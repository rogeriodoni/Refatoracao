SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcOut, lcForm, lcBO, lcFormFxp, lcFormErr, lcBoFxp, lcBoErr, lcTxt

lcOut  = "C:\4c\automation\compile717f4.txt"
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpCts.prg"
lcBO   = "C:\4c\projeto\app\classes\SigOpCtsBO.prg"

lcFormFxp = FORCEEXT(lcForm, "fxp")
lcFormErr = FORCEEXT(lcForm, "err")
lcBoFxp   = FORCEEXT(lcBO,   "fxp")
lcBoErr   = FORCEEXT(lcBO,   "err")

IF FILE(lcFormFxp)
    DELETE FILE (lcFormFxp)
ENDIF
IF FILE(lcFormErr)
    DELETE FILE (lcFormErr)
ENDIF
IF FILE(lcBoFxp)
    DELETE FILE (lcBoFxp)
ENDIF
IF FILE(lcBoErr)
    DELETE FILE (lcBoErr)
ENDIF

COMPILE (lcBO)
COMPILE (lcForm)

lcTxt = "BO.FXP="   + TRANSFORM(FILE(lcBoFxp))   + " BO.ERR="   + TRANSFORM(FILE(lcBoErr))   + CHR(13) + CHR(10) + ;
        "FORM.FXP=" + TRANSFORM(FILE(lcFormFxp)) + " FORM.ERR=" + TRANSFORM(FILE(lcFormErr)) + CHR(13) + CHR(10)

IF FILE(lcBoErr)
    lcTxt = lcTxt + "--- BO.ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcBoErr) + CHR(13) + CHR(10)
ENDIF
IF FILE(lcFormErr)
    lcTxt = lcTxt + "--- FORM.ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcFormErr) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcTxt, lcOut)
QUIT
