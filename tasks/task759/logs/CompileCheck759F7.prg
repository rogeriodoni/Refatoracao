SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut, lcForm, lcBO, lcErrF, lcErrB
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpLhi.prg"
lcBO   = "C:\4c\projeto\app\classes\SigOpLhiBO.prg"
lcErrF = "C:\4c\projeto\app\forms\operacionais\FormSigOpLhi.err"
lcErrB = "C:\4c\projeto\app\classes\SigOpLhiBO.err"
IF FILE(lcErrF)
    ERASE (lcErrF)
ENDIF
IF FILE(lcErrB)
    ERASE (lcErrB)
ENDIF
COMPILE (lcForm)
COMPILE (lcBO)
lcOut = "FORM_FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpLhi.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "BO_FXP=" + IIF(FILE("C:\4c\projeto\app\classes\SigOpLhiBO.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "FORM_ERR=" + IIF(FILE(lcErrF), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "BO_ERR=" + IIF(FILE(lcErrB), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(lcErrF)
    lcOut = lcOut + "--- FORM ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcErrF) + CHR(13) + CHR(10)
ENDIF
IF FILE(lcErrB)
    lcOut = lcOut + "--- BO ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcErrB) + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcOut, "C:\4c\tasks\task759\logs\compile_check_759_f7.txt")
QUIT
