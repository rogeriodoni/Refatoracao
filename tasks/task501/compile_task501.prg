SET SAFETY OFF
SET RESOURCE OFF
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE

LOCAL lcResult
lcResult = ""

TRY
    COMPILE C:\4c\projeto\app\classes\prcBO.prg
    lcResult = lcResult + "prcBO.prg: OK" + CHR(13) + CHR(10)
CATCH TO loEx
    lcResult = lcResult + "prcBO.prg ERROR linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message + CHR(13) + CHR(10)
ENDTRY

TRY
    COMPILE C:\4c\projeto\app\forms\cadastros\Formprc.prg
    lcResult = lcResult + "Formprc.prg: OK" + CHR(13) + CHR(10)
CATCH TO loEx
    lcResult = lcResult + "Formprc.prg ERROR linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcResult, "C:\4c\tasks\task501\compile_result.txt")
QUIT
