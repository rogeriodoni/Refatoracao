* CompilarF5SigOpMop767.prg
* Compila TextBoxGridLookup.prg + FormSigOpMop.prg (Fase 5) sem executar -
* so para provar sintaxe das celulas customizadas de Movimentacao/Cores.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_aArquivos[2], loc_nI, loc_cArq, loc_cFxp, loc_cErr

loc_aArquivos[1] = "C:\4c\projeto\app\classes\TextBoxGridLookup.prg"
loc_aArquivos[2] = "C:\4c\projeto\app\forms\operacionais\FormSigOpMop.prg"

FOR loc_nI = 1 TO ALEN(loc_aArquivos)
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
ENDFOR

QUIT
