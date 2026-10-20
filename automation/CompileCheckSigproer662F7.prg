*-- Verificacao de compilacao de Formsigproer + sigproerBO (task662, Fase 7).
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cErrForm, loc_cErrBO, loc_cSaida

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigproer.prg"
loc_cBO   = "C:\4c\projeto\app\classes\sigproerBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigproer.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigproer.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigproer.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigproer.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigproerbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigproerbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigproerBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigproerBO.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigproer.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigproer.err")
ENDIF

loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\sigproerBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\sigproerBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigproer.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigproerbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigproer.FXP") ;
   AND FILE("C:\4c\projeto\app\classes\sigproerbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FALHOU"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\resultado_sigproer662_f7.txt")
QUIT
