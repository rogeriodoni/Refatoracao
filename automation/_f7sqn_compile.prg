SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut
lcOut = ""
COMPILE C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.prg
lcOut = lcOut + "FORM FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.fxp"),"SIM","NAO")
lcOut = lcOut + " ERR=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.err"),"SIM","NAO") + CHR(13)+CHR(10)
COMPILE C:\4c\projeto\app\classes\SigOpSqnBO.prg
lcOut = lcOut + "BO FXP=" + IIF(FILE("C:\4c\projeto\app\classes\SigOpSqnBO.fxp"),"SIM","NAO")
lcOut = lcOut + " ERR=" + IIF(FILE("C:\4c\projeto\app\classes\SigOpSqnBO.err"),"SIM","NAO") + CHR(13)+CHR(10)
STRTOFILE(lcOut, "C:\4c\automation\_f7sqn_compile.txt")
QUIT
