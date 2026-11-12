SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lnF, lcT
lcOut = ""
lnF = FONTMETRIC(6, "Verdana", 8)
lcOut = lcOut + "AveCharWidth Verdana 8 = " + TRANSFORM(lnF) + CHR(13)+CHR(10)+CHR(13)+CHR(10)

SET POINT TO "."
SET SEPARATOR TO ","

lcOut = lcOut + "campo      caixa(pol)  valor            texto formatado   largura(pol)  CABE?" + CHR(13)+CHR(10)

*-- tQtds: caixa 7395, picture "@Z 99,999.999"
lcT = TRANSFORM(236.000, "@Z 99,999.999")
lcOut = lcOut + "tQtds      " + PADR(TRANSFORM(7395/10000), 11) + PADR("236.000", 17) + ;
    "[" + lcT + "]" + SPACE(MAX(0, 18 - LEN(lcT))) + ;
    PADR(TRANSFORM(ROUND(TXTWIDTH(lcT,"Verdana",8)*lnF/96, 3)), 14) + ;
    TRANSFORM(TXTWIDTH(lcT,"Verdana",8)*lnF/96 <= 7395/10000) + CHR(13)+CHR(10)

*-- VlVenda: caixa 9166, picture "@Z 999,999,999.99"
lcT = TRANSFORM(5580859.36, "@Z 999,999,999.99")
lcOut = lcOut + "VlVenda    " + PADR(TRANSFORM(9166/10000), 11) + PADR("5580859.36", 17) + ;
    "[" + lcT + "]" + SPACE(MAX(0, 18 - LEN(lcT))) + ;
    PADR(TRANSFORM(ROUND(TXTWIDTH(lcT,"Verdana",8)*lnF/96, 3)), 14) + ;
    TRANSFORM(TXTWIDTH(lcT,"Verdana",8)*lnF/96 <= 9166/10000) + CHR(13)+CHR(10)

*-- Vlcusto
lcT = TRANSFORM(1886172.21, "@Z 999,999,999.99")
lcOut = lcOut + "Vlcusto    " + PADR(TRANSFORM(9166/10000), 11) + PADR("1886172.21", 17) + ;
    "[" + lcT + "]" + SPACE(MAX(0, 18 - LEN(lcT))) + ;
    PADR(TRANSFORM(ROUND(TXTWIDTH(lcT,"Verdana",8)*lnF/96, 3)), 14) + ;
    TRANSFORM(TXTWIDTH(lcT,"Verdana",8)*lnF/96 <= 9166/10000) + CHR(13)+CHR(10)

*-- tPesos: caixa 7708, picture "@Z 9999,999.99"  (mascara com virgula fora de lugar)
lcT = TRANSFORM(0.00, "@Z 9999,999.99")
lcOut = lcOut + "tPesos(0)  " + PADR(TRANSFORM(7708/10000), 11) + PADR("0.00", 17) + ;
    "[" + lcT + "]" + SPACE(MAX(0, 18 - LEN(lcT))) + ;
    PADR(TRANSFORM(ROUND(TXTWIDTH(lcT,"Verdana",8)*lnF/96, 3)), 14) + ;
    TRANSFORM(TXTWIDTH(lcT,"Verdana",8)*lnF/96 <= 7708/10000) + CHR(13)+CHR(10)

lcOut = lcOut + CHR(13)+CHR(10) + "-- largura MAXIMA que cada picture pode gerar --" + CHR(13)+CHR(10)
lcT = "99,999.999"
lcOut = lcOut + "99,999.999        = " + TRANSFORM(ROUND(TXTWIDTH(lcT,"Verdana",8)*lnF/96,3)) + " pol  (caixa 0.7395)" + CHR(13)+CHR(10)
lcT = "999,999,999.99"
lcOut = lcOut + "999,999,999.99    = " + TRANSFORM(ROUND(TXTWIDTH(lcT,"Verdana",8)*lnF/96,3)) + " pol  (caixa 0.9166)" + CHR(13)+CHR(10)
lcT = "9999,999.99"
lcOut = lcOut + "9999,999.99       = " + TRANSFORM(ROUND(TXTWIDTH(lcT,"Verdana",8)*lnF/96,3)) + " pol  (caixa 0.7708)" + CHR(13)+CHR(10)

STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro345_medir.txt")
QUIT
