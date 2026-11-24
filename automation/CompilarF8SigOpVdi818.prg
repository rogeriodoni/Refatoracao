* CompilarF8SigOpVdi818.prg
* Compila FormSigOpVdi.prg, SigOpVdiBO.prg e menu.prg (task818, Fase 8) sem executar.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_aArquivos[3], loc_nI, loc_cArq, loc_cFxp, loc_cErr

loc_aArquivos[1] = "C:\4c\projeto\app\classes\SigOpVdiBO.prg"
loc_aArquivos[2] = "C:\4c\projeto\app\forms\operacionais\FormSigOpVdi.prg"
loc_aArquivos[3] = "C:\4c\projeto\app\menu\menu.prg"

FOR loc_nI = 1 TO 3
    loc_cArq = loc_aArquivos[loc_nI]
    loc_cFxp = STRTRAN(loc_cArq, ".prg", ".fxp")
    loc_cErr = STRTRAN(loc_cArq, ".prg", ".err")

    IF FILE(loc_cFxp)
        DELETE FILE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        DELETE FILE (loc_cErr)
    ENDIF

    COMPILE (loc_cArq)

    IF FILE(loc_cFxp)
        ? "OK: " + loc_cArq
    ELSE
        ? "FALHOU: " + loc_cArq
    ENDIF
ENDFOR

QUIT
