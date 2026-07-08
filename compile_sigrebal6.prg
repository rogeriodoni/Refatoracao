SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cResult
loc_cResult = ""

*-- Delete old FXP and ERR
IF FILE("C:\4c\projeto\app\classes\sigrebalbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigrebalbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigrebalbo.ERR")
    DELETE FILE "C:\4c\projeto\app\classes\sigrebalbo.ERR"
ENDIF

TRY
    COMPILE "C:\4c\projeto\app\classes\sigrebalBO.prg"
    IF FILE("C:\4c\projeto\app\classes\sigrebalbo.ERR")
        loc_cResult = "BO:ERR_FILE:" + FILETOSTR("C:\4c\projeto\app\classes\sigrebalbo.ERR") + CHR(13)
    ELSE
        loc_cResult = "BO:OK" + CHR(13)
    ENDIF
CATCH TO loc_oErr
    loc_cResult = "BO:EXCEPTION:" + loc_oErr.Message + CHR(13)
ENDTRY

STRTOFILE(loc_cResult, "C:\4c\compile_sigrebal6_result.txt")
QUIT
