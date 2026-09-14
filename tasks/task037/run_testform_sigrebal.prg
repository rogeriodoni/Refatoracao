SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

g_cLog = ""
g_cLogFile = "C:\4c\tasks\task037\testform_result.txt"
g_lSucesso = .T.

g_cLog = g_cLog + "=== TESTE Formsigrebal ===" + CHR(13)
g_cLog = g_cLog + "Inicio: " + TTOC(DATETIME()) + CHR(13)

*-- Carregar dependencias
TRY
    CD "C:\4c\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    g_cLog = g_cLog + "OK - config carregado" + CHR(13)
CATCH TO loc_oErr
    g_cLog = g_cLog + "ERRO config: " + loc_oErr.Message + CHR(13)
    g_lSucesso = .F.
ENDTRY

*-- Modo UI: bypass conexao SQL
PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .T.

*-- gnConnHandle = -1 simula sem conexao (Init checa gb_4c_ValidandoUI primeiro)
PUBLIC gnConnHandle
gnConnHandle = -1

*-- Criar form
LOCAL loc_oForm
TRY
    loc_oForm = CREATEOBJECT("Formsigrebal")
    IF VARTYPE(loc_oForm) = "O" AND !ISNULL(loc_oForm)
        g_cLog = g_cLog + "OK - Formsigrebal criado" + CHR(13)
        g_cLog = g_cLog + "Width=" + TRANSFORM(loc_oForm.Width) + " Height=" + TRANSFORM(loc_oForm.Height) + CHR(13)
    ELSE
        g_cLog = g_cLog + "ERRO - VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)
        g_lSucesso = .F.
    ENDIF
CATCH TO loc_oErr
    g_cLog = g_cLog + "ERRO CREATEOBJECT: " + loc_oErr.Message + " L" + TRANSFORM(loc_oErr.LineNo) + CHR(13)
    g_lSucesso = .F.
ENDTRY

*-- Verificar controles se criou
IF g_lSucesso AND VARTYPE(loc_oForm) = "O"
    TRY
        g_cLog = g_cLog + "Cabecalho: " + IIF(PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5), "OK", "FALTA") + CHR(13)
        g_cLog = g_cLog + "Botoes:    " + IIF(PEMSTATUS(loc_oForm, "cmg_4c_Botoes", 5), "OK (Btn=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.ButtonCount) + ")", "FALTA") + CHR(13)
        g_cLog = g_cLog + "DtFinal:   " + IIF(PEMSTATUS(loc_oForm, "txt_4c__dt_final", 5), "OK", "FALTA") + CHR(13)
        g_cLog = g_cLog + "Moeda:     " + IIF(PEMSTATUS(loc_oForm, "txt_4c__cd_moeda", 5), "OK", "FALTA") + CHR(13)
        g_cLog = g_cLog + "Empresa:   " + IIF(PEMSTATUS(loc_oForm, "txt_4c__cd_empresa", 5), "OK", "FALTA") + CHR(13)
        g_cLog = g_cLog + "OptGcont:  " + IIF(PEMSTATUS(loc_oForm, "obj_4c_OptGcontaz", 5), "OK", "FALTA") + CHR(13)
        g_cLog = g_cLog + "OptTpRel:  " + IIF(PEMSTATUS(loc_oForm, "obj_4c_OptGtprel", 5), "OK", "FALTA") + CHR(13)
        g_cLog = g_cLog + "OptCotac:  " + IIF(PEMSTATUS(loc_oForm, "obj_4c_OptCotacao", 5), "OK", "FALTA") + CHR(13)
        g_cLog = g_cLog + "OptAnCst:  " + IIF(PEMSTATUS(loc_oForm, "obj_4c_OpAnCst", 5), "OK", "FALTA") + CHR(13)
        g_cLog = g_cLog + "OptConc:   " + IIF(PEMSTATUS(loc_oForm, "obj_4c_Optconcilias", 5), "OK", "FALTA") + CHR(13)
    CATCH TO loc_oErr
        g_cLog = g_cLog + "ERRO verificar controles: " + loc_oErr.Message + CHR(13)
    ENDTRY

    *-- Testar BtnSair
    TRY
        loc_oForm.BtnSairClick()
        g_cLog = g_cLog + "OK - BtnSairClick" + CHR(13)
    CATCH TO loc_oErr
        g_cLog = g_cLog + "ERRO BtnSairClick: " + loc_oErr.Message + CHR(13)
        TRY
            loc_oForm.Release()
        CATCH TO loc_oErr2
            && Ignora
        ENDTRY
    ENDTRY
ENDIF

g_cLog = g_cLog + "=== " + IIF(g_lSucesso, "SUCESSO", "FALHOU") + " ===" + CHR(13)
g_cLog = g_cLog + "Fim: " + TTOC(DATETIME()) + CHR(13)

STRTOFILE(g_cLog, g_cLogFile)
QUIT
