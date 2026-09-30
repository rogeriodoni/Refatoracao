SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
LOCAL lcForm, lcFxp, lcErrFile, lcSaida
lcForm    = "C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg"
lcFxp     = "C:\4c\projeto\app\forms\operacionais\Formsigprccp.FXP"
lcErrFile = "C:\4c\projeto\app\forms\operacionais\Formsigprccp.err"
IF FILE(lcFxp)
    DELETE FILE (lcFxp)
ENDIF
IF FILE(lcErrFile)
    DELETE FILE (lcErrFile)
ENDIF
COMPILE (lcForm)
lcSaida = "FXP: " + IIF(FILE(lcFxp), "OK", "AUSENTE") + CHR(13) + CHR(10) + ;
          "ERR: " + IIF(FILE(lcErrFile), FILETOSTR(lcErrFile), "nenhum") + CHR(13) + CHR(10)
STRTOFILE(lcSaida, "C:\4c\automation\compile_ccpf8_result.txt")
QUIT
