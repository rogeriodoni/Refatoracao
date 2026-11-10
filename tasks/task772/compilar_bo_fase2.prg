*-- Compila o BO da Fase 2 e grava o resultado num .txt (execucao unattended)
SET SAFETY OFF
SET RESOURCE OFF
SET CONSOLE OFF

LOCAL loc_cPrg, loc_cFxp, loc_cErr, loc_cLog, loc_cSaida

loc_cPrg = "C:\4c\projeto\app\classes\SIGOPNOPBO.prg"
loc_cFxp = "C:\4c\projeto\app\classes\SIGOPNOPBO.fxp"
loc_cErr = "C:\4c\projeto\app\classes\SIGOPNOPBO.err"
loc_cLog = "C:\4c\tasks\task772\compilar_bo_fase2_resultado.txt"

*-- .fxp/.err antigos fariam o teste medir compilacao anterior
IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF

COMPILE (loc_cPrg)

loc_cSaida = "PRG     : " + loc_cPrg + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "FXP     : " + IIF(FILE(loc_cFxp), "GERADO (" + TRANSFORM(FDATE(loc_cFxp)) + " " + FTIME(loc_cFxp) + ")", "AUSENTE") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "ERROS   : " + TRANSFORM(_TALLY) + CHR(13) + CHR(10)

IF FILE(loc_cErr) AND FSIZE(loc_cErr) > 0
    loc_cSaida = loc_cSaida + "--- CONTEUDO DO .ERR ---" + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + FILETOSTR(loc_cErr)
ELSE
    loc_cSaida = loc_cSaida + "ERR     : vazio/ausente = COMPILACAO SEM ERRO" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida, loc_cLog)

QUIT
