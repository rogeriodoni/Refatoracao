*==============================================================================
* CompilarF4SigOpFtc737.prg - Compila o Form do Formsigopftc (Fase 4, task737)
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

lcLog   = "C:\4c\automation\_f4_737_compilacao.txt"
lcSaida = "=== COMPILACAO Fase 4 - task737 ===" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\sigopftcBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigopftcBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopftc.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigopftc.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopftcBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigopftcBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopftc.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigopftc.err"
ENDIF

COMPILE "C:\4c\projeto\app\classes\sigopftcBO.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\classes\sigopftcBO.fxp")
lcSaida = lcSaida + "BO   .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

COMPILE "C:\4c\projeto\app\forms\operacionais\Formsigopftc.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\forms\operacionais\Formsigopftc.fxp")
lcSaida = lcSaida + "Form .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\sigopftcBO.err")
    lcSaida = lcSaida + "--- ERROS DO BO ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\sigopftcBO.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "BO: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopftc.err")
    lcSaida = lcSaida + "--- ERROS DO FORM ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigopftc.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "Form: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

QUIT
