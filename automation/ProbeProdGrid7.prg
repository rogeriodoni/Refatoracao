SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
#DEFINE OUT "C:\4c\automation\probe_prodgrid7.txt"
PUBLIC gcOut
gcOut = OUT
STRTOFILE("INICIO" + CHR(13)+CHR(10), gcOut)
ON ERROR DO LogErro WITH MESSAGE(), LINENO(), PROGRAM()

LOCAL loF, loG, lnI, lnJ, loEx

CREATE CURSOR cursor_4c_Dados ( ;
    cpros C(6), dpros C(40), dpro2s C(40), cgrus C(3), sgrus C(3), ;
    reffs C(20), colecoes C(10), impetiqs N(1), situas N(1), encoms N(1), ;
    cbars C(14), cproeqs C(6), compos C(1), codcors C(3), ;
    usuaalts C(10), dtalts T)
INSERT INTO cursor_4c_Dados (cpros, dpros, cgrus, situas, usuaalts) VALUES ("000001","TESTE","001", 2, "ROGER")
INSERT INTO cursor_4c_Dados (cpros, dpros, cgrus, situas, usuaalts) VALUES ("000002","TESTE2","002", 1, "ROGER")
DO Log WITH "cursor criado, reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Dados"))

loF = CREATEOBJECT("Form")
loF.AddObject("grd", "Grid")
loF.grd.ColumnCount = 7
loF.grd.ReadOnly = .T.
loF.grd.GridLines = 3
loF.grd.Column7.AddObject("chk_4c_Inativo", "CheckBox")
loF.grd.Column7.CurrentControl = "chk_4c_Inativo"
loF.grd.Column7.Sparse = .F.
loF.grd.Column7.ReadOnly = .T.
loF.grd.Column7.chk_4c_Inativo.Enabled = .F.
loG = loF.grd
DO Log WITH "grid montado ColumnCount=" + TRANSFORM(loG.ColumnCount)

FOR lnI = 1 TO 3
    DO Log WITH "=== PASSADA " + TRANSFORM(lnI) + " ==="
    TRY
        IF loG.ColumnCount >= 7
            loG.Column7.CurrentControl = "Text1"
            loG.Column7.ControlSource  = ""
            DO Log WITH "  col7 desarmada"
        ENDIF
        loG.RecordSource = ""
        DO Log WITH "  RecordSource='' -> ColumnCount=" + TRANSFORM(loG.ColumnCount)
        loG.ColumnCount = 7
        loG.RecordSource = "cursor_4c_Dados"
        DO Log WITH "  RecordSource=cursor -> ColumnCount=" + TRANSFORM(loG.ColumnCount)

        loG.Column1.ControlSource = "cursor_4c_Dados.cpros"
        loG.Column2.ControlSource = "cursor_4c_Dados.dpros"
        loG.Column3.ControlSource = "cursor_4c_Dados.cgrus"
        loG.Column4.ControlSource = "cursor_4c_Dados.sgrus"
        loG.Column5.ControlSource = "cursor_4c_Dados.reffs"
        loG.Column6.ControlSource = "cursor_4c_Dados.usuaalts"
        DO Log WITH "  CS 1-6 ok"
        loG.Column7.ControlSource = "cursor_4c_Dados.situas = 2"
        DO Log WITH "  CS col7 (expressao) ok"

        IF !PEMSTATUS(loG.Column7, "chk_4c_Inativo", 5)
            DO Log WITH "  >>> chk_4c_Inativo FOI DESTRUIDO - recriando"
            loG.Column7.AddObject("chk_4c_Inativo", "CheckBox")
        ENDIF
        loG.Column7.chk_4c_Inativo.Caption = ""
        loG.Column7.chk_4c_Inativo.Enabled = .F.
        loG.Column7.CurrentControl = "chk_4c_Inativo"
        loG.Column7.Sparse = .F.
        loG.Column7.ReadOnly = .T.
        DO Log WITH "  col7 rearmada"

        loG.Column1.Header1.Caption = "Produto"
        loG.Column2.Header1.Caption = "Descricao"
        loG.Column3.Header1.Caption = "Grupo"
        loG.Column4.Header1.Caption = "Subgrp."
        loG.Column5.Header1.Caption = "Ref. Fornecedor"
        loG.Column6.Header1.Caption = "Usuario"
        loG.Column7.Header1.Caption = "I"
        DO Log WITH "  headers ok"

        loG.FontName = "Tahoma"
        loG.FontSize = 8

        loG.Column1.Width = 90
        loG.Column2.Width = 380
        loG.Column3.Width = 50
        loG.Column4.Width = 70
        loG.Column5.Width = 140
        loG.Column6.Width = 100
        loG.Column7.Width = 30
        DO Log WITH "  larguras ok"
    CATCH TO loEx
        DO Log WITH "  *** CATCH: " + loEx.Message + " (linha " + TRANSFORM(loEx.LineNo) + ")"
    ENDTRY

    DO Log WITH "  ESTADO ColumnCount=" + TRANSFORM(loG.ColumnCount)
    FOR lnJ = 1 TO loG.ColumnCount
        DO Log WITH "   Col" + TRANSFORM(lnJ) + ;
            " CS=[" + EVALUATE("loG.Column" + TRANSFORM(lnJ) + ".ControlSource") + "]" + ;
            " Hdr=[" + EVALUATE("loG.Column" + TRANSFORM(lnJ) + ".Header1.Caption") + "]" + ;
            " W=" + TRANSFORM(EVALUATE("loG.Column" + TRANSFORM(lnJ) + ".Width")) + ;
            " CC=[" + EVALUATE("loG.Column" + TRANSFORM(lnJ) + ".CurrentControl") + "]"
    NEXT
NEXT

DO Log WITH "FIM"
QUIT

PROCEDURE Log
LPARAMETERS pcMsg
STRTOFILE(pcMsg + CHR(13)+CHR(10), gcOut, 1)
ENDPROC

PROCEDURE LogErro
LPARAMETERS pcMsg, pnLine, pcProg
STRTOFILE("!!! ON ERROR: " + pcMsg + " | linha " + TRANSFORM(pnLine) + " | " + pcProg + CHR(13)+CHR(10), gcOut, 1)
ENDPROC
