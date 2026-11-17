*-- Compilacao Fase 8 - FormSigOpPdt / SigOpPdtBO (task784)
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cBO, loc_cForm

loc_cBO   = "C:\4c\projeto\app\classes\SigOpPdtBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpPdt.prg"

IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp")) AND FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    ?"COMPILE_OK"
ELSE
    ?"COMPILE_FAIL"
ENDIF

QUIT
