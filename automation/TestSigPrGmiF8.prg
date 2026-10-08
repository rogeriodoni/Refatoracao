*==============================================================================
* TestSigPrGmiF8.prg - Verificacao headless do FormSigPrGmi (task619, Fase 8)
*
* Prova o que "compila limpo" NAO prova (Fase 8 = eventos auxiliares +
* consolidacao final):
*   1. o Init inteiro roda (CREATEOBJECT devolve OBJETO, nao .F.) - Init de
*      form falha em CADEIA e cada defeito esconde o proximo;
*   2. todo metodo alvo de BINDEVENT existe e eh ALCANCAVEL de fora da
*      classe - PEMSTATUS(...,5) devolve .T. para PROTECTED tambem
*      (CLAUDE.md #3), por isso o escopo eh medido CHAMANDO de fora;
*   3. os BINDEVENT dos 2 botoes e dos 9 TextBox com evento estao
*      REGISTRADOS no objeto vivo - AEVENTS recebe 2 ARGUMENTOS e o nome do
*      evento vem na COLUNA 3 (memoria feedback_aevents_dois_args_coluna_3);
*   4. FormParaBO sobe as 10 properties para o BO (nenhuma perdida) e
*      BOParaForm/LimparCampos devolvem a tela ao estado inicial do Init
*      legado (Negativo="N", Datai = DATE() - 7);
*   5. ValidarDados do BO recusa criterio vazio com a mensagem do legado e
*      aponta this_cCampoFoco para um controle que EXISTE no form - sem isso
*      FocarCampoValidacao eh codigo morto.
*
* NAO se chamam Validar*/AbrirLookup* com valor: AbrirLookupCanonico abre
* form MODAL e Show() TRAVA a execucao headless (memoria
* feedback_show_modal_dentro_de_try_fecha_a_tela). Esses metodos nao sao
* alvo de BINDEVENT (sao chamados com THIS. de dentro), logo o escopo deles
* nao eh o risco - apenas a existencia, conferida por PEMSTATUS.
*
* SET SAFETY/RESOURCE OFF + gb_4c_ModoTeste COM gc_4c_ArquivoErroTeste:
* script de pipeline nao supervisionado; a flag sozinha nao suprime dialogo
* (CLAUDE.md regra #6 / memoria feedback_modoteste_exige_arquivoerroteste).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_sigprgmi_f8_dialogos.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRel, loc_oForm, loc_oErro, loc_nI, loc_nJ, loc_nFalhas, loc_nLinhas
LOCAL loc_cNome, loc_cEsp, loc_cObt, loc_cTabela, loc_nEv, loc_cEventos, loc_lOk
LOCAL ARRAY loc_aLinha[1]
LOCAL ARRAY loc_aEv[1, 5]

loc_cRel    = ""
loc_nFalhas = 0

*-- "DO config.prg" so DEFINE as globais gc_4c_Caminho* e retorna. NAO se
*-- chama ConfigurarAmbiente(): medido nesta maquina, ela NAO RETORNA e o
*-- probe morre por timeout sem diagnostico (memoria
*-- feedback_configurarambiente_bloqueia_probe_de_form). SET PATH com UMA
*-- string concatenada - com varias expressoes o VFP9 honra SO a primeira
*-- (CLAUDE.md regra #26). gb_4c_ValidandoUI vai DEPOIS do config, que
*-- reseta a flag.
CD C:\4c\projeto\app\start
TRY
    DO config.prg

    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
                 gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
                 gc_4c_CaminhoIcones)

    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrGmiBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrGmi.prg") ADDITIVE

    gb_4c_ValidandoUI = .T.
    loc_cRel = loc_cRel + "CONFIG=OK" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "CONFIG=ERRO: " + loc_oErro.Message + CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

*------------------------------------------------------------------------------
* 1) O form INSTANCIA?
*------------------------------------------------------------------------------
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigPrGmi")
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "CREATEOBJECT=EXCECAO: " + loc_oErro.Message + ;
               " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
               " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

loc_cRel = loc_cRel + "VARTYPE(form)=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) != "O"
    loc_cRel = loc_cRel + "FALHA: form nao instanciou - Init devolveu .F." + ;
               CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ELSE
    loc_cRel = loc_cRel + "ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + ;
               " BO=" + VARTYPE(loc_oForm.this_oBusinessObject) + CHR(13) + CHR(10)

    *--------------------------------------------------------------------------
    * 2) Existencia de TODO metodo da Fase 8 (inclusive os PROTECTED, que
    *    nao sao chamados de fora mas tem de existir - metodo chamado e
    *    nunca gerado estoura "Property X is not found" em runtime)
    *--------------------------------------------------------------------------
    TEXT TO loc_cTabela NOSHOW
BtnProcessaClick
BtnEncerrarClick
FormParaBO
BOParaForm
LimparCampos
FocarCampoValidacao
TornarControlesVisiveis
AjustarOrdemTabulacao
CdEmpresaKeyPress
DsEmpresaKeyPress
CdGrEstoqueKeyPress
DsGrEstoqueKeyPress
CdEstoqueKeyPress
DsEstoqueKeyPress
LinhaKeyPress
DLinhaKeyPress
NegativoKeyPress
ValidarEmpresa
ValidarGrEstoque
ValidarEstoque
ValidarLinha
ValidarDLinha
AbrirLookupEmpresa
AbrirLookupLinha
    ENDTEXT

    loc_nLinhas = ALINES(loc_aLinha, loc_cTabela)
    FOR loc_nI = 1 TO loc_nLinhas
        loc_cNome = ALLTRIM(loc_aLinha[loc_nI])
        IF EMPTY(loc_cNome)
            LOOP
        ENDIF

        IF PEMSTATUS(loc_oForm, loc_cNome, 5)
            loc_cRel = loc_cRel + "ok    metodo existe: " + loc_cNome + CHR(13) + CHR(10)
        ELSE
            loc_cRel = loc_cRel + "FALHA metodo AUSENTE: " + loc_cNome + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
    ENDFOR

    *--------------------------------------------------------------------------
    * 2b) Escopo dos 9 handlers de KeyPress: chamados de FORA com tecla
    *     neutra (0) - nenhum branch do handler dispara, mas PROTECTED
    *     estouraria "Property X is not found" aqui
    *--------------------------------------------------------------------------
    TEXT TO loc_cTabela NOSHOW
CdEmpresaKeyPress
DsEmpresaKeyPress
CdGrEstoqueKeyPress
DsGrEstoqueKeyPress
CdEstoqueKeyPress
DsEstoqueKeyPress
LinhaKeyPress
DLinhaKeyPress
NegativoKeyPress
    ENDTEXT

    loc_nLinhas = ALINES(loc_aLinha, loc_cTabela)
    FOR loc_nI = 1 TO loc_nLinhas
        loc_cNome = ALLTRIM(loc_aLinha[loc_nI])
        IF EMPTY(loc_cNome)
            LOOP
        ENDIF

        loc_lOk = .T.
        TRY
            loc_oForm.&loc_cNome.(0, 0)
        CATCH TO loc_oErro
            loc_lOk = .F.
            loc_cRel = loc_cRel + "FALHA escopo/chamada " + loc_cNome + ": " + ;
                       loc_oErro.Message + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDTRY

        IF loc_lOk
            loc_cRel = loc_cRel + "ok    PUBLIC alcancavel de fora: " + ;
                       loc_cNome + CHR(13) + CHR(10)
        ENDIF
    ENDFOR

    *--------------------------------------------------------------------------
    * 3) BINDEVENT registrado no objeto VIVO (AEVENTS: 2 args, evento na
    *    coluna 3)
    *--------------------------------------------------------------------------
    TEXT TO loc_cTabela NOSHOW
cmd_4c_Processa|CLICK
cmd_4c_Encerrar|CLICK
txt_4c__cd_empresa|KEYPRESS
txt_4c__ds_empresa|KEYPRESS
txt_4c__Cd_GrEstoque|KEYPRESS
txt_4c__Ds_GrEstoque|KEYPRESS
txt_4c__cd_estoque|KEYPRESS
txt_4c__ds_estoque|KEYPRESS
txt_4c_Linha|KEYPRESS
txt_4c_DLinha|KEYPRESS
txt_4c_Negativo|KEYPRESS
    ENDTEXT

    loc_nLinhas = ALINES(loc_aLinha, loc_cTabela)
    FOR loc_nI = 1 TO loc_nLinhas
        loc_cNome = ALLTRIM(GETWORDNUM(loc_aLinha[loc_nI], 1, "|"))
        loc_cEsp  = ALLTRIM(GETWORDNUM(loc_aLinha[loc_nI], 2, "|"))
        IF EMPTY(loc_cNome)
            LOOP
        ENDIF

        loc_cEventos = ""
        loc_nEv = AEVENTS(loc_aEv, EVALUATE("loc_oForm." + loc_cNome))
        IF loc_nEv > 0
            FOR loc_nJ = 1 TO loc_nEv
                loc_cEventos = loc_cEventos + "," + UPPER(ALLTRIM(loc_aEv[loc_nJ, 3]))
            ENDFOR
        ENDIF

        IF loc_cEsp $ loc_cEventos
            loc_cRel = loc_cRel + "ok    BINDEVENT " + loc_cNome + "." + ;
                       loc_cEsp + CHR(13) + CHR(10)
        ELSE
            loc_cRel = loc_cRel + "FALHA BINDEVENT AUSENTE " + loc_cNome + "." + ;
                       loc_cEsp + " (eventos=" + loc_cEventos + ")" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
    ENDFOR

    *--------------------------------------------------------------------------
    * 3b) Estado inicial da tela = default do Init legado
    *--------------------------------------------------------------------------
    IF loc_oForm.txt_4c_Datai.Value == DATE() - 7
        loc_cRel = loc_cRel + "ok    BOParaForm Datai = DATE()-7" + CHR(13) + CHR(10)
    ELSE
        loc_cRel = loc_cRel + "FALHA BOParaForm Datai obtido=[" + ;
                   TRANSFORM(loc_oForm.txt_4c_Datai.Value) + "]" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    IF ALLTRIM(loc_oForm.txt_4c_Negativo.Value) == "N"
        loc_cRel = loc_cRel + "ok    BOParaForm Negativo = N" + CHR(13) + CHR(10)
    ELSE
        loc_cRel = loc_cRel + "FALHA BOParaForm Negativo obtido=[" + ;
                   TRANSFORM(loc_oForm.txt_4c_Negativo.Value) + "]" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *--------------------------------------------------------------------------
    * 4) FormParaBO: a tela inteira sobe para o BO (10 properties). FormParaBO
    *    eh PROTECTED - exercitado pelo caminho REAL (BtnProcessaClick, que
    *    faz NovoRegistro + FormParaBO + Salvar). Sem conexao SQL a validacao
    *    para na checagem da Linha, mas as 10 properties ja foram escritas.
    *--------------------------------------------------------------------------
    loc_oForm.txt_4c__cd_empresa.Value   = "001"
    loc_oForm.txt_4c__ds_empresa.Value   = "EMPRESA TESTE"
    loc_oForm.txt_4c__Cd_GrEstoque.Value = "GRP01"
    loc_oForm.txt_4c__Ds_GrEstoque.Value = "GRUPO TESTE"
    loc_oForm.txt_4c__cd_estoque.Value   = "CTA01"
    loc_oForm.txt_4c__ds_estoque.Value   = "CONTA TESTE"
    loc_oForm.txt_4c_Linha.Value         = "LIN01"
    loc_oForm.txt_4c_DLinha.Value        = "LINHA TESTE"
    loc_oForm.txt_4c_Negativo.Value      = "S"
    loc_oForm.txt_4c_Datai.Value         = DATE() - 3

    TRY
        loc_oForm.BtnProcessaClick()
        loc_cRel = loc_cRel + "ok    BtnProcessaClick executou sem excecao" + ;
                   CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cRel = loc_cRel + "FALHA BtnProcessaClick: " + loc_oErro.Message + ;
                   " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                   " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY

    TEXT TO loc_cTabela NOSHOW
this_cCdEmpresa|001
this_cDsEmpresa|EMPRESA TESTE
this_cCdGrEstoque|GRP01
this_cDsGrEstoque|GRUPO TESTE
this_cCdEstoque|CTA01
this_cDsEstoque|CONTA TESTE
this_cLinha|LIN01
this_cDLinha|LINHA TESTE
this_cNegativo|S
    ENDTEXT

    loc_nLinhas = ALINES(loc_aLinha, loc_cTabela)
    FOR loc_nI = 1 TO loc_nLinhas
        loc_cNome = ALLTRIM(GETWORDNUM(loc_aLinha[loc_nI], 1, "|"))
        loc_cEsp  = ALLTRIM(GETWORDNUM(loc_aLinha[loc_nI], 2, "|"))
        IF EMPTY(loc_cNome)
            LOOP
        ENDIF

        IF !PEMSTATUS(loc_oForm.this_oBusinessObject, loc_cNome, 5)
            loc_cRel = loc_cRel + "FALHA property AUSENTE no BO: " + loc_cNome + ;
                       CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
            LOOP
        ENDIF

        loc_cObt = ALLTRIM(TRANSFORM(EVALUATE("loc_oForm.this_oBusinessObject." + loc_cNome)))

        IF loc_cObt == loc_cEsp
            loc_cRel = loc_cRel + "ok    FormParaBO " + loc_cNome + " = " + ;
                       loc_cObt + CHR(13) + CHR(10)
        ELSE
            loc_cRel = loc_cRel + "FALHA FormParaBO " + loc_cNome + " esperado=[" + ;
                       loc_cEsp + "] obtido=[" + loc_cObt + "]" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
    ENDFOR

    IF loc_oForm.this_oBusinessObject.this_dDatai == DATE() - 3
        loc_cRel = loc_cRel + "ok    FormParaBO this_dDatai = DATE()-3" + CHR(13) + CHR(10)
    ELSE
        loc_cRel = loc_cRel + "FALHA FormParaBO this_dDatai obtido=[" + ;
                   TRANSFORM(loc_oForm.this_oBusinessObject.this_dDatai) + "]" + ;
                   CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *--------------------------------------------------------------------------
    * 5) ValidarDados recusa criterio vazio com a mensagem do legado, e
    *    this_cCampoFoco aponta para um controle que EXISTE no form (senao
    *    FocarCampoValidacao eh codigo morto)
    *--------------------------------------------------------------------------
    loc_oForm.this_oBusinessObject.NovoRegistro()
    loc_oForm.this_oBusinessObject.this_cCdEmpresa = ""

    TRY
        loc_lOk = loc_oForm.this_oBusinessObject.Salvar()

        loc_cRel = loc_cRel + "Salvar(Empresa vazia)=" + TRANSFORM(loc_lOk) + ;
                   " msg=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + ;
                   "] foco=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cCampoFoco) + ;
                   "]" + CHR(13) + CHR(10)

        IF loc_lOk
            loc_cRel = loc_cRel + "FALHA: Salvar aceitou Empresa vazia" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ELSE
            loc_cRel = loc_cRel + "ok    Salvar recusou Empresa vazia" + CHR(13) + CHR(10)
        ENDIF

        loc_cNome = ALLTRIM(loc_oForm.this_oBusinessObject.this_cCampoFoco)
        IF EMPTY(loc_cNome) OR !PEMSTATUS(loc_oForm, loc_cNome, 5)
            loc_cRel = loc_cRel + ;
                       "FALHA this_cCampoFoco nao aponta controle do form: [" + ;
                       loc_cNome + "]" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ELSE
            loc_cRel = loc_cRel + "ok    this_cCampoFoco existe no form: " + ;
                       loc_cNome + CHR(13) + CHR(10)
        ENDIF
    CATCH TO loc_oErro
        loc_cRel = loc_cRel + "FALHA Salvar/ValidarDados: " + loc_oErro.Message + ;
                   " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                   " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY

    loc_cRel = loc_cRel + "TabIndex: Processa=" + ;
               TRANSFORM(loc_oForm.cmd_4c_Processa.TabIndex) + " Encerrar=" + ;
               TRANSFORM(loc_oForm.cmd_4c_Encerrar.TabIndex) + " cd_empresa=" + ;
               TRANSFORM(loc_oForm.txt_4c__cd_empresa.TabIndex) + " Datai=" + ;
               TRANSFORM(loc_oForm.txt_4c_Datai.TabIndex) + CHR(13) + CHR(10)

    *-- BtnEncerrarClick por ULTIMO: ele faz Release() e derruba o form
    TRY
        loc_oForm.BtnEncerrarClick()
        loc_cRel = loc_cRel + "ok    BtnEncerrarClick (Release) alcancavel de fora" + ;
                   CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cRel = loc_cRel + "FALHA BtnEncerrarClick: " + loc_oErro.Message + ;
                   CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY

    loc_oForm = .NULL.
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRel = loc_cRel + "DIALOGOS SUPRIMIDOS (esperados: validacao sem conexao SQL):" + ;
               CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ENDIF

loc_cRel = loc_cRel + "==============================" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + IIF(loc_nFalhas = 0, "RESULTADO=SUCESSO", "RESULTADO=FALHA") + ;
           CHR(13) + CHR(10)

STRTOFILE(loc_cRel, "C:\4c\automation\test_sigprgmi_f8.txt")
QUIT
