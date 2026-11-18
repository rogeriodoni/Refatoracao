* CompilarF6SigOpSqn806.prg
* Compila FormSigOpSqn.prg, SigOpSqnBO.prg e textboxgridlookup.PRG (Fase 6)
* sem executar nada deles - so para provar sintaxe. A PROVA vem do arquivo
* de saida (_f6sqn_compile.txt), nao do exit code: .fxp nao prova execucao
* e exit=0 nao prova nada.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_cCel, loc_cOut, loc_cRel

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpSqnBO.prg"
loc_cCel  = "C:\4c\projeto\app\classes\textboxgridlookup.PRG"
loc_cOut  = "C:\4c\automation\_f6sqn_compile.txt"

COMPILE (loc_cCel)
COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cRel = "CEL   FXP=" + IIF(FILE(STRTRAN(loc_cCel, ".PRG", ".fxp")), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(STRTRAN(loc_cCel, ".PRG", ".err")), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(STRTRAN(loc_cCel, ".PRG", ".err"))
    loc_cRel = loc_cRel + FILETOSTR(STRTRAN(loc_cCel, ".PRG", ".err")) + CHR(13) + CHR(10)
ENDIF

loc_cRel = loc_cRel + "BO    FXP=" + IIF(FILE(STRTRAN(loc_cBO, ".prg", ".fxp")), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(STRTRAN(loc_cBO, ".prg", ".err")), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    loc_cRel = loc_cRel + FILETOSTR(STRTRAN(loc_cBO, ".prg", ".err")) + CHR(13) + CHR(10)
ENDIF

loc_cRel = loc_cRel + "FORM  FXP=" + IIF(FILE(STRTRAN(loc_cForm, ".prg", ".fxp")), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(STRTRAN(loc_cForm, ".prg", ".err")), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    loc_cRel = loc_cRel + FILETOSTR(STRTRAN(loc_cForm, ".prg", ".err")) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRel, loc_cOut)

QUIT
