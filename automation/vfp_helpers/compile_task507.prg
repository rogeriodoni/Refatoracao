SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cFormFile, loc_cBoFile, loc_cResult, loc_lOk
loc_cFormFile = "C:\4c\projeto\app\forms\cadastros\FormRAN.prg"
loc_cBoFile   = "C:\4c\projeto\app\classes\RANBO.prg"
loc_cResult   = "C:\4c\automation\vfp_helpers\compile_task507.log"
loc_lOk = .T.

STRTOFILE("", loc_cResult)

TRY
    COMPILE (loc_cBoFile)
    STRTOFILE("BO:OK" + CHR(13) + CHR(10), loc_cResult, .T.)
CATCH TO loE
    STRTOFILE("BO:ERRO:" + loE.Message + " Linha:" + TRANSFORM(loE.LineNo) + CHR(13)+CHR(10), loc_cResult, .T.)
    loc_lOk = .F.
ENDTRY

TRY
    COMPILE (loc_cFormFile)
    STRTOFILE("FORM:OK" + CHR(13) + CHR(10), loc_cResult, .T.)
CATCH TO loE
    STRTOFILE("FORM:ERRO:" + loE.Message + " Linha:" + TRANSFORM(loE.LineNo) + CHR(13)+CHR(10), loc_cResult, .T.)
    loc_lOk = .F.
ENDTRY

IF loc_lOk
    STRTOFILE("STATUS:SUCESSO" + CHR(13)+CHR(10), loc_cResult, .T.)
ELSE
    STRTOFILE("STATUS:FALHOU" + CHR(13)+CHR(10), loc_cResult, .T.)
ENDIF

RETURN loc_lOk
