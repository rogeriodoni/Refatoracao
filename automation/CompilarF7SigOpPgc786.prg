SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcForm, lcBO, lcNeg, lcOut

lcForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPPGC.prg"
lcBO   = "C:\4c\projeto\app\classes\SIGOPPGCBO.prg"
lcNeg  = "C:\4c\automation\NegativoF7786.prg"

*-- controle NEGATIVO: tem de gerar .ERR
STRTOFILE("DEFINE CLASS Quebrado AS Custom" + CHR(13)+CHR(10) + ;
          "    PROCEDURE X()" + CHR(13)+CHR(10) + ;
          "        IF .T. THEN DO ALGO" + CHR(13)+CHR(10) + ;
          "    ENDPROC" + CHR(13)+CHR(10), lcNeg)

IF FILE(FORCEEXT(lcForm, "fxp"))
    DELETE FILE (FORCEEXT(lcForm, "fxp"))
ENDIF
IF FILE(FORCEEXT(lcForm, "err"))
    DELETE FILE (FORCEEXT(lcForm, "err"))
ENDIF
IF FILE(FORCEEXT(lcBO, "fxp"))
    DELETE FILE (FORCEEXT(lcBO, "fxp"))
ENDIF
IF FILE(FORCEEXT(lcBO, "err"))
    DELETE FILE (FORCEEXT(lcBO, "err"))
ENDIF
IF FILE(FORCEEXT(lcNeg, "fxp"))
    DELETE FILE (FORCEEXT(lcNeg, "fxp"))
ENDIF
IF FILE(FORCEEXT(lcNeg, "err"))
    DELETE FILE (FORCEEXT(lcNeg, "err"))
ENDIF

COMPILE (lcForm)
COMPILE (lcBO)
COMPILE (lcNeg)

lcOut = "FORM.FXP=" + TRANSFORM(FILE(FORCEEXT(lcForm, "fxp"))) + ;
        "  FORM.ERR=" + TRANSFORM(FILE(FORCEEXT(lcForm, "err"))) + CHR(13)+CHR(10) + ;
        "BO.FXP="   + TRANSFORM(FILE(FORCEEXT(lcBO, "fxp"))) + ;
        "  BO.ERR="   + TRANSFORM(FILE(FORCEEXT(lcBO, "err"))) + CHR(13)+CHR(10) + ;
        "NEG.FXP="  + TRANSFORM(FILE(FORCEEXT(lcNeg, "fxp"))) + ;
        "  NEG.ERR="  + TRANSFORM(FILE(FORCEEXT(lcNeg, "err"))) + CHR(13)+CHR(10)

IF FILE(FORCEEXT(lcForm, "err"))
    lcOut = lcOut + "--- FORM.ERR ---" + CHR(13)+CHR(10) + FILETOSTR(FORCEEXT(lcForm, "err"))
ENDIF
IF FILE(FORCEEXT(lcBO, "err"))
    lcOut = lcOut + "--- BO.ERR ---" + CHR(13)+CHR(10) + FILETOSTR(FORCEEXT(lcBO, "err"))
ENDIF
IF FILE(FORCEEXT(lcNeg, "err"))
    lcOut = lcOut + "--- NEG.ERR (controle) ---" + CHR(13)+CHR(10) + FILETOSTR(FORCEEXT(lcNeg, "err"))
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\compile_f7_786.txt")
QUIT
