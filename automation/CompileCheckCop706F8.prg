SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
LOCAL lcOut, lcErr
lcOut = "C:\4c\automation\CompileCheckCop706F8.out"
lcErr = "C:\4c\automation\CompileCheckCop706F8.err"
IF FILE(lcErr)
    ERASE (lcErr)
ENDIF
STRTOFILE("", lcOut)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCop.fxp")
    ERASE "C:\4c\projeto\app\forms\operacionais\FormSigOpCop.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpCopBO.fxp")
    ERASE "C:\4c\projeto\app\classes\SigOpCopBO.fxp"
ENDIF
COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigOpCop.prg"
COMPILE "C:\4c\projeto\app\classes\SigOpCopBO.prg"
LOCAL lcTxt
lcTxt = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCop.err")
    lcTxt = lcTxt + "FORM ERR:" + CHR(13) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpCop.err") + CHR(13)
ELSE
    lcTxt = lcTxt + "FORM ERR: (nenhum)" + CHR(13)
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpCopBO.err")
    lcTxt = lcTxt + "BO ERR:" + CHR(13) + FILETOSTR("C:\4c\projeto\app\classes\SigOpCopBO.err") + CHR(13)
ELSE
    lcTxt = lcTxt + "BO ERR: (nenhum)" + CHR(13)
ENDIF
lcTxt = lcTxt + "FORM FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCop.fxp"), "SIM", "NAO") + CHR(13)
lcTxt = lcTxt + "BO   FXP=" + IIF(FILE("C:\4c\projeto\app\classes\SigOpCopBO.fxp"), "SIM", "NAO") + CHR(13)
STRTOFILE(lcTxt, lcOut)
QUIT
