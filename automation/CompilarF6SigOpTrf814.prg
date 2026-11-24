* CompilarF6SigOpTrf814.prg
* Compila TextBoxGridLookup.prg (classes novas) e FormSigOpTrf.prg
* (Fase 6 - lookups de celula) sem executar - prova de sintaxe.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cClasses, loc_cForm, loc_cOut

loc_cClasses = "C:\4c\projeto\app\classes\textboxgridlookup.PRG"
loc_cForm    = "C:\4c\projeto\app\forms\operacionais\FormSigOpTrf.prg"

IF FILE(STRTRAN(loc_cClasses, ".PRG", ".fxp"))
    DELETE FILE (STRTRAN(loc_cClasses, ".PRG", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cClasses, ".PRG", ".err"))
    DELETE FILE (STRTRAN(loc_cClasses, ".PRG", ".err"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF

COMPILE (loc_cClasses)
COMPILE (loc_cForm)

loc_cOut = "CLASSES_FXP=" + TRANSFORM(FILE(STRTRAN(loc_cClasses, ".PRG", ".fxp"))) + CHR(13) + CHR(10) + ;
           "CLASSES_ERR=" + TRANSFORM(FILE(STRTRAN(loc_cClasses, ".PRG", ".err"))) + CHR(13) + CHR(10) + ;
           "FORM_FXP="    + TRANSFORM(FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))) + CHR(13) + CHR(10) + ;
           "FORM_ERR="    + TRANSFORM(FILE(STRTRAN(loc_cForm, ".prg", ".err"))) + CHR(13) + CHR(10)

IF FILE(STRTRAN(loc_cClasses, ".PRG", ".err"))
    loc_cOut = loc_cOut + "--- CLASSES ERR ---" + CHR(13) + CHR(10) + FILETOSTR(STRTRAN(loc_cClasses, ".PRG", ".err")) + CHR(13) + CHR(10)
ENDIF

IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    loc_cOut = loc_cOut + "--- FORM ERR ---" + CHR(13) + CHR(10) + FILETOSTR(STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF

= STRTOFILE(loc_cOut, "C:\4c\automation\_compila814f6.txt")
QUIT
