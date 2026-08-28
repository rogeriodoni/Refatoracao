SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cLog
loc_cLog = "C:\4c\tasks\task501\diag5_result.txt"

STRTOFILE("DIAG5 START" + CHR(13) + CHR(10), loc_cLog)

CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE(FILETOSTR(loc_cLog) + "config OK" + CHR(13) + CHR(10), loc_cLog)
STRTOFILE(FILETOSTR(loc_cLog) + "CaminhoBase: " + gcCaminhoBase + CHR(13) + CHR(10), loc_cLog)
STRTOFILE(FILETOSTR(loc_cLog) + "CaminhoClasses: " + gcCaminhoClasses + CHR(13) + CHR(10), loc_cLog)
STRTOFILE(FILETOSTR(loc_cLog) + "CaminhoForms: " + gcCaminhoForms + CHR(13) + CHR(10), loc_cLog)

* Test loading each BO one by one
LOCAL ARRAY loc_aBOs[1]
LOCAL loc_nBOs, loc_i
loc_nBOs = ADIR(loc_aBOs, gcCaminhoClasses + "*BO.prg")
STRTOFILE(FILETOSTR(loc_cLog) + "BO files found: " + TRANSFORM(loc_nBOs) + CHR(13) + CHR(10), loc_cLog)

IF loc_nBOs > 0
    FOR loc_i = 1 TO loc_nBOs
        LOCAL loc_cBOFile
        loc_cBOFile = gcCaminhoClasses + loc_aBOs[loc_i, 1]
        TRY
            SET PROCEDURE TO (loc_cBOFile) ADDITIVE
            STRTOFILE(FILETOSTR(loc_cLog) + "OK: " + loc_aBOs[loc_i, 1] + CHR(13) + CHR(10), loc_cLog)
        CATCH TO loEx
            STRTOFILE(FILETOSTR(loc_cLog) + "ERR: " + loc_aBOs[loc_i, 1] + " -> " + loEx.Message + CHR(13) + CHR(10), loc_cLog)
        ENDTRY
    ENDFOR
ENDIF

STRTOFILE(FILETOSTR(loc_cLog) + "BOs done. Now loading Form cadastros..." + CHR(13) + CHR(10), loc_cLog)

LOCAL ARRAY loc_aForms[1]
LOCAL loc_nForms
loc_nForms = ADIR(loc_aForms, gcCaminhoForms + "cadastros\Form*.prg")
STRTOFILE(FILETOSTR(loc_cLog) + "Form files found: " + TRANSFORM(loc_nForms) + CHR(13) + CHR(10), loc_cLog)

IF loc_nForms > 0
    FOR loc_i = 1 TO loc_nForms
        LOCAL loc_cFormFile
        loc_cFormFile = gcCaminhoForms + "cadastros\" + loc_aForms[loc_i, 1]
        TRY
            SET PROCEDURE TO (loc_cFormFile) ADDITIVE
            STRTOFILE(FILETOSTR(loc_cLog) + "Form OK: " + loc_aForms[loc_i, 1] + CHR(13) + CHR(10), loc_cLog)
        CATCH TO loEx
            STRTOFILE(FILETOSTR(loc_cLog) + "Form ERR: " + loc_aForms[loc_i, 1] + " -> " + loEx.Message + CHR(13) + CHR(10), loc_cLog)
        ENDTRY
    ENDFOR
ENDIF

STRTOFILE(FILETOSTR(loc_cLog) + "DIAG5 DONE" + CHR(13) + CHR(10), loc_cLog)
QUIT
