SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cForm, loc_cErr, loc_cFxp, loc_cSaida
loc_cForm = "C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.prg"
loc_cErr  = "C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.err"
loc_cFxp  = "C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.fxp"
IF FILE(loc_cErr)
    ERASE (loc_cErr)
ENDIF
IF FILE(loc_cFxp)
    ERASE (loc_cFxp)
ENDIF
COMPILE (loc_cForm)
IF FILE(loc_cErr) AND !EMPTY(FILETOSTR(loc_cErr))
    loc_cSaida = "COMPILE_FAIL" + CHR(13) + CHR(10) + FILETOSTR(loc_cErr)
ELSE
    loc_cSaida = "COMPILE_OK fxp=" + IIF(FILE(loc_cFxp), "SIM", "NAO")
ENDIF
STRTOFILE(loc_cSaida, "C:\4c\automation\sigprint_f7_result.txt")
QUIT
