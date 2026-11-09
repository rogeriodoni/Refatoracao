SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loE
lcOut = "C:\4c\refatoracao\origem\correcoes\erro329_tmp\aplica.txt"
STRTOFILE("", lcOut)
TRY
    SELECT 0
    USE "C:\4c\refatoracao\projeto\app\reports\SigReCtc.frx" EXCLUSIVE ALIAS frxp
    *-- Totais em negrito: 11708 de largura (medido no preview real do motor 80),
    *-- crescendo so para a ESQUERDA: borda direita = a do legado.
    REPLACE hpos WITH (hpos + width) - 11708, width WITH 11708 ;
        FOR objtype = 8 AND INLIST(UPPER(ALLTRIM(expr)), "TOTAL_CARTAO", "TOTAL_EMPRESA", "TOTAL_GERAL", "TOTLIQ_CARTAO", "TOTLIQ_EMPRESA", "TOTLIQ_GERAL")
    SCAN FOR objtype = 8 AND INLIST(UPPER(ALLTRIM(expr)), "TOTAL_CARTAO", "TOTAL_EMPRESA", "TOTAL_GERAL", "TOTLIQ_CARTAO", "TOTLIQ_EMPRESA", "TOTLIQ_GERAL")
        STRTOFILE(PADR(ALLTRIM(expr), 16) + TRANSFORM(INT(hpos)) + ".." + TRANSFORM(INT(hpos + width)) + " w=" + TRANSFORM(INT(width)) + " style=" + TRANSFORM(fontstyle) + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    USE IN frxp
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message, lcOut, .T.)
ENDTRY
QUIT
