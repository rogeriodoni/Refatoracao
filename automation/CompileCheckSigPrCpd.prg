*-- Verificacao de compilacao do BO da task595 (sigprcpd), Fase 2.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cSaida, loc_cErrBO

loc_cBO = "C:\4c\projeto\app\classes\sigprcpdBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\classes\sigprcpdbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigprcpdbo.FXP"
ENDIF

*-- COMPILE nao dispara excecao em erro de sintaxe: grava um .ERR ao lado do
*-- fonte. Apagar o .ERR antigo e LER o arquivo - esse eh o veredito.
IF FILE("C:\4c\projeto\app\classes\sigprcpdBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigprcpdBO.err"
ENDIF

COMPILE (loc_cBO)

loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\sigprcpdBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\sigprcpdBO.err")
ENDIF

loc_cSaida = "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigprcpdbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND FILE("C:\4c\projeto\app\classes\sigprcpdbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprcpd.txt")
QUIT
