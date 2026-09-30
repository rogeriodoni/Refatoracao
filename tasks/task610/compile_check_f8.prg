SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lcBO, lcForm
lcOut = "C:\4c\tasks\task610\compile_f8.txt"
lcBO   = "C:\4c\projeto\app\classes\SigPrFemBO.prg"
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg"

IF FILE(FORCEEXT(lcBO, "FXP"))
    DELETE FILE (FORCEEXT(lcBO, "FXP"))
ENDIF
IF FILE(FORCEEXT(lcForm, "FXP"))
    DELETE FILE (FORCEEXT(lcForm, "FXP"))
ENDIF

STRTOFILE("== BO ==" + CHR(13) + CHR(10), lcOut)
COMPILE (lcBO)
IF FILE(FORCEEXT(lcBO, "ERR"))
    STRTOFILE(FILETOSTR(FORCEEXT(lcBO, "ERR")), lcOut, 1)
ELSE
    STRTOFILE("SEM ERROS" + CHR(13) + CHR(10), lcOut, 1)
ENDIF
STRTOFILE("FXP: " + TRANSFORM(FILE(FORCEEXT(lcBO, "FXP"))) + CHR(13) + CHR(10), lcOut, 1)

STRTOFILE("== FORM ==" + CHR(13) + CHR(10), lcOut, 1)
COMPILE (lcForm)
IF FILE(FORCEEXT(lcForm, "ERR"))
    STRTOFILE(FILETOSTR(FORCEEXT(lcForm, "ERR")), lcOut, 1)
ELSE
    STRTOFILE("SEM ERROS" + CHR(13) + CHR(10), lcOut, 1)
ENDIF
STRTOFILE("FXP: " + TRANSFORM(FILE(FORCEEXT(lcForm, "FXP"))) + CHR(13) + CHR(10), lcOut, 1)
QUIT
