*-- Verificacao de compilacao do Form/BO da task610 (SigPrFem), Fase 8.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cSaida, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigPrFemBO.prg"

IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrFem.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrFem.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrFemBO.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrFemBO.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrFemBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrFemBO.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SigPrFemBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigPrFemBO.err")
ENDIF

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.err")
ENDIF

loc_cSaida = "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\SigPrFemBO.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) AND ;
   FILE("C:\4c\projeto\app\classes\SigPrFemBO.FXP") AND ;
   FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprfem_f8.txt")
QUIT
