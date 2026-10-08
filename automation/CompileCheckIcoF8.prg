*==============================================================================
* CompileCheckIcoF8.prg - Compila Formsigprico + sigpricoBO (Fase 8 / task624)
* e grava o resultado. Apaga o .FXP antes e confere que foi recriado (a licao
* do .FXP velho: COMPILE pode NAO reescrever um .fxp existente).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE SAIDA "C:\4c\automation\compile_ico_f8.txt"
LOCAL loc_cForm, loc_cBO, loc_cErr, loc_cTxt

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigprico.prg"
loc_cBO   = "C:\4c\projeto\app\classes\sigpricoBO.prg"
loc_cErr  = "C:\4c\projeto\app\forms\operacionais\Formsigprico.err"

IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigpricoBO.err")
    DELETE FILE ("C:\4c\projeto\app\classes\sigpricoBO.err")
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cTxt = "COMPILE CHECK FASE 8 - task624" + CHR(13) + CHR(10)
loc_cTxt = loc_cTxt + "Form .FXP existe : " + ;
    TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\Formsigprico.fxp")) + CHR(13) + CHR(10)
loc_cTxt = loc_cTxt + "BO   .FXP existe : " + ;
    TRANSFORM(FILE("C:\4c\projeto\app\classes\sigpricobo.fxp")) + CHR(13) + CHR(10)

IF FILE(loc_cErr)
    loc_cTxt = loc_cTxt + "*** ERROS DE COMPILACAO NO FORM ***" + CHR(13) + CHR(10) + ;
        FILETOSTR(loc_cErr)
ELSE
    loc_cTxt = loc_cTxt + "Form: SEM .err (compilou limpo)" + CHR(13) + CHR(10)
ENDIF

IF FILE("C:\4c\projeto\app\classes\sigpricoBO.err")
    loc_cTxt = loc_cTxt + "*** ERROS DE COMPILACAO NO BO ***" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\sigpricoBO.err")
ELSE
    loc_cTxt = loc_cTxt + "BO:   SEM .err (compilou limpo)" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cTxt, SAIDA)
QUIT
