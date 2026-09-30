*==============================================================================
* CompileCheckSigPrCpdF7.prg - Compila Formsigprcpd.prg + sigprcpdBO.prg e
* grava os erros de compilacao em arquivo (Fase 7 / task595).
*
* Apaga o .FXP ANTES: COMPILE pode NAO reescrever um .fxp existente, e sem
* apagar o teste roda codigo velho (CLAUDE.md regra #29 / licao do harness).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cRes, loc_cErros
loc_cRes = ""

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprcpd.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprcpd.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprcpdbo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigprcpdbo.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprcpdBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigprcpdBO.err"
ENDIF

COMPILE C:\4c\projeto\app\classes\sigprcpdBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg

loc_cRes = "FXP BO   = " + TRANSFORM(FILE("C:\4c\projeto\app\classes\sigprcpdbo.fxp")) + CHR(13) + CHR(10) + ;
           "FXP Form = " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\formsigprcpd.fxp")) + CHR(13) + CHR(10)

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
    loc_cRes = loc_cRes + "ERROS FORM: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS FORM: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

IF FILE("C:\4c\projeto\app\classes\sigprcpdBO.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\classes\sigprcpdBO.err")
    loc_cRes = loc_cRes + "ERROS BO: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS BO: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\compile_sigprcpd_f7_result.txt")
QUIT
