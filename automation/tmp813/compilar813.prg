SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcPrg, lcFxp, lcErr, lcSaida, lcTexto

lcPrg = "C:\4c\projeto\app\classes\SigOpTotBO.prg"
lcFxp = "C:\4c\projeto\app\classes\SigOpTotBO.fxp"
lcErr = "C:\4c\projeto\app\classes\SigOpTotBO.err"
lcSaida = "C:\4c\automation\tmp813\compilar813_saida.txt"

IF FILE(lcFxp)
    DELETE FILE (lcFxp)
ENDIF
IF FILE(lcErr)
    DELETE FILE (lcErr)
ENDIF

COMPILE (lcPrg)

lcTexto = "PRG     = " + lcPrg + CHR(13) + CHR(10)
lcTexto = lcTexto + "FXP     = " + IIF(FILE(lcFxp), "SIM", "NAO") + CHR(13) + CHR(10)
lcTexto = lcTexto + "ERR     = " + IIF(FILE(lcErr), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(lcErr)
    lcTexto = lcTexto + "--- CONTEUDO DO .ERR ---" + CHR(13) + CHR(10)
    lcTexto = lcTexto + FILETOSTR(lcErr) + CHR(13) + CHR(10)
ELSE
    lcTexto = lcTexto + "--- COMPILACAO LIMPA (nenhum .err gerado) ---" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcTexto, lcSaida)

QUIT
