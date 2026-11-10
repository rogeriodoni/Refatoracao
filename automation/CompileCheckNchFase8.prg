SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcForm, lcFxp, lcLog, lcErro

lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpNch.prg"
lcFxp  = "C:\4c\projeto\app\forms\operacionais\FormSigOpNch.fxp"
lcLog  = "C:\4c\automation\compilecheck_nch_f8.txt"
lcErro = "C:\4c\automation\compilecheck_nch_f8_err.txt"

IF FILE(lcFxp)
    ERASE (lcFxp)
ENDIF
IF FILE(lcErro)
    ERASE (lcErro)
ENDIF

COMPILE (lcForm)

LOCAL lcSaida
lcSaida = "FXP gerado: " + IIF(FILE(lcFxp), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(lcErro)
    lcSaida = lcSaida + "ERROS:" + CHR(13) + CHR(10) + FILETOSTR(lcErro)
ELSE
    lcSaida = lcSaida + "Sem arquivo de erro."
ENDIF

STRTOFILE(lcSaida, lcLog)

QUIT
