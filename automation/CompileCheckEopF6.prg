SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cPrg, loc_cFxp, loc_cErr, loc_cSaida
loc_cPrg = "C:\4c\projeto\app\forms\operacionais\FormSigPrEop.prg"
loc_cFxp = "C:\4c\projeto\app\forms\operacionais\FormSigPrEop.fxp"
loc_cErr = "C:\4c\projeto\app\forms\operacionais\FormSigPrEop.err"
IF FILE(loc_cFxp)
    ERASE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    ERASE (loc_cErr)
ENDIF
COMPILE (loc_cPrg)
loc_cSaida = "FXP=" + IIF(FILE(loc_cFxp), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(loc_cErr)
    loc_cSaida = loc_cSaida + "ERR:" + CHR(13) + CHR(10) + FILETOSTR(loc_cErr)
ELSE
    loc_cSaida = loc_cSaida + "SEM_ERROS"
ENDIF
STRTOFILE(loc_cSaida, "C:\4c\automation\compile_eop_f6.txt")
QUIT
