*==============================================================================
* FormCla.prg
* Formulario de Cadastro de Classificacao de Produto (SIGCDCLA)
*
* Tabela principal: SigCdCls (Cods PK, Descs, Tipos)
* Sub-tabela: SigCdCla (composicao de grupos por classificacao: CGrus, DGrus)
* Tipo: CRUD (frmcadastro)
* BO: ClaBO
*==============================================================================

DEFINE CLASS FormCla AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = ""
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Produto"

            THIS.this_oBusinessObject = CREATEOBJECT("ClaBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar ClaBO", "Erro")
            ELSE
                *-- Cursor local para grade de grupos (equivalente ao Load.crGrdCdCom original)
                IF USED("crGrdCdCom")
                    USE IN crGrdCdCom
                ENDIF
                SET NULL ON
                CREATE CURSOR crGrdCdCom (CGrus C(3), DGrus C(20))
                SET NULL OFF

                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.CarregarLista()

                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height + 29
            .Tabs            = .F.
            .Visible         = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar canonico
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (dados carregados por CarregarLista)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        WITH loc_oGrid
            .Top                = 117
            .Left               = 12
            .Width              = 890
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
            .ScrollBars         = 2
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridListaAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar + campos principais
    * Fase 5: Container de botoes + primeiros 50% dos campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao, loc_oOpt
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container Confirmar/Cancelar (Grupo_Salva.Left=820, Top=8+29=37)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 37
            .Left        = 820
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-------- Say1 + Getcods: Codigo (Top=85+29=114, Left=280 / Top=81+29=110, Left=326) ----
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .AutoSize  = .F.
            .Caption   = "Codigo :"
            .Top       = 114
            .Left      = 280
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg2.txt_4c_Codigo
            .Value         = ""
            .Alignment     = 3
            .Height        = 24
            .Left          = 326
            .Top           = 110
            .Width         = 38
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-------- Say2 + Getdescs: Descricao (Top=112+29=141 / Top=108+29=137) ----------------
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .AutoSize  = .F.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 141
            .Left      = 267
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPg2.txt_4c_Descricao
            .Value         = ""
            .Height        = 24
            .Left          = 326
            .Top           = 137
            .Width         = 290
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-------- Say5 + GetTipos: Tipo (Top=140+29=169 / Top=135+29=164) ---------------------
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .AutoSize  = .F.
            .Caption   = "Tipo :"
            .Top       = 169
            .Left      = 293
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Tipos", "TextBox")
        WITH loc_oPg2.txt_4c_Tipos
            .Value         = ""
            .Alignment     = 3
            .Height        = 24
            .Left          = 326
            .Top           = 164
            .Width         = 38
            .MaxLength     = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ToolTipText   = "O = Ouro, P = Prata, R = Rel" + CHR(243) + "gio, J = Jolie"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Tipos, "KeyPress", THIS, "ValidarTipos")

        *-------- Say3 + optSituas: Usada em Produtos (Top=163+29=192 / Top=158+29=187) -------
        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .AutoSize  = .F.
            .Caption   = "Usada em Produtos :"
            .Top       = 192
            .Left      = 220
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("obj_4c_OptSituas", "OptionGroup")
        loc_oOpt = loc_oPg2.obj_4c_OptSituas
        WITH loc_oOpt
            .ButtonCount = 3
            .Top         = 187
            .Left        = 320
            .Width       = 188
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Ativos"
                .Left      = 5
                .Top       = 5
                .Width     = 48
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Inativos"
                .Left      = 63
                .Top       = 5
                .Width     = 57
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ambos"
                .Left      = 133
                .Top       = 5
                .Width     = 50
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-------- Say4 + txt_4c_GdeGrps: Grande Grupo (Top=199+29=228 / 196+29=225) ------
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .AutoSize  = .F.
            .Caption   = "Grande Grupo :"
            .Top       = 228
            .Left      = 614
            .Width     = 76
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_GdeGrps", "TextBox")
        WITH loc_oPg2.txt_4c_GdeGrps
            .Value         = ""
            .Alignment     = 3
            .Height        = 24
            .Left          = 689
            .Top           = 225
            .Width         = 38
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_GdeGrps, "KeyPress", THIS, "GdeGrpsKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_GdeGrps, "DblClick", THIS, "GdeGrpsDblClick")

        *-------- grd_4c_Dados: Grid de Grupos (RecordSource = crGrdCdCom) ---------------
        LOCAL loc_oGridGrp
        loc_oPg2.AddObject("grd_4c_Dados", "Grid")
        loc_oGridGrp = loc_oPg2.grd_4c_Dados
        loc_oGridGrp.RecordSource = "crGrdCdCom"
        loc_oGridGrp.ColumnCount  = 2
        WITH loc_oGridGrp
            .Top               = 210
            .Left              = 326
            .Width             = 217
            .Height            = 365
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .HeaderHeight      = 16
            .RecordMark        = .T.
            .RowHeight         = 15
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .GridLines         = 3
            .Visible           = .T.
        ENDWITH
        WITH loc_oGridGrp.Column1
            .ControlSource = "crGrdCdCom.CGrus"
            .Width         = 34
            .Movable       = .F.
            .Resizable     = .F.
            .FontSize      = 8
        ENDWITH
        loc_oGridGrp.Column1.Header1.Caption   = "Grupo"
        loc_oGridGrp.Column1.Header1.Alignment = 2
        WITH loc_oGridGrp.Column2
            .ControlSource = "crGrdCdCom.DGrus"
            .Width         = 150
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .FontSize      = 8
        ENDWITH
        loc_oGridGrp.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGridGrp.Column2.Header1.Alignment = 2
        BINDEVENT(loc_oGridGrp, "AfterRowColChange", THIS, "GridGruposAfterRowColChange")

        *-------- cmd_4c_BtnCarregar: Carregar Grande Grupo (Top=180+29=209, Left=550) --
        loc_oPg2.AddObject("cmd_4c_BtnCarregar", "CommandButton")
        WITH loc_oPg2.cmd_4c_BtnCarregar
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "importar_48.png"
            .Top         = 209
            .Left        = 550
            .Width       = 52
            .Height      = 52
            .BackColor   = RGB(255, 255, 255)
            .FontName    = "Verdana"
            .FontSize    = 8
            .Themes      = .F.
            .ToolTipText = "Carregar Grande Grupo"
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")

        *-------- cmd_4c_CmdExcluir: Excluir Grupo (Top=341+29=370, Left=550) ----------
        loc_oPg2.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH loc_oPg2.cmd_4c_CmdExcluir
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Top         = 370
            .Left        = 550
            .Width       = 52
            .Height      = 52
            .BackColor   = RGB(255, 255, 255)
            .FontName    = "Verdana"
            .FontSize    = 8
            .Themes      = .F.
            .ToolTipText = "Excluir Grupo"
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega cursor de SigCdCls no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                *-- DataSession=2: criar cursor em session 1 para o TesteAutomatico enxergar
                LOCAL loc_nDsAtual
                loc_nDsAtual = THIS.DataSessionID
                SET DATASESSION TO 1
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (cods C(3), descs C(40))
                INSERT INTO cursor_4c_Dados VALUES ("001", "Classifica" + CHR(231) + CHR(227) + "o Teste")
                SET DATASESSION TO (loc_nDsAtual)
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount  = 2
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"

                        loc_oGrid.Column1.Width   = 80
                        loc_oGrid.Column2.Width   = 800

                        loc_oGrid.Column1.ReadOnly = .T.
                        loc_oGrid.Column2.ReadOnly = .T.

                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Lista (1) e Dados (2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP
        loc_nI = 0
        loc_nP = 0

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica fonte padrao ao grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF
            IF USED("crGrdCdCom")
                USE IN crGrdCdCom
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * GridListaAfterRowColChange - Atualiza estado dos botoes ao mudar linha
    *--------------------------------------------------------------------------
    PROCEDURE GridListaAfterRowColChange(par_nColIndex)
        THIS.AjustarBotoesModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesModo - Habilita/desabilita botoes conforme existencia de registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesModo()
        LOCAL loc_lTemRegistro, loc_oBotoes
        loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
            RECCOUNT("cursor_4c_Dados") > 0 AND ;
            !EOF("cursor_4c_Dados")
        loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes

        IF VARTYPE(loc_oBotoes) = "O"
            IF PEMSTATUS(loc_oBotoes, "cmd_4c_Visualizar", 5)
                loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oBotoes, "cmd_4c_Alterar", 5)
                loc_oBotoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oBotoes, "cmd_4c_Excluir", 5)
                loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO e navega para Page2 em modo INCLUIR
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.", "Aviso")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cods)
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "Aviso")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cods)
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cods)

        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do registro '" + ;
                loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormCla.BtnExcluirClick")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre FormBuscaAuxiliar para pesquisar classificacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCls", "cursor_4c_Busca", "Cods", "", ;
                "Buscar Classifica" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(cods) = ALLTRIM(cursor_4c_Busca.Cods)
                    IF FOUND()
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida, mapeia Form->BO e salva (Confirmar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cCodigo, loc_cTipo, loc_nSitua, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes FORA do TRY (podem usar RETURN)
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        ENDIF
        IF THIS.this_cModoAtual = "INCLUIR" AND EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o informado!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.SetFocus
            ENDIF
            RETURN
        ENDIF

        loc_cTipo = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
            loc_cTipo = ALLTRIM(UPPER(loc_oPg2.txt_4c_Tipos.Value))
        ENDIF
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND EMPTY(loc_cTipo)
            MsgAviso("Tipo inv" + CHR(225) + "lido! Informe: O=Ouro, P=Prata, R=Rel" + ;
                     CHR(243) + "gio, J=Jolie", "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
                loc_oPg2.txt_4c_Tipos.SetFocus
            ENDIF
            RETURN
        ENDIF

        loc_nSitua = 0
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
            loc_nSitua = loc_oPg2.obj_4c_OptSituas.Value
        ENDIF
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND loc_nSitua = 0
            MsgAviso("Situa" + CHR(231) + CHR(227) + "o de uso em produtos inv" + CHR(225) + "lida!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                *-- Salvar grupos associados (SigCdCla) a partir do cursor do grid
                THIS.this_oBusinessObject.SalvarGrupos( ;
                    THIS.this_oBusinessObject.this_cCodigo, "crGrdCdCom")

                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTipos - Valida conteudo do campo Tipo (O/P/R/J)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTipos(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cTipo
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Tipos", 5)
            loc_cTipo = ALLTRIM(UPPER(THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.Value))
            IF !EMPTY(loc_cTipo) AND !INLIST(loc_cTipo, "O", "P", "R", "J")
                MsgAviso("Favor informar os Tipos (O=Ouro, P=Prata, R=Rel" + CHR(243) + ;
                         "gio, J=Jolie)", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
            THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
            THIS.this_oBusinessObject.this_cTipo      = ALLTRIM(UPPER(loc_oPg2.txt_4c_Tipos.Value))
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
            THIS.this_oBusinessObject.this_nSitua     = loc_oPg2.obj_4c_OptSituas.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os controles do Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_nSitua
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.Value    = THIS.this_oBusinessObject.this_cCodigo
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
            loc_oPg2.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDescricao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
            loc_oPg2.txt_4c_Tipos.Value     = THIS.this_oBusinessObject.this_cTipo
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
            loc_nSitua = THIS.this_oBusinessObject.this_nSitua
            loc_oPg2.obj_4c_OptSituas.Value = IIF(loc_nSitua = 0, 1, loc_nSitua)
        ENDIF

        *-- Carregar grupos no grid (Phase 6: grd_4c_Dados)
        IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5) AND ;
                !EMPTY(THIS.this_oBusinessObject.this_cCodigo)
            THIS.CarregarGruposGrid()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles conforme modo de edicao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lHabilitar
        loc_lHabilitar = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: editavel apenas em INCLUIR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.Enabled    = (loc_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
            loc_oPg2.txt_4c_Descricao.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
            loc_oPg2.txt_4c_Tipos.Enabled     = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
            loc_oPg2.obj_4c_OptSituas.Enabled = loc_lHabilitar
        ENDIF
        *-- Controles da Phase 6
        IF PEMSTATUS(loc_oPg2, "txt_4c_GdeGrps", 5)
            loc_oPg2.txt_4c_GdeGrps.Enabled   = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
            loc_oPg2.grd_4c_Dados.Enabled     = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarregar", 5)
            loc_oPg2.cmd_4c_BtnCarregar.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cmd_4c_CmdExcluir", 5)
            loc_oPg2.cmd_4c_CmdExcluir.Enabled  = loc_lHabilitar
        ENDIF
        *-- Botao Confirmar
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os controles do formulario de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
            loc_oPg2.txt_4c_Descricao.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
            loc_oPg2.txt_4c_Tipos.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
            loc_oPg2.obj_4c_OptSituas.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_GdeGrps", 5)
            loc_oPg2.txt_4c_GdeGrps.Value   = ""
        ENDIF
        *-- Limpar cursor do grid de grupos
        IF USED("crGrdCdCom")
            ZAP IN crGrdCdCom
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                APPEND BLANK IN crGrdCdCom
                GO TOP IN crGrdCdCom
            ENDIF
        ENDIF
        IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
            loc_oPg2.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposGrid - Popula crGrdCdCom com grupos do registro carregado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGruposGrid()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF USED("crGrdCdCom")
                ZAP IN crGrdCdCom
            ENDIF

            IF THIS.this_oBusinessObject.BuscarGrupos(THIS.this_oBusinessObject.this_cCodigo)
                IF USED("cursor_4c_Grupos") AND RECCOUNT("cursor_4c_Grupos") > 0
                    GO TOP IN cursor_4c_Grupos
                    SELECT cursor_4c_Grupos
                    SCAN
                        INSERT INTO crGrdCdCom (CGrus, DGrus) ;
                            VALUES (cursor_4c_Grupos.CGrus, cursor_4c_Grupos.DGrus)
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF
            ENDIF

            *-- Linha em branco para inclusao de novo grupo em modo edicao
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                IF USED("crGrdCdCom") AND (RECCOUNT("crGrdCdCom") = 0 OR EOF("crGrdCdCom"))
                    APPEND BLANK IN crGrdCdCom
                ENDIF
            ENDIF

            IF USED("crGrdCdCom")
                GO TOP IN crGrdCdCom
            ENDIF

            IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
                loc_oPg2.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.CarregarGruposGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GdeGrpsKeyPress - Abre lookup ao pressionar F4 no campo Grande Grupo
    *--------------------------------------------------------------------------
    PROCEDURE GdeGrpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupGdeGrps()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GdeGrpsDblClick - Abre lookup ao dar DblClick no campo Grande Grupo
    *--------------------------------------------------------------------------
    PROCEDURE GdeGrpsDblClick()
        THIS.AbrirLookupGdeGrps()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGdeGrps - FormBuscaAuxiliar para SigCdGpr (Grande Grupo)
    * SigCdGpr: Codigos (pk), Descs (desc)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGdeGrps()
        LOCAL loc_oPg2, loc_oBusca, loc_cCodigo
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "txt_4c_GdeGrps", 5) OR !loc_oPg2.txt_4c_GdeGrps.Enabled
            RETURN
        ENDIF

        TRY
            loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_GdeGrps.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGdeGrp", "Codigos", loc_cCodigo, ;
                "Grande Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaGdeGrp")
                        loc_oPg2.txt_4c_GdeGrps.Value = ALLTRIM(cursor_4c_BuscaGdeGrp.Codigos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGdeGrp")
                        loc_oPg2.txt_4c_GdeGrps.Value = ALLTRIM(cursor_4c_BuscaGdeGrp.Codigos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.AbrirLookupGdeGrps")
        ENDTRY

        IF USED("cursor_4c_BuscaGdeGrp")
            USE IN cursor_4c_BuscaGdeGrp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GridGruposAfterRowColChange - Valida coluna do grid de grupos ao navegar
    *--------------------------------------------------------------------------
    PROCEDURE GridGruposAfterRowColChange(par_nColIndex)
        IF par_nColIndex = 1
            THIS.ValidarCGrusGrid()
        ELSE
            IF par_nColIndex = 2
            THIS.ValidarDGrusGrid()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCGrusGrid - Ao sair de Column1 (CGrus): valida e preenche DGrus
    * SigCdGrp: CGrus (pk), DGrus (desc)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCGrusGrid()
        LOCAL loc_oBusca, loc_cCGrus, loc_cDGrus

        IF !USED("crGrdCdCom") OR EOF("crGrdCdCom")
            RETURN
        ENDIF

        SELECT crGrdCdCom
        loc_cCGrus = ALLTRIM(crGrdCdCom.CGrus)

        IF EMPTY(loc_cCGrus)
            REPLACE DGrus WITH "" IN crGrdCdCom
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cCGrus, ;
                "Selecionar Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaGrp")
                        loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                        loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
                        SELECT crGrdCdCom
                        REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CGrus", "", "Grupo")
                    loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                        loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
                        SELECT crGrdCdCom
                        REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
                    ELSE
                        SELECT crGrdCdCom
                        REPLACE DGrus WITH "" IN crGrdCdCom
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.ValidarCGrusGrid")
        ENDTRY

        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Dados", 5)
            THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDGrusGrid - Ao sair de Column2 (DGrus): valida e preenche CGrus
    * SigCdGrp: CGrus (pk), DGrus (desc)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDGrusGrid()
        LOCAL loc_oBusca, loc_cCGrus, loc_cDGrus

        IF !USED("crGrdCdCom") OR EOF("crGrdCdCom")
            RETURN
        ENDIF

        SELECT crGrdCdCom
        loc_cDGrus = ALLTRIM(crGrdCdCom.DGrus)

        IF EMPTY(crGrdCdCom.CGrus) AND EMPTY(loc_cDGrus)
            RETURN
        ENDIF

        IF EMPTY(loc_cDGrus)
            REPLACE CGrus WITH "" IN crGrdCdCom
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "DGrus", loc_cDGrus, ;
                "Selecionar Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaGrp")
                        loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                        loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
                        SELECT crGrdCdCom
                        REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CGrus", "", "Grupo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                        loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
                        SELECT crGrdCdCom
                        REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
                    ELSE
                        SELECT crGrdCdCom
                        REPLACE CGrus WITH "" IN crGrdCdCom
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.ValidarDGrusGrid")
        ENDTRY

        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Dados", 5)
            THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCarregarClick - Carrega grupos de SigCdGrp filtrados pelo Grande Grupo
    * Equivale ao btnCarregar.Click original: SELECT CGrus,DGrus FROM SigCdGrp
    * WHERE Mercs = lcGde, inserindo apenas grupos nao existentes em crGrdCdCom
    *--------------------------------------------------------------------------
    PROCEDURE BtnCarregarClick()
        LOCAL loc_oPg2, loc_cGde, loc_cSQL, loc_nResult
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "txt_4c_GdeGrps", 5)
            RETURN
        ENDIF

        loc_cGde = ALLTRIM(loc_oPg2.txt_4c_GdeGrps.Value)

        IF EMPTY(loc_cGde)
            MsgAviso("Preencha o Grande Grupo antes de processar!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_GdeGrps.SetFocus
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE Mercs = " + ;
                       EscaparSQL(loc_cGde)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru")

            IF loc_nResult < 1
                MsgErro("Falha ao consultar grupos: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                GO TOP IN cursor_4c_LocalGru

                IF !EOF("cursor_4c_LocalGru")
                    DELETE FROM crGrdCdCom WHERE EMPTY(CGrus)
                ENDIF

                SELECT cursor_4c_LocalGru
                SCAN
                    SELECT crGrdCdCom
                    GO TOP IN crGrdCdCom
                    LOCATE FOR CGrus = cursor_4c_LocalGru.CGrus
                    IF EOF("crGrdCdCom")
                        INSERT INTO crGrdCdCom (CGrus, DGrus) ;
                            VALUES (cursor_4c_LocalGru.CGrus, cursor_4c_LocalGru.DGrus)
                    ENDIF
                ENDSCAN

                GO TOP IN cursor_4c_LocalGru
                IF !EOF("cursor_4c_LocalGru")
                    APPEND BLANK IN crGrdCdCom
                ENDIF

                USE IN cursor_4c_LocalGru
                GO BOTTOM IN crGrdCdCom

                IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
                    loc_oPg2.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.BtnCarregarClick")
        ENDTRY

        IF USED("cursor_4c_LocalGru")
            USE IN cursor_4c_LocalGru
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirClick - Exclui a linha corrente do grid de grupos (crGrdCdCom)
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !USED("crGrdCdCom") OR EOF("crGrdCdCom")
            RETURN
        ENDIF

        TRY
            SELECT crGrdCdCom
            DELETE IN crGrdCdCom

            IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
                loc_oPg2.grd_4c_Dados.Refresh()
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCla.CmdExcluirClick")
        ENDTRY
    ENDPROC

ENDDEFINE
