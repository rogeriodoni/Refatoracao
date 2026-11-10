SET SAFETY OFF
SET RESOURCE OFF
COMPILE C:\4c\projeto\app\classes\SigOpGvtBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\FormSigOpGvt.prg
STRTOFILE("BO.FXP=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpGvtBO.FXP")) + ;
    " BO.ERR=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpGvtBO.ERR")) + ;
    " FORM.FXP=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpGvt.FXP")) + ;
    " FORM.ERR=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpGvt.ERR")), ;
    "C:\4c\automation\compile744f8_out.txt")
QUIT
