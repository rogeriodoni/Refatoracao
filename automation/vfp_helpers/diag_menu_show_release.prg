*-- Diagnostico: snapshots ANTES do form, APOS Show, APOS Release
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

PUBLIC gb_4c_ModoTeste
gb_4c_ModoTeste = .T.

LOCAL loc_cLog
loc_cLog = "C:\4c\automation\vfp_helpers\diag_menu_show_release.log"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

STRTOFILE("=== DIAG MENU SHOW+RELEASE " + TTOC(DATETIME()) + " ===" + CHR(13)+CHR(10), loc_cLog)

CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()

PUBLIC go_4c_Sistema, gc_4c_UsuarioLogado, gnConnHandle
gc_4c_UsuarioLogado = "TESTE"
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
STRTOFILE("[1] SQL handle = " + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), loc_cLog, 1)

*-- FASE 1: Startup completo (main.prg simulado)
SET SYSMENU TO DEFAULT
DO CriarMenuPrincipal
STRTOFILE("[2] SNAPSHOT STARTUP: CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
LOCAL loc_i
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

*-- FASE 2: Abrir form COM Show(2) modeless + snapshot
LOCAL loc_oForm
TRY
    loc_oForm = CREATEOBJECT("FormCor")
    STRTOFILE("[3] CREATEOBJECT FormCor OK, VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)+CHR(10), loc_cLog, 1)
    STRTOFILE("     Apos CREATEOBJECT: CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
CATCH TO loc_oErr
    STRTOFILE("[3] EXCEPTION create FormCor: " + loc_oErr.Message + " LN=" + TRANSFORM(loc_oErr.LineNo) + CHR(13)+CHR(10), loc_cLog, 1)
ENDTRY

*-- Show(2) para modeless (nao bloqueia)
IF VARTYPE(loc_oForm) = "O"
    TRY
        loc_oForm.Show(2)
        STRTOFILE("[4] Show(2) chamado OK" + CHR(13)+CHR(10), loc_cLog, 1)
        STRTOFILE("     Apos Show: CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
        FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
            STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
        ENDFOR
    CATCH TO loc_oErr
        STRTOFILE("[4] EXCEPTION Show: " + loc_oErr.Message + CHR(13)+CHR(10), loc_cLog, 1)
    ENDTRY

    *-- Release + snapshot
    TRY
        loc_oForm.Release()
        STRTOFILE("[5] Release chamado OK" + CHR(13)+CHR(10), loc_cLog, 1)
    CATCH TO loc_oErr
        STRTOFILE("[5] EXCEPTION Release: " + loc_oErr.Message + CHR(13)+CHR(10), loc_cLog, 1)
    ENDTRY
    loc_oForm = .NULL.
    STRTOFILE("     Apos Release + .NULL.: CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
    FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
        STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
    ENDFOR
ENDIF

*-- FASE 3: Abrir mais um form para ver acumulacao/degradacao
TRY
    loc_oForm = CREATEOBJECT("FormCor")
    loc_oForm.Show(2)
    STRTOFILE("[6] Segundo FormCor Show OK, CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
    loc_oForm.Release()
    loc_oForm = .NULL.
    STRTOFILE("     Apos 2o Release: CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
    FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
        STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
    ENDFOR
CATCH TO loc_oErr
    STRTOFILE("[6] EXCEPTION 2o form: " + loc_oErr.Message + CHR(13)+CHR(10), loc_cLog, 1)
ENDTRY

IF gnConnHandle > 0
    SQLDISCONNECT(gnConnHandle)
ENDIF
STRTOFILE("=== DONE ===" + CHR(13)+CHR(10), loc_cLog, 1)
QUIT
