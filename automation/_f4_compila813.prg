SET SAFETY OFF
SET RESOURCE OFF
COMPILE ("C:\4c\projeto\app\classes\SigOpTotBO.prg")
COMPILE ("C:\4c\projeto\app\forms\operacionais\FormSigOpTot.prg")
COMPILE ("C:\4c\automation\CompilarF4SigOpTot813.prg")
STRTOFILE("FORM_FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpTot.fxp"),"SIM","NAO") + ;
  " BO_FXP=" + IIF(FILE("C:\4c\projeto\app\classes\SigOpTotBO.fxp"),"SIM","NAO") + ;
  " ERR_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpTot.err"),"SIM","NAO") + ;
  " ERR_BO=" + IIF(FILE("C:\4c\projeto\app\classes\SigOpTotBO.err"),"SIM","NAO") + ;
  " ERR_DRIVER=" + IIF(FILE("C:\4c\automation\CompilarF4SigOpTot813.err"),"SIM","NAO"), ;
  "C:\4c\automation\_f4_compila813.txt")
QUIT
