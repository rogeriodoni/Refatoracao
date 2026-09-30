*-- Verificacao de compilacao do par BO + Form da task599 (sigprdft), Fase 3.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm

loc_cBO   = "C:\4c\projeto\app\classes\sigprdftBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg"

IF FILE("C:\4c\projeto\app\classes\sigprdftbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprdftbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprdft.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprdft.FXP"
ENDIF

IF FILE("C:\4c\projeto\app\classes\sigprdftBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigprdftBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprdft.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprdft.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\sigprdftBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\sigprdftBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprdft.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigprdft.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\sigprdftbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprdft.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\classes\sigprdftbo.FXP") ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigprdft.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprdft.txt")
QUIT
