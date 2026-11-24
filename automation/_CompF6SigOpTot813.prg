SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cForm, loc_cBO, loc_cLog
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpTot.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpTotBO.prg"
loc_cLog  = "C:\4c\automation\_compf6_813.txt"

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".err"))
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

LOCAL loc_cTexto
loc_cTexto = "FORM .fxp: " + IIF(FILE(STRTRAN(loc_cForm, ".prg", ".fxp")), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FORM .err: " + IIF(FILE(STRTRAN(loc_cForm, ".prg", ".err")), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "BO   .fxp: " + IIF(FILE(STRTRAN(loc_cBO, ".prg", ".fxp")), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "BO   .err: " + IIF(FILE(STRTRAN(loc_cBO, ".prg", ".err")), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    loc_cTexto = loc_cTexto + CHR(13) + CHR(10) + "--- ERR FORM ---" + CHR(13) + CHR(10) + FILETOSTR(STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    loc_cTexto = loc_cTexto + CHR(13) + CHR(10) + "--- ERR BO ---" + CHR(13) + CHR(10) + FILETOSTR(STRTRAN(loc_cBO, ".prg", ".err"))
ENDIF
STRTOFILE(loc_cTexto, loc_cLog)
QUIT
