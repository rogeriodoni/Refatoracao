SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cBoFile, loc_cFormFile, loc_cErrBo, loc_cErrForm, loc_cResult
loc_cBoFile   = "C:\4c\projeto\app\classes\DrsBO.prg"
loc_cFormFile = "C:\4c\projeto\app\forms\cadastros\FormDrs.prg"
loc_cErrBo    = "C:\4c\projeto\app\classes\DrsBO.err"
loc_cErrForm  = "C:\4c\projeto\app\forms\cadastros\FormDrs.err"
loc_cResult   = "C:\4c\tasks\task398\compilacao_resultado.txt"

*-- Remove .err anteriores
IF FILE(loc_cErrBo)
    DELETE FILE (loc_cErrBo)
ENDIF
IF FILE(loc_cErrForm)
    DELETE FILE (loc_cErrForm)
ENDIF
*-- Remove .fxp anteriores (forca recompilacao)
IF FILE(FORCEEXT(loc_cBoFile, "fxp"))
    DELETE FILE (FORCEEXT(loc_cBoFile, "fxp"))
ENDIF
IF FILE(FORCEEXT(loc_cFormFile, "fxp"))
    DELETE FILE (FORCEEXT(loc_cFormFile, "fxp"))
ENDIF

loc_cResult = ""

*-- Compila DrsBO.prg
TRY
    COMPILE (loc_cBoFile)
    IF FILE(loc_cErrBo)
        loc_cResult = loc_cResult + "DRSBO_ERROR:" + FILETOSTR(loc_cErrBo) + CHR(10)
    ELSE
        loc_cResult = loc_cResult + "DRSBO_OK" + CHR(10)
    ENDIF
CATCH TO loc_oEx
    loc_cResult = loc_cResult + "DRSBO_EXCEPTION:" + loc_oEx.Message + CHR(10)
ENDTRY

*-- Compila FormDrs.prg
TRY
    COMPILE (loc_cFormFile)
    IF FILE(loc_cErrForm)
        loc_cResult = loc_cResult + "FORMDRS_ERROR:" + FILETOSTR(loc_cErrForm) + CHR(10)
    ELSE
        loc_cResult = loc_cResult + "FORMDRS_OK" + CHR(10)
    ENDIF
CATCH TO loc_oEx
    loc_cResult = loc_cResult + "FORMDRS_EXCEPTION:" + loc_oEx.Message + CHR(10)
ENDTRY

STRTOFILE(loc_cResult, "C:\4c\tasks\task398\compilacao_resultado.txt")
QUIT
