SET SAFETY OFF
SET RESOURCE OFF
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\relatoriobase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\automation\vfp_helpers\ValidarCompilacao.prg ADDITIVE

DO ValidarCompilacao WITH "C:\4c\projeto\app\classes\sigrebalBO.prg;C:\4c\projeto\app\forms\relatorios\Formsigrebal.prg"
QUIT
