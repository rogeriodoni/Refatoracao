* CompilarF7Sigoprbt793.prg
* Compila Formsigoprbt.prg + sigoprbtBO.prg (Fase 7) sem executar.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigoprbt.prg"
loc_cBO   = "C:\4c\projeto\app\classes\sigoprbtBO.prg"

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
