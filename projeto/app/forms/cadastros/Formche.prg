*==============================================================================
* Formche.prg - Fase 7/8: Eventos Principais
* Formulario Carteira de Cheques (SIGCDCHE)
*
* Tabela principal: SigCqLcm (lotes de cheques)
* Tabelas aux: SigCcChm (cheques do lote), TempChq (cursor local)
* Tipo: CRUD (frmcadastro) - Lista de lotes + Dados do lote
* BO: cheBO
*==============================================================================

DEFINE CLASS Formche AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 686
    Width       = 1000
    Caption     = "Carteira de Cheques"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 1

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Filtros de periodo (Page1)
    this_dDataIni = {}
    this_dDataFim = {}

    *-- Numero do lote corrente
    this_nNumLoteAtual = 0
    *-- Guarda de reentrancia dos lookups abertos de LostFocus (regra #37, Erro195)
    this_lEmLookup = .F.

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    * DataSession=2: FormBase.Init define SET DATE BRITISH + SET CENTURY ON
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura basica do form
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- DataSession = 2 nasce com os SETs no default do VFP e o FormBase so
        *-- repoe DATE/CENTURY. Sem SET DELETED ON, o DELETE em TempChq (botao
        *-- Excluir e limpeza de linhas em branco) marca a linha mas ela
        *-- continua visivel na grade E continua sendo varrida pelo SCAN da
        *-- gravacao - o cheque excluido voltava ao salvar.
        SET DELETED ON
        SET EXACT ON

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("cheBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar cheBO", "Formche.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista, Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
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
    * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD + filtros + grid
    * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oFiltros, loc_oGrid

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (Top=2+29=31)
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
            .Caption   = THIS.Caption
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 40
            .Top       = 15
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 46
            .Top       = 18
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Top=0+29=29, Left=542)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida canonico (Left=917, Width=90, Top=29)
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
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container filtros de periodo (original: cntFiltros, top=82+29=111)
        loc_oPg1.AddObject("cnt_4c_Filtros", "Container")
        loc_oFiltros = loc_oPg1.cnt_4c_Filtros
        WITH loc_oFiltros
            .Top         = 111
            .Left        = 2
            .Width       = 420
            .Height      = 40
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oFiltros.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oFiltros.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .Top       = 10
            .Left      = 12
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oFiltros.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oFiltros.txt_4c_DtInicial
            .Top         = 6
            .Left        = 62
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oFiltros.txt_4c_DtInicial, "LostFocus", THIS, "DtInicialLostFocus")

        loc_oFiltros.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oFiltros.lbl_4c_Sep
            .Caption   = CHR(224)
            .Top       = 10
            .Left      = 149
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oFiltros.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oFiltros.txt_4c_DtFinal
            .Top         = 6
            .Left        = 162
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oFiltros.txt_4c_DtFinal, "LostFocus", THIS, "DtFinalLostFocus")

        *-- Botao LimpaDT: original top=85+29=114, left=290 (Limpar Data Transporte)
        loc_oPg1.AddObject("cmd_4c_LimpaDT", "CommandButton")
        WITH loc_oPg1.cmd_4c_LimpaDT
            .Top         = 114
            .Left        = 290
            .Width       = 120
            .Height      = 40
            .Caption     = "Limpar Data"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.cmd_4c_LimpaDT, "Click", THIS, "BtnLimpaDTClick")

        *-- Grid lista de lotes (grd_4c_Dados) - RecordSource definido em CarregarLista
        *-- ColumnCount e RecordSource FORA do WITH (Problema 36)
        loc_oPg1.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid             = loc_oPg1.grd_4c_Dados
        loc_oGrid.Top         = 156
        loc_oGrid.Left        = 2
        loc_oGrid.Width       = 910
        loc_oGrid.Height      = 492
        loc_oGrid.ColumnCount = 6

        WITH loc_oGrid
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
            .ReadOnly           = .T.
            .Visible            = .T.
            .Column1.Width      = 55
            .Column2.Width      = 82
            .Column3.Width      = 130
            .Column3.Alignment  = 2
            .Column4.Width      = 105
            .Column4.Alignment  = 1
            .Column5.Width      = 100
            .Column5.Alignment  = 1
            .Column6.Width      = 100
            .Column1.Header1.Caption = "Lote"
            .Column2.Header1.Caption = "Data"
            .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column4.Header1.Caption = "Total"
            .Column5.Header1.Caption = "Juros"
            .Column6.Header1.Caption = "Dt. Transporte"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: Fase 5/8
    * Campos adicionados: BotoesAcao, Imprime, Shapes, cabecalho do lote,
    * totais, moeda, GradeCheque (9 cols), ExcCheque, leitor cheque
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao, loc_oGrid

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Cabecalho cinza (identico ao da pagina Lista) - CLAUDE.md #11 / Erro152
        loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPg2.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

        ENDWITH


        *-- Container botoes de acao: Confirmar / Cancelar (Top=4+29=33)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Botao Imprime (top=4+29=33, left=696, original: 75x75)
        loc_oPg2.AddObject("cmd_4c_Imprime", "CommandButton")
        WITH loc_oPg2.cmd_4c_Imprime
            .Top           = 33
            .Left          = 696
            .Width         = 75
            .Height        = 75
            .Caption       = "\<Relat" + CHR(243) + "rio"
            .FontName      = "Tahoma"
            .FontBold      = .T.
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_Imprime, "Click", THIS, "BtnImprimeClick")

        *-- Botao Protocolo (hidden, top=4+29=33, left=771)
        loc_oPg2.AddObject("cmd_4c_Protocolos", "CommandButton")
        WITH loc_oPg2.cmd_4c_Protocolos
            .Top     = 33
            .Left    = 771
            .Width   = 75
            .Height  = 75
            .Caption = "\<Protocolo"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .F.
        ENDWITH

        *-- Shapes decorativos (top=8+29=37)
        loc_oPg2.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPg2.shp_4c_Shape1
            .Top         = 115
            .Left        = 9
            .Width       = 620
            .Height      = 112
            .BackStyle   = 0
            .BorderColor = RGB(150, 150, 150)
            .Visible     = .T.
        ENDWITH

        loc_oPg2.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPg2.shp_4c_Shape2
            .Top         = 115
            .Left        = 719
            .Width       = 92
            .Height      = 53
            .BackStyle   = 0
            .BorderColor = RGB(150, 150, 150)
            .Visible     = .T.
        ENDWITH

        *-- Lote (readonly): lbl_4c_Label3 (top=19+29=48), txt_4c_Lote (top=15+29=44)
        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .Caption   = "Lote :"
            .Top       = 126
            .Left      = 79
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Lote", "TextBox")
        WITH loc_oPg2.txt_4c_Lote
            .Top         = 122
            .Left        = 111
            .Width       = 64
            .Height      = 23
            .Value       = 0
            .InputMask = "99999999"
            .ReadOnly    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Data Base: lbl_4c_DataBase (top=19+29=48), txt_4c_Data (top=15+29=44)
        loc_oPg2.AddObject("lbl_4c_DataBase", "Label")
        WITH loc_oPg2.lbl_4c_DataBase
            .Caption   = "Data Base :"
            .Top       = 126
            .Left      = 191
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPg2.txt_4c_Data
            .Top         = 122
            .Left        = 251
            .Width       = 77
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Data do Movimento (readonly): lbl_4c_Label22 (top=19+29=48), txt_4c_DtMovs (top=15+29=44)
        loc_oPg2.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPg2.lbl_4c_Label22
            .Caption   = "Data do Movimento :"
            .Top       = 126
            .Left      = 360
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DtMovs", "TextBox")
        WITH loc_oPg2.txt_4c_DtMovs
            .Top         = 122
            .Left        = 464
            .Width       = 77
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .ReadOnly    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Movimento (cod. operacao do lote - codigos): lbl_4c_Label19 (top=45+29=74), txt_4c_OperL (top=41+29=70)
        loc_oPg2.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPg2.lbl_4c_Label19
            .Caption   = "Movimento :"
            .Top       = 152
            .Left      = 48
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_OperL", "TextBox")
        WITH loc_oPg2.txt_4c_OperL
            .Top         = 148
            .Left        = 111
            .Width       = 124
            .Height      = 23
            .Value       = ""
            .InputMask = "!!!!!!!!!!!!!!!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_OperL, "LostFocus", THIS, "ValidarOperL")

        *-- Operacao (S/N, readonly): lbl_4c_Label5 (top=45+29=74), txt_4c_Opera (top=41+29=70)
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 152
            .Left      = 253
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Opera", "TextBox")
        WITH loc_oPg2.txt_4c_Opera
            .Top         = 148
            .Left        = 311
            .Width       = 17
            .Height      = 23
            .Value       = ""
            .ReadOnly    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Limpar Carteira (hidden): lbl_4c_Label13, txt_4c_LimCart
        loc_oPg2.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg2.lbl_4c_Label13
            .Caption   = "Limpar Carteira :"
            .Top       = 152
            .Left      = 380
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_LimCart", "TextBox")
        WITH loc_oPg2.txt_4c_LimCart
            .Top         = 148
            .Left        = 464
            .Width       = 17
            .Height      = 23
            .Format    = "M"
            .InputMask = "S,N"
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .F.
        ENDWITH

        *-- Indicador (S/N) hidden
        loc_oPg2.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPg2.lbl_4c_Label14
            .Caption   = "(S/N)"
            .Top       = 152
            .Left      = 489
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- Grupo Terceiro: lbl_4c_Label21 (top=71+29=100), txt_4c_GrupoT / txt_4c_DGrupoT (top=67+29=96)
        loc_oPg2.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPg2.lbl_4c_Label21
            .Caption   = "Grupo Terceiro :"
            .Top       = 178
            .Left      = 29
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_GrupoT", "TextBox")
        WITH loc_oPg2.txt_4c_GrupoT
            .Top         = 174
            .Left        = 111
            .Width       = 87
            .Height      = 23
            .Value       = ""
            .InputMask = "!!!!!!!!!!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_GrupoT, "LostFocus", THIS, "ValidarGrupoT")

        loc_oPg2.AddObject("txt_4c_DGrupoT", "TextBox")
        WITH loc_oPg2.txt_4c_DGrupoT
            .Top         = 174
            .Left        = 200
            .Width       = 300
            .Height      = 23
            .Value       = ""
            .ReadOnly    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_DGrupoT, "LostFocus", THIS, "ValidarDGrupoT")

        *-- Total Bruto (readonly): lbl_4c_Label8 (top=97+29=126), txt_4c_Valor (top=93+29=122)
        loc_oPg2.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg2.lbl_4c_Label8
            .Caption   = "Total Bruto :"
            .Top       = 204
            .Left      = 47
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPg2.txt_4c_Valor
            .Top         = 200
            .Left        = 111
            .Width       = 124
            .Height      = 23
            .Value       = 0
            .InputMask   = "999,999,999.99"
            .ReadOnly    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Juros (readonly): lbl_4c_Label17 (top=97+29=126), txt_4c_TJUROS (top=93+29=122)
        loc_oPg2.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPg2.lbl_4c_Label17
            .Caption   = "Juros :"
            .Top       = 204
            .Left      = 247
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_TJUROS", "TextBox")
        WITH loc_oPg2.txt_4c_TJUROS
            .Top         = 200
            .Left        = 284
            .Width       = 113
            .Height      = 23
            .Value       = 0
            .InputMask   = "999,999,999.99"
            .ReadOnly    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Total Liquido (readonly): lbl_4c_Label4 (top=97+29=126), txt_4c_TLiq (top=93+29=122)
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .Caption   = "Total L" + CHR(237) + "quido :"
            .Top       = 204
            .Left      = 433
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_TLiq", "TextBox")
        WITH loc_oPg2.txt_4c_TLiq
            .Top         = 200
            .Left        = 504
            .Width       = 117
            .Height      = 23
            .Value       = 0
            .InputMask   = "999,999,999.99"
            .ReadOnly    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Moeda: lbl_4c_Label6 (top=406+29=435), txt_4c_Moeda (top=402+29=431)
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .Caption   = "Moeda :"
            .Top       = 513
            .Left      = 590
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg2.txt_4c_Moeda
            .Top         = 509
            .Left        = 633
            .Width       = 32
            .Height      = 23
            .Value       = ""
            .InputMask = "!!!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Moeda, "LostFocus", THIS, "ValidarMoeda")

        *-- Cotacao: lbl_4c_Cotacao (top=431+29=460), txt_4c_Cotacao (top=427+29=456)
        loc_oPg2.AddObject("lbl_4c_Cotacao", "Label")
        WITH loc_oPg2.lbl_4c_Cotacao
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
            .Top       = 538
            .Left      = 582
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Cotacao", "TextBox")
        WITH loc_oPg2.txt_4c_Cotacao
            .Top         = 534
            .Left        = 633
            .Width       = 118
            .Height      = 23
            .Value       = 0
            .InputMask   = "99,999.9999999"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Cotacao, "LostFocus", THIS, "CotacaoLostFocus")

        *-- Valor Convertido (readonly): lbl_4c_Label20 (top=456+29=485), txt_4c_ValConv (top=452+29=481)
        loc_oPg2.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPg2.lbl_4c_Label20
            .Caption   = "Valor Conv :"
            .Top       = 563
            .Left      = 570
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_ValConv", "TextBox")
        WITH loc_oPg2.txt_4c_ValConv
            .Top         = 559
            .Left        = 633
            .Width       = 118
            .Height      = 23
            .Value       = 0
            .InputMask   = "999,999,999.99"
            .ReadOnly    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- GradeCheque: grid de cheques (top=130+29=159), 9 colunas
        *-- ColumnCount FORA do WITH; ControlSource/RecordSource definidos em CarregarPaginaDados
        loc_oPg2.AddObject("grd_4c_GradeCheque", "Grid")
        loc_oGrid             = loc_oPg2.grd_4c_GradeCheque
        loc_oGrid.Top         = 237
        loc_oGrid.Left        = 9
        loc_oGrid.Width       = 985
        loc_oGrid.Height      = 244
        loc_oGrid.ColumnCount = 9

        WITH loc_oGrid
            .FontName           = "Courier New"
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
            .RowHeight          = 17
            .ScrollBars         = 3
            .Visible            = .T.
            .Column1.Header1.Caption = "Bco"
            .Column2.Header1.Caption = "Agenc"
            .Column3.Header1.Caption = "N" + CHR(186) + " Conta"
            .Column4.Header1.Caption = "N" + CHR(186) + " Cheque"
            .Column5.Header1.Caption = "Vencimento"
            .Column6.Header1.Caption = "Valor"
            .Column7.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
            .Column8.Header1.Caption = "CPF/CNPJ"
            .Column9.Header1.Caption = "Nome Terceiro"
        ENDWITH

        *-- Celula "No Conta": o legado completa a conta com zeros a esquerda ao
        *-- sair do campo (Conta.Text1.Valid). Column.AddObject sozinho NAO faz o
        *-- controle aparecer - precisa de CurrentControl + Sparse (regra #18).
        loc_oGrid.Column3.AddObject("txt_4c_ContaChq", "TextBoxContaCheque_4c")
        loc_oGrid.Column3.CurrentControl = "txt_4c_ContaChq"
        loc_oGrid.Column3.Sparse         = .F.

        *-- Botao Excluir Cheque da grade (ExcCheque, top=376+29=405, left=939)
        loc_oPg2.AddObject("cmd_4c_ExcCheque", "CommandButton")
        WITH loc_oPg2.cmd_4c_ExcCheque
            .Top           = 483
            .Left          = 939
            .Width         = 55
            .Height        = 53
            .Caption       = "E\<xcluir"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_ExcCheque, "Click", THIS, "BtnExcChequeClick")

        *-- Get_Cheque: campo para leitora magnetica / digitacao (top=393+29=422, left=115)
        loc_oPg2.AddObject("txt_4c_Cheque", "TextBox")
        WITH loc_oPg2.txt_4c_Cheque
            .Top         = 500
            .Left        = 115
            .Width       = 252
            .Height      = 24
            .Value       = ""
            .InputMask = "<99999999<9999999999>999999999999:"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Labels AvisoPorta M/T/S (ocultos - visiveis conforme tipo de operacao)
        loc_oPg2.AddObject("lbl_4c_AvisoPortaM", "Label")
        WITH loc_oPg2.lbl_4c_AvisoPortaM
            .Top       = 174
            .Left      = 544
            .Width     = 22
            .Height    = 18
            .Caption   = "M"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 192)
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_AvisoPortaT", "Label")
        WITH loc_oPg2.lbl_4c_AvisoPortaT
            .Top       = 174
            .Left      = 570
            .Width     = 22
            .Height    = 18
            .Caption   = "T"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 192)
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_AvisoPortaS", "Label")
        WITH loc_oPg2.lbl_4c_AvisoPortaS
            .Top       = 174
            .Left      = 596
            .Width     = 22
            .Height    = 18
            .Caption   = "S"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 192)
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- cmd_4c_Command3 Historico (top=405, left=829)
        loc_oPg2.AddObject("cmd_4c_Command3", "CommandButton")
        WITH loc_oPg2.cmd_4c_Command3
            .Top           = 483
            .Left          = 829
            .Width         = 55
            .Height        = 53
            .Caption       = "Hist" + CHR(243) + "rico"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_Command3, "Click", THIS, "BtnCommand3Click")

        *-- cmd_4c_BotConsulta PGV consulta lote (top=405, left=884)
        loc_oPg2.AddObject("cmd_4c_BotConsulta", "CommandButton")
        WITH loc_oPg2.cmd_4c_BotConsulta
            .Top           = 483
            .Left          = 884
            .Width         = 55
            .Height        = 53
            .Caption       = "PGV"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_BotConsulta, "Click", THIS, "BtnBotConsultaClick")

        *-- Grupo Origem (top=456, left=9/115/197)
        loc_oPg2.AddObject("lbl_4c_LblGrupoOs", "Label")
        WITH loc_oPg2.lbl_4c_LblGrupoOs
            .Top      = 538
            .Left     = 38
            .Width    = 75
            .Height   = 15
            .Caption  = "Grupo Origem :"
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_GrupoOs", "TextBox")
        WITH loc_oPg2.txt_4c_GrupoOs
            .Top         = 534
            .Left        = 115
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .InputMask   = "!!!!!!!!!!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_GrupoOs, "LostFocus", THIS, "ValidarGrupoOs")

        loc_oPg2.AddObject("txt_4c_DGrupoOs", "TextBox")
        WITH loc_oPg2.txt_4c_DGrupoOs
            .Top         = 534
            .Left        = 197
            .Width       = 300
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .ReadOnly    = .F.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_DGrupoOs, "LostFocus", THIS, "ValidarDGrupoOs")

        *-- cmd_4c_Command1 PGV Origem (top=456, left=500, cobre linha Grupo+Conta Orig)
        loc_oPg2.AddObject("cmd_4c_Command1", "CommandButton")
        WITH loc_oPg2.cmd_4c_Command1
            .Top           = 534
            .Left          = 500
            .Width         = 31
            .Height        = 48
            .Caption       = "PGV"
            .FontName      = "Tahoma"
            .FontSize      = 7
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_Command1, "Click", THIS, "BtnCommand1Click")

        *-- Conta Origem (top=481, left=9/115/197)
        loc_oPg2.AddObject("lbl_4c_LblContaOs", "Label")
        WITH loc_oPg2.lbl_4c_LblContaOs
            .Top      = 562
            .Left     = 38
            .Width    = 75
            .Height   = 15
            .Caption  = "Conta Origem :"
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_ContaOs", "TextBox")
        WITH loc_oPg2.txt_4c_ContaOs
            .Top         = 559
            .Left        = 115
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .InputMask   = "!!!!!!!!!!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_ContaOs, "LostFocus", THIS, "ValidarContaOs")

        loc_oPg2.AddObject("txt_4c_DCONTAOs", "TextBox")
        WITH loc_oPg2.txt_4c_DCONTAOs
            .Top         = 559
            .Left        = 197
            .Width       = 300
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .ReadOnly    = .F.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_DCONTAOs, "LostFocus", THIS, "ValidarDContaOs")

        *-- Grupo Destino (top=506, left=9/115/197)
        loc_oPg2.AddObject("lbl_4c_LblGrupoDs", "Label")
        WITH loc_oPg2.lbl_4c_LblGrupoDs
            .Top      = 587
            .Left     = 36
            .Width    = 77
            .Height   = 15
            .Caption  = "Grupo Destino :"
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_GrupoDs", "TextBox")
        WITH loc_oPg2.txt_4c_GrupoDs
            .Top         = 584
            .Left        = 115
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .InputMask   = "!!!!!!!!!!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_GrupoDs, "LostFocus", THIS, "ValidarGrupoDs")

        loc_oPg2.AddObject("txt_4c_DGrupoDs", "TextBox")
        WITH loc_oPg2.txt_4c_DGrupoDs
            .Top         = 584
            .Left        = 197
            .Width       = 300
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .ReadOnly    = .F.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_DGrupoDs, "LostFocus", THIS, "ValidarDGrupoDs")

        *-- cmd_4c_Command2 PGV Destino (top=506, left=500, cobre linha Grupo+Conta Dest)
        loc_oPg2.AddObject("cmd_4c_Command2", "CommandButton")
        WITH loc_oPg2.cmd_4c_Command2
            .Top           = 584
            .Left          = 500
            .Width         = 31
            .Height        = 48
            .Caption       = "PGV"
            .FontName      = "Tahoma"
            .FontSize      = 7
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_Command2, "Click", THIS, "BtnCommand2Click")

        *-- Conta Destino (top=531, left=9/115/197)
        loc_oPg2.AddObject("lbl_4c_LblContaDs", "Label")
        WITH loc_oPg2.lbl_4c_LblContaDs
            .Top      = 612
            .Left     = 36
            .Width    = 77
            .Height   = 15
            .Caption  = "Conta Destino :"
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_ContaDs", "TextBox")
        WITH loc_oPg2.txt_4c_ContaDs
            .Top         = 609
            .Left        = 115
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .InputMask   = "!!!!!!!!!!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_ContaDs, "LostFocus", THIS, "ValidarContaDs")

        loc_oPg2.AddObject("txt_4c_DCONTADs", "TextBox")
        WITH loc_oPg2.txt_4c_DCONTADs
            .Top         = 609
            .Left        = 197
            .Width       = 300
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .ReadOnly    = .F.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_DCONTADs, "LostFocus", THIS, "ValidarDContaDs")

        *-- Taxa a.m.% label + textbox (top=506, left=548/633)
        loc_oPg2.AddObject("lbl_4c_LblTaxa", "Label")
        WITH loc_oPg2.lbl_4c_LblTaxa
            .Top      = 588
            .Left     = 551
            .Width    = 80
            .Height   = 15
            .Caption  = "Taxa a.m. (%) :"
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Taxa", "TextBox")
        WITH loc_oPg2.txt_4c_Taxa
            .Top         = 584
            .Left        = 633
            .Width       = 66
            .Height      = 23
            .Value       = 0
            .InputMask = "999.99"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Taxa, "LostFocus", THIS, "TaxaLostFocus")

        *-- Taxa a.d.% label + textbox (top=531, left=548/633)
        loc_oPg2.AddObject("lbl_4c_LblTaxaDia", "Label")
        WITH loc_oPg2.lbl_4c_LblTaxaDia
            .Top      = 613
            .Left     = 553
            .Width    = 78
            .Height   = 15
            .Caption  = "Taxa a.d. (%) :"
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_TaxaDia", "TextBox")
        WITH loc_oPg2.txt_4c_TaxaDia
            .Top         = 609
            .Left        = 633
            .Width       = 66
            .Height      = 23
            .Value       = 0
            .InputMask = "999.9999"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_TaxaDia, "LostFocus", THIS, "TaxaDiaLostFocus")

        *-- Indicadores S (Simples) / C (Composto) entre Taxa dia e IOF (top=552, left=717/743)
        loc_oPg2.AddObject("lbl_4c_TpJuroS", "Label")
        WITH loc_oPg2.lbl_4c_TpJuroS
            .Top       = 630
            .Left      = 717
            .Width     = 20
            .Height    = 18
            .Caption   = "S"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(128, 128, 128)
            .AutoSize  = .F.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_TpJuroC", "Label")
        WITH loc_oPg2.lbl_4c_TpJuroC
            .Top       = 630
            .Left      = 743
            .Width     = 20
            .Height    = 18
            .Caption   = "C"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(128, 128, 128)
            .AutoSize  = .F.
        ENDWITH

        *-- Grupo Juros (top=556, left=9/115/197)
        loc_oPg2.AddObject("lbl_4c_LblGruJuro", "Label")
        WITH loc_oPg2.lbl_4c_LblGruJuro
            .Top      = 637
            .Left     = 46
            .Width    = 67
            .Height   = 15
            .Caption  = "Grupo Juros :"
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_GruJuro", "TextBox")
        WITH loc_oPg2.txt_4c_GruJuro
            .Top         = 634
            .Left        = 115
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .InputMask   = "!!!!!!!!!!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_GruJuro, "LostFocus", THIS, "ValidarGruJuro")

        loc_oPg2.AddObject("txt_4c_DGruJuro", "TextBox")
        WITH loc_oPg2.txt_4c_DGruJuro
            .Top         = 634
            .Left        = 197
            .Width       = 300
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .ReadOnly    = .F.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_DGruJuro, "LostFocus", THIS, "ValidarDGruJuro")

        *-- IOF a.m.% label + textbox (top=556, left=548/633)
        loc_oPg2.AddObject("lbl_4c_LblTaxaIof", "Label")
        WITH loc_oPg2.lbl_4c_LblTaxaIof
            .Top      = 638
            .Left     = 557
            .Width    = 74
            .Height   = 15
            .Caption  = "IOF a.m. (%) :"
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_TaxaIof", "TextBox")
        WITH loc_oPg2.txt_4c_TaxaIof
            .Top         = 634
            .Left        = 633
            .Width       = 66
            .Height      = 23
            .Value       = 0
            .InputMask   = "999.99"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_TaxaIof, "LostFocus", THIS, "TaxaIofLostFocus")

        *-- Conta Juros (top=581, left=9/115/197)
        loc_oPg2.AddObject("lbl_4c_LblConJuro", "Label")
        WITH loc_oPg2.lbl_4c_LblConJuro
            .Top      = 662
            .Left     = 46
            .Width    = 67
            .Height   = 15
            .Caption  = "Conta Juros :"
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_ConJuro", "TextBox")
        WITH loc_oPg2.txt_4c_ConJuro
            .Top         = 659
            .Left        = 115
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .InputMask   = "!!!!!!!!!!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_ConJuro, "LostFocus", THIS, "ValidarConJuro")

        loc_oPg2.AddObject("txt_4c_DJuro", "TextBox")
        WITH loc_oPg2.txt_4c_DJuro
            .Top         = 659
            .Left        = 197
            .Width       = 300
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .ReadOnly    = .F.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_DJuro, "LostFocus", THIS, "ValidarDConJuro")

        THIS.TornarControlesVisiveis(loc_oPg2)

        *-- Re-ocultar controles que devem iniciar invisiveis (TornarControlesVisiveis seta Visible=.T. em tudo)
        loc_oPg2.lbl_4c_Label13.Visible    = .F.
        loc_oPg2.txt_4c_LimCart.Visible    = .F.
        loc_oPg2.lbl_4c_Label14.Visible    = .F.
        loc_oPg2.cmd_4c_Protocolos.Visible = .F.
        loc_oPg2.lbl_4c_AvisoPortaM.Visible = .F.
        loc_oPg2.lbl_4c_AvisoPortaT.Visible = .F.
        loc_oPg2.lbl_4c_AvisoPortaS.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca lotes no periodo e vincula grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cFiltro, loc_cDataIni, loc_cDataFim, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (numlotes N(10,0), datas D, operas C(20), ;
                    valtots N(12,2), valtjuros N(12,2), datatrans D)
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            *-- Montar filtro de periodo
            loc_cFiltro = ""

            IF !EMPTY(THIS.this_dDataIni)
                loc_cDataIni = FormatarDataSQL(THIS.this_dDataIni)
                loc_cFiltro  = loc_cFiltro + " AND a.datas >= " + loc_cDataIni
            ENDIF

            IF !EMPTY(THIS.this_dDataFim)
                loc_cDataFim = FormatarDataSQL(THIS.this_dDataFim)
                loc_cFiltro  = loc_cFiltro + " AND a.datas <= " + loc_cDataFim
            ENDIF

            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                *-- RecordSource FORA do WITH (Problema 36)
                loc_oGrid.ColumnCount = 6
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                WITH loc_oGrid
                    .Column1.ControlSource = "cursor_4c_Dados.numlotes"
                    .Column2.ControlSource = "cursor_4c_Dados.datas"
                    .Column3.ControlSource = "cursor_4c_Dados.operas"
                    .Column4.ControlSource = "cursor_4c_Dados.valtots"
                    .Column5.ControlSource = "cursor_4c_Dados.valtjuros"
                    .Column6.ControlSource = "cursor_4c_Dados.datatrans"
                    *-- Re-setar headers apos RecordSource (VFP9 reseta captions)
                    .Column1.Header1.Caption = "Lote"
                    .Column2.Header1.Caption = "Data"
                    .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    .Column4.Header1.Caption = "Total"
                    .Column5.Header1.Caption = "Juros"
                    .Column6.Header1.Caption = "Dt. Transporte"
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ELSE
                IF par_nPagina = 2
                    THIS.CarregarPaginaDados()
                ENDIF
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Abre Page2 para inclusao de novo lote
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_nNumLoteAtual = 0
            THIS.this_cModoAtual    = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_nLote
        loc_lResultado = .F.

        *-- Validacao FORA do TRY (Regra Critica VFP9 #1: RETURN nunca dentro de TRY)
        loc_nLote = 0
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            loc_nLote = cursor_4c_Dados.numlotes
        ENDIF

        IF loc_nLote = 0
            MsgAviso("Selecione um lote na lista.", "Carteira de Cheques")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_nNumLoteAtual = loc_nLote

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre Page2 em modo edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_nLote
        loc_lResultado = .F.

        *-- Validacao FORA do TRY (Regra Critica VFP9 #1: RETURN nunca dentro de TRY)
        loc_nLote = 0
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            loc_nLote = cursor_4c_Dados.numlotes
        ENDIF

        IF loc_nLote = 0
            MsgAviso("Selecione um lote na lista.", "Carteira de Cheques")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_nNumLoteAtual = loc_nLote

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui lote selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_nLote
        loc_lResultado = .F.

        *-- Validacao FORA do TRY (Regra Critica VFP9 #1: RETURN nunca dentro de TRY)
        loc_nLote = 0
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            loc_nLote = cursor_4c_Dados.numlotes
        ENDIF

        IF loc_nLote = 0
            MsgAviso("Selecione um lote na lista.", "Carteira de Cheques")
            RETURN .F.
        ENDIF

        TRY
            IF MsgConfirma("Excluir o lote " + LTRIM(STR(loc_nLote)) + "?")
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
                    IF THIS.this_oBusinessObject.Excluir()
                        THIS.CarregarLista()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Aplica filtro de periodo e recarrega lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.this_dDataIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
            THIS.this_dDataFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnLimpaDTClick - Limpa data de transporte do lote selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnLimpaDTClick()
        LOCAL loc_lResultado, loc_nLote, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_nLote = 0
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                loc_nLote = cursor_4c_Dados.numlotes
            ENDIF

            IF loc_nLote = 0
                MsgAviso("Selecione um lote na lista.", "Limpar Data Transporte")
                loc_lResultado = .F.
            ENDIF

            IF MsgConfirma("Limpar data de transporte do lote " + LTRIM(STR(loc_nLote)) + "?")
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "UPDATE SigCqLcm SET datatrans = NULL WHERE NumLotes = " + ;
                    FormatarNumeroSQL(loc_nLote))

                IF loc_nRet > 0
                    SQLEXEC(gnConnHandle, ;
                        "UPDATE SigCcChm SET datatrans = NULL WHERE numlotes = " + ;
                        FormatarNumeroSQL(loc_nLote))
                ENDIF

                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnLimpaDTClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DtInicialLostFocus - Valida data inicial e recarrega lista
    *--------------------------------------------------------------------------
    PROCEDURE DtInicialLostFocus()
        LOCAL loc_dIni, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_dIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value

            IF VARTYPE(loc_dIni) = "D"
                THIS.this_dDataIni = loc_dIni
            ELSE
                THIS.this_dDataIni = {}
            ENDIF

            IF !EMPTY(THIS.this_dDataIni) AND !EMPTY(THIS.this_dDataFim)
                IF THIS.this_dDataIni > THIS.this_dDataFim
                    MsgAviso("Data inicial maior que a data final.", ;
                        "Per" + CHR(237) + "odo")
                    THIS.this_dDataIni = {}
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value = {}
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.DtInicialLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DtFinalLostFocus - Valida data final e recarrega lista
    *--------------------------------------------------------------------------
    PROCEDURE DtFinalLostFocus()
        LOCAL loc_dFim, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_dFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value

            IF VARTYPE(loc_dFim) = "D"
                THIS.this_dDataFim = loc_dFim
            ELSE
                THIS.this_dDataFim = {}
            ENDIF

            IF !EMPTY(THIS.this_dDataIni) AND !EMPTY(THIS.this_dDataFim)
                IF THIS.this_dDataFim < THIS.this_dDataIni
                    MsgAviso("Data final menor que a data inicial.", ;
                        "Per" + CHR(237) + "odo")
                    THIS.this_dDataFim = {}
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value = {}
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.DtFinalLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de edicao (expandido na Fase 5)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            WITH loc_oPg2
                .txt_4c_OperL.ReadOnly           = !par_lHabilitar
                .txt_4c_Data.ReadOnly            = !par_lHabilitar
                .txt_4c_GrupoT.ReadOnly          = !par_lHabilitar
                .txt_4c_Moeda.ReadOnly           = !par_lHabilitar
                .txt_4c_Cotacao.ReadOnly         = !par_lHabilitar
                .grd_4c_GradeCheque.ReadOnly     = !par_lHabilitar
                *-- AllowAddNew eh o mecanismo do legado para INCLUIR MAIS CHEQUES:
                *-- com a ultima linha preenchida, a seta para baixo acrescenta
                *-- outra. Sem ele o lote ficava preso em UM cheque (Erro207).
                .grd_4c_GradeCheque.AllowAddNew  = par_lHabilitar
                .cmd_4c_ExcCheque.Enabled        = par_lHabilitar
                .txt_4c_GrupoOs.ReadOnly         = !par_lHabilitar
                .txt_4c_ContaOs.ReadOnly         = !par_lHabilitar
                .txt_4c_GrupoDs.ReadOnly         = !par_lHabilitar
                .txt_4c_ContaDs.ReadOnly         = !par_lHabilitar
                .txt_4c_GruJuro.ReadOnly         = !par_lHabilitar
                .txt_4c_ConJuro.ReadOnly         = !par_lHabilitar
                .txt_4c_Taxa.ReadOnly            = !par_lHabilitar
                .txt_4c_TaxaDia.ReadOnly         = !par_lHabilitar
                .txt_4c_TaxaIof.ReadOnly         = !par_lHabilitar
                *-- Campos de DESCRICAO: editaveis no legado (busca pelo nome),
                *-- mas apenas em INSERIR/ALTERAR, como o When do SCX.
                .txt_4c_DGrupoT.ReadOnly         = !par_lHabilitar
                .txt_4c_DGrupoOs.ReadOnly        = !par_lHabilitar
                .txt_4c_DCONTAOs.ReadOnly        = !par_lHabilitar
                .txt_4c_DGrupoDs.ReadOnly        = !par_lHabilitar
                .txt_4c_DCONTADs.ReadOnly        = !par_lHabilitar
                .txt_4c_DGruJuro.ReadOnly        = !par_lHabilitar
                .txt_4c_DJuro.ReadOnly           = !par_lHabilitar
                .cmd_4c_BotConsulta.Enabled      = par_lHabilitar
                .cmd_4c_Command1.Enabled         = par_lHabilitar
                .cmd_4c_Command2.Enabled         = par_lHabilitar
                .cmd_4c_Command3.Enabled         = par_lHabilitar
                .cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDWITH

            *-- Column.ReadOnly DEPOIS de Grid.ReadOnly: o do grid propaga para as
            *-- colunas e sobrescreve. O SCX declara ColumnN.ReadOnly = .F. nas 9.
            WITH loc_oPg2.grd_4c_GradeCheque
                .Column1.ReadOnly = !par_lHabilitar
                .Column2.ReadOnly = !par_lHabilitar
                .Column3.ReadOnly = !par_lHabilitar
                .Column4.ReadOnly = !par_lHabilitar
                .Column5.ReadOnly = !par_lHabilitar
                .Column6.ReadOnly = !par_lHabilitar
                .Column7.ReadOnly = !par_lHabilitar
                .Column8.ReadOnly = !par_lHabilitar
                .Column9.ReadOnly = !par_lHabilitar
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta estado do lote corrente
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        TRY
            THIS.this_nNumLoteAtual = 0
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            WITH loc_oPg2
                .txt_4c_Lote.Value    = 0
                .txt_4c_Data.Value    = {}
                .txt_4c_DtMovs.Value  = {}
                .txt_4c_OperL.Value   = ""
                .txt_4c_Opera.Value   = ""
                .txt_4c_LimCart.Value = ""
                .txt_4c_GrupoT.Value  = ""
                .txt_4c_DGrupoT.Value = ""
                .txt_4c_Valor.Value   = 0
                .txt_4c_TJUROS.Value  = 0
                .txt_4c_TLiq.Value    = 0
                .txt_4c_Moeda.Value   = ""
                .txt_4c_Cotacao.Value = 0
                .txt_4c_ValConv.Value = 0
                .txt_4c_GrupoOs.Value  = ""
                .txt_4c_DGrupoOs.Value = ""
                .txt_4c_ContaOs.Value  = ""
                .txt_4c_DCONTAOs.Value = ""
                .txt_4c_GrupoDs.Value  = ""
                .txt_4c_DGrupoDs.Value = ""
                .txt_4c_ContaDs.Value  = ""
                .txt_4c_DCONTADs.Value = ""
                .txt_4c_GruJuro.Value  = ""
                .txt_4c_DGruJuro.Value = ""
                .txt_4c_ConJuro.Value  = ""
                .txt_4c_DJuro.Value    = ""
                .txt_4c_Taxa.Value     = 0
                .txt_4c_TaxaDia.Value  = 0
                .txt_4c_TaxaIof.Value  = 0
            ENDWITH
            IF USED("TempChq")
                SELECT TempChq
                SET ORDER TO
                ZAP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia dados do BO para controles do form (expandido na Fase 5)
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO, loc_nRet
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO  = THIS.this_oBusinessObject
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2
                THIS.this_nNumLoteAtual = loc_oBO.this_nNumLote
                WITH loc_oPg2
                    .txt_4c_Lote.Value    = loc_oBO.this_nNumLote
                    .txt_4c_Data.Value    = loc_oBO.this_dData
                    .txt_4c_DtMovs.Value  = loc_oBO.this_dDtMovs
                    .txt_4c_OperL.Value   = ALLTRIM(loc_oBO.this_cOperL)
                    .txt_4c_Opera.Value   = ALLTRIM(loc_oBO.this_cOpera)
                    .txt_4c_LimCart.Value = ALLTRIM(loc_oBO.this_cLimCart)
                    .txt_4c_GrupoT.Value  = ALLTRIM(loc_oBO.this_cGrupoT)
                    .txt_4c_DGrupoT.Value = ALLTRIM(loc_oBO.this_cDGrupoT)
                    .txt_4c_Valor.Value   = loc_oBO.this_nValor
                    .txt_4c_TJUROS.Value  = loc_oBO.this_nTJuros
                    .txt_4c_TLiq.Value    = loc_oBO.this_nTLiq
                    .txt_4c_Moeda.Value   = ALLTRIM(loc_oBO.this_cMoeda)
                    .txt_4c_Cotacao.Value = loc_oBO.this_nCotacao
                    .txt_4c_ValConv.Value = loc_oBO.this_nValConv
                    .txt_4c_GrupoOs.Value  = ALLTRIM(loc_oBO.this_cGrupoOs)
                    .txt_4c_ContaOs.Value  = ALLTRIM(loc_oBO.this_cContaOs)
                    .txt_4c_GrupoDs.Value  = ALLTRIM(loc_oBO.this_cGrupoDs)
                    .txt_4c_ContaDs.Value  = ALLTRIM(loc_oBO.this_cContaDs)
                    .txt_4c_GruJuro.Value  = ALLTRIM(loc_oBO.this_cGruJuro)
                    .txt_4c_ConJuro.Value  = ALLTRIM(loc_oBO.this_cConJuro)
                    .txt_4c_Taxa.Value     = loc_oBO.this_nTaxaMes
                    .txt_4c_TaxaDia.Value  = loc_oBO.this_nTaxaDia
                    .txt_4c_TaxaIof.Value  = loc_oBO.this_nTaxaIof
                ENDWITH
                *-- inicdesc() do legado: descricoes de Origem, Destino, Juros e Terceiro
                THIS.IniciarDescricoes("")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia dados dos controles para o BO (implementado na Fase 5)
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO, loc_nTotal, loc_nJuros
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO  = THIS.this_oBusinessObject
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2
                loc_oBO.this_dData    = loc_oPg2.txt_4c_Data.Value
                loc_oBO.this_cOperL   = ALLTRIM(loc_oPg2.txt_4c_OperL.Value)
                loc_oBO.this_cOpera   = ALLTRIM(loc_oPg2.txt_4c_Opera.Value)
                loc_oBO.this_cLimCart = ALLTRIM(loc_oPg2.txt_4c_LimCart.Value)
                loc_oBO.this_cGrupoT  = ALLTRIM(loc_oPg2.txt_4c_GrupoT.Value)
                loc_oBO.this_cMoeda   = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
                loc_oBO.this_nCotacao = loc_oPg2.txt_4c_Cotacao.Value
                loc_oBO.this_nValConv = loc_oPg2.txt_4c_ValConv.Value
                loc_oBO.this_cGrupoOs = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
                loc_oBO.this_cContaOs = ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value)
                loc_oBO.this_cGrupoDs = ALLTRIM(loc_oPg2.txt_4c_GrupoDs.Value)
                loc_oBO.this_cContaDs = ALLTRIM(loc_oPg2.txt_4c_ContaDs.Value)
                loc_oBO.this_cGruJuro = ALLTRIM(loc_oPg2.txt_4c_GruJuro.Value)
                loc_oBO.this_cConJuro = ALLTRIM(loc_oPg2.txt_4c_ConJuro.Value)
                loc_oBO.this_nTaxaMes = loc_oPg2.txt_4c_Taxa.Value
                loc_oBO.this_nTaxaDia = loc_oPg2.txt_4c_TaxaDia.Value
                loc_oBO.this_nTaxaIof = loc_oPg2.txt_4c_TaxaIof.Value
                *-- Calcular totais a partir de TempChq
                loc_nTotal = 0
                loc_nJuros = 0
                IF USED("TempChq")
                    SELECT TempChq
                    SCAN
                        IF !EMPTY(ALLTRIM(TempChq.Bancos)) OR !EMPTY(ALLTRIM(TempChq.NCheques))
                            loc_nTotal = loc_nTotal + TempChq.Valors
                            loc_nJuros = loc_nJuros + TempChq.Valjuros
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_oBO.this_nValor  = loc_nTotal
                loc_oBO.this_nTJuros = loc_nJuros
                loc_oBO.this_nTLiq   = loc_nTotal - loc_nJuros
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.FormParaBO")
        ENDTRY
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

            IF USED("TempChq")
                USE IN TempChq
            ENDIF

            DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.Destroy")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lExcluir

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_lExcluir = INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")

                IF !loc_lExcluir
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
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma e salva cabecalho do lote (SigCqLcm)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oBO, loc_oPg2, loc_lProsseguir
        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        TRY
            loc_oBO  = THIS.this_oBusinessObject
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Cada validacao ABORTA a gravacao. Antes elas so atribuiam
            *-- loc_lResultado = .F. (que ja era .F.) e a execucao seguia direto
            *-- para FormParaBO + Salvar: o aviso aparecia e o registro gravava
            *-- assim mesmo (Erro207). Flag em vez de RETURN por causa do TRY.
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_OperL.Value))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o de lote inv" + CHR(225) + "lida.", "Confirmar")
                loc_oPg2.txt_4c_OperL.SetFocus()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(loc_oPg2.txt_4c_Data.Value)
                MsgAviso("Data base obrigat" + CHR(243) + "ria.", "Confirmar")
                loc_oPg2.txt_4c_Data.SetFocus()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Moeda.Value))
                MsgAviso("Moeda obrigat" + CHR(243) + "ria.", "Confirmar")
                loc_oPg2.txt_4c_Moeda.SetFocus()
                loc_lProsseguir = .F.
            ENDIF

            *-- Validacoes transcritas do Grupo_Salva.Salva.Click do legado
            IF loc_lProsseguir
                IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)) ;
                        OR EMPTY(ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value)) ;
                        OR EMPTY(ALLTRIM(loc_oPg2.txt_4c_GrupoDs.Value)) ;
                        OR EMPTY(ALLTRIM(loc_oPg2.txt_4c_ContaDs.Value))
                    MsgAviso("Grupos e Contas de Origem/Destino devem ser preenchidos", "Confirmar")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value) + ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value) == ;
                        ALLTRIM(loc_oPg2.txt_4c_GrupoDs.Value) + ALLTRIM(loc_oPg2.txt_4c_ContaDs.Value)
                    MsgAviso("Conta Dep" + CHR(243) + "sito Inv" + CHR(225) + "lida !!", "Confirmar")
                    loc_oPg2.txt_4c_ContaOs.SetFocus()
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Conta de juros nao pode coincidir com origem nem destino
            IF loc_lProsseguir AND loc_oPg2.txt_4c_TJUROS.Value != 0
                IF ALLTRIM(loc_oPg2.txt_4c_GruJuro.Value) + ALLTRIM(loc_oPg2.txt_4c_ConJuro.Value) == ;
                        ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value) + ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value) ;
                        OR ALLTRIM(loc_oPg2.txt_4c_GruJuro.Value) + ALLTRIM(loc_oPg2.txt_4c_ConJuro.Value) == ;
                        ALLTRIM(loc_oPg2.txt_4c_GrupoDs.Value) + ALLTRIM(loc_oPg2.txt_4c_ContaDs.Value)
                    MsgAviso("Conta Juros Inv" + CHR(225) + "lida !!", "Confirmar")
                    loc_oPg2.txt_4c_ConJuro.SetFocus()
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND !THIS.ExisteChequeNoLote()
                MsgAviso("Nenhum cheque adicionado ao lote.", "Confirmar")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_lProsseguir = THIS.ValidarLinhasCheque()
            ENDIF

            IF loc_lProsseguir
                THIS.FormParaBO()

                IF loc_oBO.Salvar()
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteChequeNoLote - .T. se TempChq tem ao menos uma linha PREENCHIDA.
    *   RECCOUNT() nao serve: a grade sempre carrega com uma linha em branco
    *   (APPEND BLANK em CarregarPaginaDados), entao RECCOUNT eh 1 com o lote
    *   vazio e a validacao "Nenhum cheque adicionado" nunca disparava.
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * ValidarLinhasCheque - transcrito do Grupo_Salva.Salva.Click do legado:
    *   linha totalmente vazia eh DELETADA; nas demais Bancos/Agencias/NContas/
    *   NCheques tem de ter o tamanho exato, e Vencimento e Valor sao
    *   obrigatorios. Devolve .F. (com aviso) na primeira linha invalida.
    *--------------------------------------------------------------------------
    FUNCTION ValidarLinhasCheque()
        LOCAL loc_lOk, loc_oPg2
        loc_lOk = .T.

        IF USED("TempChq")
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            SELECT TempChq
            GO TOP

            SCAN
                IF EMPTY(ALLTRIM(TempChq.Bancos)) AND EMPTY(ALLTRIM(TempChq.Agencias)) ;
                        AND EMPTY(ALLTRIM(TempChq.NContas)) AND EMPTY(ALLTRIM(TempChq.NCheques))
                    DELETE
                    LOOP
                ENDIF

                *-- Mesma normalizacao do Conta.Text1.Valid do legado, aqui como
                *-- rede de seguranca: linha que nao passou pela celula (colada,
                *-- vinda do banco ou preenchida por outro caminho) tambem fica
                *-- com os 10 digitos antes da checagem de tamanho.
                IF !EMPTY(ALLTRIM(TempChq.NContas))
                    REPLACE TempChq.NContas WITH PADL(ALLTRIM(TempChq.NContas), 10, "0")
                ENDIF

                IF LEN(ALLTRIM(TempChq.Bancos)) != 3 OR LEN(ALLTRIM(TempChq.Agencias)) != 4 ;
                        OR LEN(ALLTRIM(TempChq.NContas)) != 10 OR LEN(ALLTRIM(TempChq.NCheques)) != 6
                    MsgAviso("Cheque com Dados Inv" + CHR(225) + "lidos !" + CHR(13) + CHR(13) + ;
                        "Bco: "    + ALLTRIM(TempChq.Bancos)   + " (3 d" + CHR(237) + "gitos)" + CHR(13) + ;
                        "Ag" + CHR(234) + "ncia: " + ALLTRIM(TempChq.Agencias) + " (4 d" + CHR(237) + "gitos)" + CHR(13) + ;
                        "Conta: "  + ALLTRIM(TempChq.NContas)  + " (10 d" + CHR(237) + "gitos)" + CHR(13) + ;
                        "Cheque: " + ALLTRIM(TempChq.NCheques) + " (6 d" + CHR(237) + "gitos)", ;
                        "Confirmar")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                IF EMPTY(TempChq.Vencs)
                    MsgAviso("Vencimento Inv" + CHR(225) + "lido !", "Confirmar")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                IF TempChq.Valors = 0
                    MsgAviso("Valor Cheque Inv" + CHR(225) + "lido !", "Confirmar")
                    loc_lOk = .F.
                    EXIT
                ENDIF
            ENDSCAN

            IF !loc_lOk
                loc_oPg2.grd_4c_GradeCheque.SetFocus()
            ENDIF

            GO TOP IN TempChq
            loc_oPg2.grd_4c_GradeCheque.Refresh()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    FUNCTION ExisteChequeNoLote()
        LOCAL loc_lTem, loc_nRec
        loc_lTem = .F.

        IF USED("TempChq")
            SELECT TempChq
            loc_nRec = RECNO("TempChq")
            SCAN
                IF !EMPTY(ALLTRIM(TempChq.Bancos)) OR !EMPTY(ALLTRIM(TempChq.NCheques))
                    loc_lTem = .T.
                    EXIT
                ENDIF
            ENDSCAN
            IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("TempChq")
                GO loc_nRec IN TempChq
            ENDIF
        ENDIF

        RETURN loc_lTem
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPaginaDados - Cria/atualiza TempChq e vincula grd_4c_GradeCheque
    * INCLUIR: grade vazia (1 linha em branco p/ empresa)
    * VISUALIZAR/ALTERAR: carrega SigCcChm JOIN SigChe JOIN SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPaginaDados()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_oGrid, loc_oPg2
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF USED("TempChq")
                SELECT TempChq
                SET ORDER TO
                ZAP
            ELSE
                CREATE CURSOR TempChq ( ;
                    Bancos    C(3),   Agencias  C(4),  NContas   C(10), NCheques C(6),  ;
                    Vencs     D(8),   Valors    N(12,2), cpft     C(20), Nomet    C(40), ;
                    Obss      C(40),  emps      C(3),  Iclis     C(10), Grclis   C(10), ;
                    contas    C(10),  grupos    C(10), valpags   N(12,2), grucarts C(10), ;
                    concarts  C(10),  valjuros  N(12,2), nums    C(8),  Protocolos C(8), ;
                    grupoT    C(10),  contaT    C(10), leituras  C(34), devolvido C(1),  ;
                    moeds     C(3),   cotas     N(11,4) )
            ENDIF

            IF THIS.this_nNumLoteAtual > 0
                *-- Tudo que a grade exibe ja esta em SigCcChm. A versao
                *-- anterior buscava vencs/valors/... num LEFT JOIN com SigChe;
                *-- como SigChe aceita mais de um registro para a mesma chave de
                *-- cheque, o join DUPLICAVA linhas. O unico join que resta eh o
                *-- do TERCEIRO (contat), para CPF/Nome - equivalente ao
                *-- inicdesc('5') do legado.
                loc_cSQL = ;
                    "SELECT c.bancos, c.agencias, c.ncontas, c.ncheques, c.obss, c.emps," + ;
                    " c.vencs, c.valors, c.valjuros, c.iclis, c.grclis," + ;
                    " c.contas, c.grupos, c.nums, c.grupot, c.contat," + ;
                    " c.moeds, c.cotas, c.grucarts, c.concarts, c.protocolos," + ;
                    " 0 AS valpags," + ;
                    " ISNULL(cli.cpfs,   '')    AS cpft,"     + ;
                    " ISNULL(cli.rclis,  '')    AS nomet"     + ;
                    " FROM SigCcChm c"                        + ;
                    " LEFT JOIN SigCdCli cli ON RTRIM(cli.iclis) = RTRIM(c.contat)"          + ;
                    " WHERE c.numlotes = " + FormatarNumeroSQL(THIS.this_nNumLoteAtual)      + ;
                    " ORDER BY c.bancos, c.agencias, c.ncontas, c.ncheques"

                IF USED("cursor_4c_ChequesLoad")
                    USE IN cursor_4c_ChequesLoad
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequesLoad")

                IF loc_nRet > 0 AND USED("cursor_4c_ChequesLoad") AND RECCOUNT("cursor_4c_ChequesLoad") > 0
                    SELECT cursor_4c_ChequesLoad
                    SCAN
                        INSERT INTO TempChq ;
                            (Bancos, Agencias, NContas, NCheques, Vencs, Valors, ;
                             cpft, Nomet, Obss, emps, Iclis, Grclis, contas, grupos, ;
                             valpags, grucarts, concarts, nums, Protocolos, grupoT, ;
                             contaT, moeds, cotas, valjuros) ;
                            VALUES ;
                            (cursor_4c_ChequesLoad.bancos, cursor_4c_ChequesLoad.agencias, ;
                             cursor_4c_ChequesLoad.ncontas, cursor_4c_ChequesLoad.ncheques, ;
                             cursor_4c_ChequesLoad.vencs, cursor_4c_ChequesLoad.valors, ;
                             cursor_4c_ChequesLoad.cpft, cursor_4c_ChequesLoad.nomet, ;
                             cursor_4c_ChequesLoad.obss, cursor_4c_ChequesLoad.emps, ;
                             cursor_4c_ChequesLoad.iclis, cursor_4c_ChequesLoad.grclis, ;
                             cursor_4c_ChequesLoad.contas, cursor_4c_ChequesLoad.grupos, ;
                             cursor_4c_ChequesLoad.valpags, cursor_4c_ChequesLoad.grucarts, ;
                             cursor_4c_ChequesLoad.concarts, cursor_4c_ChequesLoad.nums, ;
                             cursor_4c_ChequesLoad.protocolos, cursor_4c_ChequesLoad.grupot, ;
                             cursor_4c_ChequesLoad.contat, cursor_4c_ChequesLoad.moeds, ;
                             cursor_4c_ChequesLoad.cotas, cursor_4c_ChequesLoad.valjuros)
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_ChequesLoad")
                    USE IN cursor_4c_ChequesLoad
                ENDIF
            ELSE
                *-- INCLUIR: linha em branco para empresa
                INSERT INTO TempChq (emps) VALUES (go_4c_Sistema.cCodEmpresa)
            ENDIF

            *-- Vincular grid (RecordSource FORA do WITH - Problema 36)
            loc_oGrid = loc_oPg2.grd_4c_GradeCheque
            loc_oGrid.RecordSource = "TempChq"

            WITH loc_oGrid
                .Column1.ControlSource   = "TempChq.Bancos"
                .Column2.ControlSource   = "TempChq.Agencias"
                .Column3.ControlSource   = "TempChq.NContas"
                .Column4.ControlSource   = "TempChq.NCheques"
                .Column5.ControlSource   = "TempChq.Vencs"
                .Column6.ControlSource   = "TempChq.Valors"
                .Column7.ControlSource   = "TempChq.Obss"
                .Column8.ControlSource   = "TempChq.cpft"
                .Column9.ControlSource   = "TempChq.Nomet"
                .Column1.Header1.Caption = "Bco"
                .Column2.Header1.Caption = "Agenc"
                .Column3.Header1.Caption = "N" + CHR(186) + " Conta"
                .Column4.Header1.Caption = "N" + CHR(186) + " Cheque"
                .Column5.Header1.Caption = "Vencimento"
                .Column6.Header1.Caption = "Valor"
                .Column7.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
                .Column8.Header1.Caption = "CPF/CNPJ"
                .Column9.Header1.Caption = "Nome Terceiro"

                *-- Format/InputMask transcritos do SCX (GradeCheque.<col>.Text1).
                *-- O legado declara nos DOIS niveis porque a Column sozinha nao
                *-- atualiza o Text1 ja instanciado.
                .Column1.Format    = "999"
                .Column1.InputMask = "999"
                .Column2.Format    = "9999"
                .Column2.InputMask = "9999"
                .Column3.Format    = "9999999999"
                .Column3.InputMask = "9999999999"
                .Column4.Format    = "999999"
                .Column4.InputMask = "999999"
                .Column6.Format    = "999,999,999.99"
                .Column6.InputMask = "999,999,999.99"
                .Column8.Format    = "K"
                .Column1.Text1.Format    = "999"
                .Column1.Text1.InputMask = "999"
                .Column1.Text1.Alignment = 3
                .Column2.Text1.Format    = "9999"
                .Column2.Text1.InputMask = "9999"
                .Column3.Text1.Format    = "9999999999"
                .Column3.Text1.InputMask = "9999999999"
                .Column4.Text1.Format    = "999999"
                .Column4.Text1.InputMask = "999999"
                .Column6.Text1.Format    = "999,999,999.99"
                .Column6.Text1.InputMask = "999,999,999.99"
                .Column8.Text1.Format    = "K"

                *-- Column.Width por ULTIMO: RecordSource/ControlSource recalculam
                *-- as larguras para o default 90 (regra #41). Definidas no
                *-- ConfigurarPaginaDados elas eram apagadas aqui.
                .Column1.Width = 35
                .Column2.Width = 40
                .Column3.Width = 85
                .Column4.Width = 70
                .Column5.Width = 80
                .Column6.Width = 110
                .Column7.Width = 145
                .Column8.Width = 150
                .Column9.Width = 240

                *-- ColumnOrder do SCX: Observacao vai para o FIM; CPF e Nome
                *-- sobem para 7 e 8. Sem isto a ordem na tela diverge do legado.
                .Column7.ColumnOrder = 9
                .Column8.ColumnOrder = 7
                .Column9.ColumnOrder = 8
                .Column5.Bound       = .T.
            ENDWITH

            SELECT TempChq
            GO TOP
            loc_oGrid.Refresh()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.CarregarPaginaDados")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcChequeClick - Exclui cheque corrente de TempChq e atualiza grade
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcChequeClick()
        LOCAL loc_oGrid
        TRY
            IF USED("TempChq") AND !EOF("TempChq")
                SELECT TempChq
                DELETE
                SKIP
                IF EOF("TempChq")
                    SKIP -1
                    IF BOF("TempChq")
                        APPEND BLANK
                        REPLACE TempChq.emps WITH go_4c_Sistema.cCodEmpresa
                        GO TOP
                    ENDIF
                ENDIF
            ENDIF
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeCheque
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnExcChequeClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimeClick - Imprime relatorio SigMvChe para o lote corrente
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
    *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Isolamento de locale + modo de renderizacao (Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
        *-- que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar aqui,
        *-- popups renderizam encolhidos apos preview fechar. Mesmo fix do
        *-- FormBase.Destroy (Erro58) precisa rodar no path REPORT PREVIEW.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    PROCEDURE BtnImprimeClick()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cRel, loc_cPoint, loc_cSep
        loc_lResultado = .F.

        TRY
            IF THIS.this_nNumLoteAtual <= 0
                MsgAviso("Salve o lote antes de imprimir.", "Relat" + CHR(243) + "rio")
                loc_lResultado = .F.
            ENDIF

            loc_cRel = gc_4c_CaminhoReports + "SigMvChe.frx"

            IF !FILE(loc_cRel)
                MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                    CHR(13) + loc_cRel, "Imprimir")
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT * FROM SigCcChm WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLoteAtual)

            IF USED("cursor_4c_Rel")
                USE IN cursor_4c_Rel
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Rel")

            IF loc_nRet < 0 OR !USED("cursor_4c_Rel") OR RECCOUNT("cursor_4c_Rel") = 0
                MsgAviso("Nenhum cheque encontrado para impress" + CHR(227) + "o.", "Imprimir")
                IF USED("cursor_4c_Rel")
                    USE IN cursor_4c_Rel
                ENDIF
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_RelFinal")
                USE IN cursor_4c_RelFinal
            ENDIF

            IF USED("TempChq") AND RECCOUNT("TempChq") > 0
                SELECT a.*, b.valjuros AS valjur ;
                    FROM TempChq a, cursor_4c_Rel b ;
                    WHERE a.bancos = b.bancos AND a.agencias = b.agencias ;
                    AND a.ncontas = b.ncontas AND a.ncheques = b.ncheques ;
                    INTO CURSOR cursor_4c_RelFinal
            ELSE
                SELECT * FROM cursor_4c_Rel INTO CURSOR cursor_4c_RelFinal
            ENDIF

            IF USED("cursor_4c_Rel")
                USE IN cursor_4c_Rel
            ENDIF

            IF USED("cursor_4c_RelFinal") AND RECCOUNT("cursor_4c_RelFinal") > 0
                SELECT cursor_4c_RelFinal
                GO TOP
                loc_cPoint = SET("Point")
                loc_cSep   = SET("Separator")
                SET POINT TO "."
                SET SEPARATOR TO ","
                SET REPORTBEHAVIOR 80
                THIS.ExecutarReportForm("SigMvChe", "PREVIEW")
                SET POINT TO (loc_cPoint)
                SET SEPARATOR TO (loc_cSep)
                SET REPORTBEHAVIOR 90
                SET SYSMENU TO DEFAULT
                TRY
                    CriarMenuPrincipal()
                CATCH TO loc_oErroMenu
                ENDTRY
                loc_lResultado = .T.
            ENDIF

            IF USED("cursor_4c_RelFinal")
                USE IN cursor_4c_RelFinal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnImprimeClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperL - LostFocus: lookup de operacao de carteira (SigCdOpt)
    * Preenche txt_4c_Opera (S/E/' ') e txt_4c_Moeda default da operacao
    *--------------------------------------------------------------------------
    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em ValidarOperLExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE ValidarOperL()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarOperLExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarOperLExec()
        LOCAL loc_oLookup, loc_cVal, loc_oPg2, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_cVal = ALLTRIM(loc_oPg2.txt_4c_OperL.Value)

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdOpt", "cursor_4c_OperLPick", ;
                "Operacaos", loc_cVal, ;
                "Opera" + CHR(231) + CHR(245) + "es")

            IF VARTYPE(loc_oLookup) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !loc_oLookup.this_lSelecionou
                    *-- Sem mAddColuna o grid nasce com ColumnCount = 0 e o picker
                    *-- abre como caixa branca vazia. Colunas transcritas do legado
                    *-- (Get_OperL.Valid: AddColuna Operacaos/Descrs).
                    loc_oLookup.mAddColuna("Operacaos", "", "C" + CHR(243) + "digo")
                    loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.Show()
                    IF !loc_oLookup.this_lSelecionou
                        loc_oLookup.Release()
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_OperLPick") AND RECCOUNT("cursor_4c_OperLPick") > 0
                    SELECT cursor_4c_OperLPick
                    GO TOP
                    loc_oPg2.txt_4c_OperL.Value = ALLTRIM(cursor_4c_OperLPick.Operacaos)
                    *-- Transcrito do legado (Get_OperL.Valid): a operacao carrega os
                    *-- grupos/contas padrao de origem, destino e terceiro. Sem isto o
                    *-- usuario escolhia o Movimento e os campos Grupo/Conta Orig.
                    *-- continuavam vazios (Erro207).
                    loc_oPg2.txt_4c_GrupoDs.Value = ALLTRIM(cursor_4c_OperLPick.grudeps)
                    loc_oPg2.txt_4c_ContaDs.Value = ALLTRIM(cursor_4c_OperLPick.condeps)
                    loc_oPg2.txt_4c_GrupoOs.Value = ALLTRIM(cursor_4c_OperLPick.grupoos)
                    loc_oPg2.txt_4c_ContaOs.Value = ALLTRIM(cursor_4c_OperLPick.contaos)
                    loc_oPg2.txt_4c_GrupoT.Value  = ALLTRIM(cursor_4c_OperLPick.grupot)
                    *-- opera: S=entrada(DB), E=saida, ' '=transferencia(TR)
                    loc_oPg2.txt_4c_Opera.Value = IIF(ALLTRIM(cursor_4c_OperLPick.tipos) = "TR", " ", ;
                        IIF(ALLTRIM(cursor_4c_OperLPick.tipos) = "DB", "S", "E"))
                    *-- Moeda default da operacao (coluna SigCdOpt.moedas, nao "moeds")
                    IF !EMPTY(ALLTRIM(cursor_4c_OperLPick.moedas))
                        loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_OperLPick.moedas)
                    ENDIF
                    *-- Leitura de cheque por codigo de barras so com tpleituras = 2
                    loc_oPg2.txt_4c_Cheque.Visible = (cursor_4c_OperLPick.tpleituras = 2)
                    loc_oPg2.txt_4c_Cheque.Enabled = (cursor_4c_OperLPick.tpleituras = 2)
                    *-- inicdesc('1'..'4') do legado: preenche as descricoes dos codigos
                    THIS.IniciarDescricoes("1")
                    THIS.IniciarDescricoes("2")
                    THIS.IniciarDescricoes("3")
                    THIS.IniciarDescricoes("4")
                ENDIF

                IF USED("cursor_4c_OperLPick")
                    USE IN cursor_4c_OperLPick
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.ValidarOperL")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarDescricoes - equivalente ao inicdesc(pcDado) do legado
    *   "1" = Origem, "2" = Destino, "3" = Juros, "4" = Terceiro
    *   Vazio/ausente = todos. Preenche o textbox de descricao a partir do
    *   codigo ja digitado; codigo vazio LIMPA a descricao (igual ao legado).
    *--------------------------------------------------------------------------
    PROCEDURE IniciarDescricoes(par_cDado)
        LOCAL loc_cDado, loc_oPg2
        TRY
            loc_cDado = IIF(VARTYPE(par_cDado) = "C", ALLTRIM(par_cDado), "")
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2

            IF EMPTY(loc_cDado) OR loc_cDado = "1"
                loc_oPg2.txt_4c_DGrupoOs.Value = THIS.ObterDescricaoGrupo(loc_oPg2.txt_4c_GrupoOs.Value)
                loc_oPg2.txt_4c_DCONTAOs.Value = THIS.ObterDescricaoConta(loc_oPg2.txt_4c_ContaOs.Value)
            ENDIF

            IF EMPTY(loc_cDado) OR loc_cDado = "2"
                loc_oPg2.txt_4c_DGrupoDs.Value = THIS.ObterDescricaoGrupo(loc_oPg2.txt_4c_GrupoDs.Value)
                loc_oPg2.txt_4c_DCONTADs.Value = THIS.ObterDescricaoConta(loc_oPg2.txt_4c_ContaDs.Value)
            ENDIF

            IF EMPTY(loc_cDado) OR loc_cDado = "3"
                loc_oPg2.txt_4c_DGruJuro.Value = THIS.ObterDescricaoGrupo(loc_oPg2.txt_4c_GruJuro.Value)
                loc_oPg2.txt_4c_DJuro.Value    = THIS.ObterDescricaoConta(loc_oPg2.txt_4c_ConJuro.Value)
            ENDIF

            IF EMPTY(loc_cDado) OR loc_cDado = "4"
                loc_oPg2.txt_4c_DGrupoT.Value = THIS.ObterDescricaoGrupo(loc_oPg2.txt_4c_GrupoT.Value)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.IniciarDescricoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Busca pela DESCRICAO (modo 'D' do legado)
    *   No legado cada campo de descricao tem Valid proprio:
    *     Get_dGrupo*  -> fAcessoContab(..., 'D', ...)  (SigCdGcr.Descrs)
    *     Get_DCONTA*  -> fAcessoContas(..., 'D', ...)  (SigCdCli.Rclis)
    *   e um When que so libera o campo em INSERIR/ALTERAR com o campo de CODIGO
    *   vazio. A migracao tinha deixado esses campos ReadOnly e sem handler, logo
    *   nao havia como localizar grupo/conta pelo nome (Erro207).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDGrupoT()
        THIS.ResolverPorDescricao("txt_4c_GrupoT", "txt_4c_DGrupoT", ;
            "cursor_4c_DGrupoTPick", "Grupo Terceiro", .T.)
    ENDPROC

    PROCEDURE ValidarDGrupoOs()
        THIS.ResolverPorDescricao("txt_4c_GrupoOs", "txt_4c_DGrupoOs", ;
            "cursor_4c_DGrupoOsPick", "Grupo Origem", .T.)
    ENDPROC

    PROCEDURE ValidarDGrupoDs()
        THIS.ResolverPorDescricao("txt_4c_GrupoDs", "txt_4c_DGrupoDs", ;
            "cursor_4c_DGrupoDsPick", "Grupo Destino", .T.)
    ENDPROC

    PROCEDURE ValidarDGruJuro()
        THIS.ResolverPorDescricao("txt_4c_GruJuro", "txt_4c_DGruJuro", ;
            "cursor_4c_DGruJuroPick", "Grupo Juros", .T.)
    ENDPROC

    PROCEDURE ValidarDContaOs()
        THIS.ResolverPorDescricao("txt_4c_ContaOs", "txt_4c_DCONTAOs", ;
            "cursor_4c_DContaOsPick", "Conta Origem", .F.)
    ENDPROC

    PROCEDURE ValidarDContaDs()
        THIS.ResolverPorDescricao("txt_4c_ContaDs", "txt_4c_DCONTADs", ;
            "cursor_4c_DContaDsPick", "Conta Destino", .F.)
    ENDPROC

    PROCEDURE ValidarDConJuro()
        THIS.ResolverPorDescricao("txt_4c_ConJuro", "txt_4c_DJuro", ;
            "cursor_4c_DConJuroPick", "Conta Juros", .F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverPorDescricao - corpo unico da busca por descricao.
    *   par_lGrupo = .T. consulta SigCdGcr (codigos/descrs); .F. consulta
    *   SigCdCli (Iclis/Rclis). Preenche SEMPRE os dois campos do par.
    *   Equivale ao When do legado: so age em INSERIR/ALTERAR e com o campo de
    *   CODIGO vazio - com codigo preenchido a descricao eh apenas exibicao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResolverPorDescricao(par_cTxtCod, par_cTxtDesc, ;
            par_cCursor, par_cTitulo, par_lGrupo)
        LOCAL loc_oPg2, loc_cDesc, loc_cTabela, loc_cColCod, loc_cColDesc
        LOCAL loc_oLookup, loc_lProsseguir
        loc_lProsseguir = .T.

        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !EMPTY(ALLTRIM(EVALUATE("loc_oPg2." + par_cTxtCod + ".Value")))
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cDesc = ALLTRIM(EVALUATE("loc_oPg2." + par_cTxtDesc + ".Value"))
                IF EMPTY(loc_cDesc)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cTabela  = IIF(par_lGrupo, "SigCdGcr", "SigCdCli")
                loc_cColCod  = IIF(par_lGrupo, "codigos", "Iclis")
                loc_cColDesc = IIF(par_lGrupo, "descrs", "Rclis")

                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, loc_cTabela, par_cCursor, ;
                    loc_cColDesc, loc_cDesc, par_cTitulo)

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna(loc_cColDesc, "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.mAddColuna(loc_cColCod, "", "C" + CHR(243) + "digo")
                        loc_oLookup.Show()
                    ENDIF

                    IF loc_oLookup.this_lSelecionou AND USED(par_cCursor)
                        IF RECCOUNT(par_cCursor) > 0
                            SELECT (par_cCursor)
                            STORE ALLTRIM(EVALUATE(par_cCursor + "." + loc_cColCod)) ;
                                TO ("loc_oPg2." + par_cTxtCod + ".Value")
                            STORE ALLTRIM(EVALUATE(par_cCursor + "." + loc_cColDesc)) ;
                                TO ("loc_oPg2." + par_cTxtDesc + ".Value")
                        ENDIF
                    ENDIF

                    IF USED(par_cCursor)
                        USE IN (par_cCursor)
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.ResolverPorDescricao")
        ENDTRY

        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoGrupo - Descricao do grupo contabil (SigCdGcr.descrs)
    *   Codigo vazio devolve "" - o legado LIMPA a descricao nesse caso.
    *--------------------------------------------------------------------------
    FUNCTION ObterDescricaoGrupo(par_cCodigo)
        LOCAL loc_cCod, loc_cDesc, loc_nRet
        loc_cDesc = ""
        loc_cCod  = IIF(VARTYPE(par_cCodigo) = "C", ALLTRIM(par_cCodigo), "")

        IF !EMPTY(loc_cCod)
            IF USED("cursor_4c_DescGrupo")
                USE IN cursor_4c_DescGrupo
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                EscaparSQL(loc_cCod), "cursor_4c_DescGrupo")
            IF loc_nRet > 0 AND USED("cursor_4c_DescGrupo") AND RECCOUNT("cursor_4c_DescGrupo") > 0
                SELECT cursor_4c_DescGrupo
                GO TOP
                loc_cDesc = ALLTRIM(cursor_4c_DescGrupo.descrs)
            ENDIF
            IF USED("cursor_4c_DescGrupo")
                USE IN cursor_4c_DescGrupo
            ENDIF
        ENDIF

        RETURN loc_cDesc
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterDescricaoConta - Razao social da conta (SigCdCli.Rclis)
    *--------------------------------------------------------------------------
    FUNCTION ObterDescricaoConta(par_cConta)
        LOCAL loc_cCta, loc_cDesc, loc_nRet
        loc_cDesc = ""
        loc_cCta  = IIF(VARTYPE(par_cConta) = "C", ALLTRIM(par_cConta), "")

        IF !EMPTY(loc_cCta)
            IF USED("cursor_4c_DescConta")
                USE IN cursor_4c_DescConta
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + ;
                EscaparSQL(loc_cCta), "cursor_4c_DescConta")
            IF loc_nRet > 0 AND USED("cursor_4c_DescConta") AND RECCOUNT("cursor_4c_DescConta") > 0
                SELECT cursor_4c_DescConta
                GO TOP
                loc_cDesc = ALLTRIM(cursor_4c_DescConta.Rclis)
            ENDIF
            IF USED("cursor_4c_DescConta")
                USE IN cursor_4c_DescConta
            ENDIF
        ENDIF

        RETURN loc_cDesc
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarMoeda - LostFocus: lookup de moeda (SigCdMoe) + cotacao
    *--------------------------------------------------------------------------
    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em ValidarMoedaExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE ValidarMoeda()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarMoedaExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarMoedaExec()
        LOCAL loc_oLookup, loc_cVal, loc_oPg2, loc_nRet, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdMoe", "cursor_4c_MoedaPick", ;
                "CMoes", loc_cVal, ;
                "Moedas")

            IF VARTYPE(loc_oLookup) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !loc_oLookup.this_lSelecionou
                    *-- Colunas transcritas do legado (Get_Moeda.Valid: CMoes/DMoes).
                    *-- Sem mAddColuna o picker abre com zero colunas.
                    loc_oLookup.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oLookup.mAddColuna("DMoes", "", "Nome")
                    loc_oLookup.Show()
                    IF !loc_oLookup.this_lSelecionou
                        loc_oLookup.Release()
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_MoedaPick") AND RECCOUNT("cursor_4c_MoedaPick") > 0
                    SELECT cursor_4c_MoedaPick
                    GO TOP
                    loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_MoedaPick.CMoes)
                    *-- Legado: so busca cotacao quando a moeda tem Cotas; senao 1.
                    loc_oPg2.txt_4c_Cotacao.Value = 1
                    IF ConverterParaLogico(cursor_4c_MoedaPick.Cotas)
                        IF USED("cursor_4c_CotacaoPick")
                            USE IN cursor_4c_CotacaoPick
                        ENDIF
                        loc_nRet = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 CMoes, Valos FROM SigCdCot WHERE CMoes = " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_MoedaPick.CMoes)) + ;
                            " ORDER BY Datas DESC, Horas DESC", ;
                            "cursor_4c_CotacaoPick")
                        IF loc_nRet > 0 AND USED("cursor_4c_CotacaoPick") AND RECCOUNT("cursor_4c_CotacaoPick") > 0
                            SELECT cursor_4c_CotacaoPick
                            loc_oPg2.txt_4c_Cotacao.Value = cursor_4c_CotacaoPick.Valos
                        ENDIF
                        IF USED("cursor_4c_CotacaoPick")
                            USE IN cursor_4c_CotacaoPick
                        ENDIF
                    ENDIF
                    THIS.CotacaoLostFocus()
                ENDIF

                IF USED("cursor_4c_MoedaPick")
                    USE IN cursor_4c_MoedaPick
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.ValidarMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CotacaoLostFocus - LostFocus: recalcula ValConv = Valor / Cotacao
    *--------------------------------------------------------------------------
    PROCEDURE CotacaoLostFocus()
        LOCAL loc_oPg2, loc_nCotacao
        TRY
            loc_oPg2     = THIS.pgf_4c_Paginas.Page2
            loc_nCotacao = loc_oPg2.txt_4c_Cotacao.Value
            IF loc_nCotacao != 0
                loc_oPg2.txt_4c_ValConv.Value = ROUND(loc_oPg2.txt_4c_Valor.Value / loc_nCotacao, 2)
            ELSE
                loc_oPg2.txt_4c_ValConv.Value = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.CotacaoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoT - LostFocus: lookup de grupo terceiro (SigCdGcr)
    *--------------------------------------------------------------------------
    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em ValidarGrupoTExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE ValidarGrupoT()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoTExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarGrupoTExec()
        LOCAL loc_oLookup, loc_cVal, loc_oPg2, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoT.Value)

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdGcr", "cursor_4c_GrupoTPick", ;
                "codigos", loc_cVal, ;
                "Grupo Terceiro")

            IF VARTYPE(loc_oLookup) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !loc_oLookup.this_lSelecionou
                    *-- Colunas do picker (legado fAcessoContab: Codigo/Descricao). Sem
                    *-- mAddColuna o grid nasce com ColumnCount = 0 e a lista abre VAZIA.
                    loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.Show()
                    IF !loc_oLookup.this_lSelecionou
                        loc_oLookup.Release()
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_GrupoTPick") AND RECCOUNT("cursor_4c_GrupoTPick") > 0
                    SELECT cursor_4c_GrupoTPick
                    GO TOP
                    loc_oPg2.txt_4c_GrupoT.Value  = ALLTRIM(cursor_4c_GrupoTPick.codigos)
                    loc_oPg2.txt_4c_DGrupoT.Value = ALLTRIM(cursor_4c_GrupoTPick.descrs)
                ENDIF

                IF USED("cursor_4c_GrupoTPick")
                    USE IN cursor_4c_GrupoTPick
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.ValidarGrupoT")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterJuroCarts - Retorna tipo de juros da empresa (1=Simples, 2=Composto)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterJuroCarts()
        LOCAL loc_nJuroCarts, loc_nRet
        loc_nJuroCarts = 1

        IF USED("cursor_4c_ParamJuro")
            USE IN cursor_4c_ParamJuro
        ENDIF

        *-- SigCdPam eh tabela de parametro SINGLE-ROW: nao tem coluna emps.
        *-- O "WHERE emps = ..." inventado pelo migrador fazia o SELECT falhar,
        *-- e o fallback silencioso usava sempre juros SIMPLES.
        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 JuroCarts FROM SigCdPam", ;
            "cursor_4c_ParamJuro")

        IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ParamJuro") > 0
            SELECT cursor_4c_ParamJuro
            GO TOP
            loc_nJuroCarts = cursor_4c_ParamJuro.JuroCarts
        ENDIF

        IF USED("cursor_4c_ParamJuro")
            USE IN cursor_4c_ParamJuro
        ENDIF

        RETURN loc_nJuroCarts
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGrupoOs - LostFocus: lookup grupo contabil de origem (SigCdGcr)
    *--------------------------------------------------------------------------
    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em ValidarGrupoOsExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE ValidarGrupoOs()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoOsExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarGrupoOsExec()
        LOCAL loc_oLookup, loc_cVal, loc_oPg2, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdGcr", "cursor_4c_GrupoOsPick", ;
                "codigos", loc_cVal, ;
                "Grupo Origem")

            IF VARTYPE(loc_oLookup) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !loc_oLookup.this_lSelecionou
                    *-- Colunas do picker (legado fAcessoContab: Codigo/Descricao). Sem
                    *-- mAddColuna o grid nasce com ColumnCount = 0 e a lista abre VAZIA.
                    loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.Show()
                    IF !loc_oLookup.this_lSelecionou
                        loc_oLookup.Release()
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_GrupoOsPick") AND RECCOUNT("cursor_4c_GrupoOsPick") > 0
                    SELECT cursor_4c_GrupoOsPick
                    GO TOP
                    loc_oPg2.txt_4c_GrupoOs.Value  = ALLTRIM(cursor_4c_GrupoOsPick.codigos)
                    loc_oPg2.txt_4c_DGrupoOs.Value = ALLTRIM(cursor_4c_GrupoOsPick.descrs)
                ENDIF

                IF USED("cursor_4c_GrupoOsPick")
                    USE IN cursor_4c_GrupoOsPick
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.ValidarGrupoOs")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaOs - LostFocus: valida conta de origem (SigCdCli, filtro grupo)
    *   Legado: Get_ContaOs.Valid -> fAcessoContas(..., 'C', ...), que faz o SEEK
    *   exato e, falhando, ABRE O BROWSE. Estava ligado a "KeyPress" sem testar
    *   tecla: o aviso "Conta nao encontrada" disparava a cada caractere digitado
    *   e o usuario nunca conseguia terminar de digitar (regra #47 / Erro207).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaOs()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverConta("txt_4c_GrupoOs", "txt_4c_ContaOs", "txt_4c_DCONTAOs", ;
            "cursor_4c_ContaOsVal", "Conta Origem", .T.)
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverConta - corpo compartilhado dos tres campos de conta (Origem,
    *   Destino e Juros). Reproduz fAcessoContas em modo 'C':
    *     1) codigo vazio -> limpa SO a descricao
    *     2) SEEK exato dentro do grupo -> preenche codigo + descricao
    *     3) nao achou -> abre o picker filtrado pelo grupo
    *   NUNCA apaga o codigo digitado (regra #50).
    *   par_lAplicaJuros reproduz o trecho do legado que puxa SigCdCli.juros
    *   para a Taxa a.m. quando a conta de ORIGEM eh resolvida.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResolverConta(par_cTxtGrupo, par_cTxtConta, par_cTxtDesc, ;
            par_cCursor, par_cTitulo, par_lAplicaJuros)
        LOCAL loc_oPg2, loc_cVal, loc_cGrupo, loc_nRet, loc_lProsseguir, loc_oLookup
        LOCAL loc_cFiltro, loc_nJuros
        loc_lProsseguir = .T.
        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cVal   = ALLTRIM(EVALUATE("loc_oPg2." + par_cTxtConta + ".Value"))
            loc_cGrupo = ALLTRIM(EVALUATE("loc_oPg2." + par_cTxtGrupo + ".Value"))
            loc_nJuros = 0

            IF EMPTY(loc_cVal)
                STORE "" TO ("loc_oPg2." + par_cTxtDesc + ".Value")
                loc_lProsseguir = .F.
            ENDIF

            *-- SEEK exato dentro do grupo
            IF loc_lProsseguir
                IF USED(par_cCursor)
                    USE IN (par_cCursor)
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Iclis, Rclis, juros FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(loc_cVal) + ;
                    IIF(EMPTY(loc_cGrupo), "", " AND grupos = " + EscaparSQL(loc_cGrupo)), ;
                    par_cCursor)

                IF loc_nRet > 0 AND USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
                    SELECT (par_cCursor)
                    GO TOP
                    STORE ALLTRIM(EVALUATE(par_cCursor + ".Iclis")) TO ("loc_oPg2." + par_cTxtConta + ".Value")
                    STORE ALLTRIM(EVALUATE(par_cCursor + ".Rclis")) TO ("loc_oPg2." + par_cTxtDesc + ".Value")
                    loc_nJuros      = EVALUATE(par_cCursor + ".juros")
                    loc_lProsseguir = .F.
                ENDIF

                IF USED(par_cCursor)
                    USE IN (par_cCursor)
                ENDIF
            ENDIF

            *-- Nao achou: abre o browse, como o legado faz
            IF loc_lProsseguir
                loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", ;
                    "grupos = " + EscaparSQL(loc_cGrupo))

                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdCli", par_cCursor, ;
                    "Iclis", loc_cVal, par_cTitulo, .F., .F., loc_cFiltro)

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oLookup.mAddColuna("Rclis", "", "Nome")
                        loc_oLookup.Show()
                    ENDIF

                    IF loc_oLookup.this_lSelecionou AND USED(par_cCursor)
                        IF RECCOUNT(par_cCursor) > 0
                            SELECT (par_cCursor)
                            STORE ALLTRIM(EVALUATE(par_cCursor + ".Iclis")) TO ("loc_oPg2." + par_cTxtConta + ".Value")
                            STORE ALLTRIM(EVALUATE(par_cCursor + ".Rclis")) TO ("loc_oPg2." + par_cTxtDesc + ".Value")
                            loc_nJuros = EVALUATE(par_cCursor + ".juros")
                        ENDIF
                    ENDIF

                    IF USED(par_cCursor)
                        USE IN (par_cCursor)
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF

            *-- Legado (Get_ContaOs.Valid): juros do cadastro da conta vai p/ a taxa
            IF par_lAplicaJuros AND loc_nJuros != 0
                loc_oPg2.txt_4c_Taxa.Value = loc_nJuros
                THIS.TaxaLostFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.ResolverConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoDs - LostFocus: lookup grupo contabil de destino (SigCdGcr)
    *--------------------------------------------------------------------------
    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em ValidarGrupoDsExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE ValidarGrupoDs()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoDsExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarGrupoDsExec()
        LOCAL loc_oLookup, loc_cVal, loc_oPg2, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoDs.Value)

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdGcr", "cursor_4c_GrupoDsPick", ;
                "codigos", loc_cVal, ;
                "Grupo Destino")

            IF VARTYPE(loc_oLookup) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !loc_oLookup.this_lSelecionou
                    *-- Colunas do picker (legado fAcessoContab: Codigo/Descricao). Sem
                    *-- mAddColuna o grid nasce com ColumnCount = 0 e a lista abre VAZIA.
                    loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.Show()
                    IF !loc_oLookup.this_lSelecionou
                        loc_oLookup.Release()
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_GrupoDsPick") AND RECCOUNT("cursor_4c_GrupoDsPick") > 0
                    SELECT cursor_4c_GrupoDsPick
                    GO TOP
                    loc_oPg2.txt_4c_GrupoDs.Value  = ALLTRIM(cursor_4c_GrupoDsPick.codigos)
                    loc_oPg2.txt_4c_DGrupoDs.Value = ALLTRIM(cursor_4c_GrupoDsPick.descrs)
                ENDIF

                IF USED("cursor_4c_GrupoDsPick")
                    USE IN cursor_4c_GrupoDsPick
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.ValidarGrupoDs")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaDs - LostFocus: valida conta de destino (SigCdCli, filtro grupo)
    *   Mesmo tratamento do ValidarContaOs (legado Get_ContaDs.Valid). O legado
    *   NAO puxa juros nesta conta, so na de origem.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaDs()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverConta("txt_4c_GrupoDs", "txt_4c_ContaDs", "txt_4c_DCONTADs", ;
            "cursor_4c_ContaDsVal", "Conta Destino", .F.)
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGruJuro - LostFocus: lookup grupo contabil de juros (SigCdGcr)
    *--------------------------------------------------------------------------
    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em ValidarGruJuroExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE ValidarGruJuro()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGruJuroExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarGruJuroExec()
        LOCAL loc_oLookup, loc_cVal, loc_oPg2, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GruJuro.Value)

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdGcr", "cursor_4c_GruJuroPick", ;
                "codigos", loc_cVal, ;
                "Grupo Juros")

            IF VARTYPE(loc_oLookup) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !loc_oLookup.this_lSelecionou
                    *-- Colunas do picker (legado fAcessoContab: Codigo/Descricao). Sem
                    *-- mAddColuna o grid nasce com ColumnCount = 0 e a lista abre VAZIA.
                    loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.Show()
                    IF !loc_oLookup.this_lSelecionou
                        loc_oLookup.Release()
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_GruJuroPick") AND RECCOUNT("cursor_4c_GruJuroPick") > 0
                    SELECT cursor_4c_GruJuroPick
                    GO TOP
                    loc_oPg2.txt_4c_GruJuro.Value  = ALLTRIM(cursor_4c_GruJuroPick.codigos)
                    loc_oPg2.txt_4c_DGruJuro.Value = ALLTRIM(cursor_4c_GruJuroPick.descrs)
                ENDIF

                IF USED("cursor_4c_GruJuroPick")
                    USE IN cursor_4c_GruJuroPick
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.ValidarGruJuro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConJuro - LostFocus: valida conta de juros (SigCdCli, filtro grupo)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConJuro()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverConta("txt_4c_GruJuro", "txt_4c_ConJuro", "txt_4c_DJuro", ;
            "cursor_4c_ConJuroVal", "Conta Juros", .F.)
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * TaxaLostFocus - LostFocus: calcula TaxaDia a partir de TaxaMes
    * Composto (JuroCarts=2): TaxaDia = ((1+Taxa/100)^(1/30)-1)*100
    * Simples: TaxaDia = Taxa/30
    *--------------------------------------------------------------------------
    PROCEDURE TaxaLostFocus()
        LOCAL loc_oPg2, loc_nTaxa, loc_nTaxaDia, loc_nJuroCarts
        TRY
            loc_oPg2       = THIS.pgf_4c_Paginas.Page2
            loc_nTaxa      = loc_oPg2.txt_4c_Taxa.Value
            loc_nJuroCarts = THIS.ObterJuroCarts()

            IF loc_nJuroCarts = 2
                IF loc_nTaxa > 0
                    loc_nTaxaDia = ROUND(((1 + loc_nTaxa/100)^(1/30) - 1) * 100, 4)
                ELSE
                    loc_nTaxaDia = 0
                ENDIF
                loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(0, 0, 192)
                loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(128, 128, 128)
            ELSE
                loc_nTaxaDia = ROUND(loc_nTaxa / 30, 4)
                loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(0, 0, 192)
                loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(128, 128, 128)
            ENDIF

            loc_oPg2.txt_4c_TaxaDia.Value = loc_nTaxaDia
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.TaxaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TaxaDiaLostFocus - LostFocus: calcula TaxaMes (inverso) a partir de TaxaDia
    * Composto: TaxaMes = ((1+TaxaDia/100)^30 - 1)*100
    * Simples: TaxaMes = TaxaDia*30
    *--------------------------------------------------------------------------
    PROCEDURE TaxaDiaLostFocus()
        LOCAL loc_oPg2, loc_nTaxaDia, loc_nTaxaMes, loc_nJuroCarts
        TRY
            loc_oPg2       = THIS.pgf_4c_Paginas.Page2
            loc_nTaxaDia   = loc_oPg2.txt_4c_TaxaDia.Value
            loc_nJuroCarts = THIS.ObterJuroCarts()

            IF loc_nJuroCarts = 2
                IF loc_nTaxaDia > 0
                    loc_nTaxaMes = ROUND(((1 + loc_nTaxaDia/100)^30 - 1) * 100, 4)
                ELSE
                    loc_nTaxaMes = 0
                ENDIF
                loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(0, 0, 192)
                loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(128, 128, 128)
            ELSE
                loc_nTaxaMes = ROUND(loc_nTaxaDia * 30, 4)
                loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(0, 0, 192)
                loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(128, 128, 128)
            ENDIF

            loc_oPg2.txt_4c_Taxa.Value = loc_nTaxaMes
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.TaxaDiaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TaxaIofLostFocus - LostFocus: valida taxa IOF (nao pode ser negativa)
    *--------------------------------------------------------------------------
    PROCEDURE TaxaIofLostFocus()
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF loc_oPg2.txt_4c_TaxaIof.Value < 0
                loc_oPg2.txt_4c_TaxaIof.Value = 0
                MsgAviso("Taxa IOF n" + CHR(227) + "o pode ser negativa.", "IOF")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.TaxaIofLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBotConsultaClick - Consulta PGV: exibe resumo de cheques do lote
    *--------------------------------------------------------------------------
    PROCEDURE BtnBotConsultaClick()
        LOCAL loc_nRet, loc_cSQL, loc_cMsg, loc_nTotal, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF THIS.this_nNumLoteAtual <= 0
                MsgAviso("Salve o lote antes de consultar o PGV.", "Consulta PGV")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_PgvConsulta")
                    USE IN cursor_4c_PgvConsulta
                ENDIF

                loc_cSQL = "SELECT c.bancos, c.agencias, c.ncontas, c.ncheques," + ;
                    " ISNULL(h.valors, 0) AS valors" + ;
                    " FROM SigCcChm c" + ;
                    " LEFT JOIN SigChe h ON h.bancos=c.bancos AND h.agencias=c.agencias" + ;
                    " AND h.ncontas=c.ncontas AND h.ncheques=c.ncheques" + ;
                    " WHERE c.numlotes = " + FormatarNumeroSQL(THIS.this_nNumLoteAtual) + ;
                    " ORDER BY c.bancos, c.ncheques"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PgvConsulta")

                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_PgvConsulta") > 0
                    SELECT cursor_4c_PgvConsulta
                    loc_nTotal = RECCOUNT("cursor_4c_PgvConsulta")
                    GO TOP
                    loc_cMsg = "PGV - Lote " + LTRIM(STR(THIS.this_nNumLoteAtual)) + ;
                        " (" + LTRIM(STR(loc_nTotal)) + " cheque(s))" + CHR(13) + CHR(13)
                    SCAN
                        loc_cMsg = loc_cMsg + ;
                            ALLTRIM(cursor_4c_PgvConsulta.bancos) + "/" + ;
                            ALLTRIM(cursor_4c_PgvConsulta.ncontas) + ;
                            " Ch:" + ALLTRIM(cursor_4c_PgvConsulta.ncheques) + CHR(13)
                    ENDSCAN
                    MsgInfo(loc_cMsg, "Consulta PGV")
                ELSE
                    MsgAviso("Nenhum cheque registrado neste lote.", "Consulta PGV")
                ENDIF

                IF USED("cursor_4c_PgvConsulta")
                    USE IN cursor_4c_PgvConsulta
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnBotConsultaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCommand1Click - PGV Origem
    *   Legado (Command1.Click): exige a Conta de Origem preenchida e abre a tela
    *   SigOpCgv passando essa conta. NAO eh um picker de conta - a versao anterior
    *   abria um FormBuscaAuxiliar sobre SigCdCli, o que permitia TROCAR a conta
    *   por este botao, coisa que o legado nao faz (Erro207).
    *   SigOpCgv ainda nao foi migrada: a ausencia fica VISIVEL em vez de ser
    *   substituida por um comportamento diferente em silencio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCommand1Click()
        LOCAL loc_oPg2, loc_cConta
        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value)

            IF EMPTY(loc_cConta)
                MsgAviso(CHR(201) + " necess" + CHR(225) + "rio selecionar a Conta de terceiro...", ;
                    "PGV")
            ELSE
                IF INLIST(THIS.this_cModoAtual, "VISUALIZAR", "INCLUIR", "ALTERAR")
                    MsgAviso("Tela de PGV (SigOpCgv) ainda n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                        "PGV")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnCommand1Click")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCommand2Click - PGV Destino
    *   Espelho do BtnCommand1Click sobre a Conta de Destino (legado Command2.Click).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCommand2Click()
        LOCAL loc_oPg2, loc_cConta
        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContaDs.Value)

            IF EMPTY(loc_cConta)
                MsgAviso(CHR(201) + " necess" + CHR(225) + "rio selecionar a Conta de terceiro...", ;
                    "PGV")
            ELSE
                IF INLIST(THIS.this_cModoAtual, "VISUALIZAR", "INCLUIR", "ALTERAR")
                    MsgAviso("Tela de PGV (SigOpCgv) ainda n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                        "PGV")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnCommand2Click")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCommand3Click - Historico: exibe audit log do lote
    *--------------------------------------------------------------------------
    PROCEDURE BtnCommand3Click()
        LOCAL loc_nRet, loc_cSQL, loc_cMsg, loc_nLote, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_nLote = THIS.this_nNumLoteAtual

            IF loc_nLote <= 0
                MsgAviso("Nenhum lote selecionado.", "Hist" + CHR(243) + "rico")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_Hist")
                    USE IN cursor_4c_Hist
                ENDIF

                loc_cSQL = "SELECT TOP 20 operacaos, datatrans, usuarios" + ;
                    " FROM LogAuditoria" + ;
                    " WHERE codigos = " + ;
                    FormatarNumeroSQL(loc_nLote) + ;
                    " ORDER BY datatrans DESC"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Hist")

                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_Hist") > 0
                    SELECT cursor_4c_Hist
                    GO TOP
                    loc_cMsg = "Hist" + CHR(243) + "rico - Lote " + ;
                        LTRIM(STR(loc_nLote)) + CHR(13) + CHR(13)
                    SCAN
                        loc_cMsg = loc_cMsg + ;
                            ALLTRIM(cursor_4c_Hist.operacaos) + " - " + ;
                            ALLTRIM(cursor_4c_Hist.usuarios) + CHR(13)
                    ENDSCAN
                    MsgInfo(loc_cMsg, "Hist" + CHR(243) + "rico")
                ELSE
                    MsgAviso("Nenhum hist" + CHR(243) + "rico encontrado para este lote.", ;
                        "Hist" + CHR(243) + "rico")
                ENDIF

                IF USED("cursor_4c_Hist")
                    USE IN cursor_4c_Hist
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formche.BtnCommand3Click")
        ENDTRY
    ENDPROC

ENDDEFINE


