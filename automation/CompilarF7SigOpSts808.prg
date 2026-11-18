* CompilarF7SigOpSts808.prg
* Compila FormSigOpSts.prg e SigOpStsBO.prg (Fase 7) sem executar nada deles
* - so para provar sintaxe. A PROVA vem do arquivo de saida
* (_f7sts_compile.txt), nao do exit code: .fxp nao prova execucao e exit=0
* nao prova nada. Os .fxp/.err antigos sao apagados antes, senao o relatorio
* confirma compilado VELHO (COMPILE pode nao reescrever .fxp existente).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_cOut, loc_cRel

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpSts.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpStsBO.prg"
loc_cOut  = "C:\4c\automation\_f7sts_compile.txt"

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    ERASE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    ERASE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    ERASE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    ERASE (STRTRAN(loc_cBO, ".prg", ".err"))
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cRel = "BO    FXP=" + IIF(FILE(STRTRAN(loc_cBO, ".prg", ".fxp")), "SIM", "NAO") + ;
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
