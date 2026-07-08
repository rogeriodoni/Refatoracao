SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cBak, loc_cLog
loc_cBak = "C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg.bak"
loc_cLog = "C:\4c\tasks\task190\compilacao_bak.log"

LOCAL loc_cOut
loc_cOut = "=== COMPILACAO BAK ===" + CHR(13)+CHR(10)
loc_cOut = loc_cOut + "Data: " + DTOC(DATE()) + " " + TIME() + CHR(13)+CHR(10) + CHR(13)+CHR(10)

IF FILE(FORCEEXT(loc_cBak, "fxp"))
    DELETE FILE (FORCEEXT(loc_cBak, "fxp"))
ENDIF
IF FILE(FORCEEXT(loc_cBak, "err"))
    DELETE FILE (FORCEEXT(loc_cBak, "err"))
ENDIF
COMPILE (loc_cBak)
IF FILE(FORCEEXT(loc_cBak, "err"))
    loc_cOut = loc_cOut + "FormSigPrGlx.prg.bak: ERRO" + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + FILETOSTR(FORCEEXT(loc_cBak, "err")) + CHR(13)+CHR(10)
ELSE
    loc_cOut = loc_cOut + "FormSigPrGlx.prg.bak: OK" + CHR(13)+CHR(10)
ENDIF

loc_cOut = loc_cOut + CHR(13)+CHR(10) + "=== FIM ==="
STRTOFILE(loc_cOut, loc_cLog, 0)
QUIT
