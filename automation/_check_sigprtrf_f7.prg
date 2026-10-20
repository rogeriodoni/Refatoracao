SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGPRTRF.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGPRTRFBO.prg"

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp")) AND FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    STRTOFILE("COMPILE_OK", "C:\4c\automation\_check_sigprtrf_f7.result")
ELSE
    STRTOFILE("COMPILE_FAIL", "C:\4c\automation\_check_sigprtrf_f7.result")
ENDIF

QUIT
