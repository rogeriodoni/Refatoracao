SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_oF
loc_cOut = ""

loc_oF = CREATEOBJECT("Form")
loc_oF.AddObject("cbo0", "ComboBox")
loc_oF.AddObject("cbo2", "ComboBox")

WITH loc_oF.cbo0
    .Style = 0
    .AddItem("Janeiro")
    .AddItem("Fevereiro")
    .Visible = .T.
ENDWITH
WITH loc_oF.cbo2
    .Style = 2
    .AddItem("Janeiro")
    .AddItem("Fevereiro")
    .Visible = .T.
ENDWITH
loc_oF.Show()

*-- Prova 1: ReadOnly existe nas duas? (a propriedade que o gate procura)
loc_cOut = loc_cOut + "cbo0.Style=" + TRANSFORM(loc_oF.cbo0.Style) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "cbo2.Style=" + TRANSFORM(loc_oF.cbo2.Style) + CHR(13) + CHR(10)

*-- Prova 2: digitacao simulada de texto FORA da lista
loc_oF.cbo0.SetFocus()
KEYBOARD "Zebra" PLAIN
DOEVENTS
loc_cOut = loc_cOut + "cbo0 apos digitar Zebra: DisplayValue=[" + ;
    TRANSFORM(loc_oF.cbo0.DisplayValue) + "] Value=[" + TRANSFORM(loc_oF.cbo0.Value) + "]" + CHR(13) + CHR(10)

loc_oF.cbo2.SetFocus()
KEYBOARD "Zebra" PLAIN
DOEVENTS
loc_cOut = loc_cOut + "cbo2 apos digitar Zebra: DisplayValue=[" + ;
    TRANSFORM(loc_oF.cbo2.DisplayValue) + "] Value=[" + TRANSFORM(loc_oF.cbo2.Value) + "]" + CHR(13) + CHR(10)

*-- Prova 3: atribuir texto fora da lista por codigo
loc_oF.cbo0.DisplayValue = "Zebra"
loc_oF.cbo2.DisplayValue = "Zebra"
loc_cOut = loc_cOut + "cbo0.DisplayValue apos atribuir=[" + TRANSFORM(loc_oF.cbo0.DisplayValue) + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "cbo2.DisplayValue apos atribuir=[" + TRANSFORM(loc_oF.cbo2.DisplayValue) + "]" + CHR(13) + CHR(10)

loc_oF.Release()
STRTOFILE(loc_cOut, "C:\4c\automation\medir_combo_style2.txt")
QUIT
