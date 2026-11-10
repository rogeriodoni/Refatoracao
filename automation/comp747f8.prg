SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcLog, lcForm, lcBO
lcLog  = "C:\4c\automation\comp747f8.txt"
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpIgm"
lcBO   = "C:\4c\projeto\app\classes\SigOpIgmBO"
STRTOFILE("inicio" + CHR(13)+CHR(10), lcLog)
DELETE FILE (lcForm + ".FXP")
DELETE FILE (lcForm + ".ERR")
DELETE FILE (lcBO + ".FXP")
DELETE FILE (lcBO + ".ERR")
STRTOFILE("FXP apagado? FORM=" + IIF(FILE(lcForm + ".FXP"),"NAO","SIM") + CHR(13)+CHR(10), lcLog, 1)
COMPILE (lcForm + ".prg")
COMPILE (lcBO + ".prg")
STRTOFILE("FORM  FXP=" + IIF(FILE(lcForm + ".FXP"),"SIM","NAO") + "  ERR=" + IIF(FILE(lcForm + ".ERR"),"SIM","NAO") + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("BO    FXP=" + IIF(FILE(lcBO + ".FXP"),"SIM","NAO") + "  ERR=" + IIF(FILE(lcBO + ".ERR"),"SIM","NAO") + CHR(13)+CHR(10), lcLog, 1)
IF FILE(lcForm + ".ERR")
    STRTOFILE("ERR FORM: " + FILETOSTR(lcForm + ".ERR") + CHR(13)+CHR(10), lcLog, 1)
ENDIF
IF FILE(lcBO + ".ERR")
    STRTOFILE("ERR BO: " + FILETOSTR(lcBO + ".ERR") + CHR(13)+CHR(10), lcLog, 1)
ENDIF
STRTOFILE("FIM" + CHR(13)+CHR(10), lcLog, 1)
QUIT
