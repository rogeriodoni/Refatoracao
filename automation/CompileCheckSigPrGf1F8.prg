*==============================================================================
* CompileCheckSigPrGf1F8.prg - compila FormSigPrGf1.prg e SigPrGf1BO.prg
* Apaga o .FXP antes: COMPILE pode NAO reescrever um .fxp existente e o teste
* seguinte rodaria codigo velho.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcRes, lcForm, lcBO, lcOut
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrGf1.prg"
lcBO   = "C:\4c\projeto\app\classes\SigPrGf1BO.prg"
lcOut  = "C:\4c\automation\compile_gf1_f8.txt"

IF FILE(STRTRAN(lcForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(lcForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(lcBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(lcBO, ".prg", ".fxp"))
ENDIF
IF FILE(lcOut)
    DELETE FILE (lcOut)
ENDIF

lcRes = ""
COMPILE (lcForm)
lcRes = lcRes + "FORM fxp=" + TRANSFORM(FILE(STRTRAN(lcForm, ".prg", ".fxp"))) + CHR(13) + CHR(10)
lcRes = lcRes + "FORM err=" + TRANSFORM(FILE(STRTRAN(lcForm, ".prg", ".err"))) + CHR(13) + CHR(10)
IF FILE(STRTRAN(lcForm, ".prg", ".err"))
    lcRes = lcRes + FILETOSTR(STRTRAN(lcForm, ".prg", ".err")) + CHR(13) + CHR(10)
ENDIF

COMPILE (lcBO)
lcRes = lcRes + "BO fxp=" + TRANSFORM(FILE(STRTRAN(lcBO, ".prg", ".fxp"))) + CHR(13) + CHR(10)
lcRes = lcRes + "BO err=" + TRANSFORM(FILE(STRTRAN(lcBO, ".prg", ".err"))) + CHR(13) + CHR(10)
IF FILE(STRTRAN(lcBO, ".prg", ".err"))
    lcRes = lcRes + FILETOSTR(STRTRAN(lcBO, ".prg", ".err")) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcRes, lcOut)
QUIT
