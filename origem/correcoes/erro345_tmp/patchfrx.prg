*==============================================================================
* Erro345 - numeros saindo como ***** em SigReEq1/SigReEq2
*
* Causa: o VFP formata o campo numerico na largura CHEIA da picture (com os
* espacos a esquerda) e imprime asteriscos quando esse texto nao cabe na caixa.
* Medido em Verdana 8 contra as caixas do FRX:
*     tQtds  "99,999.999"     0.667" em 0.7395"  = +10.9%  -> RENDERIZA
*     tPesos "9999,999.99"    0.740" em 0.7708"  = + 4.2%  -> ASTERISCOS
*     VlVenda/Vlcusto "999,999,999.99" 0.927" em 0.9166" = -1.1% -> ASTERISCOS
*
* Conserto: alargar a caixa ate a celula (sem mexer nas linhas da tabela) e
* reduzir a picture um grupo, mirando folga >= 11% (o unico valor comprovado).
*   999,999,999.99 -> 99,999,999.99   (capacidade ~100 milhoes)
*   9999,999.99    -> 999,999.99      (capacidade ~1 milhao; a mascara legada
*                                      tinha a virgula fora de lugar)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcLog, lnN
lcLog = "C:\4c\origem\correcoes\erro345_tmp\patchfrx.txt"
STRTOFILE("", lcLog)
lnN = 0

*-- SigReEq2 (sintetico)
USE "C:\4c\projeto\app\reports\SigReEq2.frx" EXCLUSIVE ALIAS f2
SELECT f2
SCAN FOR OBJTYPE = 8
    DO CASE
        CASE ALLTRIM(EXPR) == "tPesos"
            REPLACE HPOS WITH 31300, WIDTH WITH 8000, PICTURE WITH '"@Z 999,999.99"'
            lnN = lnN + 1
        CASE ALLTRIM(EXPR) == "VlVenda"
            REPLACE HPOS WITH 47550, WIDTH WITH 9600, PICTURE WITH '"@Z 99,999,999.99"'
            lnN = lnN + 1
        CASE ALLTRIM(EXPR) == "Vlcusto"
            REPLACE HPOS WITH 60800, WIDTH WITH 9650, PICTURE WITH '"@Z 99,999,999.99"'
            lnN = lnN + 1
    ENDCASE
    IF INLIST(ALLTRIM(EXPR), "tPesos", "VlVenda", "Vlcusto")
        STRTOFILE("SigReEq2 " + PADR(ALLTRIM(EXPR),10) + " hpos=" + TRANSFORM(HPOS) + ;
            " w=" + TRANSFORM(WIDTH) + " pict=" + ALLTRIM(PICTURE) + CHR(13)+CHR(10), lcLog, .T.)
    ENDIF
ENDSCAN
USE IN f2

*-- SigReEq1 (analitico)
USE "C:\4c\projeto\app\reports\SigReEq1.frx" EXCLUSIVE ALIAS f1
SELECT f1
SCAN FOR OBJTYPE = 8
    DO CASE
        CASE ALLTRIM(EXPR) == "tPesos"
            REPLACE HPOS WITH 61920, WIDTH WITH 7540, PICTURE WITH '"@Z 999,999.99"'
            lnN = lnN + 1
        CASE ALLTRIM(EXPR) == "tQtds"
            REPLACE HPOS WITH 69650, WIDTH WITH 7900
            lnN = lnN + 1
        CASE ALLTRIM(EXPR) == "VlVenda"
            REPLACE HPOS WITH 77760, WIDTH WITH 9690, PICTURE WITH '"@Z 99,999,999.99"'
            lnN = lnN + 1
        CASE ALLTRIM(EXPR) == "Vlcusto"
            REPLACE HPOS WITH 91100, WIDTH WITH 9690, PICTURE WITH '"@Z 99,999,999.99"'
            lnN = lnN + 1
    ENDCASE
    IF INLIST(ALLTRIM(EXPR), "tPesos", "tQtds", "VlVenda", "Vlcusto")
        STRTOFILE("SigReEq1 " + PADR(ALLTRIM(EXPR),10) + " hpos=" + TRANSFORM(HPOS) + ;
            " w=" + TRANSFORM(WIDTH) + " pict=" + ALLTRIM(PICTURE) + CHR(13)+CHR(10), lcLog, .T.)
    ENDIF
ENDSCAN
USE IN f1

STRTOFILE("alterados=" + TRANSFORM(lnN) + CHR(13)+CHR(10), lcLog, .T.)
QUIT
