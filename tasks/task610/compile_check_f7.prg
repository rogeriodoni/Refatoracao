*-- compile_check_f7.prg - compila SigPrFemBO.prg + FormSigPrFem.prg (Fase 7)
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBo, loc_cFrm, loc_cErrBo, loc_cErrFrm, loc_cOut, loc_cRes

loc_cBo     = "C:\4c\projeto\app\classes\SigPrFemBO.prg"
loc_cFrm    = "C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg"
loc_cErrBo  = "C:\4c\projeto\app\classes\SigPrFemBO.err"
loc_cErrFrm = "C:\4c\projeto\app\forms\operacionais\FormSigPrFem.err"
loc_cOut    = "C:\4c\tasks\task610\compile_f7.txt"

IF FILE(loc_cErrBo)
    ERASE (loc_cErrBo)
ENDIF
IF FILE(loc_cErrFrm)
    ERASE (loc_cErrFrm)
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrFemBO.fxp")
    ERASE ("C:\4c\projeto\app\classes\SigPrFemBO.fxp")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.fxp")
    ERASE ("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.fxp")
ENDIF

COMPILE (loc_cBo)
COMPILE (loc_cFrm)

loc_cRes = "== BO ==" + CHR(13) + CHR(10)
IF FILE(loc_cErrBo)
    loc_cRes = loc_cRes + "ERROS:" + CHR(13) + CHR(10) + FILETOSTR(loc_cErrBo)
ELSE
    loc_cRes = loc_cRes + "SEM ERROS" + CHR(13) + CHR(10)
ENDIF
loc_cRes = loc_cRes + "FXP: " + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigPrFemBO.fxp")) + CHR(13) + CHR(10)

loc_cRes = loc_cRes + "== FORM ==" + CHR(13) + CHR(10)
IF FILE(loc_cErrFrm)
    loc_cRes = loc_cRes + "ERROS:" + CHR(13) + CHR(10) + FILETOSTR(loc_cErrFrm)
ELSE
    loc_cRes = loc_cRes + "SEM ERROS" + CHR(13) + CHR(10)
ENDIF
loc_cRes = loc_cRes + "FXP: " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.fxp")) + CHR(13) + CHR(10)

STRTOFILE(loc_cRes, loc_cOut)

QUIT
