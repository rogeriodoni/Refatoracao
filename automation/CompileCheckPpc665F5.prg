*-- Verificacao de compilacao da task665 (SigPrPpc), Fase 5.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cSaida, loc_cErrForm

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrPpc.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprppc.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprppc.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrPpc.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrPpc.err"
ENDIF

COMPILE (loc_cForm)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrPpc.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrPpc.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprppc.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND FILE("C:\4c\projeto\app\forms\operacionais\formsigprppc.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_ppc665_f5.txt")
QUIT
