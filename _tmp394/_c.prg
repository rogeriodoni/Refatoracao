SET SAFETY OFF
SET RESOURCE OFF
_SCREEN.WindowState = 1
LOCAL lcO
lcO = ""
COMPILE C:\4c\projeto\app\forms\operacionais\FormSIGPGCNB.prg
lcO = lcO + "FRM FXP=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\formsigpgcnb.fxp")) + ;
            " ERR=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\formsigpgcnb.err")) + CHR(13)+CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigpgcnb.err")
    lcO = lcO + FILETOSTR("C:\4c\projeto\app\forms\operacionais\formsigpgcnb.err") + CHR(13)+CHR(10)
ENDIF
STRTOFILE(lcO, "C:\4c\_tmp394\_c.txt")
QUIT
