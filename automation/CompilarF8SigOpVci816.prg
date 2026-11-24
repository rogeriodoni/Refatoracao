* CompilarF8SigOpVci816.prg
* Compila Formsigopvci.prg e sigopvciBO.prg (task816) sem executar nada - so
* para provar sintaxe. A PROVA vem do arquivo de saida (_f8vci816_compile.txt).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_cOut, loc_cRel
LOCAL loc_cFormFxp, loc_cFormErr, loc_cBOFxp, loc_cBOErr

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigopvci.prg"
loc_cBO   = "C:\4c\projeto\app\classes\sigopvciBO.prg"

loc_cFormFxp = "C:\4c\projeto\app\forms\operacionais\Formsigopvci.fxp"
loc_cFormErr = "C:\4c\projeto\app\forms\operacionais\Formsigopvci.err"
loc_cBOFxp   = "C:\4c\projeto\app\classes\sigopvciBO.fxp"
loc_cBOErr   = "C:\4c\projeto\app\classes\sigopvciBO.err"

loc_cOut = "C:\4c\automation\_f8vci816_compile.txt"

IF FILE(loc_cFormFxp)
    DELETE FILE (loc_cFormFxp)
ENDIF
IF FILE(loc_cFormErr)
    DELETE FILE (loc_cFormErr)
ENDIF
IF FILE(loc_cBOFxp)
    DELETE FILE (loc_cBOFxp)
ENDIF
IF FILE(loc_cBOErr)
    DELETE FILE (loc_cBOErr)
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cRel = "BO   FXP=" + IIF(FILE(loc_cBOFxp), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(loc_cBOErr), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(loc_cBOErr)
    loc_cRel = loc_cRel + FILETOSTR(loc_cBOErr) + CHR(13) + CHR(10)
ENDIF

loc_cRel = loc_cRel + "FORM FXP=" + IIF(FILE(loc_cFormFxp), "SIM", "NAO") + ;
           " ERR=" + IIF(FILE(loc_cFormErr), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(loc_cFormErr)
    loc_cRel = loc_cRel + FILETOSTR(loc_cFormErr) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRel, loc_cOut)

QUIT
