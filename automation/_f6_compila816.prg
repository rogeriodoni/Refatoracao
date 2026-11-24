SET SAFETY OFF
SET RESOURCE OFF
COMPILE ("C:\4c\projeto\app\forms\operacionais\Formsigopvci.prg")
STRTOFILE("FORM_FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigopvci.fxp"),"SIM","NAO") + ;
  " ERR_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigopvci.err"),"SIM","NAO"), ;
  "C:\4c\automation\_f6_compila816.txt")
QUIT
