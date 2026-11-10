* CompilarF4Sigopfis742.prg
* Compila Formsigopfis.prg (Fase 4) sem executar - so para provar sintaxe.
* Uso: vfp9.exe -t "C:\4c\automation\CompilarF4Sigopfis742.prg"
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm
loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigopfis.prg"

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF

COMPILE (loc_cForm)

QUIT
