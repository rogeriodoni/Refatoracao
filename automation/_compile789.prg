SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut, lcFrm, lcBO, lcNeg

lcFrm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPPRM"
lcBO  = "C:\4c\projeto\app\classes\SIGOPPRMBO"
lcNeg = "C:\4c\automation\_ctrlneg789"

COMPILE (lcBO  + ".prg")
COMPILE (lcFrm + ".prg")
COMPILE (lcNeg + ".prg")

lcOut = "BO.FXP="   + TRANSFORM(FILE(lcBO  + ".FXP")) + " BO.ERR="   + TRANSFORM(FILE(lcBO  + ".ERR")) + CHR(13) + CHR(10)
lcOut = lcOut + "FORM.FXP=" + TRANSFORM(FILE(lcFrm + ".FXP")) + " FORM.ERR=" + TRANSFORM(FILE(lcFrm + ".ERR")) + CHR(13) + CHR(10)
lcOut = lcOut + "CTRLNEG.FXP=" + TRANSFORM(FILE(lcNeg + ".FXP")) + " CTRLNEG.ERR=" + TRANSFORM(FILE(lcNeg + ".ERR")) + CHR(13) + CHR(10)
IF FILE(lcFrm + ".ERR")
    lcOut = lcOut + "--- FORM.ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcFrm + ".ERR") + CHR(13) + CHR(10)
ENDIF
IF FILE(lcBO + ".ERR")
    lcOut = lcOut + "--- BO.ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcBO + ".ERR") + CHR(13) + CHR(10)
ENDIF
IF FILE(lcNeg + ".ERR")
    lcOut = lcOut + "--- CTRLNEG.ERR (controle negativo) ---" + CHR(13) + CHR(10) + FILETOSTR(lcNeg + ".ERR") + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcOut, "C:\4c\automation\_compile789.txt")
QUIT
