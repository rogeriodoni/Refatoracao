*-- Verificacao de compilacao do Form + BO da task595 (sigprcpd), Fase 8 (final).
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cSaida, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg"
loc_cBO   = "C:\4c\projeto\app\classes\sigprcpdBO.prg"

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprcpdBO.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprcpdBO.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprcpdBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigprcpdBO.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\sigprcpdBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\sigprcpdBO.err")
ENDIF

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
ENDIF

loc_cSaida = "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigprcpdBO.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND FILE("C:\4c\projeto\app\classes\sigprcpdBO.FXP") ;
        AND EMPTY(ALLTRIM(loc_cErrForm)) AND FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprcpd_f8.txt")
QUIT
