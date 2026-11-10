* CompilarF6SigOpOca773.prg
* Compila FormSigOpOca.prg (Fase 6) sem executar - so para provar sintaxe.
* Grava prova em arquivo (nao confiar em exit code - ver memoria vfp9smoketest).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cFxp, loc_cErr, loc_cRelatorio, loc_cTexto
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpOca.prg"
loc_cFxp  = STRTRAN(loc_cForm, ".prg", ".fxp")
loc_cErr  = STRTRAN(loc_cForm, ".prg", ".err")
loc_cRelatorio = "C:\4c\automation\compila773_f6_resultado.txt"

IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF

COMPILE (loc_cForm)

loc_cTexto = "SMOKE=EXECUTOU" + CHR(13) + ;
             "FXP_EXISTE=" + TRANSFORM(FILE(loc_cFxp)) + CHR(13) + ;
             "ERR_EXISTE=" + TRANSFORM(FILE(loc_cErr)) + CHR(13)

IF FILE(loc_cErr)
    loc_cTexto = loc_cTexto + "ERR_CONTEUDO=" + CHR(13) + FILETOSTR(loc_cErr)
ENDIF

STRTOFILE(loc_cTexto, loc_cRelatorio)

QUIT
