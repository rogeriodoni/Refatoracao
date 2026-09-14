SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cTest, loc_cLog
loc_cTest = "C:\4c\automation\vfp_helpers\test_with_syntax3.prg"
loc_cLog  = "C:\4c\tasks\task190\test_with_syntax3.log"

LOCAL loc_cOut
loc_cOut = "=== TEST3 NO COLON ===" + CHR(13)+CHR(10)

IF FILE(FORCEEXT(loc_cTest, "fxp"))
    DELETE FILE (FORCEEXT(loc_cTest, "fxp"))
ENDIF
IF FILE(FORCEEXT(loc_cTest, "err"))
    DELETE FILE (FORCEEXT(loc_cTest, "err"))
ENDIF
COMPILE (loc_cTest)
IF FILE(FORCEEXT(loc_cTest, "err"))
    loc_cOut = loc_cOut + "ERRO: " + FILETOSTR(FORCEEXT(loc_cTest, "err")) + CHR(13)+CHR(10)
ELSE
    loc_cOut = loc_cOut + "OK" + CHR(13)+CHR(10)
ENDIF

STRTOFILE(loc_cOut, loc_cLog, 0)
QUIT
