*==============================================================================
* ProbeAut644F8.prg - Instancia FormSigOpAut headless (Fase 8 / task644) e
* exerce o que a fase acrescentou, nao so a abertura da tela:
*   (1) o Init inteiro conclui;
*   (2) escopo: BtnImprimirClick/BtnSairClick/BtnGradeClick/CarregarDados/
*       VincularGrade/ValidarMarcacaoLinha tem de ser PUBLIC - BINDEVENT e o
*       harness os alcancam de FORA da classe (regra CLAUDE.md #3/#51).
*       FormParaBO/BOParaForm sao a EXCECAO: FormBase os declara PROTECTED e
*       o VFP9 nao deixa a subclasse alargar o escopo, entao aqui eles
*       DEVEM aparecer como protegidos - e por isso este probe os exerce por
*       uma SUBCLASSE (ProbeFormSigOpAut, no fim do arquivo), nunca pelo
*       script solto, que receberia "Property FORMPARABO is not found";
*   (3) ida-e-volta form <-> BO do unico campo editavel (TxtObs <->
*       this_cObservacao), que antes da Fase 8 era property MORTA no BO;
*   (4) FormParaBO carrega tambem a LINHA corrente da grade nas properties
*       this_*Linha* (equivale ao csPgto.marca/.Autenticas que o legado le
*       dentro do Scan do botao Imprimir);
*   (5) FLUXO REAL do botao Imprimir: com 2 linhas marcadas, BtnImprimirClick
*       tem de deixar as duas com Printed=.T. e Marca=.F. (legado:
*       "Replace csPgto.marca with .f., csPgto.Printed with .t.") - eh o
*       equivalente a "testar gravando", nao so abrir a tela;
*   (6) o guard do Encerrar: com linha NAO autenticada, BtnSairClick nao pode
*       liberar o form (legado: MessageBox "Autenticacao Obrigatoria" +
*       Return antes do ThisForm.Release);
*   (7) marcacao de linha: ValidarMarcacaoLinha reproduz o Check1.Click
*       legado - linha com Printed=.F. volta sempre para marcada.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
* Nao depende de SQL Server: roda no ramo de ModoTeste do CarregarDados.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_aut644_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oBO, loc_nOk, loc_nPrinted, loc_nMarcadas
loc_cOut = "C:\4c\automation\probe_aut644_f8_result.txt"
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
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpAutBO.prg")   ADDITIVE
    *-- FisBO: em producao vem do ADIR "*BO.prg" de ConfigurarAmbiente(), que
    *   este probe NAO chama (nao retorna nesta maquina). Sem carrega-lo aqui,
    *   ObterModeloImpressoraFiscal cai no CATCH com "Class definition FISBO
    *   is not found" - artefato do harness, nao defeito do form.
    SET PROCEDURE TO (gcCaminhoClasses + "FisBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpAut.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) Init completo. Instancia a SUBCLASSE de probe: ela nao muda nada
    *   do form (so acrescenta dois metodos publicos que delegam por THIS.
    *   aos hooks protegidos), e eh a unica forma de exercitar FormParaBO/
    *   BOParaForm de fora - subclasse alcanca membro PROTECTED, script nao.
    loc_oForm = CREATEOBJECT("ProbeFormSigOpAut")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_oBO = loc_oForm.this_oBusinessObject

        *-- (2) Escopo: PEMSTATUS(...,2) = .T. significa PROTECTED (= defeito
        *   para os metodos chamados de fora)
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO(prot) FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2)) + ;
                  " BOParaForm=" + TRANSFORM(PEMSTATUS(loc_oForm,"BOParaForm",2)) + ;
                  " BtnImprimirClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnImprimirClick",2)) + ;
                  " BtnSairClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnSairClick",2)) + ;
                  " BtnGradeClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnGradeClick",2)) + ;
                  " CarregarDados=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarDados",2)) + ;
                  " VincularGrade=" + TRANSFORM(PEMSTATUS(loc_oForm,"VincularGrade",2)) + ;
                  " ValidarMarcacaoLinha=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarMarcacaoLinha",2)), loc_cOut, 1)

        *-- Cursor com 2 linhas marcadas e nenhuma autenticada; revincula a
        *   grade como todo caminho que popula o cursor tem de fazer
        IF USED("cursor_4c_Pagamentos")
            USE IN cursor_4c_Pagamentos
        ENDIF
        CREATE CURSOR cursor_4c_Pagamentos (Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))
        INSERT INTO cursor_4c_Pagamentos (Marca, Obs, Fpags, Printed, Autenticas) ;
            VALUES (.T., "# 001; TESTE", "DINHEIRO", .F., 1)
        INSERT INTO cursor_4c_Pagamentos (Marca, Obs, Fpags, Printed, Autenticas) ;
            VALUES (.T., "# 002", "CHEQUE", .F., 3)
        loc_oForm.VincularGrade()
        SELECT cursor_4c_Pagamentos
        GO TOP

        *-- (3) Ida-e-volta do campo editavel
        loc_oForm.txt_4c_TxtObs.Value = "OBS DIGITADA PELO OPERADOR"
        STRTOFILE(CHR(13)+CHR(10)+"FormParaBO retorno=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + ;
                  " BO.this_cObservacao=[" + ALLTRIM(loc_oBO.this_cObservacao) + "]", loc_cOut, 1)

        loc_oBO.this_cObservacao = "VINDO DO BO"
        STRTOFILE(CHR(13)+CHR(10)+"BOParaForm retorno=" + TRANSFORM(loc_oForm.ProbeBOParaForm()) + ;
                  " txt_4c_TxtObs.Value=[" + ALLTRIM(loc_oForm.txt_4c_TxtObs.Value) + "]", loc_cOut, 1)

        *-- (4) Linha corrente carregada no BO por FormParaBO
        SELECT cursor_4c_Pagamentos
        GO TOP
        loc_oForm.ProbeFormParaBO()
        STRTOFILE(CHR(13)+CHR(10)+"LINHA NO BO Marca=" + TRANSFORM(loc_oBO.this_lLinhaMarca) + ;
                  " Obs=[" + ALLTRIM(loc_oBO.this_cLinhaObs) + "]" + ;
                  " Fpags=[" + ALLTRIM(loc_oBO.this_cLinhaFpags) + "]" + ;
                  " Printed=" + TRANSFORM(loc_oBO.this_lLinhaImpressa) + ;
                  " Autenticas=" + TRANSFORM(loc_oBO.this_nLinhaAutenticas) + ;
                  " RecnoPreservado=" + TRANSFORM(RECNO("cursor_4c_Pagamentos")), loc_cOut, 1)

        *-- (6) Guard do Encerrar ANTES de autenticar: nao pode liberar
        STRTOFILE(CHR(13)+CHR(10)+"PENDENTE(antes)=" + TRANSFORM(loc_oBO.ExisteLinhaNaoAutenticada()), loc_cOut, 1)
        loc_oForm.BtnSairClick()
        STRTOFILE(CHR(13)+CHR(10)+"POS-BtnSairClick(pendente) formVivo=" + ;
                  TRANSFORM(VARTYPE(loc_oForm) = "O") + ;
                  " cursorAberto=" + TRANSFORM(USED("cursor_4c_Pagamentos")), loc_cOut, 1)

        *-- (7) Marcacao de linha (Check1.Click legado)
        SELECT cursor_4c_Pagamentos
        GO TOP
        REPLACE Marca WITH .F.
        loc_oForm.ValidarMarcacaoLinha()
        STRTOFILE(CHR(13)+CHR(10)+"ValidarMarcacaoLinha(Printed=.F.) Marca=" + ;
                  TRANSFORM(cursor_4c_Pagamentos.Marca) + " (esperado .T.)", loc_cOut, 1)

        *-- (5) FLUXO REAL do botao Imprimir.
        *   Autenticas = 3 nas DUAS linhas de proposito: com Autenticas = 1 o
        *   metodo Autentica entra no ramo da impressora de CHEQUE, que exige
        *   SigSyCom via SQL (ObterConfigPortaCheque devolve .F. sem conexao)
        *   e devolve .F. - a linha NAO eh marcada, e isso esta CERTO (o
        *   legado so faz o Replace "If lOk"). Fixar o tipo aqui separa
        *   "o fluxo nao funciona" de "esta maquina nao tem a impressora".
        SELECT cursor_4c_Pagamentos
        GO TOP
        REPLACE ALL Marca WITH .T., Printed WITH .F., Autenticas WITH 3
        loc_oForm.BtnImprimirClick()

        loc_nPrinted  = 0
        loc_nMarcadas = 0
        SELECT cursor_4c_Pagamentos
        GO TOP
        SCAN
            IF cursor_4c_Pagamentos.Printed
                loc_nPrinted = loc_nPrinted + 1
            ENDIF
            IF cursor_4c_Pagamentos.Marca
                loc_nMarcadas = loc_nMarcadas + 1
            ENDIF
        ENDSCAN
        STRTOFILE(CHR(13)+CHR(10)+"POS-BtnImprimirClick Reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Pagamentos")) + ;
                  " Printed=" + TRANSFORM(loc_nPrinted) + " (esperado 2)" + ;
                  " Marcadas=" + TRANSFORM(loc_nMarcadas) + " (esperado 0)" + ;
                  " PENDENTE(depois)=" + TRANSFORM(loc_oBO.ExisteLinhaNaoAutenticada()), loc_cOut, 1)

        *-- Encerrar agora deve liberar
        loc_oForm.BtnSairClick()
        STRTOFILE(CHR(13)+CHR(10)+"POS-BtnSairClick(tudo autenticado) cursorAberto=" + ;
                  TRANSFORM(USED("cursor_4c_Pagamentos")), loc_cOut, 1)

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

*==============================================================================
* ProbeFormSigOpAut - Subclasse de teste. NAO altera o comportamento do form:
* so expoe dois metodos publicos que delegam por THIS. aos hooks PROTECTED
* herdados de FormBase (FormParaBO/BOParaForm). Subclasse alcanca membro
* protegido; script solto nao (regra CLAUDE.md #51).
*==============================================================================
DEFINE CLASS ProbeFormSigOpAut AS FormSigOpAut

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

ENDDEFINE
