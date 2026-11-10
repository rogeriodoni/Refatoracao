SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcBO, lcFO, lcOut

lcBO = "C:\4c\projeto\app\classes\SigOpLibBO.prg"
lcFO = "C:\4c\projeto\app\forms\operacionais\FormSigOpLib.prg"

IF FILE("C:\4c\projeto\app\classes\SigOpLibBO.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpLibBO.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpLibBO.ERR")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpLibBO.ERR"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpLib.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpLib.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpLib.ERR")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpLib.ERR"
ENDIF

COMPILE (lcBO)
COMPILE (lcFO)

lcOut = "BO.FXP="   + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpLibBO.FXP")) + ;
        " BO.ERR="  + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpLibBO.ERR")) + ;
        " FORM.FXP="+ TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpLib.FXP")) + ;
        " FORM.ERR="+ TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpLib.ERR")) + CHR(13) + CHR(10)

IF FILE("C:\4c\projeto\app\classes\SigOpLibBO.ERR")
    lcOut = lcOut + "--- BO.ERR ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\SigOpLibBO.ERR")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpLib.ERR")
    lcOut = lcOut + "--- FORM.ERR ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpLib.ERR")
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\compile_check_760_f8.txt")
QUIT
