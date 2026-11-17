SET SAFETY OFF
SET RESOURCE OFF
COMPILE ("C:\4c\projeto\app\classes\sigopsepBO.prg")
COMPILE ("C:\4c\projeto\app\forms\operacionais\Formsigopsep.prg")
STRTOFILE("FORM_FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigopsep.fxp"),"SIM","NAO") + ;
  " BO_FXP=" + IIF(FILE("C:\4c\projeto\app\classes\sigopsepBO.fxp"),"SIM","NAO") + ;
  " ERR_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigopsep.err"),"SIM","NAO") + ;
  " ERR_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigopsepBO.err"),"SIM","NAO"), ;
  "C:\4c\automation\_f4_compila800.txt")
QUIT
