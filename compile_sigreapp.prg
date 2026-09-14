SET SAFETY OFF
SET RESOURCE OFF
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\relatoriobase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\sigreappBO.prg ADDITIVE
TRY
  COMPILE C:\4c\projeto\app\classes\sigreappBO.prg
  COMPILE C:\4c\projeto\app\forms\relatorios\Formsigreapp.prg
  STRTOFILE("COMPILE_OK", "C:\4c\compile_sigreapp_result.txt")
CATCH TO loErr
  LOCAL lcMsg
  lcMsg = "ERRO: " + loErr.Message + CHR(13) + "Linha: " + TRANSFORM(loErr.LineNo)
  STRTOFILE(lcMsg, "C:\4c\compile_sigreapp_result.txt")
ENDTRY
QUIT
