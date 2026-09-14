SET SAFETY OFF
SET RESOURCE OFF
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
COMPILE C:\4c\projeto\app\classes\PzoBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\FormPzo.prg
WAIT WINDOW "Compile OK" TIMEOUT 2
QUIT