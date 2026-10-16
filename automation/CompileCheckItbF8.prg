*==============================================================================
* CompileCheckItbF8.prg - Compila FormSigPrItb + SigPrItbBO (Fase 8 / task632)
* Apaga o .FXP e o .err ANTES e confere que o .FXP foi recriado - a licao do
* ".FXP velho": COMPILE pode NAO reescrever um .fxp que ja existe, e o
* harness acabaria medindo codigo antigo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE SAIDA "C:\4c\automation\logs\compile_itb_f8.txt"

LOCAL loc_cForm, loc_cBO, loc_cErrForm, loc_cErrBO, loc_cFxpForm, loc_cFxpBO, loc_cTxt

loc_cForm    = "C:\4c\projeto\app\forms\operacionais\FormSigPrItb.prg"
loc_cFxpForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrItb.fxp"
loc_cErrForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrItb.err"
loc_cBO      = "C:\4c\projeto\app\classes\SigPrItbBO.prg"
loc_cFxpBO   = "C:\4c\projeto\app\classes\SigPrItbBO.fxp"
loc_cErrBO   = "C:\4c\projeto\app\classes\SigPrItbBO.err"

IF FILE(loc_cFxpForm)
    DELETE FILE (loc_cFxpForm)
ENDIF
IF FILE(loc_cErrForm)
    DELETE FILE (loc_cErrForm)
ENDIF
IF FILE(loc_cFxpBO)
    DELETE FILE (loc_cFxpBO)
ENDIF
IF FILE(loc_cErrBO)
    DELETE FILE (loc_cErrBO)
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cTxt = "COMPILE CHECK FASE 8 - task632 (FormSigPrItb)" + CHR(13) + CHR(10)
loc_cTxt = loc_cTxt + "Form .FXP recriado : " + TRANSFORM(FILE(loc_cFxpForm)) + CHR(13) + CHR(10)
loc_cTxt = loc_cTxt + "BO   .FXP recriado : " + TRANSFORM(FILE(loc_cFxpBO))   + CHR(13) + CHR(10)

IF FILE(loc_cErrForm)
    loc_cTxt = loc_cTxt + "*** ERROS NO FORM ***" + CHR(13) + CHR(10) + FILETOSTR(loc_cErrForm)
ELSE
    loc_cTxt = loc_cTxt + "Form: SEM .err (compilou limpo)" + CHR(13) + CHR(10)
ENDIF

IF FILE(loc_cErrBO)
    loc_cTxt = loc_cTxt + "*** ERROS NO BO ***" + CHR(13) + CHR(10) + FILETOSTR(loc_cErrBO)
ELSE
    loc_cTxt = loc_cTxt + "BO:   SEM .err (compilou limpo)" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cTxt, SAIDA)
QUIT
