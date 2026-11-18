SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcForm, lcErr, lcLog
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.prg"
lcErr  = "C:\4c\automation\fase7_sigopspr805_erros.txt"
lcLog  = "C:\4c\automation\fase7_sigopspr805_compile.txt"
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.FXP"
ENDIF
IF FILE(lcErr)
    DELETE FILE (lcErr)
ENDIF
COMPILE (lcForm)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.ERR")
    STRTOFILE("ERROS:" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.ERR"), lcLog)
ELSE
    STRTOFILE("SEM ERR. FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.FXP"), "OK", "AUSENTE"), lcLog)
ENDIF
QUIT
