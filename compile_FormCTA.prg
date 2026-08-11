SET SAFETY OFF
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\CTABO.prg ADDITIVE
LOCAL lcError
lcError = ""
TRY
    COMPILE C:\4c\projeto\app\forms\cadastros\FormCTA.prg
    STRTOFILE("OK: Compiled successfully", "C:\4c\compile_result_FormCTA.txt")
CATCH TO loEx
    STRTOFILE("ERROR line " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message, "C:\4c\compile_result_FormCTA.txt")
ENDTRY
QUIT
