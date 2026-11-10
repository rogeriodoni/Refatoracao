SET SAFETY OFF
SET TALK OFF
SET CONSOLE ON

TRY
    DO "C:\4c\automation\vfp_helpers\ValidarCompilacao.prg" WITH "C:\4c\projeto\app\forms\operacionais\FormSigOpOca.prg;C:\4c\projeto\app\classes\SigOpOcaBO.prg"
CATCH TO loEx
    ? "ERRO: " + loEx.Message
ENDTRY

QUIT
