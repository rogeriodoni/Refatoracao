SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcRes
lcRes = ""

IF FILE("C:\4c\projeto\app\classes\SigPrSndBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrSndBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrSndBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrSndBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.err"
ENDIF
IF FILE("C:\4c\projeto\app\menu\menu.fxp")
    DELETE FILE "C:\4c\projeto\app\menu\menu.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\menu\menu.err")
    DELETE FILE "C:\4c\projeto\app\menu\menu.err"
ENDIF
IF FILE("C:\4c\tasks\task678\_compila_fase8.out")
    DELETE FILE "C:\4c\tasks\task678\_compila_fase8.out"
ENDIF

COMPILE C:\4c\projeto\app\classes\SigPrSndBO.prg
lcRes = lcRes + "BO   fxp=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigPrSndBO.fxp")) + ;
                "  err=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigPrSndBO.err")) + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\classes\SigPrSndBO.err")
    lcRes = lcRes + "--- ERROS BO ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\SigPrSndBO.err") + CHR(13) + CHR(10)
ENDIF

COMPILE C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.prg
lcRes = lcRes + "FRM  fxp=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.fxp")) + ;
                "  err=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.err")) + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.err")
    lcRes = lcRes + "--- ERROS FORM ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.err") + CHR(13) + CHR(10)
ENDIF

COMPILE C:\4c\projeto\app\menu\menu.prg
lcRes = lcRes + "MENU fxp=" + TRANSFORM(FILE("C:\4c\projeto\app\menu\menu.fxp")) + ;
                "  err=" + TRANSFORM(FILE("C:\4c\projeto\app\menu\menu.err")) + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\menu\menu.err")
    lcRes = lcRes + "--- ERROS MENU ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\menu\menu.err") + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcRes, "C:\4c\tasks\task678\_compila_fase8.out", 0)
QUIT
