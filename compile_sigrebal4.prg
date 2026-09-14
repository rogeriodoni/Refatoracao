SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cResult
loc_cResult = ""

TRY
    COMPILE "C:\4c\projeto\app\classes\sigrebalBO.prg"
    loc_cResult = loc_cResult + "BO:OK" + CHR(13)
CATCH TO loc_oErr
    loc_cResult = loc_cResult + "BO:ERRO:" + loc_oErr.Message + CHR(13)
    loc_cResult = loc_cResult + "Linha:" + TRANSFORM(loc_oErr.LineNo) + CHR(13)
ENDTRY

TRY
    COMPILE "C:\4c\projeto\app\forms\relatorios\Formsigrebal.prg"
    loc_cResult = loc_cResult + "FORM:OK" + CHR(13)
CATCH TO loc_oErr
    loc_cResult = loc_cResult + "FORM:ERRO:" + loc_oErr.Message + CHR(13)
    loc_cResult = loc_cResult + "Linha:" + TRANSFORM(loc_oErr.LineNo) + CHR(13)
ENDTRY

STRTOFILE(loc_cResult, "C:\4c\compile_sigrebal4_result.txt")
QUIT
