SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\sigopindBO.prg ADDITIVE
COMPILE C:\4c\projeto\app\forms\operacionais\Formsigopind.prg
IF _VFP.ActiveForm IS NULL
    WAIT WINDOW "Compiled OK" TIMEOUT 2
ENDIF
QUIT