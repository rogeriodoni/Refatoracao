SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcOut, lcForm, lcBO, lcErrF, lcErrB, lcTxt

lcOut  = "C:\4c\automation\compilecheck731f5.txt"
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.prg"
lcBO   = "C:\4c\projeto\app\classes\SigOpEntBO.prg"
lcErrF = "C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.err"
lcErrB = "C:\4c\projeto\app\classes\SigOpEntBO.err"

*-- Apaga .fxp/.err ANTES: COMPILE pode NAO reescrever .fxp existente
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpEntBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpEntBO.fxp"
ENDIF
IF FILE(lcErrF)
    DELETE FILE (lcErrF)
ENDIF
IF FILE(lcErrB)
    DELETE FILE (lcErrB)
ENDIF

COMPILE (lcForm)
COMPILE (lcBO)

lcTxt = "FORM .fxp = " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.fxp")) + CHR(13) + CHR(10) + ;
        "FORM .err = " + TRANSFORM(FILE(lcErrF)) + CHR(13) + CHR(10) + ;
        "BO   .fxp = " + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpEntBO.fxp")) + CHR(13) + CHR(10) + ;
        "BO   .err = " + TRANSFORM(FILE(lcErrB)) + CHR(13) + CHR(10)

IF FILE(lcErrF)
    lcTxt = lcTxt + "--- ERR DO FORM ---" + CHR(13) + CHR(10) + FILETOSTR(lcErrF) + CHR(13) + CHR(10)
ENDIF
IF FILE(lcErrB)
    lcTxt = lcTxt + "--- ERR DO BO ---" + CHR(13) + CHR(10) + FILETOSTR(lcErrB) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcTxt, lcOut)
QUIT
