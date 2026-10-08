*-- Medir a SEQUENCIA REAL do FormSIGPRIFF: RowSource definido ANTES de o
*-- array ser dimensionado/populado. Precisa de Requery()?
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_oF
loc_cOut = ""

TRY
    loc_oF = CREATEOBJECT("frmSeq")
    loc_cOut = loc_cOut + "A) elemento default de DIMENSION em DEFINE CLASS -> VARTYPE=[" + ;
        loc_oF.cTipoElemento + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "B) ListCount APOS popular, SEM Requery           -> " + ;
        TRANSFORM(loc_oF.nAntes) + " List1=[" + loc_oF.cList1Antes + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "C) ListCount APOS Requery                        -> " + ;
        TRANSFORM(loc_oF.nDepois) + " List1=[" + loc_oF.cList1Depois + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "D) ListCount com array[1] = .F. (modo nao-M)     -> " + ;
        TRANSFORM(loc_oF.nFalso) + " List1=[" + loc_oF.cList1Falso + "]" + CHR(13) + CHR(10)
    loc_oF = .NULL.
CATCH TO loc_oE
    loc_cOut = loc_cOut + "ERRO: " + loc_oE.Message + " LINHA " + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\_tmp\medir_rowsource_seq.txt")
QUIT

DEFINE CLASS frmSeq AS Form
    DIMENSION this_aOpcoes[1]
    cTipoElemento = ""
    nAntes = -1
    nDepois = -1
    nFalso = -1
    cList1Antes = ""
    cList1Depois = ""
    cList1Falso = ""

    PROCEDURE Init
        LOCAL loc_nI
        THIS.cTipoElemento = VARTYPE(THIS.this_aOpcoes[1])

        THIS.AddObject("cbo", "ComboBox")
        WITH THIS.cbo
            .Style         = 2
            .RowSourceType = 5
            .RowSource     = "THISFORM.this_aOpcoes"
            .Visible       = .T.
        ENDWITH

        *-- caso D: array ainda com o elemento default (.F.) do DEFINE CLASS
        THIS.nFalso      = THIS.cbo.ListCount
        THIS.cList1Falso = IIF(THIS.cbo.ListCount > 0, TRANSFORM(THIS.cbo.List(1)), "<vazio>")

        *-- popular DEPOIS de o RowSource ja estar definido (sequencia do form real)
        DIMENSION THIS.this_aOpcoes[3]
        THIS.this_aOpcoes[1] = "AAA"
        THIS.this_aOpcoes[2] = "BBB"
        THIS.this_aOpcoes[3] = "CCC"

        THIS.nAntes      = THIS.cbo.ListCount
        THIS.cList1Antes = IIF(THIS.cbo.ListCount > 0, TRANSFORM(THIS.cbo.List(1)), "<vazio>")

        THIS.cbo.Requery()
        THIS.nDepois      = THIS.cbo.ListCount
        THIS.cList1Depois = IIF(THIS.cbo.ListCount > 0, TRANSFORM(THIS.cbo.List(1)), "<vazio>")
    ENDPROC
ENDDEFINE
