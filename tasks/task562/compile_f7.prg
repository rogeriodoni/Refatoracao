SET SAFETY OFF
SET RESOURCE OFF
SET CONSOLE OFF
LOCAL lcSrc, lcErr
lcSrc = "C:\4c\projeto\app\forms\operacionais\FormSigMvChv.prg"
lcErr = "C:\4c\tasks\task562\compile_f7.err"
IF FILE(STRTRAN(lcSrc, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(lcSrc, ".prg", ".fxp"))
ENDIF
COMPILE (lcSrc)
IF FILE(lcErr)
    STRTOFILE("ERROS:" + CHR(13) + FILETOSTR(lcErr), "C:\4c\tasks\task562\compile_f7.txt")
ELSE
    STRTOFILE("SEM ERROS. FXP=" + IIF(FILE(STRTRAN(lcSrc,".prg",".fxp")), "GERADO", "AUSENTE"), "C:\4c\tasks\task562\compile_f7.txt")
ENDIF
QUIT
