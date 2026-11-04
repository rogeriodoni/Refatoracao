*==============================================================================
* CompilarF6Sigopdtf725.prg - Compila o BO e o Form do Formsigopdtf (Fase 6,
* task725) e grava o resultado passo a passo. Script auxiliar de pipeline:
* SET SAFETY OFF + SET RESOURCE OFF obrigatorios (regra #6 - execucao
* unattended). Apaga os .FXP antes (o VFP pode NAO reescrever um .fxp
* existente - regra ja medida na Fase 5 desta mesma task).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcSaida, lnQtd
LOCAL ARRAY laInfo[1, 5]

lcLog   = "C:\4c\automation\_m725\compilar_f6_sigopdtf.txt"
lcSaida = "=== COMPILACAO Fase 6 - task725 ===" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\sigopdtfBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigopdtfBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopdtf.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigopdtf.fxp"
ENDIF

COMPILE "C:\4c\projeto\app\classes\sigopdtfBO.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\classes\sigopdtfBO.fxp")
lcSaida = lcSaida + "BO   .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

COMPILE "C:\4c\projeto\app\forms\operacionais\Formsigopdtf.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\forms\operacionais\Formsigopdtf.fxp")
lcSaida = lcSaida + "Form .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\sigopdtfBO.err")
    lcSaida = lcSaida + "--- ERROS DO BO ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\sigopdtfBO.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "BO: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopdtf.err")
    lcSaida = lcSaida + "--- ERROS DO FORM ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigopdtf.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "Form: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

QUIT
