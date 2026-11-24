* CompilarF1SigOpZom822.prg
* Compila SigOpZomBO.prg (Fase 1 da task822) sem executar nada - so para
* provar sintaxe. A PROVA vem do arquivo de saida (_f1zom822_compile.txt): .fxp
* nao prova execucao e exit=0 nao prova nada.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cBO, loc_cOut, loc_cRel, loc_cFxp, loc_cErr

loc_cBO  = "C:\4c\projeto\app\classes\SigOpZomBO.prg"
loc_cFxp = "C:\4c\projeto\app\classes\SigOpZomBO.fxp"
loc_cErr = "C:\4c\projeto\app\classes\SigOpZomBO.err"
loc_cOut = "C:\4c\automation\_f1zom822_compile.txt"

IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF

COMPILE (loc_cBO)

loc_cRel = "BO FXP=" + IIF(FILE(loc_cFxp), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(loc_cErr), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(loc_cErr)
    loc_cRel = loc_cRel + FILETOSTR(loc_cErr) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRel, loc_cOut)

QUIT
