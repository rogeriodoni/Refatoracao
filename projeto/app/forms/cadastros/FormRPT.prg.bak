*==============================================================================
* FormRPT.prg - Cadastro Customizado de Relatorios 4Report
* Migracao de SIGCDRPT.SCX (frmcadastro)
* Fase 8/8 - Consolidacao Final (todos os metodos implementados)
*==============================================================================
DEFINE CLASS FormRPT AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1003
    Caption     = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Modo atual: LISTA | INCLUIR | ALTERAR | VISUALIZAR | EXCLUIR
    this_cModoAtual      = "LISTA"

    *-- Estado especifico deste form
    this_cSetExact       = ""   && Salva SET EXACT original (restaurado no Destroy)

    *==========================================================================
    * Init - Apenas delega para FormBase.Init() que chama InicializarForm()
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormRPT:" + CHR(13) + loc_oErro.Message, "FormRPT.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configuracao completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Salvar SET EXACT e ativar (padrao do legado)
            THIS.this_cSetExact = SET("Exact")
            SET EXACT ON

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("RPTBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar RPTBO.", "FormRPT.InicializarForm")
                loc_lSucesso = .F.
            ENDIF

            *-- Variaveis PUBLIC para filtros de data (parametros SQL: ?_vp_DtInicial/?_vp_DtFinal)
            PUBLIC _vp_DtInicial, _vp_DtFinal
            _vp_DtInicial = DATE()
            _vp_DtFinal   = DATE()

            *-- Configurar estrutura visual
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.CriarCursoresLayout()
            THIS.ConfigurarPaginaDados()

            *-- Estado inicial: Page1 (Lista)
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"

            *-- Propagar Caption para labels de titulo
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            ENDIF

            *-- Carregar lista inicial (pula se validando UI)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar:" + CHR(13) + loc_oErro.Message, "FormRPT.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame externo com Page1 (Lista) e Page2 (Dados)
    * PageFrame.Top = -29 oculta as abas; compensacao +29 em controles internos
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
            .Visible   = .T.

            *-- Pagina 1: Lista de Reports
            .Page1.Caption  = "Lista"
            .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Pagina 2: Edicao/Configuracao do Report
            .Page2.Caption  = "Dados"
            .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista de Reports)
    * Contem: cabecalho, container de 5 botoes CRUD, Encerrar e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container cabecalho (escuro, com titulo do form)
        * Top=29: compensacao do PageFrame.Top=-29
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 85
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 17
                .Left      = 12
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * Container botoes CRUD (5 botoes: Incluir, Visualizar, Alterar, Excluir, Buscar)
        * Left=542: posicao padrao Framework para botoes CRUD
        *----------------------------------------------------------------------
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container Encerrar (padrao canonico: Left=917, Width=90, Height=85)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * Grid de lista de reports
        * Top=117: compensacao(29) + altura botoes(85) + gap(3)
        * 5 colunas visiveis: NmReport, Descr, Ativo, DtCriacao, DtAlteracao
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 2
            .Width              = 995
            .Height             = 470
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes (handlers devem ser PUBLIC)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Edicao do Report)
    * PageFrame interno com 2 sub-paginas:
    *   Sub-Page1: Editor SQL + metadados + botoes salvar + grid resultado
    *   Sub-Page2: Configuracao de layout (orientacao, papel, colunas) - Fase 6
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oSubPg1
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- PageFrame interno (Top=-29: oculta abas; compensacao +29 nos controles internos)
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        WITH loc_oPagina.pgf_4c_Dados
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 631
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption = "SQL"
            .Page2.Caption = "Layout"
        ENDWITH

        *==========================================================
        * Sub-Page1: Editor SQL + Metadados + Botoes + Grid resultado
        *==========================================================
        loc_oSubPg1 = loc_oPagina.pgf_4c_Dados.Page1

        *-- Cabecalho escuro (Top=29 compensa pgf_4c_Dados.Top=-29)
        loc_oSubPg1.AddObject("cnt_4c_CabecalhoDados", "Container")
        WITH loc_oSubPg1.cnt_4c_CabecalhoDados
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width - 168
            .Height      = 85
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_TituloD_Sombra", "Label")
            WITH .lbl_4c_TituloD_Sombra
                .Caption   = "Dados do Relat" + CHR(243) + "rio"
                .Top       = 17
                .Left      = 12
                .Width     = THIS.Width - 188
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_TituloD", "Label")
            WITH .lbl_4c_TituloD
                .Caption   = "Dados do Relat" + CHR(243) + "rio"
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width - 188
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container Confirmar/Cancelar (Left=835: 832 cabecalho + 3 gap)
        loc_oSubPg1.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oSubPg1.cnt_4c_Salva
            .Top         = 29
            .Left        = THIS.Width - 165
            .Width       = 165
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_confirmar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 85
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Row 1 (Top=120): Nome do Report
        loc_oSubPg1.AddObject("lbl_4c_NmReport", "Label")
        WITH loc_oSubPg1.lbl_4c_NmReport
            .Caption   = "Nome:"
            .Top       = 123
            .Left      = 5
            .Width     = 48
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oSubPg1.AddObject("txt_4c_NmReport", "TextBox")
        WITH loc_oSubPg1.txt_4c_NmReport
            .Value       = ""
            .Top         = 120
            .Left        = 56
            .Width       = 335
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 100
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Row 1: Ativo
        loc_oSubPg1.AddObject("lbl_4c_Ativo", "Label")
        WITH loc_oSubPg1.lbl_4c_Ativo
            .Caption   = "Ativo:"
            .Top       = 123
            .Left      = 398
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oSubPg1.AddObject("chk_4c_Ativo", "CheckBox")
        WITH loc_oSubPg1.chk_4c_Ativo
            .Value   = 1
            .Caption = ""
            .Top     = 121
            .Left    = 438
            .Width   = 20
            .Height  = 20
            .Visible = .T.
        ENDWITH

        *-- Row 1: DtCriacao
        loc_oSubPg1.AddObject("lbl_4c_DtCriacao", "Label")
        WITH loc_oSubPg1.lbl_4c_DtCriacao
            .Caption   = "Criado em:"
            .Top       = 123
            .Left      = 465
            .Width     = 65
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oSubPg1.AddObject("txt_4c_DtCriacao", "TextBox")
        WITH loc_oSubPg1.txt_4c_DtCriacao
            .Value       = ""
            .Top         = 120
            .Left        = 533
            .Width       = 90
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ReadOnly    = .T.
            .BackColor   = RGB(240, 240, 240)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Row 1: DtAlteracao
        loc_oSubPg1.AddObject("lbl_4c_DtAlteracao", "Label")
        WITH loc_oSubPg1.lbl_4c_DtAlteracao
            .Caption   = "Alterado em:"
            .Top       = 123
            .Left      = 630
            .Width     = 75
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oSubPg1.AddObject("txt_4c_DtAlteracao", "TextBox")
        WITH loc_oSubPg1.txt_4c_DtAlteracao
            .Value       = ""
            .Top         = 120
            .Left        = 708
            .Width       = 90
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ReadOnly    = .T.
            .BackColor   = RGB(240, 240, 240)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Row 2 (Top=150): Descricao (EditBox multilinhas)
        loc_oSubPg1.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oSubPg1.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o:"
            .Top       = 153
            .Left      = 5
            .Width     = 48
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oSubPg1.AddObject("edt_4c_Descricao", "EditBox")
        WITH loc_oSubPg1.edt_4c_Descricao
            .Value       = ""
            .Top         = 150
            .Left        = 56
            .Width       = 936
            .Height      = 53
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 200
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .ScrollBars  = 2
            .Visible     = .T.
        ENDWITH

        *-- Row 3 (Top=208): ComboBox para copiar SQL de outro report
        loc_oSubPg1.AddObject("lbl_4c_CopiarSQL", "Label")
        WITH loc_oSubPg1.lbl_4c_CopiarSQL
            .Caption   = "Copiar SQL de:"
            .Top       = 211
            .Left      = 5
            .Width     = 85
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oSubPg1.AddObject("cbo_4c_NmReports", "ComboBox")
        WITH loc_oSubPg1.cbo_4c_NmReports
            .Value         = ""
            .Top           = 208
            .Left          = 93
            .Width         = 295
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Style         = 2
            .RowSourceType = 0
            .RowSource     = ""
            .BoundColumn   = 1
            .ColumnCount   = 1
            .ColumnWidths  = "295"
            .Visible       = .T.
        ENDWITH

        *-- Container de hints de teclado (F8/F9)
        loc_oSubPg1.AddObject("cnt_4c_Container1", "Container")
        WITH loc_oSubPg1.cnt_4c_Container1
            .Top         = 170
            .Left        = 326
            .Width       = 600
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_HintF8", "Label")
            WITH .lbl_4c_HintF8
                .Caption   = "[F8] Executar SQL"
                .Top       = 4
                .Left      = 5
                .Width     = 130
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(0, 80, 160)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_HintF9", "Label")
            WITH .lbl_4c_HintF9
                .Caption   = "[F9] Gerar Relat" + CHR(243) + "rio"
                .Top       = 4
                .Left      = 145
                .Width     = 155
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(0, 80, 160)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label da SQL Query (Top=238)
        loc_oSubPg1.AddObject("lbl_4c_SqlQuery", "Label")
        WITH loc_oSubPg1.lbl_4c_SqlQuery
            .Caption   = "SQL Query:"
            .Top       = 238
            .Left      = 5
            .Width     = 65
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OLE RichText para edicao do SQL (Top=257, Height=170)
        loc_oSubPg1.AddObject("obj_4c_OleRTF_SqlCMD", "OleControl", "RICHTEXT.RichtextCtrl.1")
        WITH loc_oSubPg1.obj_4c_OleRTF_SqlCMD
            .Top     = 257
            .Left    = 5
            .Width   = 988
            .Height  = 170
            .Visible = .T.
        ENDWITH

        *-- Label do resultado (Top=433)
        loc_oSubPg1.AddObject("lbl_4c_Resultado", "Label")
        WITH loc_oSubPg1.lbl_4c_Resultado
            .Caption   = "Resultado da Query:"
            .Top       = 433
            .Left      = 5
            .Width     = 130
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de resultado (Top=452, Height=148: termina em 600px)
        loc_oSubPg1.AddObject("grd_4c_Resultado", "Grid")
        WITH loc_oSubPg1.grd_4c_Resultado
            .Top                = 452
            .Left               = 2
            .Width              = 993
            .Height             = 148
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 3
            .ReadOnly           = .T.
            .ColumnCount        = 0
            .Visible            = .T.
        ENDWITH

        *-- BINDEVENTs (handlers devem ser PUBLIC)
        BINDEVENT(loc_oSubPg1.cnt_4c_Salva.cmd_4c_Confirmar, "Click",             THIS, "BtnSalvarClick")
        BINDEVENT(loc_oSubPg1.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",             THIS, "BtnCancelarClick")
        BINDEVENT(loc_oSubPg1.cbo_4c_NmReports,              "InteractiveChange", THIS, "CboNmReportsChange")

        THIS.ConfigurarSubPaginaLayout()
        THIS.ConfigurarPgPage1()
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega grid da Page1 com lista de reports
    * Configurar ControlSource e Headers APOS RecordSource (auto-bind sobrescreve)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            THIS.this_oBusinessObject.Buscar("")
            RETURN .T.
        ENDIF

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lSucesso = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource e ColumnCount FORA de WITH (cria colunas imediatamente)
                loc_oGrid.ColumnCount = 5
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 5

                *-- ControlSource APOS RecordSource (sobrepoe auto-bind)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Ativo"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.dtcad"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.dtmodif"

                *-- Larguras das colunas
                loc_oGrid.Column1.Width = 280
                loc_oGrid.Column2.Width = 350
                loc_oGrid.Column3.Width = 50
                loc_oGrid.Column4.Width = 80
                loc_oGrid.Column5.Width = 80

                *-- Headers (obrigatorio reconfigurar apos RecordSource)
                loc_oGrid.Column1.Header1.Caption = "T" + CHR(237) + "tulo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Ativo"
                loc_oGrid.Column4.Header1.Caption = "Dt. Cria" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column5.Header1.Caption = "Dt. Altera" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)
                THIS.PopularComboReports()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormRPT.CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lSucesso = .F.
            ELSE
                DO CASE
                CASE par_nPagina = 1
                    THIS.pgf_4c_Paginas.Page1.Enabled = .T.
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual = "LISTA"

                CASE par_nPagina = 2
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    THIS.pgf_4c_Paginas.Page1.Enabled = .F.
                ENDCASE

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao alternar pagina:" + CHR(13) + loc_oErro.Message, "FormRPT.AlternarPagina")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara formulario para inclusao de novo report
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre report selecionado em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cRPT_ID
        loc_cRPT_ID = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um report para visualizar.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF BOF("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um report para visualizar.")
            RETURN
        ENDIF

        loc_cRPT_ID = ALLTRIM(cursor_4c_Dados.RPT_ID)
        IF EMPTY(loc_cRPT_ID)
            MsgAviso("Selecione um report para visualizar.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRPT_ID)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
            THIS.CarregarCursoresLayoutDoReport(loc_cRPT_ID)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre report selecionado para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cRPT_ID
        loc_cRPT_ID = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um report para alterar.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF BOF("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um report para alterar.")
            RETURN
        ENDIF

        loc_cRPT_ID = ALLTRIM(cursor_4c_Dados.RPT_ID)
        IF EMPTY(loc_cRPT_ID)
            MsgAviso("Selecione um report para alterar.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRPT_ID)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
            THIS.CarregarCursoresLayoutDoReport(loc_cRPT_ID)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui report selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cRPT_ID, loc_cNmReport
        loc_cRPT_ID   = ""
        loc_cNmReport = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um report para excluir.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF BOF("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um report para excluir.")
            RETURN
        ENDIF

        loc_cRPT_ID   = ALLTRIM(cursor_4c_Dados.RPT_ID)
        loc_cNmReport = ALLTRIM(cursor_4c_Dados.NmReport)

        IF EMPTY(loc_cRPT_ID)
            MsgAviso("Selecione um report para excluir.")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do report '" + ;
                loc_cNmReport + "'?", "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRPT_ID)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Report exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista (reset de filtros)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva inclusao ou alteracao
    * Chamado pelo botao Confirmar da Page2 (criado na Fase 5)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Report salvo com sucesso!")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    * Chamado pelo botao Cancelar da Page2 (criado na Fase 5)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO
    * Sub-controles da Page2 criados nas Fases 5-6; PEMSTATUS garante seguranca
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lOK, loc_oSubPg1
        loc_lOK = .T.

        TRY
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                loc_lResultado = .T.
            ENDIF

            loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_NmReport", 5)
                THIS.this_oBusinessObject.this_cNmReport = ;
                    UPPER(ALLTRIM(loc_oSubPg1.txt_4c_NmReport.Value))
                IF EMPTY(THIS.this_oBusinessObject.this_cNmReport)
                    MsgAviso("Obrigat" + CHR(243) + "rio informar o Nome do Report.")
                    loc_oSubPg1.txt_4c_NmReport.SetFocus()
                    loc_lOK = .F.
                ENDIF
            ENDIF

            IF loc_lOK AND PEMSTATUS(loc_oSubPg1, "edt_4c_Descricao", 5)
                THIS.this_oBusinessObject.this_cDescr = ;
                    ALLTRIM(loc_oSubPg1.edt_4c_Descricao.Value)
            ENDIF

            IF loc_lOK AND PEMSTATUS(loc_oSubPg1, "chk_4c_Ativo", 5)
                THIS.this_oBusinessObject.this_lAtivo = ;
                    (loc_oSubPg1.chk_4c_Ativo.Value = 1)
            ENDIF

            IF loc_lOK AND PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
                THIS.this_oBusinessObject.this_cSqlQuery = ;
                    ALLTRIM(loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text)
                IF EMPTY(THIS.this_oBusinessObject.this_cSqlQuery)
                    MsgAviso("Obrigat" + CHR(243) + "rio informar o SQL do Report.")
                    loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
                    loc_lOK = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao ler campos:" + CHR(13) + loc_oErro.Message, "FormRPT.FormParaBO")
            loc_lOK = .F.
        ENDTRY

        RETURN loc_lOK
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    * Sub-controles da Page2 criados nas Fases 5-6; PEMSTATUS garante seguranca
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oSubPg1
        loc_oSubPg1 = .NULL.

        TRY
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                RETURN
            ENDIF

            loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_NmReport", 5)
                loc_oSubPg1.txt_4c_NmReport.Value = ;
                    ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "edt_4c_Descricao", 5)
                loc_oSubPg1.edt_4c_Descricao.Value = ;
                    ALLTRIM(THIS.this_oBusinessObject.this_cDescr)
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "chk_4c_Ativo", 5)
                loc_oSubPg1.chk_4c_Ativo.Value = THIS.this_oBusinessObject.this_lAtivo
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtCriacao", 5)
                loc_oSubPg1.txt_4c_DtCriacao.Value = ;
                    DTOC(THIS.this_oBusinessObject.this_dDtCriacao)
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtAlteracao", 5)
                loc_oSubPg1.txt_4c_DtAlteracao.Value = ;
                    DTOC(THIS.this_oBusinessObject.this_dDtAlteracao)
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
                loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text = ;
                    ALLTRIM(THIS.this_oBusinessObject.this_cSqlQuery)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao preencher campos:" + CHR(13) + loc_oErro.Message, "FormRPT.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao na Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oSubPg1
        loc_oSubPg1 = .NULL.

        TRY
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                RETURN
            ENDIF

            loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_NmReport", 5)
                loc_oSubPg1.txt_4c_NmReport.ReadOnly    = !par_lHabilitar
                loc_oSubPg1.txt_4c_NmReport.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "edt_4c_Descricao", 5)
                loc_oSubPg1.edt_4c_Descricao.ReadOnly   = !par_lHabilitar
                loc_oSubPg1.edt_4c_Descricao.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "chk_4c_Ativo", 5)
                loc_oSubPg1.chk_4c_Ativo.Enabled = par_lHabilitar OR ;
                    (THIS.this_cModoAtual = "EXCLUIR")
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
                loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Enabled = par_lHabilitar
            ENDIF

            *-- Botao Confirmar: habilitado em edicao OU em exclusao
            LOCAL loc_oSubPg, loc_oCnt
            loc_oSubPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            IF PEMSTATUS(loc_oSubPg, "cnt_4c_Salva", 5)
                IF PEMSTATUS(loc_oSubPg.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                    loc_oSubPg.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
                        par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao habilitar campos:" + CHR(13) + loc_oErro.Message, "FormRPT.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oSubPg1
        loc_oSubPg1 = .NULL.

        TRY
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                RETURN
            ENDIF

            loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_NmReport", 5)
                loc_oSubPg1.txt_4c_NmReport.Value = ""
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "edt_4c_Descricao", 5)
                loc_oSubPg1.edt_4c_Descricao.Value = ""
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "chk_4c_Ativo", 5)
                loc_oSubPg1.chk_4c_Ativo.Value = 1
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtCriacao", 5)
                loc_oSubPg1.txt_4c_DtCriacao.Value = ""
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtAlteracao", 5)
                loc_oSubPg1.txt_4c_DtAlteracao.Value = ""
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
                loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text = ""
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtInicial", 5)
                loc_oSubPg1.txt_4c_DtInicial.Value = DTOC(DATE())
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtFinal", 5)
                loc_oSubPg1.txt_4c_DtFinal.Value = DTOC(DATE())
            ENDIF

            IF PEMSTATUS(loc_oSubPg1, "lbl_4c_SqlAlterado", 5)
                loc_oSubPg1.lbl_4c_SqlAlterado.ForeColor = RGB(0, 0, 0)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao limpar campos:" + CHR(13) + loc_oErro.Message, "FormRPT.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta visibilidade/habilitacao dos botoes por modo
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEdicao, loc_oPg1Cnt
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            *-- Botoes CRUD: habilitados apenas na lista
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
                loc_oPg1Cnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                IF PEMSTATUS(loc_oPg1Cnt, "cmd_4c_Incluir", 5)
                    loc_oPg1Cnt.cmd_4c_Incluir.Enabled    = (THIS.this_cModoAtual = "LISTA")
                    loc_oPg1Cnt.cmd_4c_Visualizar.Enabled = (THIS.this_cModoAtual = "LISTA")
                    loc_oPg1Cnt.cmd_4c_Alterar.Enabled    = (THIS.this_cModoAtual = "LISTA")
                    loc_oPg1Cnt.cmd_4c_Excluir.Enabled    = (THIS.this_cModoAtual = "LISTA")
                    loc_oPg1Cnt.cmd_4c_Buscar.Enabled     = (THIS.this_cModoAtual = "LISTA")
                ENDIF
            ENDIF

            *-- Botoes de salvar (Page2 sub-page, criados na Fase 5)
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                LOCAL loc_oSub1
                loc_oSub1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                IF PEMSTATUS(loc_oSub1, "cnt_4c_Salva", 5)
                    IF PEMSTATUS(loc_oSub1.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                        loc_oSub1.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
                            loc_lEdicao OR (THIS.this_cModoAtual = "EXCLUIR")
                    ENDIF
                    IF PEMSTATUS(loc_oSub1.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
                        loc_oSub1.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao ajustar botoes:" + CHR(13) + loc_oErro.Message, "FormRPT.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CboNmReportsChange - Ao selecionar report no combo, copia seu SQL
    *==========================================================================
    PROCEDURE CboNmReportsChange()
        LOCAL loc_oSubPg1, loc_cNmReport, loc_cRPT_ID, loc_cSQL, loc_nRes
        loc_cNmReport = ""
        loc_cRPT_ID   = ""

        TRY
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                loc_cNmReport = ""  && sem sub-page, noop
            ELSE
                loc_oSubPg1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                loc_cNmReport = ALLTRIM(loc_oSubPg1.cbo_4c_NmReports.Value)
            ENDIF

            IF !EMPTY(loc_cNmReport) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(NmReport) = loc_cNmReport
                IF FOUND()
                    loc_cRPT_ID = ALLTRIM(cursor_4c_Dados.RPT_ID)
                ENDIF
            ENDIF

            IF !EMPTY(loc_cRPT_ID) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT SqlQuery FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(loc_cRPT_ID)
                IF USED("cursor_4c_CboSQL")
                    USE IN cursor_4c_CboSQL
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CboSQL")
                IF loc_nRes >= 0 AND USED("cursor_4c_CboSQL") AND RECCOUNT("cursor_4c_CboSQL") > 0
                    SELECT cursor_4c_CboSQL
                    IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
                        loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text = ;
                            ALLTRIM(cursor_4c_CboSQL.SqlQuery)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_CboSQL")
                    USE IN cursor_4c_CboSQL
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao copiar SQL:" + CHR(13) + loc_oErro.Message, "FormRPT.CboNmReportsChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExecutarSQLClick - Executa SQL do editor e exibe no grid resultado
    * Implementacao completa na Fase 7
    *==========================================================================
    PROCEDURE BtnExecutarSQLClick()
        LOCAL loc_oSubPg1, loc_cSQL, loc_nRes, loc_oGrid, loc_j, loc_nTotalCols
        loc_cSQL = ""

        TRY
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                loc_cSQL = ""  && noop
            ELSE
                loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
                    loc_cSQL = ALLTRIM(loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text)
                ENDIF
            ENDIF

            IF EMPTY(loc_cSQL)
                MsgAviso("Informe o SQL antes de executar.")
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.")
            ELSE
                loc_oGrid = loc_oSubPg1.grd_4c_Resultado
                loc_oGrid.RecordSource = ""
                IF USED("cursor_4c_ResultadoTemp")
                    USE IN cursor_4c_ResultadoTemp
                ENDIF
                IF USED("cursor_4c_Resultado")
                    USE IN cursor_4c_Resultado
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResultadoTemp")
                IF loc_nRes >= 0 AND USED("cursor_4c_ResultadoTemp")
                    SELECT * FROM cursor_4c_ResultadoTemp INTO CURSOR cursor_4c_Resultado READWRITE
                    USE IN cursor_4c_ResultadoTemp
                    loc_oGrid.ColumnCount  = 0
                    loc_oGrid.RecordSource = "cursor_4c_Resultado"
                    *-- Reconfigurar ControlSource apos auto-bind (sobrepoe vinculo por posicao)
                    loc_nTotalCols = FCOUNT("cursor_4c_Resultado")
                    FOR loc_j = 1 TO loc_nTotalCols
                        loc_oGrid.Columns(loc_j).ControlSource = "cursor_4c_Resultado." + FIELD(loc_j, "cursor_4c_Resultado")
                        loc_oGrid.Columns(loc_j).Header1.Caption = FIELD(loc_j, "cursor_4c_Resultado")
                    NEXT
                ELSE
                    MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao executar SQL:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnExecutarSQLClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Seta variaveis de data e executa SQL (FASE 9)
    * Chamado pelo botao Processar (cmd_4c_Processar) dentro do cabecalho
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oSubPg1, loc_dIni, loc_dFim

        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

                *-- Ler datas dos campos e setar variaveis PUBLIC para SQLEXEC
                IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtInicial", 5)
                    loc_dIni = CTOD(ALLTRIM(loc_oSubPg1.txt_4c_DtInicial.Value))
                    IF !EMPTY(loc_dIni)
                        PUBLIC _vp_DtInicial
                        _vp_DtInicial = loc_dIni
                    ENDIF
                ENDIF

                IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtFinal", 5)
                    loc_dFim = CTOD(ALLTRIM(loc_oSubPg1.txt_4c_DtFinal.Value))
                    IF !EMPTY(loc_dFim)
                        PUBLIC _vp_DtFinal
                        _vp_DtFinal = loc_dFim
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ler datas:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnProcessarClick")
        ENDTRY

        THIS.BtnExecutarSQLClick()

        *-- Resetar indicador SQL alterado apos execucao
        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                IF PEMSTATUS(loc_oSubPg1, "lbl_4c_SqlAlterado", 5)
                    loc_oSubPg1.lbl_4c_SqlAlterado.ForeColor = RGB(0, 0, 0)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao resetar indicador:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnLayOutRPTClick - Salva SQL e navega para sub-pagina de Layout (FASE 9)
    * Original: Cmd_LayOutRPT.Click -> Grupo_Salva.Salva.Click()
    *==========================================================================
    PROCEDURE BtnLayOutRPTClick()
        LOCAL loc_oPg2
        TRY
            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 2
                    loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
                    *-- Sincronizar ListIndex do ComboBox com PaperSize atual do cursor
                    IF PEMSTATUS(loc_oPg2, "cbo_4c_TamPapel", 5) AND USED("cursor_4c_PropsTitulo")
                        SELECT cursor_4c_PropsTitulo
                        loc_oPg2.cbo_4c_TamPapel.ListIndex = cursor_4c_PropsTitulo.PaperSize
                    ENDIF
                    *-- Atualizar imagem de orientacao conforme valor no cursor
                    THIS.OrientacaoChanged()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar/navegar layout:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnLayOutRPTClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEstruturaClick - Mostra estrutura da tabela selecionada no editor SQL
    * Original: Cmd_Estrutura.Click -> sys.all_Columns query -> grid resultado
    *==========================================================================
    PROCEDURE BtnEstruturaClick()
        LOCAL loc_oSubPg1, loc_cTabela, loc_cSQL, loc_nRes, loc_oGrid, loc_lOK, loc_j, loc_nTotalCols
        loc_lOK = .F.

        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5) AND ;
               PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1, "obj_4c_OleRTF_SqlCMD", 5)

                loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                loc_cTabela = ALLTRIM(loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.SelText)

                IF EMPTY(loc_cTabela)
                    loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
                    MsgAviso("Selecione o nome da tabela no editor SQL.")
                ELSE
                    IF GETWORDCOUNT(loc_cTabela) > 1
                    loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
                    MsgAviso("Selecione apenas o nome da tabela (sem espa" + CHR(231) + "os).")
                ELSE
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.")
                ELSE
                    loc_cSQL = "SELECT c.ORDINAL_POSITION AS Column_ID, c.COLUMN_NAME AS Column_Name, " + ;
                        "c.DATA_TYPE AS Type, " + ;
                        "ISNULL(c.CHARACTER_MAXIMUM_LENGTH, ISNULL(c.NUMERIC_PRECISION, 0)) AS Max_Length, " + ;
                        "CASE WHEN c.NUMERIC_PRECISION IS NOT NULL THEN CAST(c.NUMERIC_PRECISION AS CHAR(3)) ELSE '' END AS Precision, " + ;
                        "CASE WHEN c.NUMERIC_SCALE IS NOT NULL THEN CAST(c.NUMERIC_SCALE AS CHAR(3)) ELSE '' END AS Scale, " + ;
                        "c.IS_NULLABLE AS Is_Nullable " + ;
                        "FROM INFORMATION_SCHEMA.COLUMNS c " + ;
                        "WHERE c.TABLE_NAME = " + EscaparSQL(loc_cTabela) + " " + ;
                        "ORDER BY c.ORDINAL_POSITION"

                    loc_oGrid = loc_oSubPg1.grd_4c_Resultado
                    loc_oGrid.RecordSource = ""
                    IF USED("cursor_4c_ResultadoTemp")
                        USE IN cursor_4c_ResultadoTemp
                    ENDIF
                    IF USED("cursor_4c_Resultado")
                        USE IN cursor_4c_Resultado
                    ENDIF

                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResultadoTemp")

                    IF loc_nRes >= 0 AND USED("cursor_4c_ResultadoTemp")
                        SELECT * FROM cursor_4c_ResultadoTemp INTO CURSOR cursor_4c_Resultado READWRITE
                        USE IN cursor_4c_ResultadoTemp
                        loc_oGrid.ColumnCount  = 0
                        loc_oGrid.RecordSource = "cursor_4c_Resultado"
                        *-- Reconfigurar ControlSource apos auto-bind (sobrepoe vinculo por posicao)
                        loc_nTotalCols = FCOUNT("cursor_4c_Resultado")
                        FOR loc_j = 1 TO loc_nTotalCols
                            loc_oGrid.Columns(loc_j).ControlSource = "cursor_4c_Resultado." + FIELD(loc_j, "cursor_4c_Resultado")
                            loc_oGrid.Columns(loc_j).Header1.Caption = FIELD(loc_j, "cursor_4c_Resultado")
                        NEXT
                        loc_lOK = .T.
                    ELSE
                        MsgErro("Tabela '" + loc_cTabela + "' n" + CHR(227) + "o encontrada.", "Estrutura")
                    ENDIF

                    loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
                    ENDIF
                    ENDIF
                ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar estrutura:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnEstruturaClick")
        ENDTRY

        RETURN loc_lOK
    ENDPROC

    *==========================================================================
    * PopularComboReports - Preenche cbo_4c_NmReports com cursor_4c_Dados
    * Chamado apos CarregarLista() para manter combo sincronizado
    *==========================================================================
    PROTECTED PROCEDURE PopularComboReports()
        LOCAL loc_oCbo, loc_cNmReport
        loc_oCbo = .NULL.

        TRY
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
                RETURN
            ENDIF
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1, "cbo_4c_NmReports", 5)
                RETURN
            ENDIF

            loc_oCbo = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.cbo_4c_NmReports
            loc_oCbo.Clear()
            loc_oCbo.AddItem("")

            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                SELECT cursor_4c_Dados
                SCAN
                    loc_cNmReport = ALLTRIM(cursor_4c_Dados.NmReport)
                    IF !EMPTY(loc_cNmReport)
                        loc_oCbo.AddItem(loc_cNmReport)
                    ENDIF
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao popular combo:" + CHR(13) + loc_oErro.Message, "FormRPT.PopularComboReports")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
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
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * CriarCursoresLayout - Cria cursores para configuracao de layout do FRX
    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresLayout()
        IF USED("cursor_4c_PropsTitulo")
            USE IN cursor_4c_PropsTitulo
        ENDIF
        IF USED("cursor_4c_PropsGrp")
            USE IN cursor_4c_PropsGrp
        ENDIF
        IF USED("cursor_4c_PropsCampos")
            USE IN cursor_4c_PropsCampos
        ENDIF
        IF USED("cursor_4c_LstCampos")
            USE IN cursor_4c_LstCampos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_PropsTitulo ( ;
            LblCaption M(4), LblFonte M(4), LblBtFonte C(1), LblBtCor I(10), ;
            LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5), ;
            Orientation I(1), PaperSize I(1) ;
        )
        APPEND BLANK
        REPLACE Orientation WITH 1, PaperSize WITH 9
        REPLACE LblCaption WITH "", LblFonte WITH "Tahoma,10,N", LblBtFonte WITH ""
        REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 90, LblTipoCmp WITH "C"

        CREATE CURSOR cursor_4c_PropsGrp ( ;
            NmCampo C(40), LblCaption M(4), LblFonte M(4), LblBtFonte C(1), ;
            LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5) ;
        )
        APPEND BLANK
        REPLACE NmCampo WITH "", LblCaption WITH "Campo de SubTotal"
        REPLACE LblFonte WITH "Tahoma,8,N", LblBtFonte WITH ""
        REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 10, LblTipoCmp WITH "C"

        CREATE CURSOR cursor_4c_PropsCampos ( ;
            NmCampo C(40), TpCampo C(10), CkOutRPT I(1), CkFiltro I(1), ;
            CkSubTot I(1), CkTotal I(1), LblCaption M(4), LblFonte M(4), ;
            LblBtFonte C(1), LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), ;
            LblTipoCmp C(1), ArrayID I(5) ;
        )

        CREATE CURSOR cursor_4c_LstCampos ( NmCampo C(40), TpCampo C(10) )
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * ConfigurarSubPaginaLayout - Constroi controles da Sub-Page2 (Layout FRX)
    * Coordenadas originais do SCX + 29 (compensa pgf_4c_Dados.Top=-29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaLayout()
        LOCAL loc_oSubPg2, loc_i
        LOCAL loc_aPaperSize(41)
        loc_oSubPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        *-- Container de botoes (CmdGrp_Acoes: Top=8+29=37)
        loc_oSubPg2.AddObject("cnt_4c_BotoesLayout", "Container")
        WITH loc_oSubPg2.cnt_4c_BotoesLayout
            .Top         = 37
            .Left        = 11
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_VoltarLayout", "CommandButton")
            WITH .cmd_4c_VoltarLayout
                .Caption  = "Voltar"
                .Top      = 5
                .Left     = 5
                .Width    = 70
                .Height   = 70
                .Visible  = .T.
            ENDWITH

            .AddObject("cmd_4c_GerarLayout", "CommandButton")
            WITH .cmd_4c_GerarLayout
                .Caption  = "Gerar" + CHR(13) + "Layout"
                .Top      = 5
                .Left     = 80
                .Width    = 70
                .Height   = 70
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *-- Label NmRelatorio (Lbl_Nm_Relatorio: Top=131+29=160)
        loc_oSubPg2.AddObject("lbl_4c_NmRelatorio", "Label")
        WITH loc_oSubPg2.lbl_4c_NmRelatorio
            .Caption   = ""
            .Top       = 160
            .Left      = 10
            .Width     = 540
            .Height    = 22
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Tamanho do Papel:" (Lbl_TamPapel: Top=48+29=77)
        loc_oSubPg2.AddObject("lbl_4c_TamPapel", "Label")
        WITH loc_oSubPg2.lbl_4c_TamPapel
            .Caption   = "Tamanho do Papel:"
            .Top       = 77
            .Left      = 202
            .Width     = 108
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- ComboBox TamPapel (Cbo_TamPapel: Top=71+29=100)
        *-- BoundColumn=2: valor ligado eh o indice numerico (col2); col1 exibe o nome
        loc_oSubPg2.AddObject("cbo_4c_TamPapel", "ComboBox")
        WITH loc_oSubPg2.cbo_4c_TamPapel
            .Top           = 100
            .Left          = 202
            .Width         = 348
            .Height        = 24
            .Style         = 2
            .ColumnCount   = 2
            .BoundColumn   = 2
            .ColumnWidths  = "300,48"
            .ControlSource = "cursor_4c_PropsTitulo.PaperSize"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Preencher 41 tamanhos de papel (legado laPaperSize)
        loc_aPaperSize[01] = "Letter, 8 1/2 x 11 in"
        loc_aPaperSize[02] = "Letter Small, 8 1/2 x 11 in"
        loc_aPaperSize[03] = "Tabloid, 11 x 17 in"
        loc_aPaperSize[04] = "Ledger, 17 x 11 in"
        loc_aPaperSize[05] = "Legal, 8 1/2 x 14 in"
        loc_aPaperSize[06] = "Statement, 5 1/2 x 8 1/2 in"
        loc_aPaperSize[07] = "Executive, 7 1/4 x 10 1/2 in"
        loc_aPaperSize[08] = "A3, 297 x 420 mm"
        loc_aPaperSize[09] = "A4, 210 x 297 mm"
        loc_aPaperSize[10] = "A4, Small 210 x 297 mm"
        loc_aPaperSize[11] = "A5, 148 x 210 mm"
        loc_aPaperSize[12] = "B4, 250 x 354 mm"
        loc_aPaperSize[13] = "B5, 182 x 257 mm"
        loc_aPaperSize[14] = "Folio, 8 1/2 x 13 in"
        loc_aPaperSize[15] = "Quarto, 215 x 275 mm"
        loc_aPaperSize[16] = "10 x 14 in"
        loc_aPaperSize[17] = "11 x 17 in"
        loc_aPaperSize[18] = "Note, 8 1/2 x 11 in"
        loc_aPaperSize[19] = "Envelope #9, 3 7/8 x 8 7/8 in"
        loc_aPaperSize[20] = "Envelope #10, 4 1/8 x 9 1/2 in"
        loc_aPaperSize[21] = "Envelope #11, 4 1/2 x 10 3/8 in"
        loc_aPaperSize[22] = "Envelope #12, 4 1/2 x 11 in"
        loc_aPaperSize[23] = "Envelope #14, 5 x 11 1/2 in"
        loc_aPaperSize[24] = "C size sheet"
        loc_aPaperSize[25] = "D size sheet"
        loc_aPaperSize[26] = "E size sheet"
        loc_aPaperSize[27] = "Envelope DL, 110 x 220 mm"
        loc_aPaperSize[28] = "Envelope C5, 162 x 229 mm"
        loc_aPaperSize[29] = "Envelope C3, 324 x 458 mm"
        loc_aPaperSize[30] = "Envelope C4, 229 x 324 mm"
        loc_aPaperSize[31] = "Envelope C6, 114 x 162 mm"
        loc_aPaperSize[32] = "Envelope C65, 114 x 229 mm"
        loc_aPaperSize[33] = "Envelope B4, 250 x 353 mm"
        loc_aPaperSize[34] = "Envelope B5, 176 x 250 mm"
        loc_aPaperSize[35] = "Envelope B6, 176 x 125 mm"
        loc_aPaperSize[36] = "Envelope, 110 x 230 mm"
        loc_aPaperSize[37] = "Envelope Monarch, 3 7/8 x 7.5 in"
        loc_aPaperSize[38] = "6 3/4 Envelope, 3 5/8 x 6 1/2 in"
        loc_aPaperSize[39] = "US Std Fanfold, 14 7/8 x 11 in"
        loc_aPaperSize[40] = "German Std Fanfold, 8 1/2 x 12 in"
        loc_aPaperSize[41] = "German Legal Fanfold, 8 1/2 x 13 in"

        FOR loc_i = 1 TO 41
            loc_oSubPg2.cbo_4c_TamPapel.AddListItem(loc_aPaperSize[loc_i], loc_i, 1)
            loc_oSubPg2.cbo_4c_TamPapel.AddListItem(ALLTRIM(STR(loc_i)), loc_i, 2)
        ENDFOR
        loc_oSubPg2.cbo_4c_TamPapel.ListIndex = 9

        *-- Imagem orientacao (Img_Orientacao: Top=6+29=35)
        loc_oSubPg2.AddObject("img_4c_Orientacao", "Image")
        WITH loc_oSubPg2.img_4c_Orientacao
            .Top     = 35
            .Left    = 603
            .Width   = 130
            .Height  = 116
            .Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Retrato_26.JPG"
            .Visible = .T.
        ENDWITH

        *-- OptionGroup orientacao (OptGrp_Orientacao: Top=126+29=155)
        *-- ControlSource liga Value (1=Retrato, 2=Paisagem) a cursor_4c_PropsTitulo.Orientation
        loc_oSubPg2.AddObject("opt_4c_Orientacao", "OptionGroup")
        WITH loc_oSubPg2.opt_4c_Orientacao
            .Top           = 155
            .Left          = 580
            .Width         = 180
            .Height        = 28
            .ButtonCount   = 2
            .Value         = 1
            .ControlSource = "cursor_4c_PropsTitulo.Orientation"
            .BackStyle     = 0
            .BorderStyle   = 0
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption = "Retrato"
                .Left    = 0
                .Width   = 85
                .Visible = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption = "Paisagem"
                .Left    = 90
                .Width   = 85
                .Visible = .T.
            ENDWITH
        ENDWITH

        *-- Label "Titulo do Relatorio:" (Label1: Top=162+29=191)
        loc_oSubPg2.AddObject("lbl_4c_TituloRelLayout", "Label")
        WITH loc_oSubPg2.lbl_4c_TituloRelLayout
            .Caption   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio: "
            .Top       = 191
            .Left      = 10
            .Width     = 110
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Totalizar pelo Campo:"
        loc_oSubPg2.AddObject("lbl_4c_CmpGrupo", "Label")
        WITH loc_oSubPg2.lbl_4c_CmpGrupo
            .Caption   = "Totalizar pelo Campo: ( Use o clique direito, para apagar )"
            .Top       = 539
            .Left      = 10
            .Width     = 560
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid: Propriedades do Titulo do Relatorio (grd_4c_PropsTitulo)
        loc_oSubPg2.AddObject("grd_4c_PropsTitulo", "Grid")
        loc_oSubPg2.grd_4c_PropsTitulo.RecordSourceType  = 1
        loc_oSubPg2.grd_4c_PropsTitulo.ColumnCount = 3
        loc_oSubPg2.grd_4c_PropsTitulo.RecordSource      = "cursor_4c_PropsTitulo"
        loc_oSubPg2.grd_4c_PropsTitulo.ColumnCount       = 5
        WITH loc_oSubPg2.grd_4c_PropsTitulo
            .Top          = 209
            .Left         = 4
            .Width        = 990
            .Height       = 65
            .GridLines    = 1
            .HeaderHeight = 18
            .RowHeight    = 20
            .ReadOnly     = .F.
            .Visible      = .T.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ScrollBars   = 2

            WITH .Column1
                .Header1.Caption = "Titulo"
                .ControlSource   = "cursor_4c_PropsTitulo.LblCaption"
                .Width           = 120
                .Sparse          = .F.
                .AddObject("Edit1", "EditBox")
                .CurrentControl  = "Edit1"
                WITH .Edit1
                    .Visible = .T.
                    .Width   = 118
                    .Height  = 40
                ENDWITH
            ENDWITH

            WITH .Column2
                .Header1.Caption = "Fonte"
                .ControlSource   = "cursor_4c_PropsTitulo.LblFonte"
                .Width           = 300
                .Sparse          = .F.
                .AddObject("Edit1", "EditBox")
                .CurrentControl  = "Edit1"
                WITH .Edit1
                    .Visible = .T.
                    .Width   = 298
                    .Height  = 40
                ENDWITH
            ENDWITH

            WITH .Column3
                .Header1.Caption = "Fte"
                .ControlSource   = "cursor_4c_PropsTitulo.LblBtFonte"
                .Width           = 60
                .Sparse          = .F.
                .AddObject("Command1", "CommandButton")
                .CurrentControl  = "Command1"
                WITH .Command1
                    .Caption = "..."
                    .Visible = .T.
                    .Width   = 55
                    .Height  = 18
                ENDWITH
            ENDWITH

            WITH .Column4
                .Header1.Caption = "Cor"
                .ControlSource   = "cursor_4c_PropsTitulo.LblBtCor"
                .Width           = 60
                .Sparse          = .F.
                .AddObject("Command1", "CommandButton")
                .CurrentControl  = "Command1"
                WITH .Command1
                    .Caption = "..."
                    .Visible = .T.
                    .Width   = 55
                    .Height  = 18
                ENDWITH
            ENDWITH

            WITH .Column5
                .Header1.Caption = "Alinhar"
                .ControlSource   = "cursor_4c_PropsTitulo.LblAlinhar"
                .Width           = 450
                .Sparse          = .F.
                .AddObject("Combo1", "ComboBox")
                .CurrentControl  = "Combo1"
                WITH .Combo1
                    .RowSourceType = 1
                    .RowSource     = "Left,Center,Right"
                    .Style         = 2
                    .Visible       = .T.
                    .Width         = 445
                    .Height        = 21
                ENDWITH
            ENDWITH
        ENDWITH

        *-- Grid: Propriedades dos Campos (grd_4c_PropsCampos)
        loc_oSubPg2.AddObject("grd_4c_PropsCampos", "Grid")
        loc_oSubPg2.grd_4c_PropsCampos.RecordSourceType  = 1
        loc_oSubPg2.grd_4c_PropsCampos.ColumnCount = 3
        loc_oSubPg2.grd_4c_PropsCampos.RecordSource      = "cursor_4c_PropsCampos"
        loc_oSubPg2.grd_4c_PropsCampos.ColumnCount       = 12
        WITH loc_oSubPg2.grd_4c_PropsCampos
            .Top          = 287
            .Left         = 4
            .Width        = 990
            .Height       = 238
            .GridLines    = 1
            .HeaderHeight = 18
            .RowHeight    = 20
            .ReadOnly     = .F.
            .Visible      = .T.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ScrollBars   = 3

            WITH .Column1
                .Header1.Caption = "Campo"
                .ControlSource   = "cursor_4c_PropsCampos.NmCampo"
                .Width           = 100
                .ReadOnly        = .T.
                .Sparse          = .F.
                WITH .Text1
                    .ReadOnly = .T.
                    .Visible  = .T.
                    .Width    = 98
                ENDWITH
            ENDWITH

            WITH .Column2
                .Header1.Caption = "Tipo"
                .ControlSource   = "cursor_4c_PropsCampos.TpCampo"
                .Width           = 75
                .ReadOnly        = .T.
                .Sparse          = .F.
                WITH .Text1
                    .ReadOnly = .T.
                    .Visible  = .T.
                    .Width    = 73
                ENDWITH
            ENDWITH

            WITH .Column3
                .Header1.Caption = "Sa" + CHR(237) + "da Rel."
                .ControlSource   = "cursor_4c_PropsCampos.CkOutRPT"
                .Width           = 65
                .Sparse          = .F.
                .AddObject("Check1", "CheckBox")
                .CurrentControl  = "Check1"
                WITH .Check1
                    .Caption = ""
                    .Visible = .T.
                    .Width   = 60
                    .Height  = 17
                ENDWITH
            ENDWITH

            WITH .Column4
                .Header1.Caption = "Filtro"
                .ControlSource   = "cursor_4c_PropsCampos.CkFiltro"
                .Width           = 55
                .Sparse          = .F.
                .AddObject("Check1", "CheckBox")
                .CurrentControl  = "Check1"
                WITH .Check1
                    .Caption = ""
                    .Visible = .T.
                    .Width   = 50
                    .Height  = 17
                ENDWITH
            ENDWITH

            WITH .Column5
                .Header1.Caption = "SubTot"
                .ControlSource   = "cursor_4c_PropsCampos.CkSubTot"
                .Width           = 60
                .Sparse          = .F.
                .AddObject("Check1", "CheckBox")
                .CurrentControl  = "Check1"
                WITH .Check1
                    .Caption = ""
                    .Visible = .T.
                    .Width   = 55
                    .Height  = 17
                ENDWITH
            ENDWITH

            WITH .Column6
                .Header1.Caption = "Total"
                .ControlSource   = "cursor_4c_PropsCampos.CkTotal"
                .Width           = 55
                .Sparse          = .F.
                .AddObject("Check1", "CheckBox")
                .CurrentControl  = "Check1"
                WITH .Check1
                    .Caption = ""
                    .Visible = .T.
                    .Width   = 50
                    .Height  = 17
                ENDWITH
            ENDWITH

            WITH .Column7
                .Header1.Caption = "Titulo do Campo"
                .ControlSource   = "cursor_4c_PropsCampos.LblCaption"
                .Width           = 140
                .Sparse          = .F.
                .AddObject("Edit1", "EditBox")
                .CurrentControl  = "Edit1"
                WITH .Edit1
                    .Visible = .T.
                    .Width   = 138
                    .Height  = 40
                ENDWITH
            ENDWITH

            WITH .Column8
                .Header1.Caption = "Fonte"
                .ControlSource   = "cursor_4c_PropsCampos.LblFonte"
                .Width           = 190
                .Sparse          = .F.
                .AddObject("Edit1", "EditBox")
                .CurrentControl  = "Edit1"
                WITH .Edit1
                    .Visible = .T.
                    .Width   = 188
                    .Height  = 40
                ENDWITH
            ENDWITH

            WITH .Column9
                .Header1.Caption = "Fte"
                .ControlSource   = "cursor_4c_PropsCampos.LblBtFonte"
                .Width           = 50
                .Sparse          = .F.
                .AddObject("Command1", "CommandButton")
                .CurrentControl  = "Command1"
                WITH .Command1
                    .Caption = "..."
                    .Visible = .T.
                    .Width   = 46
                    .Height  = 18
                ENDWITH
            ENDWITH

            WITH .Column10
                .Header1.Caption = "Cor"
                .ControlSource   = "cursor_4c_PropsCampos.LblBtCor"
                .Width           = 50
                .Sparse          = .F.
                .AddObject("Command1", "CommandButton")
                .CurrentControl  = "Command1"
                WITH .Command1
                    .Caption = "..."
                    .Visible = .T.
                    .Width   = 46
                    .Height  = 18
                ENDWITH
            ENDWITH

            WITH .Column11
                .Header1.Caption = "Alinhar"
                .ControlSource   = "cursor_4c_PropsCampos.LblAlinhar"
                .Width           = 80
                .Sparse          = .F.
                .AddObject("Combo1", "ComboBox")
                .CurrentControl  = "Combo1"
                WITH .Combo1
                    .RowSourceType = 1
                    .RowSource     = "Left,Center,Right"
                    .Style         = 2
                    .Visible       = .T.
                    .Width         = 77
                    .Height        = 21
                ENDWITH
            ENDWITH

            WITH .Column12
                .Header1.Caption = "Tam."
                .ControlSource   = "cursor_4c_PropsCampos.LblTamCmp"
                .Width           = 70
                .Sparse          = .F.
                .AddObject("Spinner1", "Spinner")
                .CurrentControl  = "Spinner1"
                WITH .Spinner1
                    .SpinnerLowValue  = 0
                    .SpinnerHighValue = 9999
                    .Increment        = 1
                    .Visible          = .T.
                    .Width            = 66
                    .Height           = 21
                ENDWITH
            ENDWITH
        ENDWITH

        *-- DynamicBackColor: cinza escuro para SubTot/Total em campos nao-numericos
        loc_oSubPg2.grd_4c_PropsCampos.Column5.DynamicBackColor = ;
            "IIF(InList(cursor_4c_PropsCampos.LblTipoCmp,'N','U'),RGB(239,239,239),RGB(209,209,209))"
        loc_oSubPg2.grd_4c_PropsCampos.Column6.DynamicBackColor = ;
            "IIF(InList(cursor_4c_PropsCampos.LblTipoCmp,'N','U'),RGB(239,239,239),RGB(209,209,209))"

        *-- Grid: Propriedades do Grupo (grd_4c_PropsGrp)
        loc_oSubPg2.AddObject("grd_4c_PropsGrp", "Grid")
        loc_oSubPg2.grd_4c_PropsGrp.RecordSourceType  = 1
        loc_oSubPg2.grd_4c_PropsGrp.ColumnCount = 3
        loc_oSubPg2.grd_4c_PropsGrp.RecordSource      = "cursor_4c_PropsGrp"
        loc_oSubPg2.grd_4c_PropsGrp.ColumnCount       = 7
        WITH loc_oSubPg2.grd_4c_PropsGrp
            .Top          = 558
            .Left         = 4
            .Width        = 989
            .Height       = 67
            .GridLines    = 1
            .HeaderHeight = 18
            .RowHeight    = 20
            .ReadOnly     = .F.
            .Visible      = .T.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ScrollBars   = 2

            WITH .Column1
                .Header1.Caption = "Grupo"
                .ControlSource   = "cursor_4c_PropsGrp.NmCampo"
                .Width           = 180
                .Sparse          = .F.
                .AddObject("Combo1", "ComboBox")
                .CurrentControl  = "Combo1"
                WITH .Combo1
                    .RowSourceType = 2
                    .RowSource     = "cursor_4c_LstCampos.NmCampo"
                    .BoundColumn   = 1
                    .Style         = 0
                    .Visible       = .T.
                    .Width         = 177
                    .Height        = 21
                ENDWITH
            ENDWITH

            WITH .Column2
                .Header1.Caption = "Titulo do Campo"
                .ControlSource   = "cursor_4c_PropsGrp.LblCaption"
                .Width           = 180
                .Sparse          = .F.
                .AddObject("Edit1", "EditBox")
                .CurrentControl  = "Edit1"
                WITH .Edit1
                    .Visible = .T.
                    .Width   = 178
                    .Height  = 40
                ENDWITH
            ENDWITH

            WITH .Column3
                .Header1.Caption = "Fonte"
                .ControlSource   = "cursor_4c_PropsGrp.LblFonte"
                .Width           = 200
                .Sparse          = .F.
                .AddObject("Edit1", "EditBox")
                .CurrentControl  = "Edit1"
                WITH .Edit1
                    .Visible = .T.
                    .Width   = 198
                    .Height  = 40
                ENDWITH
            ENDWITH

            WITH .Column4
                .Header1.Caption = "Fte"
                .ControlSource   = "cursor_4c_PropsGrp.LblBtFonte"
                .Width           = 80
                .Sparse          = .F.
                .AddObject("Command1", "CommandButton")
                .CurrentControl  = "Command1"
                WITH .Command1
                    .Caption = "..."
                    .Visible = .T.
                    .Width   = 76
                    .Height  = 18
                ENDWITH
            ENDWITH

            WITH .Column5
                .Header1.Caption = "Cor"
                .ControlSource   = "cursor_4c_PropsGrp.LblBtCor"
                .Width           = 80
                .Sparse          = .F.
                .AddObject("Command1", "CommandButton")
                .CurrentControl  = "Command1"
                WITH .Command1
                    .Caption = "..."
                    .Visible = .T.
                    .Width   = 76
                    .Height  = 18
                ENDWITH
            ENDWITH

            WITH .Column6
                .Header1.Caption = "Alinhar"
                .ControlSource   = "cursor_4c_PropsGrp.LblAlinhar"
                .Width           = 100
                .Sparse          = .F.
                .AddObject("Combo1", "ComboBox")
                .CurrentControl  = "Combo1"
                WITH .Combo1
                    .RowSourceType = 1
                    .RowSource     = "Left,Center,Right"
                    .Style         = 2
                    .Visible       = .T.
                    .Width         = 97
                    .Height        = 21
                ENDWITH
            ENDWITH

            WITH .Column7
                .Header1.Caption = "Tam."
                .ControlSource   = "cursor_4c_PropsGrp.LblTamCmp"
                .Width           = 169
                .Sparse          = .F.
                .AddObject("Spinner1", "Spinner")
                .CurrentControl  = "Spinner1"
                WITH .Spinner1
                    .SpinnerLowValue  = 0
                    .SpinnerHighValue = 9999
                    .Increment        = 1
                    .Visible          = .T.
                    .Width            = 165
                    .Height           = 21
                ENDWITH
            ENDWITH
        ENDWITH

        *-- BINDEVENTs (handlers devem ser PUBLIC)
        LOCAL loc_oGrdTIT, loc_oGrdCMPs, loc_oGrdGRP
        loc_oGrdTIT  = loc_oSubPg2.grd_4c_PropsTitulo
        loc_oGrdCMPs = loc_oSubPg2.grd_4c_PropsCampos
        loc_oGrdGRP  = loc_oSubPg2.grd_4c_PropsGrp

        BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_VoltarLayout, "Click", THIS, "BtnVoltarLayoutClick")
        BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_GerarLayout,  "Click", THIS, "BtnGerarLayoutClick")
        BINDEVENT(loc_oSubPg2.opt_4c_Orientacao, "InteractiveChange",   THIS, "OrientacaoChanged")
        BINDEVENT(loc_oGrdTIT.Column3.Command1,   "Click",              THIS, "BtnFonteTITClick")
        BINDEVENT(loc_oGrdTIT.Column4.Command1,   "Click",              THIS, "BtnCorTITClick")
        BINDEVENT(loc_oGrdCMPs.Column5.Check1,    "When",               THIS, "ChkSubTotalWhen")
        BINDEVENT(loc_oGrdCMPs.Column6.Check1,    "When",               THIS, "ChkTotalFinalWhen")
        BINDEVENT(loc_oGrdCMPs.Column7.Edit1,     "KeyPress",          THIS, "EdtCaptionCMPsLostFocus")
        BINDEVENT(loc_oGrdCMPs.Column9.Command1,  "Click",              THIS, "BtnFonteCMPsClick")
        BINDEVENT(loc_oGrdCMPs.Column10.Command1, "Click",              THIS, "BtnCorCMPsClick")
        BINDEVENT(loc_oGrdGRP.Column1.Combo1,     "InteractiveChange",  THIS, "ComboNmCampoGRPInteractiveChange")
        BINDEVENT(loc_oGrdGRP.Column4.Command1,   "Click",              THIS, "BtnFonteGRPClick")
        BINDEVENT(loc_oGrdGRP.Column5.Command1,   "Click",              THIS, "BtnCorGRPClick")
    ENDPROC

    *==========================================================================
    * BtnVoltarLayoutClick - Volta para Sub-Page1 (Editor SQL)
    *==========================================================================
    PROCEDURE BtnVoltarLayoutClick()
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
    ENDPROC

    *==========================================================================
    * OrientacaoChanged - Atualiza imagem ao mudar orientacao Portrait/Paisagem
    *==========================================================================
    PROCEDURE OrientacaoChanged()
        LOCAL loc_oPg2, loc_nOrientacao
        loc_oPg2        = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_nOrientacao = loc_oPg2.opt_4c_Orientacao.Value
        IF loc_nOrientacao = 1
            loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Retrato_26.JPG"
        ELSE
            loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Paisagem_26.JPG"
        ENDIF
        IF USED("cursor_4c_PropsTitulo")
            SELECT cursor_4c_PropsTitulo
            REPLACE Orientation WITH loc_nOrientacao
        ENDIF
        THIS.this_nOrientacao = loc_nOrientacao
    ENDPROC

    *==========================================================================
    * BtnFonteTITClick - Seleciona fonte para o Titulo do Relatorio
    *==========================================================================
    PROCEDURE BtnFonteTITClick()
        LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
        LOCAL loc_cFonteNova
        IF !USED("cursor_4c_PropsTitulo")
            RETURN
        ENDIF
        SELECT cursor_4c_PropsTitulo
        loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsTitulo.LblFonte, "Tahoma,8,N"))
        THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
        loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
        IF !EMPTY(loc_cFonteNova)
            REPLACE LblFonte WITH loc_cFonteNova
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCorTITClick - Seleciona cor do texto para o Titulo do Relatorio
    *==========================================================================
    PROCEDURE BtnCorTITClick()
        LOCAL loc_nCor
        IF !USED("cursor_4c_PropsTitulo")
            RETURN
        ENDIF
        loc_nCor = GETCOLOR()
        IF loc_nCor >= 0
            SELECT cursor_4c_PropsTitulo
            REPLACE LblBtCor WITH loc_nCor
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkSubTotalWhen - Valida se o campo suporta subtotal (somente numericos)
    *==========================================================================
    PROCEDURE ChkSubTotalWhen()
        LOCAL loc_lPermite
        loc_lPermite = .F.
        IF USED("cursor_4c_PropsCampos") AND !EOF("cursor_4c_PropsCampos")
            loc_lPermite = (cursor_4c_PropsCampos.LblTipoCmp $ "NU")
        ENDIF
        RETURN loc_lPermite
    ENDPROC

    *==========================================================================
    * ChkTotalFinalWhen - Valida se o campo suporta total final (somente numericos)
    *==========================================================================
    PROCEDURE ChkTotalFinalWhen()
        LOCAL loc_lPermite
        loc_lPermite = .F.
        IF USED("cursor_4c_PropsCampos") AND !EOF("cursor_4c_PropsCampos")
            loc_lPermite = (cursor_4c_PropsCampos.LblTipoCmp $ "NU")
        ENDIF
        RETURN loc_lPermite
    ENDPROC

    *==========================================================================
    * EdtCaptionCMPsLostFocus - Recalcula LblTam ao editar titulo de campo
    *==========================================================================
    PROCEDURE EdtCaptionCMPsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cTpCampo, loc_cFonte, loc_nTam
        IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
            RETURN
        ENDIF
        loc_cTpCampo = ALLTRIM(NVL(cursor_4c_PropsCampos.TpCampo, ""))
        loc_cFonte   = ALLTRIM(NVL(cursor_4c_PropsCampos.LblFonte, "Tahoma,8,N"))
        IF EMPTY(loc_cTpCampo)
            RETURN
        ENDIF
        loc_nTam = THIS.Calc_TamCampo(loc_cTpCampo, loc_cFonte)
        IF loc_nTam > 0
            SELECT cursor_4c_PropsCampos
            REPLACE LblTamCmp WITH loc_nTam
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnFonteCMPsClick - Seleciona fonte para coluna de Campos
    *==========================================================================
    PROCEDURE BtnFonteCMPsClick()
        LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
        LOCAL loc_cFonteNova
        IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
            RETURN
        ENDIF
        SELECT cursor_4c_PropsCampos
        loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsCampos.LblFonte, "Tahoma,8,N"))
        THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
        loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
        IF !EMPTY(loc_cFonteNova)
            REPLACE LblFonte WITH loc_cFonteNova
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCorCMPsClick - Seleciona cor do texto para coluna de Campos
    *==========================================================================
    PROCEDURE BtnCorCMPsClick()
        LOCAL loc_nCor
        IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
            RETURN
        ENDIF
        loc_nCor = GETCOLOR()
        IF loc_nCor >= 0
            SELECT cursor_4c_PropsCampos
            REPLACE LblBtCor WITH loc_nCor
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ComboNmCampoGRPInteractiveChange - Atualiza LblTam ao selecionar campo do grupo
    *==========================================================================
    PROCEDURE ComboNmCampoGRPInteractiveChange()
        LOCAL loc_cNmCampo, loc_cTpCampo, loc_cFonte, loc_nTam
        IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
            RETURN
        ENDIF
        loc_cNmCampo = ALLTRIM(NVL(cursor_4c_PropsGrp.NmCampo, ""))
        IF EMPTY(loc_cNmCampo) OR !USED("cursor_4c_LstCampos")
            RETURN
        ENDIF
        SELECT cursor_4c_LstCampos
        LOCATE FOR cursor_4c_LstCampos.NmCampo = loc_cNmCampo
        IF FOUND("cursor_4c_LstCampos")
            loc_cTpCampo = ALLTRIM(NVL(cursor_4c_LstCampos.TpCampo, ""))
            SELECT cursor_4c_PropsGrp
            loc_cFonte = ALLTRIM(NVL(cursor_4c_PropsGrp.LblFonte, "Tahoma,8,N"))
            loc_nTam   = THIS.Calc_TamCampo(loc_cTpCampo, loc_cFonte)
            IF loc_nTam > 0
                REPLACE LblTamCmp WITH loc_nTam
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
            ENDIF
        ENDIF
        SELECT cursor_4c_PropsGrp
    ENDPROC

    *==========================================================================
    * BtnFonteGRPClick - Seleciona fonte para coluna do Grupo
    *==========================================================================
    PROCEDURE BtnFonteGRPClick()
        LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
        LOCAL loc_cFonteNova
        IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
            RETURN
        ENDIF
        SELECT cursor_4c_PropsGrp
        loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsGrp.LblFonte, "Tahoma,8,N"))
        THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
        loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
        IF !EMPTY(loc_cFonteNova)
            REPLACE LblFonte WITH loc_cFonteNova
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCorGRPClick - Seleciona cor do texto para coluna do Grupo
    *==========================================================================
    PROCEDURE BtnCorGRPClick()
        LOCAL loc_nCor
        IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
            RETURN
        ENDIF
        loc_nCor = GETCOLOR()
        IF loc_nCor >= 0
            SELECT cursor_4c_PropsGrp
            REPLACE LblBtCor WITH loc_nCor
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * Calc_TamCampo - Calcula largura em pixels baseado no tipo e fonte do campo
    * par_cTpCampo: ex "varchar(50)", par_cFonte: "FontName,Size,Style"
    *==========================================================================
    PROCEDURE Calc_TamCampo(par_cTpCampo, par_cFonte)
        LOCAL loc_lcTipo, loc_cTpWrk, loc_nFieldWidth, loc_nTam
        LOCAL loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
        LOCAL loc_nFontWidth

        loc_lcTipo      = UPPER(LEFT(ALLTRIM(par_cTpCampo), 1))
        loc_cTpWrk      = STRTRAN(STRTRAN(STRTRAN(par_cTpCampo, loc_lcTipo, ""), "(", ""), ")", "")
        loc_nFieldWidth = INT(VAL(ALLTRIM(loc_cTpWrk)))

        IF loc_nFieldWidth <= 0
            RETURN 0
        ENDIF

        THIS.DetalharFonte(par_cFonte, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)

        loc_nFontWidth = FONTMETRIC(6, loc_cFontName, loc_nFontSize, loc_cFontStyle)
        IF loc_nFontWidth <= 0
            loc_nFontWidth = 6
        ENDIF

        RETURN INT(loc_nFieldWidth * loc_nFontWidth)
    ENDPROC

    *==========================================================================
    * DetalharFonte - Decompoe string "FontName,Size,Style" em partes
    * Parametros por referencia: par_cFontName, par_nFontSize, par_cFontStyle, par_nFontStyle
    *==========================================================================
    PROCEDURE DetalharFonte(par_cFonte, par_cFontName, par_nFontSize, par_cFontStyle, par_nFontStyle)
        par_nFontStyle = 0
        par_cFontName  = LEFT(par_cFonte, AT(",", par_cFonte, 1) - 1)
        par_cFonte     = ALLTRIM(STRTRAN(par_cFonte, par_cFontName + ",", ""))
        par_nFontSize  = LEFT(par_cFonte, AT(",", par_cFonte, 1) - 1)
        par_cFonte     = ALLTRIM(STRTRAN(par_cFonte, par_nFontSize + ",", ""))
        par_cFontStyle = par_cFonte
        par_nFontSize  = VAL(par_nFontSize)
        DO CASE
        CASE par_cFontStyle = "N"
            par_nFontStyle = 0
        CASE par_cFontStyle = "B"
            par_nFontStyle = 1
        CASE par_cFontStyle = "I"
            par_nFontStyle = 2
        CASE par_cFontStyle = "BI"
            par_nFontStyle = 3
        CASE par_cFontStyle = "U"
            par_nFontStyle = 4
        CASE par_cFontStyle = "BU"
            par_nFontStyle = 5
        CASE par_cFontStyle = "S"
            par_nFontStyle = 128
        ENDCASE
    ENDPROC

    *==========================================================================
    * RetornarFontStyle - Converte codigo numerico para string de estilo de fonte
    *==========================================================================
    PROTECTED PROCEDURE RetornarFontStyle(par_nFontStyle)
        DO CASE
        CASE par_nFontStyle = 1
            RETURN "B"
        CASE par_nFontStyle = 2
            RETURN "I"
        CASE par_nFontStyle = 3
            RETURN "BI"
        CASE par_nFontStyle = 4
            RETURN "U"
        CASE par_nFontStyle = 5
            RETURN "BU"
        CASE par_nFontStyle = 128
            RETURN "S"
        OTHERWISE
            RETURN "N"
        ENDCASE
    ENDFUNC

    *==========================================================================
    * BtnGerarLayoutClick - Gera arquivo FRX usando SFReportFile
    * Monta Page Header, Detail, Summary, Group e Page Footer a partir dos cursores
    *==========================================================================
    PROCEDURE BtnGerarLayoutClick()
        LOCAL loc_lSucesso, loc_cArqFRX
        LOCAL loc_loReport, loc_loPageHeader, loc_loDetail, loc_loSummary
        LOCAL loc_loGroup, loc_loGroupFooter, loc_loPageFooter, loc_loObject, loc_loVariable
        LOCAL loc_lcFontName, loc_lnFontSize, loc_lcFontStyle, loc_lnFontStyle
        LOCAL loc_lnSummaryBand, loc_lnFACTOR, loc_lnWidthMAX
        LOCAL loc_lnWidth, loc_lnHPos, loc_lnVPos, loc_lnFieldWidth, loc_lnFactorWidth
        LOCAL loc_lcField, loc_lcPicture
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cNmReport))
                MsgAviso("Salve o report antes de gerar o layout.")
                RETURN
            ENDIF
            IF !USED("cursor_4c_PropsTitulo") OR !USED("cursor_4c_PropsCampos")
                MsgAviso("Cursores de layout n" + CHR(227) + "o inicializados.")
                RETURN
            ENDIF

            *-- Caminho do FRX temporario
            IF !DIRECTORY(THIS.this_oBusinessObject.this_cDirTmp)
                MD (THIS.this_oBusinessObject.this_cDirTmp)
            ENDIF
            loc_cArqFRX = FULLPATH(THIS.this_oBusinessObject.this_cDirTmp + ;
                UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)) + ".FRX")
            THIS.this_oBusinessObject.this_cArqReport = loc_cArqFRX

            *-- Contar campos com total (necessita Summary band)
            SELECT cursor_4c_PropsCampos
            loc_lnSummaryBand = 0
            SCAN
                IF cursor_4c_PropsCampos.CkTotal = 1
                    loc_lnSummaryBand = loc_lnSummaryBand + 1
                ENDIF
            ENDSCAN

            *-- Instanciar SFReportFile
            SET CLASSLIB TO (gc_4c_CaminhoFramework + "ReportOBJ\SFRepObj.vcx") ADDITIVE
            loc_loReport = CREATEOBJECT("SFReportFile")
            loc_loReport.cReportFile = loc_cArqFRX
            SELECT cursor_4c_PropsTitulo
            loc_loReport.Orientation = cursor_4c_PropsTitulo.Orientation - 1
            loc_loReport.PaperSize   = cursor_4c_PropsTitulo.PaperSize
            loc_loReport.cCOMMENT    = "ORIENTATION"

            loc_loPageHeader          = loc_loReport.GetReportBand("Page Header")
            loc_loPageHeader.cCOMMENT = "PAGE_HEADER"

            loc_loDetail          = loc_loReport.GetReportBand("Detail")
            loc_loDetail.nHeight  = 1
            loc_loDetail.cCOMMENT = "DETAIL"

            IF loc_lnSummaryBand > 0
                loc_loReport.lSummaryBand = .T.
                loc_loSummary             = loc_loReport.GetReportBand("Summary")
                loc_loSummary.nHeight     = 3
                loc_loSummary.cCOMMENT    = "SUMMARY"
            ENDIF

            *-- Banda de grupo (se NmCampo preenchido)
            SELECT cursor_4c_PropsGrp
            IF !ISNULL(cursor_4c_PropsGrp.NmCampo) AND !EMPTY(ALLTRIM(cursor_4c_PropsGrp.NmCampo))
                loc_loReport.CreateGroupBand()
                loc_loGroup                      = loc_loReport.GetReportBand("Group Header", 1)
                loc_loGroup.cExpression          = ALLTRIM(cursor_4c_PropsGrp.NmCampo)
                loc_loGroup.nHeight              = 3
                loc_loGroup.lPrintOnEachPage     = .T.
                loc_loGroup.nNewPageWhenLessThan = 4
                loc_loGroup.cCOMMENT             = "GROUP_HEADER"

                loc_lcFontName  = ""
                loc_lnFontSize  = 0
                loc_lcFontStyle = ""
                loc_lnFontStyle = 0
                THIS.DetalharFonte(ALLTRIM(cursor_4c_PropsGrp.LblFonte), @loc_lcFontName, @loc_lnFontSize, @loc_lcFontStyle, @loc_lnFontStyle)

                loc_loObject             = loc_loGroup.AddItem("Field")
                loc_loObject.nVPosition  = 1
                loc_loObject.cExpression = "[" + ALLTRIM(cursor_4c_PropsGrp.LblCaption) + "]"
                loc_loObject.cfontname   = loc_lcFontName
                loc_loObject.nFontSize   = loc_lnFontSize
                loc_loObject.cAlignment  = cursor_4c_PropsGrp.LblAlinhar
                loc_loObject.lFontBold   = ("B" $ loc_lcFontStyle)
                loc_loObject.lFontItalic = ("I" $ loc_lcFontStyle)
                loc_loObject.nForeColor  = cursor_4c_PropsGrp.LblBtCor
                loc_loObject.nWidth      = cursor_4c_PropsGrp.LblTamCmp
                loc_loObject.nHeight     = (FONTMETRIC(1, loc_lcFontName, loc_lnFontSize, loc_lcFontStyle) / 10) * 2
                loc_loObject.cCOMMENT    = "GROUP_HEADER_LABEL " + ALLTRIM(cursor_4c_PropsGrp.NmCampo) + CHR(13) + ;
                    "LblAlinhar " + ALLTRIM(cursor_4c_PropsGrp.LblAlinhar)          + CHR(13) + ;
                    "LblTamCmp "  + ALLTRIM(STR(cursor_4c_PropsGrp.LblTamCmp))      + CHR(13) + ;
                    "LblTipoCmp " + ALLTRIM(cursor_4c_PropsGrp.LblTipoCmp)          + CHR(13) + ;
                    "LblCaption " + ALLTRIM(cursor_4c_PropsGrp.LblCaption)

                loc_loObject             = loc_loGroup.AddItem("Field")
                loc_loObject.nVPosition  = 1
                loc_loObject.nHPosition  = cursor_4c_PropsGrp.LblTamCmp + 5
                loc_loObject.cExpression = cursor_4c_PropsGrp.NmCampo
                loc_loObject.cfontname   = loc_lcFontName
                loc_loObject.nFontSize   = loc_lnFontSize
                loc_loObject.cAlignment  = cursor_4c_PropsGrp.LblAlinhar
                loc_loObject.lFontBold   = ("B" $ loc_lcFontStyle)
                loc_loObject.lFontItalic = ("I" $ loc_lcFontStyle)
                loc_loObject.nForeColor  = cursor_4c_PropsGrp.LblBtCor
                loc_loObject.nWidth      = cursor_4c_PropsGrp.LblTamCmp
                loc_loObject.nHeight     = (FONTMETRIC(1, loc_lcFontName, loc_lnFontSize, loc_lcFontStyle) / 10)
                loc_loObject.cCOMMENT    = "GROUP_HEADER_FIELD " + ALLTRIM(cursor_4c_PropsGrp.NmCampo)

                loc_loGroupFooter          = loc_loReport.GetReportBand("Group Footer", 1)
                loc_loGroupFooter.nHeight  = 2
                loc_loGroupFooter.cCOMMENT = "GROUP_FOOTER " + ALLTRIM(cursor_4c_PropsGrp.NmCampo)
            ENDIF

            *-- lnFACTOR = 10000 unidades/inch / 96 px/inch
            loc_lnFACTOR   = 104.166
            loc_lnWidthMAX = IIF(loc_loReport.Orientation = 1, 116933, 82683)
            loc_lnVPos     = 0
            loc_lnWidth    = 0

            *-- Iterar campos marcados para saida (CkOutRPT=1)
            SELECT cursor_4c_PropsCampos
            GO TOP
            SCAN FOR cursor_4c_PropsCampos.CkOutRPT = 1
                loc_lcField      = ALLTRIM(cursor_4c_PropsCampos.NmCampo)
                loc_lcPicture    = IIF(cursor_4c_PropsCampos.LblTipoCmp $ "NFIBY", "9,999,999.99", "")
                loc_lnFieldWidth = cursor_4c_PropsCampos.LblTamCmp

                loc_lnFactorWidth = (loc_lnWidth + loc_lnFieldWidth) * loc_lnFACTOR
                IF loc_lnFactorWidth > loc_lnWidthMAX
                    loc_lnWidth = 0
                    loc_lnVPos  = loc_lnVPos + 1
                ENDIF
                loc_lnHPos = loc_lnWidth

                loc_lcFontName  = ""
                loc_lnFontSize  = 0
                loc_lcFontStyle = ""
                loc_lnFontStyle = 0
                THIS.DetalharFonte(ALLTRIM(cursor_4c_PropsCampos.LblFonte), @loc_lcFontName, @loc_lnFontSize, @loc_lcFontStyle, @loc_lnFontStyle)

                *-- Cabecalho da coluna no Page Header
                loc_loObject             = loc_loPageHeader.AddItem("Field")
                loc_loObject.cExpression = "[" + ALLTRIM(cursor_4c_PropsCampos.LblCaption) + "]"
                loc_loObject.cfontname   = loc_lcFontName
                loc_loObject.nFontSize   = loc_lnFontSize
                loc_loObject.cAlignment  = cursor_4c_PropsCampos.LblAlinhar
                loc_loObject.lFontBold   = ("B" $ loc_lcFontStyle)
                loc_loObject.lFontItalic = ("I" $ loc_lcFontStyle)
                loc_loObject.nForeColor  = cursor_4c_PropsCampos.LblBtCor
                loc_loObject.nWidth      = cursor_4c_PropsCampos.LblTamCmp
                loc_loObject.nHeight     = (FONTMETRIC(1, loc_lcFontName, loc_lnFontSize, loc_lcFontStyle) / 10)
                loc_loObject.nVPosition  = loc_lnVPos + 7
                loc_loObject.nHPosition  = loc_lnHPos
                loc_loObject.cCOMMENT    = "HEADING "    + cursor_4c_PropsCampos.NmCampo                       + CHR(13) + ;
                    "TpCampo "    + cursor_4c_PropsCampos.TpCampo                               + CHR(13) + ;
                    "CkOutRPT "   + ALLTRIM(STR(cursor_4c_PropsCampos.CkOutRPT))                + CHR(13) + ;
                    "CkFiltro "   + ALLTRIM(STR(cursor_4c_PropsCampos.CkFiltro))                + CHR(13) + ;
                    "CkSubTot "   + ALLTRIM(STR(cursor_4c_PropsCampos.CkSubTot))                + CHR(13) + ;
                    "CkTotal "    + ALLTRIM(STR(cursor_4c_PropsCampos.CkTotal))                 + CHR(13) + ;
                    "LblAlinhar " + ALLTRIM(cursor_4c_PropsCampos.LblAlinhar)                   + CHR(13) + ;
                    "LblTamCmp "  + ALLTRIM(STR(cursor_4c_PropsCampos.LblTamCmp))              + CHR(13) + ;
                    "LblTipoCmp " + ALLTRIM(cursor_4c_PropsCampos.LblTipoCmp)                  + CHR(13) + ;
                    "LblCaption " + ALLTRIM(cursor_4c_PropsCampos.LblCaption)

                *-- Campo no detalhe
                loc_loObject             = loc_loDetail.AddItem("Field")
                loc_loObject.cExpression = loc_lcField
                loc_loObject.cfontname   = loc_lcFontName
                loc_loObject.nFontSize   = loc_lnFontSize
                loc_loObject.cAlignment  = cursor_4c_PropsCampos.LblAlinhar
                loc_loObject.lFontBold   = ("B" $ loc_lcFontStyle)
                loc_loObject.lFontItalic = ("I" $ loc_lcFontStyle)
                loc_loObject.nForeColor  = cursor_4c_PropsCampos.LblBtCor
                loc_loObject.nHeight     = (FONTMETRIC(1, loc_lcFontName, loc_lnFontSize, loc_lcFontStyle) / 10)
                loc_loObject.nWidth      = loc_lnFieldWidth
                loc_loObject.nVPosition  = loc_lnVPos
                loc_loObject.nHPosition  = loc_lnHPos
                loc_loObject.cPicture    = loc_lcPicture
                loc_loObject.cCOMMENT    = "FIELD " + loc_loObject.cExpression

                IF cursor_4c_PropsCampos.CkSubTot = 1 AND TYPE("loc_loGroupFooter") = "O"
                    loc_loObject                = loc_loGroupFooter.AddItem("Field")
                    loc_loObject.cExpression    = loc_lcField
                    loc_loObject.nWidth         = loc_lnFieldWidth + 2
                    loc_loObject.nVPosition     = loc_lnVPos + 1
                    loc_loObject.nHPosition     = loc_lnHPos - 2
                    loc_loObject.cAlignment     = cursor_4c_PropsCampos.LblAlinhar
                    loc_loObject.nResetOnGroup  = 1
                    loc_loObject.cTotalType     = "Sum"
                    loc_loObject.lFontBold      = .T.
                    loc_loObject.cDataType      = "N"
                    loc_loObject.cCOMMENT       = "CAMPO_SUBTOTAL " + loc_loObject.cExpression
                ENDIF

                IF cursor_4c_PropsCampos.CkTotal = 1 AND loc_lnSummaryBand > 0
                    loc_loObject             = loc_loSummary.AddItem("Field")
                    loc_loObject.cExpression = loc_lcField
                    loc_loObject.nWidth      = loc_lnFieldWidth + 2
                    loc_loObject.nVPosition  = loc_lnVPos + 2
                    loc_loObject.nHPosition  = loc_lnHPos - 2
                    loc_loObject.cAlignment  = cursor_4c_PropsCampos.LblAlinhar
                    loc_loObject.cTotalType  = "Sum"
                    loc_loObject.cDataType   = "N"
                    loc_loObject.cCOMMENT    = "CAMPO_TOTAL " + loc_loObject.cExpression
                ENDIF

                loc_lnWidth = loc_lnHPos + loc_lnFieldWidth + 1
            ENDSCAN

            loc_lnWidth = loc_lnWidth - 1
            loc_lnWidth = IIF(loc_lnWidth < 0, 0, loc_lnWidth)
            IF loc_lnVPos > 0
                loc_lnWidth = INT(loc_lnWidthMAX / loc_lnFACTOR)
            ENDIF

            *-- Linha separadora no Page Header
            loc_loObject            = loc_loPageHeader.AddItem("Line")
            loc_loObject.nWidth     = loc_lnWidth
            loc_loObject.nVPosition = loc_lnVPos + 6
            loc_loObject.nHPosition = 0
            loc_loObject.cCOMMENT   = "LINE"

            *-- Summary: linha + rotulo + contagem
            IF loc_lnSummaryBand > 0
                loc_loObject            = loc_loSummary.AddItem("Line")
                loc_loObject.nWidth     = loc_lnWidth
                loc_loObject.nVPosition = 1
                loc_loObject.nHPosition = 0
                loc_loObject.cCOMMENT   = "SUMMARY_LINE"

                loc_loObject             = loc_loSummary.AddItem("Text")
                loc_loObject.cExpression = "Total:"
                loc_loObject.nVPosition  = 2
                loc_loObject.nHPosition  = 0
                loc_loObject.lFontBold   = .T.
                loc_loObject.cCOMMENT    = "SUMMARY_LABEL Total:"

                loc_loObject             = loc_loSummary.AddItem("Field")
                loc_loObject.cExpression = [Ltrim(Str(lnCount)) + " registro" + Iif(lnCount = 1, "", "s")]
                loc_loObject.nWidth      = 21
                loc_loObject.nVPosition  = 2
                loc_loObject.nHPosition  = 8
                loc_loObject.lFontBold   = .T.
                loc_loObject.cCOMMENT    = "SUMMARY_FIELD"
            ENDIF

            *-- Page Footer
            loc_loPageFooter          = loc_loReport.GetReportBand("Page Footer")
            loc_loPageFooter.nHeight  = 2

            loc_loObject            = loc_loPageFooter.AddItem("Line")
            loc_loObject.nWidth     = loc_lnWidth
            loc_loObject.nVPosition = 0

            loc_loObject             = loc_loPageFooter.AddItem("Field")
            loc_loObject.cExpression = "go_4c_Sistema.cEmpresa"
            loc_loObject.nWidth      = 50
            loc_loObject.nHPosition  = 0
            loc_loObject.nVPosition  = 0.5
            loc_loObject.lFontBold   = .T.
            loc_loObject.cCOMMENT    = "NOME SISTEMA"

            loc_loObject             = loc_loPageFooter.AddItem("Field")
            loc_loObject.cExpression = "this.Name"
            loc_loObject.nWidth      = 20
            loc_loObject.nVPosition  = 0.5
            loc_loObject.nHPosition  = loc_lnWidth - 20
            loc_loObject.cAlignment  = "Right"
            loc_loObject.lFontBold   = .T.
            loc_loObject.cCOMMENT    = "NOME REPORT"

            loc_loObject            = loc_loPageFooter.AddItem("Line")
            loc_loObject.nWidth     = loc_lnWidth
            loc_loObject.nVPosition = 1

            *-- Variavel de contagem de registros
            loc_loVariable               = loc_loReport.CreateVariable()
            loc_loVariable.cName         = "lnCount"
            loc_loVariable.cValue        = 1
            loc_loVariable.cInitialValue = 0
            loc_loVariable.cTotalType    = "Sum"
            loc_loVariable.cCOMMENT      = "VARIABLE"

            loc_loReport.Save()

            *-- Mesclar cabecalho/rodape padrao do template
            THIS.MesclarComTemplate(loc_cArqFRX, cursor_4c_PropsTitulo.Orientation)

            *-- Salvar FRX no SQL Server (SIGCDRLD)
            IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cRPT_ID))
                THIS.SalvarFRXParaSQL(THIS.this_oBusinessObject.this_cRPT_ID, loc_cArqFRX)
            ENDIF

            MsgInfo("Layout gerado com sucesso!")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar layout:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnGerarLayoutClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MesclarComTemplate - Incorpora cabecalho/rodape padrao do FRX template
    * Abre rpt_retrato.frx ou rpt_paisagem.frx, atualiza PAGE_HEADER_TITULO
    * e acrescenta os records ao FRX gerado
    *==========================================================================
    PROTECTED PROCEDURE MesclarComTemplate(par_cArqFRX, par_nOrientacao)
        LOCAL loc_lSucesso, loc_cTemplate, loc_cOldSafety
        LOCAL loc_lcFontName, loc_lnFontSize, loc_lcFontStyle, loc_lnFontStyle
        LOCAL loc_lnRed, loc_lnGreen, loc_lnBlue
        loc_lSucesso  = .F.
        loc_cOldSafety = SET("SAFETY")

        TRY
            SET SAFETY OFF

            IF par_nOrientacao = 1
                loc_cTemplate = gc_4c_CaminhoReports + "rpt_retrato.frx"
            ELSE
                loc_cTemplate = gc_4c_CaminhoReports + "rpt_paisagem.frx"
            ENDIF

            IF !FILE(loc_cTemplate)
                MsgAviso("Template n" + CHR(227) + "o encontrado: " + loc_cTemplate)
                RETURN
            ENDIF

            *-- Abrir FRX gerado e template
            IF USED("TmpFRX_Main")
                USE IN TmpFRX_Main
            ENDIF
            USE (par_cArqFRX) IN 0 ALIAS TmpFRX_Main

            IF USED("TmpCabPadrao")
                USE IN TmpCabPadrao
            ENDIF
            USE (loc_cTemplate) IN 0 ALIAS TmpCabPadrao

            IF FILE("TmpRelat.DBF")
                IF USED("TmpRelat")
                    USE IN TmpRelat
                ENDIF
                DELETE FILE TmpRelat.*
            ENDIF

            SELECT * FROM TmpCabPadrao WHERE OBJTYPE NOT IN (1, 9) INTO TABLE TmpRelat READWRITE

            *-- Atualizar PAGE_HEADER_TITULO com titulo e fonte do cursor
            SELECT TmpRelat
            GO TOP
            LOCATE FOR ALLTRIM(COMMENT) = "PAGE_HEADER_TITULO"
            IF !EOF()
                SELECT cursor_4c_PropsTitulo
                loc_lcFontName  = ""
                loc_lnFontSize  = 0
                loc_lcFontStyle = ""
                loc_lnFontStyle = 0
                THIS.DetalharFonte(ALLTRIM(NVL(cursor_4c_PropsTitulo.LblFonte, "Tahoma,10,N")), ;
                    @loc_lcFontName, @loc_lnFontSize, @loc_lcFontStyle, @loc_lnFontStyle)

                SELECT TmpRelat
                REPLACE Expr     WITH "'" + ALLTRIM(NVL(cursor_4c_PropsTitulo.LblCaption, "")) + "'"
                REPLACE COMMENT  WITH "PAGE_HEADER_TITULO " + Expr                                 + CHR(13) + ;
                    "LblAlinhar " + ALLTRIM(NVL(cursor_4c_PropsTitulo.LblAlinhar, "Left"))     + CHR(13) + ;
                    "LblTamCmp "  + ALLTRIM(STR(NVL(cursor_4c_PropsTitulo.LblTamCmp, 90)))    + CHR(13) + ;
                    "LblTipoCmp " + ALLTRIM(NVL(cursor_4c_PropsTitulo.LblTipoCmp, "C"))        + CHR(13) + ;
                    "LblCaption " + ALLTRIM(NVL(cursor_4c_PropsTitulo.LblCaption, ""))
                REPLACE fontface  WITH loc_lcFontName
                REPLACE FontSize  WITH loc_lnFontSize
                REPLACE FontStyle WITH IIF("BI" $ loc_lcFontStyle, 3, ;
                    IIF("B" $ loc_lcFontStyle, 1, IIF("I" $ loc_lcFontStyle, 2, 0)))

                SELECT cursor_4c_PropsTitulo
                loc_lnRed   = MOD(NVL(cursor_4c_PropsTitulo.LblBtCor, 0), 256)
                loc_lnGreen = MOD(INT(NVL(cursor_4c_PropsTitulo.LblBtCor, 0) / 256), 256)
                loc_lnBlue  = MOD(INT(NVL(cursor_4c_PropsTitulo.LblBtCor, 0) / 65536), 256)
                SELECT TmpRelat
                REPLACE PenRed WITH loc_lnRed, PenGreen WITH loc_lnGreen, PenBlue WITH loc_lnBlue
                GO TOP
            ENDIF

            *-- Incorporar records do template ao FRX gerado
            SELECT TmpFRX_Main
            APPEND FROM TmpRelat

            USE IN TmpFRX_Main
            USE IN TmpCabPadrao
            USE IN TmpRelat
            IF FILE("TmpRelat.DBF")
                DELETE FILE TmpRelat.*
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao mesclar template:" + CHR(13) + loc_oErro.Message, "FormRPT.MesclarComTemplate")
        ENDTRY

        IF UPPER(loc_cOldSafety) = "ON"
            SET SAFETY ON
        ELSE
            SET SAFETY OFF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarFRXParaSQL - Salva cada record do FRX no SQL Server (SIGCDRLD)
    * Usa ?variable parameterizado para campos texto (handles CHR(13) etc.)
    *==========================================================================
    PROTECTED PROCEDURE SalvarFRXParaSQL(par_cRPT_ID, par_cArqFRX)
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
        LOCAL loc_p_cidchaves, loc_p_rpt_id, loc_p_rpt_ordem
        LOCAL loc_p_platform, loc_p_uniqueid, loc_p_timestamp_val
        LOCAL loc_p_objtype, loc_p_objcode
        LOCAL loc_p_name_val, loc_p_expr_val, loc_p_vpos, loc_p_hpos, loc_p_height, loc_p_width
        LOCAL loc_p_style, loc_p_picture_val, loc_p_order_val, loc_p_unique_val
        LOCAL loc_p_comment_val, loc_p_environ, loc_p_boxchar, loc_p_fillchar
        LOCAL loc_p_tag_val, loc_p_tag2_val, loc_p_penred, loc_p_pengreen, loc_p_penblue
        LOCAL loc_p_fillred, loc_p_fillgreen, loc_p_fillblue, loc_p_pensize
        LOCAL loc_p_penpat, loc_p_fillpat, loc_p_fontface_val, loc_p_fontstyle, loc_p_fontsize_val
        LOCAL loc_p_mode, loc_p_ruler, loc_p_rulerlines, loc_p_grid_val
        LOCAL loc_p_gridh, loc_p_gridv, loc_p_float_val, loc_p_stretch_val
        LOCAL loc_p_stretchtop, loc_p_top_val, loc_p_bottom_val
        LOCAL loc_p_suptype, loc_p_suprest, loc_p_norepeat, loc_p_resetrpt
        LOCAL loc_p_pagebreak, loc_p_colbreak, loc_p_resetpage
        LOCAL loc_p_general, loc_p_spacing, loc_p_double_val
        LOCAL loc_p_swapheader, loc_p_swapfooter, loc_p_ejectbefor, loc_p_ejectafter
        LOCAL loc_p_plain, loc_p_summary_val, loc_p_addalias, loc_p_offset
        LOCAL loc_p_topmargin, loc_p_botmargin
        LOCAL loc_p_totaltype, loc_p_resettotal, loc_p_resoid
        LOCAL loc_p_curpos, loc_p_supalways, loc_p_supovflow
        LOCAL loc_p_suprpcol, loc_p_supgroup, loc_p_supvalchng
        LOCAL loc_p_user_val, loc_p_supexpr_val
        loc_lSucesso = .F.

        TRY
            SQLEXEC(gnConnHandle, "DELETE FROM SIGCDRLD WHERE rpt_id = ?par_cRPT_ID")

            IF USED("TmpFRX_Save")
                USE IN TmpFRX_Save
            ENDIF
            USE (par_cArqFRX) IN 0 ALIAS TmpFRX_Save

            loc_p_rpt_id = par_cRPT_ID

            loc_cSQL = "INSERT INTO SIGCDRLD (" + ;
                "cidchaves,rpt_id,rpt_ordem,platform,uniqueid,[timestamp]," + ;
                "objtype,objcode,name,expr,vpos,hpos,height,width," + ;
                "style,picture,order_,unique_,comment,environ,boxchar,fillchar," + ;
                "tag,tag2,penred,pengreen,penblue,fillred,fillgreen,fillblue," + ;
                "pensize,penpat,fillpat,fontface,fontstyle,fontsize,mode," + ;
                "ruler,rulerlines,grid,gridh,gridv,float_,stretch,stretchtop,top_," + ;
                "bottom,suptype,suprest,norepeat,resetrpt,pagebreak,colbreak," + ;
                "resetpage,general,spacing,double_,swapheader,swapfooter," + ;
                "ejectbefor,ejectafter,plain,summary,addalias,offset," + ;
                "topmargin,botmargin,totaltype,resettotal,resoid,curpos," + ;
                "supalways,supovflow,suprpcol,supgroup,supvalchng,user_,supexpr" + ;
                ") VALUES (" + ;
                "?loc_p_cidchaves,?loc_p_rpt_id,?loc_p_rpt_ordem,?loc_p_platform,?loc_p_uniqueid,?loc_p_timestamp_val," + ;
                "?loc_p_objtype,?loc_p_objcode,?loc_p_name_val,?loc_p_expr_val,?loc_p_vpos,?loc_p_hpos,?loc_p_height,?loc_p_width," + ;
                "?loc_p_style,?loc_p_picture_val,?loc_p_order_val,?loc_p_unique_val,?loc_p_comment_val,?loc_p_environ,?loc_p_boxchar,?loc_p_fillchar," + ;
                "?loc_p_tag_val,?loc_p_tag2_val,?loc_p_penred,?loc_p_pengreen,?loc_p_penblue,?loc_p_fillred,?loc_p_fillgreen,?loc_p_fillblue," + ;
                "?loc_p_pensize,?loc_p_penpat,?loc_p_fillpat,?loc_p_fontface_val,?loc_p_fontstyle,?loc_p_fontsize_val,?loc_p_mode," + ;
                "?loc_p_ruler,?loc_p_rulerlines,?loc_p_grid_val,?loc_p_gridh,?loc_p_gridv,?loc_p_float_val,?loc_p_stretch_val,?loc_p_stretchtop,?loc_p_top_val," + ;
                "?loc_p_bottom_val,?loc_p_suptype,?loc_p_suprest,?loc_p_norepeat,?loc_p_resetrpt,?loc_p_pagebreak,?loc_p_colbreak," + ;
                "?loc_p_resetpage,?loc_p_general,?loc_p_spacing,?loc_p_double_val,?loc_p_swapheader,?loc_p_swapfooter," + ;
                "?loc_p_ejectbefor,?loc_p_ejectafter,?loc_p_plain,?loc_p_summary_val,?loc_p_addalias,?loc_p_offset," + ;
                "?loc_p_topmargin,?loc_p_botmargin,?loc_p_totaltype,?loc_p_resettotal,?loc_p_resoid,?loc_p_curpos," + ;
                "?loc_p_supalways,?loc_p_supovflow,?loc_p_suprpcol,?loc_p_supgroup,?loc_p_supvalchng,?loc_p_user_val,?loc_p_supexpr_val)"

            SELECT TmpFRX_Save
            GO TOP
            SCAN
                loc_p_cidchaves     = LEFT(SYS(2015) + SYS(2015) + SPACE(20), 20)
                loc_p_rpt_ordem     = RECNO()
                loc_p_platform      = NVL(TmpFRX_Save.PLATFORM, "")
                loc_p_uniqueid      = NVL(TmpFRX_Save.UNIQUEID, "")
                loc_p_timestamp_val = NVL(TmpFRX_Save.TIMESTAMP, 0)
                loc_p_objtype       = NVL(TmpFRX_Save.OBJTYPE, 0)
                loc_p_objcode       = NVL(TmpFRX_Save.OBJCODE, 0)
                loc_p_name_val      = NVL(TmpFRX_Save.NAME, "")
                loc_p_expr_val      = NVL(TmpFRX_Save.EXPR, "")
                loc_p_vpos          = NVL(TmpFRX_Save.VPOS, 0)
                loc_p_hpos          = NVL(TmpFRX_Save.HPOS, 0)
                loc_p_height        = NVL(TmpFRX_Save.HEIGHT, 0)
                loc_p_width         = NVL(TmpFRX_Save.WIDTH, 0)
                loc_p_style         = NVL(TmpFRX_Save.STYLE, "")
                loc_p_picture_val   = NVL(TmpFRX_Save.PICTURE, "")
                loc_p_order_val     = NVL(TmpFRX_Save.ORDER, "")
                loc_p_unique_val    = IIF(NVL(TmpFRX_Save.UNIQUE, .F.), 1, 0)
                loc_p_comment_val   = NVL(TmpFRX_Save.COMMENT, "")
                loc_p_environ       = IIF(NVL(TmpFRX_Save.ENVIRON, .F.), 1, 0)
                loc_p_boxchar       = NVL(TmpFRX_Save.BOXCHAR, "")
                loc_p_fillchar      = NVL(TmpFRX_Save.FILLCHAR, "")
                loc_p_tag_val       = NVL(TmpFRX_Save.TAG, "")
                loc_p_tag2_val      = NVL(TmpFRX_Save.TAG2, "")
                loc_p_penred        = NVL(TmpFRX_Save.PENRED, 0)
                loc_p_pengreen      = NVL(TmpFRX_Save.PENGREEN, 0)
                loc_p_penblue       = NVL(TmpFRX_Save.PENBLUE, 0)
                loc_p_fillred       = NVL(TmpFRX_Save.FILLRED, 0)
                loc_p_fillgreen     = NVL(TmpFRX_Save.FILLGREEN, 0)
                loc_p_fillblue      = NVL(TmpFRX_Save.FILLBLUE, 0)
                loc_p_pensize       = NVL(TmpFRX_Save.PENSIZE, 0)
                loc_p_penpat        = NVL(TmpFRX_Save.PENPAT, 0)
                loc_p_fillpat       = NVL(TmpFRX_Save.FILLPAT, 0)
                loc_p_fontface_val  = NVL(TmpFRX_Save.FONTFACE, "")
                loc_p_fontstyle     = NVL(TmpFRX_Save.FONTSTYLE, 0)
                loc_p_fontsize_val  = NVL(TmpFRX_Save.FONTSIZE, 0)
                loc_p_mode          = NVL(TmpFRX_Save.MODE, 0)
                loc_p_ruler         = NVL(TmpFRX_Save.RULER, 0)
                loc_p_rulerlines    = NVL(TmpFRX_Save.RULERLINES, 0)
                loc_p_grid_val      = IIF(NVL(TmpFRX_Save.GRID, .F.), 1, 0)
                loc_p_gridh         = NVL(TmpFRX_Save.GRIDH, 0)
                loc_p_gridv         = NVL(TmpFRX_Save.GRIDV, 0)
                loc_p_float_val     = IIF(NVL(TmpFRX_Save.FLOAT, .F.), 1, 0)
                loc_p_stretch_val   = IIF(NVL(TmpFRX_Save.STRETCH, .F.), 1, 0)
                loc_p_stretchtop    = IIF(NVL(TmpFRX_Save.STRETCHTOP, .F.), 1, 0)
                loc_p_top_val       = IIF(NVL(TmpFRX_Save.TOP, .F.), 1, 0)
                loc_p_bottom_val    = IIF(NVL(TmpFRX_Save.BOTTOM, .F.), 1, 0)
                loc_p_suptype       = NVL(TmpFRX_Save.SUPTYPE, 0)
                loc_p_suprest       = NVL(TmpFRX_Save.SUPREST, 0)
                loc_p_norepeat      = IIF(NVL(TmpFRX_Save.NOREPEAT, .F.), 1, 0)
                loc_p_resetrpt      = NVL(TmpFRX_Save.RESETRPT, 0)
                loc_p_pagebreak     = IIF(NVL(TmpFRX_Save.PAGEBREAK, .F.), 1, 0)
                loc_p_colbreak      = IIF(NVL(TmpFRX_Save.COLBREAK, .F.), 1, 0)
                loc_p_resetpage     = IIF(NVL(TmpFRX_Save.RESETPAGE, .F.), 1, 0)
                loc_p_general       = NVL(TmpFRX_Save.GENERAL, 0)
                loc_p_spacing       = NVL(TmpFRX_Save.SPACING, 0)
                loc_p_double_val    = IIF(NVL(TmpFRX_Save.DOUBLE, .F.), 1, 0)
                loc_p_swapheader    = IIF(NVL(TmpFRX_Save.SWAPHEADER, .F.), 1, 0)
                loc_p_swapfooter    = IIF(NVL(TmpFRX_Save.SWAPFOOTER, .F.), 1, 0)
                loc_p_ejectbefor    = IIF(NVL(TmpFRX_Save.EJECTBEFOR, .F.), 1, 0)
                loc_p_ejectafter    = IIF(NVL(TmpFRX_Save.EJECTAFTER, .F.), 1, 0)
                loc_p_plain         = IIF(NVL(TmpFRX_Save.PLAIN, .F.), 1, 0)
                loc_p_summary_val   = IIF(NVL(TmpFRX_Save.SUMMARY, .F.), 1, 0)
                loc_p_addalias      = IIF(NVL(TmpFRX_Save.ADDALIAS, .F.), 1, 0)
                loc_p_offset        = NVL(TmpFRX_Save.OFFSET, 0)
                loc_p_topmargin     = NVL(TmpFRX_Save.TOPMARGIN, 0)
                loc_p_botmargin     = NVL(TmpFRX_Save.BOTMARGIN, 0)
                loc_p_totaltype     = NVL(TmpFRX_Save.TOTALTYPE, 0)
                loc_p_resettotal    = NVL(TmpFRX_Save.RESETTOTAL, 0)
                loc_p_resoid        = NVL(TmpFRX_Save.RESOID, 0)
                loc_p_curpos        = IIF(NVL(TmpFRX_Save.CURPOS, .F.), 1, 0)
                loc_p_supalways     = IIF(NVL(TmpFRX_Save.SUPALWAYS, .F.), 1, 0)
                loc_p_supovflow     = IIF(NVL(TmpFRX_Save.SUPOVFLOW, .F.), 1, 0)
                loc_p_suprpcol      = NVL(TmpFRX_Save.SUPRPCOL, 0)
                loc_p_supgroup      = NVL(TmpFRX_Save.SUPGROUP, 0)
                loc_p_supvalchng    = IIF(NVL(TmpFRX_Save.SUPVALCHNG, .F.), 1, 0)
                loc_p_user_val      = NVL(TmpFRX_Save.USER, "")
                loc_p_supexpr_val   = NVL(TmpFRX_Save.SUPEXPR, "")

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao salvar rec FRX " + ALLTRIM(STR(RECNO())) + ":" + CHR(13) + CapturarErroSQL(), "FormRPT.SalvarFRXParaSQL")
                ENDIF
            ENDSCAN

            USE IN TmpFRX_Save

            *-- Registros de campos filtro-only (CkOutRPT=0, CkFiltro=1)
            SELECT cursor_4c_PropsCampos
            GO TOP
            SCAN FOR cursor_4c_PropsCampos.CkOutRPT = 0 AND cursor_4c_PropsCampos.CkFiltro = 1
                loc_p_cidchaves     = LEFT(SYS(2015) + SYS(2015) + SPACE(20), 20)
                loc_p_rpt_ordem     = 10000 + RECNO()
                loc_p_platform      = ""
                loc_p_uniqueid      = ""
                loc_p_timestamp_val = 0
                loc_p_objtype       = 8
                loc_p_objcode       = 0
                loc_p_name_val      = ""
                loc_p_expr_val      = "[" + ALLTRIM(cursor_4c_PropsCampos.LblCaption) + "]"
                loc_p_vpos          = 0
                loc_p_hpos          = 0
                loc_p_height        = 0
                loc_p_width         = 0
                loc_p_style         = ""
                loc_p_picture_val   = ""
                loc_p_order_val     = ""
                loc_p_unique_val    = 0
                loc_p_comment_val   = "HEADING "    + cursor_4c_PropsCampos.NmCampo                    + CHR(13) + ;
                    "TpCampo "    + cursor_4c_PropsCampos.TpCampo                             + CHR(13) + ;
                    "CkOutRPT "   + ALLTRIM(STR(cursor_4c_PropsCampos.CkOutRPT))              + CHR(13) + ;
                    "CkFiltro "   + ALLTRIM(STR(cursor_4c_PropsCampos.CkFiltro))              + CHR(13) + ;
                    "CkSubTot "   + ALLTRIM(STR(cursor_4c_PropsCampos.CkSubTot))              + CHR(13) + ;
                    "CkTotal "    + ALLTRIM(STR(cursor_4c_PropsCampos.CkTotal))               + CHR(13) + ;
                    "LblAlinhar " + ALLTRIM(cursor_4c_PropsCampos.LblAlinhar)                 + CHR(13) + ;
                    "LblTamCmp "  + ALLTRIM(STR(cursor_4c_PropsCampos.LblTamCmp))            + CHR(13) + ;
                    "LblTipoCmp " + ALLTRIM(cursor_4c_PropsCampos.LblTipoCmp)                + CHR(13) + ;
                    "LblCaption " + ALLTRIM(cursor_4c_PropsCampos.LblCaption)
                loc_p_environ       = 0
                loc_p_boxchar       = ""
                loc_p_fillchar      = ""
                loc_p_tag_val       = ""
                loc_p_tag2_val      = ""
                loc_p_penred        = 0
                loc_p_pengreen      = 0
                loc_p_penblue       = 0
                loc_p_fillred       = 0
                loc_p_fillgreen     = 0
                loc_p_fillblue      = 0
                loc_p_pensize       = 0
                loc_p_penpat        = 0
                loc_p_fillpat       = 0
                loc_p_fontface_val  = ALLTRIM(cursor_4c_PropsCampos.LblFonte)
                loc_p_fontstyle     = 0
                loc_p_fontsize_val  = 0
                loc_p_mode          = 0
                loc_p_ruler         = 0
                loc_p_rulerlines    = 0
                loc_p_grid_val      = 0
                loc_p_gridh         = 0
                loc_p_gridv         = 0
                loc_p_float_val     = 0
                loc_p_stretch_val   = 0
                loc_p_stretchtop    = 0
                loc_p_top_val       = 0
                loc_p_bottom_val    = 0
                loc_p_suptype       = 0
                loc_p_suprest       = 0
                loc_p_norepeat      = 0
                loc_p_resetrpt      = 0
                loc_p_pagebreak     = 0
                loc_p_colbreak      = 0
                loc_p_resetpage     = 0
                loc_p_general       = 0
                loc_p_spacing       = 0
                loc_p_double_val    = 0
                loc_p_swapheader    = 0
                loc_p_swapfooter    = 0
                loc_p_ejectbefor    = 0
                loc_p_ejectafter    = 0
                loc_p_plain         = 0
                loc_p_summary_val   = 0
                loc_p_addalias      = 0
                loc_p_offset        = 0
                loc_p_topmargin     = 0
                loc_p_botmargin     = 0
                loc_p_totaltype     = 0
                loc_p_resettotal    = 0
                loc_p_resoid        = 0
                loc_p_curpos        = 0
                loc_p_supalways     = 0
                loc_p_supovflow     = 0
                loc_p_suprpcol      = 0
                loc_p_supgroup      = 0
                loc_p_supvalchng    = 0
                loc_p_user_val      = ""
                loc_p_supexpr_val   = ""

                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar FRX no SQL:" + CHR(13) + loc_oErro.Message, "FormRPT.SalvarFRXParaSQL")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCursoresLayoutDoReport - Carrega cursores de layout de report existente
    * Usa Manutencao_RPT.Carregar_RPT para reconstruir FRX do SIGCDRLD
    * e escaneia os records pelo campo COMMENT para classificar
    *==========================================================================
    PROCEDURE CarregarCursoresLayoutDoReport(par_cRPT_ID)
        LOCAL loc_lSucesso, loc_cArqFRX, loc_oMntRPT
        LOCAL loc_lnOBJTYPE, loc_lnOBJCODE, loc_lcLblCaption, loc_lcExpr
        LOCAL loc_lcNmCampo, loc_lcTpCampo, loc_lcTipoCmp, loc_oPg2
        loc_lSucesso = .F.

        TRY
            loc_cArqFRX = FULLPATH(THIS.this_oBusinessObject.this_cDirTmp + ;
                UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)) + ".FRX")
            THIS.this_oBusinessObject.this_cArqReport = loc_cArqFRX

            *-- Reconstruir FRX a partir de SIGCDRLD via Manutencao_RPT
            SET CLASSLIB TO (gc_4c_CaminhoFramework + "ReportOBJ\SFRepObj.vcx") ADDITIVE
            loc_oMntRPT = CREATEOBJECT("Manutencao_RPT")
            IF !loc_oMntRPT.Carregar_RPT(gnConnHandle, par_cRPT_ID, loc_cArqFRX)
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o layout do report.")
                RETURN
            ENDIF

            *-- Resetar cursores com defaults
            THIS.CriarCursoresLayout()

            *-- Abrir FRX e escanear records
            IF USED("cursor_4c_TmpFRX")
                USE IN cursor_4c_TmpFRX
            ENDIF
            USE (loc_cArqFRX) IN 0 ALIAS cursor_4c_TmpFRX

            SELECT cursor_4c_TmpFRX
            GO TOP
            SCAN
                loc_lnOBJTYPE = NVL(cursor_4c_TmpFRX.OBJTYPE, 0)
                loc_lnOBJCODE = NVL(cursor_4c_TmpFRX.OBJCODE, 0)

                DO CASE
                CASE loc_lnOBJTYPE = 1 AND loc_lnOBJCODE = 53
                    *-- Report definition: extrair Orientation e PaperSize
                    loc_lcExpr = NVL(cursor_4c_TmpFRX.EXPR, "")
                    SELECT cursor_4c_PropsTitulo
                    REPLACE Orientation WITH VAL(STRTRAN(GETWORDNUM(loc_lcExpr, 1), "ORIENTATION=", "")) + 1
                    REPLACE PaperSize   WITH VAL(STRTRAN(GETWORDNUM(loc_lcExpr, 2), "PAPERSIZE=", ""))
                    SELECT cursor_4c_TmpFRX

                CASE loc_lnOBJTYPE = 8 AND ("PAGE_HEADER_TITULO" $ NVL(cursor_4c_TmpFRX.COMMENT, ""))
                    loc_lcLblCaption = ALLTRIM(NVL(cursor_4c_TmpFRX.EXPR, ""))
                    SELECT cursor_4c_PropsTitulo
                    REPLACE LblCaption WITH IIF(EMPTY(loc_lcLblCaption), "", &loc_lcLblCaption.)
                    REPLACE LblFonte   WITH ALLTRIM(NVL(cursor_4c_TmpFRX.FONTFACE, "")) + "," + ;
                        ALLTRIM(STR(NVL(cursor_4c_TmpFRX.FONTSIZE, 8))) + "," + ;
                        THIS.RetornarFontStyle(NVL(cursor_4c_TmpFRX.FONTSTYLE, 0))
                    REPLACE LblBtCor   WITH RGB(NVL(cursor_4c_TmpFRX.PENRED, 0), NVL(cursor_4c_TmpFRX.PENGREEN, 0), NVL(cursor_4c_TmpFRX.PENBLUE, 0))
                    REPLACE LblAlinhar WITH ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 2), 2), "Left"))
                    REPLACE LblTamCmp  WITH VAL(ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 3), 2), "0")))
                    REPLACE LblTipoCmp WITH ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 4), 2), "C"))
                    REPLACE ArrayID    WITH RECNO("cursor_4c_TmpFRX")
                    SELECT cursor_4c_TmpFRX

                CASE loc_lnOBJTYPE = 8 AND ("HEADING " $ NVL(cursor_4c_TmpFRX.COMMENT, ""))
                    loc_lcNmCampo    = GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 1), 2)
                    loc_lcTpCampo    = GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 2), 2)
                    loc_lcTipoCmp    = ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 9), 2), "C"))
                    loc_lcLblCaption = ALLTRIM(NVL(cursor_4c_TmpFRX.EXPR, ""))

                    SELECT cursor_4c_PropsCampos
                    LOCATE FOR cursor_4c_PropsCampos.NmCampo = loc_lcNmCampo
                    IF EOF("cursor_4c_PropsCampos")
                        APPEND BLANK
                    ENDIF
                    REPLACE NmCampo    WITH loc_lcNmCampo
                    REPLACE TpCampo    WITH loc_lcTpCampo
                    REPLACE CkOutRPT   WITH VAL(ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 3), 2), "0")))
                    REPLACE CkFiltro   WITH VAL(ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 4), 2), "0")))
                    REPLACE CkSubTot   WITH VAL(ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 5), 2), "0")))
                    REPLACE CkTotal    WITH VAL(ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 6), 2), "0")))
                    REPLACE LblCaption WITH IIF(EMPTY(loc_lcLblCaption), "", &loc_lcLblCaption.)
                    REPLACE LblFonte   WITH ALLTRIM(NVL(cursor_4c_TmpFRX.FONTFACE, "")) + "," + ;
                        ALLTRIM(STR(NVL(cursor_4c_TmpFRX.FONTSIZE, 8))) + "," + ;
                        THIS.RetornarFontStyle(NVL(cursor_4c_TmpFRX.FONTSTYLE, 0))
                    REPLACE LblBtCor   WITH RGB(NVL(cursor_4c_TmpFRX.PENRED, 0), NVL(cursor_4c_TmpFRX.PENGREEN, 0), NVL(cursor_4c_TmpFRX.PENBLUE, 0))
                    REPLACE LblAlinhar WITH ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 7), 2), "Left"))
                    REPLACE LblTamCmp  WITH VAL(ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 8), 2), "0")))
                    REPLACE LblTipoCmp WITH loc_lcTipoCmp
                    REPLACE ArrayID    WITH RECNO("cursor_4c_TmpFRX")

                    IF !(loc_lcTipoCmp $ "NU")
                        SELECT cursor_4c_LstCampos
                        LOCATE FOR cursor_4c_LstCampos.NmCampo = loc_lcNmCampo
                        IF EOF("cursor_4c_LstCampos")
                            APPEND BLANK
                            REPLACE NmCampo WITH loc_lcNmCampo, TpCampo WITH loc_lcTpCampo
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_TmpFRX

                CASE loc_lnOBJTYPE = 8 AND ("GROUP_HEADER_LABEL" $ NVL(cursor_4c_TmpFRX.COMMENT, ""))
                    loc_lcLblCaption = ALLTRIM(NVL(cursor_4c_TmpFRX.EXPR, ""))
                    SELECT cursor_4c_PropsGrp
                    REPLACE NmCampo    WITH GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 1), 2)
                    REPLACE LblCaption WITH IIF(EMPTY(loc_lcLblCaption), "", &loc_lcLblCaption.)
                    REPLACE LblFonte   WITH ALLTRIM(NVL(cursor_4c_TmpFRX.FONTFACE, "")) + "," + ;
                        ALLTRIM(STR(NVL(cursor_4c_TmpFRX.FONTSIZE, 8))) + "," + ;
                        THIS.RetornarFontStyle(NVL(cursor_4c_TmpFRX.FONTSTYLE, 0))
                    REPLACE LblBtCor   WITH RGB(NVL(cursor_4c_TmpFRX.PENRED, 0), NVL(cursor_4c_TmpFRX.PENGREEN, 0), NVL(cursor_4c_TmpFRX.PENBLUE, 0))
                    REPLACE LblAlinhar WITH ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 2), 2), "Left"))
                    REPLACE LblTamCmp  WITH VAL(ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 3), 2), "0")))
                    REPLACE LblTipoCmp WITH ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 4), 2), "C"))
                    REPLACE ArrayID    WITH RECNO("cursor_4c_TmpFRX")
                    SELECT cursor_4c_TmpFRX

                ENDCASE
            ENDSCAN

            USE IN cursor_4c_TmpFRX

            *-- Sincronizar controles visuais da Sub-Page2 com valores carregados
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            SELECT cursor_4c_PropsTitulo
            loc_oPg2.opt_4c_Orientacao.Value    = cursor_4c_PropsTitulo.Orientation
            loc_oPg2.cbo_4c_TamPapel.ListIndex  = cursor_4c_PropsTitulo.PaperSize
            loc_oPg2.lbl_4c_NmRelatorio.Caption = ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)
            IF cursor_4c_PropsTitulo.Orientation = 1
                loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Retrato_26.JPG"
            ELSE
                loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Paisagem_26.JPG"
            ENDIF
            THIS.this_nOrientacao = cursor_4c_PropsTitulo.Orientation

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar layout:" + CHR(13) + loc_oErro.Message, "FormRPT.CarregarCursoresLayoutDoReport")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPgPage1 - FASE 9: Adiciona controles ausentes da Page1 original
    * CmdGrp_Acoes (3 botoes), filtros De/Ate (FwEditData), lbl_4c_SqlAlterado
    * Original: SIGCDRPT.Pagina.Dados.Pageframe1.Page1
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage1()
        LOCAL loc_oSubPg1, loc_oCab
        loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF !PEMSTATUS(loc_oSubPg1, "cnt_4c_CabecalhoDados", 5)
            RETURN
        ENDIF

        loc_oCab = loc_oSubPg1.cnt_4c_CabecalhoDados

        *-- Reposicionar titulos para dar espaco aos 3 botoes de acao (Left=5..244)
        IF PEMSTATUS(loc_oCab, "lbl_4c_TituloD_Sombra", 5)
            loc_oCab.lbl_4c_TituloD_Sombra.Left  = 257
            loc_oCab.lbl_4c_TituloD_Sombra.Width = THIS.Width - 440
        ENDIF
        IF PEMSTATUS(loc_oCab, "lbl_4c_TituloD", 5)
            loc_oCab.lbl_4c_TituloD.Left  = 255
            loc_oCab.lbl_4c_TituloD.Width = THIS.Width - 440
        ENDIF

        *-- Botao LayOutRPT: salva SQL e vai para sub-pagina de Layout
        *-- Original: CmdGrp_Acoes.Cmd_LayOutRPT (Left=5, Width~70)
        loc_oCab.AddObject("cmd_4c_LayOutRPT", "CommandButton")
        WITH loc_oCab.cmd_4c_LayOutRPT
            .Caption         = "Salvar/" + CHR(13) + "Layout"
            .ToolTipText     = "Salvar SQL e configurar Layout do Relat" + CHR(243) + "rio"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 7
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Estrutura: exibe colunas da tabela selecionada no editor
        *-- Original: CmdGrp_Acoes.Cmd_Estrutura (Left=80)
        loc_oCab.AddObject("cmd_4c_Estrutura", "CommandButton")
        WITH loc_oCab.cmd_4c_Estrutura
            .Caption         = "Estrutura" + CHR(13) + "Tabela"
            .ToolTipText     = "Mostrar colunas da tabela selecionada"
            .Top             = 5
            .Left            = 85
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 7
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Processar: seta datas e executa SQL no editor
        *-- Original: CmdGrp_Acoes.Cmd_Processar (Left=155) + F8
        loc_oCab.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oCab.cmd_4c_Processar
            .Caption         = "Executar" + CHR(13) + "SQL (F8)"
            .ToolTipText     = "Executar SQL e exibir resultado"
            .Top             = 5
            .Left            = 165
            .Width           = 80
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 7
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Filtros de data De:/Ate: - posicionados na Row1 (Right side, apos txt_4c_DtAlteracao)
        *-- Original: Label1 Top=132 Left=26, FwEditData1 ControlSource="_vp_DtInicial"
        loc_oSubPg1.AddObject("lbl_4c_De", "Label")
        WITH loc_oSubPg1.lbl_4c_De
            .Caption   = "De:"
            .Top       = 123
            .Left      = 802
            .Width     = 22
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oSubPg1.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oSubPg1.txt_4c_DtInicial
            .Value       = DTOC(DATE())
            .Top         = 120
            .Left        = 827
            .Width       = 68
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Format      = "E"
            .MaxLength   = 10
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Original: Label2 Top=131 Left=164 "Ate:"
        loc_oSubPg1.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oSubPg1.lbl_4c_Ate
            .Caption   = "At" + CHR(233) + ":"
            .Top       = 123
            .Left      = 899
            .Width     = 28
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: FwEditData2 Top=128 Left=195 ControlSource="_vp_DtFinal"
        loc_oSubPg1.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oSubPg1.txt_4c_DtFinal
            .Value       = DTOC(DATE())
            .Top         = 120
            .Left        = 930
            .Width       = 65
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Format      = "E"
            .MaxLength   = 10
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Indicador SQL Alterado: "*" fica vermelho quando SQL eh modificado mas nao processado
        *-- Original: Lbl_SQL_Alterado Top=147 Left=8
        loc_oSubPg1.AddObject("lbl_4c_SqlAlterado", "Label")
        WITH loc_oSubPg1.lbl_4c_SqlAlterado
            .Caption   = "*"
            .Top       = 238
            .Left      = 73
            .Width     = 20
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs para botoes de acao (handlers PUBLIC)
        BINDEVENT(loc_oCab.cmd_4c_LayOutRPT, "Click", THIS, "BtnLayOutRPTClick")
        BINDEVENT(loc_oCab.cmd_4c_Estrutura, "Click", THIS, "BtnEstruturaClick")
        BINDEVENT(loc_oCab.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cSetExact
        loc_cSetExact = THIS.this_cSetExact

        TRY
            IF !EMPTY(loc_cSetExact)
                SET EXACT &loc_cSetExact.
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF USED("cursor_4c_ResultadoTemp")
                USE IN cursor_4c_ResultadoTemp
            ENDIF

            IF USED("cursor_4c_Resultado")
                USE IN cursor_4c_Resultado
            ENDIF

            IF USED("cursor_4c_CboSQL")
                USE IN cursor_4c_CboSQL
            ENDIF

            IF USED("cursor_4c_PropsTitulo")
                USE IN cursor_4c_PropsTitulo
            ENDIF
            IF USED("cursor_4c_PropsCampos")
                USE IN cursor_4c_PropsCampos
            ENDIF
            IF USED("cursor_4c_PropsGrp")
                USE IN cursor_4c_PropsGrp
            ENDIF
            IF USED("cursor_4c_LstCampos")
                USE IN cursor_4c_LstCampos
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro no Destroy:" + CHR(13) + loc_oErro.Message, "FormRPT.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
