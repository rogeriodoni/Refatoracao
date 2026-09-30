SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcForm, lcBO, lcSaida
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg"
lcBO   = "C:\4c\projeto\app\classes\SigPrCccBO.prg"
lcSaida = ""
IF FILE(FORCEEXT(lcForm, "fxp"))
    DELETE FILE (FORCEEXT(lcForm, "fxp"))
ENDIF
IF FILE(FORCEEXT(lcBO, "fxp"))
    DELETE FILE (FORCEEXT(lcBO, "fxp"))
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrCccBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrCccBO.err"
ENDIF
COMPILE (lcForm)
COMPILE (lcBO)
lcSaida = "FORM FXP: " + IIF(FILE(FORCEEXT(lcForm,"fxp")), "OK", "AUSENTE") + CHR(13) + CHR(10)
lcSaida = lcSaida + "BO   FXP: " + IIF(FILE(FORCEEXT(lcBO,"fxp")), "OK", "AUSENTE") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.err")
    lcSaida = lcSaida + "ERROS FORM:" + CHR(13)+CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.err")
ELSE
    lcSaida = lcSaida + "ERROS FORM: nenhum" + CHR(13)+CHR(10)
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrCccBO.err")
    lcSaida = lcSaida + "ERROS BO:" + CHR(13)+CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\SigPrCccBO.err")
ELSE
    lcSaida = lcSaida + "ERROS BO: nenhum" + CHR(13)+CHR(10)
ENDIF
STRTOFILE(lcSaida, "C:\4c\automation\compile_fase8_sigprccc.log")
QUIT
