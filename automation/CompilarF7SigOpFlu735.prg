*==============================================================================
* CompilarF7SigOpFlu735.prg - Compila o Form do FormSIGOPFLU (Fase 7, task735)
* e grava o resultado + o tamanho do .FXP.
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF obrigatorios
* (regra #6 - execucao unattended).
* Apaga os .FXP antes: o VFP pode NAO reescrever um .fxp existente e o teste
* passaria a rodar p-code velho.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcSaida, lnQtd
LOCAL ARRAY laInfo[1, 5]

lcLog   = "C:\4c\automation\_m735\compilar_f7_sigopflu.txt"
lcSaida = "=== COMPILACAO Fase 7 - task735 ===" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\SIGOPFLUBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\SIGOPFLUBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SIGOPFLUBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SIGOPFLUBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.err")
    DELETE FILE "C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.err"
ENDIF

COMPILE "C:\4c\projeto\app\classes\SIGOPFLUBO.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\classes\SIGOPFLUBO.fxp")
lcSaida = lcSaida + "BO   .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

COMPILE "C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.fxp")
lcSaida = lcSaida + "Form .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\SIGOPFLUBO.err")
    lcSaida = lcSaida + "--- ERROS DO BO ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\SIGOPFLUBO.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "BO: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.err")
    lcSaida = lcSaida + "--- ERROS DO FORM ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "Form: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

QUIT
