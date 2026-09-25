SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
lcErr = "C:\4c\tasks\task570\_f6_compila.err"
IF FILE(lcErr)
    DELETE FILE (lcErr)
ENDIF
COMPILE C:\4c\projeto\app\classes\SigMvExpBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\FormSigMvExp.prg
lcOut = "BO_FXP=" + IIF(FILE("C:\4c\projeto\app\classes\sigmvexpbo.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "FORM_FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigmvexp.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\classes\SigMvExpBO.err")
    lcOut = lcOut + "ERR_BO:" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\SigMvExpBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigMvExp.err")
    lcOut = lcOut + "ERR_FORM:" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigMvExp.err")
ENDIF
STRTOFILE(lcOut, lcErr)
QUIT
