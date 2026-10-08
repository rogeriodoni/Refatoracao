*-- Medir: RowSource (RowSourceType=5) apontando para ARRAY PROPERTY do form
*-- com "THIS." x "THISFORM." x array PUBLIC. Erro178/Fase5 task626.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_oF
loc_cOut = ""

*-- (1) RowSource = "THIS.this_aOpcoes"
TRY
    loc_oF = CREATEOBJECT("frmTesteThis")
    loc_cOut = loc_cOut + "1) RowSource THIS.prop      -> ListCount=" + ;
        TRANSFORM(loc_oF.cbo.ListCount) + " List1=[" + ;
        IIF(loc_oF.cbo.ListCount > 0, TRANSFORM(loc_oF.cbo.List(1)), "<vazio>") + "]" + CHR(13) + CHR(10)
    loc_oF = .NULL.
CATCH TO loc_oE
    loc_cOut = loc_cOut + "1) RowSource THIS.prop      -> ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- (2) RowSource = "THISFORM.this_aOpcoes"
TRY
    loc_oF = CREATEOBJECT("frmTesteThisForm")
    loc_cOut = loc_cOut + "2) RowSource THISFORM.prop  -> ListCount=" + ;
        TRANSFORM(loc_oF.cbo.ListCount) + " List1=[" + ;
        IIF(loc_oF.cbo.ListCount > 0, TRANSFORM(loc_oF.cbo.List(1)), "<vazio>") + "]" + CHR(13) + CHR(10)
    loc_oF = .NULL.
CATCH TO loc_oE
    loc_cOut = loc_cOut + "2) RowSource THISFORM.prop  -> ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- (3) RowSource = nome de array PUBLIC (o que o legado faz: PUBLIC laOpcoes)
TRY
    loc_oF = CREATEOBJECT("frmTestePublic")
    loc_cOut = loc_cOut + "3) RowSource array PUBLIC   -> ListCount=" + ;
        TRANSFORM(loc_oF.cbo.ListCount) + " List1=[" + ;
        IIF(loc_oF.cbo.ListCount > 0, TRANSFORM(loc_oF.cbo.List(1)), "<vazio>") + "]" + CHR(13) + CHR(10)
    loc_oF = .NULL.
CATCH TO loc_oE
    loc_cOut = loc_cOut + "3) RowSource array PUBLIC   -> ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- (4) DIMENSION em array PROPERTY do form em runtime
TRY
    loc_oF = CREATEOBJECT("frmTesteThisForm")
    DIMENSION loc_oF.this_aOpcoes[5]
    loc_cOut = loc_cOut + "4) DIMENSION obj.arrayprop  -> ALEN=" + TRANSFORM(ALEN(loc_oF.this_aOpcoes)) + CHR(13) + CHR(10)
    loc_oF = .NULL.
CATCH TO loc_oE
    loc_cOut = loc_cOut + "4) DIMENSION obj.arrayprop  -> ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- (5) TextBox criado por AddObject: tipo/valor default de .Value
TRY
    loc_oF = CREATEOBJECT("frmTesteTxt")
    loc_cOut = loc_cOut + "5) TextBox AddObject .Value -> VARTYPE=[" + VARTYPE(loc_oF.txt.Value) + ;
        "] LEN=" + TRANSFORM(LEN(TRANSFORM(loc_oF.txt.Value))) + ;
        " Alignment=" + TRANSFORM(loc_oF.txt.Alignment) + CHR(13) + CHR(10)
    loc_oF = .NULL.
CATCH TO loc_oE
    loc_cOut = loc_cOut + "5) TextBox AddObject .Value -> ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- (6) WindowState: default de um Form por CREATEOBJECT
TRY
    loc_oF = CREATEOBJECT("frmTesteTxt")
    loc_cOut = loc_cOut + "6) Form.WindowState default -> " + TRANSFORM(loc_oF.WindowState) + CHR(13) + CHR(10)
    loc_oF = .NULL.
CATCH TO loc_oE
    loc_cOut = loc_cOut + "6) Form.WindowState default -> ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\_tmp\medir_rowsource_array.txt")
QUIT

DEFINE CLASS frmTesteThis AS Form
    DIMENSION this_aOpcoes[1]
    PROCEDURE Init
        DIMENSION THIS.this_aOpcoes[3]
        THIS.this_aOpcoes[1] = "AAA"
        THIS.this_aOpcoes[2] = "BBB"
        THIS.this_aOpcoes[3] = "CCC"
        THIS.AddObject("cbo", "ComboBox")
        WITH THIS.cbo
            .Style         = 2
            .RowSourceType = 5
            .RowSource     = "THIS.this_aOpcoes"
            .Visible       = .T.
        ENDWITH
        THIS.cbo.Requery()
    ENDPROC
ENDDEFINE

DEFINE CLASS frmTesteThisForm AS Form
    DIMENSION this_aOpcoes[1]
    PROCEDURE Init
        DIMENSION THIS.this_aOpcoes[3]
        THIS.this_aOpcoes[1] = "AAA"
        THIS.this_aOpcoes[2] = "BBB"
        THIS.this_aOpcoes[3] = "CCC"
        THIS.AddObject("cbo", "ComboBox")
        WITH THIS.cbo
            .Style         = 2
            .RowSourceType = 5
            .RowSource     = "THISFORM.this_aOpcoes"
            .Visible       = .T.
        ENDWITH
        THIS.cbo.Requery()
    ENDPROC
ENDDEFINE

DEFINE CLASS frmTestePublic AS Form
    PROCEDURE Init
        PUBLIC ARRAY aOpcoesTeste(3)
        aOpcoesTeste(1) = "AAA"
        aOpcoesTeste(2) = "BBB"
        aOpcoesTeste(3) = "CCC"
        THIS.AddObject("cbo", "ComboBox")
        WITH THIS.cbo
            .Style         = 2
            .RowSourceType = 5
            .RowSource     = "aOpcoesTeste"
            .Visible       = .T.
        ENDWITH
        THIS.cbo.Requery()
    ENDPROC
ENDDEFINE

DEFINE CLASS frmTesteTxt AS Form
    PROCEDURE Init
        THIS.AddObject("txt", "TextBox")
        THIS.txt.Visible = .T.
    ENDPROC
ENDDEFINE
