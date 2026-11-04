*==============================================================================
* CompilarF7SigOpDvm726.prg - Compila o BO e o Form do FormSIGOPDVM (Fase 7,
* task726) e grava o resultado + o TAMANHO do .FXP.
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF obrigatorios
* (regra #6 - execucao unattended).
*
* Armadilhas ja medidas em tasks anteriores e evitadas aqui:
*   - FILESIZE() NAO EXISTE em VFP9 (regra #13) - tamanho vem de ADIR(), col 2.
*   - O VFP pode NAO reescrever um .fxp existente: apagar antes de compilar,
*     inclusive o .FXP DESTE script, senao re-execucoes rodam p-code velho.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcSaida, lnQtd
LOCAL ARRAY laInfo[1, 5]

lcLog   = "C:\4c\automation\_m726\compilar_f7_sigopdvm.txt"
lcSaida = "=== COMPILACAO Fase 7 - task726 ===" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\SIGOPDVMBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\SIGOPDVMBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SIGOPDVMBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SIGOPDVMBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.err"
ENDIF

COMPILE "C:\4c\projeto\app\classes\SIGOPDVMBO.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\classes\SIGOPDVMBO.fxp")
lcSaida = lcSaida + "BO   .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

COMPILE "C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.fxp")
lcSaida = lcSaida + "Form .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\SIGOPDVMBO.err")
    lcSaida = lcSaida + "--- ERROS DO BO ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\SIGOPDVMBO.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "BO: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.err")
    lcSaida = lcSaida + "--- ERROS DO FORM ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "Form: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

QUIT
