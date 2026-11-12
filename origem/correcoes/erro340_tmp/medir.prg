SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lnPx, lnPol, lnCaixaPol, lcTxt
lcOut = ""
lcTxt = "      10137122"
*-- FRX: CBars hpos=625 w=10729 (unidades de 1/10000 pol) fonte Verdana 8
lnCaixaPol = 10729 / 10000
*-- largura do texto em pixels na fonte do FRX
lnPx  = TXTWIDTH(lcTxt, "Verdana", 8) * FONTMETRIC(6, "Verdana", 8)
lnPol = lnPx / 96          && VFP reporta metricas em 96 dpi logico
lcOut = lcOut + "texto        = [" + lcTxt + "]" + CHR(13)+CHR(10)
lcOut = lcOut + "largura texto= " + TRANSFORM(lnPx) + " px = " + TRANSFORM(ROUND(lnPol,3)) + " pol" + CHR(13)+CHR(10)
lcOut = lcOut + "caixa CBars  = " + TRANSFORM(ROUND(lnCaixaPol,3)) + " pol" + CHR(13)+CHR(10)
lcOut = lcOut + "CABE?        = " + TRANSFORM(lnPol <= lnCaixaPol) + CHR(13)+CHR(10)
lcOut = lcOut + CHR(13)+CHR(10) + "-- comparativo --" + CHR(13)+CHR(10)
lnPx  = TXTWIDTH("10137122      ", "Verdana", 8) * FONTMETRIC(6, "Verdana", 8)
lcOut = lcOut + "esq-alinhado = " + TRANSFORM(ROUND(lnPx/96,3)) + " pol (mesma largura, so muda a ordem)" + CHR(13)+CHR(10)
lnPx  = TXTWIDTH("10137122", "Verdana", 8) * FONTMETRIC(6, "Verdana", 8)
lcOut = lcOut + "so os digitos= " + TRANSFORM(ROUND(lnPx/96,3)) + " pol" + CHR(13)+CHR(10)
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro340_tmp\medir.txt")
QUIT
