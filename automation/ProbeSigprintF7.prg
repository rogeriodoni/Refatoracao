*==============================================================================
* ProbeSigprintF7.prg - Instancia FormSIGPRINT headless (Fase 7 / task631) e
* exercita os 4 eventos CRUD acrescentados nesta fase.
*
* NAO chama ConfigurarAmbiente() - ela nao retorna nesta maquina; carrega a mao
* so as dependencias do form (licao do probe de instanciacao).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprint_f7.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_cSaida, loc_oPg2
loc_cSaida = "C:\4c\automation\probe_sigprint_f7_result.txt"
STRTOFILE("INICIO", loc_cSaida)
loc_cRes = ""

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.
    STRTOFILE(CHR(13)+CHR(10)+"config OK", loc_cSaida, 1)

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
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRINTBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormSIGPRINT.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cSaida, 1)

    loc_oForm = CREATEOBJECT("FormSIGPRINT")
    STRTOFILE(CHR(13)+CHR(10)+"createobject retornou " + VARTYPE(loc_oForm), loc_cSaida, 1)

    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = CHR(13) + CHR(10) + "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ELSE
        loc_oPg2 = loc_oForm.pgf_4c_Paginas.Page2

        *-- 1) Os 4 eventos existem e sao PUBLIC? (atributo 2 = PROTECTED)
        loc_cRes = CHR(13) + CHR(10) + "=== ESCOPO (existe / eh PROTECTED)"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "BtnIncluirClick    ex=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnIncluirClick", 5)) + " prot=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnIncluirClick", 2))
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "BtnAlterarClick    ex=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnAlterarClick", 5)) + " prot=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnAlterarClick", 2))
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "BtnVisualizarClick ex=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnVisualizarClick", 5)) + " prot=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnVisualizarClick", 2))
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "BtnExcluirClick    ex=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnExcluirClick", 5)) + " prot=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnExcluirClick", 2))
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "AjustarBotoesPorModo ex=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 5)) + " prot=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 2))
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "cursor_4c_Dados usado=" + ;
            TRANSFORM(USED("cursor_4c_Dados"))

        *-- 2) INCLUIR: modo, ficha limpa, Codigo digitavel, Tipo = 1, Confirmar ON
        loc_oForm.BtnIncluirClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== POS BtnIncluirClick"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "modo=" + loc_oForm.this_cModoAtual + ;
            " page=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " cod.Enabled=" + TRANSFORM(loc_oPg2.txt_4c_Codigo.Enabled) + ;
            " cod.Value=[" + loc_oPg2.txt_4c_Codigo.Value + "]" + ;
            " descrs.Enabled=" + TRANSFORM(loc_oPg2.txt_4c_Descrs.Enabled) + ;
            " mensas.Enabled=" + TRANSFORM(loc_oPg2.obj_4c_GetMensas.Enabled) + ;
            " tipo=" + TRANSFORM(loc_oPg2.obj_4c_OptTipo.Value) + ;
            " confirmar=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled) + ;
            " cancelar=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled)

        *-- 3) Volta para a Lista pelo funil: modo normalizado + Confirmar OFF
        loc_oForm.AlternarPagina(1)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== POS AlternarPagina(1)"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "modo=" + loc_oForm.this_cModoAtual + ;
            " page=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " confirmar=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled)

        *-- 4) Guarda de "nenhuma linha selecionada": cursor vazio => os 3
        *-- eventos tem de avisar e NAO trocar de pagina
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            ZAP
        ENDIF
        loc_oForm.BtnAlterarClick()
        loc_oForm.BtnVisualizarClick()
        loc_oForm.BtnExcluirClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== POS eventos com cursor VAZIO"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "modo=" + loc_oForm.this_cModoAtual + ;
            " page=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " (deve continuar LISTA / 1)"

        loc_oForm.Release()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "RELEASE OK"
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
        " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cRes, loc_cSaida, 1)

IF FILE("C:\4c\automation\vfp_error_sigprint_f7.txt")
    STRTOFILE(CHR(13) + CHR(10) + "DIALOGOS: " + ;
        FILETOSTR("C:\4c\automation\vfp_error_sigprint_f7.txt"), loc_cSaida, 1)
ENDIF
QUIT
