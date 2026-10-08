SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog
lcLog = "C:\4c\automation\logs\ibb_fase8_compile.txt"
IF FILE(lcLog)
    DELETE FILE (lcLog)
ENDIF

LOCAL ARRAY laFiles[3]
laFiles[1] = "C:\4c\projeto\app\classes\SigPrIbbBO.prg"
laFiles[2] = "C:\4c\projeto\app\forms\operacionais\FormSigPrIbb.prg"
laFiles[3] = "C:\4c\projeto\app\menu\menu.prg"

LOCAL i, lcPrg, lcFxp, lcErr, lcResult
lcResult = ""

FOR i = 1 TO 3
    lcPrg = laFiles[i]
    lcFxp = STRTRAN(lcPrg, ".prg", ".fxp")
    lcErr = STRTRAN(lcPrg, ".prg", ".err")

    IF FILE(lcFxp)
        DELETE FILE (lcFxp)
    ENDIF
    IF FILE(lcErr)
        DELETE FILE (lcErr)
    ENDIF

    COMPILE (lcPrg)

    IF FILE(lcErr)
        lcResult = lcResult + lcPrg + " -> ERROS:" + CHR(13) + CHR(10) + FILETOSTR(lcErr) + CHR(13) + CHR(10)
    ELSE
        lcResult = lcResult + lcPrg + " -> OK (FXP gerado: " + TRANSFORM(FILE(lcFxp)) + ")" + CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(lcResult, lcLog)
QUIT
