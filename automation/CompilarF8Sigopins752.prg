SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcForm, lcFxp, lcErr, lcTxt

lcForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPins.prg"
lcFxp  = "C:\4c\projeto\app\forms\operacionais\FormSIGOPins.fxp"
lcErr  = "C:\4c\projeto\app\forms\operacionais\FormSIGOPins.err"

IF FILE(lcFxp)
    ERASE (lcFxp)
ENDIF
IF FILE(lcErr)
    ERASE (lcErr)
ENDIF

COMPILE (lcForm)

lcTxt = "ARQUIVO: " + lcForm + CHR(13) + CHR(10)
lcTxt = lcTxt + "ERROS(_TALLY): " + TRANSFORM(_TALLY) + CHR(13) + CHR(10)
lcTxt = lcTxt + "FXP GERADO: " + IIF(FILE(lcFxp), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(lcErr)
    lcTxt = lcTxt + "--- ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcErr)
ELSE
    lcTxt = lcTxt + "SEM ARQUIVO .ERR (compilacao limpa)" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcTxt, "C:\4c\automation\_f8_752_compilacao.txt")
QUIT
