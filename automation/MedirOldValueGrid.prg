SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcRes, loFrm
lcLog = "C:\4c\automation\logs\medir_oldvalue.txt"
lcRes = ""

CREATE CURSOR C1 (v N(10,3))
INSERT INTO C1 (v) VALUES (10)

loFrm = CREATEOBJECT("Form")
loFrm.AddObject("grd", "Grid")
loFrm.grd.RecordSource = ""
loFrm.grd.ColumnCount = 1
loFrm.grd.RecordSource = "C1"
loFrm.grd.Column1.ControlSource = "C1.v"

loFrm.AddObject("txt", "TextBox")

lcRes = lcRes + "PEMSTATUS(Column1,      'OldValue', 5) = " + TRANSFORM(PEMSTATUS(loFrm.grd.Column1, "OldValue", 5)) + CHR(13) + CHR(10)
lcRes = lcRes + "PEMSTATUS(Column1.Text1,'OldValue', 5) = " + TRANSFORM(PEMSTATUS(loFrm.grd.Column1.Text1, "OldValue", 5)) + CHR(13) + CHR(10)
lcRes = lcRes + "PEMSTATUS(TextBox solto,'OldValue', 5) = " + TRANSFORM(PEMSTATUS(loFrm.txt, "OldValue", 5)) + CHR(13) + CHR(10)
lcRes = lcRes + "TYPE('loFrm.grd.Column1.OldValue')       = " + TYPE("loFrm.grd.Column1.OldValue") + CHR(13) + CHR(10)
lcRes = lcRes + "TYPE('loFrm.grd.Column1.Text1.OldValue') = " + TYPE("loFrm.grd.Column1.Text1.OldValue") + CHR(13) + CHR(10)

TRY
    lcRes = lcRes + "LEITURA Column1.OldValue = " + TRANSFORM(loFrm.grd.Column1.OldValue) + CHR(13) + CHR(10)
CATCH TO loE
    lcRes = lcRes + "LEITURA Column1.OldValue ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY
TRY
    lcRes = lcRes + "LEITURA Column1.Text1.OldValue = " + TRANSFORM(loFrm.grd.Column1.Text1.OldValue) + CHR(13) + CHR(10)
CATCH TO loE
    lcRes = lcRes + "LEITURA Column1.Text1.OldValue ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcRes, lcLog)
QUIT
