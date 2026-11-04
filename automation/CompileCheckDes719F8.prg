*==============================================================================
* CompileCheckDes719F8.prg - compila FormSigOpDes.prg e SigOpDesBO.prg
* (Fase 8/8, task719) e grava o resultado num .txt.
*
* SET SAFETY OFF / SET RESOURCE OFF: o pipeline roda sem supervisao e
* qualquer dialogo modal o travaria (regra CLAUDE.md #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cSaida, loc_cForm, loc_cBO, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpDes.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpDesBO.prg"

*-- Apagar o .fxp e o .err ANTES: COMPILE pode nao reescrever um .fxp
*-- existente, e o teste rodaria sobre codigo velho (regra CLAUDE.md #29).
loc_cErrForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpDes.err"
loc_cErrBO   = "C:\4c\projeto\app\classes\SigOpDesBO.err"

IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpDes.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpDes.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpDesBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpDesBO.fxp"
ENDIF
IF FILE(loc_cErrForm)
    DELETE FILE (loc_cErrForm)
ENDIF
IF FILE(loc_cErrBO)
    DELETE FILE (loc_cErrBO)
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cSaida = "=== COMPILE CHECK task719 FASE 8 ===" + CHR(13) + CHR(10)

loc_cSaida = loc_cSaida + "FormSigOpDes.fxp gerado: " + ;
    IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpDes.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "SigOpDesBO.fxp gerado: " + ;
    IIF(FILE("C:\4c\projeto\app\classes\SigOpDesBO.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)

loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "--- FormSigOpDes.err ---" + CHR(13) + CHR(10)
IF FILE(loc_cErrForm)
    loc_cSaida = loc_cSaida + FILETOSTR(loc_cErrForm)
ELSE
    loc_cSaida = loc_cSaida + "(sem arquivo de erro)" + CHR(13) + CHR(10)
ENDIF

loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "--- SigOpDesBO.err ---" + CHR(13) + CHR(10)
IF FILE(loc_cErrBO)
    loc_cSaida = loc_cSaida + FILETOSTR(loc_cErrBO)
ELSE
    loc_cSaida = loc_cSaida + "(sem arquivo de erro)" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compilecheck_des719_f8.txt")

QUIT
