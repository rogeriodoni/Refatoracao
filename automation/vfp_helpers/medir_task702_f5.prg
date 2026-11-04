SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcOut, lcTxt, lnFM6, lnW
lcOut = "C:\4c\automation\vfp_helpers\medir_task702_f5.txt"
lcTxt = ""

*-- Tahoma 14 bold: largura media do caractere (FONTMETRIC(6))
lnFM6 = FONTMETRIC(6, "Tahoma", 14, "B")
lcTxt = lcTxt + "FONTMETRIC(6,Tahoma,14,B) = " + TRANSFORM(lnFM6) + CHR(13) + CHR(10)
lcTxt = lcTxt + REPLICATE("-", 70) + CHR(13) + CHR(10)

#DEFINE MEDE(c) TXTWIDTH(c, "Tahoma", 14, "B") * lnFM6

*-- Label2: "Representante :" em Left 405, Width 150; campo em Left 561
lnW = TXTWIDTH("Representante :", "Tahoma", 14, "B") * lnFM6
lcTxt = lcTxt + "lbl_4c_Label2 'Representante :'" + CHR(13) + CHR(10)
lcTxt = lcTxt + "   texto = " + TRANSFORM(lnW) + "px | Width = 150 -> cabe=" + ;
    IIF(lnW <= 150, "SIM", "NAO (CORTA)") + CHR(13) + CHR(10)
lcTxt = lcTxt + "   texto termina em " + TRANSFORM(405 + lnW) + ;
    " | txt_4c_Usuario comeca em 561 -> invade=" + ;
    IIF(405 + lnW < 561, "NAO", "SIM") + CHR(13) + CHR(10)

*-- Label3 estado inicial: "Senha :" em Left 486, Width 130
lnW = TXTWIDTH("Senha :", "Tahoma", 14, "B") * lnFM6
lcTxt = lcTxt + "lbl_4c_Label3 'Senha :' (inicial, Left 486)" + CHR(13) + CHR(10)
lcTxt = lcTxt + "   texto = " + TRANSFORM(lnW) + "px | Width = 130 -> cabe=" + ;
    IIF(lnW <= 130, "SIM", "NAO (CORTA)") + CHR(13) + CHR(10)
lcTxt = lcTxt + "   texto termina em " + TRANSFORM(486 + lnW) + ;
    " | txt_4c_Senha comeca em 561 -> invade=" + ;
    IIF(486 + lnW < 561, "NAO", "SIM") + CHR(13) + CHR(10)

*-- Label3 modo senha do dia: "Senha Do Dia : " em Left 142, Width 130
lnW = TXTWIDTH("Senha Do Dia : ", "Tahoma", 14, "B") * lnFM6
lcTxt = lcTxt + "lbl_4c_Label3 'Senha Do Dia : ' (senha do dia, Left 142)" + CHR(13) + CHR(10)
lcTxt = lcTxt + "   texto = " + TRANSFORM(lnW) + "px | Width = 130 -> cabe=" + ;
    IIF(lnW <= 130, "SIM", "NAO (CORTA)") + CHR(13) + CHR(10)

*-- Frase: Alignment 2 (centro) em caixa de 968, WordWrap
lnW = TXTWIDTH("Valor da Condicao de Pagamento COND PAGTO 30/60 foi excedido!", ;
    "Tahoma", 14, "B") * lnFM6
lcTxt = lcTxt + "lbl_4c_Frase (frase mais longa medida)" + CHR(13) + CHR(10)
lcTxt = lcTxt + "   texto = " + TRANSFORM(lnW) + "px | Width = 968 -> 1 linha=" + ;
    IIF(lnW <= 968, "SIM", "NAO (quebra, Height 34 cobre 2 linhas?)") + CHR(13) + CHR(10)
lcTxt = lcTxt + "   altura de 1 linha = " + ;
    TRANSFORM(FONTMETRIC(1, "Tahoma", 14, "B")) + "px | Height = 34" + CHR(13) + CHR(10)

STRTOFILE(lcTxt, lcOut)
QUIT
