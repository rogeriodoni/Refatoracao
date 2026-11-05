SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcLog
lcLog = "C:\4c\automation\comp739f4.txt"
STRTOFILE("inicio" + CHR(13)+CHR(10), lcLog)
DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpGco.FXP"
DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpGco.ERR"
DELETE FILE "C:\4c\projeto\app\classes\SigOpGcoBO.FXP"
DELETE FILE "C:\4c\projeto\app\classes\SigOpGcoBO.ERR"
STRTOFILE("FXP apagado? FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpGco.FXP"),"NAO","SIM") + CHR(13)+CHR(10), lcLog, 1)
COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigOpGco.prg"
COMPILE "C:\4c\projeto\app\classes\SigOpGcoBO.prg"
STRTOFILE("FORM  FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpGco.FXP"),"SIM","NAO") + ;
          "  ERR=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpGco.ERR"),"SIM","NAO") + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("BO    FXP=" + IIF(FILE("C:\4c\projeto\app\classes\SigOpGcoBO.FXP"),"SIM","NAO") + ;
          "  ERR=" + IIF(FILE("C:\4c\projeto\app\classes\SigOpGcoBO.ERR"),"SIM","NAO") + CHR(13)+CHR(10), lcLog, 1)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpGco.ERR")
    STRTOFILE("ERR FORM: " + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpGco.ERR") + CHR(13)+CHR(10), lcLog, 1)
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpGcoBO.ERR")
    STRTOFILE("ERR BO: " + FILETOSTR("C:\4c\projeto\app\classes\SigOpGcoBO.ERR") + CHR(13)+CHR(10), lcLog, 1)
ENDIF
STRTOFILE("FIM" + CHR(13)+CHR(10), lcLog, 1)
QUIT
