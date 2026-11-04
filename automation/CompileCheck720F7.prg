SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut, lcPrg, lcErr
lcPrg = "C:\4c\projeto\app\forms\operacionais\FormSigOpDet.prg"
lcErr = "C:\4c\projeto\app\forms\operacionais\FormSigOpDet.err"
COMPILE (lcPrg)
lcOut = "PRG=" + lcPrg + CHR(13) + CHR(10)
lcOut = lcOut + "FXP_EXISTE=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpDet.fxp")) + CHR(13) + CHR(10)
lcOut = lcOut + "ERR_EXISTE=" + TRANSFORM(FILE(lcErr)) + CHR(13) + CHR(10)
IF FILE(lcErr)
    lcOut = lcOut + "--- ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcErr)
ENDIF
STRTOFILE(lcOut, "C:\4c\automation\compile720f7.txt")
QUIT
