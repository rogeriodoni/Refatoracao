*-- Fase 8 da task638 (SigPrMlu): compila o par BO + Form e INSTANCIA o form em
*-- modo teste, para provar que o Init passa e que os metodos novos da fase
*-- (FormParaBO / BOParaForm / LimparCampos / AjustarBotoesPorModo) existem, tem
*-- o ESCOPO certo e respondem. Instanciar eh a unica prova de que a tela abre -
*-- o Init de form grande falha em CADEIA e cada defeito esconde o proximo.
*--
*-- Notas de harness, todas medidas antes (ver CLAUDE.md e memoria do projeto):
*--   . SET SAFETY/RESOURCE OFF: pipeline roda sem supervisao (regra #6).
*--   . COMPILE pode NAO reescrever um .fxp existente - apagar antes.
*--   . COMPILE nao dispara excecao: o veredito eh o .ERR ao lado do fonte.
*--   . ConfigurarAmbiente() NAO pode ser chamado - nesta maquina ele nao
*--     retorna. Em troca, repor a mao os SET PATH/SET PROCEDURE que o form usa;
*--     sem esse bloco o CREATEOBJECT estoura "Class definition ... is not
*--     found" e o probe mediria a falta de setup, nao o form.
*--   . gb_4c_ValidandoUI SO depois do DO config.prg, que o zera sempre.
*--   . gc_4c_ArquivoErroTeste eh obrigatorio: sem ele MsgErro volta a abrir
*--     MESSAGEBOX e trava o VFP headless.
*--   . apagar tambem o .FXP DESTE arquivo a cada edicao, senao roda a versao
*--     anterior do proprio probe.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm, loc_cFxpBO, loc_cFxpForm

loc_cBO      = "C:\4c\projeto\app\classes\SigPrMluBO.prg"
loc_cForm    = "C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg"
loc_cFxpBO   = "C:\4c\projeto\app\classes\sigprmlubo.FXP"
loc_cFxpForm = "C:\4c\projeto\app\forms\operacionais\formsigprmlu.FXP"

IF FILE(loc_cFxpBO)
    DELETE FILE (loc_cFxpBO)
ENDIF
IF FILE(loc_cFxpForm)
    DELETE FILE (loc_cFxpForm)
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrMluBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrMluBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\SigPrMluBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigPrMluBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE(loc_cFxpBO),   "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE(loc_cFxpForm), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE(loc_cFxpBO) AND FILE(loc_cFxpForm)
    loc_cSaida = loc_cSaida + "COMPILE_OK" + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_mlu_f8.txt")

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_mlu_f8_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

CD C:\4c\projeto\app\start
DO config.prg

gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigPrMluBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrMlu.prg") ADDITIVE

LOCAL loc_oForm, loc_oErro, loc_cProbe
loc_cProbe = ""

TRY
    loc_oForm = CREATEOBJECT("FormSigPrMlu")
    loc_cProbe = loc_cProbe + "VARTYPE_FORM=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

    IF VARTYPE(loc_oForm) = "O"
        loc_cProbe = loc_cProbe + "PEM_FORMPARABO="   + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_BOPARAFORM="   + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_LIMPARCAMPOS=" + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 5)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_AJUSTAR="      + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 5)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_BTNPROCESSAR=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClick", 5)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_BTNENCERRAR="  + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5)) + CHR(13) + CHR(10)

        loc_cProbe = loc_cProbe + "PROT_FORMPARABO="    + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PROT_BOPARAFORM="    + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PROT_LIMPARCAMPOS="  + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PROT_AJUSTAR="       + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 2)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PROT_CARREGARLISTA=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PROT_VALIDARPROC="   + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarProcessamento", 2)) + CHR(13) + CHR(10)

        loc_cProbe = loc_cProbe + "MODO_INICIAL=[" + ALLTRIM(loc_oForm.this_cModoAtual) + "]" + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PROC_ENABLED_LISTA=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + CHR(13) + CHR(10)

        loc_oForm.this_cModoAtual = "PROCESSANDO"
        loc_oForm.AjustarBotoesPorModo()
        loc_cProbe = loc_cProbe + "PROC_ENABLED_PROCESSANDO=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + CHR(13) + CHR(10)

        loc_oForm.this_cModoAtual = "LISTA"
        loc_oForm.AjustarBotoesPorModo()
        loc_cProbe = loc_cProbe + "PROC_ENABLED_VOLTA=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + CHR(13) + CHR(10)

        loc_oForm.cnt_4c_Nova.txt_4c_Nova.Value = "UNIF TESTE"
        loc_cProbe = loc_cProbe + "VALIDAR_SEM_SELECAO=" + ;
            TRANSFORM(loc_oForm.ValidarProcessamento()) + CHR(13) + CHR(10)

        SET DATASESSION TO loc_oForm.DataSessionId
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados (SelImp N(1,0), Codigos C(10), Descs C(30), ;
            UsuIns C(10), DatIns T, NRegis N(8,0))
        INSERT INTO cursor_4c_Dados (SelImp, Codigos, NRegis) VALUES (1, "MALA000001", 10)
        INSERT INTO cursor_4c_Dados (SelImp, Codigos, NRegis) VALUES (1, "MALA000002", 20)
        INSERT INTO cursor_4c_Dados (SelImp, Codigos, NRegis) VALUES (0, "MALA000003", 30)
        GO TOP
        SET DATASESSION TO 1

        loc_cProbe = loc_cProbe + "VALIDAR_COM_2_MALAS=" + ;
            TRANSFORM(loc_oForm.ValidarProcessamento()) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "BO_NOME=["    + ALLTRIM(NVL(loc_oForm.this_oBusinessObject.this_cNomeUnificacao, "")) + "]" + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "BO_CODIGOS=[" + ALLTRIM(NVL(loc_oForm.this_oBusinessObject.this_cCodigosSelecionados, "")) + "]" + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "BO_QTD="      + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalMalasSelecionadas) + CHR(13) + CHR(10)

        SET DATASESSION TO loc_oForm.DataSessionId
        loc_cProbe = loc_cProbe + "RECNO_APOS_FORMPARABO=" + TRANSFORM(RECNO("cursor_4c_Dados")) + CHR(13) + CHR(10)
        SET DATASESSION TO 1

        loc_oForm.cnt_4c_Nova.txt_4c_Nova.Value = ""
        loc_cProbe = loc_cProbe + "VALIDAR_SEM_NOME=" + ;
            TRANSFORM(loc_oForm.ValidarProcessamento()) + CHR(13) + CHR(10)

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cProbe = loc_cProbe + "EXCECAO=[" + loc_oErro.Message + "] LINHA=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF FILE("C:\4c\automation\probe_mlu_f8_erros.txt")
    loc_cProbe = loc_cProbe + "MSG_CAPTURADAS=[" + ;
        ALLTRIM(FILETOSTR("C:\4c\automation\probe_mlu_f8_erros.txt")) + "]" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida + loc_cProbe, "C:\4c\automation\compile_check_mlu_f8.txt")
QUIT
