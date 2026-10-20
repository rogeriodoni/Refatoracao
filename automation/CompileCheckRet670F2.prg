*-- Verificacao de compilacao da task670 (SigPrRet), Fase 2.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cSaida, loc_cErrBO

loc_cBO = "C:\4c\projeto\app\classes\SigPrRetBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\classes\sigprretbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprretbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrRetBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrRetBO.err"
ENDIF

COMPILE (loc_cBO)

loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SigPrRetBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigPrRetBO.err")
ENDIF

loc_cSaida = "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigprretbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND FILE("C:\4c\projeto\app\classes\sigprretbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_ret670_f2.txt")
QUIT
