SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cForm, loc_cBO, loc_cSaida
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPRPS.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGOPRPSBO.prg"
IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPRPS.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSIGOPRPS.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SIGOPRPSBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SIGOPRPSBO.err"
ENDIF
COMPILE (loc_cForm)
COMPILE (loc_cBO)
loc_cSaida = "FXP Form: " + IIF(FILE(STRTRAN(loc_cForm, ".prg", ".fxp")), "OK", "AUSENTE") + CHR(13) + CHR(10) + ;
             "FXP BO  : " + IIF(FILE(STRTRAN(loc_cBO,   ".prg", ".fxp")), "OK", "AUSENTE") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPRPS.err")
    loc_cSaida = loc_cSaida + "ERROS FORM:" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGOPRPS.err")
ELSE
    loc_cSaida = loc_cSaida + "ERROS FORM: nenhum" + CHR(13) + CHR(10)
ENDIF
IF FILE("C:\4c\projeto\app\classes\SIGOPRPSBO.err")
    loc_cSaida = loc_cSaida + "ERROS BO:" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\SIGOPRPSBO.err")
ELSE
    loc_cSaida = loc_cSaida + "ERROS BO: nenhum" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cSaida, "C:\4c\tasks\task797\logs\05_fase8_compilacao.log")
QUIT
