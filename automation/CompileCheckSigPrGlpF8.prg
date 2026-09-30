*-- Verificacao de compilacao do par BO + Form da task617 (SigPrGlp), Fase 8.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm

loc_cBO   = "C:\4c\projeto\app\classes\SigPrGlpBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\classes\sigprglpbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprglpbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprglp.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprglp.FXP"
ENDIF

*-- COMPILE nao dispara excecao em erro de sintaxe: grava um .ERR ao lado do
*-- fonte. Apagar os .ERR antigos e LER os arquivos - esse eh o veredito.
IF FILE("C:\4c\projeto\app\classes\SigPrGlpBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrGlpBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\SigPrGlpBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigPrGlpBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\sigprglpbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprglp.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\classes\sigprglpbo.FXP") ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigprglp.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprglp_f8.txt")
QUIT
