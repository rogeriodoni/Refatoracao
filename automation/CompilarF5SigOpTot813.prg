* CompilarF5SigOpTot813.prg
* Compila FormSigOpTot.prg (Fase 5 da task813) sem executar nada - so para
* provar sintaxe. A PROVA vem do arquivo de saida (_f5tot_compile.txt): .fxp
* nao prova execucao e exit=0 nao prova nada.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cOut, loc_cRel, loc_cFxp, loc_cErr

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpTot.prg"
loc_cFxp  = "C:\4c\projeto\app\forms\operacionais\FormSigOpTot.fxp"
loc_cErr  = "C:\4c\projeto\app\forms\operacionais\FormSigOpTot.err"
loc_cOut  = "C:\4c\automation\_f5tot_compile.txt"

IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF

COMPILE (loc_cForm)

loc_cRel = "FORM FXP=" + IIF(FILE(loc_cFxp), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(loc_cErr), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(loc_cErr)
    loc_cRel = loc_cRel + FILETOSTR(loc_cErr) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRel, loc_cOut)

QUIT
