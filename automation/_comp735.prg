SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcForm, lcBO, lcOut
lcForm = "C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.prg"
lcBO   = "C:\4c\projeto\app\classes\SIGOPFLUBO.prg"
COMPILE (lcForm)
COMPILE (lcBO)
lcOut = "FORM.FXP=" + IIF(FILE(STRTRAN(lcForm,".prg",".fxp")), "SIM", "NAO") + ;
        " FORM.ERR=" + IIF(FILE(STRTRAN(lcForm,".prg",".err")), "SIM", "NAO") + ;
        " BO.FXP="   + IIF(FILE(STRTRAN(lcBO,".prg",".fxp")),   "SIM", "NAO") + ;
        " BO.ERR="   + IIF(FILE(STRTRAN(lcBO,".prg",".err")),   "SIM", "NAO")
STRTOFILE(lcOut, "C:\4c\automation\_comp735_out.txt")
QUIT
