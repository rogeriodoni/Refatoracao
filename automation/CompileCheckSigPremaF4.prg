*-- Verificacao de compilacao do BO + Form da task602 (SIGPREMA), Fase 4.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm

loc_cBO   = "C:\4c\projeto\app\classes\sigpremaBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigprema.prg"

IF FILE("C:\4c\projeto\app\classes\sigpremabo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigpremabo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprema.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprema.FXP"
ENDIF

IF FILE("C:\4c\projeto\app\classes\sigpremaBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigpremaBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprema.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprema.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\sigpremaBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\sigpremaBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprema.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigprema.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\sigpremabo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprema.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\classes\sigpremabo.FXP") ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigprema.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprema_f4.txt")
QUIT
