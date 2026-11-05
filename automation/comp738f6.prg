SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcLog
lcLog = "C:\4c\automation\comp738f6.txt"
STRTOFILE("inicio" + CHR(13)+CHR(10), lcLog)
DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigopgar.FXP"
DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigopgar.ERR"
DELETE FILE "C:\4c\projeto\app\classes\sigopgarBO.FXP"
DELETE FILE "C:\4c\projeto\app\classes\sigopgarBO.ERR"
COMPILE "C:\4c\projeto\app\forms\operacionais\Formsigopgar.prg"
COMPILE "C:\4c\projeto\app\classes\sigopgarBO.prg"
STRTOFILE("FORM  FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigopgar.FXP"),"SIM","NAO") + ;
          "  ERR=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigopgar.ERR"),"SIM","NAO") + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("BO    FXP=" + IIF(FILE("C:\4c\projeto\app\classes\sigopgarBO.FXP"),"SIM","NAO") + ;
          "  ERR=" + IIF(FILE("C:\4c\projeto\app\classes\sigopgarBO.ERR"),"SIM","NAO") + CHR(13)+CHR(10), lcLog, 1)
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopgar.ERR")
    STRTOFILE("ERR FORM: " + FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigopgar.ERR") + CHR(13)+CHR(10), lcLog, 1)
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopgarBO.ERR")
    STRTOFILE("ERR BO: " + FILETOSTR("C:\4c\projeto\app\classes\sigopgarBO.ERR") + CHR(13)+CHR(10), lcLog, 1)
ENDIF
STRTOFILE("FIM" + CHR(13)+CHR(10), lcLog, 1)
QUIT
