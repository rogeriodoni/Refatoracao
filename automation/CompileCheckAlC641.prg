*-- Verificacao de compilacao do BO da task641 (SigOpAlC), Fase 2.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cSaida, loc_cErrBO

loc_cBO = "C:\4c\projeto\app\classes\SigOpAlCBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\classes\sigopalcbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigopalcbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpAlCBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpAlCBO.err"
ENDIF

COMPILE (loc_cBO)

loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SigOpAlCBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigOpAlCBO.err")
ENDIF

loc_cSaida = "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigopalcbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND FILE("C:\4c\projeto\app\classes\sigopalcbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_alc641.txt")
QUIT
