SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gc_Log, goSpy
gc_Log = ""

CREATE CURSOR cTeste (a C(5), b C(5), c C(5), d C(5), e C(5))
INSERT INTO cTeste VALUES ("1","2","3","4","5")

loF = CREATEOBJECT("FrmTeste")
loF.Show()

*-- 1) mesmo valor de ColumnCount
loF.grd.RecordSource = "cTeste"
loF.grd.ColumnCount = 5
loF.grd.Column1.Width = 123
loF.grd.Column1.Header1.Caption = "ANTES"
BINDEVENT(loF.grd.Column1.Text1, "LostFocus", loF, "Espiao")
gc_Log = gc_Log + "obj Text1 antes      : " + TRANSFORM(SYS(1272, loF.grd.Column1.Text1)) + CHR(13)+CHR(10)
gc_Log = gc_Log + "AEVENTS antes        : " + TRANSFORM(AEVENTS(la1, loF.grd.Column1.Text1)) + CHR(13)+CHR(10)

loF.grd.ColumnCount = 5   && reatribui o MESMO valor
gc_Log = gc_Log + "obj Text1 depois(=5) : " + TRANSFORM(SYS(1272, loF.grd.Column1.Text1)) + CHR(13)+CHR(10)
gc_Log = gc_Log + "AEVENTS depois(=5)   : " + TRANSFORM(AEVENTS(la2, loF.grd.Column1.Text1)) + CHR(13)+CHR(10)
gc_Log = gc_Log + "Width depois(=5)     : " + TRANSFORM(loF.grd.Column1.Width) + CHR(13)+CHR(10)
gc_Log = gc_Log + "Caption depois(=5)   : [" + TRANSFORM(loF.grd.Column1.Header1.Caption) + "]" + CHR(13)+CHR(10)

*-- 2) RecordSource reatribuido (mesmo cursor)
loF.grd.Column1.Width = 99
loF.grd.Column1.Header1.Caption = "ANTES2"
loF.grd.RecordSource = ""
loF.grd.RecordSource = "cTeste"
gc_Log = gc_Log + "AEVENTS pos-RecSource: " + TRANSFORM(AEVENTS(la3, loF.grd.Column1.Text1)) + CHR(13)+CHR(10)
gc_Log = gc_Log + "Width pos-RecSource  : " + TRANSFORM(loF.grd.Column1.Width) + CHR(13)+CHR(10)
gc_Log = gc_Log + "Caption pos-RecSource: [" + TRANSFORM(loF.grd.Column1.Header1.Caption) + "]" + CHR(13)+CHR(10)

STRTOFILE(gc_Log, "C:\4c\automation\medir_columncount_bindevent.txt")
loF.Release()
QUIT

DEFINE CLASS FrmTeste AS Form
    Width = 500
    Height = 300
    ADD OBJECT grd AS Grid WITH Visible = .T.
    PROCEDURE Espiao
    ENDPROC
ENDDEFINE
