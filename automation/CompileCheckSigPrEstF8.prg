SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcLog
lcLog = "C:\4c\automation\compile_f8_sigprest.txt"
STRTOFILE("=== COMPILE CHECK Fase 8 ===" + CHR(13)+CHR(10), lcLog)
COMPILE "C:\4c\projeto\app\classes\SIGPRESTBO.prg"
COMPILE "C:\4c\projeto\app\forms\operacionais\FormSIGPREST.prg"
STRTOFILE("SIGPRESTBO.fxp    : " + TRANSFORM(FILE("C:\4c\projeto\app\classes\SIGPRESTBO.fxp")) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("SIGPRESTBO.err    : " + TRANSFORM(FILE("C:\4c\projeto\app\classes\SIGPRESTBO.err")) + CHR(13)+CHR(10), lcLog, 1)
IF FILE("C:\4c\projeto\app\classes\SIGPRESTBO.err")
    STRTOFILE(FILETOSTR("C:\4c\projeto\app\classes\SIGPRESTBO.err") + CHR(13)+CHR(10), lcLog, 1)
ENDIF
STRTOFILE("FormSIGPREST.fxp  : " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPREST.fxp")) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("FormSIGPREST.err  : " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPREST.err")) + CHR(13)+CHR(10), lcLog, 1)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPREST.err")
    STRTOFILE(FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGPREST.err") + CHR(13)+CHR(10), lcLog, 1)
ENDIF
STRTOFILE("=== FIM ===" + CHR(13)+CHR(10), lcLog, 1)
QUIT
