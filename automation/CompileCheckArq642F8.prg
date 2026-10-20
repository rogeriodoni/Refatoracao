*-- Verificacao de compilacao da task642 (SigOpArq), Fase 8.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cSaida, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpArq.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpArqBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigoparq.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigoparq.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpArq.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpArq.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigoparqbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigoparqbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpArqBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpArqBO.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpArq.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpArq.err")
ENDIF
loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SigOpArqBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigOpArqBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigoparq.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigoparqbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) AND ;
        FILE("C:\4c\projeto\app\forms\operacionais\formsigoparq.FXP") AND ;
        FILE("C:\4c\projeto\app\classes\sigoparqbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_arq642_f8.txt")
QUIT
