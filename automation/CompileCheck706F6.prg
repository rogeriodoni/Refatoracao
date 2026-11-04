SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcForm, lcBO, lcOut

lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpCop.prg"
lcBO   = "C:\4c\projeto\app\classes\SigOpCopBO.prg"
lcOut  = ""

ERASE C:\4c\projeto\app\forms\operacionais\formsigopcop.FXP
ERASE C:\4c\projeto\app\forms\operacionais\FormSigOpCop.ERR
ERASE C:\4c\projeto\app\classes\sigopcopbo.FXP
ERASE C:\4c\projeto\app\classes\SigOpCopBO.ERR

COMPILE (lcForm)
COMPILE (lcBO)

lcOut = lcOut + "FORM FXP : " + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigopcop.FXP"), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "FORM ERR : " + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCop.ERR"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCop.ERR")
    lcOut = lcOut + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpCop.ERR") + CHR(13) + CHR(10)
ENDIF
lcOut = lcOut + "BO FXP   : " + IIF(FILE("C:\4c\projeto\app\classes\sigopcopbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "BO ERR   : " + IIF(FILE("C:\4c\projeto\app\classes\SigOpCopBO.ERR"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\classes\SigOpCopBO.ERR")
    lcOut = lcOut + FILETOSTR("C:\4c\projeto\app\classes\SigOpCopBO.ERR") + CHR(13) + CHR(10)
ENDIF

= STRTOFILE(lcOut, "C:\4c\automation\compile_check_706_f6.txt")
QUIT
