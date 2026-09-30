*==============================================================================
* CompileCheckSigPrChrF8.prg - Compila FormSigPrChr.prg + SigPrChrBO.prg e
* grava os erros de compilacao em arquivo (Fase 8 / task590).
*
* Apaga o .FXP ANTES: COMPILE pode NAO reescrever um .fxp existente, e sem
* apagar o teste roda codigo velho (CLAUDE.md regra #29 / licao do harness).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cRes, loc_cErros
loc_cRes = ""

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprchr.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprchr.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprchrbo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigprchrbo.fxp"
ENDIF
IF FILE("C:\4c\automation\erros_compile_sigprchr_f8.err")
    DELETE FILE "C:\4c\automation\erros_compile_sigprchr_f8.err"
ENDIF

COMPILE C:\4c\projeto\app\classes\SigPrChrBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg

loc_cRes = "FXP BO   = " + TRANSFORM(FILE("C:\4c\projeto\app\classes\sigprchrbo.fxp")) + CHR(13) + CHR(10) + ;
           "FXP Form = " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\formsigprchr.fxp")) + CHR(13) + CHR(10)

*-- COMPILE grava os erros num .err com o nome do fonte
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrChr.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrChr.err")
    loc_cRes = loc_cRes + "ERROS FORM: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS FORM: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

IF FILE("C:\4c\projeto\app\classes\SigPrChrBO.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\classes\SigPrChrBO.err")
    loc_cRes = loc_cRes + "ERROS BO: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS BO: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\compile_sigprchr_f8_result.txt")
QUIT
