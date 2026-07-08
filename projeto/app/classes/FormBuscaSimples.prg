*==============================================================================
* FORMBUSCASIMPLES.PRG
* Formulario simples para exibir cursor ja carregado e permitir selecao
*
* Diferente do FormBuscaAuxiliar, este form NAO faz consultas SQL.
* O cursor deve ser carregado ANTES de criar o objeto.
*
* Uso:
*   SQLEXEC(gnConnHandle, "SELECT...", "cursor_4c_Busca")
*   loc_oForm = CREATEOBJECT("FormBuscaSimples", "cursor_4c_Busca", "Titulo")
*   loc_oForm.mAddColuna("campo1", "", "Coluna 1")
*   loc_oForm.mAddColuna("campo2", "", "Coluna 2")
*   loc_oForm.Show(1)
*   IF loc_oForm.this_lSelecionou
*       ? cursor_4c_Busca.campo1
*   ENDIF
*   loc_oForm.Release()
*==============================================================================

DEFINE CLASS FormBuscaSimples AS Form

    *-- Propriedades do form
    Height = 319
    Width = 374
    Caption = "Procura"
    AutoCenter = .T.
    BorderStyle = 2
    MaxButton = .F.
    MinButton = .F.
    WindowType = 1      && Modal
    ShowWindow = 1      && In Top-Level Form
    ControlBox = .F.    && Sem menu de controle
    TitleBar = 0        && Sem barra de titulo
    Themes = .F.        && Sem temas do Windows
    FontName = "Verdana"
    FontSize = 8

    *-- Propriedades de controle
    this_cCursorOrigem = ""
    this_cTitulo = "Procura"
    this_lSelecionou = .F.

    *-- Array de colunas [nome, mascara, titulo]
    DIMENSION this_aColunas[1, 3]
    this_nColunas = 0

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cCursor, par_cTitulo)
        LOCAL loc_cIconPath

        loc_cIconPath = gc_4c_CaminhoIcones

        * Guarda parametros
        THIS.this_cCursorOrigem = par_cCursor

        IF VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
            THIS.this_cTitulo = par_cTitulo
        ENDIF

        * Configura aparencia visual
        THIS.Picture = loc_cIconPath + "fundo_cadastro.jpg"

        * Cria controles
        THIS.CriarControles()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarControles - Cria controles visuais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarControles()
        LOCAL loc_cIconPath
        loc_cIconPath = gc_4c_CaminhoIcones

        *-- Container do cabecalho
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top = 0
            .Left = 0
            .Width = THIS.Width
            .Height = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
        ENDWITH

        *-- Label sombra do titulo
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption = THIS.this_cTitulo
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Left = 10
            .Top = 18
            .AutoSize = .T.
            .Visible = .T.
        ENDWITH

        *-- Label titulo
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption = THIS.this_cTitulo
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Left = 10
            .Top = 17
            .AutoSize = .T.
            .Visible = .T.
        ENDWITH

        *-- Grid de selecao
        THIS.AddObject("grd_4c_Lista", "Grid")
        WITH THIS.grd_4c_Lista
            .Left = 3
            .Top = 82
            .Width = THIS.Width - 6
            .Height = 224
            .FontName = "Tahoma"
            .FontSize = 8
            .RecordSourceType = 1
            .ReadOnly = .T.
            .DeleteMark = .F.
            .RecordMark = .F.
            .AllowHeaderSizing = .F.
            .AllowRowSizing = .F.
            .RowHeight = 16
            .ScrollBars = 2
            .GridLineColor = RGB(238, 238, 238)
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .HighlightStyle = 2
            .Visible = .T.
        ENDWITH

        *-- Container dos botoes
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top = 252
            .Left = 232
            .Width = 138
            .Height = 56
            .BackStyle = 0
            .BorderWidth = 0
        ENDWITH

        *-- Botao Selecionar
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Selecionar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Selecionar
            .Caption = "Selecionar"
            .Left = 5
            .Top = 5
            .Width = 64
            .Height = 46
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Default = .T.
            .Visible = .T.
        ENDWITH

        *-- Botao Cancelar
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Cancelar
            .Caption = "Cancelar"
            .Left = 69
            .Top = 5
            .Width = 64
            .Height = 46
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Cancel = .T.
            .Visible = .T.
        ENDWITH

        *-- Bind events
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.grd_4c_Lista, "DblClick", THIS, "GridDblClick")

        *-- Torna controles visiveis
        THIS.cnt_4c_Cabecalho.Visible = .T.
        THIS.cnt_4c_Botoes.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * mAddColuna - Adiciona coluna ao grid
    *--------------------------------------------------------------------------
    PROCEDURE mAddColuna(par_cCampo, par_cMascara, par_cTitulo)
        THIS.this_nColunas = THIS.this_nColunas + 1

        DIMENSION THIS.this_aColunas[THIS.this_nColunas, 3]
        THIS.this_aColunas[THIS.this_nColunas, 1] = par_cCampo
        THIS.this_aColunas[THIS.this_nColunas, 2] = par_cMascara
        THIS.this_aColunas[THIS.this_nColunas, 3] = par_cTitulo
    ENDPROC

    *--------------------------------------------------------------------------
    * Show - Exibe o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Show(par_nStyle)
        THIS.ConfigurarGrid()
        DODEFAULT(par_nStyle)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Configura colunas do grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_nI, loc_cCampo, loc_cTitulo, loc_nLarguraTotal, loc_nLargura

        IF !USED(THIS.this_cCursorOrigem)
            RETURN
        ENDIF

        WITH THIS.grd_4c_Lista
            .RecordSource = THIS.this_cCursorOrigem
            .ColumnCount = THIS.this_nColunas

            * Calcula largura proporcional
            loc_nLarguraTotal = .Width - 20

            FOR loc_nI = 1 TO THIS.this_nColunas
                loc_cCampo = THIS.this_aColunas[loc_nI, 1]
                loc_cTitulo = THIS.this_aColunas[loc_nI, 3]

                * Primeira coluna menor, demais dividem o restante
                IF loc_nI = 1
                    loc_nLargura = 80
                ELSE
                    loc_nLargura = (loc_nLarguraTotal - 80) / (THIS.this_nColunas - 1)
                ENDIF

                .Columns(loc_nI).ControlSource = THIS.this_cCursorOrigem + "." + loc_cCampo
                .Columns(loc_nI).Header1.Caption = loc_cTitulo
                .Columns(loc_nI).Width = loc_nLargura
            ENDFOR

            .Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelecionarClick - Usuario selecionou registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelecionarClick()
        THIS.this_lSelecionou = .T.
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Usuario cancelou
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_lSelecionou = .F.
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * GridDblClick - Duplo clique seleciona
    *--------------------------------------------------------------------------
    PROCEDURE GridDblClick()
        THIS.this_lSelecionou = .T.
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - Trata ESC
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.this_lSelecionou = .F.
            THIS.Hide()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * QueryUnload - Trata fechamento
    *--------------------------------------------------------------------------
    PROCEDURE QueryUnload()
        THIS.this_lSelecionou = .F.
        THIS.Hide()
        NODEFAULT
    ENDPROC

ENDDEFINE
