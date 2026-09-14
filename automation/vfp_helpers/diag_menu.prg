SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cLog
loc_cLog = "C:\4c\automation\vfp_helpers\diag_menu.log"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

STRTOFILE("=== DIAG MENU " + TTOC(DATETIME()) + " ===" + CHR(13)+CHR(10), loc_cLog)

CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
STRTOFILE("[1] ConfigurarAmbiente ok" + CHR(13)+CHR(10), loc_cLog, 1)

*-- Antes de CriarMenuPrincipal
STRTOFILE("[2] ANTES CriarMenuPrincipal: CNTPAD(_MSYSMENU) = " + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)

*-- Chamar CriarMenuPrincipal 1x
DO CriarMenuPrincipal
STRTOFILE("[3] APOS 1a CriarMenuPrincipal:" + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("     CNTPAD(_MSYSMENU) = " + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("     CNTBAR(popRelatorios) = " + TRANSFORM(CNTBAR("popRelatorios")) + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("     CNTBAR(popArquivo)    = " + TRANSFORM(CNTBAR("popArquivo")) + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("     CNTBAR(popFerramentas) = " + TRANSFORM(CNTBAR("popFerramentas")) + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("     CNTBAR(popAjuda)       = " + TRANSFORM(CNTBAR("popAjuda")) + CHR(13)+CHR(10), loc_cLog, 1)

*-- Listar todos os PADs para ver se Ferramentas/Ajuda existem
LOCAL loc_i, loc_cPad
STRTOFILE("[4] Pads em _MSYSMENU:" + CHR(13)+CHR(10), loc_cLog, 1)
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    loc_cPad = PRMPAD("_MSYSMENU", loc_i)
    STRTOFILE("     " + TRANSFORM(loc_i) + ": " + loc_cPad + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

*-- Chamar CriarMenuPrincipal 2x — simula recarga
DO CriarMenuPrincipal
STRTOFILE("[5] APOS 2a CriarMenuPrincipal:" + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("     CNTPAD(_MSYSMENU) = " + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("     CNTBAR(popRelatorios) = " + TRANSFORM(CNTBAR("popRelatorios")) + CHR(13)+CHR(10), loc_cLog, 1)
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    loc_cPad = PRMPAD("_MSYSMENU", loc_i)
    STRTOFILE("     " + TRANSFORM(loc_i) + ": " + loc_cPad + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

STRTOFILE("=== DONE ===" + CHR(13)+CHR(10), loc_cLog, 1)
QUIT
