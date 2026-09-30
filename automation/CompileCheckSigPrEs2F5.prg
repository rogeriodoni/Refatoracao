*-- Verificacao de compilacao do BO + Form da task607 (SIGPRES2), Fase 5.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm

loc_cBO   = "C:\4c\projeto\app\classes\sigpres2BO.prg"
loc_cForm = "C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg"

IF FILE("C:\4c\projeto\app\classes\sigpres2bo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigpres2bo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\cadastros\formsigpres2.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\cadastros\formsigpres2.FXP"
ENDIF

IF FILE("C:\4c\projeto\app\classes\sigpres2BO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigpres2BO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\cadastros\Formsigpres2.err")
    DELETE FILE "C:\4c\projeto\app\forms\cadastros\Formsigpres2.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\sigpres2BO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\sigpres2BO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\cadastros\Formsigpres2.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\cadastros\Formsigpres2.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\sigpres2bo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\cadastros\formsigpres2.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\classes\sigpres2bo.FXP") ;
   AND FILE("C:\4c\projeto\app\forms\cadastros\formsigpres2.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigpres2_f5.txt")
QUIT
