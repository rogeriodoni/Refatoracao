SET SAFETY OFF
SET RESOURCE OFF
COMPILE C:\4c\projeto\app\classes\SigOpImgBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\FormSigOpImg.prg
STRTOFILE("BO.FXP=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpImgBO.FXP")) + ;
    " BO.ERR=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpImgBO.ERR")) + ;
    " FORM.FXP=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpImg.FXP")) + ;
    " FORM.ERR=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpImg.ERR")), ;
    "C:\4c\automation\compile748f8_out.txt")
QUIT
