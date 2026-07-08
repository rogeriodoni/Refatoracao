SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cResult, loc_cErrors
loc_cResult = ""
loc_cErrors = ""

* Compile BO
TRY
    COMPILE "C:\4c\projeto\app\classes\SigReAtmBO.prg"
    loc_cResult = loc_cResult + "BO:OK" + CHR(13)
CATCH TO loc_oErr
    loc_cResult = loc_cResult + "BO:ERRO:" + loc_oErr.Message + CHR(13)
ENDTRY

* Compile Form
TRY
    COMPILE "C:\4c\projeto\app\forms\relatorios\FormSigReAtm.prg"
    loc_cResult = loc_cResult + "FORM:OK" + CHR(13)
CATCH TO loc_oErr
    loc_cResult = loc_cResult + "FORM:ERRO:" + loc_oErr.Message + CHR(13)
ENDTRY

STRTOFILE(loc_cResult, "C:\4c\compile_task034_result.txt")
QUIT
