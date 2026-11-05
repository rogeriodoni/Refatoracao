*-- Compila Formsigopftc.prg (Fase 7 - task737) e grava o resultado em texto.
*-- SET SAFETY/RESOURCE OFF: o pipeline roda sem supervisao (regra #6).
SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcForm, lcFxp, lcSaida, lcTxt

lcForm = "C:\4c\projeto\app\forms\operacionais\Formsigopftc.prg"
lcFxp  = "C:\4c\projeto\app\forms\operacionais\Formsigopftc.fxp"
lcSaida = "C:\4c\automation\_f7_737_compilacao.txt"

*-- COMPILE pode NAO reescrever um .fxp existente - apagar antes e conferir o
*-- timestamp depois, senao o teste roda codigo velho (regra #29 / nota).
IF FILE(lcFxp)
    ERASE (lcFxp)
ENDIF

lcTxt = "ARQUIVO: " + lcForm + CHR(13) + CHR(10)
COMPILE (lcForm)

lcTxt = lcTxt + "ERROS: " + TRANSFORM(_TALLY) + CHR(13) + CHR(10)
lcTxt = lcTxt + "FXP GERADO: " + IIF(FILE(lcFxp), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(lcFxp)
    lcTxt = lcTxt + "FXP DATA: " + TTOC(FDATE(lcFxp, 1)) + CHR(13) + CHR(10)
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopftc.err")
    lcTxt = lcTxt + "--- ERR ---" + CHR(13) + CHR(10) + ;
            FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigopftc.err")
ELSE
    lcTxt = lcTxt + "SEM ARQUIVO .ERR (compilacao limpa)" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcTxt, lcSaida)
QUIT
