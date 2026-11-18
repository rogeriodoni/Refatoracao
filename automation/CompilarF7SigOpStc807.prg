* CompilarF7SigOpStc807.prg
* Compila FormSIGOPSTC.prg (Fase 7) sem executar nada - so para provar
* sintaxe. A PROVA vem do arquivo de saida (_f7stc_compile.txt), nao do
* exit code: .fxp nao prova execucao e exit=0 nao prova nada.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cOut, loc_cRel

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPSTC.prg"
loc_cOut  = "C:\4c\automation\_f7stc_compile.txt"

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    ERASE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    ERASE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF

COMPILE (loc_cForm)

loc_cRel = "FORM  FXP=" + IIF(FILE(STRTRAN(loc_cForm, ".prg", ".fxp")), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(STRTRAN(loc_cForm, ".prg", ".err")), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    loc_cRel = loc_cRel + FILETOSTR(STRTRAN(loc_cForm, ".prg", ".err")) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRel, loc_cOut)

QUIT
