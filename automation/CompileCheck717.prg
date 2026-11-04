SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut, lcF, lcB
lcF = "C:\4c\projeto\app\forms\operacionais\FormSigOpCts.prg"
lcB = "C:\4c\projeto\app\classes\SigOpCtsBO.prg"
COMPILE (lcB)
COMPILE (lcF)
lcOut = "BO.FXP="  + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpCtsBO.fxp")) + ;
        " BO.ERR=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpCtsBO.err")) + ;
        " FORM.FXP=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCts.fxp")) + ;
        " FORM.ERR=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCts.err"))
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCts.err")
    lcOut = lcOut + CHR(13) + CHR(10) + "--- FORM.ERR ---" + CHR(13) + CHR(10) + ;
            FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpCts.err")
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpCtsBO.err")
    lcOut = lcOut + CHR(13) + CHR(10) + "--- BO.ERR ---" + CHR(13) + CHR(10) + ;
            FILETOSTR("C:\4c\projeto\app\classes\SigOpCtsBO.err")
ENDIF
STRTOFILE(lcOut, "C:\4c\automation\compile717_out.txt")
QUIT
