SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cResult
loc_cResult = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigmvsbn.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigmvsbn.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigmvsbnbo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigmvsbnbo.fxp"
ENDIF
TRY
    COMPILE "C:\4c\projeto\app\classes\SigMvSbnBO.prg"
    loc_cResult = loc_cResult + "BO_OK" + CHR(13)
CATCH TO loc_oErr
    loc_cResult = loc_cResult + "BO_FAIL: " + loc_oErr.Message + CHR(13)
ENDTRY
TRY
    COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigMvSbn.prg"
    loc_cResult = loc_cResult + "FORM_OK" + CHR(13)
CATCH TO loc_oErr
    loc_cResult = loc_cResult + "FORM_FAIL: " + loc_oErr.Message + CHR(13)
ENDTRY
STRTOFILE(loc_cResult, "C:\4c\tasks\task577\compile_check_result.txt")
QUIT
