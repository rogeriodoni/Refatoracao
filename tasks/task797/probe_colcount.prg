SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cOut, loc_oF
loc_cOut = ""

CREATE CURSOR cur_probe (Datas T, Transacaos C(30), Usuars C(10), Nfis C(8))
INSERT INTO cur_probe VALUES (DATETIME(), "TESTE", "USR", "123")

loc_oF = CREATEOBJECT("Form")
loc_oF.AddObject("g", "Grid")
WITH loc_oF.g
    .ColumnCount = 4
    .FontName    = "Tahoma"
    .FontSize    = 8
ENDWITH
loc_oF.g.Column1.Width = 120
loc_oF.g.Column1.Header1.Alignment = 2
loc_oF.g.Column1.Header1.Caption   = "Data/Hora"
loc_oF.g.Column1.Text1.Margin      = 0
loc_oF.g.Column1.Text1.BackColor   = RGB(255,255,255)

loc_cOut = loc_cOut + "ANTES  : W=" + TRANSFORM(loc_oF.g.Column1.Width) + ;
    " HdrAlign=" + TRANSFORM(loc_oF.g.Column1.Header1.Alignment) + ;
    " Cap=[" + loc_oF.g.Column1.Header1.Caption + "]" + ;
    " Margin=" + TRANSFORM(loc_oF.g.Column1.Text1.Margin) + CHR(13) + CHR(10)

*-- reatribuir ColumnCount com o MESMO valor + RecordSource (o que CarregarLista faz)
loc_oF.g.RecordSource = ""
loc_oF.g.ColumnCount  = 4
loc_oF.g.RecordSource = "cur_probe"
loc_oF.g.Column1.ControlSource = "cur_probe.Datas"

loc_cOut = loc_cOut + "DEPOIS : W=" + TRANSFORM(loc_oF.g.Column1.Width) + ;
    " HdrAlign=" + TRANSFORM(loc_oF.g.Column1.Header1.Alignment) + ;
    " Cap=[" + loc_oF.g.Column1.Header1.Caption + "]" + ;
    " Margin=" + TRANSFORM(loc_oF.g.Column1.Text1.Margin) + CHR(13) + CHR(10)

*-- controle: SO RecordSource, sem reatribuir ColumnCount
loc_oF.g.Column1.Header1.Alignment = 2
loc_oF.g.Column1.Text1.Margin      = 0
loc_oF.g.Column1.Width             = 120
loc_oF.g.RecordSource = ""
loc_oF.g.RecordSource = "cur_probe"
loc_cOut = loc_cOut + "SO RS  : W=" + TRANSFORM(loc_oF.g.Column1.Width) + ;
    " HdrAlign=" + TRANSFORM(loc_oF.g.Column1.Header1.Alignment) + ;
    " Cap=[" + loc_oF.g.Column1.Header1.Caption + "]" + ;
    " Margin=" + TRANSFORM(loc_oF.g.Column1.Text1.Margin) + CHR(13) + CHR(10)

loc_cOut = loc_cOut + "ColumnCount final=" + TRANSFORM(loc_oF.g.ColumnCount) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, "C:\4c\tasks\task797\logs\probe_colcount.txt")
QUIT
