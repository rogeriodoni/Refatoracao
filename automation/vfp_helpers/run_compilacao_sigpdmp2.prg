SET SAFETY OFF
SET TALK OFF
SET CONSOLE ON

TRY
    DO "C:\4c\automation\vfp_helpers\ValidarCompilacao.prg" WITH "C:\4c\projeto\app\classes\sigpdmp2BO.prg;C:\4c\projeto\app\forms\operacionais\Formsigpdmp2.prg"
    loc_nResult = 0
CATCH TO loEx
    ? "ERRO: " + loEx.Message
    loc_nResult = 1
ENDTRY

QUIT
