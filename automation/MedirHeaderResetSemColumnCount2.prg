SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cLog
loc_cLog = "C:\4c\automation\logs\medir_header_reset2.txt"
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
loc_oGrid.ReadOnly = .F.
loc_oGrid.Column1.ReadOnly = .T.
loc_oGrid.Column2.ReadOnly = .F.

LogIt(loc_cLog, "1 setup: C1.RO=" + TRANSFORM(loc_oGrid.Column1.ReadOnly) + " C2.RO=" + TRANSFORM(loc_oGrid.Column2.ReadOnly))

USE IN cur1
CREATE CURSOR cur1 (A C(10), B C(10))
APPEND BLANK

*-- replicando EXATAMENTE o padrao do BtnSelEstoqueClick: sem resetar RecordSource="" antes
loc_oGrid.RecordSource = "cur1"
loc_oGrid.Column1.ControlSource = "cur1.A"
loc_oGrid.Column2.ControlSource = "cur1.B"

LogIt(loc_cLog, "2 apos reatribuir RecordSource direto (sem passar por ''): C1.RO=" + TRANSFORM(loc_oGrid.Column1.ReadOnly) + " C2.RO=" + TRANSFORM(loc_oGrid.Column2.ReadOnly))

loc_oForm.Release()
QUIT

PROCEDURE LogIt(par_cArq, par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), par_cArq, 1)
ENDPROC
