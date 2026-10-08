*==============================================================================
* CompileCheckSigPriblF8.prg - Compila FormSIGPRIBL.prg + SIGPRIBLBO.prg e
* grava os erros de compilacao em arquivo (Fase 8 / task623).
*
* Apaga o .FXP ANTES: COMPILE pode NAO reescrever um .fxp existente, e sem
* apagar o teste roda codigo velho (CLAUDE.md regra #29 / licao do harness).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cRes, loc_cErros
loc_cRes = ""

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigpribl.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigpribl.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigpriblbo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigpriblbo.fxp"
ENDIF

COMPILE C:\4c\projeto\app\classes\SIGPRIBLBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.prg

loc_cRes = "FXP BO   = " + TRANSFORM(FILE("C:\4c\projeto\app\classes\sigpriblbo.fxp")) + CHR(13) + CHR(10) + ;
           "FXP Form = " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\formsigpribl.fxp")) + CHR(13) + CHR(10)

*-- COMPILE grava os erros num .err com o nome do fonte
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.err")
    loc_cRes = loc_cRes + "ERROS FORM: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS FORM: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

IF FILE("C:\4c\projeto\app\classes\SIGPRIBLBO.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\classes\SIGPRIBLBO.err")
    loc_cRes = loc_cRes + "ERROS BO: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS BO: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\compile_sigpribl_f8_result.txt")
QUIT
