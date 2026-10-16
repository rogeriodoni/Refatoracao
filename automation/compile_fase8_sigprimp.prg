SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cRes, loc_cErr
loc_cRes = ""

ERASE C:\4c\projeto\app\forms\operacionais\formsigprimp.fxp
ERASE C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.err
COMPILE C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg

IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.err")
    loc_cErr = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.err")
    IF LEN(ALLTRIM(loc_cErr)) > 0
        loc_cRes = "ERROS DE COMPILACAO:" + CHR(13) + CHR(10) + loc_cErr
    ELSE
        loc_cRes = "COMPILOU OK (.err vazio)"
    ENDIF
ELSE
    loc_cRes = "COMPILOU OK (sem .err)"
ENDIF

loc_cRes = loc_cRes + CHR(13) + CHR(10) + "FXP existe: " + ;
    IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigprimp.fxp"), "SIM", "NAO")

STRTOFILE(loc_cRes, "C:\4c\automation\compile_fase8_sigprimp_result.txt")
QUIT
