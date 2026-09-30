*-- Verificacao de compilacao do BO + Form da task594 (SIGPRCOT), Fase 3.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm

loc_cBO   = "C:\4c\projeto\app\classes\SIGPRCOTBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg"

IF FILE("C:\4c\projeto\app\classes\sigprcotbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprcotbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprcot.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprcot.FXP"
ENDIF

IF FILE("C:\4c\projeto\app\classes\SIGPRCOTBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SIGPRCOTBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\SIGPRCOTBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SIGPRCOTBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\sigprcotbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprcot.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\classes\sigprcotbo.FXP") ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigprcot.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprcot_f3.txt")
QUIT
