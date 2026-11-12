* CompilarF4SigOpPcu777.prg
* Compila FormSigOpPcu.prg (Fase 4) sem executar o form - so para provar sintaxe.
* Grava o resultado em _CompilarF4SigOpPcu777.txt (FXP/ERR + conteudo do .err),
* porque .FXP presente NAO prova que este script rodou.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cFxp, loc_cErr, loc_cSaida

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpPcu.prg"
loc_cFxp  = STRTRAN(loc_cForm, ".prg", ".fxp")
loc_cErr  = STRTRAN(loc_cForm, ".prg", ".err")

IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF

COMPILE (loc_cForm)

loc_cSaida = "FXP=" + IIF(FILE(loc_cFxp), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR=" + IIF(FILE(loc_cErr), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(loc_cErr)
    loc_cSaida = loc_cSaida + FILETOSTR(loc_cErr)
ENDIF
STRTOFILE(loc_cSaida, "C:\4c\automation\_CompilarF4SigOpPcu777.txt")

QUIT