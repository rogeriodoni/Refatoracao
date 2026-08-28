* Diagnostic test for task501
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cLog
loc_cLog = "C:\4c\tasks\task501\diag_result.txt"

STRTOFILE("DIAG START" + CHR(13) + CHR(10), loc_cLog)

* Step 1: Load config
STRTOFILE(FILETOSTR(loc_cLog) + "Step 1: CD + DO config" + CHR(13) + CHR(10), loc_cLog)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE(FILETOSTR(loc_cLog) + "Step 1 OK" + CHR(13) + CHR(10), loc_cLog)
CATCH TO loEx
    STRTOFILE(FILETOSTR(loc_cLog) + "Step 1 ERR: " + loEx.Message + " line " + TRANSFORM(loEx.LineNo) + CHR(13) + CHR(10), loc_cLog)
ENDTRY

* Step 2: Load base classes manually
STRTOFILE(FILETOSTR(loc_cLog) + "Step 2: Load base classes" + CHR(13) + CHR(10), loc_cLog)
TRY
    SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
    SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
    SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
    SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
    STRTOFILE(FILETOSTR(loc_cLog) + "Step 2 OK" + CHR(13) + CHR(10), loc_cLog)
CATCH TO loEx
    STRTOFILE(FILETOSTR(loc_cLog) + "Step 2 ERR: " + loEx.Message + " line " + TRANSFORM(loEx.LineNo) + CHR(13) + CHR(10), loc_cLog)
ENDTRY

* Step 3: Load prcBO
STRTOFILE(FILETOSTR(loc_cLog) + "Step 3: Load prcBO" + CHR(13) + CHR(10), loc_cLog)
TRY
    SET PROCEDURE TO C:\4c\projeto\app\classes\prcBO.prg ADDITIVE
    STRTOFILE(FILETOSTR(loc_cLog) + "Step 3 OK" + CHR(13) + CHR(10), loc_cLog)
CATCH TO loEx
    STRTOFILE(FILETOSTR(loc_cLog) + "Step 3 ERR: " + loEx.Message + " line " + TRANSFORM(loEx.LineNo) + CHR(13) + CHR(10), loc_cLog)
ENDTRY

* Step 4: Load Formprc
STRTOFILE(FILETOSTR(loc_cLog) + "Step 4: Load Formprc" + CHR(13) + CHR(10), loc_cLog)
TRY
    SET PROCEDURE TO C:\4c\projeto\app\forms\cadastros\Formprc.prg ADDITIVE
    STRTOFILE(FILETOSTR(loc_cLog) + "Step 4 OK" + CHR(13) + CHR(10), loc_cLog)
CATCH TO loEx
    STRTOFILE(FILETOSTR(loc_cLog) + "Step 4 ERR: " + loEx.Message + " line " + TRANSFORM(loEx.LineNo) + CHR(13) + CHR(10), loc_cLog)
ENDTRY

* Step 5: Instantiate prcBO
STRTOFILE(FILETOSTR(loc_cLog) + "Step 5: Instantiate prcBO" + CHR(13) + CHR(10), loc_cLog)
TRY
    LOCAL loc_oBO
    loc_oBO = CREATEOBJECT("prcBO")
    IF !ISNULL(loc_oBO)
        STRTOFILE(FILETOSTR(loc_cLog) + "Step 5 OK" + CHR(13) + CHR(10), loc_cLog)
    ELSE
        STRTOFILE(FILETOSTR(loc_cLog) + "Step 5 ERR: NULL returned" + CHR(13) + CHR(10), loc_cLog)
    ENDIF
CATCH TO loEx
    STRTOFILE(FILETOSTR(loc_cLog) + "Step 5 ERR: " + loEx.Message + " line " + TRANSFORM(loEx.LineNo) + CHR(13) + CHR(10), loc_cLog)
ENDTRY

STRTOFILE(FILETOSTR(loc_cLog) + "DIAG DONE" + CHR(13) + CHR(10), loc_cLog)
QUIT
