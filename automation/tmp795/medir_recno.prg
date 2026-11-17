SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
#DEFINE OUTF "C:\4c\automation\tmp795\medir_recno_out.txt"
LOCAL lcOut
lcOut = ""

PUBLIC goF
goF = CREATEOBJECT("Form")
goF.Width = 400
goF.Height = 300

CREATE CURSOR cursor_teste (datas D, estoque N(11,3))
LOCAL lnI
FOR lnI = 1 TO 10
    INSERT INTO cursor_teste (datas, estoque) VALUES (DATE() + lnI, lnI * 10)
ENDFOR
INDEX ON datas TAG datas

goF.AddObject("grd", "Grid")
goF.grd.ColumnCount  = 2
goF.grd.RecordSource = "cursor_teste"
goF.grd.Column1.ControlSource = "cursor_teste.datas"
goF.grd.Column2.ControlSource = "cursor_teste.estoque"
goF.grd.Visible = .T.

*-- posiciona no 7o registro, como o SEEK do BO faz
SELECT cursor_teste
GO 7
lcOut = lcOut + "RECNO apos GO 7            = " + TRANSFORM(RECNO("cursor_teste")) + CHR(13) + CHR(10)

*-- re-bind: eh o que MontaGrade faz
goF.grd.ColumnCount  = 2
goF.grd.RecordSource = "cursor_teste"
lcOut = lcOut + "RECNO apos RecordSource    = " + TRANSFORM(RECNO("cursor_teste")) + CHR(13) + CHR(10)

goF.grd.Column1.ControlSource = "cursor_teste.datas"
goF.grd.Column2.ControlSource = "cursor_teste.estoque"
lcOut = lcOut + "RECNO apos ControlSource   = " + TRANSFORM(RECNO("cursor_teste")) + CHR(13) + CHR(10)

goF.grd.Refresh()
lcOut = lcOut + "RECNO apos Refresh         = " + TRANSFORM(RECNO("cursor_teste")) + CHR(13) + CHR(10)
lcOut = lcOut + "Grid.ActiveRow             = " + TRANSFORM(goF.grd.ActiveRow) + CHR(13) + CHR(10)
lcOut = lcOut + "Grid.RelativeRow           = " + TRANSFORM(goF.grd.RelativeRow) + CHR(13) + CHR(10)

*-- e o GO TOP que o form faz hoje
GO TOP IN cursor_teste
lcOut = lcOut + "RECNO apos GO TOP          = " + TRANSFORM(RECNO("cursor_teste")) + CHR(13) + CHR(10)

STRTOFILE(lcOut, OUTF)
QUIT
