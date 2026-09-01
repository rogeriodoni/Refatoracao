*==============================================================================
* FormRop.prg - Formulario de Cadastro de Restricoes Por Operacao
* Migrado de: SIGCDROP.SCX (frmcadastro)
* Tabela    : SigCdRpo
* Task      : task502
* Herda de  : FormBase
*==============================================================================

SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS FormRop AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 597
    Width       = 970
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Business Object e estado interno
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cPkAtual        = ""

    *==========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: DODEFAULT() aciona FormBase.Init que chama InicializarForm
    * FormBase.Init tambem corrige SET DATE BRITISH / SET CENTURY ON (regra 9.4)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro em FormRop.Init:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado, loc_oCab
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"

            THIS.this_oBusinessObject = CREATEOBJECT("RopBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar RopBO!" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar caption para labels de titulo da Page1
                loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                IF VARTYPE(loc_oCab) = "O"
                    IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
                        loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
                    ENDIF
                    IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
                        loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
                    ENDIF
                ENDIF

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormRop.InicializarForm:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria pgf_4c_Paginas com Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page2.BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho + botoes CRUD + Grid (10 colunas)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro com titulo
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Left=542, Top=29 - canonico)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
        *-- Left=917, Width=90, cmd Width=75, Caption="Encerrar"
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem: 10 colunas conforme legado
        *-- ColumnCount FORA do WITH (evita problema de auto-bind)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 10
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 3
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .ReadOnly           = .T.
            .SetAll("Resizable", .F., "Column")
            .SetAll("Movable",   .F., "Column")
            .Visible            = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GridListaAfterRowColChange")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick",          THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: todos os campos + botoes Confirmar/Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCntAcao
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Botoes Confirmar/Cancelar (Grupo_Salva legado, Top compensado +29)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oCntAcao = loc_oPagina.cnt_4c_BotoesAcao
        WITH loc_oCntAcao
            .Top         = 36
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCntAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCntAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCntAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oCntAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCntAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCntAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * CAMPO 1: Dopps - "Movimenta" + CHR(231) + CHR(227) + "o" (Top=127)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Dopps", "Label")
        WITH loc_oPagina.lbl_4c_Dopps
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Top       = 131
            .Left      = 210
            .Width     = 120
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dopps", "TextBox")
        WITH loc_oPagina.txt_4c_Dopps
            .Value         = ""
            .Top           = 127
            .Left          = 330
            .Width         = 150
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 20
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dopps, "KeyPress", THIS, "TeclaDopps")

        *----------------------------------------------------------------------
        * CAMPO 2: TpOps - "Tipo de Material" (Top=153)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_TpOps", "Label")
        WITH loc_oPagina.lbl_4c_TpOps
            .Caption   = "Tipo de Material :"
            .Top       = 157
            .Left      = 220
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_TpOps", "TextBox")
        WITH loc_oPagina.txt_4c_TpOps
            .Value         = ""
            .Top           = 153
            .Left          = 330
            .Width         = 115
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 20
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_TpOps, "KeyPress", THIS, "TeclaTpOps")

        *----------------------------------------------------------------------
        * CAMPO 3: Cgrus - "Grupo de Produto" (Top=179)
        * Com campo de descricao txt_4c_DGrus ao lado
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Cgrus", "Label")
        WITH loc_oPagina.lbl_4c_Cgrus
            .Caption   = "Grupo de Produto :"
            .Top       = 183
            .Left      = 220
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cgrus", "TextBox")
        WITH loc_oPagina.txt_4c_Cgrus
            .Value         = ""
            .Top           = 179
            .Left          = 330
            .Width         = 35
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Cgrus, "KeyPress", THIS, "TeclaCgrus")

        loc_oPagina.AddObject("txt_4c_DGrus", "TextBox")
        WITH loc_oPagina.txt_4c_DGrus
            .Value         = ""
            .Top           = 179
            .Left          = 368
            .Width         = 200
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 40
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 4: Opers - "Op.Est. (E/S)" (Top=206)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Opers", "Label")
        WITH loc_oPagina.lbl_4c_Opers
            .Caption   = "Op." + "Est. (E/S) :"
            .Top       = 210
            .Left      = 248
            .Width     = 82
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Opers", "TextBox")
        WITH loc_oPagina.txt_4c_Opers
            .Value         = ""
            .Top           = 206
            .Left          = 330
            .Width         = 20
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 1
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Opers, "KeyPress", THIS, "TeclaOpers")

        *----------------------------------------------------------------------
        * CAMPO 5: mercs - "Grande Grupo" (Top=231)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_mercs", "Label")
        WITH loc_oPagina.lbl_4c_mercs
            .Caption   = "Grande Grupo :"
            .Top       = 235
            .Left      = 243
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_mercs", "TextBox")
        WITH loc_oPagina.txt_4c_mercs
            .Value         = ""
            .Top           = 231
            .Left          = 330
            .Width         = 35
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_mercs, "KeyPress", THIS, "TeclaMercs")

        *----------------------------------------------------------------------
        * CAMPO 6: Grupos - "Grupo Contab" (Top=255)
        * Com campo de descricao txt_4c_DGrupos ao lado
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Grupos", "Label")
        WITH loc_oPagina.lbl_4c_Grupos
            .Caption   = "Grupo Contab :"
            .Top       = 259
            .Left      = 243
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupos", "TextBox")
        WITH loc_oPagina.txt_4c_Grupos
            .Value         = ""
            .Top           = 255
            .Left          = 330
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupos, "KeyPress", THIS, "TeclaGrupos")

        loc_oPagina.AddObject("txt_4c_DGrupos", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupos
            .Value         = ""
            .Top           = 255
            .Left          = 415
            .Width         = 160
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 50
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 7: Contas - "Conta Destino" (Top=281)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Contas", "Label")
        WITH loc_oPagina.lbl_4c_Contas
            .Caption   = "Conta Destino :"
            .Top       = 285
            .Left      = 243
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Contas", "TextBox")
        WITH loc_oPagina.txt_4c_Contas
            .Value         = ""
            .Top           = 281
            .Left          = 330
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "TeclaContas")

        *----------------------------------------------------------------------
        * CAMPO 8: ContaOrig - "Conta Origem" (Top=307)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_ContaOrig", "Label")
        WITH loc_oPagina.lbl_4c_ContaOrig
            .Caption   = "Conta Origem :"
            .Top       = 311
            .Left      = 243
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ContaOrig", "TextBox")
        WITH loc_oPagina.txt_4c_ContaOrig
            .Value         = ""
            .Top           = 307
            .Left          = 330
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_ContaOrig, "KeyPress", THIS, "TeclaContaOrig")

        *----------------------------------------------------------------------
        * CAMPO 9: CodCors - "Cor" (Top=333)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_CodCors", "Label")
        WITH loc_oPagina.lbl_4c_CodCors
            .Caption   = "Cor :"
            .Top       = 337
            .Left      = 293
            .Width     = 37
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CodCors", "TextBox")
        WITH loc_oPagina.txt_4c_CodCors
            .Value         = ""
            .Top           = 333
            .Left          = 330
            .Width         = 40
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 4
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CodCors, "KeyPress", THIS, "TeclaCodCors")

        *----------------------------------------------------------------------
        * CAMPO 10: Exclus - "Exclusivo" (Top=359)
        * OptionGroup: Sim=1, N" + CHR(227) + "o=2, default Value=2
        * REGRA: OptionGroup.Value SEMPRE numerico (CLAUDE.md memoria Erro133)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Exclus", "Label")
        WITH loc_oPagina.lbl_4c_Exclus
            .Caption   = "Exclusivo :"
            .Top       = 363
            .Left      = 273
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Exclus", "OptionGroup")
        loc_oPagina.opt_4c_Exclus.ButtonCount = 2
        WITH loc_oPagina.opt_4c_Exclus
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 359
            .Left        = 330
            .Width       = 130
            .Height      = 25
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Exclus.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 50
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Exclus.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 65
            .Top       = 5
            .Width     = 50
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * Configura ControlSource e Headers APOS RecordSource
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- ColumnCount e RecordSource FORA do WITH
                loc_oGrid.ColumnCount  = 10
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- ControlSource APOS RecordSource (evita auto-bind sobrescrito)
                loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Dopps"
                loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.TpOps"
                loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.Cgrus"
                loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.Opers"
                loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.mercs"
                loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.Grupos"
                loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Contas"
                loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.ContaOrig"
                loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.CodCors"
                loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.cIdChaves"

                *-- Larguras das colunas
                loc_oGrid.Column1.Width  = 150
                loc_oGrid.Column2.Width  = 120
                loc_oGrid.Column3.Width  = 80
                loc_oGrid.Column4.Width  = 30
                loc_oGrid.Column5.Width  = 70
                loc_oGrid.Column6.Width  = 80
                loc_oGrid.Column7.Width  = 80
                loc_oGrid.Column8.Width  = 80
                loc_oGrid.Column9.Width  = 44
                loc_oGrid.Column10.Width = 0

                *-- Headers APOS RecordSource (RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Header1.Caption  = "Tipo de Material"
                loc_oGrid.Column3.Header1.Caption  = "Grp.Produto"
                loc_oGrid.Column4.Header1.Caption  = "E/S"
                loc_oGrid.Column5.Header1.Caption  = "Gde.Grupo"
                loc_oGrid.Column6.Header1.Caption  = "Grupo"
                loc_oGrid.Column7.Header1.Caption  = "Conta Destino"
                loc_oGrid.Column8.Header1.Caption  = "Conta Orig"
                loc_oGrid.Column9.Header1.Caption  = "Cor"
                loc_oGrid.Column10.Header1.Caption = "PK"

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormRop.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GridListaAfterRowColChange - Rastreia PK corrente da linha selecionada
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE GridListaAfterRowColChange(par_nColIndex)
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                THIS.this_cPkAtual = ALLTRIM(cursor_4c_Dados.cIdChaves)
            ELSE
                THIS.this_cPkAtual = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em GridListaAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 e Page2
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 para incluir novo registro
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cPk
        loc_cPk = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cPk = ALLTRIM(cursor_4c_Dados.cIdChaves)
        ENDIF

        IF EMPTY(loc_cPk)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.this_cPkAtual   = loc_cPk
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 para alterar registro selecionado
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cPk
        loc_cPk = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cPk = ALLTRIM(cursor_4c_Dados.cIdChaves)
        ENDIF

        IF EMPTY(loc_cPk)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.this_cPkAtual   = loc_cPk
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cPk, loc_cDopps
        loc_cPk    = ""
        loc_cDopps = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cPk    = ALLTRIM(cursor_4c_Dados.cIdChaves)
            loc_cDopps = ALLTRIM(cursor_4c_Dados.Dopps)
        ENDIF

        IF EMPTY(loc_cPk)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da restri" + CHR(231) + CHR(227) + "o [" + loc_cDopps + "]?", ;
                               "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre picker para localizar registro na lista
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_cPk
        loc_cPk = ""

        TRY
            IF USED("cursor_4c_BuscaRop")
                USE IN cursor_4c_BuscaRop
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Dopps, TpOps, Cgrus FROM SigCdRpo ORDER BY Dopps, TpOps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaRop")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaRop") AND RECCOUNT("cursor_4c_BuscaRop") > 0
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.DefinirCursor("cursor_4c_BuscaRop", "cIdChaves", "Dopps", ;
                                              "Buscar Restri" + CHR(231) + CHR(227) + "o")
                    IF loc_oLookup.Mostrar()
                        loc_cPk = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhum registro encontrado.", "Busca")
            ENDIF

            IF USED("cursor_4c_BuscaRop")
                USE IN cursor_4c_BuscaRop
            ENDIF

            IF !EMPTY(loc_cPk) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cIdChaves) == loc_cPk
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro na busca:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormRop.BtnBuscarClick")
            IF USED("cursor_4c_BuscaRop")
                USE IN cursor_4c_BuscaRop
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma e salva o registro atual
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados do Form para o BO antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cDopps     = ALLTRIM(loc_oPg2.txt_4c_Dopps.Value)
        THIS.this_oBusinessObject.this_cTpOps     = ALLTRIM(loc_oPg2.txt_4c_TpOps.Value)
        THIS.this_oBusinessObject.this_cCgrus     = ALLTRIM(loc_oPg2.txt_4c_Cgrus.Value)
        THIS.this_oBusinessObject.this_cOpers     = UPPER(ALLTRIM(loc_oPg2.txt_4c_Opers.Value))
        THIS.this_oBusinessObject.this_cMercs     = ALLTRIM(loc_oPg2.txt_4c_mercs.Value)
        THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPg2.txt_4c_Grupos.Value)
        THIS.this_oBusinessObject.this_cContas    = ALLTRIM(loc_oPg2.txt_4c_Contas.Value)
        THIS.this_oBusinessObject.this_cContaOrig = ALLTRIM(loc_oPg2.txt_4c_ContaOrig.Value)
        THIS.this_oBusinessObject.this_cCodCors   = ALLTRIM(loc_oPg2.txt_4c_CodCors.Value)
        *-- OptionGroup.Value SEMPRE numerico (CLAUDE.md memoria Erro133)
        THIS.this_oBusinessObject.this_nExclus    = loc_oPg2.opt_4c_Exclus.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para o Form apos carregar registro
    * Tambem busca descricoes de FK via SQL (Cgrus=DGrus, Grupos=DGrupos)
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cSQL, loc_nResult, loc_cDesc
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Dopps.Value     = THIS.this_oBusinessObject.this_cDopps
        loc_oPg2.txt_4c_TpOps.Value     = THIS.this_oBusinessObject.this_cTpOps
        loc_oPg2.txt_4c_Cgrus.Value     = THIS.this_oBusinessObject.this_cCgrus
        loc_oPg2.txt_4c_Opers.Value     = THIS.this_oBusinessObject.this_cOpers
        loc_oPg2.txt_4c_mercs.Value     = THIS.this_oBusinessObject.this_cMercs
        loc_oPg2.txt_4c_Grupos.Value    = THIS.this_oBusinessObject.this_cGrupos
        loc_oPg2.txt_4c_Contas.Value    = THIS.this_oBusinessObject.this_cContas
        loc_oPg2.txt_4c_ContaOrig.Value = THIS.this_oBusinessObject.this_cContaOrig
        loc_oPg2.txt_4c_CodCors.Value   = THIS.this_oBusinessObject.this_cCodCors

        *-- OptionGroup.Value SEMPRE numerico; default 2 se zerado
        IF THIS.this_oBusinessObject.this_nExclus = 1
            loc_oPg2.opt_4c_Exclus.Value = 1
        ELSE
            loc_oPg2.opt_4c_Exclus.Value = 2
        ENDIF

        *-- Carregar descricao de Cgrus (SigCdGrp.DGrus)
        loc_cDesc = ""
        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCgrus))
            TRY
                IF USED("cursor_4c_DescGrp")
                    USE IN cursor_4c_DescGrp
                ENDIF
                loc_cSQL = "SELECT TOP 1 DGrus FROM SigCdGrp WHERE CGrus = " + ;
                           EscaparSQL(THIS.this_oBusinessObject.this_cCgrus)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGrp")
                IF loc_nResult >= 0 AND USED("cursor_4c_DescGrp") AND RECCOUNT("cursor_4c_DescGrp") > 0
                    SELECT cursor_4c_DescGrp
                    loc_cDesc = ALLTRIM(TratarNulo(DGrus, "C"))
                ENDIF
                IF USED("cursor_4c_DescGrp")
                    USE IN cursor_4c_DescGrp
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o Grupo Produto:" + ;
                        CHR(13) + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
        loc_oPg2.txt_4c_DGrus.Value = loc_cDesc

        *-- Carregar descricao de Grupos (SigCdGcr.Descrs)
        loc_cDesc = ""
        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
            TRY
                IF USED("cursor_4c_DescGcr")
                    USE IN cursor_4c_DescGcr
                ENDIF
                loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = " + ;
                           EscaparSQL(THIS.this_oBusinessObject.this_cGrupos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGcr")
                IF loc_nResult >= 0 AND USED("cursor_4c_DescGcr") AND RECCOUNT("cursor_4c_DescGcr") > 0
                    SELECT cursor_4c_DescGcr
                    loc_cDesc = ALLTRIM(TratarNulo(Descrs, "C"))
                ENDIF
                IF USED("cursor_4c_DescGcr")
                    USE IN cursor_4c_DescGcr
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o Grupo Contab:" + ;
                        CHR(13) + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
        loc_oPg2.txt_4c_DGrupos.Value = loc_cDesc
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2 para novo registro
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Dopps", 5)
            loc_oPg2.txt_4c_Dopps.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TpOps", 5)
            loc_oPg2.txt_4c_TpOps.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Cgrus", 5)
            loc_oPg2.txt_4c_Cgrus.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrus", 5)
            loc_oPg2.txt_4c_DGrus.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Opers", 5)
            loc_oPg2.txt_4c_Opers.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_mercs", 5)
            loc_oPg2.txt_4c_mercs.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Grupos", 5)
            loc_oPg2.txt_4c_Grupos.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupos", 5)
            loc_oPg2.txt_4c_DGrupos.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
            loc_oPg2.txt_4c_Contas.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_ContaOrig", 5)
            loc_oPg2.txt_4c_ContaOrig.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_CodCors", 5)
            loc_oPg2.txt_4c_CodCors.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "opt_4c_Exclus", 5)
            loc_oPg2.opt_4c_Exclus.Value    = 2
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos de edicao da Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Dopps", 5)
            loc_oPg2.txt_4c_Dopps.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TpOps", 5)
            loc_oPg2.txt_4c_TpOps.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Cgrus", 5)
            loc_oPg2.txt_4c_Cgrus.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Opers", 5)
            loc_oPg2.txt_4c_Opers.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_mercs", 5)
            loc_oPg2.txt_4c_mercs.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Grupos", 5)
            loc_oPg2.txt_4c_Grupos.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
            loc_oPg2.txt_4c_Contas.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_ContaOrig", 5)
            loc_oPg2.txt_4c_ContaOrig.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_CodCors", 5)
            loc_oPg2.txt_4c_CodCors.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "opt_4c_Exclus", 5)
            loc_oPg2.opt_4c_Exclus.Enabled    = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaDopps - Lookup customizado para Dopps (UNION SigCdOpe + SigCdOpd)
    * Pattern A canonico: SQL no caller + DefinirCursor + Mostrar
    *==========================================================================
    PROCEDURE AbrirBuscaDopps()
        LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF USED("cursor_4c_BuscaDopps")
                USE IN cursor_4c_BuscaDopps
            ENDIF

            loc_cSQL = "SELECT DISTINCT Dopes AS Dopps, Dopes AS Descs FROM SigCdOpe" + ;
                       " UNION" + ;
                       " SELECT DISTINCT Dopps, Dopps AS Descs FROM SigCdOpd" + ;
                       " ORDER BY Dopps"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDopps")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaDopps") AND RECCOUNT("cursor_4c_BuscaDopps") > 0
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.DefinirCursor("cursor_4c_BuscaDopps", "Dopps", "Descs", ;
                                              "Movimenta" + CHR(231) + CHR(227) + "o")
                    IF loc_oLookup.Mostrar()
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Dopps", 5)
                            loc_oPg2.txt_4c_Dopps.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o encontrada.", "Movimenta" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_BuscaDopps")
                USE IN cursor_4c_BuscaDopps
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar Movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormRop.AbrirBuscaDopps")
            IF USED("cursor_4c_BuscaDopps")
                USE IN cursor_4c_BuscaDopps
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaDopps - KeyPress do txt_4c_Dopps: F4 abre lookup
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TeclaDopps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28 AND !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF par_nKeyCode = 28
            THIS.AbrirBuscaDopps()
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaTpOps - KeyPress do txt_4c_TpOps: F4 abre lookup SigOpOpt
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TeclaTpOps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        IF par_nKeyCode = 28 AND !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF par_nKeyCode = 28
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.AbrirLookupCanonico("SigOpOpt", "Cods", "Descs", ;
                "Tipo de Material", ALLTRIM(loc_oPg2.txt_4c_TpOps.Value), ;
                loc_oPg2.txt_4c_TpOps, .NULL., "Situas <> 2")
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaCgrus - KeyPress do txt_4c_Cgrus: F4 abre lookup SigCdGrp
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TeclaCgrus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        IF par_nKeyCode = 28 AND !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF par_nKeyCode = 28
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.AbrirLookupCanonico("SigCdGrp", "CGrus", "DGrus", ;
                "Grupo de Produto", ALLTRIM(loc_oPg2.txt_4c_Cgrus.Value), ;
                loc_oPg2.txt_4c_Cgrus, loc_oPg2.txt_4c_DGrus)
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaOpers - KeyPress do txt_4c_Opers: converte para maiuscula e valida
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TeclaOpers(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF PEMSTATUS(loc_oPg2, "txt_4c_Opers", 5)
            loc_cVal = UPPER(ALLTRIM(loc_oPg2.txt_4c_Opers.Value))
            IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "E", "S")
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o Estoque inv" + CHR(225) + "lida!" + CHR(13) + ;
                         "Use E (Entrada), S (Sa" + CHR(237) + "da) ou deixe em branco.")
                loc_oPg2.txt_4c_Opers.Value = ""
            ELSE
                loc_oPg2.txt_4c_Opers.Value = loc_cVal
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaMercs - KeyPress do txt_4c_mercs: F4 abre lookup SigCdGpr
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TeclaMercs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        IF par_nKeyCode = 28 AND !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF par_nKeyCode = 28
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.AbrirLookupCanonico("SigCdGpr", "codigos", "descs", ;
                "Grande Grupo", ALLTRIM(loc_oPg2.txt_4c_mercs.Value), ;
                loc_oPg2.txt_4c_mercs, .NULL.)
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaGrupos - KeyPress do txt_4c_Grupos: F4 abre lookup SigCdGcr
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TeclaGrupos(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        IF par_nKeyCode = 28 AND !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF par_nKeyCode = 28
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.AbrirLookupCanonico("SigCdGcr", "Codigos", "Descrs", ;
                "Grupo Contab", ALLTRIM(loc_oPg2.txt_4c_Grupos.Value), ;
                loc_oPg2.txt_4c_Grupos, loc_oPg2.txt_4c_DGrupos)
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaContas - KeyPress do txt_4c_Contas: F4 abre lookup SigCdCli
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TeclaContas(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        IF par_nKeyCode = 28 AND !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF par_nKeyCode = 28
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.AbrirLookupCanonico("SigCdCli", "IClis", "Razaos", ;
                "Conta Destino", ALLTRIM(loc_oPg2.txt_4c_Contas.Value), ;
                loc_oPg2.txt_4c_Contas, .NULL.)
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaContaOrig - KeyPress do txt_4c_ContaOrig: F4 abre lookup SigCdCli
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TeclaContaOrig(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        IF par_nKeyCode = 28 AND !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF par_nKeyCode = 28
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.AbrirLookupCanonico("SigCdCli", "IClis", "Razaos", ;
                "Conta Origem", ALLTRIM(loc_oPg2.txt_4c_ContaOrig.Value), ;
                loc_oPg2.txt_4c_ContaOrig, .NULL.)
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaCodCors - KeyPress do txt_4c_CodCors: F4 abre lookup SigCdCor
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TeclaCodCors(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        IF par_nKeyCode = 28 AND !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF par_nKeyCode = 28
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.AbrirLookupCanonico("SigCdCor", "Cods", "Descs", ;
                "Cor", ALLTRIM(loc_oPg2.txt_4c_CodCors.Value), ;
                loc_oPg2.txt_4c_CodCors, .NULL.)
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_BuscaRop")
            USE IN cursor_4c_BuscaRop
        ENDIF

        IF USED("cursor_4c_BuscaDopps")
            USE IN cursor_4c_BuscaDopps
        ENDIF

        IF USED("cursor_4c_LkpCanonico")
            USE IN cursor_4c_LkpCanonico
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
