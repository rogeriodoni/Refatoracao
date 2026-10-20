*-- Verificacao de compilacao do BO da task664 (sigprpdf), Fase 2.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cFXP, loc_cERR, loc_cSaida, loc_cErrBO

loc_cBO  = "C:\4c\projeto\app\classes\sigprpdfBO.prg"
loc_cFXP = "C:\4c\projeto\app\classes\sigprpdfbo.FXP"
loc_cERR = "C:\4c\projeto\app\classes\sigprpdfBO.err"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE(loc_cFXP)
    DELETE FILE (loc_cFXP)
ENDIF

*-- COMPILE nao dispara excecao em erro de sintaxe: grava um .ERR ao lado do
*-- fonte. Apagar o .ERR antigo e LER o arquivo - esse eh o veredito.
IF FILE(loc_cERR)
    DELETE FILE (loc_cERR)
ENDIF

COMPILE (loc_cBO)

loc_cErrBO = ""
IF FILE(loc_cERR)
    loc_cErrBO = FILETOSTR(loc_cERR)
ENDIF

loc_cSaida = "FXP_BO=" + IIF(FILE(loc_cFXP), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND FILE(loc_cFXP)
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigprpdf664f2.txt")
QUIT
