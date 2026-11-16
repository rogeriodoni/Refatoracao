SET SAFETY OFF
SET RESOURCE OFF
SYS(2335,0)
LOCAL lcCap, lcOut, lnS, lnW
lcCap = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque  por Grupo de Produto/Faixa de Valor"
lcOut = ""
FOR lnS = 9 TO 14
    lnW = TXTWIDTH(lcCap, "Tahoma", lnS, "B") * FONTMETRIC(6, "Tahoma", lnS, "B")
    lcOut = lcOut + "size=" + TRANSFORM(lnS) + " width=" + TRANSFORM(ROUND(lnW,0)) + CHR(13)+CHR(10)
ENDFOR
STRTOFILE(lcOut, "C:\4c\refatoracao\automation\erro363\medir_out.txt")
QUIT
