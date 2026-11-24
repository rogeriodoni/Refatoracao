* CompilarF5SigOpZom822.prg
* Compila SigOpZomBO.prg + FormSigOpZom.prg (Fase 5 da task822) sem executar
* nada - so para provar sintaxe. A PROVA vem do arquivo de saida
* (_f5zom822_compile.txt): .fxp nao prova execucao e exit=0 nao prova nada.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cBO, loc_cForm, loc_cOut, loc_cRel
LOCAL loc_cBOFxp, loc_cBOErr, loc_cFormFxp, loc_cFormErr

loc_cBO      = "C:\4c\projeto\app\classes\SigOpZomBO.prg"
loc_cBOFxp   = "C:\4c\projeto\app\classes\SigOpZomBO.fxp"
loc_cBOErr   = "C:\4c\projeto\app\classes\SigOpZomBO.err"

loc_cForm    = "C:\4c\projeto\app\forms\operacionais\FormSigOpZom.prg"
loc_cFormFxp = "C:\4c\projeto\app\forms\operacionais\FormSigOpZom.fxp"
loc_cFormErr = "C:\4c\projeto\app\forms\operacionais\FormSigOpZom.err"

loc_cOut = "C:\4c\automation\_f5zom822_compile.txt"

IF FILE(loc_cBOFxp)
    DELETE FILE (loc_cBOFxp)
ENDIF
IF FILE(loc_cBOErr)
    DELETE FILE (loc_cBOErr)
ENDIF
IF FILE(loc_cFormFxp)
    DELETE FILE (loc_cFormFxp)
ENDIF
IF FILE(loc_cFormErr)
    DELETE FILE (loc_cFormErr)
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cRel = "BO   FXP=" + IIF(FILE(loc_cBOFxp), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(loc_cBOErr), "SIM", "NAO") + CHR(13) + CHR(10) + ;
           "FORM FXP=" + IIF(FILE(loc_cFormFxp), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(loc_cFormErr), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(loc_cBOErr)
    loc_cRel = loc_cRel + "--- BO ERR ---" + CHR(13) + CHR(10) + FILETOSTR(loc_cBOErr) + CHR(13) + CHR(10)
ENDIF
IF FILE(loc_cFormErr)
    loc_cRel = loc_cRel + "--- FORM ERR ---" + CHR(13) + CHR(10) + FILETOSTR(loc_cFormErr) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRel, loc_cOut)

QUIT
