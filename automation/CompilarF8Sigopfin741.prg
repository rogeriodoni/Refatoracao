* CompilarF8Sigopfin741.prg
* Compila Formsigopfin.prg (Fase 8) + sigopfinBO.prg via COMPILE dentro do
* script (nao -T), para nao deixar o VFP pendurado no IDE. So prova sintaxe.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigopfin.prg"
loc_cBO   = "C:\4c\projeto\app\classes\sigopfinBO.prg"

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

COMPILE (loc_cBO)
COMPILE (loc_cForm)

STRTOFILE("BO.FXP=" + TRANSFORM(FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))) + ;
    " BO.ERR=" + TRANSFORM(FILE(STRTRAN(loc_cBO, ".prg", ".err"))) + CHR(13) + ;
    "FORM.FXP=" + TRANSFORM(FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))) + ;
    " FORM.ERR=" + TRANSFORM(FILE(STRTRAN(loc_cForm, ".prg", ".err"))), ;
    "C:\4c\automation\_resultado_compilaf8_741.txt")

QUIT
