*-- Verificacao de compilacao da task644 (SigOpAut), Fase 8.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cSaida, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpAut.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpAutBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigopaut.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigopaut.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpAut.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpAut.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopautbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigopautbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpAutBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpAutBO.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpAut.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpAut.err")
ENDIF
loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SigOpAutBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigOpAutBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigopaut.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigopautbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) AND ;
        FILE("C:\4c\projeto\app\forms\operacionais\formsigopaut.FXP") AND ;
        FILE("C:\4c\projeto\app\classes\sigopautbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_aut644_f8.txt")
QUIT
