*-- Verificacao de compilacao do BO + Form da task603 (SIGPREML), Fase 8.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm

loc_cBO   = "C:\4c\projeto\app\classes\SigPrEmlBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg"

IF FILE("C:\4c\projeto\app\classes\SigPrEmlBO.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrEmlBO.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrEml.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrEml.FXP"
ENDIF

IF FILE("C:\4c\projeto\app\classes\SigPrEmlBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrEmlBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrEml.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrEml.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\SigPrEmlBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigPrEmlBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrEml.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrEml.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\SigPrEmlBO.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrEml.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\classes\SigPrEmlBO.FXP") ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrEml.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigpreml_f8.txt")
QUIT
