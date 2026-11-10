* CompilarF2Sigophis745.prg
* Compila SigOpHisBO.prg (Fase 2) sem executar - so para provar sintaxe.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cBO
loc_cBO = "C:\4c\projeto\app\classes\SigOpHisBO.prg"

IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".err"))
ENDIF

COMPILE (loc_cBO)

QUIT
