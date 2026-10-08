SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_oFrm, loc_cOut
loc_oFrm = CREATEOBJECT("Form")
loc_oFrm.FontName = "Tahoma"
loc_oFrm.FontSize = 8
loc_oFrm.AddObject("txt_teste", "TextBox")
loc_cOut = "TextBox via AddObject em Form(Tahoma,8):" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  FontName = [" + loc_oFrm.txt_teste.FontName + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  FontSize = " + TRANSFORM(loc_oFrm.txt_teste.FontSize) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  Format   = [" + loc_oFrm.txt_teste.Format + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  SpecialEffect = " + TRANSFORM(loc_oFrm.txt_teste.SpecialEffect) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  BorderStyle   = " + TRANSFORM(loc_oFrm.txt_teste.BorderStyle) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  BackStyle     = " + TRANSFORM(loc_oFrm.txt_teste.BackStyle) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  Alignment     = " + TRANSFORM(loc_oFrm.txt_teste.Alignment) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, "C:\4c\automation\medir_textbox_default_font.txt")
loc_oFrm = .NULL.
QUIT
