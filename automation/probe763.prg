SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_oErr
loc_cOut = ""

CREATE CURSOR crSigOpOco (codigos C(10), descrs C(30), grupos C(10), ;
    contas C(10), dcontas C(50), opers C(2), contabs N(1,0), imps L, notas N(1,0))
INSERT INTO crSigOpOco (codigos, descrs, imps) VALUES ("001", "TESTE UM", .F.)
INSERT INTO crSigOpOco (codigos, descrs, imps) VALUES ("002", "TESTE DOIS", .T.)

PUBLIC go
go = CREATEOBJECT("Form")
go.Width = 800
go.Height = 350

SELECT crSigOpOco
go.AddObject("g", "Grid")
go.g.ColumnCount = 3
loc_cOut = loc_cOut + "APOS ColumnCount=3 (crSigOpOco corrente):" + CHR(13)+CHR(10)
loc_cOut = loc_cOut + "  RecordSource=[" + TRANSFORM(go.g.RecordSource) + "] Type=" + TRANSFORM(go.g.RecordSourceType) + CHR(13)+CHR(10)
loc_cOut = loc_cOut + "  C1.ControlSource=[" + TRANSFORM(go.g.Column1.ControlSource) + "]" + CHR(13)+CHR(10)
loc_cOut = loc_cOut + "  C2.ControlSource=[" + TRANSFORM(go.g.Column2.ControlSource) + "]" + CHR(13)+CHR(10)
loc_cOut = loc_cOut + "  C3.ControlSource=[" + TRANSFORM(go.g.Column3.ControlSource) + "]" + CHR(13)+CHR(10)

*-- Teste A: AddObject do CheckBox COM autobind em coluna CHARACTER (codigos)
TRY
    go.g.Column1.AddObject("chkA", "CheckBox")
    loc_cOut = loc_cOut + "TESTE A (autobind char): AddObject OK, Value VARTYPE=" + ;
        VARTYPE(go.g.Column1.chkA.Value) + CHR(13)+CHR(10)
CATCH TO loc_oErr
    loc_cOut = loc_cOut + "TESTE A (autobind char): ERRO [" + loc_oErr.Message + "]" + CHR(13)+CHR(10)
ENDTRY

*-- Teste B: bindar certo (Column1 -> imps LOGICO) e so depois AddObject
go.g.RecordSource = "crSigOpOco"
go.g.Column1.ControlSource = "crSigOpOco.imps"
go.g.Column2.ControlSource = "crSigOpOco.codigos"
go.g.Column3.ControlSource = "crSigOpOco.descrs"
TRY
    go.g.Column1.AddObject("chkB", "CheckBox")
    loc_cOut = loc_cOut + "TESTE B (bind imps LOGICO): AddObject OK, Value VARTYPE=" + ;
        VARTYPE(go.g.Column1.chkB.Value) + " valor=" + TRANSFORM(go.g.Column1.chkB.Value) + CHR(13)+CHR(10)
    go.g.Column1.chkB.Caption = ""
    go.g.Column1.chkB.Visible = .T.
    go.g.Column1.Sparse = .F.
    go.g.Column1.CurrentControl = "chkB"
    loc_cOut = loc_cOut + "  CurrentControl=[" + go.g.Column1.CurrentControl + "] Sparse=" + ;
        TRANSFORM(go.g.Column1.Sparse) + CHR(13)+CHR(10)
CATCH TO loc_oErr
    loc_cOut = loc_cOut + "TESTE B (bind imps LOGICO): ERRO [" + loc_oErr.Message + "]" + CHR(13)+CHR(10)
ENDTRY

*-- Teste C: atribuir .Value = 0 (numerico) num chk ligado a coluna LOGICA
TRY
    go.g.Column1.chkB.Value = 0
    loc_cOut = loc_cOut + "TESTE C (.Value = 0 em col logica): OK, VARTYPE=" + ;
        VARTYPE(go.g.Column1.chkB.Value) + CHR(13)+CHR(10)
CATCH TO loc_oErr
    loc_cOut = loc_cOut + "TESTE C (.Value = 0 em col logica): ERRO [" + loc_oErr.Message + "]" + CHR(13)+CHR(10)
ENDTRY

*-- Teste D: .Value = .F. (logico)
TRY
    go.g.Column1.chkB.Value = .F.
    loc_cOut = loc_cOut + "TESTE D (.Value = .F.): OK, VARTYPE=" + ;
        VARTYPE(go.g.Column1.chkB.Value) + CHR(13)+CHR(10)
CATCH TO loc_oErr
    loc_cOut = loc_cOut + "TESTE D (.Value = .F.): ERRO [" + loc_oErr.Message + "]" + CHR(13)+CHR(10)
ENDTRY

*-- Teste E: larguras apos RecordSource
go.g.Column1.Width = 15
go.g.Column2.Width = 80
go.g.Column3.Width = 220
loc_cOut = loc_cOut + "TESTE E larguras: " + TRANSFORM(go.g.Column1.Width) + "/" + ;
    TRANSFORM(go.g.Column2.Width) + "/" + TRANSFORM(go.g.Column3.Width) + CHR(13)+CHR(10)

*-- Teste F: Shape tem ColorScheme / BorderStyle / FillStyle ?
go.AddObject("sh", "Shape")
LOCAL loc_cP
loc_cOut = loc_cOut + "  Shape props: ColorScheme=" + TRANSFORM(PEMSTATUS(go.sh,"ColorScheme",5)) + " BorderStyle=" + TRANSFORM(PEMSTATUS(go.sh,"BorderStyle",5)) + " FillStyle=" + TRANSFORM(PEMSTATUS(go.sh,"FillStyle",5)) + " SpecialEffect=" + TRANSFORM(PEMSTATUS(go.sh,"SpecialEffect",5)) + " BackStyle=" + TRANSFORM(PEMSTATUS(go.sh,"BackStyle",5)) + " ForeColor=" + TRANSFORM(PEMSTATUS(go.sh,"ForeColor",5)) + " ZOrderSet=" + TRANSFORM(PEMSTATUS(go.sh,"ZOrderSet",5)) + CHR(13)+CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\probe763_out.txt")
QUIT
