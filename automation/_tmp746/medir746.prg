SET SAFETY OFF
SET RESOURCE OFF
LOCAL loF, loC, lcOut, lnFw, i
lcOut = ""

loF = CREATEOBJECT("Form")
loF.Width = 600
loF.Height = 480
loF.FontName = "Tahoma"
loF.FontSize = 8

*-- Overhead do CheckBox: usa os dois irmaos que o SCX declara
DIMENSION laCap(3), laW(3)
laCap(1) = "Imprimir Observa" + CHR(231) + CHR(245) + "es"
laW(1)   = 122
laCap(2) = "Agrupar Informa" + CHR(231) + CHR(245) + "es"
laW(2)   = 120
laCap(3) = "Imprimir Carn" + CHR(234)
laW(3)   = 0

FOR i = 1 TO 3
    loF.AddObject("chk" + TRANSFORM(i), "CheckBox")
    loC = EVALUATE("loF.chk" + TRANSFORM(i))
    WITH loC
        .FontName = "Tahoma"
        .FontSize = 8
        .AutoSize = .T.
        .Alignment = 0
        .BackStyle = 0
        .Caption = laCap(i)
        .Visible = .T.
    ENDWITH
    *-- largura do TEXTO no contexto do proprio controle
    lnFw = TXTWIDTH(laCap(i), "Tahoma", 8) * FONTMETRIC(6, "Tahoma", 8)
    lcOut = lcOut + "[" + laCap(i) + "]" + CHR(13) + CHR(10) + ;
        "   SCX.Width=" + TRANSFORM(laW(i)) + ;
        "  TXTWIDTH_px=" + TRANSFORM(lnFw) + ;
        "  overhead=" + TRANSFORM(laW(i) - lnFw) + ;
        "  AutoSizeWidth=" + TRANSFORM(loC.Width) + ;
        "  AutoSizeHeight=" + TRANSFORM(loC.Height) + CHR(13) + CHR(10)
ENDFOR

*-- AutoSize eh no-op? comparar com AutoSize = .F.
loF.AddObject("chkF", "CheckBox")
WITH loF.chkF
    .FontName = "Tahoma"
    .FontSize = 8
    .AutoSize = .F.
    .Caption = "Imprimir Carn" + CHR(234)
    .Width = 90
    .Height = 15
    .Visible = .T.
ENDWITH
lcOut = lcOut + "chkF (AutoSize=.F., Width=90): W=" + TRANSFORM(loF.chkF.Width) + ;
    " H=" + TRANSFORM(loF.chkF.Height) + CHR(13) + CHR(10)

*-- FONTMETRIC(6) do form
lcOut = lcOut + "FONTMETRIC(6,Tahoma,8)=" + TRANSFORM(FONTMETRIC(6, "Tahoma", 8)) + CHR(13) + CHR(10)

STRTOFILE(lcOut, "C:\4c\automation\_tmp746\medir746.txt")
QUIT
