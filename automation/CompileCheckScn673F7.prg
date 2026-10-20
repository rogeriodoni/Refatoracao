*-- Verificacao de compilacao da task673 (SigPrScn), Fase 7.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cSaida, loc_cErrForm, loc_cErrBO

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprscn.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprscn.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrScn.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrScn.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprscnbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprscnbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrScnBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrScnBO.err"
ENDIF

COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigPrScn.prg"
COMPILE "C:\4c\projeto\app\classes\SigPrScnBO.prg"

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrScn.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrScn.err")
ENDIF
loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SigPrScnBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigPrScnBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprscn.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigprscnbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) AND ;
        FILE("C:\4c\projeto\app\forms\operacionais\formsigprscn.FXP") AND ;
        FILE("C:\4c\projeto\app\classes\sigprscnbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_scn673_f7.txt")
QUIT
