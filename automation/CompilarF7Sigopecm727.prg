*==============================================================================
* CompilarF7Sigopecm727.prg - Compila o BO e o Form do Formsigopecm (Fase 7,
* task727) e grava o resultado + o TAMANHO do .FXP.
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF obrigatorios
* (regra #6 - execucao unattended).
*
* O TAMANHO do .FXP serve para provar que a alteracao do .prg foi SO de
* comentario (mesmo tamanho antes/depois, compilando no MESMO path). NAO usar
* md5 do .FXP: ele embute o caminho do fonte e nao eh reprodutivel entre
* compilacoes distantes no tempo (medido na task717).
*
* Armadilhas herdadas da task725, ja evitadas aqui:
*   1. FILESIZE() NAO EXISTE em VFP9 - tamanho se obtem por ADIR() (coluna 2);
*   2. o .FXP DESTE script fica VELHO (o VFP nao reescreve .fxp existente) -
*      apagar o .fxp do script antes de re-executar.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcSaida, lnQtd
LOCAL ARRAY laInfo[1, 5]

lcLog   = "C:\4c\automation\_m727\compilar_f7_sigopecm.txt"
lcSaida = "=== COMPILACAO Fase 7 - task727 ===" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\sigopecmBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigopecmBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopecm.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigopecm.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopecmBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigopecmBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopecm.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigopecm.err"
ENDIF

COMPILE "C:\4c\projeto\app\classes\sigopecmBO.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\classes\sigopecmBO.fxp")
lcSaida = lcSaida + "BO   .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

COMPILE "C:\4c\projeto\app\forms\operacionais\Formsigopecm.prg"
lnQtd   = ADIR(laInfo, "C:\4c\projeto\app\forms\operacionais\Formsigopecm.fxp")
lcSaida = lcSaida + "Form .fxp tamanho: " + TRANSFORM(IIF(lnQtd > 0, laInfo[1, 2], -1)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\classes\sigopecmBO.err")
    lcSaida = lcSaida + "--- ERROS DO BO ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\sigopecmBO.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "BO: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopecm.err")
    lcSaida = lcSaida + "--- ERROS DO FORM ---" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigopecm.err") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "Form: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcLog)

QUIT
