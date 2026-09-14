SET SAFETY OFF
SET RESOURCE OFF
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\relatoriobase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
COMPILE C:\4c\projeto\app\classes\sigrebalBO.prg
COMPILE C:\4c\projeto\app\forms\relatorios\Formsigrebal.prg
STRTOFILE("OK", "C:\4c\compile_sigrebal_result.txt")
QUIT