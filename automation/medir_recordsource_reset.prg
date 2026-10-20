SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_oFrm
loc_cOut = ""

CREATE CURSOR cur_teste (Priors N(6), Emps C(3), Dopes C(20))
INSERT INTO cur_teste VALUES (1, "001", "MALOTE")
INSERT INTO cur_teste VALUES (2, "002", "CAIXA")

loc_oFrm = CREATEOBJECT("Form")
loc_oFrm.AddObject("grd", "Grid")
WITH loc_oFrm.grd
    .ColumnCount = 3
    .ReadOnly    = .T.
    .Column1.Width           = 50
    .Column1.ReadOnly        = .F.
    .Column1.Header1.Caption = "Prioridade"
    .Column2.Width           = 31
    .Column2.Header1.Caption = "Emp"
    .Column3.Width           = 150
    .Column3.Header1.Caption = "Operacao"
ENDWITH

loc_cOut = loc_cOut + "ANTES  C1.W=" + TRANSFORM(loc_oFrm.grd.Column1.Width) + ;
    " C2.W=" + TRANSFORM(loc_oFrm.grd.Column2.Width) + ;
    " C3.W=" + TRANSFORM(loc_oFrm.grd.Column3.Width) + ;
    " C1.Cap=[" + loc_oFrm.grd.Column1.Header1.Caption + "]" + ;
    " C1.RO=" + TRANSFORM(loc_oFrm.grd.Column1.ReadOnly) + CHR(13) + CHR(10)

*-- exatamente o que CarregarGrades faz
loc_oFrm.grd.ColumnCount  = 3
loc_oFrm.grd.RecordSource = "cur_teste"
WITH loc_oFrm.grd
    .Column1.ControlSource = "cur_teste.Priors"
    .Column2.ControlSource = "cur_teste.Emps"
    .Column3.ControlSource = "cur_teste.Dopes"
ENDWITH

loc_cOut = loc_cOut + "DEPOIS C1.W=" + TRANSFORM(loc_oFrm.grd.Column1.Width) + ;
    " C2.W=" + TRANSFORM(loc_oFrm.grd.Column2.Width) + ;
    " C3.W=" + TRANSFORM(loc_oFrm.grd.Column3.Width) + ;
    " C1.Cap=[" + loc_oFrm.grd.Column1.Header1.Caption + "]" + ;
    " C1.RO=" + TRANSFORM(loc_oFrm.grd.Column1.ReadOnly) + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\medir_recordsource_reset.txt")
QUIT
