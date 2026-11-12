SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lnF
lcOut = ""
lnF = FONTMETRIC(6, "Tahoma", 8)
lcOut = lcOut + "AveCharWidth Tahoma 8 = " + TRANSFORM(lnF) + CHR(13)+CHR(10)+CHR(13)+CHR(10)
lcOut = lcOut + "texto                 px(texto)   legado.Width   folga(glifo+pad)" + CHR(13)+CHR(10)
lcOut = lcOut + "Estoque Atual         " + PADL(TXTWIDTH("Estoque Atual","Tahoma",8)*lnF, 6) + "      85            " + TRANSFORM(85 - TXTWIDTH("Estoque Atual","Tahoma",8)*lnF) + CHR(13)+CHR(10)
lcOut = lcOut + "Total                 " + PADL(TXTWIDTH("Total","Tahoma",8)*lnF, 6) + "      42            " + TRANSFORM(42 - TXTWIDTH("Total","Tahoma",8)*lnF) + CHR(13)+CHR(10)
lcOut = lcOut + CHR(13)+CHR(10) + "-- sem Width no legado (AutoSize calculou) --" + CHR(13)+CHR(10)
lcOut = lcOut + "Estoque  em :         " + PADL(TXTWIDTH("Estoque  em :","Tahoma",8)*lnF, 6) + CHR(13)+CHR(10)
lcOut = lcOut + "Grupo                 " + PADL(TXTWIDTH("Grupo","Tahoma",8)*lnF, 6) + CHR(13)+CHR(10)
lcOut = lcOut + CHR(13)+CHR(10) + "-- confere a caixa do grupo --" + CHR(13)+CHR(10)
lcOut = lcOut + "optRfestoque Width=142, botao em Left=5 -> cabe ate 137" + CHR(13)+CHR(10)
lcOut = lcOut + "opt_calcusto Width=108, Opt2 em Left=56 -> cabe ate 52" + CHR(13)+CHR(10)
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro342_tmp_medir.txt")
QUIT
