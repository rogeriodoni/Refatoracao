SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cForm, loc_cBO, loc_cErrForm, loc_cErrBO, loc_cSaida
loc_cForm    = "C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg"
loc_cBO      = "C:\4c\projeto\app\classes\sigprftpBO.prg"
loc_cErrForm = "C:\4c\projeto\app\forms\operacionais\Formsigprftp.err"
loc_cErrBO   = "C:\4c\projeto\app\classes\sigprftpBO.err"

IF FILE(loc_cErrForm)
    ERASE (loc_cErrForm)
ENDIF
IF FILE(loc_cErrBO)
    ERASE (loc_cErrBO)
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cSaida = ""
IF FILE(loc_cErrBO) AND !EMPTY(FILETOSTR(loc_cErrBO))
    loc_cSaida = loc_cSaida + "BO_COMPILE_FAIL" + CHR(13) + CHR(10) + FILETOSTR(loc_cErrBO) + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "BO_COMPILE_OK" + CHR(13) + CHR(10)
ENDIF

IF FILE(loc_cErrForm) AND !EMPTY(FILETOSTR(loc_cErrForm))
    loc_cSaida = loc_cSaida + "FORM_COMPILE_FAIL" + CHR(13) + CHR(10) + FILETOSTR(loc_cErrForm)
ELSE
    loc_cSaida = loc_cSaida + "FORM_COMPILE_OK"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\ftp_f8_result.txt")
QUIT
