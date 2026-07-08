SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_cBo, loc_cForm, loc_cLog
loc_cBo   = "C:\4c\projeto\app\classes\SigPrGlpBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg"
loc_cLog  = "C:\4c\tasks\task189\compilacao_task189.log"

LOCAL loc_cOut
loc_cOut = "=== COMPILACAO TASK189 ===" + CHR(13)+CHR(10)
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
    loc_cOut = loc_cOut + "SigPrGlpBO.prg: ERRO" + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + FILETOSTR(FORCEEXT(loc_cBo, "err")) + CHR(13)+CHR(10)
ELSE
    loc_cOut = loc_cOut + "SigPrGlpBO.prg: OK" + CHR(13)+CHR(10)
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
    loc_cOut = loc_cOut + "FormSigPrGlp.prg: ERRO" + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + FILETOSTR(FORCEEXT(loc_cForm, "err")) + CHR(13)+CHR(10)
ELSE
    loc_cOut = loc_cOut + "FormSigPrGlp.prg: OK" + CHR(13)+CHR(10)
ENDIF

loc_cOut = loc_cOut + CHR(13)+CHR(10) + "=== FIM ==="
STRTOFILE(loc_cOut, loc_cLog, 0)

QUIT
