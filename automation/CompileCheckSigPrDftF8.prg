*==============================================================================
* CompileCheckSigPrDftF8.prg - Compila Formsigprdft.prg + sigprdftBO.prg e
* grava os erros de compilacao em arquivo (Fase 8 / task599).
*
* Apaga o .FXP ANTES: COMPILE pode NAO reescrever um .fxp existente, e sem
* apagar o teste roda codigo velho (CLAUDE.md regra #29).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cRes, loc_cErros
loc_cRes = ""

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprdft.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprdft.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprdftbo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigprdftbo.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprdft.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprdft.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprdftBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigprdftBO.err"
ENDIF

COMPILE C:\4c\projeto\app\classes\sigprdftBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg

loc_cRes = "FXP BO   = " + TRANSFORM(FILE("C:\4c\projeto\app\classes\sigprdftbo.fxp")) + CHR(13) + CHR(10) + ;
           "FXP Form = " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\formsigprdft.fxp")) + CHR(13) + CHR(10)

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprdft.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigprdft.err")
    loc_cRes = loc_cRes + "ERROS FORM: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS FORM: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

IF FILE("C:\4c\projeto\app\classes\sigprdftBO.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\classes\sigprdftBO.err")
    loc_cRes = loc_cRes + "ERROS BO: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS BO: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\compile_sigprdft_f8_result.txt")
QUIT
