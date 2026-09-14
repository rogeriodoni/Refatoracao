SET SAFETY OFF
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\relatoriobase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
COMPILE C:\4c\projeto\app\classes\SigReEtlBO.prg
COMPILE C:\4c\projeto\app\forms\relatorios\FormSigReEtl.prg
WAIT WINDOW "Compilacao concluida" TIMEOUT 2
QUIT