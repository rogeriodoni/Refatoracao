SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
LOCAL loc_cPrg, loc_cFxp, loc_cErr
loc_cPrg = "C:\4c\projeto\app\forms\operacionais\Formsigoppro.prg"
loc_cFxp = "C:\4c\projeto\app\forms\operacionais\Formsigoppro.fxp"
loc_cErr = "C:\4c\projeto\app\forms\operacionais\Formsigoppro.err"
IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF
COMPILE (loc_cPrg)
LOCAL loc_cSaida
loc_cSaida = "FXP=" + IIF(FILE(loc_cFxp), "OK", "AUSENTE") + CHR(13) + CHR(10)
IF FILE(loc_cErr)
    loc_cSaida = loc_cSaida + "ERR:" + CHR(13) + CHR(10) + FILETOSTR(loc_cErr)
ELSE
    loc_cSaida = loc_cSaida + "ERR: nenhum"
ENDIF
STRTOFILE(loc_cSaida, "C:\4c\automation\compilar_f7_sigoppro790_final.txt")
QUIT
