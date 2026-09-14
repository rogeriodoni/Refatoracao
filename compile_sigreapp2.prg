SET SAFETY OFF
SET RESOURCE OFF
SET ERRORS OFF
SET TALK OFF

LOCAL lcResult
lcResult = "INIT"

TRY
    COMPILE "C:\4c\projeto\app\classes\sigreappBO.prg"
    lcResult = "BO_OK"
CATCH TO loErr
    lcResult = "BO_ERRO: " + loErr.Message + " Linha=" + TRANSFORM(loErr.LineNo)
ENDTRY

STRTOFILE(lcResult + CHR(13), "C:\4c\compile_sigreapp2_result.txt", .F.)

TRY
    COMPILE "C:\4c\projeto\app\forms\relatorios\Formsigreapp.prg"
    lcResult = "FORM_OK"
CATCH TO loErr
    lcResult = "FORM_ERRO: " + loErr.Message + " Linha=" + TRANSFORM(loErr.LineNo)
ENDTRY

STRTOFILE(lcResult + CHR(13), "C:\4c\compile_sigreapp2_result.txt", .T.)
STRTOFILE("DONE", "C:\4c\compile_sigreapp2_result.txt", .T.)
QUIT
