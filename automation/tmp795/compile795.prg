SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcForm, lcFxp, lcErr, lcOut
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.prg"
lcFxp  = "C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.fxp"
lcErr  = "C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.err"
IF FILE(lcFxp)
    DELETE FILE (lcFxp)
ENDIF
IF FILE(lcErr)
    DELETE FILE (lcErr)
ENDIF
COMPILE (lcForm)
lcOut = "FXP=" + IIF(FILE(lcFxp), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "ERR=" + IIF(FILE(lcErr), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(lcErr)
    lcOut = lcOut + "--- CONTEUDO DO .ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcErr)
ENDIF
STRTOFILE(lcOut, "C:\4c\automation\tmp795\compile795_r1.txt")
QUIT
