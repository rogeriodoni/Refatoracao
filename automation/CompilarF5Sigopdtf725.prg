*==============================================================================
* CompilarF5Sigopdtf725.prg - Compila o BO e o Form do Formsigopdtf (Fase 5,
* task725) e grava, passo a passo, o resultado + o TAMANHO do .FXP.
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF obrigatorios
* (regra #6 - execucao unattended).
*
* Para que serve o TAMANHO do .FXP: provar que uma alteracao no .prg foi SO de
* comentario - mesmo tamanho antes/depois, compilando no MESMO path. Nao usar
* md5 do .FXP: ele embute o caminho do fonte e nao eh reprodutivel entre
* compilacoes distantes no tempo.
*
* DUAS armadilhas medidas nesta task, encadeadas - juntas deixam o vfp9.exe
* PENDURADO num dialogo modal (sem .FXP do alvo e sem log, exigindo
* Stop-Process):
*   1. FILESIZE() NAO EXISTE em VFP9 - nome desconhecido faz o interpretador
*      procurar FILESIZE.PRG em disco e estourar em RUNTIME (regra #13).
*      Tamanho de arquivo se obtem por ADIR() (coluna 2 do array).
*   2. O .FXP DESTE PROPRIO script fica VELHO: o VFP nao reescreve um .fxp
*      existente, entao depois da 1a execucao com FILESIZE() todas as
*      seguintes continuaram rodando o p-code ANTIGO e travando do mesmo
*      jeito - corrigir o .prg nao adiantava nada. ASSINATURA do problema:
*      o script passa a COMPILAR LIMPO (conferido com COMPILE + leitura do
*      .ERR) e MESMO ASSIM trava igual. Apagar o .FXP do script antes de
*      re-executar. Os STRTOFILE a cada checkpoint ficam porque o log
*      parcial mostra em que ponto parou.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcSaida, lnQtd
LOCAL ARRAY laInfo[1, 5]

lcLog   = "C:\4c\automation\_m725\compilar_f5_sigopdtf.txt"
lcSaida = "=== COMPILACAO Fase 5 - task725 ===" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcLog)

*-- Apaga os .FXP antes (o VFP pode NAO reescrever um .fxp existente)
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

*-- O COMPILE grava os erros num .ERR ao lado do .prg
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
