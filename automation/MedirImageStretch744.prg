*-- MedirImageStretch744.prg
*-- Mede o comportamento REAL do Image do VFP9 quanto a Width/Height
*-- declarados x tamanho natural do .jpg, com e sem Stretch.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE OUT "C:\4c\automation\medir_image744_out.txt"

LOCAL loc_cR, loc_oF
loc_cR = ""

loc_oF = CREATEOBJECT("Form")
loc_oF.Width  = 400
loc_oF.Height = 300

*-- A) ordem do form migrado: Top/Left/Width/Height/BackStyle/Picture
loc_oF.AddObject("imgA", "Image")
WITH loc_oF.imgA
    .Top       = 95
    .Left      = 84
    .Width     = 76
    .Height    = 77
    .BackStyle = 0
    .Picture   = "C:\4c\vbmp\gaveta.jpg"
ENDWITH
loc_cR = loc_cR + "A ordem W/H antes do Picture, Stretch default=" + ;
         TRANSFORM(loc_oF.imgA.Stretch) + " -> WxH=" + ;
         TRANSFORM(loc_oF.imgA.Width) + "x" + TRANSFORM(loc_oF.imgA.Height) + CHR(13) + CHR(10)

*-- B) Picture ANTES de Width/Height
loc_oF.AddObject("imgB", "Image")
WITH loc_oF.imgB
    .BackStyle = 0
    .Picture   = "C:\4c\vbmp\gaveta.jpg"
    .Width     = 76
    .Height    = 77
ENDWITH
loc_cR = loc_cR + "B Picture antes de W/H -> WxH=" + ;
         TRANSFORM(loc_oF.imgB.Width) + "x" + TRANSFORM(loc_oF.imgB.Height) + CHR(13) + CHR(10)

*-- C) Stretch = 1 (Isometric), W/H antes do Picture
loc_oF.AddObject("imgC", "Image")
WITH loc_oF.imgC
    .Width     = 76
    .Height    = 77
    .BackStyle = 0
    .Stretch   = 1
    .Picture   = "C:\4c\vbmp\gaveta.jpg"
ENDWITH
loc_cR = loc_cR + "C Stretch=1 -> WxH=" + ;
         TRANSFORM(loc_oF.imgC.Width) + "x" + TRANSFORM(loc_oF.imgC.Height) + CHR(13) + CHR(10)

*-- D) Stretch = 2 (Stretch), W/H antes do Picture
loc_oF.AddObject("imgD", "Image")
WITH loc_oF.imgD
    .Width     = 76
    .Height    = 77
    .BackStyle = 0
    .Stretch   = 2
    .Picture   = "C:\4c\vbmp\gaveta.jpg"
ENDWITH
loc_cR = loc_cR + "D Stretch=2 -> WxH=" + ;
         TRANSFORM(loc_oF.imgD.Width) + "x" + TRANSFORM(loc_oF.imgD.Height) + CHR(13) + CHR(10)

*-- E) Stretch=0 e REAPLICAR W/H DEPOIS do Picture
loc_oF.AddObject("imgE", "Image")
WITH loc_oF.imgE
    .Top       = 95
    .Left      = 84
    .Width     = 76
    .Height    = 77
    .BackStyle = 0
    .Picture   = "C:\4c\vbmp\gaveta.jpg"
    .Width     = 76
    .Height    = 77
ENDWITH
loc_cR = loc_cR + "E reaplicar W/H depois do Picture -> WxH=" + ;
         TRANSFORM(loc_oF.imgE.Width) + "x" + TRANSFORM(loc_oF.imgE.Height) + CHR(13) + CHR(10)

*-- F) tamanho natural: Image SEM W/H declarados
loc_oF.AddObject("imgF", "Image")
loc_oF.imgF.Picture = "C:\4c\vbmp\gaveta.jpg"
loc_cR = loc_cR + "F natural (sem W/H) -> WxH=" + ;
         TRANSFORM(loc_oF.imgF.Width) + "x" + TRANSFORM(loc_oF.imgF.Height) + CHR(13) + CHR(10)

*-- G) Image sem Picture: W/H declarados sobrevivem?
loc_oF.AddObject("imgG", "Image")
loc_oF.imgG.Width  = 76
loc_oF.imgG.Height = 77
loc_cR = loc_cR + "G sem Picture -> WxH=" + ;
         TRANSFORM(loc_oF.imgG.Width) + "x" + TRANSFORM(loc_oF.imgG.Height) + CHR(13) + CHR(10)

*-- H) depois de Show(): Stretch=0 com W/H reaplicados continua?
loc_cR = loc_cR + "H imgE pos-conf WxH=" + ;
         TRANSFORM(loc_oF.imgE.Width) + "x" + TRANSFORM(loc_oF.imgE.Height) + CHR(13) + CHR(10)

STRTOFILE(loc_cR, OUT)
QUIT
