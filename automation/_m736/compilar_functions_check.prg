SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcLog
lcLog = "C:\4c\automation\_m736\compilar_functions_check.txt"
STRTOFILE("start" + CHR(13)+CHR(10), lcLog)
IF FILE("C:\4c\projeto\app\utils\functions.err")
    DELETE FILE "C:\4c\projeto\app\utils\functions.err"
ENDIF
IF FILE("C:\4c\projeto\app\utils\functions.fxp")
    DELETE FILE "C:\4c\projeto\app\utils\functions.fxp"
ENDIF
COMPILE "C:\4c\projeto\app\utils\functions.prg"
IF FILE("C:\4c\projeto\app\utils\functions.err")
    STRTOFILE(FILETOSTR("C:\4c\projeto\app\utils\functions.err"), lcLog)
ELSE
    STRTOFILE("OK - no err file", lcLog)
ENDIF
QUIT
