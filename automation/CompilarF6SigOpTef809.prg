* CompilarF6SigOpTef809.prg
* Compila Formsigoptef.prg e sigoptefBO.prg (Fase 6/8 da task809) sem
* executar nada deles - so para provar sintaxe. A PROVA vem do arquivo de
* saida (_f6tef_compile.txt), nao do exit code: .fxp nao prova execucao e
* exit = 0 nao prova nada. Os .fxp/.err antigos sao APAGADOS antes, senao
* um .fxp velho faz o teste rodar codigo que nao existe mais.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_cOut, loc_cRel

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigoptef.prg"
loc_cBO   = "C:\4c\projeto\app\classes\sigoptefBO.prg"
loc_cOut  = "C:\4c\automation\_f6tef_compile.txt"

ERASE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ERASE (STRTRAN(loc_cForm, ".prg", ".err"))
ERASE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ERASE (STRTRAN(loc_cBO, ".prg", ".err"))

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
