SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut
lcOut = ""
COMPILE "C:\4c\projeto\app\classes\sigreeqeBO.prg"
lcOut = lcOut + "sigreeqeBO.fxp existe = " + TRANSFORM(FILE("C:\4c\projeto\app\classes\sigreeqeBO.fxp")) + CHR(13)+CHR(10)
COMPILE "C:\4c\projeto\app\forms\relatorios\Formsigreeqe.prg"
lcOut = lcOut + "Formsigreeqe.fxp existe = " + TRANSFORM(FILE("C:\4c\projeto\app\forms\relatorios\Formsigreeqe.fxp")) + CHR(13)+CHR(10)
IF FILE("C:\4c\projeto\app\classes\sigreeqeBO.err")
    lcOut = lcOut + "ERROS BO:" + CHR(13)+CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\sigreeqeBO.err")
ELSE
    lcOut = lcOut + "BO: sem .err" + CHR(13)+CHR(10)
ENDIF
IF FILE("C:\4c\projeto\app\forms\relatorios\Formsigreeqe.err")
    lcOut = lcOut + "ERROS FORM:" + CHR(13)+CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\relatorios\Formsigreeqe.err")
ELSE
    lcOut = lcOut + "FORM: sem .err" + CHR(13)+CHR(10)
ENDIF
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro340_tmp\compilar.txt")
QUIT
