* CompilarF6SigOpSts808.prg - Fase 6 da task808
* Compila FormSigOpSts.prg, SigOpStsBO.prg e textboxgridlookup.PRG sem
* executar nada deles - so para provar sintaxe. A PROVA vem do arquivo de
* saida (_f6sts_compile.txt), nao do exit code: .fxp nao prova execucao e
* exit=0 nao prova nada. O CONTROLE NEGATIVO no fim prova que o COMPILE
* desta sessao de fato gera .err quando ha erro de sintaxe.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_cCel, loc_cOut, loc_cRel, loc_cNeg

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpSts.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpStsBO.prg"
loc_cCel  = "C:\4c\projeto\app\classes\textboxgridlookup.PRG"
loc_cNeg  = "C:\4c\automation\_f6sts_negativo.prg"
loc_cOut  = "C:\4c\automation\_f6sts_compile.txt"

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

*-- Controle negativo: codigo com erro de sintaxe proposital
STRTOFILE("DEFINE CLASS XX_4c AS Custom" + CHR(13) + CHR(10) + ;
          "    PUBLIC PROCEDURE Zzz()" + CHR(13) + CHR(10) + ;
          "    ENDPROC" + CHR(13) + CHR(10) + ;
          "ENDDEFINE" + CHR(13) + CHR(10), loc_cNeg)
COMPILE (loc_cNeg)
loc_cRel = loc_cRel + "NEG   ERR=" + IIF(FILE(STRTRAN(loc_cNeg, ".prg", ".err")), "SIM", "NAO") + ;
           " (esperado SIM)" + CHR(13) + CHR(10)
IF FILE(STRTRAN(loc_cNeg, ".prg", ".err"))
    loc_cRel = loc_cRel + FILETOSTR(STRTRAN(loc_cNeg, ".prg", ".err")) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRel, loc_cOut)

QUIT
