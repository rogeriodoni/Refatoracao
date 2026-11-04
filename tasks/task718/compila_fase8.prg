SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cErr, loc_cPrg
loc_cPrg = "C:\4c\projeto\app\forms\operacionais\Formsigopden.prg"
loc_cErr = "C:\4c\tasks\task718\compila_fase8.err"
IF FILE(loc_cErr)
    ERASE (loc_cErr)
ENDIF
COMPILE (loc_cPrg)
IF FILE(loc_cErr)
    STRTOFILE("ERROS:" + CHR(13) + FILETOSTR(loc_cErr), "C:\4c\tasks\task718\compila_fase8.out")
ELSE
    STRTOFILE("OK - sem erros. FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigopden.fxp"), "SIM", "NAO"), "C:\4c\tasks\task718\compila_fase8.out")
ENDIF
QUIT
