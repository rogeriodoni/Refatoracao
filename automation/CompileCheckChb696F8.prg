*-- Verificacao de compilacao da task696 (SigOpChb), Fase 8 (Form + BO).
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cSaida, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpChb.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpChbBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigopchb.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigopchb.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpChb.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpChb.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopchbbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigopchbbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpChbBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpChbBO.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpChb.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpChb.err")
ENDIF
loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SigOpChbBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigOpChbBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigopchb.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigopchbbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) AND ;
   FILE("C:\4c\projeto\app\forms\operacionais\formsigopchb.FXP") AND ;
   FILE("C:\4c\projeto\app\classes\sigopchbbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_chb696_f8.txt")
QUIT
