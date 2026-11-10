* CompilarF7SigOpLib760.prg
* Compila FormSigOpLib.prg + SigOpLibBO.prg (Fase 7) sem executar - so sintaxe.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpLib.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpLibBO.prg"

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".err"))
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

QUIT
