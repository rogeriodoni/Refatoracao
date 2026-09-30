SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cLog, loc_oF
loc_cLog = ""

PUBLIC gb_TesteColuna
loF = CREATEOBJECT("Form")
loF.Width = 400
loF.Height = 300
loF.AddObject("grd", "Grid")
loF.grd.ColumnCount = 2
loF.grd.Visible = .T.

loc_cLog = loc_cLog + "PEMSTATUS(Column,'SetFocus',5) = " + TRANSFORM(PEMSTATUS(loF.grd.Column1, "SetFocus", 5)) + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "PEMSTATUS(Column,'Refresh',5)  = " + TRANSFORM(PEMSTATUS(loF.grd.Column1, "Refresh", 5)) + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "PEMSTATUS(Column,'ZOrder',5)   = " + TRANSFORM(PEMSTATUS(loF.grd.Column1, "ZOrder", 5)) + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "PEMSTATUS(Grid,'ZOrder',5)     = " + TRANSFORM(PEMSTATUS(loF.grd, "ZOrder", 5)) + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "PEMSTATUS(Container,'ZOrder',5)= " + TRANSFORM(PEMSTATUS(CREATEOBJECT("Container"), "ZOrder", 5)) + CHR(13) + CHR(10)

TRY
    loF.Show()
    loF.grd.Column1.SetFocus()
    loc_cLog = loc_cLog + "Column1.SetFocus() -> OK" + CHR(13) + CHR(10)
CATCH TO loE
    loc_cLog = loc_cLog + "Column1.SetFocus() -> ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cLog, "C:\4c\automation\medir_column_setfocus.txt")
loF.Release()
QUIT
