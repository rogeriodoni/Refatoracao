*-- Verificacao de compilacao do Form + BO da task668 (SIGPRPRO), Fase 6.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cSaida, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGPRPROBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprpro.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprpro.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprprobo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprprobo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SIGPRPROBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SIGPRPROBO.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.err")
ENDIF
loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SIGPRPROBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SIGPRPROBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprpro.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\sigprprobo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigprpro.FXP") ;
   AND FILE("C:\4c\projeto\app\classes\sigprprobo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_pro668_f7.txt")
QUIT
