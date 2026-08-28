* Diagnostic test 2 for task501 - tests ConfigurarAmbiente
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)
ON ERROR * ignore errors

LOCAL loc_cLog
loc_cLog = "C:\4c\tasks\task501\diag2_result.txt"

STRTOFILE("DIAG2 START" + CHR(13) + CHR(10), loc_cLog)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE(FILETOSTR(loc_cLog) + "config OK" + CHR(13) + CHR(10), loc_cLog)
CATCH TO loEx
    STRTOFILE(FILETOSTR(loc_cLog) + "config ERR: " + loEx.Message + CHR(13) + CHR(10), loc_cLog)
ENDTRY

STRTOFILE(FILETOSTR(loc_cLog) + "Before ConfigurarAmbiente" + CHR(13) + CHR(10), loc_cLog)

TRY
    ConfigurarAmbiente()
    STRTOFILE(FILETOSTR(loc_cLog) + "ConfigurarAmbiente OK" + CHR(13) + CHR(10), loc_cLog)
CATCH TO loEx
    STRTOFILE(FILETOSTR(loc_cLog) + "ConfigurarAmbiente ERR: " + loEx.Message + " Linha:" + TRANSFORM(loEx.LineNo) + CHR(13) + CHR(10), loc_cLog)
ENDTRY

STRTOFILE(FILETOSTR(loc_cLog) + "After ConfigurarAmbiente" + CHR(13) + CHR(10), loc_cLog)

QUIT
