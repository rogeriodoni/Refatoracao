SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcForm, lcErr
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSIGMVCMV.prg"
lcErr  = "C:\4c\tasks\task563\compila_fase8.txt"
IF FILE(FORCEEXT(lcForm, "fxp"))
    DELETE FILE (FORCEEXT(lcForm, "fxp"))
ENDIF
STRTOFILE("INICIO" + CHR(13) + CHR(10), lcErr)
COMPILE (lcForm)
IF FILE(FORCEEXT(lcForm, "err"))
    STRTOFILE("ERRFILE:" + CHR(13) + CHR(10) + FILETOSTR(FORCEEXT(lcForm, "err")), lcErr, 1)
ELSE
    STRTOFILE("SEM .ERR" + CHR(13) + CHR(10), lcErr, 1)
ENDIF
STRTOFILE("FXP EXISTE: " + TRANSFORM(FILE(FORCEEXT(lcForm, "fxp"))) + CHR(13) + CHR(10), lcErr, 1)
QUIT
