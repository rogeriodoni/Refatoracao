*-- Verificacao de compilacao da task666 (SIGPRPPP), Fase 4.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cSaida, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGPRPPPBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprppp.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprppp.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprpppbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprpppbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SIGPRPPPBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SIGPRPPPBO.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.err")
ENDIF
loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SIGPRPPPBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SIGPRPPPBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprppp.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigprpppbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) AND ;
        FILE("C:\4c\projeto\app\forms\operacionais\formsigprppp.FXP") AND ;
        FILE("C:\4c\projeto\app\classes\sigprpppbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_ppp666_f4.txt")
QUIT
