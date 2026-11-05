*-- Compila Formsigopftc.prg + sigopftcBO.prg (Fase 8 - task737) e grava o
*-- resultado em texto.
*-- SET SAFETY/RESOURCE OFF: o pipeline roda sem supervisao (regra #6).
SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcTxt, lnI, lcPrg, lcFxp, lcErr
LOCAL ARRAY laPrg[2]

laPrg[1] = "C:\4c\projeto\app\forms\operacionais\Formsigopftc.prg"
laPrg[2] = "C:\4c\projeto\app\classes\sigopftcBO.prg"

lcTxt = ""

FOR lnI = 1 TO ALEN(laPrg)
    lcPrg = laPrg[lnI]
    lcFxp = STRTRAN(UPPER(lcPrg), ".PRG", ".FXP")
    lcErr = STRTRAN(UPPER(lcPrg), ".PRG", ".ERR")

    *-- COMPILE pode NAO reescrever um .fxp existente - apagar antes e conferir
    *-- o timestamp depois, senao o teste roda codigo velho (regra #29 / nota).
    IF FILE(lcFxp)
        ERASE (lcFxp)
    ENDIF
    IF FILE(lcErr)
        ERASE (lcErr)
    ENDIF

    COMPILE (lcPrg)

    lcTxt = lcTxt + "ARQUIVO: " + lcPrg + CHR(13) + CHR(10)
    lcTxt = lcTxt + "  ERROS: " + TRANSFORM(_TALLY) + CHR(13) + CHR(10)
    lcTxt = lcTxt + "  FXP  : " + IIF(FILE(lcFxp), "SIM - " + TTOC(FDATE(lcFxp, 1)), "NAO") + CHR(13) + CHR(10)

    IF FILE(lcErr)
        lcTxt = lcTxt + "  --- ERR ---" + CHR(13) + CHR(10) + ;
                FILETOSTR(lcErr) + CHR(13) + CHR(10)
    ELSE
        lcTxt = lcTxt + "  SEM ARQUIVO .ERR (compilacao limpa)" + CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(lcTxt, "C:\4c\automation\_f8_737_compilacao.txt")
QUIT
