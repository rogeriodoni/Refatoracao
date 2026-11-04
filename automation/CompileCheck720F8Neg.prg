SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut, lcPrg, lcErr, lcFxp
lcPrg = "C:\Users\roger\AppData\Local\Temp\NegCtl720.prg"
lcErr = "C:\Users\roger\AppData\Local\Temp\NegCtl720.err"
lcFxp = "C:\Users\roger\AppData\Local\Temp\NegCtl720.fxp"
IF FILE(lcErr)
    DELETE FILE (lcErr)
ENDIF
IF FILE(lcFxp)
    DELETE FILE (lcFxp)
ENDIF
COMPILE (lcPrg)
lcOut = "ERR_EXISTE=" + TRANSFORM(FILE(lcErr)) + CHR(13) + CHR(10)
IF FILE(lcErr)
    lcOut = lcOut + "--- ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcErr)
ENDIF
STRTOFILE(lcOut, "C:\4c\automation\compile720f8neg.txt")
QUIT
