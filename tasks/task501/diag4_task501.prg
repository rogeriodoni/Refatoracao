SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cLog
loc_cLog = "C:\4c\tasks\task501\diag4_result.txt"

STRTOFILE("DIAG4 START" + CHR(13) + CHR(10), loc_cLog)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE(FILETOSTR(loc_cLog) + "config OK" + CHR(13) + CHR(10), loc_cLog)
CATCH TO loEx
    STRTOFILE(FILETOSTR(loc_cLog) + "config ERR: " + loEx.Message + CHR(13) + CHR(10), loc_cLog)
ENDTRY

STRTOFILE(FILETOSTR(loc_cLog) + "Testing base classes..." + CHR(13) + CHR(10), loc_cLog)

LOCAL loc_cFile
FOR EACH loc_cFile IN ARRAY ["dataaccess.prg", "businessbase.prg", "formbase.prg", "gridbase.prg", "relatoriobase.prg", "FormBuscaAuxiliar.prg", "FormBuscaSimples.prg", "FormErro.prg", "TextBoxGridLookup.prg"]
    TRY
        IF FILE(gcCaminhoClasses + loc_cFile)
            SET PROCEDURE TO (gcCaminhoClasses + loc_cFile) ADDITIVE
            STRTOFILE(FILETOSTR(loc_cLog) + "OK: " + loc_cFile + CHR(13) + CHR(10), loc_cLog)
        ELSE
            STRTOFILE(FILETOSTR(loc_cLog) + "SKIP: " + loc_cFile + CHR(13) + CHR(10), loc_cLog)
        ENDIF
    CATCH TO loEx
        STRTOFILE(FILETOSTR(loc_cLog) + "ERR " + loc_cFile + ": " + loEx.Message + CHR(13) + CHR(10), loc_cLog)
    ENDTRY
ENDFOR

STRTOFILE(FILETOSTR(loc_cLog) + "Testing *BO.prg files..." + CHR(13) + CHR(10), loc_cLog)

LOCAL ARRAY loc_aBOs[1]
LOCAL loc_nBOs, loc_i
loc_nBOs = ADIR(loc_aBOs, gcCaminhoClasses + "*BO.prg")
IF loc_nBOs > 0
    FOR loc_i = 1 TO loc_nBOs
        TRY
            SET PROCEDURE TO (gcCaminhoClasses + loc_aBOs[loc_i, 1]) ADDITIVE
            STRTOFILE(FILETOSTR(loc_cLog) + "BO OK: " + loc_aBOs[loc_i, 1] + CHR(13) + CHR(10), loc_cLog)
        CATCH TO loEx
            STRTOFILE(FILETOSTR(loc_cLog) + "BO ERR " + loc_aBOs[loc_i, 1] + ": " + loEx.Message + CHR(13) + CHR(10), loc_cLog)
        ENDTRY
    ENDFOR
ENDIF

STRTOFILE(FILETOSTR(loc_cLog) + "Testing Form*.prg cadastros..." + CHR(13) + CHR(10), loc_cLog)

LOCAL ARRAY loc_aForms[1]
LOCAL loc_nForms
loc_nForms = ADIR(loc_aForms, gcCaminhoForms + "cadastros\Form*.prg")
IF loc_nForms > 0
    FOR loc_i = 1 TO loc_nForms
        TRY
            SET PROCEDURE TO (gcCaminhoForms + "cadastros\" + loc_aForms[loc_i, 1]) ADDITIVE
            STRTOFILE(FILETOSTR(loc_cLog) + "Form OK: " + loc_aForms[loc_i, 1] + CHR(13) + CHR(10), loc_cLog)
        CATCH TO loEx
            STRTOFILE(FILETOSTR(loc_cLog) + "Form ERR " + loc_aForms[loc_i, 1] + ": " + loEx.Message + CHR(13) + CHR(10), loc_cLog)
        ENDTRY
    ENDFOR
ENDIF

STRTOFILE(FILETOSTR(loc_cLog) + "DIAG4 DONE" + CHR(13) + CHR(10), loc_cLog)
QUIT
