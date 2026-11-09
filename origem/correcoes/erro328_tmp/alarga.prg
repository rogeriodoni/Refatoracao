SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loE
lcOut = "C:\4c\refatoracao\origem\correcoes\erro328_tmp\alarga.txt"
STRTOFILE("", lcOut)
TRY
    SELECT 0
    USE "C:\4c\refatoracao\projeto\app\reports\SigReCtc.frx" EXCLUSIVE ALIAS frxa
    *-- quem esta nas linhas dos totais (vpos 32083 / 35833 / 40104), para conferir sobreposicao
    SCAN FOR INLIST(INT(vpos), 32083, 35833, 40104) AND INLIST(objtype, 5, 6, 7, 8)
        STRTOFILE("antes rec=" + PADL(RECNO(), 3) + " t=" + TRANSFORM(objtype) + " vpos=" + TRANSFORM(INT(vpos)) + " " + TRANSFORM(INT(hpos)) + ".." + TRANSFORM(INT(hpos + width)) + " [" + LEFT(ALLTRIM(expr), 30) + "]" + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    *-- Totais de Valor Bruto: cresce 500 para a ESQUERDA (borda direita fica igual)
    REPLACE hpos WITH hpos - 500, width WITH width + 500 ;
        FOR objtype = 8 AND INLIST(UPPER(ALLTRIM(expr)), "TOTAL_CARTAO", "TOTAL_EMPRESA", "TOTAL_GERAL")
    *-- Totais de Valor Liquido: o vizinho da esquerda termina em 89583 -> 300 p/ esquerda + 200 p/ direita
    REPLACE hpos WITH hpos - 300, width WITH width + 500 ;
        FOR objtype = 8 AND INLIST(UPPER(ALLTRIM(expr)), "TOTLIQ_CARTAO", "TOTLIQ_EMPRESA", "TOTLIQ_GERAL")
    SCAN FOR INLIST(INT(vpos), 32083, 35833, 40104) AND INLIST(objtype, 5, 6, 7, 8)
        STRTOFILE("depois rec=" + PADL(RECNO(), 3) + " vpos=" + TRANSFORM(INT(vpos)) + " " + TRANSFORM(INT(hpos)) + ".." + TRANSFORM(INT(hpos + width)) + " w=" + TRANSFORM(INT(width)) + " [" + LEFT(ALLTRIM(expr), 30) + "]" + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    USE IN frxa
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message, lcOut, .T.)
ENDTRY
QUIT
