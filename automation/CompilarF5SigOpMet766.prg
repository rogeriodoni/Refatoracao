* CompilarF5SigOpMet766.prg
* Compila FormSigOpMet.prg (Fase 5) sem executar - so para provar sintaxe.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm
loc_cForm = "C:\4c\projeto\app\forms\cadastros\FormSigOpMet.prg"

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF

COMPILE (loc_cForm)

QUIT
