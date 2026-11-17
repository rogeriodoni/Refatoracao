* CompilarF8SigOpPag782.prg
* Compila Form e BO do SIGOPPAG (task782, Fase 8/8) sem executar - prova de sintaxe.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_cOut

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigoppag.prg"
loc_cBO   = "C:\4c\projeto\app\classes\sigoppagBO.prg"

IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".err"))
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cOut = "FORM_FXP=" + TRANSFORM(FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))) + CHR(13) + CHR(10) + ;
           "FORM_ERR=" + TRANSFORM(FILE(STRTRAN(loc_cForm, ".prg", ".err"))) + CHR(13) + CHR(10) + ;
           "BO_FXP="   + TRANSFORM(FILE(STRTRAN(loc_cBO, ".prg", ".fxp")))   + CHR(13) + CHR(10) + ;
           "BO_ERR="   + TRANSFORM(FILE(STRTRAN(loc_cBO, ".prg", ".err")))   + CHR(13) + CHR(10)

IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    loc_cOut = loc_cOut + "--- FORM ERR ---" + CHR(13) + CHR(10) + FILETOSTR(STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    loc_cOut = loc_cOut + "--- BO ERR ---" + CHR(13) + CHR(10) + FILETOSTR(STRTRAN(loc_cBO, ".prg", ".err"))
ENDIF

= STRTOFILE(loc_cOut, "C:\4c\automation\_compila782f8.txt")
QUIT
