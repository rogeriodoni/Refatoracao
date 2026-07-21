SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cErr, loc_cLog
loc_cErr = "C:\4c\projeto\app\menu\menu.err"
loc_cLog = "C:\4c\automation\vfp_helpers\test_menu_compile.log"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF
IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF
COMPILE C:\4c\projeto\app\menu\menu.prg
IF FILE(loc_cErr)
    STRTOFILE("FAIL:" + CHR(13)+CHR(10) + FILETOSTR(loc_cErr), loc_cLog)
ELSE
    STRTOFILE("OK", loc_cLog)
ENDIF
QUIT
