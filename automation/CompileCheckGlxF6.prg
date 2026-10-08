SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcPrg, lcFxp, lcErr

lcPrg = "C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg"
lcFxp = "C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.fxp"
lcErr = "C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.err"

IF FILE(lcFxp)
    DELETE FILE (lcFxp)
ENDIF
IF FILE(lcErr)
    DELETE FILE (lcErr)
ENDIF

COMPILE (lcPrg)

IF FILE(lcErr)
    STRTOFILE("ERROS:" + CHR(13) + CHR(10) + FILETOSTR(lcErr), "C:\4c\automation\logs\glx_f6_compile.txt")
ELSE
    STRTOFILE("OK - sem .err. FXP gerado: " + TRANSFORM(FILE(lcFxp)), "C:\4c\automation\logs\glx_f6_compile.txt")
ENDIF

QUIT
