SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut
loc_cOut = ""

IF FILE("C:\4c\projeto\app\classes\SigPrMdcBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrMdcBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.fxp"
ENDIF
IF FILE("C:\4c\automation\err_task635.err")
    DELETE FILE "C:\4c\automation\err_task635.err"
ENDIF

COMPILE "C:\4c\projeto\app\classes\SigPrMdcBO.prg"
COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.prg"

loc_cOut = "BO  .fxp existe: " + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigPrMdcBO.fxp")) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "FORM .fxp existe: " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.fxp")) + CHR(13) + CHR(10)

IF FILE("C:\4c\projeto\app\classes\SigPrMdcBO.err")
    loc_cOut = loc_cOut + "--- ERROS BO ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\SigPrMdcBO.err") + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "BO: sem .err" + CHR(13) + CHR(10)
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.err")
    loc_cOut = loc_cOut + "--- ERROS FORM ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.err") + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "FORM: sem .err" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cOut, "C:\4c\automation\compilar_task635.txt")
QUIT
