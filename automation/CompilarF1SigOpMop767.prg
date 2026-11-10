* CompilarF1SigOpMop767.prg
* Compila SigOpMopBO.prg (Fase 1) sem executar - so para provar sintaxe.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cBO
loc_cBO = "C:\4c\projeto\app\classes\SigOpMopBO.prg"

IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".err"))
ENDIF

COMPILE (loc_cBO)

QUIT
