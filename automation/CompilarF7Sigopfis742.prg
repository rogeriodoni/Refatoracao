SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcForm, lcFxp, lcSaida
lcForm = "C:\4c\projeto\app\forms\operacionais\Formsigopfis.prg"
lcFxp  = "C:\4c\projeto\app\forms\operacionais\formsigopfis.FXP"
IF FILE(lcFxp)
    DELETE FILE (lcFxp)
ENDIF
COMPILE (lcForm)
lcSaida = "FXP existe: " + IIF(FILE(lcFxp), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopfis.err")
    lcSaida = lcSaida + "ERROS:" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigopfis.err")
ELSE
    lcSaida = lcSaida + "Sem arquivo .err - compilacao limpa"
ENDIF
STRTOFILE(lcSaida, "C:\4c\automation\_resultado_compilaf7_742.txt")
QUIT
