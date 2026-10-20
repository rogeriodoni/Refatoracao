*-- Verificacao de compilacao da task671 (SigPrRsa), Fase 3.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cSaida, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigPrRsaBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprrsa.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprrsa.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprrsabo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprrsabo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrRsaBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrRsaBO.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.err")
ENDIF
loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SigPrRsaBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigPrRsaBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprrsa.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigprrsabo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) AND ;
        FILE("C:\4c\projeto\app\forms\operacionais\formsigprrsa.FXP") AND ;
        FILE("C:\4c\projeto\app\classes\sigprrsabo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_rsa671_f3.txt")
QUIT
