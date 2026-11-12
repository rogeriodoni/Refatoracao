*==============================================================================
* CompilarF4SigOpPec778.prg - Compila FormSigOpPec (Fase 4, task778)
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

lcLog   = "C:\4c\automation\_f4_778_compilacao.txt"
lcSaida = "=== COMPILACAO Fase 4 - task778 ===" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\SigOpPecBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpPecBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpPec.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpPec.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpPecBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpPecBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpPec.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpPec.err"
ENDIF

COMPILE "C:\4c\projeto\app\classes\SigOpPecBO.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\classes\SigOpPecBO.fxp")
lcSaida = lcSaida + "BO   .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigOpPec.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\forms\operacionais\FormSigOpPec.fxp")
lcSaida = lcSaida + "Form .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\SigOpPecBO.err")
    lcSaida = lcSaida + "--- ERROS DO BO ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\SigOpPecBO.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "BO: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpPec.err")
    lcSaida = lcSaida + "--- ERROS DO FORM ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpPec.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "Form: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

QUIT
