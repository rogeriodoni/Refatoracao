*-- Compila FormSigOpRef.prg e SigOpRefBO.prg e grava o resultado num .txt
*-- (prova por arquivo de saida, nao por exit code).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, lnI, lcPrg, lcFxp, lcErr
LOCAL ARRAY laPrg[2]
laPrg[1] = "C:\4c\projeto\app\forms\operacionais\FormSigOpRef.prg"
laPrg[2] = "C:\4c\projeto\app\classes\SigOpRefBO.prg"

lcSaida = ""

FOR lnI = 1 TO ALEN(laPrg)
    lcPrg = laPrg[lnI]
    lcFxp = FORCEEXT(lcPrg, "fxp")
    lcErr = FORCEEXT(lcPrg, "err")

    IF FILE(lcFxp)
        ERASE (lcFxp)
    ENDIF
    IF FILE(lcErr)
        ERASE (lcErr)
    ENDIF

    COMPILE (lcPrg)

    lcSaida = lcSaida + JUSTFNAME(lcPrg) + ;
        " | FXP=" + IIF(FILE(lcFxp), "SIM", "NAO") + ;
        " | ERR=" + IIF(FILE(lcErr), "SIM", "NAO") + CHR(13) + CHR(10)

    IF FILE(lcErr)
        lcSaida = lcSaida + FILETOSTR(lcErr) + CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(lcSaida, "C:\4c\automation\_f7_compile.txt")
QUIT
