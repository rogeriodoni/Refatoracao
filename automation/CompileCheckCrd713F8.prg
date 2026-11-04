SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
LOCAL lcOut
lcOut = "C:\4c\automation\CompileCheckCrd713F8.out"
STRTOFILE("", lcOut)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.fxp")
    ERASE "C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpCrdBO.fxp")
    ERASE "C:\4c\projeto\app\classes\SigOpCrdBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.err")
    ERASE "C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpCrdBO.err")
    ERASE "C:\4c\projeto\app\classes\SigOpCrdBO.err"
ENDIF
COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.prg"
COMPILE "C:\4c\projeto\app\classes\SigOpCrdBO.prg"
LOCAL lcTxt
lcTxt = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.err")
    lcTxt = lcTxt + "FORM ERR:" + CHR(13) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.err") + CHR(13)
ELSE
    lcTxt = lcTxt + "FORM ERR: (nenhum)" + CHR(13)
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpCrdBO.err")
    lcTxt = lcTxt + "BO ERR:" + CHR(13) + FILETOSTR("C:\4c\projeto\app\classes\SigOpCrdBO.err") + CHR(13)
ELSE
    lcTxt = lcTxt + "BO ERR: (nenhum)" + CHR(13)
ENDIF
lcTxt = lcTxt + "FORM FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.fxp"), "SIM", "NAO") + CHR(13)
lcTxt = lcTxt + "BO   FXP=" + IIF(FILE("C:\4c\projeto\app\classes\SigOpCrdBO.fxp"), "SIM", "NAO") + CHR(13)
STRTOFILE(lcTxt, lcOut)
QUIT
