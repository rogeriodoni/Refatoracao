*-- Verificacao de compilacao do Form da task676 (SIGPRSER), Fase 4.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cSaida, loc_cErrForm

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrSer.prg"

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprser.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprser.FXP"
ENDIF

IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrSer.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrSer.err"
ENDIF

COMPILE (loc_cForm)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrSer.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrSer.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprser.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigprser.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprser_f4.txt")
QUIT
