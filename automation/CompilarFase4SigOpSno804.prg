* CompilarFase4SigOpSno804.prg
* Compila SigOpSnoBO.prg e FormSigOpSno.prg (Fase 4) sem executar - so sintaxe.
* Uso: vfp9.exe -t "C:\4c\automation\CompilarFase4SigOpSno804.prg"
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_aArquivos[2], loc_i, loc_cArquivo, loc_cFxp, loc_cErr

loc_aArquivos[1] = "C:\4c\projeto\app\classes\SigOpSnoBO.prg"
loc_aArquivos[2] = "C:\4c\projeto\app\forms\operacionais\FormSigOpSno.prg"

FOR loc_i = 1 TO 2
    loc_cArquivo = loc_aArquivos[loc_i]
    loc_cFxp = STRTRAN(loc_cArquivo, ".prg", ".fxp")
    loc_cErr = STRTRAN(loc_cArquivo, ".prg", ".err")

    IF FILE(loc_cFxp)
        DELETE FILE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        DELETE FILE (loc_cErr)
    ENDIF

    COMPILE (loc_cArquivo)
ENDFOR

QUIT
