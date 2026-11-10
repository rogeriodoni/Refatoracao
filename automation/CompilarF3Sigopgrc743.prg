* CompilarF3Sigopgrc743.prg
* Compila FormSIGOPGRC.prg (Fase 3) sem executar - so para provar sintaxe.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPGRC.prg"

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF

COMPILE (loc_cForm)

QUIT
