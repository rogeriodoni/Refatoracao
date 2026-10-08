*==============================================================================
* CompileCheckSigPrIcoF7.prg - Fase 7 / task624 (sigprico).
*
* Compila sigpricoBO.prg + Formsigprico.prg e grava os erros em arquivo.
* Apaga os .FXP ANTES: COMPILE pode NAO reescrever um .fxp existente e o teste
* rodaria codigo velho (CLAUDE.md regra #29).
*
* A INSTANCIACAO fica em automation\ProbeIcoF7.prg - compilar limpo nao prova
* que a tela abre (CLAUDE.md regra #34).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cRes, loc_cErros
loc_cRes = ""

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprico.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprico.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigpricobo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigpricobo.fxp"
ENDIF

COMPILE C:\4c\projeto\app\classes\sigpricoBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\Formsigprico.prg

loc_cRes = "FXP BO   = " + TRANSFORM(FILE("C:\4c\projeto\app\classes\sigpricobo.fxp")) + CHR(13) + CHR(10) + ;
           "FXP Form = " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\formsigprico.fxp")) + CHR(13) + CHR(10)

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprico.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigprico.err")
    loc_cRes = loc_cRes + "ERROS FORM: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS FORM: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

IF FILE("C:\4c\projeto\app\classes\sigpricoBO.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\classes\sigpricoBO.err")
    loc_cRes = loc_cRes + "ERROS BO: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS BO: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\compile_sigprico_f7_result.txt")
QUIT
