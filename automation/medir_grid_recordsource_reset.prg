SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_oFrm, loc_oG
loc_cOut = ""

CREATE CURSOR cur_teste (Priors N(6), Emps C(3))
INSERT INTO cur_teste VALUES (1, "001")

loc_oFrm = CREATEOBJECT("Form")
loc_oFrm.AddObject("grd", "Grid")
loc_oG = loc_oFrm.grd
WITH loc_oG
    .ColumnCount = 2
    .ReadOnly    = .T.
    .Column1.Width = 50
    .Column1.ReadOnly = .F.
    .Column1.Header1.Caption = "Prioridade"
    .Column2.Width = 31
    .Column2.Header1.Caption = "Emp"
    .RecordSource = "cur_teste"
    .Column1.ControlSource = "cur_teste.Priors"
    .Column2.ControlSource = "cur_teste.Emps"
ENDWITH
loc_cOut = loc_cOut + "T1 bind inicial: C1.W=" + TRANSFORM(loc_oG.Column1.Width) + ;
   " Cap=[" + loc_oG.Column1.Header1.Caption + "] RO=" + TRANSFORM(loc_oG.Column1.ReadOnly) + CHR(13)+CHR(10)

*-- T2: fechar e recriar o cursor, depois REBIND (2a chamada de CarregarGrades)
USE IN cur_teste
CREATE CURSOR cur_teste (Priors N(6), Emps C(3))
INSERT INTO cur_teste VALUES (9, "009")
loc_oG.ColumnCount  = 2
loc_oG.RecordSource = "cur_teste"
loc_oG.Column1.ControlSource = "cur_teste.Priors"
loc_oG.Column2.ControlSource = "cur_teste.Emps"
loc_cOut = loc_cOut + "T2 rebind pos-recriar: C1.W=" + TRANSFORM(loc_oG.Column1.Width) + ;
   " Cap=[" + loc_oG.Column1.Header1.Caption + "] RO=" + TRANSFORM(loc_oG.Column1.ReadOnly) + CHR(13)+CHR(10)

*-- T3: mudar ColumnCount de verdade
loc_oG.ColumnCount = 3
loc_cOut = loc_cOut + "T3 ColumnCount 2->3: C1.W=" + TRANSFORM(loc_oG.Column1.Width) + ;
   " Cap=[" + loc_oG.Column1.Header1.Caption + "] RO=" + TRANSFORM(loc_oG.Column1.ReadOnly) + CHR(13)+CHR(10)

*-- T4: RecordSource = "" e rebind
loc_oG.ColumnCount = 2
loc_oG.Column1.Width = 50
loc_oG.Column1.Header1.Caption = "Prioridade"
loc_oG.Column1.ReadOnly = .F.
loc_oG.RecordSource = ""
loc_oG.RecordSource = "cur_teste"
loc_oG.Column1.ControlSource = "cur_teste.Priors"
loc_cOut = loc_cOut + "T4 RS vazio->rebind: C1.W=" + TRANSFORM(loc_oG.Column1.Width) + ;
   " Cap=[" + loc_oG.Column1.Header1.Caption + "] RO=" + TRANSFORM(loc_oG.Column1.ReadOnly) + CHR(13)+CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\medir_rs2.txt")
QUIT
