SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cBo, loc_cForm, loc_cLog
loc_cBo   = "C:\4c\projeto\app\classes\SigPrGlxBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg"
loc_cLog  = "C:\4c\tasks\task190\compilacao_task190.log"

LOCAL loc_cOut
loc_cOut = "=== COMPILACAO TASK190 ===" + CHR(13)+CHR(10)
loc_cOut = loc_cOut + "Data: " + DTOC(DATE()) + " " + TIME() + CHR(13)+CHR(10)
loc_cOut = loc_cOut + CHR(13)+CHR(10)

*-- Compilar BO
IF FILE(FORCEEXT(loc_cBo, "fxp"))
    DELETE FILE (FORCEEXT(loc_cBo, "fxp"))
ENDIF
IF FILE(FORCEEXT(loc_cBo, "err"))
    DELETE FILE (FORCEEXT(loc_cBo, "err"))
ENDIF
COMPILE (loc_cBo)
IF FILE(FORCEEXT(loc_cBo, "err"))
    loc_cOut = loc_cOut + "SigPrGlxBO.prg: ERRO" + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + FILETOSTR(FORCEEXT(loc_cBo, "err")) + CHR(13)+CHR(10)
ELSE
    loc_cOut = loc_cOut + "SigPrGlxBO.prg: OK" + CHR(13)+CHR(10)
ENDIF

*-- Compilar Form
IF FILE(FORCEEXT(loc_cForm, "fxp"))
    DELETE FILE (FORCEEXT(loc_cForm, "fxp"))
ENDIF
IF FILE(FORCEEXT(loc_cForm, "err"))
    DELETE FILE (FORCEEXT(loc_cForm, "err"))
ENDIF
COMPILE (loc_cForm)
IF FILE(FORCEEXT(loc_cForm, "err"))
    loc_cOut = loc_cOut + "FormSigPrGlx.prg: ERRO" + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + FILETOSTR(FORCEEXT(loc_cForm, "err")) + CHR(13)+CHR(10)
ELSE
    loc_cOut = loc_cOut + "FormSigPrGlx.prg: OK" + CHR(13)+CHR(10)
ENDIF

loc_cOut = loc_cOut + CHR(13)+CHR(10) + "=== FIM ==="
STRTOFILE(loc_cOut, loc_cLog, 0)

QUIT
