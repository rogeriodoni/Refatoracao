SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcPrg, lcFxp, lcErr, lcS
lcPrg = "C:\4c\projeto\app\forms\cadastros\FormOET.prg"
lcFxp = "C:\4c\projeto\app\forms\cadastros\formoet.fxp"
lcErr = "C:\4c\projeto\app\forms\cadastros\formoet.err"
IF FILE(lcFxp)
    DELETE FILE (lcFxp)
ENDIF
IF FILE(lcErr)
    DELETE FILE (lcErr)
ENDIF
COMPILE (lcPrg)
lcS = "fxp gerado = " + TRANSFORM(FILE(lcFxp)) + CHR(13) + CHR(10)
IF FILE(lcErr)
    lcS = lcS + "--- ERROS ---" + CHR(13) + CHR(10) + FILETOSTR(lcErr)
ELSE
    lcS = lcS + "NENHUM .ERR"
ENDIF
STRTOFILE(lcS, "C:\4c\automation\compilar_erro303.txt")
QUIT
