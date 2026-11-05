*==============================================================================
* CompilarF4SigOpFpg736.prg - Compila o Form do FormSigOpFpg (Fase 4, task736)
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

lcLog   = "C:\4c\automation\_m736\compilar_f4_sigopfpg.txt"
lcSaida = "=== COMPILACAO Fase 4 - task736 ===" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\SigOpFpgBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpFpgBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpFpgBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpFpgBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.err"
ENDIF

COMPILE "C:\4c\projeto\app\classes\SigOpFpgBO.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\classes\SigOpFpgBO.fxp")
lcSaida = lcSaida + "BO   .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.fxp")
lcSaida = lcSaida + "Form .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\SigOpFpgBO.err")
    lcSaida = lcSaida + "--- ERROS DO BO ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\SigOpFpgBO.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "BO: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.err")
    lcSaida = lcSaida + "--- ERROS DO FORM ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "Form: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

QUIT
