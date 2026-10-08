SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cLog
loc_cLog = "C:\4c\automation\logs\medir_header_reset.txt"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

CREATE CURSOR cur1 (A C(10), B C(10))
APPEND BLANK

LOCAL loc_oForm, loc_oGrid
loc_oForm = CREATEOBJECT("Form")
loc_oForm.AddObject("grd1", "Grid")
loc_oGrid = loc_oForm.grd1
loc_oGrid.RecordSource = ""
loc_oGrid.ColumnCount  = 2
loc_oGrid.RecordSource = "cur1"
loc_oGrid.Column1.ControlSource = "cur1.A"
loc_oGrid.Column2.ControlSource = "cur1.B"
loc_oGrid.Column1.Header1.Caption = "Grupo"
loc_oGrid.Column2.Header1.Caption = "Conta"
loc_oGrid.Column1.Width = 80

LogIt(loc_cLog, "1 apos setup inicial: H1=[" + loc_oGrid.Column1.Header1.Caption + "] H2=[" + loc_oGrid.Column2.Header1.Caption + "] W1=" + TRANSFORM(loc_oGrid.Column1.Width))

*-- Agora recria o cursor e reatribui SO RecordSource + ControlSource (sem tocar ColumnCount)
USE IN cur1
CREATE CURSOR cur1 (A C(10), B C(10))
APPEND BLANK

loc_oGrid.RecordSource = ""
loc_oGrid.RecordSource = "cur1"
loc_oGrid.Column1.ControlSource = "cur1.A"
loc_oGrid.Column2.ControlSource = "cur1.B"

LogIt(loc_cLog, "2 apos RecordSource=''+RecordSource+ControlSource (SEM reatribuir ColumnCount): H1=[" + loc_oGrid.Column1.Header1.Caption + "] H2=[" + loc_oGrid.Column2.Header1.Caption + "] W1=" + TRANSFORM(loc_oGrid.Column1.Width))

loc_oForm.Release()
QUIT

PROCEDURE LogIt(par_cArq, par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), par_cArq, 1)
ENDPROC
