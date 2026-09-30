SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cForm, loc_cErr, loc_cSaida
loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg"
loc_cErr  = "C:\4c\projeto\app\forms\operacionais\Formsigprftp.err"
IF FILE(loc_cErr)
    ERASE (loc_cErr)
ENDIF
COMPILE (loc_cForm)
IF FILE(loc_cErr) AND !EMPTY(FILETOSTR(loc_cErr))
    loc_cSaida = "COMPILE_FAIL" + CHR(13) + CHR(10) + FILETOSTR(loc_cErr)
ELSE
    loc_cSaida = "COMPILE_OK"
ENDIF
STRTOFILE(loc_cSaida, "C:\4c\automation\ftp_f5_result.txt")
QUIT
