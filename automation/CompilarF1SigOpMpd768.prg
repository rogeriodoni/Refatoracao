* CompilarF1SigOpMpd768.prg
* Compila SigOpMpdBO.prg (Fase 1) sem executar - so para provar sintaxe.
* Grava prova em arquivo (nao confiar em exit code - ver memoria vfp9smoketest).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cBO, loc_cFxp, loc_cErr, loc_cRelatorio, loc_cTexto
loc_cBO  = "C:\4c\projeto\app\classes\SigOpMpdBO.prg"
loc_cFxp = STRTRAN(loc_cBO, ".prg", ".fxp")
loc_cErr = STRTRAN(loc_cBO, ".prg", ".err")
loc_cRelatorio = "C:\4c\automation\compila768_resultado.txt"

IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF

COMPILE (loc_cBO)

loc_cTexto = "FXP_EXISTE=" + TRANSFORM(FILE(loc_cFxp)) + CHR(13) + ;
             "ERR_EXISTE=" + TRANSFORM(FILE(loc_cErr)) + CHR(13)

IF FILE(loc_cErr)
    loc_cTexto = loc_cTexto + "ERR_CONTEUDO=" + CHR(13) + FILETOSTR(loc_cErr)
ENDIF

STRTOFILE(loc_cTexto, loc_cRelatorio)

QUIT
