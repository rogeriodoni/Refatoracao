SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcPrg, lcFxp, lcErrF, lcOut
lcPrg  = "C:\4c\projeto\app\forms\operacionais\Formsigmvcot.prg"
lcFxp  = "C:\4c\projeto\app\forms\operacionais\formsigmvcot.fxp"
lcErrF = "C:\4c\projeto\app\forms\operacionais\formsigmvcot.err"
lcOut  = "C:\4c\tasks\task565\fase8_compila.txt"
IF FILE(lcFxp)
    ERASE (lcFxp)
ENDIF
IF FILE(lcErrF)
    ERASE (lcErrF)
ENDIF
COMPILE (lcPrg)
IF FILE(lcErrF) AND LEN(ALLTRIM(FILETOSTR(lcErrF))) > 0
    STRTOFILE("ERROS:" + CHR(13) + FILETOSTR(lcErrF), lcOut)
ELSE
    STRTOFILE("OK sem erros | FXP gerado: " + IIF(FILE(lcFxp), "SIM", "NAO") + " | " + TTOC(DATETIME()), lcOut)
ENDIF
QUIT
