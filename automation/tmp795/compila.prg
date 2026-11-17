SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut
lcOut = ""

COMPILE "C:\4c\projeto\app\classes\SIGOPRESBO.prg"
lcOut = lcOut + "BO_FXP=" + IIF(FILE("C:\4c\projeto\app\classes\SIGOPRESBO.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "BO_ERR=" + IIF(FILE("C:\4c\projeto\app\classes\SIGOPRESBO.err"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\classes\SIGOPRESBO.err")
    lcOut = lcOut + FILETOSTR("C:\4c\projeto\app\classes\SIGOPRESBO.err") + CHR(13) + CHR(10)
ENDIF

COMPILE "C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.prg"
lcOut = lcOut + "FORM_FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "FORM_ERR=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.err"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.err")
    lcOut = lcOut + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.err") + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\tmp795\compila_out.txt")
QUIT
