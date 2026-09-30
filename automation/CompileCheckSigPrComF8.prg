*-- Verificacao de compilacao do par BO + Form da task593 (sigprcom), Fase 8.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm

loc_cBO   = "C:\4c\projeto\app\classes\sigprcomBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\classes\sigprcombo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprcombo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\cadastros\formsigprcom.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\cadastros\formsigprcom.FXP"
ENDIF

*-- COMPILE nao dispara excecao em erro de sintaxe: grava um .ERR ao lado do
*-- fonte. Apagar os .ERR antigos e LER os arquivos - esse eh o veredito.
IF FILE("C:\4c\projeto\app\classes\sigprcomBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigprcomBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\cadastros\Formsigprcom.err")
    DELETE FILE "C:\4c\projeto\app\forms\cadastros\Formsigprcom.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\sigprcomBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\sigprcomBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\cadastros\Formsigprcom.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\cadastros\Formsigprcom.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\sigprcombo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\cadastros\formsigprcom.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\classes\sigprcombo.FXP") ;
   AND FILE("C:\4c\projeto\app\forms\cadastros\formsigprcom.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprcom_f8.txt")
QUIT
