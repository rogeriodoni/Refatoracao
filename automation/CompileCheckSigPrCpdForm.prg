*-- Verificacao de compilacao do Form da task595 (sigprcpd), Fase 6.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cSaida, loc_cErr

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg"

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.FXP"
ENDIF

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err"
ENDIF

COMPILE (loc_cForm)

loc_cErr = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
    loc_cErr = FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErr) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErr)) AND FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprcpd_form.txt")
QUIT
