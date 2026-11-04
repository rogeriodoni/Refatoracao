SET SAFETY OFF
SET RESOURCE OFF
COMPILE C:\4c\projeto\app\classes\SigOpEntBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.prg
STRTOFILE("BO.FXP="   + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpEntBO.fxp"))  + ;
          " BO.ERR="  + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpEntBO.err"))  + ;
          " FORM.FXP="+ TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.fxp")) + ;
          " FORM.ERR="+ TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.err")), ;
          "C:\4c\automation\compile_ent731_f4.txt")
QUIT
