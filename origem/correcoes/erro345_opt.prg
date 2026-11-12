SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lnF8, lnF7
lcOut = ""
lnF8 = FONTMETRIC(6, "Verdana", 8)
lnF7 = FONTMETRIC(6, "Verdana", 7)
lcOut = lcOut + "picture                 Verdana8(pol)  Verdana7(pol)" + CHR(13)+CHR(10)
LOCAL ARRAY laP[5]
laP[1] = "999,999,999.99"
laP[2] = "99,999,999.99"
laP[3] = "9,999,999.99"
laP[4] = "9999,999.99"
laP[5] = "999,999.99"
LOCAL lnI
FOR lnI = 1 TO 5
    lcOut = lcOut + PADR(laP[lnI], 24) + ;
        PADR(TRANSFORM(ROUND(TXTWIDTH(laP[lnI],"Verdana",8)*lnF8/96, 4)), 15) + ;
        TRANSFORM(ROUND(TXTWIDTH(laP[lnI],"Verdana",7)*lnF7/96, 4)) + CHR(13)+CHR(10)
ENDFOR
lcOut = lcOut + CHR(13)+CHR(10) + "-- caixas disponiveis (celula inteira, em pol) --" + CHR(13)+CHR(10)
lcOut = lcOut + "SigReEq2 tPesos : 0.8125   VlVenda: 0.9687   Vlcusto: 0.9791" + CHR(13)+CHR(10)
lcOut = lcOut + "SigReEq1 tPesos : 0.7604   VlVenda: 0.9792   Vlcusto: 0.9792" + CHR(13)+CHR(10)
lcOut = lcOut + CHR(13)+CHR(10) + "-- referencia medida na imagem do usuario --" + CHR(13)+CHR(10)
lcOut = lcOut + "tQtds  picture 0.667 em caixa 0.7395 = +10.9%  -> RENDERIZA" + CHR(13)+CHR(10)
lcOut = lcOut + "tPesos picture 0.740 em caixa 0.7708 = + 4.2%  -> ASTERISCOS" + CHR(13)+CHR(10)
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro345_opt.txt")
QUIT
