SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cLog
loc_cLog = "C:\4c\tasks\task501\diag6_result.txt"

STRTOFILE("DIAG6: Testing sigpriteBO" + CHR(13) + CHR(10), loc_cLog)

TRY
    SET PROCEDURE TO C:\4c\projeto\app\classes\sigpriteBO.prg ADDITIVE
    STRTOFILE(FILETOSTR(loc_cLog) + "sigpriteBO loaded OK" + CHR(13) + CHR(10), loc_cLog)
CATCH TO loEx
    STRTOFILE(FILETOSTR(loc_cLog) + "sigpriteBO ERR: " + loEx.Message + " L" + TRANSFORM(loEx.LineNo) + CHR(13) + CHR(10), loc_cLog)
ENDTRY

STRTOFILE(FILETOSTR(loc_cLog) + "DONE" + CHR(13) + CHR(10), loc_cLog)
QUIT
