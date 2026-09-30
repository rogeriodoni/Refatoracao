*-- Verificacao de compilacao do par BO + Form da task580 (SigMvTta).
*-- SET SAFETY/RESOURCE OFF obrigatorios: o pipeline roda sem supervisao e
*-- qualquer dialogo modal o trava indefinidamente (CLAUDE.md regra #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm

loc_cBO   = "C:\4c\projeto\app\classes\SigMvTtaBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigMvTta.prg"

*-- COMPILE pode NAO reescrever um .fxp que ja existe: apagar antes e
*-- conferir a recriacao, senao o teste valida codigo VELHO (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\classes\sigmvttabo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigmvttabo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigmvtta.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigmvtta.FXP"
ENDIF

*-- COMPILE nao dispara excecao em erro de sintaxe: ele grava um .ERR ao
*-- lado do fonte. Apagar os .ERR antigos para nao ler resultado de rodada
*-- anterior, e depois LER os arquivos - e' esse o veredito, nao o CATCH.
IF FILE("C:\4c\projeto\app\classes\SigMvTtaBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigMvTtaBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigMvTta.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigMvTta.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\SigMvTtaBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigMvTtaBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigMvTta.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigMvTta.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\sigmvttabo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigmvtta.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\classes\sigmvttabo.FXP") ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigmvtta.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_tta.txt")
QUIT
