SET SAFETY OFF
SET RESOURCE OFF
LOCAL loF, lcOut, lcCap
lcOut = ""
lcCap = "Imprimir Carn" + CHR(234)

loF = CREATEOBJECT("Form")
loF.Width = 600
loF.Height = 480
loF.FontName = "Tahoma"
loF.FontSize = 8

*-- A: fonte -> AutoSize -> Caption  (ordem usada no medir746)
loF.AddObject("chkA", "CheckBox")
WITH loF.chkA
    .FontName = "Tahoma"
    .FontSize = 8
    .AutoSize = .T.
    .Caption  = lcCap
ENDWITH
lcOut = lcOut + "A fonte->AutoSize->Caption : W=" + TRANSFORM(loF.chkA.Width) + " H=" + TRANSFORM(loF.chkA.Height) + CHR(13)+CHR(10)

*-- B: fonte -> Caption -> AutoSize
loF.AddObject("chkB", "CheckBox")
WITH loF.chkB
    .FontName = "Tahoma"
    .FontSize = 8
    .Caption  = lcCap
    .AutoSize = .T.
ENDWITH
lcOut = lcOut + "B fonte->Caption->AutoSize : W=" + TRANSFORM(loF.chkB.Width) + " H=" + TRANSFORM(loF.chkB.Height) + CHR(13)+CHR(10)

*-- C: AutoSize -> Caption, SEM declarar fonte (herda do form)
loF.AddObject("chkC", "CheckBox")
WITH loF.chkC
    .AutoSize = .T.
    .Caption  = lcCap
ENDWITH
lcOut = lcOut + "C semfonte->AutoSize->Cap  : W=" + TRANSFORM(loF.chkC.Width) + " H=" + TRANSFORM(loF.chkC.Height) + CHR(13)+CHR(10)

*-- D: AutoSize .T. depois de Visible e de reatribuir Caption
loF.AddObject("chkD", "CheckBox")
WITH loF.chkD
    .FontName = "Tahoma"
    .FontSize = 8
    .AutoSize = .T.
    .Caption  = lcCap
    .Visible  = .T.
    .Caption  = lcCap
ENDWITH
lcOut = lcOut + "D +Visible +recaption      : W=" + TRANSFORM(loF.chkD.Width) + " H=" + TRANSFORM(loF.chkD.Height) + CHR(13)+CHR(10)

*-- E: AutoSize .T. e DEPOIS Width explicita (quem ganha?)
loF.AddObject("chkE", "CheckBox")
WITH loF.chkE
    .FontName = "Tahoma"
    .FontSize = 8
    .AutoSize = .T.
    .Caption  = lcCap
    .Width    = 88
    .Height   = 15
ENDWITH
lcOut = lcOut + "E AutoSize.T. + Width=88   : W=" + TRANSFORM(loF.chkE.Width) + " H=" + TRANSFORM(loF.chkE.Height) + CHR(13)+CHR(10)

*-- F: canonico que vou escrever: AutoSize .F. + Width/Height medidos
loF.AddObject("chkF", "CheckBox")
WITH loF.chkF
    .FontName = "Tahoma"
    .FontSize = 8
    .AutoSize = .F.
    .Caption  = lcCap
    .Height   = 15
    .Width    = 88
ENDWITH
lcOut = lcOut + "F AutoSize.F. + 88x15      : W=" + TRANSFORM(loF.chkF.Width) + " H=" + TRANSFORM(loF.chkF.Height) + CHR(13)+CHR(10)

*-- Faixa ocupada na linha Top=89: chkCarne(218) x chkAgrupa(351)
lcOut = lcOut + CHR(13)+CHR(10) + "chkCarne 218.." + TRANSFORM(218 + loF.chkF.Width) + ;
    "  chkAgrupa comeca em 351  -> folga=" + TRANSFORM(351 - (218 + loF.chkF.Width)) + CHR(13)+CHR(10)
lcOut = lcOut + "Lbl_Impressora 121..201  chkCarne comeca em 218 -> folga=17" + CHR(13)+CHR(10)

STRTOFILE(lcOut, "C:\4c\automation\_tmp746\medir746b.txt")
QUIT
