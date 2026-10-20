*==============================================================================
* ProbeAtu643F8b.prg - Instancia FormSigOpAtu headless (Fase 8 / task643) e
* exercita o que a fase acrescentou:
*   (1) universo do lookup vindo de crOpera, e nao de SigCdOpe inteira;
*   (2) cancelamento deixando crOpera em EOF, que eh como o SIGCDBAL detecta
*       que o usuario nao escolheu nada;
*   (3) hooks BOParaForm/LimparCampos no Init;
*   (4) escopo dos metodos (PUBLIC x PROTECTED).
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
* Nao depende de SQL Server: o ramo exercitado eh o do cursor local.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_atu643_f8b.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oErro2
loc_cOut = "C:\4c\automation\probe_atu643_f8b_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpAtuBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpAtu.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- crOpera como o SIGCDBAL o entrega: subconjunto FILTRADO de SigCdOpe,
    *   indexado por Dopes e posicionado no topo (SIGCDBAL:5476-5484).
    CREATE CURSOR crOpera (Dopes C(20), Estoqs N(1))
    INSERT INTO crOpera (Dopes, Estoqs) VALUES ("ENTRADA", 1)
    INSERT INTO crOpera (Dopes, Estoqs) VALUES ("INVENTARIO", 1)
    INSERT INTO crOpera (Dopes, Estoqs) VALUES ("SAIDA", 0)
    INDEX ON Dopes TAG Dopes
    GO TOP

    loc_oForm = CREATEOBJECT("FormSigOpAtu")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        *-- (3) Estado inicial posto por LimparCampos/BOParaForm no Init
        STRTOFILE(CHR(13)+CHR(10)+"INIT Campo=[" + ALLTRIM(loc_oForm.txt_4c_DopEstq.Value) + "]" + ;
                  " Confirmado=" + TRANSFORM(loc_oForm.this_lConfirmado) + ;
                  " Selecionado=[" + ALLTRIM(loc_oForm.this_cDopEstqSelecionado) + "]" + ;
                  " MemoEhSentinela=" + TRANSFORM(loc_oForm.this_cUltimoDopEstqValidado == CHR(0)), loc_cOut, 1)

        *-- (4) Escopo (2 = PROTECTED). Os chamados de fora tem de ser PUBLIC.
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO BtnOkClick prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnOkClick",2)) + ;
                  " BtnCancelarClick prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnCancelarClick",2)) + ;
                  " AbrirLookupDopEstq prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AbrirLookupDopEstq",2)) + ;
                  " FormParaBO prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2)) + ;
                  " BOParaForm prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BOParaForm",2)) + ;
                  " LimparCampos prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"LimparCampos",2)) + ;
                  " CarregarUniverso prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarUniversoOperacoes",2)), loc_cOut, 1)

        *-- (1) Match EXATO sobre o universo de crOpera. Se o picker abrisse,
        *   o Show() MODAL travaria o script - terminar dentro do tempo ja eh
        *   prova de que o exato resolveu sem dialogo (regra #37).
        loc_oForm.txt_4c_DopEstq.Value = "INVENTARIO"
        loc_oForm.AbrirLookupDopEstq("INVENTARIO")
        STRTOFILE(CHR(13)+CHR(10)+"LOOKUP EXATO Campo=[" + ALLTRIM(loc_oForm.txt_4c_DopEstq.Value) + "]" + ;
                  " PickerFechado=" + TRANSFORM(NOT USED("cursor_4c_BuscaOpe")), loc_cOut, 1)

        *-- PROVA DE QUE O UNIVERSO VEIO MESMO DE crOpera, e nao de um
        *   no-op: digita em MINUSCULA. Se CarregarUniversoOperacoes tivesse
        *   falhado (ou nao casasse), o campo ficaria como o usuario digitou;
        *   o campo so pode virar MAIUSCULA se o LOCATE casou numa linha do
        *   cursor montado a partir de crOpera e reescreveu o valor canonico.
        STRTOFILE(CHR(13)+CHR(10)+"TipoGnConnHandle=" + TYPE("gnConnHandle"), loc_cOut, 1)
        loc_oForm.txt_4c_DopEstq.Value = "saida"
        loc_oForm.AbrirLookupDopEstq("saida")
        STRTOFILE(CHR(13)+CHR(10)+"CANONIZOU Campo=[" + ALLTRIM(loc_oForm.txt_4c_DopEstq.Value) + "]", loc_cOut, 1)

        *-- Codigo que NAO esta em crOpera: o picker abriria e travaria o
        *   script (Show modal). Com o universo correto ele abre VAZIO de
        *   match mas com as 3 linhas de crOpera; aqui so se prova que o
        *   campo digitado NAO eh apagado (regras #37/#50) usando o caminho
        *   de confirmacao, que nao abre dialogo.
        loc_oForm.txt_4c_DopEstq.Value = "NAOEXISTE"
        loc_oForm.PublicarOperacaoEscolhida("NAOEXISTE")
        STRTOFILE(CHR(13)+CHR(10)+"NAO APAGOU Campo=[" + ALLTRIM(loc_oForm.txt_4c_DopEstq.Value) + "]", loc_cOut, 1)

        *-- Sem crOpera aberto e sem conexao, o universo nao carrega e o
        *   lookup nao faz nada (nem abre dialogo, nem apaga o campo).
        USE IN crOpera
        loc_oForm.txt_4c_DopEstq.Value = "SAIDA"
        loc_oForm.AbrirLookupDopEstq("SAIDA")
        STRTOFILE(CHR(13)+CHR(10)+"SEM crOpera Campo=[" + ALLTRIM(loc_oForm.txt_4c_DopEstq.Value) + "]" + ;
                  " PickerFechado=" + TRANSFORM(NOT USED("cursor_4c_BuscaOpe")), loc_cOut, 1)

        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
