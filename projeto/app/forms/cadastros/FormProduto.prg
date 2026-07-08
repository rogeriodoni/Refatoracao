*==============================================================================
* FormProduto.prg - Formulario de Cadastro de Produtos
* Data: 2026-04-12
* Tabela: SigCdPro | PK: cpros
* Legado: SIGCDPRO.SCX (frmcadastro)
* Fases: COMPLETO - Todas as 8 fases migradas
*        Page1 (Lista): Grade, filtros, botoes CRUD
*        Page2 (Dados): 7 abas internas, FormParaBO/BOParaForm, lookups, validacoes
*==============================================================================

DEFINE CLASS FormProduto AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Produtos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject    = .NULL.
    this_cMensagemErro      = ""

    *-- Guardias para LostFocus (evitar revalidacao duplicada)
    this_cUltCgrus          = ""    && Ultimo cgrus validado (grupo)
    this_cUltIfors          = ""    && Ultimo ifors validado (fornecedor)
    this_cUltCodcors        = ""    && Ultimo codcors validado (cor)
    this_cUltCodacbs        = ""    && Ultimo codacbs validado (acabamento)
    this_cUltColecoes       = ""    && Ultimo colecoes validado (colecao)
    this_cUltLinhas          = ""    && Ultimo linhas validado (linha)
    this_cUltCunis          = ""    && Ultimo cunis validado (unidade)
    this_cUltCunips         = ""    && Ultimo cunips validado (unidade peso)
    this_cUltMoeda          = ""    && Ultimo moedas validado
    this_cUltClassFiscal    = ""    && Ultimo clfiscals validado
    this_cUltOrganizacao    = ""    && Ultimo cvens validado
    this_cUltIcm            = ""    && Ultimo sittricms validado
    this_cUltContaCC        = ""    && Ultimo contaccus validado
    this_cUltGrupoCC        = ""    && Ultimo gruccus validado
    this_cUltGarra          = ""    && Ultimo codgarras validado
    this_cUltTptribs        = ""    && Ultimo tptribs validado
    this_cUltFiltroGru      = ""    && Ultimo filtro grupo validado
    this_cUltConquilha      = ""    && Ultimo conquilha validado
    this_cUltCorFas         = ""    && Ultimo cor fassonista validado
    this_cUltAcbFas         = ""    && Ultimo acabamento fassonista validado
    this_cUltTamFas         = ""    && Ultimo tamanho fassonista validado
    this_cUltGrupo          = ""    && Ultimo grupo validado (filtro Page1)

    *-- Guardias para LostFocus de composicao e campos fiscais descritivos
    this_cUltimoTabCompo_DescLostFocusValidado    = ""
    this_cUltimoTabCompo_MatPLostFocusValidado    = ""
    this_cUltimoTabCompo_DesccpLostFocusValidado  = ""
    this_cUltimoTabCompo_MatsubLostFocusValidado  = ""
    this_cUltimoTabCompo_CmkpcLostFocusValidado   = ""
    this_cUltimoTabCompo_MoedaLostFocusValidado   = ""
    this_cUltimoTabCompo_FtioLostFocusValidado    = ""
    this_cUltimoTabCompo_MoepvLostFocusValidado   = ""
    this_cUltimoTabCompo_MoevLostFocusValidado    = ""
    this_cUltimoTabCompo_MoecLostFocusValidado    = ""
    this_cUltimoTabCompo_MoecusfLostFocusValidado = ""
    this_cUltimoValidarDgruccusValidado           = ""
    this_cUltimoValidarDcontaccusValidado         = ""
    this_cUltimoValidarDclfiscalValidado          = ""
    this_cUltimoValidarDorigmercValidado          = ""
    this_cUltimoValidarDsittricmsValidado         = ""

    *-- Guardias LostFocus para campos de codigo (evitar lookup repetido)
    this_cUltimoValidarGruccusValidado            = ""
    this_cUltimoValidarContaccusValidado          = ""
    this_cUltimoValidarClfiscalValidado           = ""
    this_cUltimoValidarOrigmercValidado           = ""
    this_cUltimoValidarSittricmsValidado          = ""
    this_cUltimoValidarCodServsValidado           = ""
    this_cUltimoValidarTptribsValidado            = ""
    this_cUltimoValidarMoedaEstimadaValidado      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Guard: evitar loops de SQL durante validacao UI
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                gb_4c_ValidandoUI = .F.
            ENDIF

            *-- Criar instancia do Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MsgErro("Erro ao criar Business Object ProdutoBO", "FormProduto.InicializarForm")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Se falhar ao carregar, nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal (2 paginas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 660
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption  = "Lista"
            .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption  = "Dados"
            .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista de Produtos)
    * Compensacao +29: Top_legado + 29
    * Grid legado: Grade top=173, left=38, width=922, height=409
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Produtos"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op: Left=542 no legado, Top=0 -> 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 380
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida separado (Left=917, Top=29)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container de filtros (cntFiltros legado: continha getCgru/getDgru/getDtIni/Fim/optFilSituas)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 120
            .Left        = 12
            .Width       = 940
            .Height      = 55
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Filtro: Label Grupo
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
            .Caption   = "Grupo:"
            .Left      = 5
            .Top       = 8
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Filtro: Codigo do grupo
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroCgru", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru
            .Value         = ""
            .Left          = 47
            .Top           = 3
            .Width         = 35
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "KeyPress", THIS, "FiltroGrupo_KeyPress")
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "KeyPress", THIS, "ValidarFiltroGrupo")

        *-- Filtro: Descricao do grupo (leitura)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDgru", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDgru
            .Value         = ""
            .Left          = 84
            .Top           = 3
            .Width         = 156
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Filtro: Label Ultima alteracao
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData
            .Caption   = "Ult. Alt.:"
            .Left      = 248
            .Top       = 8
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Filtro: Data Inicio
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDataIni", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDataIni
            .Value         = {}
            .Left          = 302
            .Top           = 3
            .Width         = 80
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Filtro: Label "ate"
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblAte", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblAte
            .Caption   = "at" + CHR(233) + ":"
            .Left      = 386
            .Top       = 8
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Filtro: Data Fim
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDataFim", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDataFim
            .Value         = {}
            .Left          = 410
            .Top           = 3
            .Width         = 80
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Filtro: Situacao (Todos/Ativos/Inativos) - legado: optFilSituas
        loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_FiltraSituas", "OptionGroup")
        WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
            .Left        = 500
            .Top         = 3
            .Width       = 200
            .Height      = 25
            .ButtonCount = 3
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
            .Buttons(1).Caption   = "Todos"
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).Themes    = .F.
            .Buttons(1).FontName  = "Tahoma"
            .Buttons(1).FontSize  = 8
            .Buttons(2).Caption   = "Ativos"
            .Buttons(2).Left      = 65
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).Themes    = .F.
            .Buttons(2).FontName  = "Tahoma"
            .Buttons(2).FontSize  = 8
            .Buttons(3).Caption   = "Inativos"
            .Buttons(3).Left      = 130
            .Buttons(3).Top       = 0
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).Themes    = .F.
            .Buttons(3).FontName  = "Tahoma"
            .Buttons(3).FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas, "InteractiveChange", THIS, "FiltroSituas_InteractiveChange")

        *-- Botao Pesquisar
        loc_oPagina.cnt_4c_Filtros.AddObject("cmd_4c_Pesquisar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar
            .Caption         = "Pesquisar"
            .Left            = 708
            .Top             = 2
            .Width           = 75
            .Height          = 22
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar, "Click", THIS, "BtnPesquisarClick")

        *-- Label contador de produtos (legado: lblProdutos top=584)
        loc_oPagina.AddObject("lbl_4c_ContadorProdutos", "Label")
        WITH loc_oPagina.lbl_4c_ContadorProdutos
            .Caption   = "0 produto(s)"
            .Top       = 583
            .Left      = 38
            .Width     = 200
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Grid de lista (Grade: top=173, left=38, width=922, height=409)
        *-- 7 colunas: cpros, dpros, cgrus, sgrus, reffs, usuaalts, situacao
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 182
            .Left              = 12
            .Width             = 940
            .Height            = 395
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .ColumnCount       = 7
            .AllowHeaderSizing = .T.
            .Visible           = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdLista_DblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
    * Legado: Optiongroup1 top=5->34, pgframeDados top=-54->-54
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Grupo_Salva: Confirmar + Cancelar (legado: Top=5, Left=842, Height=85)
        *-- Compensacao +29 para Page2: Top=5+29=34
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 34
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (legado: Salva, Top=5, Left=5)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 1
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (legado: Left=80, Top=5)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 1
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Verdana"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- OptionGroup para navegacao entre abas internas
        *-- Legado: Optiongroup1 Top=5, Left=5, Width=535, Height=85, ButtonCount=7
        *-- Compensacao +29: Top=5+29=34
        *-- Style=1 (graphical buttons com icone), Comic Sans MS Bold Italic
        loc_oPagina.AddObject("opt_4c_Abas", "OptionGroup")
        WITH loc_oPagina.opt_4c_Abas
            .Left        = 5
            .Top         = 34
            .Width       = 535
            .Height      = 85
            .ButtonCount = 7
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Abas
            *-- Btn 1: Principal (Left=5, Top=5)
            .Buttons(1).Caption   = "Principal"
            .Buttons(1).Style     = 1
            .Buttons(1).Picture   = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 5
            .Buttons(1).Width     = 75
            .Buttons(1).Height    = 75
            .Buttons(1).FontName  = "Comic Sans MS"
            .Buttons(1).FontSize  = 8
            .Buttons(1).FontBold  = .T.
            .Buttons(1).FontItalic = .T.
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).WordWrap  = .F.
            .Buttons(1).SpecialEffect = 0
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).BackColor = RGB(255, 255, 255)
            .Buttons(1).Themes    = .F.
            *-- Btn 2: Componente (Left=80, Top=5)
            .Buttons(2).Caption   = "Componente"
            .Buttons(2).Style     = 1
            .Buttons(2).Picture   = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(2).Left      = 80
            .Buttons(2).Top       = 5
            .Buttons(2).Width     = 75
            .Buttons(2).Height    = 75
            .Buttons(2).FontName  = "Comic Sans MS"
            .Buttons(2).FontSize  = 8
            .Buttons(2).FontBold  = .T.
            .Buttons(2).FontItalic = .T.
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).WordWrap  = .F.
            .Buttons(2).SpecialEffect = 0
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).BackColor = RGB(255, 255, 255)
            .Buttons(2).Themes    = .F.
            *-- Btn 3: Custo (Left=380, Top=5) - NOTA: ordem visual diferente da logica
            .Buttons(3).Caption   = "Custo"
            .Buttons(3).Style     = 1
            .Buttons(3).Picture   = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .Buttons(3).Left      = 380
            .Buttons(3).Top       = 5
            .Buttons(3).Width     = 75
            .Buttons(3).Height    = 75
            .Buttons(3).FontName  = "Comic Sans MS"
            .Buttons(3).FontSize  = 8
            .Buttons(3).FontBold  = .T.
            .Buttons(3).FontItalic = .T.
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).WordWrap  = .F.
            .Buttons(3).SpecialEffect = 0
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).BackColor = RGB(255, 255, 255)
            .Buttons(3).Themes    = .F.
            *-- Btn 4: Fiscal (Left=155, Top=5)
            .Buttons(4).Caption   = "Fiscal"
            .Buttons(4).Style     = 1
            .Buttons(4).Picture   = gc_4c_CaminhoIcones + "geral_nota_60.jpg"
            .Buttons(4).Left      = 155
            .Buttons(4).Top       = 5
            .Buttons(4).Width     = 75
            .Buttons(4).Height    = 75
            .Buttons(4).FontName  = "Comic Sans MS"
            .Buttons(4).FontSize  = 8
            .Buttons(4).FontBold  = .T.
            .Buttons(4).FontItalic = .T.
            .Buttons(4).AutoSize  = .F.
            .Buttons(4).WordWrap  = .F.
            .Buttons(4).SpecialEffect = 0
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(4).BackColor = RGB(255, 255, 255)
            .Buttons(4).Themes    = .F.
            *-- Btn 5: Designer (Left=230, Top=5) - Page5=Designer
            .Buttons(5).Caption   = "Designer"
            .Buttons(5).Style     = 1
            .Buttons(5).Picture   = gc_4c_CaminhoIcones + "geral_cores_60.jpg"
            .Buttons(5).Left      = 230
            .Buttons(5).Top       = 5
            .Buttons(5).Width     = 75
            .Buttons(5).Height    = 75
            .Buttons(5).FontName  = "Comic Sans MS"
            .Buttons(5).FontSize  = 8
            .Buttons(5).FontBold  = .T.
            .Buttons(5).FontItalic = .T.
            .Buttons(5).AutoSize  = .F.
            .Buttons(5).WordWrap  = .F.
            .Buttons(5).SpecialEffect = 0
            .Buttons(5).ForeColor = RGB(90, 90, 90)
            .Buttons(5).BackColor = RGB(255, 255, 255)
            .Buttons(5).Themes    = .F.
            *-- Btn 6: Consulta (Left=305, Top=5) - Page6=Consulta
            .Buttons(6).Caption   = "Consulta"
            .Buttons(6).Style     = 1
            .Buttons(6).Picture   = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
            .Buttons(6).Left      = 305
            .Buttons(6).Top       = 5
            .Buttons(6).Width     = 75
            .Buttons(6).Height    = 75
            .Buttons(6).FontName  = "Comic Sans MS"
            .Buttons(6).FontSize  = 8
            .Buttons(6).FontBold  = .T.
            .Buttons(6).FontItalic = .T.
            .Buttons(6).AutoSize  = .F.
            .Buttons(6).WordWrap  = .F.
            .Buttons(6).SpecialEffect = 0
            .Buttons(6).ForeColor = RGB(90, 90, 90)
            .Buttons(6).BackColor = RGB(255, 255, 255)
            .Buttons(6).Themes    = .F.
            *-- Btn 7: Fases (Left=380, Top=5) - Page7=Fases
            .Buttons(7).Caption   = "Fases"
            .Buttons(7).Style     = 1
            .Buttons(7).Picture   = gc_4c_CaminhoIcones + "geral_cronometro_60.jpg"
            .Buttons(7).Left      = 380
            .Buttons(7).Top       = 5
            .Buttons(7).Width     = 75
            .Buttons(7).Height    = 75
            .Buttons(7).FontName  = "Comic Sans MS"
            .Buttons(7).FontSize  = 8
            .Buttons(7).FontBold  = .T.
            .Buttons(7).FontItalic = .T.
            .Buttons(7).AutoSize  = .F.
            .Buttons(7).WordWrap  = .F.
            .Buttons(7).ForeColor = RGB(90, 90, 90)
            .Buttons(7).BackColor = RGB(255, 255, 255)
            .Buttons(7).Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Abas, "InteractiveChange", THIS, "OpcaoAbasChange")

        *-- PageFrame interno (pgframeDados legado: top=-54, left=-1, width=1003, height=656)
        *-- Tabs=.F. para ocultar abas (navegacao pelo OptionGroup)
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        WITH loc_oPagina.pgf_4c_Dados
            .Top       = -54
            .Left      = -1
            .Width     = 1003
            .Height    = 685
            .PageCount = 7
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption  = "Principal"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page2.Caption  = "Composicao"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page3.Caption  = "Custos"
            .Page3.BackColor = RGB(255, 255, 255)
            .Page4.Caption  = "Dados Fiscais"
            .Page4.BackColor = RGB(255, 255, 255)
            .Page5.Caption  = "Designer"
            .Page5.BackColor = RGB(255, 255, 255)
            .Page6.Caption  = "Consulta"
            .Page6.BackColor = RGB(255, 255, 255)
            .Page7.Caption  = "Fases"
            .Page7.BackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Configurar conteudo de cada aba
        THIS.ConfigurarTabPrincipal()
        THIS.ConfigurarTabComposicao()
        THIS.ConfigurarTabCustos()
        THIS.ConfigurarTabDadosFiscais()
        THIS.ConfigurarPgpgDadosFiscais()
        THIS.ConfigurarTabDesigner()
        THIS.ConfigurarPgpgDesigner()
        THIS.ConfigurarTabConsulta()
        THIS.ConfigurarTabFases()

        *-- Z-ORDER: Trazer OptionGroup e botoes para frente do PageFrame interno
        *-- O pgf_4c_Dados (ultimo AddObject) cobre tudo - ZOrder(0) traz para frente
        loc_oPagina.opt_4c_Abas.ZOrder(0)
        loc_oPagina.cnt_4c_BotoesDados.ZOrder(0)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTabPrincipal - Aba 1: Dados principais do produto (pgDados)
    * Legado: pgframeDados.pgDados (167 controles)
    * Posicoes direto do layout.json (sem compensacao - dentro de pgf_4c_Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTabPrincipal()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- Botao Pesquisa (legado: cmdProduto, Top=33, Left=623, Width=85, Height=85)
        loc_oPg.AddObject("cmd_4c_Pesquisa", "CommandButton")
        WITH loc_oPg.cmd_4c_Pesquisa
            .Caption         = "Pesquisa"
            .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
            .PicturePosition = 1
            .Width           = 75
            .Height          = 75
            .Left            = 628
            .Top             = 38
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_Pesquisa, "Click", THIS, "BtnPesquisaProdutoClick")

        *-- Botao Arquivos (legado: cmdArquivos, Top=33, Left=698, Width=85, Height=85)
        loc_oPg.AddObject("cmd_4c_Arquivos", "CommandButton")
        WITH loc_oPg.cmd_4c_Arquivos
            .Caption         = "Arquivos"
            .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
            .PicturePosition = 1
            .Width           = 75
            .Height          = 75
            .Left            = 703
            .Top             = 38
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_Arquivos, "Click", THIS, "BtnArquivosProdutoClick")

        *-- === CODIGO e DESCRICAO =============================================

        loc_oPg.AddObject("lbl_4c_LblCpros", "Label")
        WITH loc_oPg.lbl_4c_LblCpros
            .Caption = "Produto :"
            .Top = 134
            .Left = 58
            .Width = 53
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPg.txt_4c_Cpros
            .Value = ""
            .Top = 130
            .Left = 113
            .Width = 108
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 14
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDpros", "Label")
        WITH loc_oPg.lbl_4c_LblDpros
            .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top = 134
            .Left = 222
            .Width = 70
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dpros", "TextBox")
        WITH loc_oPg.txt_4c_Dpros
            .Value = ""
            .Top = 130
            .Left = 222
            .Width = 290
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 65
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDpro2s", "Label")
        WITH loc_oPg.lbl_4c_LblDpro2s
            .Caption = "Descritivo :"
            .Top = 158
            .Left = 55
            .Width = 56
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dpro2s", "TextBox")
        WITH loc_oPg.txt_4c_Dpro2s
            .Value = ""
            .Top = 154
            .Left = 113
            .Width = 399
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 45
        ENDWITH

        *-- === GRUPO / SUBGRUPO ===============================================

        loc_oPg.AddObject("lbl_4c_LblCgrus", "Label")
        WITH loc_oPg.lbl_4c_LblCgrus
            .Caption = "Grupo :"
            .Top = 182
            .Left = 73
            .Width = 38
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cgrus", "TextBox")
        WITH loc_oPg.txt_4c_Cgrus
            .Value = ""
            .Top = 178
            .Left = 113
            .Width = 31
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TabPrincipal_CgruKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TabPrincipal_CgruLostFocus")

        loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
        WITH loc_oPg.txt_4c_Dgrus
            .Value = ""
            .Top = 178
            .Left = 145
            .Width = 171
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblSgrus", "Label")
        WITH loc_oPg.lbl_4c_LblSgrus
            .Caption = "Subgrupo :"
            .Top = 206
            .Left = 56
            .Width = 55
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Csgrus", "TextBox")
        WITH loc_oPg.txt_4c_Csgrus
            .Value = ""
            .Top = 202
            .Left = 113
            .Width = 52
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 6
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dsgrus", "TextBox")
        WITH loc_oPg.txt_4c_Dsgrus
            .Value = ""
            .Top = 202
            .Left = 166
            .Width = 150
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        *-- === LINHA / COLECAO ================================================

        loc_oPg.AddObject("lbl_4c_LblLinhas", "Label")
        WITH loc_oPg.lbl_4c_LblLinhas
            .Caption = "Linha :"
            .Top = 230
            .Left = 77
            .Width = 34
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Linhas", "TextBox")
        WITH loc_oPg.txt_4c_Linhas
            .Value = ""
            .Top = 226
            .Left = 113
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 10
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Linhas, "KeyPress", THIS, "TabPrincipal_LinhasKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Linhas, "KeyPress", THIS, "TabPrincipal_LinhasLostFocus")

        loc_oPg.AddObject("txt_4c_Dlinhas", "TextBox")
        WITH loc_oPg.txt_4c_Dlinhas
            .Value = ""
            .Top = 226
            .Left = 194
            .Width = 318
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblColecoes", "Label")
        WITH loc_oPg.lbl_4c_LblColecoes
            .Caption = "Grupo de Venda :"
            .Top = 253
            .Left = 25
            .Width = 86
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Colecoes", "TextBox")
        WITH loc_oPg.txt_4c_Colecoes
            .Value = ""
            .Top = 250
            .Left = 113
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 10
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Colecoes, "KeyPress", THIS, "TabPrincipal_ColecoesKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Colecoes, "KeyPress", THIS, "TabPrincipal_ColecoesLostFocus")

        loc_oPg.AddObject("txt_4c_Dcolecoes", "TextBox")
        WITH loc_oPg.txt_4c_Dcolecoes
            .Value = ""
            .Top = 250
            .Left = 194
            .Width = 318
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        *-- === FORNECEDOR / REF ==============================================

        loc_oPg.AddObject("lbl_4c_LblIfors", "Label")
        WITH loc_oPg.lbl_4c_LblIfors
            .Caption = "Fornecedor :"
            .Top = 278
            .Left = 47
            .Width = 64
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
        WITH loc_oPg.txt_4c_Ifors
            .Value = ""
            .Top = 274
            .Left = 113
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 10
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "TabPrincipal_IforsKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "TabPrincipal_IforsLostFocus")

        loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
        WITH loc_oPg.txt_4c_Dfors
            .Value = ""
            .Top = 274
            .Left = 194
            .Width = 318
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblReffs", "Label")
        WITH loc_oPg.lbl_4c_LblReffs
            .Caption = "Ref. Fornecedor :"
            .Top = 301
            .Left = 23
            .Width = 88
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
        WITH loc_oPg.txt_4c_Reffs
            .Value = ""
            .Top = 298
            .Left = 113
            .Width = 152
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 40
        ENDWITH

        *-- === CODIGOS AUX (Tipo/Identificador/Conjunto) =====================

        loc_oPg.AddObject("lbl_4c_LblMercs", "Label")
        WITH loc_oPg.lbl_4c_LblMercs
            .Caption = "Tipo :"
            .Top = 182
            .Left = 324
            .Width = 30
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Mercs", "TextBox")
        WITH loc_oPg.txt_4c_Mercs
            .Value = ""
            .Top = 178
            .Left = 318
            .Width = 31
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblIdecpros", "Label")
        WITH loc_oPg.lbl_4c_LblIdecpros
            .Caption = "Identificador :"
            .Top = 182
            .Left = 408
            .Width = 70
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Idecpros", "TextBox")
        WITH loc_oPg.txt_4c_Idecpros
            .Value = ""
            .Top = 178
            .Left = 481
            .Width = 31
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblConj", "Label")
        WITH loc_oPg.lbl_4c_LblConj
            .Caption = "Conjunto :"
            .Top = 206
            .Left = 408
            .Width = 53
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Conjunts", "TextBox")
        WITH loc_oPg.txt_4c_Conjunts
            .Value = ""
            .Top = 202
            .Left = 460
            .Width = 52
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 6
        ENDWITH

        *-- === COLUNA DIREITA: EQUIVALENTE / BARRA / EAN ====================

        loc_oPg.AddObject("lbl_4c_LblCproeqs", "Label")
        WITH loc_oPg.lbl_4c_LblCproeqs
            .Caption = "Equivalente :"
            .Top = 137
            .Left = 560
            .Width = 65
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cproeqs", "TextBox")
        WITH loc_oPg.txt_4c_Cproeqs
            .Value = ""
            .Top = 133
            .Left = 626
            .Width = 108
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 14
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cproeqs, "KeyPress", THIS, "TabPrincipal_CproeqsKeyPress")

        loc_oPg.AddObject("lbl_4c_LblCbars", "Label")
        WITH loc_oPg.lbl_4c_LblCbars
            .Caption = "Barra :"
            .Top = 157
            .Left = 590
            .Width = 35
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cbars", "TextBox")
        WITH loc_oPg.txt_4c_Cbars
            .Value = 0
            .Top = 155
            .Left = 626
            .Width = 108
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblEan13", "Label")
        WITH loc_oPg.lbl_4c_LblEan13
            .Caption = "EAN/GTIN :"
            .Top = 181
            .Left = 568
            .Width = 57
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Ean13", "TextBox")
        WITH loc_oPg.txt_4c_Ean13
            .Value = 0
            .Top = 177
            .Left = 626
            .Width = 108
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        *-- === SITUACAO / DATA SITUACAO ======================================

        loc_oPg.AddObject("opt_4c_Situas", "OptionGroup")
        WITH loc_oPg.opt_4c_Situas
            .Top = 130
            .Left = 735
            .Width = 142
            .Height = 25
            .ButtonCount = 2
            .BorderStyle = 0
            .Themes = .F.
            .Value = 1
        ENDWITH
        WITH loc_oPg.opt_4c_Situas
            .Buttons(1).Caption = "Ativo"
            .Buttons(1).Left = 0
            .Buttons(1).Top = 0
            .Buttons(1).AutoSize = .T.
            .Buttons(1).Themes = .F.
            .Buttons(1).FontName = "Tahoma"
            .Buttons(1).FontSize = 8
            .Buttons(2).Caption = "Inativo"
            .Buttons(2).Left = 60
            .Buttons(2).Top = 0
            .Buttons(2).AutoSize = .T.
            .Buttons(2).Themes = .F.
            .Buttons(2).FontName = "Tahoma"
            .Buttons(2).FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")

        loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
        WITH loc_oPg.txt_4c_DtSituas
            .Value = {}
            .Top = 132
            .Left = 878
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        *-- === LOTE MINIMO ===================================================

        loc_oPg.AddObject("lbl_4c_LblLtmins", "Label")
        WITH loc_oPg.lbl_4c_LblLtmins
            .Caption = "Lote M" + CHR(237) + "nimo :"
            .Top = 157
            .Left = 812
            .Width = 65
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Ltminsv", "TextBox")
        WITH loc_oPg.txt_4c_Ltminsv
            .Value = 0
            .Top = 154
            .Left = 878
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        *-- === COLUNA DIREITA MEDIA: QTDE/OBS/ESTOQUE ========================

        loc_oPg.AddObject("lbl_4c_LblQmins", "Label")
        WITH loc_oPg.lbl_4c_LblQmins
            .Caption = "Qtde. M" + CHR(237) + "nima :"
            .Top = 203
            .Left = 553
            .Width = 72
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Qmins", "TextBox")
        WITH loc_oPg.txt_4c_Qmins
            .Value = 0
            .Top = 199
            .Left = 626
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblQtped", "Label")
        WITH loc_oPg.lbl_4c_LblQtped
            .Caption = "Qtde. Pedido :"
            .Top = 225
            .Left = 553
            .Width = 72
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Qtped", "TextBox")
        WITH loc_oPg.txt_4c_Qtped
            .Value = 0
            .Top = 221
            .Left = 626
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblObs3", "Label")
        WITH loc_oPg.lbl_4c_LblObs3
            .Caption = "Obs. Componente :"
            .Top = 247
            .Left = 529
            .Width = 96
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Obsetqs", "TextBox")
        WITH loc_oPg.txt_4c_Obsetqs
            .Value = ""
            .Top = 243
            .Left = 626
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 10
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblObs1", "Label")
        WITH loc_oPg.lbl_4c_LblObs1
            .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top = 269
            .Left = 558
            .Width = 67
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Obspeds", "TextBox")
        WITH loc_oPg.txt_4c_Obspeds
            .Value = ""
            .Top = 265
            .Left = 626
            .Width = 220
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 30
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblObs2", "Label")
        WITH loc_oPg.lbl_4c_LblObs2
            .Caption = "Complemento :"
            .Top = 290
            .Left = 551
            .Width = 74
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Obspes", "TextBox")
        WITH loc_oPg.txt_4c_Obspes
            .Value = ""
            .Top = 287
            .Left = 626
            .Width = 220
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 30
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblUltcomp", "Label")
        WITH loc_oPg.lbl_4c_LblUltcomp
            .Caption = CHR(218) + "lt.Compra :"
            .Top = 313
            .Left = 562
            .Width = 63
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dtucp", "TextBox")
        WITH loc_oPg.txt_4c_Dtucp
            .Value = {}
            .Top = 309
            .Left = 626
            .Width = 79
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Vucp", "TextBox")
        WITH loc_oPg.txt_4c_Vucp
            .Value = 0
            .Top = 309
            .Left = 706
            .Width = 106
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Mucp", "TextBox")
        WITH loc_oPg.txt_4c_Mucp
            .Value = ""
            .Top = 309
            .Left = 813
            .Width = 33
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblQtdultcomp", "Label")
        WITH loc_oPg.lbl_4c_LblQtdultcomp
            .Caption = "Qtde " + CHR(218) + "lt.Compra :"
            .Top = 335
            .Left = 535
            .Width = 90
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Qtdultcomp", "TextBox")
        WITH loc_oPg.txt_4c_Qtdultcomp
            .Value = 0
            .Top = 331
            .Left = 626
            .Width = 79
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
        WITH loc_oPg.lbl_4c_LblEstoque
            .Caption = "Estoque :"
            .Top = 357
            .Left = 577
            .Width = 48
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Estoques", "TextBox")
        WITH loc_oPg.txt_4c_Estoques
            .Value = 0
            .Top = 353
            .Left = 626
            .Width = 79
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_QtdEsts", "TextBox")
        WITH loc_oPg.txt_4c_QtdEsts
            .Value = 0
            .Top = 353
            .Left = 706
            .Width = 79
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        *-- === PRECOS / MOEDAS ===============================================

        loc_oPg.AddObject("lbl_4c_LblCtotal", "Label")
        WITH loc_oPg.lbl_4c_LblCtotal
            .Caption = "Valor de Custo :"
            .Top = 379
            .Left = 546
            .Width = 79
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Custofs", "TextBox")
        WITH loc_oPg.txt_4c_Custofs
            .Value = 0
            .Top = 375
            .Left = 626
            .Width = 127
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moecs", "TextBox")
        WITH loc_oPg.txt_4c_Moecs
            .Value = ""
            .Top = 375
            .Left = 754
            .Width = 31
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moecs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moecs, "KeyPress", THIS, "TabPrincipal_MoeLostFocus")

        loc_oPg.AddObject("lbl_4c_LblPvens", "Label")
        WITH loc_oPg.lbl_4c_LblPvens
            .Caption = "Valor de Venda :"
            .Top = 400
            .Left = 505
            .Width = 120
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
        WITH loc_oPg.txt_4c_Pvens
            .Value = 0
            .Top = 397
            .Left = 626
            .Width = 127
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moepvs", "TextBox")
        WITH loc_oPg.txt_4c_Moepvs
            .Value = ""
            .Top = 397
            .Left = 754
            .Width = 31
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moepvs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moepvs, "KeyPress", THIS, "TabPrincipal_MoeLostFocus")

        loc_oPg.AddObject("lbl_4c_LblFvendas", "Label")
        WITH loc_oPg.lbl_4c_LblFvendas
            .Caption = "Fator  de Venda :"
            .Top = 422
            .Left = 539
            .Width = 86
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Fvendas", "TextBox")
        WITH loc_oPg.txt_4c_Fvendas
            .Value = 0
            .Top = 419
            .Left = 626
            .Width = 127
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
        WITH loc_oPg.txt_4c_Moevs
            .Value = ""
            .Top = 419
            .Left = 754
            .Width = 31
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH

        *-- === AUDITORIA (ReadOnly) ==========================================

        loc_oPg.AddObject("lbl_4c_LblAuditoria", "Label")
        WITH loc_oPg.lbl_4c_LblAuditoria
            .Caption = "Data / Usu" + CHR(225) + "rio"
            .Top = 365
            .Left = 833
            .Width = 84
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblInc", "Label")
        WITH loc_oPg.lbl_4c_LblInc
            .Caption = "Inclus" + CHR(227) + "o"
            .Top = 384
            .Left = 833
            .Width = 42
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblAlt", "Label")
        WITH loc_oPg.lbl_4c_LblAlt
            .Caption = "Altera" + CHR(231) + CHR(227) + "o"
            .Top = 384
            .Left = 914
            .Width = 48
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPg.txt_4c_DtIncs
            .Value = {}
            .Top = 397
            .Left = 833
            .Width = 79
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Usuincs", "TextBox")
        WITH loc_oPg.txt_4c_Usuincs
            .Value = ""
            .Top = 419
            .Left = 833
            .Width = 79
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtAlts", "TextBox")
        WITH loc_oPg.txt_4c_DtAlts
            .Value = {}
            .Top = 397
            .Left = 914
            .Width = 79
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_UsuaAlts", "TextBox")
        WITH loc_oPg.txt_4c_UsuaAlts
            .Value = ""
            .Top = 419
            .Left = 914
            .Width = 79
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        *-- === UNIDADES ======================================================

        loc_oPg.AddObject("lbl_4c_LblCunis", "Label")
        WITH loc_oPg.lbl_4c_LblCunis
            .Caption = "Unidades (1) :"
            .Top = 398
            .Left = 41
            .Width = 70
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cunis", "TextBox")
        WITH loc_oPg.txt_4c_Cunis
            .Value = ""
            .Top = 394
            .Left = 113
            .Width = 31
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cunis, "KeyPress", THIS, "TabPrincipal_CunisKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Cunis, "KeyPress", THIS, "TabPrincipal_CunisLostFocus")

        loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
        WITH loc_oPg.txt_4c_Dunis
            .Value = ""
            .Top = 394
            .Left = 145
            .Width = 150
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblCunips", "Label")
        WITH loc_oPg.lbl_4c_LblCunips
            .Caption = "(2) :"
            .Top = 398
            .Left = 301
            .Width = 23
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cunips", "TextBox")
        WITH loc_oPg.txt_4c_Cunips
            .Value = ""
            .Top = 394
            .Left = 330
            .Width = 31
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cunips, "KeyPress", THIS, "TabPrincipal_CunipsKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Cunips, "KeyPress", THIS, "TabPrincipal_CunipsLostFocus")

        loc_oPg.AddObject("txt_4c_Dunips", "TextBox")
        WITH loc_oPg.txt_4c_Dunips
            .Value = ""
            .Top = 394
            .Left = 362
            .Width = 150
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        *-- === CLASSIFICACAO / MODELO / ACABAMENTO / LOCAL ===================

        loc_oPg.AddObject("lbl_4c_LblCclass", "Label")
        WITH loc_oPg.lbl_4c_LblCclass
            .Caption = "Classifica" + CHR(231) + CHR(227) + "o :"
            .Top = 374
            .Left = 7
            .Width = 104
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cclass", "TextBox")
        WITH loc_oPg.txt_4c_Cclass
            .Value = ""
            .Top = 370
            .Left = 113
            .Width = 31
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dclass", "TextBox")
        WITH loc_oPg.txt_4c_Dclass
            .Value = ""
            .Top = 370
            .Left = 145
            .Width = 150
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblCodfinp", "Label")
        WITH loc_oPg.lbl_4c_LblCodfinp
            .Caption = "Modelo :"
            .Top = 326
            .Left = 7
            .Width = 104
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Codfinp", "TextBox")
        WITH loc_oPg.txt_4c_Codfinp
            .Value = ""
            .Top = 322
            .Left = 113
            .Width = 31
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dcodfinp", "TextBox")
        WITH loc_oPg.txt_4c_Dcodfinp
            .Value = ""
            .Top = 322
            .Left = 145
            .Width = 150
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblCodacbs", "Label")
        WITH loc_oPg.lbl_4c_LblCodacbs
            .Caption = "Acabamento :"
            .Top = 350
            .Left = 7
            .Width = 104
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Codacbs", "TextBox")
        WITH loc_oPg.txt_4c_Codacbs
            .Value = ""
            .Top = 346
            .Left = 113
            .Width = 31
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 3
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Codacbs, "KeyPress", THIS, "TabPrincipal_CodacbsKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Codacbs, "KeyPress", THIS, "TabPrincipal_CodacbsLostFocus")

        loc_oPg.AddObject("txt_4c_Dcodacbs", "TextBox")
        WITH loc_oPg.txt_4c_Dcodacbs
            .Value = ""
            .Top = 346
            .Left = 145
            .Width = 150
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Enabled = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblLocals", "Label")
        WITH loc_oPg.lbl_4c_LblLocals
            .Caption = "Local :"
            .Top = 374
            .Left = 364
            .Width = 33
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Locals", "TextBox")
        WITH loc_oPg.txt_4c_Locals
            .Value = ""
            .Top = 370
            .Left = 401
            .Width = 111
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 10
        ENDWITH

        *-- === PESOS / COR / TAM / CODIDENT ==================================

        loc_oPg.AddObject("lbl_4c_LblPesobs", "Label")
        WITH loc_oPg.lbl_4c_LblPesobs
            .Caption = "Peso Bruto :"
            .Top = 326
            .Left = 336
            .Width = 61
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pesobs", "TextBox")
        WITH loc_oPg.txt_4c_Pesobs
            .Value = 0
            .Top = 322
            .Left = 401
            .Width = 111
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblPesoms", "Label")
        WITH loc_oPg.lbl_4c_LblPesoms
            .Caption = "Peso L" + CHR(237) + "quido :"
            .Top = 350
            .Left = 329
            .Width = 68
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pesoms", "TextBox")
        WITH loc_oPg.txt_4c_Pesoms
            .Value = 0
            .Top = 346
            .Left = 401
            .Width = 111
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblCodcors", "Label")
        WITH loc_oPg.lbl_4c_LblCodcors
            .Caption = "Padr" + CHR(227) + "o > Cor :"
            .Top = 302
            .Left = 323
            .Width = 77
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Codcors", "TextBox")
        WITH loc_oPg.txt_4c_Codcors
            .Value = ""
            .Top = 298
            .Left = 401
            .Width = 38
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 4
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Codcors, "KeyPress", THIS, "TabPrincipal_CodcorsKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Codcors, "KeyPress", THIS, "TabPrincipal_CodcorsLostFocus")

        loc_oPg.AddObject("lbl_4c_LblCodtams", "Label")
        WITH loc_oPg.lbl_4c_LblCodtams
            .Caption = "Tam:"
            .Top = 302
            .Left = 442
            .Width = 30
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Codtams", "TextBox")
        WITH loc_oPg.txt_4c_Codtams
            .Value = ""
            .Top = 298
            .Left = 474
            .Width = 38
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 4
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Codtams, "KeyPress", THIS, "TabPrincipal_CodtamsKeyPress")

        loc_oPg.AddObject("lbl_4c_LblCodident", "Label")
        WITH loc_oPg.lbl_4c_LblCodident
            .Caption = "Cod. Identidade :"
            .Top = 422
            .Left = 24
            .Width = 87
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Codident", "TextBox")
        WITH loc_oPg.txt_4c_Codident
            .Value = ""
            .Top = 418
            .Left = 113
            .Width = 182
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 20
        ENDWITH

        *-- === GARANTIA / PRODUTO WEB / VARIACAO =============================

        loc_oPg.AddObject("lbl_4c_LblDiasgar", "Label")
        WITH loc_oPg.lbl_4c_LblDiasgar
            .Caption = "Garantia :"
            .Top = 228
            .Left = 827
            .Width = 50
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Diasgar", "TextBox")
        WITH loc_oPg.txt_4c_Diasgar
            .Value = 0
            .Top = 224
            .Left = 880
            .Width = 34
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDias1", "Label")
        WITH loc_oPg.lbl_4c_LblDias1
            .Caption = "Dias"
            .Top = 228
            .Left = 918
            .Width = 22
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("chk_4c_Chkgarvit", "CheckBox")
        WITH loc_oPg.chk_4c_Chkgarvit
            .Caption = "Vital" + CHR(237) + "cia"
            .Top = 228
            .Left = 943
            .Width = 55
            .Height = 17
            .Value = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblProdweb", "Label")
        WITH loc_oPg.lbl_4c_LblProdweb
            .Caption = "Produto Web :"
            .Top = 176
            .Left = 805
            .Width = 72
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("opt_4c_ProdWeb", "OptionGroup")
        WITH loc_oPg.opt_4c_ProdWeb
            .Top = 172
            .Left = 879
            .Width = 117
            .Height = 42
            .ButtonCount = 4
            .BorderStyle = 0
            .Themes = .F.
            .Value = 1
        ENDWITH
        WITH loc_oPg.opt_4c_ProdWeb
            .Buttons(1).Caption = "N" + CHR(227) + "o"
            .Buttons(1).Left = 0 
            .Buttons(1).Top = 0
            .Buttons(1).AutoSize = .T.
            .Buttons(1).Themes = .F.
            .Buttons(1).FontName = "Tahoma"
            .Buttons(1).FontSize = 8
            .Buttons(2).Caption = "Sim"  
            .Buttons(2).Left = 35
            .Buttons(2).Top = 0
            .Buttons(2).AutoSize = .T.
            .Buttons(2).Themes = .F.
            .Buttons(2).FontName = "Tahoma"
            .Buttons(2).FontSize = 8
            .Buttons(3).Caption = "Img"  
            .Buttons(3).Left = 65
            .Buttons(3).Top = 0
            .Buttons(3).AutoSize = .T.
            .Buttons(3).Themes = .F.
            .Buttons(3).FontName = "Tahoma"
            .Buttons(3).FontSize = 8
            .Buttons(4).Caption = "Sim+Img"
            .Buttons(4).Left = 0
            .Buttons(4).Top = 22
            .Buttons(4).AutoSize = .T.
            .Buttons(4).Themes = .F.
            .Buttons(4).FontName = "Tahoma"
            .Buttons(4).FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.opt_4c_ProdWeb, "InteractiveChange", THIS, "OptProdWebChange")

        loc_oPg.AddObject("lbl_4c_LblVariacao", "Label")
        WITH loc_oPg.lbl_4c_LblVariacao
            .Caption = "Varia" + CHR(231) + CHR(227) + "o :"
            .Top = 207
            .Left = 827
            .Width = 50
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("opt_4c_Varias", "OptionGroup")
        WITH loc_oPg.opt_4c_Varias
            .Top = 203
            .Left = 874
            .Width = 107
            .Height = 22
            .ButtonCount = 2
            .BorderStyle = 0
            .Themes = .F.
            .Value = 2
        ENDWITH
        WITH loc_oPg.opt_4c_Varias
            .Buttons(1).Caption = "Sim"        
            .Buttons(1).Left = 0 
            .Buttons(1).Top = 0
            .Buttons(1).AutoSize = .T.
            .Buttons(1).Themes = .F.
            .Buttons(1).FontName = "Tahoma"
            .Buttons(1).FontSize = 8
            .Buttons(2).Caption = "N" + CHR(227) + "o"
            .Buttons(2).Left = 42
            .Buttons(2).Top = 0
            .Buttons(2).AutoSize = .T.
            .Buttons(2).Themes = .F.
            .Buttons(2).FontName = "Tahoma"
            .Buttons(2).FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.opt_4c_Varias, "InteractiveChange", THIS, "OptVariasChange")

        *-- === DIMENSOES FINAS (altura/largura/diametro/espessura/comprimento) =

        loc_oPg.AddObject("lbl_4c_LblAltura", "Label")
        WITH loc_oPg.lbl_4c_LblAltura
            .Caption = "Altura :"
            .Top = 474
            .Left = 749
            .Width = 38
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH
        loc_oPg.AddObject("txt_4c_Altura", "TextBox")
        WITH loc_oPg.txt_4c_Altura
            .Value = 0
            .Top = 471
            .Left = 791
            .Width = 48
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH
        loc_oPg.AddObject("lbl_4c_MmAltura", "Label")
        WITH loc_oPg.lbl_4c_MmAltura
            .Caption = "MM"
            .Top = 475
            .Left = 844
            .Width = 18
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblLargura", "Label")
        WITH loc_oPg.lbl_4c_LblLargura
            .Caption = "Largura :"
            .Top = 270
            .Left = 873
            .Width = 46
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH
        loc_oPg.AddObject("txt_4c_Largura", "TextBox")
        WITH loc_oPg.txt_4c_Largura
            .Value = 0
            .Top = 269
            .Left = 923
            .Width = 48
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH
        loc_oPg.AddObject("lbl_4c_MmLargura", "Label")
        WITH loc_oPg.lbl_4c_MmLargura
            .Caption = "MM"
            .Top = 271
            .Left = 976
            .Width = 18
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDiametro", "Label")
        WITH loc_oPg.lbl_4c_LblDiametro
            .Caption = "Di" + CHR(226) + "metro :"
            .Top = 293
            .Left = 867
            .Width = 52
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH
        loc_oPg.AddObject("txt_4c_Diametro", "TextBox")
        WITH loc_oPg.txt_4c_Diametro
            .Value = 0
            .Top = 291
            .Left = 923
            .Width = 48
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH
        loc_oPg.AddObject("lbl_4c_MmDiametro", "Label")
        WITH loc_oPg.lbl_4c_MmDiametro
            .Caption = "MM"
            .Top = 294
            .Left = 976
            .Width = 18
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblEspessura", "Label")
        WITH loc_oPg.lbl_4c_LblEspessura
            .Caption = "Espessura :"
            .Top = 316
            .Left = 861
            .Width = 58
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH
        loc_oPg.AddObject("txt_4c_Espessura", "TextBox")
        WITH loc_oPg.txt_4c_Espessura
            .Value = 0
            .Top = 313
            .Left = 923
            .Width = 48
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH
        loc_oPg.AddObject("lbl_4c_MmEspessura", "Label")
        WITH loc_oPg.lbl_4c_MmEspessura
            .Caption = "MM"
            .Top = 317
            .Left = 976
            .Width = 18
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblCompriment", "Label")
        WITH loc_oPg.lbl_4c_LblCompriment
            .Caption = "Comprimento :"
            .Top = 339
            .Left = 847
            .Width = 72
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH
        loc_oPg.AddObject("txt_4c_Compriment", "TextBox")
        WITH loc_oPg.txt_4c_Compriment
            .Value = 0
            .Top = 335
            .Left = 923
            .Width = 48
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH
        loc_oPg.AddObject("lbl_4c_CmCompriment", "Label")
        WITH loc_oPg.lbl_4c_CmCompriment
            .Caption = "CM"
            .Top = 340
            .Left = 976
            .Width = 17
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- === CHECKBOXES / ENTREGA / DIMENSAO / VOLUMES =====================

        loc_oPg.AddObject("lbl_4c_LblSituAb", "Label")
        WITH loc_oPg.lbl_4c_LblSituAb
            .Caption = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top = 451
            .Left = 548
            .Width = 50
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("chk_4c_Consigs", "CheckBox")
        WITH loc_oPg.chk_4c_Consigs
            .Caption = "Consigna"
            .Top = 451
            .Left = 601
            .Width = 75
            .Height = 17
            .Value = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Fabrproprs", "CheckBox")
        WITH loc_oPg.chk_4c_Fabrproprs
            .Caption = "Fabr. Pr" + CHR(243) + "pria"
            .Top = 451
            .Left = 681
            .Width = 90
            .Height = 17
            .Value = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Encoms", "CheckBox")
        WITH loc_oPg.chk_4c_Encoms
            .Caption = "Encomenda"
            .Top = 451
            .Left = 781
            .Width = 80
            .Height = 17
            .Value = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblTents", "Label")
        WITH loc_oPg.lbl_4c_LblTents
            .Caption = "Entrega :"
            .Top = 451
            .Left = 884
            .Width = 47
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Tents", "TextBox")
        WITH loc_oPg.txt_4c_Tents
            .Value = 0
            .Top = 447
            .Left = 934
            .Width = 31
            .Height = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDias2", "Label")
        WITH loc_oPg.lbl_4c_LblDias2
            .Caption = "Dias"
            .Top = 451
            .Left = 967
            .Width = 22
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDim", "Label")
        WITH loc_oPg.lbl_4c_LblDim
            .Caption = "Dimens" + CHR(227) + "o :"
            .Top = 474
            .Left = 543
            .Width = 55
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_DimA", "TextBox")
        WITH loc_oPg.txt_4c_DimA
            .Value = 0
            .Top = 470
            .Left = 601
            .Width = 58
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH
        loc_oPg.AddObject("lbl_4c_LblPpp", "Label")
        WITH loc_oPg.lbl_4c_LblPpp
            .Caption = "ppp"
            .Top = 474
            .Left = 661
            .Width = 20
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH
        loc_oPg.AddObject("txt_4c_DimB", "TextBox")
        WITH loc_oPg.txt_4c_DimB
            .Value = 0
            .Top = 470
            .Left = 688
            .Width = 58
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH
        loc_oPg.AddObject("lbl_4c_LblAaa", "Label")
        WITH loc_oPg.lbl_4c_LblAaa
            .Caption = "aaa"
            .Top = 474
            .Left = 749
            .Width = 20
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH
        loc_oPg.AddObject("txt_4c_DimC", "TextBox")
        WITH loc_oPg.txt_4c_DimC
            .Value = 0
            .Top = 470
            .Left = 776
            .Width = 58
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH
        loc_oPg.AddObject("lbl_4c_LblCcc", "Label")
        WITH loc_oPg.lbl_4c_LblCcc
            .Caption = "ccc"
            .Top = 474
            .Left = 836
            .Width = 17
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblVolumes", "Label")
        WITH loc_oPg.lbl_4c_LblVolumes
            .Caption = "Volumes :"
            .Top = 474
            .Left = 883
            .Width = 48
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Volumes", "TextBox")
        WITH loc_oPg.txt_4c_Volumes
            .Value = 0
            .Top = 470
            .Left = 934
            .Width = 31
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
        ENDWITH

        *-- === LABELS IMAGENS ================================================

        loc_oPg.AddObject("lbl_4c_LblFigJpg", "Label")
        WITH loc_oPg.lbl_4c_LblFigJpg
            .Caption = "Imagem Principal"
            .Top = 502
            .Left = 543
            .Width = 101
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH
        loc_oPg.AddObject("lbl_4c_LblFigTec", "Label")
        WITH loc_oPg.lbl_4c_LblFigTec
            .Caption = "Imagem T" + CHR(233) + "cnica"
            .Top = 502
            .Left = 775
            .Width = 96
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- === MEMO FIELDS ===================================================

        loc_oPg.AddObject("lbl_4c_LblDsccompras", "Label")
        WITH loc_oPg.lbl_4c_LblDsccompras
            .Caption = "Descri" + CHR(231) + CHR(227) + "o de : Compra ."
            .Top = 448
            .Left = 23
            .Width = 88
            .Height = 28
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .WordWrap = .T.
        ENDWITH

        loc_oPg.AddObject("edt_4c_Dsccompras", "EditBox")
        WITH loc_oPg.edt_4c_Dsccompras
            .Value = ""
            .Top = 448
            .Left = 113
            .Width = 400
            .Height = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 0
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDpro3s", "Label")
        WITH loc_oPg.lbl_4c_LblDpro3s
            .Caption = "Descri" + CHR(231) + CHR(227) + "o : Completa ."
            .Top = 507
            .Left = 23
            .Width = 88
            .Height = 28
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .WordWrap = .T.
        ENDWITH

        loc_oPg.AddObject("edt_4c_Dpro3s", "EditBox")
        WITH loc_oPg.edt_4c_Dpro3s
            .Value = ""
            .Top = 507
            .Left = 113
            .Width = 400
            .Height = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 0
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblObscompras", "Label")
        WITH loc_oPg.lbl_4c_LblObscompras
            .Caption = "Observa" + CHR(231) + CHR(227) + "o : da  Compra ."
            .Top = 566
            .Left = 23
            .Width = 88
            .Height = 28
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .WordWrap = .T.
        ENDWITH

        loc_oPg.AddObject("edt_4c_Obscompras", "EditBox")
        WITH loc_oPg.edt_4c_Obscompras
            .Value = ""
            .Top = 566
            .Left = 113
            .Width = 400
            .Height = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .MaxLength = 0
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTabComposicao - Aba 2: Composicao de materiais (pgComposicao)
    * IMPLEMENTADO NA FASE 5
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTabComposicao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        *-- GradeGRUPO (top=34, left=582, width=229, height=107, 3 cols)
        *-- Mostra totais por grupo de composicao
        loc_oPg.AddObject("grd_4c_GrupoCompo", "Grid")
        WITH loc_oPg.grd_4c_GrupoCompo
            .Top         = 34
            .Left        = 582
            .Width       = 229
            .Height      = 107
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 3
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.grd_4c_GrupoCompo
            .Column1.Header1.Caption = "Grupo"
            .Column1.Width = 70
            .Column2.Header1.Caption = "Total"
            .Column2.Width = 95
            .Column3.Header1.Caption = "Moe"
            .Column3.Width = 50
        ENDWITH

        *-- grdCompo - Composicao principal (top=148, left=6, width=943, height=147, 14 cols)
        *-- Dados: SIGPRCPO - Material, Descricao, Unidade, Valor, Qtde, Total, Moeda, Obs, Etiq, Consumo, QtdCV, UnCV, Ordem, Compos
        loc_oPg.AddObject("grd_4c_Compo", "Grid")
        WITH loc_oPg.grd_4c_Compo
            .Top         = 148
            .Left        = 6
            .Width       = 943
            .Height      = 147
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 14
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.grd_4c_Compo
            .Column1.Header1.Caption  = "Material"
            .Column1.Width  = 90
            .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width  = 190
            .Column3.Header1.Caption  = "Un"
            .Column3.Width  = 35
            .Column4.Header1.Caption  = "Valor"
            .Column4.Width  = 75
            .Column5.Header1.Caption  = "Qtde."
            .Column5.Width  = 60
            .Column6.Header1.Caption  = "Total"
            .Column6.Width  = 75
            .Column7.Header1.Caption  = "Moe"
            .Column7.Width  = 35
            .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
            .Column8.Width  = 80
            .Column9.Header1.Caption  = "E"
            .Column9.Width  = 20
            .Column10.Header1.Caption = "Consumo"
            .Column10.Width = 70
            .Column11.Header1.Caption = "Qtde."
            .Column11.Width = 60
            .Column12.Header1.Caption = "Un"
            .Column12.Width = 35
            .Column13.Header1.Caption = "Ord"
            .Column13.Width = 35
            .Column14.Header1.Caption = "Material"
            .Column14.Width = 70
        ENDWITH

        *-- grdsubcp - Sub-componentes (top=348, left=6, width=943, height=83, 15 cols)
        *-- Dados: sigsubcp
        loc_oPg.AddObject("grd_4c_SubCompo", "Grid")
        WITH loc_oPg.grd_4c_SubCompo
            .Top         = 348
            .Left        = 6
            .Width       = 943
            .Height      = 83
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 15
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.grd_4c_SubCompo
            .Column1.Header1.Caption  = "Material"
            .Column1.Width  = 80
            .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width  = 160
            .Column3.Header1.Caption  = "Un"
            .Column3.Width  = 35
            .Column4.Header1.Caption  = "Valor"
            .Column4.Width  = 70
            .Column5.Header1.Caption  = "Qtde."
            .Column5.Width  = 55
            .Column6.Header1.Caption  = "Total"
            .Column6.Width  = 70
            .Column7.Header1.Caption  = "Moe"
            .Column7.Width  = 35
            .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
            .Column8.Width  = 75
            .Column9.Header1.Caption  = "E"
            .Column9.Width  = 20
            .Column10.Header1.Caption = "Consumo"
            .Column10.Width = 65
            .Column11.Header1.Caption = "Qtde."
            .Column11.Width = 55
            .Column12.Header1.Caption = "Un"
            .Column12.Width = 35
            .Column13.Header1.Caption = "Ord"
            .Column13.Width = 35
            .Column14.Header1.Caption = "Material"
            .Column14.Width = 65
            .Column15.Header1.Caption = "Tam"
            .Column15.Width = 45
        ENDWITH

        *-- cntMtPrima - Container Materia Prima (top=511, left=752, width=242, height=108)
        loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
        WITH loc_oPg.cnt_4c_MtPrima
            .Top         = 511
            .Left        = 752
            .Width       = 242
            .Height      = 108
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Compos", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Compos
            .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
            .Top       = 1
            .Left      = 6
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Compos", "TextBox")
        WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Compos
            .Value    = ""
            .Top      = 18
            .Left     = 6
            .Width    = 233
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Montagem", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Montagem
            .Caption   = "Montagem :"
            .Top       = 42
            .Left      = 6
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_MontaDescs", "TextBox")
        WITH loc_oPg.cnt_4c_MtPrima.txt_4c_MontaDescs
            .Value    = 0
            .Top      = 59
            .Left     = 6
            .Width    = 233
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Digitos", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Digitos
            .Caption   = "Digitos :"
            .Top       = 88
            .Left      = 4
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_DigiMaxs", "TextBox")
        WITH loc_oPg.cnt_4c_MtPrima.txt_4c_DigiMaxs
            .Value    = 0
            .Top      = 84
            .Left     = 54
            .Width    = 25
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Ordem", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Ordem
            .Caption   = "Ordem :"
            .Top       = 88
            .Left      = 85
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_OrdCompos", "TextBox")
        WITH loc_oPg.cnt_4c_MtPrima.txt_4c_OrdCompos
            .Value    = 0
            .Top      = 84
            .Left     = 136
            .Width    = 25
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Casas", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Casas
            .Caption   = "Casas :"
            .Top       = 88
            .Left      = 165
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Casas", "TextBox")
        WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Casas
            .Value    = 0
            .Top      = 84
            .Left     = 213
            .Width    = 25
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Campos de preco de custo (bottom area)
        loc_oPg.AddObject("lbl_4c_PcusLabel", "Label")
        WITH loc_oPg.lbl_4c_PcusLabel
            .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
            .Top       = 502
            .Left      = 9
            .Width     = 140
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_PcusMoe", "TextBox")
        WITH loc_oPg.txt_4c_PcusMoe
            .Value    = ""
            .Top      = 517
            .Left     = 127
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
        WITH loc_oPg.txt_4c_Pcus
            .Value    = 0
            .Top      = 517
            .Left     = 9
            .Width    = 115
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
        WITH loc_oPg.txt_4c_Fcusto
            .Value    = 0
            .Top      = 517
            .Left     = 161
            .Width    = 115
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_PcusMoepc", "TextBox")
        WITH loc_oPg.txt_4c_PcusMoepc
            .Value    = ""
            .Top      = 517
            .Left     = 279
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Custof", "TextBox")
        WITH loc_oPg.txt_4c_Custof
            .Value    = 0
            .Top      = 557
            .Left     = 161
            .Width    = 115
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_MoecusFoe", "TextBox")
        WITH loc_oPg.txt_4c_MoecusFoe
            .Value    = ""
            .Top      = 557
            .Left     = 279
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pesom", "TextBox")
        WITH loc_oPg.txt_4c_Pesom
            .Value    = 0
            .Top      = 596
            .Left     = 10
            .Width    = 79
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
        WITH loc_oPg.txt_4c_MarkupA
            .Value    = 0
            .Top      = 596
            .Left     = 323
            .Width    = 62
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- === COMANDOS PARA grdCompo (Container com 5 botoes, top=145, left=947) ===========
        loc_oPg.AddObject("obj_4c_CmdgCompo", "Container")
        WITH loc_oPg.obj_4c_CmdgCompo
            .Top         = 145
            .Left        = 947
            .Width       = 50
            .Height      = 210
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoIncluir", "CommandButton")
        WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoIncluir
            .Caption         = "+"
            .Top             = 0
            .Left            = 0
            .Width           = 50
            .Height          = 42
            .FontName        = "Tahoma"
            .FontSize        = 14
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(0,128,0)
            .ToolTipText     = "Incluir"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoIncluir, "Click", THIS, "CmdCompoIncluirClick")

        loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoExcluir", "CommandButton")
        WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir
            .Caption         = "-"
            .Top             = 42
            .Left            = 0
            .Width           = 50
            .Height          = 42
            .FontName        = "Tahoma"
            .FontSize        = 14
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(180,0,0)
            .ToolTipText     = "Excluir"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir, "Click", THIS, "CmdCompoExcluirClick")

        loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoAtualizar", "CommandButton")
        WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar
            .Caption         = "Atu"
            .Top             = 84
            .Left            = 0
            .Width           = 50
            .Height          = 42
            .FontName        = "Tahoma"
            .FontSize        = 10
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(0,0,180)
            .ToolTipText     = "Atualizar Pre" + CHR(231) + "os"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar, "Click", THIS, "CmdCompoAtualizarClick")

        loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoPeso", "CommandButton")
        WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso
            .Caption         = "Kg"
            .Top             = 126
            .Left            = 0
            .Width           = 50
            .Height          = 42
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .ToolTipText     = "Atualizar Pesos"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso, "Click", THIS, "CmdCompoAtuPesosClick")

        loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoRecalc", "CommandButton")
        WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc
            .Caption         = "="
            .Top             = 168
            .Left            = 0
            .Width           = 50
            .Height          = 42
            .FontName        = "Tahoma"
            .FontSize        = 14
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .ToolTipText     = "Recalcular"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc, "Click", THIS, "CmdCompoRecalcClick")

        *-- === COMANDOS PARA grdsubcp (Container com 2 botoes, top=345, left=947) ==========
        loc_oPg.AddObject("obj_4c_CmdgSubCp", "Container")
        WITH loc_oPg.obj_4c_CmdgSubCp
            .Top         = 345
            .Left        = 947
            .Width       = 50
            .Height      = 90
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpIncluir", "CommandButton")
        WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir
            .Caption         = "+"
            .Top             = 0
            .Left            = 0
            .Width           = 50
            .Height          = 45
            .FontName        = "Tahoma"
            .FontSize        = 14
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(0,128,0)
            .ToolTipText     = "Incluir Sub-Componente"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir, "Click", THIS, "CmdSubCpIncluirClick")

        loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpExcluir", "CommandButton")
        WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir
            .Caption         = "-"
            .Top             = 45
            .Left            = 0
            .Width           = 50
            .Height          = 45
            .FontName        = "Tahoma"
            .FontSize        = 14
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(180,0,0)
            .ToolTipText     = "Excluir Sub-Componente"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir, "Click", THIS, "CmdSubCpExcluirClick")

        *-- === OBSERVACAO E DESCRICAO (entre grdCompo e grdsubcp, top=297-325) =============
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Caption   = "Obs. da OF :"
            .Top       = 300
            .Left      = 36
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
        WITH loc_oPg.txt_4c_ObsOFs
            .Value    = ""
            .Top      = 297
            .Left     = 99
            .Width    = 850
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 100
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPg.lbl_4c_Label16
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 324
            .Left      = 45
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPg.txt_4c_Desc
            .Value    = ""
            .Top      = 321
            .Left     = 99
            .Width    = 298
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Desc, "KeyPress", THIS, "TabCompo_DescLostFocus")

        loc_oPg.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPg.lbl_4c_Label15
            .Caption   = "Material Principal :"
            .Top       = 324
            .Left      = 421
            .Width     = 89
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_MatP", "TextBox")
        WITH loc_oPg.txt_4c_MatP
            .Value    = ""
            .Top      = 321
            .Left     = 517
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_MatP, "KeyPress", THIS, "TabCompo_MatPLostFocus")

        *-- === CAMPOS SUB-COMPONENTE (abaixo de grdsubcp, top=432-435) =====================
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 435
            .Left      = 39
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c__desccp", "TextBox")
        WITH loc_oPg.txt_4c__desccp
            .Value    = ""
            .Top      = 432
            .Left     = 99
            .Width    = 298
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__desccp, "KeyPress", THIS, "TabCompo_DesccpLostFocus")

        loc_oPg.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg.lbl_4c_Label5
            .Caption   = "Substitui :"
            .Top       = 435
            .Left      = 465
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c__matsub", "TextBox")
        WITH loc_oPg.txt_4c__matsub
            .Value    = ""
            .Top      = 432
            .Left     = 517
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__matsub, "KeyPress", THIS, "TabCompo_MatsubLostFocus")

        *-- === CHECKBOXES LIBERAR CUSTO / VENDA (top=458-459) ==============================
        loc_oPg.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
        WITH loc_oPg.chk_4c_ChkLiberaCusto
            .Caption   = "Custo"
            .Value     = 0
            .Top       = 458
            .Left      = 9
            .Width     = 39
            .Height    = 38
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_ChkLiberaCusto, "Click", THIS, "ChkLiberaCustoClick")

        loc_oPg.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
        WITH loc_oPg.chk_4c_ChkLiberaVenda
            .Caption   = "Venda"
            .Value     = 0
            .Top       = 459
            .Left      = 323
            .Width     = 39
            .Height    = 38
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_ChkLiberaVenda, "Click", THIS, "ChkLiberaVendaClick")

        *-- === LABELS DIVISORES CUSTO/VENDA (top=473-474) ==================================
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Caption   = " Custo "
            .Top       = 473
            .Left      = 47
            .Width     = 46
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .BackColor = RGB(220,220,220)
            .ForeColor = RGB(50,50,50)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Caption   = " Venda "
            .Top       = 474
            .Left      = 361
            .Width     = 48
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .BackColor = RGB(220,220,220)
            .ForeColor = RGB(50,50,50)
        ENDWITH

        *-- === SHAPES DIVISORES VISUAIS (top=497-498) ======================================
        loc_oPg.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPg.shp_4c_Shape6
            .Top         = 497
            .Left        = 9
            .Width       = 158
            .Height      = 2
            .BackColor   = RGB(180,180,180)
            .BackStyle   = 1
            .BorderColor = RGB(180,180,180)
        ENDWITH

        loc_oPg.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPg.shp_4c_Shape4
            .Top         = 498
            .Left        = 323
            .Width       = 158
            .Height      = 2
            .BackColor   = RGB(180,180,180)
            .BackStyle   = 1
            .BorderColor = RGB(180,180,180)
        ENDWITH

        *-- === ROTULOS AREA CUSTO (top=502-542) ============================================
        *-- lbl_4c_LblCuVda: "Fator de Custo (Moeda 2)" ja existe como lblCompra/lbl_4c_PcusLabel
        *-- Adiciona label faltante para a coluna direita do custo
        loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
        WITH loc_oPg.lbl_4c_LblCuVda
            .Caption   = "Fator de Custo (Moeda 2)"
            .Top       = 502
            .Left      = 161
            .Width     = 126
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg.lbl_4c_Label8
            .Caption   = "Total "
            .Top       = 542
            .Left      = 161
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- lbl_4c_Label7 (Say7 "Cotacao") para GetCotaCalcP
        loc_oPg.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg.lbl_4c_Label7
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .Top       = 581
            .Left      = 161
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- GetCotaCalcP (top=596, left=161): cotacao para calculo
        loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
        WITH loc_oPg.txt_4c_CotaCalcP
            .Value    = 0
            .Top      = 596
            .Left     = 161
            .Width    = 115
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Say6 "Peso Medio" (top=581, left=10)
        loc_oPg.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg.lbl_4c_Label6
            .Caption   = "Peso M" + CHR(233) + "dio"
            .Top       = 581
            .Left      = 10
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- cmdPesoM "..." (top=597, left=92)
        loc_oPg.AddObject("cmd_4c_CmdPesoM", "CommandButton")
        WITH loc_oPg.cmd_4c_CmdPesoM
            .Caption         = "..."
            .Top             = 597
            .Left            = 92
            .Width           = 26
            .Height          = 23
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .ToolTipText     = "Calcular Peso"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CmdPesoM, "Click", THIS, "CmdPesoMClick")

        *-- Say22 "MKP" (top=542, left=9) - label para Get_cmkpc
        loc_oPg.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPg.lbl_4c_Label22
            .Caption   = "MKP"
            .Top       = 542
            .Left      = 9
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- Get_cmkpc (top=557, left=9, w=24): markup de custo
        loc_oPg.AddObject("txt_4c_Cmkpc", "TextBox")
        WITH loc_oPg.txt_4c_Cmkpc
            .Value    = ""
            .Top      = 557
            .Left     = 9
            .Width    = 24
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cmkpc, "KeyPress", THIS, "TabCompo_CmkpcLostFocus")

        *-- lblValAdics (top=542, left=64): "Valor Adicional"
        loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
        WITH loc_oPg.lbl_4c_LblValAdics
            .Caption   = "Valor Adicional"
            .Top       = 542
            .Left      = 64
            .Width     = 71
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- get_pftioc (top=557, left=64, w=94): valor adicional custo (read-only)
        loc_oPg.AddObject("txt_4c__pftioc", "TextBox")
        WITH loc_oPg.txt_4c__pftioc
            .Value    = 0
            .Top      = 557
            .Left     = 64
            .Width    = 94
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- chkPlanCus (top=556, left=36): planejamento custo
        loc_oPg.AddObject("chk_4c_ChkPlanCus", "CheckBox")
        WITH loc_oPg.chk_4c_ChkPlanCus
            .Caption   = ""
            .Value     = 0
            .Top       = 556
            .Left      = 36
            .Width     = 25
            .Height    = 25
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- === ROTULOS AREA VENDA (top=503-542) ============================================
        *-- lbl_4c_LblMkpVenda "MKP Ideal" (top=504, left=324)
        loc_oPg.AddObject("lbl_4c_LblMkpVenda", "Label")
        WITH loc_oPg.lbl_4c_LblMkpVenda
            .Caption   = "MKP Ideal"
            .Top       = 504
            .Left      = 324
            .Width     = 49
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- getMargem (top=517, left=323, w=89): markup ideal de venda
        loc_oPg.AddObject("txt_4c_Margem", "TextBox")
        WITH loc_oPg.txt_4c_Margem
            .Value    = 0
            .Top      = 517
            .Left     = 323
            .Width    = 89
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Margem, "KeyPress", THIS, "TabCompo_MargemLostFocus")

        *-- lblIdeal "Preco Ideal (Moeda 1)" (top=503, left=416)
        loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
        WITH loc_oPg.lbl_4c_LblIdeal
            .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
            .Top       = 503
            .Left      = 416
            .Width     = 111
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- getPvideal (top=517, left=416, w=110): preco ideal (read-only)
        loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
        WITH loc_oPg.txt_4c_Pvideal
            .Value    = 0
            .Top      = 517
            .Left     = 416
            .Width    = 110
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- getMoeda (top=517, left=529, w=31): moeda de venda (editable+lookup)
        loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg.txt_4c_Moeda
            .Value    = ""
            .Top      = 517
            .Left     = 529
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "TabCompo_MoedaLostFocus")

        *-- lblFIdeals "Fator Ideal" (top=503, left=563)
        loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
        WITH loc_oPg.lbl_4c_LblFIdeals
            .Caption   = "Fator Ideal"
            .Top       = 503
            .Left      = 563
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- getFIdeals (top=517, left=563, w=110): fator ideal (read-only)
        loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
        WITH loc_oPg.txt_4c_FIdeals
            .Value    = 0
            .Top      = 517
            .Left     = 563
            .Width    = 110
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Say14 "MKP" (top=542, left=360) - label para Getftio
        loc_oPg.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPg.lbl_4c_Label14
            .Caption   = "MKP"
            .Top       = 542
            .Left      = 360
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- Getftio (top=557, left=360, w=24): fiacao venda (editable+lookup)
        loc_oPg.AddObject("txt_4c_Ftio", "TextBox")
        WITH loc_oPg.txt_4c_Ftio
            .Value    = ""
            .Top      = 557
            .Left     = 360
            .Width    = 24
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Ftio, "KeyPress", THIS, "TabCompo_FtioLostFocus")

        *-- Say13 "Valor Adicional" (top=542, left=416)
        loc_oPg.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg.lbl_4c_Label13
            .Caption   = "Valor Adicional"
            .Top       = 542
            .Left      = 416
            .Width     = 71
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- Get_Pftio (top=557, left=416, w=110): valor adicional/preco com fiacao (read-only)
        loc_oPg.AddObject("txt_4c_Pftio", "TextBox")
        WITH loc_oPg.txt_4c_Pftio
            .Value    = 0
            .Top      = 557
            .Left     = 416
            .Width    = 110
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Say12 "Fator" (top=542, left=563)
        loc_oPg.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPg.lbl_4c_Label12
            .Caption   = "Fator"
            .Top       = 542
            .Left      = 563
            .Width     = 28
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- getFvenda (top=557, left=563, w=110): fator de venda (editable)
        loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
        WITH loc_oPg.txt_4c_Fvenda
            .Value    = 0
            .Top      = 557
            .Left     = 563
            .Width    = 110
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Fvenda, "KeyPress", THIS, "TabCompo_FvendaLostFocus")

        *-- getMoepv (top=557, left=677, w=31): moeda preco venda (editable+lookup)
        loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
        WITH loc_oPg.txt_4c_Moepv
            .Value    = ""
            .Top      = 557
            .Left     = 677
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "TabCompo_MoepvLostFocus")

        *-- Get_mftio (top=557, left=529, w=31): markup fiacao (read-only)
        loc_oPg.AddObject("txt_4c_Mftio", "TextBox")
        WITH loc_oPg.txt_4c_Mftio
            .Value    = 0
            .Top      = 557
            .Left     = 529
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Say24 "Sts" (top=542, left=324) - label para getStatus
        loc_oPg.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPg.lbl_4c_Label24
            .Caption   = "Sts"
            .Top       = 542
            .Left      = 324
            .Width     = 17
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- getStatus (top=557, left=324, w=31): status composicao (editable+lookup)
        loc_oPg.AddObject("txt_4c_Status", "TextBox")
        WITH loc_oPg.txt_4c_Status
            .Value    = ""
            .Top      = 557
            .Left     = 324
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Status, "KeyPress", THIS, "TabCompo_StatusLostFocus")

        *-- chkPlanVen (top=556, left=387): planejamento venda
        loc_oPg.AddObject("chk_4c_ChkPlanVen", "CheckBox")
        WITH loc_oPg.chk_4c_ChkPlanVen
            .Caption   = ""
            .Value     = 0
            .Top       = 556
            .Left      = 387
            .Width     = 25
            .Height    = 25
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Chk_Pvenda (top=595, left=387, w=25, h=25): usar preco ideal
        loc_oPg.AddObject("chk_4c_ChkPvenda", "CheckBox")
        WITH loc_oPg.chk_4c_ChkPvenda
            .Caption   = ""
            .Value     = 0
            .Top       = 595
            .Left      = 387
            .Width     = 25
            .Height    = 25
            .BackStyle = 0
            .Themes    = .F.
            .ToolTipText = "Usar Pre" + CHR(231) + "o Ideal"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_ChkPvenda, "Click", THIS, "ChkPvendaClick")

        *-- lblVenda "Preco Atual (Moeda 2)" (top=581, left=416)
        loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
        WITH loc_oPg.lbl_4c_LblVenda
            .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
            .Top       = 581
            .Left      = 416
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- getPven (top=596, left=416, w=110): preco de venda atual (read-only)
        loc_oPg.AddObject("txt_4c_Pven", "TextBox")
        WITH loc_oPg.txt_4c_Pven
            .Value    = 0
            .Top      = 596
            .Left     = 416
            .Width    = 110
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- getMoev (top=596, left=529, w=31): moeda valor venda (editable+lookup)
        loc_oPg.AddObject("txt_4c_Moev", "TextBox")
        WITH loc_oPg.txt_4c_Moev
            .Value    = ""
            .Top      = 596
            .Left     = 529
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress", THIS, "TabCompo_MoevLostFocus")

        *-- lblFAtuals "Fator Atual" (top=581, left=563)
        loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
        WITH loc_oPg.lbl_4c_LblFAtuals
            .Caption   = "Fator Atual"
            .Top       = 581
            .Left      = 563
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- getFAtuals (top=596, left=563, w=110): fator atual (read-only)
        loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
        WITH loc_oPg.txt_4c_FAtuals
            .Value    = 0
            .Top      = 596
            .Left     = 563
            .Width    = 110
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Say25 "Financeiro" (top=581, left=678) - label para Get_Encarg
        loc_oPg.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPg.lbl_4c_Label25
            .Caption   = "Financeiro"
            .Top       = 581
            .Left      = 678
            .Width     = 51
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- Get_Encarg (top=595, left=678, w=62): encargos financeiros (read-only)
        loc_oPg.AddObject("txt_4c_Encarg", "TextBox")
        WITH loc_oPg.txt_4c_Encarg
            .Value    = 0
            .Top      = 595
            .Left     = 678
            .Width    = 62
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- lbl_4c_LblMkpApl "MKP Aplic." (top=581, left=324)
        loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
        WITH loc_oPg.lbl_4c_LblMkpApl
            .Caption   = "MKP Aplic."
            .Top       = 581
            .Left      = 324
            .Width     = 51
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- cmd_4c_CmdCalcVals "Calcular" (top=507, left=678, w=40, h=40)
        loc_oPg.AddObject("cmd_4c_CmdCalcVals", "CommandButton")
        WITH loc_oPg.cmd_4c_CmdCalcVals
            .Caption         = "Calc"
            .Top             = 507
            .Left            = 678
            .Width           = 40
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 7
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(0,0,180)
            .ToolTipText     = "Calcular Valores"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CmdCalcVals, "Click", THIS, "CmdCalcValsClick")

        *-- BINDEVENT para campos de moeda existentes (getMoec, getMoecusf)
        BINDEVENT(loc_oPg.txt_4c_PcusMoe,  "KeyPress", THIS, "TabCompo_MoecLostFocus")
        BINDEVENT(loc_oPg.txt_4c_MoecusFoe,"KeyPress", THIS, "TabCompo_MoecusfLostFocus")

        *-- BINDEVENT para AfterRowColChange dos grids
        BINDEVENT(loc_oPg.grd_4c_Compo,    "AfterRowColChange", THIS, "CompoGrd_AfterRowColChange")
        BINDEVENT(loc_oPg.grd_4c_SubCompo, "AfterRowColChange", THIS, "SubCompoGrd_AfterRowColChange")

        *-- Criar cursors placeholder para os grids (evitar erro de RecordSource vazio)
        IF !USED("cursor_4c_Compo")
            SET NULL ON
            CREATE CURSOR cursor_4c_Compo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), compos C(10))
            SET NULL OFF
        ENDIF
        loc_oPg.grd_4c_Compo.ColumnCount = 3
        loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
        WITH loc_oPg.grd_4c_Compo
            .Column1.ControlSource  = "cursor_4c_Compo.mats"
            .Column2.ControlSource  = "cursor_4c_Compo.dcompos"
            .Column3.ControlSource  = "cursor_4c_Compo.unicompos"
            .Column4.ControlSource  = "cursor_4c_Compo.pcompos"
            .Column5.ControlSource  = "cursor_4c_Compo.qtds"
            .Column6.ControlSource  = "cursor_4c_Compo.totas"
            .Column7.ControlSource  = "cursor_4c_Compo.moeds"
            .Column8.ControlSource  = "cursor_4c_Compo.obscompos"
            .Column9.ControlSource  = "cursor_4c_Compo.etiqs"
            .Column10.ControlSource = "cursor_4c_Compo.qtscons"
            .Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
            .Column12.ControlSource = "cursor_4c_Compo.cunips"
            .Column13.ControlSource = "cursor_4c_Compo.ordems"
            .Column14.ControlSource = "cursor_4c_Compo.compos"
        ENDWITH

        IF !USED("cursor_4c_SubCompo")
            SET NULL ON
            CREATE CURSOR cursor_4c_SubCompo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), matsubs C(14), codtams C(4))
            SET NULL OFF
        ENDIF
        loc_oPg.grd_4c_SubCompo.ColumnCount = 3
        loc_oPg.grd_4c_SubCompo.RecordSource = "cursor_4c_SubCompo"
        WITH loc_oPg.grd_4c_SubCompo
            .Column1.ControlSource  = "cursor_4c_SubCompo.mats"
            .Column2.ControlSource  = "cursor_4c_SubCompo.dcompos"
            .Column3.ControlSource  = "cursor_4c_SubCompo.unicompos"
            .Column4.ControlSource  = "cursor_4c_SubCompo.pcompos"
            .Column5.ControlSource  = "cursor_4c_SubCompo.qtds"
            .Column6.ControlSource  = "cursor_4c_SubCompo.totas"
            .Column7.ControlSource  = "cursor_4c_SubCompo.moeds"
            .Column8.ControlSource  = "cursor_4c_SubCompo.obscompos"
            .Column9.ControlSource  = "cursor_4c_SubCompo.etiqs"
            .Column10.ControlSource = "cursor_4c_SubCompo.qtscons"
            .Column11.ControlSource = "cursor_4c_SubCompo.qtdcvs"
            .Column12.ControlSource = "cursor_4c_SubCompo.cunips"
            .Column13.ControlSource = "cursor_4c_SubCompo.ordems"
            .Column14.ControlSource = "cursor_4c_SubCompo.matsubs"
            .Column15.ControlSource = "cursor_4c_SubCompo.codtams"
        ENDWITH

        IF !USED("cursor_4c_GrupoCompo")
            SET NULL ON
            CREATE CURSOR cursor_4c_GrupoCompo (grupos C(10), totas N(11,3), moeds C(3))
            SET NULL OFF
        ENDIF
        loc_oPg.grd_4c_GrupoCompo.ColumnCount = 3
        loc_oPg.grd_4c_GrupoCompo.RecordSource = "cursor_4c_GrupoCompo"
        WITH loc_oPg.grd_4c_GrupoCompo
            .Column1.ControlSource = "cursor_4c_GrupoCompo.grupos"
            .Column2.ControlSource = "cursor_4c_GrupoCompo.totas"
            .Column3.ControlSource = "cursor_4c_GrupoCompo.moeds"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTabCustos - Aba 3: Custo da composicao (pgCusto)
    * Legado: pgframeDados.pgCusto (grdCompo 12-col, cmbTipos, cmdgCompo)
    * FASE 9: implementacao completa com BINDEVENTs e botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTabCustos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

        *-- Label "Tipo :" (top=159, left=112)
        loc_oPg.AddObject("lbl_4c_TipoCusto", "Label")
        WITH loc_oPg.lbl_4c_TipoCusto
            .Caption   = "Tipo :"
            .Top       = 159
            .Left      = 112
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- ComboBox cmbTipos (top=154, left=143, width=187)
        *-- Filtra o grid de custos por tipo de calculo de custo
        loc_oPg.AddObject("cmb_4c_TiposCusto", "ComboBox")
        WITH loc_oPg.cmb_4c_TiposCusto
            .Top       = 154
            .Left      = 143
            .Width     = 187
            .Height    = 23
            .Style     = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPg.cmb_4c_TiposCusto
            .AddItem("Todos")
            .AddItem("Custo Completo")
            .AddItem("Custo Parcial")
            .AddItem("Custo Calculado")
            .ListIndex = 1
        ENDWITH
        BINDEVENT(loc_oPg.cmb_4c_TiposCusto, "LostFocus", THIS, "CmbTiposCustoValid")

        *-- grdCompo - Grid de composicao de custo (top=178, left=34, width=813, height=230, 12 cols)
        *-- Dados: SIGPRCPO filtrado por Tipos (tipo de calculo)
        loc_oPg.AddObject("grd_4c_CompoCusto", "Grid")
        WITH loc_oPg.grd_4c_CompoCusto
            .Top         = 178
            .Left        = 34
            .Width       = 813
            .Height      = 230
            .ReadOnly    = .F.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 12
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.grd_4c_CompoCusto
            .Column1.Header1.Caption  = "Item"
            .Column1.Width  = 80
            .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width  = 180
            .Column3.Header1.Caption  = "Un"
            .Column3.Width  = 35
            .Column4.Header1.Caption  = "Valor"
            .Column4.Width  = 75
            .Column5.Header1.Caption  = "Qtd"
            .Column5.Width  = 60
            .Column6.Header1.Caption  = "Total"
            .Column6.Width  = 75
            .Column7.Header1.Caption  = "Moe"
            .Column7.Width  = 35
            .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
            .Column8.Width  = 75
            .Column9.Header1.Caption  = "Etiq"
            .Column9.Width  = 35
            .Column10.Header1.Caption = "Consumo"
            .Column10.Width = 70
            .Column11.Header1.Caption = "Qtd"
            .Column11.Width = 55
            .Column12.Header1.Caption = "Un"
            .Column12.Width = 35
        ENDWITH
        BINDEVENT(loc_oPg.grd_4c_CompoCusto, "AfterRowColChange", THIS, "CustosGrd_AfterRowColChange")

        *-- Botoes Incluir/Excluir para grid de custo
        *-- Legado: cmdgCompo (CommandGroup) top=240, left=851, buttonCount=2
        loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
        WITH loc_oPg.cnt_4c_BotoesCusto
            .Top         = 178
            .Left        = 851
            .Width       = 50
            .Height      = 90
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoIncluir", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir
            .Caption       = "+"
            .Top           = 0
            .Left          = 0
            .Width         = 50
            .Height        = 45
            .FontName      = "Tahoma"
            .FontSize      = 14
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(230, 255, 230)
            .ForeColor     = RGB(0, 128, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir, "Click", THIS, "CmdCustoIncluirClick")

        loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoExcluir", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir
            .Caption       = "-"
            .Top           = 45
            .Left          = 0
            .Width         = 50
            .Height        = 45
            .FontName      = "Tahoma"
            .FontSize      = 14
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 230, 230)
            .ForeColor     = RGB(192, 0, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir, "Click", THIS, "CmdCustoExcluirClick")

        *-- Shape separador horizontal (Shape2: top=460, left=35, width=158, height=2)
        loc_oPg.AddObject("shp_4c_SepCusto", "Shape")
        WITH loc_oPg.shp_4c_SepCusto
            .Top         = 460
            .Left        = 35
            .Width       = 158
            .Height      = 2
            .FillColor   = RGB(180, 180, 180)
            .BackColor   = RGB(180, 180, 180)
            .BorderColor = RGB(180, 180, 180)
        ENDWITH

        *-- Label "Descricao :" (Say16: top=415, left=52)
        loc_oPg.AddObject("lbl_4c_DescCusto", "Label")
        WITH loc_oPg.lbl_4c_DescCusto
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 415
            .Left      = 52
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Get_Desc - mostra descricao do item selecionado (top=412, left=116, width=304)
        loc_oPg.AddObject("txt_4c_DescCusto", "TextBox")
        WITH loc_oPg.txt_4c_DescCusto
            .Value    = ""
            .Top      = 412
            .Left     = 116
            .Width    = 304
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Label "Grupo :" (Say2: top=415, left=479)
        loc_oPg.AddObject("lbl_4c_GrupoCusto", "Label")
        WITH loc_oPg.lbl_4c_GrupoCusto
            .Caption   = "Grupo :"
            .Top       = 415
            .Left      = 479
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox getDGruCompos - mostra grupo do item selecionado (top=412, left=522, width=304)
        loc_oPg.AddObject("txt_4c_DGruCompos", "TextBox")
        WITH loc_oPg.txt_4c_DGruCompos
            .Value    = ""
            .Top      = 412
            .Left     = 522
            .Width    = 304
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Label "Resumo por Grupo" (Say3: top=445, left=35)
        loc_oPg.AddObject("lbl_4c_ResumoGrp", "Label")
        WITH loc_oPg.lbl_4c_ResumoGrp
            .Caption   = "Resumo por Grupo"
            .Top       = 445
            .Left      = 35
            .Width     = 107
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- GradeGRUPO2 - Totais por grupo (top=468, left=35, width=195, height=141, 3 cols)
        loc_oPg.AddObject("grd_4c_GrupoCompo2", "Grid")
        WITH loc_oPg.grd_4c_GrupoCompo2
            .Top         = 468
            .Left        = 35
            .Width       = 195
            .Height      = 141
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 3
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.grd_4c_GrupoCompo2
            .Column1.Header1.Caption = "Grp"
            .Column1.Width = 55
            .Column2.Header1.Caption = "Total"
            .Column2.Width = 100
            .Column3.Header1.Caption = "Moe"
            .Column3.Width = 35
        ENDWITH

        *-- Cursor placeholder para grd_4c_CompoCusto
        IF !USED("cursor_4c_CompoCusto")
            SET NULL ON
            CREATE CURSOR cursor_4c_CompoCusto (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3))
            SET NULL OFF
        ENDIF
        loc_oPg.grd_4c_CompoCusto.ColumnCount = 3
        loc_oPg.grd_4c_CompoCusto.RecordSource = "cursor_4c_CompoCusto"
        WITH loc_oPg.grd_4c_CompoCusto
            .Column1.ControlSource  = "cursor_4c_CompoCusto.mats"
            .Column2.ControlSource  = "cursor_4c_CompoCusto.dcompos"
            .Column3.ControlSource  = "cursor_4c_CompoCusto.unicompos"
            .Column4.ControlSource  = "cursor_4c_CompoCusto.pcompos"
            .Column5.ControlSource  = "cursor_4c_CompoCusto.qtds"
            .Column6.ControlSource  = "cursor_4c_CompoCusto.totas"
            .Column7.ControlSource  = "cursor_4c_CompoCusto.moeds"
            .Column8.ControlSource  = "cursor_4c_CompoCusto.obscompos"
            .Column9.ControlSource  = "cursor_4c_CompoCusto.etiqs"
            .Column10.ControlSource = "cursor_4c_CompoCusto.qtscons"
            .Column11.ControlSource = "cursor_4c_CompoCusto.qtdcvs"
            .Column12.ControlSource = "cursor_4c_CompoCusto.cunips"
        ENDWITH

        *-- Cursor placeholder para grd_4c_GrupoCompo2
        IF !USED("cursor_4c_GrupoCompo2")
            SET NULL ON
            CREATE CURSOR cursor_4c_GrupoCompo2 (grupos C(10), totas N(11,3), moeds C(3))
            SET NULL OFF
        ENDIF
        loc_oPg.grd_4c_GrupoCompo2.ColumnCount = 3
        loc_oPg.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
        WITH loc_oPg.grd_4c_GrupoCompo2
            .Column1.ControlSource = "cursor_4c_GrupoCompo2.grupos"
            .Column2.ControlSource = "cursor_4c_GrupoCompo2.totas"
            .Column3.ControlSource = "cursor_4c_GrupoCompo2.moeds"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTabDadosFiscais - Aba 4: Dados fiscais (pgDadosFiscais)
    * IMPLEMENTADO NA FASE 6
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTabDadosFiscais()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4

        *-- Classificacao Fiscal (top=211, left=206, width=94)
        loc_oPg.AddObject("lbl_4c_Clfiscal", "Label")
        WITH loc_oPg.lbl_4c_Clfiscal
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
            .Top       = 216
            .Left      = 102
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
        WITH loc_oPg.txt_4c_Clfiscal
            .Value    = ""
            .Top      = 211
            .Left     = 206
            .Width    = 94
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 10
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TabFiscal_ClfiscalKeyPress")

        loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
        WITH loc_oPg.txt_4c_Dclfiscal
            .Value    = ""
            .Top      = 211
            .Left     = 303
            .Width    = 303
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Origem Mercadoria (top=236, left=206, width=17)
        loc_oPg.AddObject("lbl_4c_Origmerc", "Label")
        WITH loc_oPg.lbl_4c_Origmerc
            .Caption   = "Origem da Mercadoria :"
            .Top       = 241
            .Left      = 87
            .Width     = 114
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
        WITH loc_oPg.txt_4c_Origmerc
            .Value    = ""
            .Top      = 236
            .Left     = 206
            .Width    = 17
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 1
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
        WITH loc_oPg.txt_4c_Dorigmerc
            .Value    = ""
            .Top      = 236
            .Left     = 226
            .Width    = 380
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Situacao Tributaria ICMS (top=261, left=206, width=31)
        loc_oPg.AddObject("lbl_4c_Sittricms", "Label")
        WITH loc_oPg.lbl_4c_Sittricms
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
            .Top       = 266
            .Left      = 74
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Sittricms", "TextBox")
        WITH loc_oPg.txt_4c_Sittricms
            .Value    = ""
            .Top      = 261
            .Left     = 206
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 3
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dsittricms", "TextBox")
        WITH loc_oPg.txt_4c_Dsittricms
            .Value    = ""
            .Top      = 261
            .Left     = 240
            .Width    = 366
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Aliquota ICMS (top=286, left=342, width=45)
        loc_oPg.AddObject("lbl_4c_Icms", "Label")
        WITH loc_oPg.lbl_4c_Icms
            .Caption   = "Al" + CHR(237) + "quota ICMS :"
            .Top       = 291
            .Left      = 250
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Icms", "TextBox")
        WITH loc_oPg.txt_4c_Icms
            .Value    = 0
            .Top      = 286
            .Left     = 342
            .Width    = 45
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Tipo Tributacao (top=286, left=513, width=38)
        loc_oPg.AddObject("lbl_4c_Tptribs", "Label")
        WITH loc_oPg.lbl_4c_Tptribs
            .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
            .Top       = 291
            .Left      = 395
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Tptribs", "TextBox")
        WITH loc_oPg.txt_4c_Tptribs
            .Value    = ""
            .Top      = 286
            .Left     = 513
            .Width    = 38
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 4
        ENDWITH

        *-- Codigo de Servicos (top=286, left=206, width=38)
        loc_oPg.AddObject("lbl_4c_CodServs", "Label")
        WITH loc_oPg.lbl_4c_CodServs
            .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
            .Top       = 291
            .Left      = 48
            .Width     = 153
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
        WITH loc_oPg.txt_4c_CodServs
            .Value    = ""
            .Top      = 286
            .Left     = 206
            .Width    = 38
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 4
        ENDWITH

        *-- IPI (top=311, left=206, combobox)
        loc_oPg.AddObject("lbl_4c_Ipis", "Label")
        WITH loc_oPg.lbl_4c_Ipis
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
            .Top       = 316
            .Left      = 85
            .Width     = 116
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("cmb_4c_Ipi", "ComboBox")
        WITH loc_oPg.cmb_4c_Ipi
            .Top    = 311
            .Left   = 206
            .Width  = 108
            .Height = 25
            .Style  = 2
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        WITH loc_oPg.cmb_4c_Ipi
            .AddItem("T - Tributado")
            .AddItem("I - Isento")
            .AddItem("N - N" + CHR(227) + "o Tributado")
            .AddItem("S - Suspenso")
            .ListIndex = 1
        ENDWITH

        *-- Descricao Fiscal memo (top=338, left=206, width=509, height=89)
        loc_oPg.AddObject("lbl_4c_DescFis", "Label")
        WITH loc_oPg.lbl_4c_DescFis
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
            .Top       = 341
            .Left      = 117
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_DescFis", "EditBox")
        WITH loc_oPg.txt_4c_DescFis
            .Value    = ""
            .Top      = 338
            .Left     = 206
            .Width    = 509
            .Height   = 89
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Metal (top=429, left=537)
        loc_oPg.AddObject("lbl_4c_Metal", "Label")
        WITH loc_oPg.lbl_4c_Metal
            .Caption   = "Metal :"
            .Top       = 429
            .Left      = 480
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Metal", "TextBox")
        WITH loc_oPg.txt_4c_Metal
            .Value    = ""
            .Top      = 429
            .Left     = 537
            .Width    = 24
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 2
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TabFiscal_MetalKeyPress")

        loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
        WITH loc_oPg.txt_4c_DesMetal
            .Value    = ""
            .Top      = 429
            .Left     = 564
            .Width    = 150
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Teor (top=454, left=537)
        loc_oPg.AddObject("lbl_4c_Teor", "Label")
        WITH loc_oPg.lbl_4c_Teor
            .Caption   = "Teor :"
            .Top       = 454
            .Left      = 490
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Teor", "TextBox")
        WITH loc_oPg.txt_4c_Teor
            .Value    = ""
            .Top      = 454
            .Left     = 537
            .Width    = 24
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 2
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TabFiscal_TeorKeyPress")

        loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
        WITH loc_oPg.txt_4c_DesTeor
            .Value    = ""
            .Top      = 454
            .Left     = 564
            .Width    = 150
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Descricao ECF (top=429, left=206, width=213)
        loc_oPg.AddObject("lbl_4c_DescEcf", "Label")
        WITH loc_oPg.lbl_4c_DescEcf
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
            .Top       = 433
            .Left      = 124
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
        WITH loc_oPg.txt_4c_DescEcfs
            .Value    = ""
            .Top      = 429
            .Left     = 206
            .Width    = 213
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 29
        ENDWITH

        *-- Valor Estimado (top=454, left=206)
        loc_oPg.AddObject("lbl_4c_ValorEst", "Label")
        WITH loc_oPg.lbl_4c_ValorEst
            .Caption   = "Valor Estimado :"
            .Top       = 458
            .Left      = 122
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Valors", "TextBox")
        WITH loc_oPg.txt_4c_Valors
            .Value    = 0
            .Top      = 454
            .Left     = 206
            .Width    = 108
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moedas", "TextBox")
        WITH loc_oPg.txt_4c_Moedas
            .Value    = ""
            .Top      = 454
            .Left     = 317
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 3
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgpgDadosFiscais - Completa Aba 4 Dados Fiscais
    * Adiciona controles restantes + BINDEVENTs de todos os campos do tab fiscal
    * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDadosFiscais()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4

        *-- === GRUPO C.C. (get_gruccus: top=161, left=206, width=80) ============

        loc_oPg.AddObject("lbl_4c_Gruccus", "Label")
        WITH loc_oPg.lbl_4c_Gruccus
            .Caption   = "Grupo C.C. :"
            .Top       = 165
            .Left      = 138
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("txt_4c__gruccus", "TextBox")
        WITH loc_oPg.txt_4c__gruccus
            .Value         = ""
            .Top           = 161
            .Left          = 206
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__gruccus, "KeyPress", THIS, "ValidarGruccus")

        loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
        WITH loc_oPg.txt_4c__dgruccus
            .Value    = ""
            .Top      = 161
            .Left     = 288
            .Width    = 318
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__dgruccus, "KeyPress", THIS, "ValidarDgruccus")

        *-- === CONTA C.C. (get_contaccus: top=186, left=206, width=80) ==========

        loc_oPg.AddObject("lbl_4c_Contaccus", "Label")
        WITH loc_oPg.lbl_4c_Contaccus
            .Caption   = "Conta C.C. :"
            .Top       = 189
            .Left      = 138
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
        WITH loc_oPg.txt_4c__contaccus
            .Value         = ""
            .Top           = 186
            .Left          = 206
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__contaccus, "KeyPress", THIS, "ValidarContaccus")

        loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
        WITH loc_oPg.txt_4c__dcontaccus
            .Value    = ""
            .Top      = 186
            .Left     = 288
            .Width    = 318
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__dcontaccus, "KeyPress", THIS, "ValidarDcontaccus")

        *-- === ALIQUOTA IPI (Get_AliqIPI: top=311, left=425, width=45) ==========

        loc_oPg.AddObject("lbl_4c_AliqIPI", "Label")
        WITH loc_oPg.lbl_4c_AliqIPI
            .Caption   = "Al" + CHR(237) + "quota de IPI :"
            .Top       = 316
            .Left      = 327
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
        WITH loc_oPg.txt_4c_AliqIPI
            .Value    = 0
            .Top      = 311
            .Left     = 425
            .Width    = 45
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_AliqIPI, "KeyPress", THIS, "ValidarAliqIPI")

        *-- === EXCECAO DA TIPI/IPI (getextipi: top=311, left=601, width=35) ======

        loc_oPg.AddObject("lbl_4c_Extipi", "Label")
        WITH loc_oPg.lbl_4c_Extipi
            .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
            .Top       = 316
            .Left      = 495
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
        WITH loc_oPg.txt_4c_Extipi
            .Value     = ""
            .Top       = 311
            .Left      = 601
            .Width     = 35
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Extipi, "GotFocus", THIS, "TabFiscal_ExtIpiGotFocus")

        *-- === IAT (getiat: top=286, left=589, width=17) ========================

        loc_oPg.AddObject("lbl_4c_Iat", "Label")
        WITH loc_oPg.lbl_4c_Iat
            .Caption   = "IAT :"
            .Top       = 290
            .Left      = 558
            .Width     = 26
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("lbl_4c_IatDesc", "Label")
        WITH loc_oPg.lbl_4c_IatDesc
            .Caption   = "[A]rredondamento [T]runcamento"
            .Top       = 290
            .Left      = 609
            .Width     = 165
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(120, 120, 120)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Iat", "TextBox")
        WITH loc_oPg.txt_4c_Iat
            .Value     = ""
            .Top       = 286
            .Left      = 589
            .Width     = 17
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 1
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Iat, "KeyPress", THIS, "ValidarIat")

        *-- === IPPT/CST (getIPPTCST: top=479, left=206, width=108) =============
        *-- Campo de exibicao calculado: nao armazenado, somente leitura

        loc_oPg.AddObject("lbl_4c_IPPTCST", "Label")
        WITH loc_oPg.lbl_4c_IPPTCST
            .Caption   = "IPPT/CST :"
            .Top       = 483
            .Left      = 147
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
        WITH loc_oPg.txt_4c_IPPTCST
            .Value    = ""
            .Top      = 479
            .Left     = 206
            .Width    = 108
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- === GRID CMV - Custo GR (grdCmv: top=338, left=754, width=223, h=141)
        *-- 3 colunas: Periodo, Valor Custo GR, Moe

        loc_oPg.AddObject("lbl_4c_CmvTitulo", "Label")
        WITH loc_oPg.lbl_4c_CmvTitulo
            .Caption   = "Valor do Grama Produzido"
            .Top       = 320
            .Left      = 756
            .Width     = 125
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        IF !USED("cursor_4c_Cmv")
            SET NULL ON
            CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
            SET NULL OFF
        ENDIF

        loc_oPg.AddObject("grd_4c_Cmv", "Grid")
        WITH loc_oPg.grd_4c_Cmv
            .Top         = 338
            .Left        = 754
            .Width       = 223
            .Height      = 141
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 3
            .FontName    = "Verdana"
            .FontSize    = 8
        ENDWITH
        loc_oPg.grd_4c_Cmv.ColumnCount = 3
        loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
        WITH loc_oPg.grd_4c_Cmv
            .Column1.Header1.Caption = "Per" + CHR(237) + "odo"
            .Column1.Width           = 65
            .Column1.ControlSource   = "cursor_4c_Cmv.periodos"
            .Column1.ReadOnly        = .T.
            .Column2.Header1.Caption = "Valor Custo GR"
            .Column2.Width           = 105
            .Column2.ControlSource   = "cursor_4c_Cmv.valcustos"
            .Column2.ReadOnly        = .T.
            .Column3.Header1.Caption = "Moe"
            .Column3.Width           = 40
            .Column3.ControlSource   = "cursor_4c_Cmv.moedas"
            .Column3.ReadOnly        = .T.
        ENDWITH

        *-- === BOTAO GERAR DESCRICAO FISCAL (btnDescFis: top=359, left=162) ======

        loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnDescFis
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
            .PicturePosition = 5
            .Top             = 359
            .Left            = 162
            .Width           = 40
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "BtnDescFisClick")

        *-- === BINDEVENTS para controles JA CRIADOS em ConfigurarTabDadosFiscais ==
        *-- Adicionar LostFocus nos campos lookup existentes

        BINDEVENT(loc_oPg.txt_4c_Clfiscal,  "KeyPress", THIS, "ValidarClfiscal")
        BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress", THIS, "ValidarDclfiscal")
        BINDEVENT(loc_oPg.txt_4c_Origmerc,  "KeyPress", THIS, "ValidarOrigmerc")
        BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress", THIS, "ValidarDorigmerc")
        BINDEVENT(loc_oPg.txt_4c_Sittricms, "KeyPress", THIS, "ValidarSittricms")
        BINDEVENT(loc_oPg.txt_4c_Dsittricms,"KeyPress", THIS, "ValidarDsittricms")
        BINDEVENT(loc_oPg.txt_4c_CodServs,  "KeyPress", THIS, "ValidarCodServs")
        BINDEVENT(loc_oPg.txt_4c_Tptribs,   "KeyPress", THIS, "ValidarTptribs")
        BINDEVENT(loc_oPg.txt_4c_Metal,     "KeyPress", THIS, "ValidarMetal")
        BINDEVENT(loc_oPg.txt_4c_Teor,      "KeyPress", THIS, "ValidarTeor")
        BINDEVENT(loc_oPg.txt_4c_Moedas,    "KeyPress", THIS, "ValidarMoedaEstimada")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTabDesigner - Aba 5: Designer/arquivos (pgDesigner)
    * IMPLEMENTADO NA FASE 7
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTabDesigner()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

        *-- grdDesigner (top=160, left=10, width=495, height=238, 4 cols)
        *-- Dados: sigprtar - Data Inicio, Data Conclusao, Usuario, Tarefa
        loc_oPg.AddObject("grd_4c_Designer", "Grid")
        WITH loc_oPg.grd_4c_Designer
            .Top         = 160
            .Left        = 10
            .Width       = 495
            .Height      = 238
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 4
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.grd_4c_Designer
            .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
            .Column1.Width = 110
            .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
            .Column2.Width = 120
            .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
            .Column3.Width = 100
            .Column4.Header1.Caption = "Tarefa"
            .Column4.Width = 160
        ENDWITH

        *-- Observacao da Tarefa - EditBox (top=160, left=584, width=407, height=238)
        loc_oPg.AddObject("lbl_4c_ObsTarefa", "Label")
        WITH loc_oPg.lbl_4c_ObsTarefa
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
            .Top       = 144
            .Left      = 583
            .Width     = 130
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_ObsTarefas", "EditBox")
        WITH loc_oPg.txt_4c_ObsTarefas
            .Value    = ""
            .Top      = 160
            .Left     = 584
            .Width    = 407
            .Height   = 238
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Botoes de inicio/fim de tarefa (top=168 e 203, left=509)
        loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
        WITH loc_oPg.cmd_4c_IniTarefa
            .Caption = "Ini" + CHR(237) + "cio"
            .Top     = 168
            .Left    = 509
            .Width   = 42
            .Height  = 42
            .FontName = "Tahoma"
            .FontSize = 7
            .Themes  = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")

        loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
        WITH loc_oPg.cmd_4c_FimTarefa
            .Caption = "Fim"
            .Top     = 203
            .Left    = 509
            .Width   = 42
            .Height  = 42
            .FontName = "Tahoma"
            .FontSize = 7
            .Themes  = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")

        *-- grdArquivos (top=415, left=10, width=495, height=202, 1 col)
        *-- Dados: sigprarq - Arquivos do designer
        loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
        WITH loc_oPg.grd_4c_Arquivos
            .Top         = 415
            .Left        = 10
            .Width       = 495
            .Height      = 202
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 1
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.grd_4c_Arquivos
            .Column1.Header1.Caption = "Arquivos Para Designer"
            .Column1.Width = 492
        ENDWITH

        *-- Botoes de arquivo (top=416, 458, 500, left=509)
        loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
        WITH loc_oPg.cmd_4c_InsArqs
            .Caption = "Inserir"
            .Top     = 416
            .Left    = 509
            .Width   = 42
            .Height  = 42
            .FontName = "Tahoma"
            .FontSize = 7
            .Themes  = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")

        loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
        WITH loc_oPg.cmd_4c_ExcArqs
            .Caption = "Excluir"
            .Top     = 458
            .Left    = 509
            .Width   = 42
            .Height  = 42
            .FontName = "Tahoma"
            .FontSize = 7
            .Themes  = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")

        loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
        WITH loc_oPg.cmd_4c_OpnArqs
            .Caption = "Abrir"
            .Top     = 500
            .Left    = 509
            .Width   = 42
            .Height  = 42
            .FontName = "Tahoma"
            .FontSize = 7
            .Themes  = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")

        *-- Criar cursors placeholder
        IF !USED("cursor_4c_Designer")
            SET NULL ON
            CREATE CURSOR cursor_4c_Designer (dtinis D, dtfims D, usuars C(10), tarefas C(20))
            SET NULL OFF
        ENDIF
        loc_oPg.grd_4c_Designer.ColumnCount = 3
        loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_Designer"
        WITH loc_oPg.grd_4c_Designer
            .Column1.ControlSource = "cursor_4c_Designer.dtinis"
            .Column2.ControlSource = "cursor_4c_Designer.dtfims"
            .Column3.ControlSource = "cursor_4c_Designer.usuars"
            .Column4.ControlSource = "cursor_4c_Designer.tarefas"
        ENDWITH

        IF !USED("cursor_4c_Arquivos")
            SET NULL ON
            CREATE CURSOR cursor_4c_Arquivos (arquivos C(250))
            SET NULL OFF
        ENDIF
        loc_oPg.grd_4c_Arquivos.ColumnCount = 3
        loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_Arquivos"
        WITH loc_oPg.grd_4c_Arquivos
            .Column1.ControlSource = "cursor_4c_Arquivos.arquivos"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgpgDesigner - Completa Aba 5 Designer
    * Adiciona img_4c_ImgArqJpg, shp_4c_Shape1 e todos os BINDEVENTs
    * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDesigner()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgpgDesigner()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

        *-- Corrigir ReadOnly do grd_4c_Designer: .F. para Column4 ser editavel
        *-- Colunas 1-3 usam When=.F. via BINDEVENT para somente leitura
        loc_oPg.grd_4c_Designer.ReadOnly = .F.

        *-- Shape decorativo em volta da area de imagem (top=415, left=584, width=407, height=202)
        loc_oPg.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPg.shp_4c_Shape1
            .Top         = 415
            .Left        = 584
            .Width       = 407
            .Height      = 202
            .BorderColor = RGB(128, 128, 128)
            .BorderWidth = 1
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Imagem preview do arquivo selecionado (top=417, left=586, width=403, height=198)
        loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
        WITH loc_oPg.img_4c_ImgArqJpg
            .Top     = 417
            .Left    = 586
            .Width   = 403
            .Height  = 198
            .Stretch = 2
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")

        *-- BINDEVENTs para AfterRowColChange dos grids
        BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "DesignerGrd_AfterRowColChange")
        BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "ArquivosGrd_AfterRowColChange")

        *-- BINDEVENTs Colunas 1/2/3 do grd_4c_Designer (somente leitura sempre)
        BINDEVENT(loc_oPg.grd_4c_Designer.Column1.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
        BINDEVENT(loc_oPg.grd_4c_Designer.Column2.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
        BINDEVENT(loc_oPg.grd_4c_Designer.Column3.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")

        *-- BINDEVENTs Coluna 4 do grd_4c_Designer (Tarefa: editavel condicionalmente)
        BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
        BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
        BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "KeyPress", THIS, "GrdDesignerCol4LostFocus")

        *-- BINDEVENT Column1 do grd_4c_Arquivos (editavel em INCLUIR/ALTERAR)
        BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")

        *-- Cursor de tarefas para lookup do Column4 (codigo + descricao)
        IF !USED("cursor_4c_Tarefas")
            SET NULL ON
            CREATE CURSOR cursor_4c_Tarefas (CodCads C(20), DesCads C(50))
            SET NULL OFF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTabConsulta - Aba 6: Consulta de componentes por fase (PgDadosConsP)
    * Legado: PgDadosConsP com GrdCons (9 cols editaveis) e grDTEMP (2 cols)
    * IMPLEMENTADO NA FASE 9
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTabConsulta()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6

        *-- Criar cursors placeholder ANTES dos grids (evitar erro de RecordSource vazio)
        *-- cursor_4c_Consulta: SIGPRCPO - componentes com fase (SigCdPrf) e categoria (SigCdCat)
        IF !USED("cursor_4c_Consulta")
            SET NULL ON
            CREATE CURSOR cursor_4c_Consulta (mats C(14) NULL, qtds N(8,3) NULL, unicompos C(3) NULL, grupos C(10) NULL, dcompos C(40) NULL, ordems N(2,0) NULL, qtscons N(8,3) NULL, cats C(6) NULL, dscgrp C(20) NULL)
            SET NULL OFF
        ENDIF

        *-- cursor_4c_Temp: agrupamento x tempo (grDTEMP)
        IF !USED("cursor_4c_Temp")
            SET NULL ON
            CREATE CURSOR cursor_4c_Temp (grupos C(10) NULL, totas N(11,3) NULL)
            SET NULL OFF
        ENDIF

        *-- GrdCons - Grid de componentes consulta (top=155, left=6, width=987, height=362, 9 cols)
        *-- Colunas editaveis (INSERIR/ALTERAR): 4-Fase, 5-Descricao, 7-Consumo, 8-Cat
        *-- Colunas somente leitura: 1-Componente, 2-Qtde, 3-Uni, 6-Ord, 9-DescCat
        loc_oPg.AddObject("grd_4c_Consulta", "Grid")
        WITH loc_oPg.grd_4c_Consulta
            .Top         = 155
            .Left        = 6
            .Width       = 987
            .Height      = 362
            .ReadOnly    = .F.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 9
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        *-- RecordSource ANTES dos headers/ControlSources (evita reset de colunas)
        loc_oPg.grd_4c_Consulta.ColumnCount = 3
        loc_oPg.grd_4c_Consulta.RecordSource = "cursor_4c_Consulta"
        WITH loc_oPg.grd_4c_Consulta
            .Column1.Header1.Caption = "Componente"
            .Column1.Width           = 110
            .Column1.ControlSource   = "cursor_4c_Consulta.mats"
            .Column1.ReadOnly        = .T.
            .Column2.Header1.Caption = "Qtde."
            .Column2.Width           = 65
            .Column2.ControlSource   = "cursor_4c_Consulta.qtds"
            .Column2.ReadOnly        = .T.
            .Column3.Header1.Caption = "Uni"
            .Column3.Width           = 40
            .Column3.ControlSource   = "cursor_4c_Consulta.unicompos"
            .Column3.ReadOnly        = .T.
            .Column4.Header1.Caption = "Fase"
            .Column4.Width           = 80
            .Column4.ControlSource   = "cursor_4c_Consulta.grupos"
            .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column5.Width           = 180
            .Column5.ControlSource   = "cursor_4c_Consulta.dcompos"
            .Column6.Header1.Caption = "Ord."
            .Column6.Width           = 40
            .Column6.ControlSource   = "cursor_4c_Consulta.ordems"
            .Column6.ReadOnly        = .T.
            .Column7.Header1.Caption = "Consumo"
            .Column7.Width           = 75
            .Column7.ControlSource   = "cursor_4c_Consulta.qtscons"
            .Column8.Header1.Caption = "Cat."
            .Column8.Width           = 55
            .Column8.ControlSource   = "cursor_4c_Consulta.cats"
            .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column9.Width           = 150
            .Column9.ControlSource   = "cursor_4c_Consulta.dscgrp"
            .Column9.ReadOnly        = .T.
        ENDWITH
        BINDEVENT(loc_oPg.grd_4c_Consulta, "AfterRowColChange", THIS, "ConsultaGrd_AfterRowColChange")

        *-- Say7/lbl_4c_QtdCpnt: "Qtde Componentes :" (top=523, left=25)
        loc_oPg.AddObject("lbl_4c_QtdCpnt", "Label")
        WITH loc_oPg.lbl_4c_QtdCpnt
            .Caption   = "Qtde Componentes : "
            .Top       = 523
            .Left      = 25
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Getqtcpnt/txt_4c_QtdCpnt: quantidade de componentes (top=519, left=131, width=31)
        loc_oPg.AddObject("txt_4c_QtdCpnt", "TextBox")
        WITH loc_oPg.txt_4c_QtdCpnt
            .Top           = 519
            .Left          = 131
            .Width         = 31
            .Height        = 23
            .Value         = 0
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- chkFund/chk_4c_ChkFund: "Nao Checar Cadastro de Fundicao" (top=544, left=10)
        loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
        WITH loc_oPg.chk_4c_ChkFund
            .Caption  = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
            .Top      = 544
            .Left     = 10
            .Width    = 200
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
            .Themes   = .F.
        ENDWITH

        *-- Say1/lbl_4c_TempoProd: "Tempo Producao por Agrupamento :" (top=521, left=642)
        loc_oPg.AddObject("lbl_4c_TempoProd", "Label")
        WITH loc_oPg.lbl_4c_TempoProd
            .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
            .Top       = 521
            .Left      = 642
            .Width     = 176
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- grDTEMP/grd_4c_Temp: grid tempo producao (top=519, left=821, width=172, height=107, 2 cols)
        *-- Colunas: Agrupamento (grupos), Tempo % (totas) - somente leitura
        loc_oPg.AddObject("grd_4c_Temp", "Grid")
        WITH loc_oPg.grd_4c_Temp
            .Top         = 519
            .Left        = 821
            .Width       = 172
            .Height      = 107
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ScrollBars  = 3
            .GridLines   = 3
            .ColumnCount = 2
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH
        *-- RecordSource ANTES dos headers/ControlSources
        loc_oPg.grd_4c_Temp.ColumnCount = 3
        loc_oPg.grd_4c_Temp.RecordSource = "cursor_4c_Temp"
        WITH loc_oPg.grd_4c_Temp
            .Column1.Header1.Caption = "Agrupamento"
            .Column1.Width           = 100
            .Column1.ControlSource   = "cursor_4c_Temp.grupos"
            .Column2.Header1.Caption = "Tempo %"
            .Column2.Width           = 65
            .Column2.ControlSource   = "cursor_4c_Temp.totas"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTabFases - Aba 7: Fases de producao (PgDadosFaseP)
    * IMPLEMENTADO NA FASE 7
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTabFases()
        LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oCtrl, loc_oLbl, loc_oChk
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7

        *-- Cursor placeholder para GradFase (SigCdPrf)
        *-- ordems N(2,0), grupos C(10), minutos N(9,1), uniprdts C(10), matprdts C(15)
        IF !USED("cursor_4c_Fases")
            SET NULL ON
            CREATE CURSOR cursor_4c_Fases (ordems N(2,0) NULL, grupos C(10) NULL, minutos N(9,1) NULL, uniprdts C(10) NULL, matprdts C(15) NULL)
            SET NULL OFF
        ENDIF

        *-- Cursor placeholder para grdMatrizes (SigPrMtz + Locals de SigCdPro)
        IF !USED("cursor_4c_Matrizes")
            SET NULL ON
            CREATE CURSOR cursor_4c_Matrizes (cidchaves C(20) NULL, cmats C(14) NULL, cpros C(14) NULL, qtds N(3,0) NULL, locals C(10) NULL)
            SET NULL OFF
        ENDIF

        *======================================================
        *-- LABEL: Say13 - "Qtd. Min. Producao :"
        *======================================================
        loc_oPg.AddObject("lbl_4c_Qmin", "Label")
        WITH loc_oPg.lbl_4c_Qmin
            .Top      = 156
            .Left     = 33
            .Width    = 102
            .Height   = 15
            .Caption  = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *======================================================
        *-- TEXTBOX: getQmin - Qtde minima fabricacao
        *======================================================
        loc_oPg.AddObject("txt_4c_Qminfab", "TextBox")
        WITH loc_oPg.txt_4c_Qminfab
            .Top           = 152
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .InputMask     = "999,999.99"
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *======================================================
        *-- LABEL + TEXTBOX: getCodGarras - Garra
        *======================================================
        loc_oPg.AddObject("lbl_4c_Garra", "Label")
        WITH loc_oPg.lbl_4c_Garra
            .Top      = 181
            .Left     = 99
            .Width    = 36
            .Height   = 15
            .Caption  = "Garra :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Codgarras", "TextBox")
        WITH loc_oPg.txt_4c_Codgarras
            .Top           = 177
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *======================================================
        *-- LABEL + TEXTBOX: getConquilha - Conquilha
        *======================================================
        loc_oPg.AddObject("lbl_4c_Conquilha", "Label")
        WITH loc_oPg.lbl_4c_Conquilha
            .Top      = 206
            .Left     = 79
            .Width    = 57
            .Height   = 15
            .Caption  = "Conquilha :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Conquilhas", "TextBox")
        WITH loc_oPg.txt_4c_Conquilhas
            .Top           = 202
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *======================================================
        *-- LABEL + TEXTBOX: getPesoBris - Peso Brilhante
        *======================================================
        loc_oPg.AddObject("lbl_4c_PesoBri", "Label")
        WITH loc_oPg.lbl_4c_PesoBri
            .Top      = 231
            .Left     = 58
            .Width    = 77
            .Height   = 15
            .Caption  = "Peso Brilhante :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pesobris", "TextBox")
        WITH loc_oPg.txt_4c_Pesobris
            .Top           = 227
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .InputMask     = "99,999.999"
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *======================================================
        *-- LABEL + TEXTBOX: getPesoMetal - Peso Metal
        *======================================================
        loc_oPg.AddObject("lbl_4c_PesoMet", "Label")
        WITH loc_oPg.lbl_4c_PesoMet
            .Top      = 256
            .Left     = 74
            .Width    = 61
            .Height   = 15
            .Caption  = "Peso Metal :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pesometal", "TextBox")
        WITH loc_oPg.txt_4c_Pesometal
            .Top           = 252
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .InputMask     = "99,999.999"
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *======================================================
        *-- LABEL + TEXTBOX: getPesoPdrs - Peso Pedra
        *======================================================
        loc_oPg.AddObject("lbl_4c_PesoPed", "Label")
        WITH loc_oPg.lbl_4c_PesoPed
            .Top      = 281
            .Left     = 72
            .Width    = 63
            .Height   = 15
            .Caption  = "Peso Pedra :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pesopdrs", "TextBox")
        WITH loc_oPg.txt_4c_Pesopdrs
            .Top           = 277
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .InputMask     = "99,999.999"
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *======================================================
        *-- LABEL + TEXTBOX: getCor - Cor Padrao + checkbox CravCera
        *======================================================
        loc_oPg.AddObject("lbl_4c_CorPad", "Label")
        WITH loc_oPg.lbl_4c_CorPad
            .Top      = 306
            .Left     = 72
            .Width    = 63
            .Height   = 15
            .Caption  = "Cor Padr" + CHR(227) + "o :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CodcorsFas", "TextBox")
        WITH loc_oPg.txt_4c_CodcorsFas
            .Top           = 302
            .Left          = 137
            .Width         = 38
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
        WITH loc_oPg.chk_4c_CravCera
            .Top       = 306
            .Left      = 180
            .AutoSize  = .T.
            .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================
        *-- LABEL + TEXTBOX: getTam - Tamanho Padrao + checkbox PesoVariavel
        *======================================================
        loc_oPg.AddObject("lbl_4c_TamPad", "Label")
        WITH loc_oPg.lbl_4c_TamPad
            .Top      = 331
            .Left     = 45
            .Width    = 90
            .Height   = 15
            .Caption  = "Tamanho Padr" + CHR(227) + "o :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CodtamsFas", "TextBox")
        WITH loc_oPg.txt_4c_CodtamsFas
            .Top           = 327
            .Left          = 137
            .Width         = 38
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_PesoVari", "CheckBox")
        WITH loc_oPg.chk_4c_PesoVari
            .Top       = 331
            .Left      = 180
            .AutoSize  = .T.
            .Caption   = "Peso Vari" + CHR(225) + "vel"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================
        *-- LABEL + TEXTBOXES: get_codacb / get_Dacb - Acabamento
        *======================================================
        loc_oPg.AddObject("lbl_4c_Acabam", "Label")
        WITH loc_oPg.lbl_4c_Acabam
            .Top      = 356
            .Left     = 16
            .Width    = 119
            .Height   = 15
            .Caption  = "Acabamento :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CodacbsFas", "TextBox")
        WITH loc_oPg.txt_4c_CodacbsFas
            .Top           = 352
            .Left          = 137
            .Width         = 38
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DacbsFas", "TextBox")
        WITH loc_oPg.txt_4c_DacbsFas
            .Top           = 352
            .Left          = 177
            .Width         = 207
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *======================================================
        *-- GRID: grd_4c_Fases (GradFase) - 5 colunas - SigCdPrf
        *-- top=152, left=527, width=420, height=312
        *-- Ordem | Fase | Utilizacao | Uni. Produtiva | Material
        *======================================================
        loc_oPg.AddObject("grd_4c_Fases", "Grid")
        WITH loc_oPg.grd_4c_Fases
            .Top            = 152
            .Left           = 527
            .Width          = 420
            .Height         = 312
            .ReadOnly       = .F.
            .DeleteMark     = .F.
            .RecordMark     = .F.
            .GridLines      = 3
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Themes         = .F.
            .Visible        = .T.
        ENDWITH
        loc_oPg.grd_4c_Fases.ColumnCount = 5
        loc_oPg.grd_4c_Fases.RecordSource = "cursor_4c_Fases"
        WITH loc_oPg.grd_4c_Fases
            .Column1.Header1.Caption  = "Ordem"
            .Column1.Width            = 40
            .Column1.ControlSource    = "cursor_4c_Fases.ordems"
            .Column2.Header1.Caption  = "Fase"
            .Column2.Width            = 80
            .Column2.ControlSource    = "cursor_4c_Fases.grupos"
            .Column3.Header1.Caption  = "Utiliza" + CHR(231) + CHR(227) + "o"
            .Column3.Width            = 70
            .Column3.ControlSource    = "cursor_4c_Fases.minutos"
            .Column4.Header1.Caption  = "Uni. Produtiva"
            .Column4.Width            = 90
            .Column4.ControlSource    = "cursor_4c_Fases.uniprdts"
            .Column5.Header1.Caption  = "Material"
            .Column5.Width            = 120
            .Column5.ControlSource    = "cursor_4c_Fases.matprdts"
        ENDWITH

        *======================================================
        *-- GRID: grd_4c_Matrizes - 3 colunas - SigPrMtz
        *-- top=380, left=7, width=246, height=240
        *-- Matriz | Local | Qtde
        *======================================================
        loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
        WITH loc_oPg.grd_4c_Matrizes
            .Top            = 380
            .Left           = 7
            .Width          = 246
            .Height         = 240
            .ReadOnly       = .F.
            .DeleteMark     = .F.
            .RecordMark     = .F.
            .GridLines      = 3
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Themes         = .F.
            .Visible        = .T.
        ENDWITH
        loc_oPg.grd_4c_Matrizes.ColumnCount = 3
        loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_Matrizes"
        WITH loc_oPg.grd_4c_Matrizes
            .Column1.Header1.Caption  = "Matriz"
            .Column1.Width            = 100
            .Column1.ControlSource    = "cursor_4c_Matrizes.cmats"
            .Column2.Header1.Caption  = "Local"
            .Column2.Width            = 80
            .Column2.ControlSource    = "cursor_4c_Matrizes.locals"
            .Column3.Header1.Caption  = "Qtde"
            .Column3.Width            = 60
            .Column3.ControlSource    = "cursor_4c_Matrizes.qtds"
        ENDWITH

        *======================================================
        *-- LABEL + TEXTBOX: Get_Desc - Descricao da fase selecionada
        *======================================================
        loc_oPg.AddObject("lbl_4c_DescFase", "Label")
        WITH loc_oPg.lbl_4c_DescFase
            .Top      = 474
            .Left     = 527
            .Width    = 67
            .Height   = 17
            .Caption  = "Descri" + CHR(231) + CHR(227) + "o :"
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DescFase", "TextBox")
        WITH loc_oPg.txt_4c_DescFase
            .Top           = 471
            .Left          = 595
            .Width         = 395
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *======================================================
        *-- EDITBOX: Get_Obs - Observacao da fase selecionada (memo)
        *======================================================
        loc_oPg.AddObject("edt_4c_ObsFase", "EditBox")
        WITH loc_oPg.edt_4c_ObsFase
            .Top           = 497
            .Left          = 527
            .Width         = 463
            .Height        = 122
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ScrollBars    = 2
            .Visible       = .T.
        ENDWITH

        *======================================================
        *-- SHAPE: shp_4c_ShpFig - Borda ao redor da imagem da fase
        *-- top=152, left=231, width=244, height=148
        *======================================================
        loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
        WITH loc_oPg.shp_4c_ShpFig
            .Top         = 152
            .Left        = 231
            .Width       = 244
            .Height      = 148
            .BorderColor = RGB(150, 150, 150)
            .BorderWidth = 1
            .FillStyle   = 1
            .Curvature   = 0
            .Visible     = .T.
        ENDWITH

        *======================================================
        *-- IMAGE: img_4c_ImgFigJpg - Imagem da fase de producao
        *-- top=153, left=232, width=241, height=146
        *======================================================
        loc_oPg.AddObject("img_4c_ImgFigJpg", "Image")
        WITH loc_oPg.img_4c_ImgFigJpg
            .Top     = 153
            .Left    = 232
            .Width   = 241
            .Height  = 146
            .Stretch = 2
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")

        *======================================================
        *-- BUTTON: cmd_4c_CmdFicha - Imprimir ficha da fase
        *-- top=152, left=482
        *======================================================
        loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
        WITH loc_oPg.cmd_4c_CmdFicha
            .Caption       = "Ficha"
            .Top           = 152
            .Left          = 482
            .Width         = 38
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")

        *======================================================
        *-- BUTTON: cmd_4c_CmdgFigura - Carregar imagem da fase (cmdgFigura)
        *-- top=192, left=482
        *======================================================
        loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
        WITH loc_oPg.cmd_4c_CmdgFigura
            .Caption       = "..."
            .Top           = 192
            .Left          = 482
            .Width         = 38
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")

        *======================================================
        *-- BUTTON: cmd_4c_CmdgFigCam - Camera para imagem de borracha (cmdgFigCam)
        *-- top=232, left=482
        *======================================================
        loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
        WITH loc_oPg.cmd_4c_CmdgFigCam
            .Caption       = "..."
            .Top           = 232
            .Left          = 482
            .Width         = 38
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")

        *======================================================
        *-- BUTTON: cmd_4c_InserirFase - Inserir nova fase (inserir)
        *-- top=152, left=950
        *======================================================
        loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
        WITH loc_oPg.cmd_4c_InserirFase
            .Caption       = "Inserir"
            .Top           = 152
            .Left          = 950
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")

        *======================================================
        *-- BUTTON: cmd_4c_ExcluirFase - Excluir fase (excluir)
        *-- top=192, left=950
        *======================================================
        loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
        WITH loc_oPg.cmd_4c_ExcluirFase
            .Caption       = "Excluir"
            .Top           = 192
            .Left          = 950
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")

        *======================================================
        *-- BUTTON: cmd_4c_Alternativa - Alternativa de fase
        *-- top=232, left=950
        *======================================================
        loc_oPg.AddObject("cmd_4c_Alternativa", "CommandButton")
        WITH loc_oPg.cmd_4c_Alternativa
            .Caption       = "Altern."
            .Top           = 232
            .Left          = 950
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_Alternativa, "Click", THIS, "BtnAlternativaFaseClick")

        *======================================================
        *-- BUTTON: cmd_4c_BtnInsereMtx - Inserir linha na grade de matrizes
        *-- top=380, left=258
        *======================================================
        loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnInsereMtx
            .Caption       = "+"
            .Top           = 380
            .Left          = 258
            .Width         = 23
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 10
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInserirMatrizClick")

        *======================================================
        *-- BUTTON: cmd_4c_BtnExcluiMtz - Excluir linha da grade de matrizes
        *-- top=420, left=258
        *======================================================
        loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnExcluiMtz
            .Caption       = "-"
            .Top           = 420
            .Left          = 258
            .Width         = 23
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 10
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluirMatrizClick")

        *======================================================
        *-- SHAPE: shp_4c_ShpBorracha - Borda ao redor da imagem da borracha
        *-- top=464, left=258, width=236, height=156
        *======================================================
        loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
        WITH loc_oPg.shp_4c_ShpBorracha
            .Top         = 464
            .Left        = 258
            .Width       = 236
            .Height      = 156
            .BorderColor = RGB(150, 150, 150)
            .BorderWidth = 1
            .FillStyle   = 1
            .Curvature   = 0
            .Visible     = .T.
        ENDWITH

        *======================================================
        *-- IMAGE: img_4c_ImgBorracha - Imagem da borracha (molde)
        *-- top=465, left=260, width=232, height=154
        *======================================================
        loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
        WITH loc_oPg.img_4c_ImgBorracha
            .Top     = 465
            .Left    = 260
            .Width   = 232
            .Height  = 154
            .Stretch = 2
            .Visible = .F.
        ENDWITH

        *======================================================
        *-- BINDEVENTs para grids (AfterRowColChange)
        *======================================================
        BINDEVENT(loc_oPg.grd_4c_Fases,    "AfterRowColChange", THIS, "GrdFasesAfterRowColChange")
        BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")

        *======================================================
        *-- BINDEVENTs para lookups da aba Fases
        *======================================================
        BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "KeyPress", THIS, "TabFases_CodcorsKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "KeyPress", THIS, "TabFases_CodcorsLostFocus")
        BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "KeyPress", THIS, "TabFases_CodtamsKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "KeyPress", THIS, "TabFases_CodtamsLostFocus")
        BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "KeyPress", THIS, "TabFases_CodacbsKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "KeyPress", THIS, "TabFases_CodacbsLostFocus")
        BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "KeyPress", THIS, "TabFases_ConquilhaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "KeyPress", THIS, "TabFases_ConquilhaLostFocus")
        BINDEVENT(loc_oPg.txt_4c_Codgarras,   "KeyPress", THIS, "TabFases_GarraKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Codgarras,   "KeyPress", THIS, "TabFases_GarraLostFocus")

    ENDPROC

    *--------------------------------------------------------------------------
    * OptSituasChange - OptionGroup Situacao muda Ativo/Inativo
    *--------------------------------------------------------------------------
    PROCEDURE OptSituasChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
            IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
                IF loc_oPg.opt_4c_Situas.Value = 2
                    loc_oPg.txt_4c_DtSituas.Value = DATE()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptProdWebChange - OptionGroup Produto Web muda valor
    *--------------------------------------------------------------------------
    PROCEDURE OptProdWebChange()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * OptVariasChange - OptionGroup Variacao muda valor
    *--------------------------------------------------------------------------
    PROCEDURE OptVariasChange()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * OpcaoAbasChange - Navegacao entre abas pelo OptionGroup
    * Legado: Optiongroup1.InteractiveChange
    *--------------------------------------------------------------------------
    PROCEDURE OpcaoAbasChange()
        LOCAL loc_nAba, loc_lTemProduto
        loc_nAba      = THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value
        loc_lTemProduto = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))

        DO CASE
            CASE loc_nAba = 1   && Principal
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
            CASE loc_nAba = 2   && Composicao
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 2
                IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarComposicao()
                ENDIF
            CASE loc_nAba = 3   && Custos
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 3
                IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarCustos()
                ENDIF
            CASE loc_nAba = 4   && Dados Fiscais
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 4
                IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarDadosFiscais()
                ENDIF
            CASE loc_nAba = 5   && Designer
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 5
            CASE loc_nAba = 6   && Consulta P.
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 6
                IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarConsultaP()
                ENDIF
            CASE loc_nAba = 7   && Fases
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 7
                IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarFases()
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca e exibe lista de produtos no grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_lResultado, loc_cFiltro, loc_cWhere
        LOCAL loc_cCgru, loc_dIni, loc_dFim, loc_nSit
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            *-- Montar filtro a partir dos controles
            loc_cWhere = ""
            loc_cFiltro = ""

            *-- Filtro grupo
            loc_cCgru = ""
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru, "Value", 5)
                    loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
                ENDIF
            ENDIF

            IF !EMPTY(loc_cCgru)
                loc_cFiltro = "p.cgrus = " + EscaparSQL(loc_cCgru)
            ENDIF

            *-- Filtro situacao
            loc_nSit = 1
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas, "Value", 5)
                    loc_nSit = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas.Value
                ENDIF
            ENDIF

            IF loc_nSit = 2   && Apenas ativos (situas=1)
                IF !EMPTY(loc_cFiltro)
                    loc_cFiltro = loc_cFiltro + " AND p.situas = 1"
                ELSE
                    loc_cFiltro = "p.situas = 1"
                ENDIF
            ENDIF
            IF loc_nSit = 3   && Apenas inativos (situas=2)
                IF !EMPTY(loc_cFiltro)
                    loc_cFiltro = loc_cFiltro + " AND p.situas = 2"
                ELSE
                    loc_cFiltro = "p.situas = 2"
                ENDIF
            ENDIF

            *-- Filtro data ultima alteracao
            loc_dIni = {}
            loc_dFim = {}
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDataIni, "Value", 5)
                    loc_dIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDataIni.Value
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDataFim, "Value", 5)
                    loc_dFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDataFim.Value
                ENDIF
            ENDIF


            *-- Buscar dados no BO
            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_lResultado = .F.
            ELSE
                *-- Definir RecordSource (ISSO RESETA AS COLUNAS)
                loc_oGrid.ColumnCount = 7
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- Reconfigurar ControlSource APOS RecordSource
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.usuaalts"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"

                *-- Larguras
                loc_oGrid.Column1.Width = 110
                loc_oGrid.Column2.Width = 330
                loc_oGrid.Column3.Width = 55
                loc_oGrid.Column4.Width = 60
                loc_oGrid.Column5.Width = 160
                loc_oGrid.Column6.Width = 120
                loc_oGrid.Column7.Width = 40

                *-- Cabecalhos (legado: Produto, Descricao, Grupo, Subgrp., Ref. Fornecedor, Usuario, I)
                loc_oGrid.Column1.Header1.Caption = "Produto"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Grupo"
                loc_oGrid.Column4.Header1.Caption = "Subgrp."
                loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
                loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
                loc_oGrid.Column7.Header1.Caption = "I"

                THIS.FormatarGridLista(loc_oGrid)

                *-- Atualizar contador de produtos
                LOCAL loc_nTotal
                loc_nTotal = IIF(USED("cursor_4c_Dados"), RECCOUNT("cursor_4c_Dados"), 0)
                THIS.pgf_4c_Paginas.Page1.lbl_4c_ContadorProdutos.Caption = LTRIM(STR(loc_nTotal)) + " produto(s)"

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do formulario para o Business Object
    * Todos os campos editaveis da aba Principal
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oPg
        loc_oBO = THIS.this_oBusinessObject
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- Identificacao
        IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
            loc_oBO.this_cCpros  = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
            loc_oBO.this_cDpros  = ALLTRIM(loc_oPg.txt_4c_Dpros.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
            loc_oBO.this_cDpro2s = ALLTRIM(loc_oPg.txt_4c_Dpro2s.Value)
        ENDIF

        *-- Grupo / Subgrupo
        IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
            loc_oBO.this_cCgrus  = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
            loc_oBO.this_cSgrus  = ALLTRIM(loc_oPg.txt_4c_Csgrus.Value)
        ENDIF

        *-- Linha / Colecao / Fornecedor / Referencia
        IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
            loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
            loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
            loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
            loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Reffs.Value)
        ENDIF

        *-- Tipo / Identificador / Conjunto / Equivalente
        IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
            loc_oBO.this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Mercs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Idecpros", 5)
            loc_oBO.this_cIdecpros = ALLTRIM(loc_oPg.txt_4c_Idecpros.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Conjunts", 5)
            loc_oBO.this_cConjunts = ALLTRIM(loc_oPg.txt_4c_Conjunts.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
            loc_oBO.this_cCproeqs  = ALLTRIM(loc_oPg.txt_4c_Cproeqs.Value)
        ENDIF

        *-- Codigos de Barra (NUMERIC)
        IF PEMSTATUS(loc_oPg, "txt_4c_Cbars", 5)
            loc_oBO.this_nCbars = loc_oPg.txt_4c_Cbars.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ean13", 5)
            loc_oBO.this_nEan13 = loc_oPg.txt_4c_Ean13.Value
        ENDIF

        *-- Situacao (OptionGroup Value=1=Ativo, Value=2=Inativo -> nSituas)
        IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
            loc_oBO.this_nSituas = loc_oPg.opt_4c_Situas.Value
        ENDIF

        *-- Lote Minimo / Qtde
        IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
            loc_oBO.this_nLtminsv = loc_oPg.txt_4c_Ltminsv.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
            loc_oBO.this_nQmins   = loc_oPg.txt_4c_Qmins.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
            loc_oBO.this_nQtped   = loc_oPg.txt_4c_Qtped.Value
        ENDIF

        *-- Observacoes curtas
        IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
            loc_oBO.this_cObsetqs = ALLTRIM(loc_oPg.txt_4c_Obsetqs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
            loc_oBO.this_cObspeds = ALLTRIM(loc_oPg.txt_4c_Obspeds.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
            loc_oBO.this_cObspes  = ALLTRIM(loc_oPg.txt_4c_Obspes.Value)
        ENDIF

        *-- Custo / Moeda custo
        IF PEMSTATUS(loc_oPg, "txt_4c_Custofs", 5)
            loc_oBO.this_nCustofs = loc_oPg.txt_4c_Custofs.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
            loc_oBO.this_cMoecs   = ALLTRIM(loc_oPg.txt_4c_Moecs.Value)
        ENDIF

        *-- Preco / Moeda preco
        IF PEMSTATUS(loc_oPg, "txt_4c_Pvens", 5)
            loc_oBO.this_nPvens   = loc_oPg.txt_4c_Pvens.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
            loc_oBO.this_cMoepvs  = ALLTRIM(loc_oPg.txt_4c_Moepvs.Value)
        ENDIF

        *-- Fator / Moeda fator
        IF PEMSTATUS(loc_oPg, "txt_4c_Fvendas", 5)
            loc_oBO.this_nFvendas = loc_oPg.txt_4c_Fvendas.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moevs", 5)
            loc_oBO.this_cMoevs   = ALLTRIM(loc_oPg.txt_4c_Moevs.Value)
        ENDIF

        *-- Unidades
        IF PEMSTATUS(loc_oPg, "txt_4c_Cunis", 5)
            loc_oBO.this_cCunis  = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cunips", 5)
            loc_oBO.this_cCunips = ALLTRIM(loc_oPg.txt_4c_Cunips.Value)
        ENDIF

        *-- Classificacao / Modelo / Acabamento / Local
        IF PEMSTATUS(loc_oPg, "txt_4c_Cclass", 5)
            loc_oBO.this_cCclass  = ALLTRIM(loc_oPg.txt_4c_Cclass.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codfinp", 5)
            loc_oBO.this_cCodfinp = ALLTRIM(loc_oPg.txt_4c_Codfinp.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
            loc_oBO.this_cCodacbs = ALLTRIM(loc_oPg.txt_4c_Codacbs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Locals", 5)
            loc_oBO.this_cLocals  = ALLTRIM(loc_oPg.txt_4c_Locals.Value)
        ENDIF

        *-- Pesos / Cor / Tamanho / Cod.Identidade
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesobs", 5)
            loc_oBO.this_nPesobs   = loc_oPg.txt_4c_Pesobs.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesoms", 5)
            loc_oBO.this_nPesoms   = loc_oPg.txt_4c_Pesoms.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
            loc_oBO.this_cCodcors  = ALLTRIM(loc_oPg.txt_4c_Codcors.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
            loc_oBO.this_cCodtams  = ALLTRIM(loc_oPg.txt_4c_Codtams.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codident", 5)
            loc_oBO.this_cCodident = ALLTRIM(loc_oPg.txt_4c_Codident.Value)
        ENDIF

        *-- Garantia / CheckBox vitalicia
        IF PEMSTATUS(loc_oPg, "txt_4c_Diasgar", 5)
            loc_oBO.this_nDiasgar   = loc_oPg.txt_4c_Diasgar.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
            loc_oBO.this_lChkgarvit = (loc_oPg.chk_4c_Chkgarvit.Value = 1)
        ENDIF

        *-- Produto Web (Value=1=Nao=.F., Value>1=Sim=.T.)
        IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
            loc_oBO.this_lProdwebs = (loc_oPg.opt_4c_ProdWeb.Value > 1)
        ENDIF

        *-- Variacao (Value=1=Sim=.T., Value=2=Nao=.F.)
        IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
            loc_oBO.this_lVarias = (loc_oPg.opt_4c_Varias.Value = 1)
        ENDIF

        *-- CheckBoxes situacao produto
        IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
            loc_oBO.this_lConsigs    = (loc_oPg.chk_4c_Consigs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
            loc_oBO.this_lFabrproprs = (loc_oPg.chk_4c_Fabrproprs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
            loc_oBO.this_lEncoms     = (loc_oPg.chk_4c_Encoms.Value = 1)
        ENDIF

        *-- Entrega / Dimensoes / Volumes
        IF PEMSTATUS(loc_oPg, "txt_4c_Tents", 5)
            loc_oBO.this_nTents      = loc_oPg.txt_4c_Tents.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Altura", 5)
            loc_oBO.this_nAltura     = loc_oPg.txt_4c_Altura.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Largura", 5)
            loc_oBO.this_nLargura    = loc_oPg.txt_4c_Largura.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Diametro", 5)
            loc_oBO.this_nDiametro   = loc_oPg.txt_4c_Diametro.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Espessura", 5)
            loc_oBO.this_nEspessura  = loc_oPg.txt_4c_Espessura.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Compriment", 5)
            loc_oBO.this_nCompriment = loc_oPg.txt_4c_Compriment.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Volumes", 5)
            loc_oBO.this_nVolumes    = loc_oPg.txt_4c_Volumes.Value
        ENDIF

        *-- Campos Memo (TEXT)
        IF PEMSTATUS(loc_oPg, "edt_4c_Dsccompras", 5)
            loc_oBO.this_cDsccompras = loc_oPg.edt_4c_Dsccompras.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "edt_4c_Dpro3s", 5)
            loc_oBO.this_cDpro3s     = loc_oPg.edt_4c_Dpro3s.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "edt_4c_Obscompras", 5)
            loc_oBO.this_cObscompras = loc_oPg.edt_4c_Obscompras.Value
        ENDIF

        *-- Tab 7: Fases - campos de propriedades do produto editaveis nesta aba
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        IF PEMSTATUS(loc_oPg, "txt_4c_Qminfab", 5)
            loc_oBO.this_nQtminfabs = loc_oPg.txt_4c_Qminfab.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
            loc_oBO.this_cCodgarras  = ALLTRIM(loc_oPg.txt_4c_Codgarras.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
            loc_oBO.this_cConquilhas = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesobris", 5)
            loc_oBO.this_nPesobris   = loc_oPg.txt_4c_Pesobris.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesometal", 5)
            loc_oBO.this_nPesometal  = loc_oPg.txt_4c_Pesometal.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesopdrs", 5)
            loc_oBO.this_nPesopdrs   = loc_oPg.txt_4c_Pesopdrs.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_CodcorsFas", 5)
            loc_oBO.this_cCodcors    = ALLTRIM(loc_oPg.txt_4c_CodcorsFas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_CodtamsFas", 5)
            loc_oBO.this_cCodtams    = ALLTRIM(loc_oPg.txt_4c_CodtamsFas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_CodacbsFas", 5)
            loc_oBO.this_cCodacbs    = ALLTRIM(loc_oPg.txt_4c_CodacbsFas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_CravCera", 5)
            loc_oBO.this_lCravcers   = (loc_oPg.chk_4c_CravCera.Value = 1)
        ENDIF

        *-- Tab 4: Dados Fiscais (editaveis)
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
            loc_oBO.this_cClfiscals  = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
            loc_oBO.this_cOrigmercs  = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
            loc_oBO.this_cSittricms  = ALLTRIM(loc_oPg.txt_4c_Sittricms.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Icms", 5)
            loc_oBO.this_nIcms       = loc_oPg.txt_4c_Icms.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
            loc_oBO.this_cTptribs    = ALLTRIM(loc_oPg.txt_4c_Tptribs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
            loc_oBO.this_cCodservs   = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "cmb_4c_Ipi", 5)
            loc_oBO.this_cIpis       = ALLTRIM(loc_oPg.cmb_4c_Ipi.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DescFis", 5)
            loc_oBO.this_cDescfis    = loc_oPg.txt_4c_DescFis.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
            loc_oBO.this_cMetals     = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
            loc_oBO.this_cTeors      = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DescEcfs", 5)
            loc_oBO.this_cDescecfs   = ALLTRIM(loc_oPg.txt_4c_DescEcfs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Valors", 5)
            loc_oBO.this_nValors     = loc_oPg.txt_4c_Valors.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
            loc_oBO.this_cMoedas     = ALLTRIM(loc_oPg.txt_4c_Moedas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
            loc_oBO.this_nAliqipis   = loc_oPg.txt_4c_AliqIPI.Value
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
            loc_oBO.this_cExtipi     = ALLTRIM(loc_oPg.txt_4c_Extipi.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
            loc_oBO.this_cIats       = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            loc_oBO.this_cGruccus    = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
            loc_oBO.this_cContaccus  = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para o formulario
    * Inclui carga de descricoes de campos lookup via SQL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPg
        loc_oBO = THIS.this_oBusinessObject
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- Identificacao
        IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
            loc_oPg.txt_4c_Cpros.Value  = loc_oBO.this_cCpros
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
            loc_oPg.txt_4c_Dpros.Value  = loc_oBO.this_cDpros
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
            loc_oPg.txt_4c_Dpro2s.Value = loc_oBO.this_cDpro2s
        ENDIF

        *-- Grupo + descricao
        IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
            loc_oPg.txt_4c_Cgrus.Value = loc_oBO.this_cCgrus
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
            loc_oPg.txt_4c_Dgrus.Value = THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus")
        ENDIF

        *-- Subgrupo + descricao
        IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
            loc_oPg.txt_4c_Csgrus.Value = loc_oBO.this_cSgrus
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
            loc_oPg.txt_4c_Dsgrus.Value = THIS.CarregarDescSgru(loc_oBO.this_cCgrus, loc_oBO.this_cSgrus)
        ENDIF

        *-- Linha + descricao
        IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
            loc_oPg.txt_4c_Linhas.Value  = loc_oBO.this_cLinhas
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
            loc_oPg.txt_4c_Dlinhas.Value = THIS.CarregarDesc("SigCdLin", "Linhas", loc_oBO.this_cLinhas, "Descs")
        ENDIF

        *-- Colecao + descricao
        IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
            loc_oPg.txt_4c_Colecoes.Value  = loc_oBO.this_cColecoes
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
            loc_oPg.txt_4c_Dcolecoes.Value = THIS.CarregarDesc("SigCdCol", "Colecoes", loc_oBO.this_cColecoes, "Descs")
        ENDIF

        *-- Fornecedor + nome
        IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
            loc_oPg.txt_4c_Ifors.Value = loc_oBO.this_cIfors
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
            loc_oPg.txt_4c_Dfors.Value = THIS.CarregarDesc("SigCdCli", "IClis", loc_oBO.this_cIfors, "Rclis")
        ENDIF

        *-- Referencia
        IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
            loc_oPg.txt_4c_Reffs.Value = loc_oBO.this_cReffs
        ENDIF

        *-- Tipo / Identificador / Conjunto / Equivalente
        IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
            loc_oPg.txt_4c_Mercs.Value    = loc_oBO.this_cMercs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Idecpros", 5)
            loc_oPg.txt_4c_Idecpros.Value = loc_oBO.this_cIdecpros
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Conjunts", 5)
            loc_oPg.txt_4c_Conjunts.Value = loc_oBO.this_cConjunts
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
            loc_oPg.txt_4c_Cproeqs.Value  = loc_oBO.this_cCproeqs
        ENDIF

        *-- Codigos de Barra (NUMERIC)
        IF PEMSTATUS(loc_oPg, "txt_4c_Cbars", 5)
            loc_oPg.txt_4c_Cbars.Value = loc_oBO.this_nCbars
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ean13", 5)
            loc_oPg.txt_4c_Ean13.Value = loc_oBO.this_nEan13
        ENDIF

        *-- Situacao (nSituas 1=Ativo, 2=Inativo -> OptionGroup.Value)
        IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
            loc_oPg.opt_4c_Situas.Value = IIF(loc_oBO.this_nSituas >= 1, loc_oBO.this_nSituas, 1)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
            loc_oPg.txt_4c_DtSituas.Value = NVL(loc_oBO.this_dDtsituas, {})
        ENDIF

        *-- Lote Minimo / Qtde
        IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
            loc_oPg.txt_4c_Ltminsv.Value = loc_oBO.this_nLtminsv
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
            loc_oPg.txt_4c_Qmins.Value   = loc_oBO.this_nQmins
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
            loc_oPg.txt_4c_Qtped.Value   = loc_oBO.this_nQtped
        ENDIF

        *-- Observacoes curtas
        IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
            loc_oPg.txt_4c_Obsetqs.Value = loc_oBO.this_cObsetqs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
            loc_oPg.txt_4c_Obspeds.Value = loc_oBO.this_cObspeds
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
            loc_oPg.txt_4c_Obspes.Value  = loc_oBO.this_cObspes
        ENDIF

        *-- Ultima Compra (ReadOnly)
        IF PEMSTATUS(loc_oPg, "txt_4c_Dtucp", 5)
            loc_oPg.txt_4c_Dtucp.Value      = NVL(loc_oBO.this_dUltcomps, {})
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Vucp", 5)
            loc_oPg.txt_4c_Vucp.Value       = loc_oBO.this_nVultcomps
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Mucp", 5)
            loc_oPg.txt_4c_Mucp.Value       = loc_oBO.this_cMultcomps
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qtdultcomp", 5)
            loc_oPg.txt_4c_Qtdultcomp.Value = loc_oBO.this_nQtdultcomp
        ENDIF

        *-- Custo / Moeda custo
        IF PEMSTATUS(loc_oPg, "txt_4c_Custofs", 5)
            loc_oPg.txt_4c_Custofs.Value = loc_oBO.this_nCustofs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
            loc_oPg.txt_4c_Moecs.Value   = loc_oBO.this_cMoecs
        ENDIF

        *-- Preco / Moeda preco
        IF PEMSTATUS(loc_oPg, "txt_4c_Pvens", 5)
            loc_oPg.txt_4c_Pvens.Value  = loc_oBO.this_nPvens
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
            loc_oPg.txt_4c_Moepvs.Value = loc_oBO.this_cMoepvs
        ENDIF

        *-- Fator / Moeda fator
        IF PEMSTATUS(loc_oPg, "txt_4c_Fvendas", 5)
            loc_oPg.txt_4c_Fvendas.Value = loc_oBO.this_nFvendas
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moevs", 5)
            loc_oPg.txt_4c_Moevs.Value   = loc_oBO.this_cMoevs
        ENDIF

        *-- Auditoria (ReadOnly)
        IF PEMSTATUS(loc_oPg, "txt_4c_DtIncs", 5)
            loc_oPg.txt_4c_DtIncs.Value   = NVL(loc_oBO.this_dDtincs, {})
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Usuincs", 5)
            loc_oPg.txt_4c_Usuincs.Value  = loc_oBO.this_cUsuincs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DtAlts", 5)
            loc_oPg.txt_4c_DtAlts.Value   = NVL(loc_oBO.this_dDtalts, {})
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_UsuaAlts", 5)
            loc_oPg.txt_4c_UsuaAlts.Value = loc_oBO.this_cUsuaalts
        ENDIF

        *-- Unidades + descricoes
        IF PEMSTATUS(loc_oPg, "txt_4c_Cunis", 5)
            loc_oPg.txt_4c_Cunis.Value  = loc_oBO.this_cCunis
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
            loc_oPg.txt_4c_Dunis.Value  = THIS.CarregarDesc("SigCdUni", "cunis", loc_oBO.this_cCunis, "dunis")
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cunips", 5)
            loc_oPg.txt_4c_Cunips.Value = loc_oBO.this_cCunips
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
            loc_oPg.txt_4c_Dunips.Value = THIS.CarregarDesc("SigCdUni", "cunis", loc_oBO.this_cCunips, "dunis")
        ENDIF

        *-- Classificacao / Modelo / Acabamento / Local + descricoes
        IF PEMSTATUS(loc_oPg, "txt_4c_Cclass", 5)
            loc_oPg.txt_4c_Cclass.Value   = loc_oBO.this_cCclass
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dclass", 5)
            loc_oPg.txt_4c_Dclass.Value   = THIS.CarregarDesc("SigCdCls", "cods", loc_oBO.this_cCclass, "descs")
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codfinp", 5)
            loc_oPg.txt_4c_Codfinp.Value  = loc_oBO.this_cCodfinp
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dcodfinp", 5)
            loc_oPg.txt_4c_Dcodfinp.Value = THIS.CarregarDesc("SigCdFip", "cods", loc_oBO.this_cCodfinp, "descs")
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
            loc_oPg.txt_4c_Codacbs.Value  = loc_oBO.this_cCodacbs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
            loc_oPg.txt_4c_Dcodacbs.Value = THIS.CarregarDesc("SigCdAca", "cods", loc_oBO.this_cCodacbs, "descrs")
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Locals", 5)
            loc_oPg.txt_4c_Locals.Value   = loc_oBO.this_cLocals
        ENDIF

        *-- Pesos / Cor / Tamanho / Cod.Identidade
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesobs", 5)
            loc_oPg.txt_4c_Pesobs.Value   = loc_oBO.this_nPesobs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesoms", 5)
            loc_oPg.txt_4c_Pesoms.Value   = loc_oBO.this_nPesoms
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
            loc_oPg.txt_4c_Codcors.Value  = loc_oBO.this_cCodcors
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
            loc_oPg.txt_4c_Codtams.Value  = loc_oBO.this_cCodtams
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codident", 5)
            loc_oPg.txt_4c_Codident.Value = loc_oBO.this_cCodident
        ENDIF

        *-- Garantia / CheckBox vitalicia
        IF PEMSTATUS(loc_oPg, "txt_4c_Diasgar", 5)
            loc_oPg.txt_4c_Diasgar.Value    = loc_oBO.this_nDiasgar
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
            loc_oPg.chk_4c_Chkgarvit.Value = loc_oBO.this_lChkgarvit
        ENDIF

        *-- Produto Web (lProdwebs .T.=Sim->Value=2, .F.=Nao->Value=1)
        IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
            loc_oPg.opt_4c_ProdWeb.Value = IIF(loc_oBO.this_lProdwebs, 2, 1)
        ENDIF

        *-- Variacao (lVarias .T.=Sim->Value=1, .F.=Nao->Value=2)
        IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
            loc_oPg.opt_4c_Varias.Value = IIF(loc_oBO.this_lVarias, 1, 2)
        ENDIF

        *-- CheckBoxes situacao produto
        IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
            loc_oPg.chk_4c_Consigs.Value    = loc_oBO.this_lConsigs
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
            loc_oPg.chk_4c_Fabrproprs.Value = loc_oBO.this_lFabrproprs
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
            loc_oPg.chk_4c_Encoms.Value     = loc_oBO.this_lEncoms
        ENDIF

        *-- Entrega / Dimensoes / Volumes
        IF PEMSTATUS(loc_oPg, "txt_4c_Tents", 5)
            loc_oPg.txt_4c_Tents.Value      = loc_oBO.this_nTents
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Altura", 5)
            loc_oPg.txt_4c_Altura.Value     = loc_oBO.this_nAltura
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Largura", 5)
            loc_oPg.txt_4c_Largura.Value    = loc_oBO.this_nLargura
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Diametro", 5)
            loc_oPg.txt_4c_Diametro.Value   = loc_oBO.this_nDiametro
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Espessura", 5)
            loc_oPg.txt_4c_Espessura.Value  = loc_oBO.this_nEspessura
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Compriment", 5)
            loc_oPg.txt_4c_Compriment.Value = loc_oBO.this_nCompriment
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Volumes", 5)
            loc_oPg.txt_4c_Volumes.Value    = loc_oBO.this_nVolumes
        ENDIF

        *-- Campos Memo (TEXT)
        IF PEMSTATUS(loc_oPg, "edt_4c_Dsccompras", 5)
            loc_oPg.edt_4c_Dsccompras.Value = loc_oBO.this_cDsccompras
        ENDIF
        IF PEMSTATUS(loc_oPg, "edt_4c_Dpro3s", 5)
            loc_oPg.edt_4c_Dpro3s.Value     = loc_oBO.this_cDpro3s
        ENDIF
        IF PEMSTATUS(loc_oPg, "edt_4c_Obscompras", 5)
            loc_oPg.edt_4c_Obscompras.Value = loc_oBO.this_cObscompras
        ENDIF

        *-- Tab 2: Composicao (Page2 de pgf_4c_Dados)
        *-- Popula campos de custo, venda, peso e configuracoes de composicao
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        *-- Campos de preco de custo
        IF PEMSTATUS(loc_oPg, "txt_4c_Pcus", 5)
            loc_oPg.txt_4c_Pcus.Value      = loc_oBO.this_nPcuss
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
            loc_oPg.txt_4c_PcusMoe.Value   = loc_oBO.this_cMoecs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Fcusto", 5)
            loc_oPg.txt_4c_Fcusto.Value    = loc_oBO.this_nFcustos
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_PcusMoepc", 5)
            loc_oPg.txt_4c_PcusMoepc.Value = loc_oBO.this_cMoepcs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Custof", 5)
            loc_oPg.txt_4c_Custof.Value    = loc_oBO.this_nCustofs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_MoecusFoe", 5)
            loc_oPg.txt_4c_MoecusFoe.Value = loc_oBO.this_cMoecusfs
        ENDIF

        *-- CFTI custo / markup custo
        IF PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
            loc_oPg.txt_4c_Cmkpc.Value     = loc_oBO.this_cCftiocs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__pftioc", 5)
            loc_oPg.txt_4c__pftioc.Value   = loc_oBO.this_nPftiocs
        ENDIF

        *-- Preco ideal / MKP / Moeda
        IF PEMSTATUS(loc_oPg, "txt_4c_Margem", 5)
            loc_oPg.txt_4c_Margem.Value    = loc_oBO.this_nMargens
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pvideal", 5)
            loc_oPg.txt_4c_Pvideal.Value   = loc_oBO.this_nPvideals
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
            loc_oPg.txt_4c_Moeda.Value     = loc_oBO.this_cMoedas
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_FIdeals", 5)
            loc_oPg.txt_4c_FIdeals.Value   = loc_oBO.this_nFideals
        ENDIF

        *-- CFTI venda / status
        IF PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
            loc_oPg.txt_4c_Status.Value    = loc_oBO.this_cStatus
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
            loc_oPg.txt_4c_Ftio.Value      = loc_oBO.this_cCftios
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pftio", 5)
            loc_oPg.txt_4c_Pftio.Value     = loc_oBO.this_nPftios
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Mftio", 5)
            loc_oPg.txt_4c_Mftio.Value     = loc_oBO.this_cMftios
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
            loc_oPg.txt_4c_Fvenda.Value    = loc_oBO.this_nFvendas
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
            loc_oPg.txt_4c_Moepv.Value     = loc_oBO.this_cMoepvs
        ENDIF

        *-- Preco de venda atual / fator atual / encargos / cotacao
        IF PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
            loc_oPg.txt_4c_Pven.Value      = loc_oBO.this_nPvens
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
            loc_oPg.txt_4c_Moev.Value      = loc_oBO.this_cMoevs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_FAtuals", 5)
            loc_oPg.txt_4c_FAtuals.Value   = loc_oBO.this_nFatuals
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Encarg", 5)
            loc_oPg.txt_4c_Encarg.Value    = loc_oBO.this_nEncargos
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_CotaCalcP", 5)
            loc_oPg.txt_4c_CotaCalcP.Value = loc_oBO.this_nCotacalcp
        ENDIF

        *-- Peso medio / markup aplicado
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
            loc_oPg.txt_4c_Pesom.Value     = loc_oBO.this_nPesoms
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_MarkupA", 5)
            loc_oPg.txt_4c_MarkupA.Value   = loc_oBO.this_nMarkupa
        ENDIF

        *-- Material principal (exibicao)
        IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
            loc_oPg.txt_4c_MatP.Value      = loc_oBO.this_cMatprincs
        ENDIF

        *-- Container cntMtPrima: composicao / montagem / digitos / ordem / casas
        IF PEMSTATUS(loc_oPg, "cnt_4c_MtPrima", 5)
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_Compos", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_Compos.Value     = loc_oBO.this_cCompos
            ENDIF
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_MontaDescs", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_MontaDescs.Value = loc_oBO.this_nMontadescs
            ENDIF
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_DigiMaxs", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_DigiMaxs.Value   = loc_oBO.this_nDigimaxs
            ENDIF
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_OrdCompos", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_OrdCompos.Value  = loc_oBO.this_nOrdcompos
            ENDIF
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_Casas", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_Casas.Value      = loc_oBO.this_nCasas
            ENDIF
        ENDIF

        *-- Carregar grids de composicao para o produto atual
        IF !EMPTY(loc_oBO.this_cCpros)
            THIS.CarregarComposicao()
        ENDIF

        *-- Tab 4: Dados Fiscais
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
            loc_oPg.txt_4c_Clfiscal.Value  = loc_oBO.this_cClfiscals
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
            loc_oPg.txt_4c_Origmerc.Value  = loc_oBO.this_cOrigmercs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
            loc_oPg.txt_4c_Sittricms.Value = loc_oBO.this_cSittricms
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Icms", 5)
            loc_oPg.txt_4c_Icms.Value      = loc_oBO.this_nIcms
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
            loc_oPg.txt_4c_Tptribs.Value   = loc_oBO.this_cTptribs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
            loc_oPg.txt_4c_CodServs.Value  = loc_oBO.this_cCodservs
        ENDIF
        IF PEMSTATUS(loc_oPg, "cmb_4c_Ipi", 5)
            loc_oPg.cmb_4c_Ipi.Value       = IIF(EMPTY(loc_oBO.this_cIpis), "T", loc_oBO.this_cIpis)
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DescFis", 5)
            loc_oPg.txt_4c_DescFis.Value   = loc_oBO.this_cDescfis
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
            loc_oPg.txt_4c_Metal.Value     = loc_oBO.this_cMetals
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
            loc_oPg.txt_4c_Teor.Value      = loc_oBO.this_cTeors
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DescEcfs", 5)
            loc_oPg.txt_4c_DescEcfs.Value  = loc_oBO.this_cDescecfs
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Valors", 5)
            loc_oPg.txt_4c_Valors.Value    = loc_oBO.this_nValors
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
            loc_oPg.txt_4c_Moedas.Value    = loc_oBO.this_cMoedas
        ENDIF
        *-- Descricoes dos lookups (calculadas via SQL)
        IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
            loc_oPg.txt_4c_Dclfiscal.Value  = THIS.CarregarDesc("SigCdClf", "Codigos", loc_oBO.this_cClfiscals, "Descricaos")
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
            loc_oPg.txt_4c_Dorigmerc.Value  = THIS.CarregarDesc("SigCdOrg", "Codigos", loc_oBO.this_cOrigmercs, "Descricaos")
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
            loc_oPg.txt_4c_Dsittricms.Value = THIS.CarregarDesc("SigCdIcm", "Codigos", loc_oBO.this_cSittricms, "Descricaos")
        ENDIF
        *-- Campos FASE 9
        IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
            loc_oPg.txt_4c_AliqIPI.Value    = loc_oBO.this_nAliqipis
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
            loc_oPg.txt_4c_Extipi.Value     = loc_oBO.this_cExtipi
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
            loc_oPg.txt_4c_Iat.Value        = loc_oBO.this_cIats
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            loc_oPg.txt_4c__gruccus.Value   = loc_oBO.this_cGruccus
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
            loc_oPg.txt_4c__dgruccus.Value  = THIS.CarregarDesc("SigCdGcr", "Codigos", loc_oBO.this_cGruccus, "Descrs")
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
            loc_oPg.txt_4c__contaccus.Value = loc_oBO.this_cContaccus
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
            loc_oPg.txt_4c__dcontaccus.Value = THIS.CarregarDesc("SigCdCli", "IClis", loc_oBO.this_cContaccus, "Rclis")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario (aba Principal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- Identificacao
        IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
            loc_oPg.txt_4c_Cpros.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
            loc_oPg.txt_4c_Dpros.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
            loc_oPg.txt_4c_Dpro2s.Value = ""
        ENDIF

        *-- Grupo / Subgrupo
        IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
            loc_oPg.txt_4c_Cgrus.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
            loc_oPg.txt_4c_Dgrus.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
            loc_oPg.txt_4c_Csgrus.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
            loc_oPg.txt_4c_Dsgrus.Value = ""
        ENDIF

        *-- Linha / Colecao / Fornecedor / Ref
        IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
            loc_oPg.txt_4c_Linhas.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
            loc_oPg.txt_4c_Dlinhas.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
            loc_oPg.txt_4c_Colecoes.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
            loc_oPg.txt_4c_Dcolecoes.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
            loc_oPg.txt_4c_Ifors.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
            loc_oPg.txt_4c_Dfors.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
            loc_oPg.txt_4c_Reffs.Value     = ""
        ENDIF

        *-- Tipo / Identificador / Conjunto / Equivalente
        IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
            loc_oPg.txt_4c_Mercs.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Idecpros", 5)
            loc_oPg.txt_4c_Idecpros.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Conjunts", 5)
            loc_oPg.txt_4c_Conjunts.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
            loc_oPg.txt_4c_Cproeqs.Value  = ""
        ENDIF

        *-- Codigos de Barra
        IF PEMSTATUS(loc_oPg, "txt_4c_Cbars", 5)
            loc_oPg.txt_4c_Cbars.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ean13", 5)
            loc_oPg.txt_4c_Ean13.Value = 0
        ENDIF

        *-- Situacao
        IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
            loc_oPg.opt_4c_Situas.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
            loc_oPg.txt_4c_DtSituas.Value = {}
        ENDIF

        *-- Lote Minimo / Qtde
        IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
            loc_oPg.txt_4c_Ltminsv.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
            loc_oPg.txt_4c_Qmins.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
            loc_oPg.txt_4c_Qtped.Value   = 0
        ENDIF

        *-- Observacoes
        IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
            loc_oPg.txt_4c_Obsetqs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
            loc_oPg.txt_4c_Obspeds.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
            loc_oPg.txt_4c_Obspes.Value  = ""
        ENDIF

        *-- Ultima Compra (ReadOnly)
        IF PEMSTATUS(loc_oPg, "txt_4c_Dtucp", 5)
            loc_oPg.txt_4c_Dtucp.Value      = {}
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Vucp", 5)
            loc_oPg.txt_4c_Vucp.Value       = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Mucp", 5)
            loc_oPg.txt_4c_Mucp.Value       = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qtdultcomp", 5)
            loc_oPg.txt_4c_Qtdultcomp.Value = 0
        ENDIF

        *-- Estoque (ReadOnly)
        IF PEMSTATUS(loc_oPg, "txt_4c_Estoques", 5)
            loc_oPg.txt_4c_Estoques.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_QtdEsts", 5)
            loc_oPg.txt_4c_QtdEsts.Value  = 0
        ENDIF

        *-- Custo / Moeda custo
        IF PEMSTATUS(loc_oPg, "txt_4c_Custofs", 5)
            loc_oPg.txt_4c_Custofs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
            loc_oPg.txt_4c_Moecs.Value   = ""
        ENDIF

        *-- Preco / Moeda preco
        IF PEMSTATUS(loc_oPg, "txt_4c_Pvens", 5)
            loc_oPg.txt_4c_Pvens.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
            loc_oPg.txt_4c_Moepvs.Value = ""
        ENDIF

        *-- Fator / Moeda fator
        IF PEMSTATUS(loc_oPg, "txt_4c_Fvendas", 5)
            loc_oPg.txt_4c_Fvendas.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moevs", 5)
            loc_oPg.txt_4c_Moevs.Value   = ""
        ENDIF

        *-- Auditoria (ReadOnly)
        IF PEMSTATUS(loc_oPg, "txt_4c_DtIncs", 5)
            loc_oPg.txt_4c_DtIncs.Value   = {}
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Usuincs", 5)
            loc_oPg.txt_4c_Usuincs.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DtAlts", 5)
            loc_oPg.txt_4c_DtAlts.Value   = {}
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_UsuaAlts", 5)
            loc_oPg.txt_4c_UsuaAlts.Value = ""
        ENDIF

        *-- Unidades
        IF PEMSTATUS(loc_oPg, "txt_4c_Cunis", 5)
            loc_oPg.txt_4c_Cunis.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
            loc_oPg.txt_4c_Dunis.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cunips", 5)
            loc_oPg.txt_4c_Cunips.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
            loc_oPg.txt_4c_Dunips.Value = ""
        ENDIF

        *-- Classificacao / Modelo / Acabamento / Local
        IF PEMSTATUS(loc_oPg, "txt_4c_Cclass", 5)
            loc_oPg.txt_4c_Cclass.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dclass", 5)
            loc_oPg.txt_4c_Dclass.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codfinp", 5)
            loc_oPg.txt_4c_Codfinp.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dcodfinp", 5)
            loc_oPg.txt_4c_Dcodfinp.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
            loc_oPg.txt_4c_Codacbs.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
            loc_oPg.txt_4c_Dcodacbs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Locals", 5)
            loc_oPg.txt_4c_Locals.Value   = ""
        ENDIF

        *-- Pesos / Cor / Tamanho / Cod.Identidade
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesobs", 5)
            loc_oPg.txt_4c_Pesobs.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesoms", 5)
            loc_oPg.txt_4c_Pesoms.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
            loc_oPg.txt_4c_Codcors.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
            loc_oPg.txt_4c_Codtams.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codident", 5)
            loc_oPg.txt_4c_Codident.Value = ""
        ENDIF

        *-- Garantia / Produto Web / Variacao / CheckBoxes
        IF PEMSTATUS(loc_oPg, "txt_4c_Diasgar", 5)
            loc_oPg.txt_4c_Diasgar.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
            loc_oPg.chk_4c_Chkgarvit.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
            loc_oPg.opt_4c_ProdWeb.Value    = 1
        ENDIF
        IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
            loc_oPg.opt_4c_Varias.Value     = 2
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
            loc_oPg.chk_4c_Consigs.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
            loc_oPg.chk_4c_Fabrproprs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
            loc_oPg.chk_4c_Encoms.Value     = 0
        ENDIF

        *-- Entrega / Dimensoes / Volumes
        IF PEMSTATUS(loc_oPg, "txt_4c_Tents", 5)
            loc_oPg.txt_4c_Tents.Value      = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Altura", 5)
            loc_oPg.txt_4c_Altura.Value     = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Largura", 5)
            loc_oPg.txt_4c_Largura.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Diametro", 5)
            loc_oPg.txt_4c_Diametro.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Espessura", 5)
            loc_oPg.txt_4c_Espessura.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Compriment", 5)
            loc_oPg.txt_4c_Compriment.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DimA", 5)
            loc_oPg.txt_4c_DimA.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DimB", 5)
            loc_oPg.txt_4c_DimB.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DimC", 5)
            loc_oPg.txt_4c_DimC.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Volumes", 5)
            loc_oPg.txt_4c_Volumes.Value    = 0
        ENDIF

        *-- Campos Memo
        IF PEMSTATUS(loc_oPg, "edt_4c_Dsccompras", 5)
            loc_oPg.edt_4c_Dsccompras.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "edt_4c_Dpro3s", 5)
            loc_oPg.edt_4c_Dpro3s.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "edt_4c_Obscompras", 5)
            loc_oPg.edt_4c_Obscompras.Value = ""
        ENDIF

        *-- Tab 2: Composicao (Page2 de pgf_4c_Dados)
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF PEMSTATUS(loc_oPg, "txt_4c_ObsOFs", 5)
            loc_oPg.txt_4c_ObsOFs.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
            loc_oPg.txt_4c_Desc.Value      = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
            loc_oPg.txt_4c_MatP.Value      = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
            loc_oPg.txt_4c__desccp.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
            loc_oPg.txt_4c__matsub.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaCusto", 5)
            loc_oPg.chk_4c_ChkLiberaCusto.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaVenda", 5)
            loc_oPg.chk_4c_ChkLiberaVenda.Value = 0
        ENDIF

        *-- Custo
        IF PEMSTATUS(loc_oPg, "txt_4c_Pcus", 5)
            loc_oPg.txt_4c_Pcus.Value      = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
            loc_oPg.txt_4c_PcusMoe.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Fcusto", 5)
            loc_oPg.txt_4c_Fcusto.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_PcusMoepc", 5)
            loc_oPg.txt_4c_PcusMoepc.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Custof", 5)
            loc_oPg.txt_4c_Custof.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_MoecusFoe", 5)
            loc_oPg.txt_4c_MoecusFoe.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
            loc_oPg.txt_4c_Cmkpc.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__pftioc", 5)
            loc_oPg.txt_4c__pftioc.Value   = 0
        ENDIF

        *-- Venda
        IF PEMSTATUS(loc_oPg, "txt_4c_Margem", 5)
            loc_oPg.txt_4c_Margem.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pvideal", 5)
            loc_oPg.txt_4c_Pvideal.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
            loc_oPg.txt_4c_Moeda.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_FIdeals", 5)
            loc_oPg.txt_4c_FIdeals.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
            loc_oPg.txt_4c_Status.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
            loc_oPg.txt_4c_Ftio.Value      = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pftio", 5)
            loc_oPg.txt_4c_Pftio.Value     = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Mftio", 5)
            loc_oPg.txt_4c_Mftio.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
            loc_oPg.txt_4c_Fvenda.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
            loc_oPg.txt_4c_Moepv.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
            loc_oPg.txt_4c_Pven.Value      = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
            loc_oPg.txt_4c_Moev.Value      = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_FAtuals", 5)
            loc_oPg.txt_4c_FAtuals.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Encarg", 5)
            loc_oPg.txt_4c_Encarg.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_CotaCalcP", 5)
            loc_oPg.txt_4c_CotaCalcP.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
            loc_oPg.txt_4c_Pesom.Value     = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_MarkupA", 5)
            loc_oPg.txt_4c_MarkupA.Value   = 0
        ENDIF

        *-- Container: Composicao / Montagem / Digitos / Ordem / Casas
        IF PEMSTATUS(loc_oPg, "cnt_4c_MtPrima", 5)
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_Compos", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_Compos.Value     = ""
            ENDIF
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_MontaDescs", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_MontaDescs.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_DigiMaxs", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_DigiMaxs.Value   = 0
            ENDIF
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_OrdCompos", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_OrdCompos.Value  = 0
            ENDIF
            IF PEMSTATUS(loc_oPg.cnt_4c_MtPrima, "txt_4c_Casas", 5)
                loc_oPg.cnt_4c_MtPrima.txt_4c_Casas.Value      = 0
            ENDIF
        ENDIF

        *-- Limpar grids de composicao
        IF USED("cursor_4c_Compo")
            ZAP IN cursor_4c_Compo
        ENDIF
        IF USED("cursor_4c_SubCompo")
            ZAP IN cursor_4c_SubCompo
        ENDIF
        IF USED("cursor_4c_GrupoCompo")
            ZAP IN cursor_4c_GrupoCompo
        ENDIF

        *-- Tab 4: Dados Fiscais
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
            loc_oPg.txt_4c_Clfiscal.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
            loc_oPg.txt_4c_Dclfiscal.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
            loc_oPg.txt_4c_Origmerc.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
            loc_oPg.txt_4c_Dorigmerc.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
            loc_oPg.txt_4c_Sittricms.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
            loc_oPg.txt_4c_Dsittricms.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Icms", 5)
            loc_oPg.txt_4c_Icms.Value       = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
            loc_oPg.txt_4c_Tptribs.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
            loc_oPg.txt_4c_CodServs.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "cmb_4c_Ipi", 5)
            loc_oPg.cmb_4c_Ipi.Value        = "T"
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
            loc_oPg.txt_4c_AliqIPI.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
            loc_oPg.txt_4c_Extipi.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
            loc_oPg.txt_4c_Iat.Value        = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DescFis", 5)
            loc_oPg.txt_4c_DescFis.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
            loc_oPg.txt_4c_Metal.Value      = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
            loc_oPg.txt_4c_DesMetal.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
            loc_oPg.txt_4c_Teor.Value       = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
            loc_oPg.txt_4c_DesTeor.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DescEcfs", 5)
            loc_oPg.txt_4c_DescEcfs.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Valors", 5)
            loc_oPg.txt_4c_Valors.Value     = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
            loc_oPg.txt_4c_Moedas.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            loc_oPg.txt_4c__gruccus.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
            loc_oPg.txt_4c__dgruccus.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
            loc_oPg.txt_4c__contaccus.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
            loc_oPg.txt_4c__dcontaccus.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_IPPTCST", 5)
            loc_oPg.txt_4c_IPPTCST.Value    = ""
        ENDIF
        IF USED("cursor_4c_Cmv")
            ZAP IN cursor_4c_Cmv
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo de edicao
    * par_lHabilitar: .T. = edicao/inclusao, .F. = visualizacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lNovoReg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_lNovoReg = (THIS.this_cModoAtual = "INCLUIR")

        *-- Codigo: editavel SOMENTE na inclusao (PK nao se altera)
        IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
            loc_oPg.txt_4c_Cpros.ReadOnly = !loc_lNovoReg
        ENDIF

        *-- Campos texto editaveis
        IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
            loc_oPg.txt_4c_Dpros.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
            loc_oPg.txt_4c_Dpro2s.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
            loc_oPg.txt_4c_Cgrus.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
            loc_oPg.txt_4c_Csgrus.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
            loc_oPg.txt_4c_Linhas.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
            loc_oPg.txt_4c_Colecoes.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
            loc_oPg.txt_4c_Ifors.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
            loc_oPg.txt_4c_Reffs.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
            loc_oPg.txt_4c_Mercs.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Idecpros", 5)
            loc_oPg.txt_4c_Idecpros.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Conjunts", 5)
            loc_oPg.txt_4c_Conjunts.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
            loc_oPg.txt_4c_Cproeqs.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cbars", 5)
            loc_oPg.txt_4c_Cbars.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ean13", 5)
            loc_oPg.txt_4c_Ean13.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
            loc_oPg.txt_4c_Ltminsv.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
            loc_oPg.txt_4c_Qmins.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
            loc_oPg.txt_4c_Qtped.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
            loc_oPg.txt_4c_Obsetqs.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
            loc_oPg.txt_4c_Obspeds.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
            loc_oPg.txt_4c_Obspes.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Custofs", 5)
            loc_oPg.txt_4c_Custofs.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
            loc_oPg.txt_4c_Moecs.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pvens", 5)
            loc_oPg.txt_4c_Pvens.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
            loc_oPg.txt_4c_Moepvs.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Fvendas", 5)
            loc_oPg.txt_4c_Fvendas.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Moevs", 5)
            loc_oPg.txt_4c_Moevs.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cunis", 5)
            loc_oPg.txt_4c_Cunis.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cunips", 5)
            loc_oPg.txt_4c_Cunips.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Cclass", 5)
            loc_oPg.txt_4c_Cclass.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codfinp", 5)
            loc_oPg.txt_4c_Codfinp.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
            loc_oPg.txt_4c_Codacbs.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Locals", 5)
            loc_oPg.txt_4c_Locals.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesobs", 5)
            loc_oPg.txt_4c_Pesobs.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Pesoms", 5)
            loc_oPg.txt_4c_Pesoms.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
            loc_oPg.txt_4c_Codcors.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
            loc_oPg.txt_4c_Codtams.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Codident", 5)
            loc_oPg.txt_4c_Codident.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Diasgar", 5)
            loc_oPg.txt_4c_Diasgar.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Tents", 5)
            loc_oPg.txt_4c_Tents.ReadOnly     = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Altura", 5)
            loc_oPg.txt_4c_Altura.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Largura", 5)
            loc_oPg.txt_4c_Largura.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Diametro", 5)
            loc_oPg.txt_4c_Diametro.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Espessura", 5)
            loc_oPg.txt_4c_Espessura.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Compriment", 5)
            loc_oPg.txt_4c_Compriment.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DimA", 5)
            loc_oPg.txt_4c_DimA.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DimB", 5)
            loc_oPg.txt_4c_DimB.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DimC", 5)
            loc_oPg.txt_4c_DimC.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Volumes", 5)
            loc_oPg.txt_4c_Volumes.ReadOnly   = !par_lHabilitar
        ENDIF

        *-- OptionGroups e CheckBoxes: Enabled
        IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
            loc_oPg.opt_4c_Situas.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
            loc_oPg.opt_4c_ProdWeb.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
            loc_oPg.opt_4c_Varias.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
            loc_oPg.chk_4c_Chkgarvit.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
            loc_oPg.chk_4c_Consigs.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
            loc_oPg.chk_4c_Fabrproprs.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
            loc_oPg.chk_4c_Encoms.Enabled     = par_lHabilitar
        ENDIF

        *-- EditBoxes (Memo)
        IF PEMSTATUS(loc_oPg, "edt_4c_Dsccompras", 5)
            loc_oPg.edt_4c_Dsccompras.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "edt_4c_Dpro3s", 5)
            loc_oPg.edt_4c_Dpro3s.ReadOnly     = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg, "edt_4c_Obscompras", 5)
            loc_oPg.edt_4c_Obscompras.ReadOnly  = !par_lHabilitar
        ENDIF

        *-- Tab 7: Fases - campos e botoes de operacao
        LOCAL loc_oPg7
        loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7

        IF PEMSTATUS(loc_oPg7, "txt_4c_Qminfab", 5)
            loc_oPg7.txt_4c_Qminfab.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "txt_4c_Codgarras", 5)
            loc_oPg7.txt_4c_Codgarras.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "txt_4c_Conquilhas", 5)
            loc_oPg7.txt_4c_Conquilhas.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "txt_4c_Pesobris", 5)
            loc_oPg7.txt_4c_Pesobris.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "txt_4c_Pesometal", 5)
            loc_oPg7.txt_4c_Pesometal.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "txt_4c_Pesopdrs", 5)
            loc_oPg7.txt_4c_Pesopdrs.ReadOnly   = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
            loc_oPg7.txt_4c_CodcorsFas.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
            loc_oPg7.txt_4c_CodtamsFas.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
            loc_oPg7.txt_4c_CodacbsFas.ReadOnly  = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "chk_4c_CravCera", 5)
            loc_oPg7.chk_4c_CravCera.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "chk_4c_PesoVari", 5)
            loc_oPg7.chk_4c_PesoVari.Enabled    = par_lHabilitar
        ENDIF
        *-- Botoes de operacao: habilitados so em modo edicao
        IF PEMSTATUS(loc_oPg7, "cmd_4c_InserirFase", 5)
            loc_oPg7.cmd_4c_InserirFase.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "cmd_4c_ExcluirFase", 5)
            loc_oPg7.cmd_4c_ExcluirFase.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "cmd_4c_Alternativa", 5)
            loc_oPg7.cmd_4c_Alternativa.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "cmd_4c_CmdgFigura", 5)
            loc_oPg7.cmd_4c_CmdgFigura.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "cmd_4c_CmdgFigCam", 5)
            loc_oPg7.cmd_4c_CmdgFigCam.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "cmd_4c_BtnInsereMtx", 5)
            loc_oPg7.cmd_4c_BtnInsereMtx.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "cmd_4c_BtnExcluiMtz", 5)
            loc_oPg7.cmd_4c_BtnExcluiMtz.Enabled = par_lHabilitar
        ENDIF
        *-- Grid Fases/Matrizes: somente editavel em modo edicao
        IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
            loc_oPg7.grd_4c_Fases.ReadOnly    = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg7, "grd_4c_Matrizes", 5)
            loc_oPg7.grd_4c_Matrizes.ReadOnly = !par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo produto
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
        THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados")
            MsgAviso("Nenhum produto selecionado!")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum produto selecionado!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
            THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados")
            MsgAviso("Nenhum produto selecionado!")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum produto selecionado!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
            THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir produto selecionado
    * Legado: verifica se produto e usado em pedidos/fichas tecnicas
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResultado

        IF !USED("cursor_4c_Dados")
            MsgAviso("Nenhum produto selecionado!")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum produto selecionado!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

            *-- Verificar uso em itens de pedido (SigMvCIte)
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT COUNT(*) AS nExiste
                FROM SigMvCIte
                WHERE cpros = <<EscaparSQL(loc_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerPro")

            IF loc_nResultado < 0
                MsgErro("Falha ao verificar uso do produto!")
                IF USED("cursor_4c_VerPro")
                    USE IN cursor_4c_VerPro
                ENDIF
                RETURN
            ENDIF

            IF NVL(cursor_4c_VerPro.nExiste, 0) > 0
                MsgAviso("Produto em uso em pedidos - n" + CHR(227) + "o pode ser exclu" + CHR(237) + "do!")
                IF USED("cursor_4c_VerPro")
                    USE IN cursor_4c_VerPro
                ENDIF
                RETURN
            ENDIF

            IF USED("cursor_4c_VerPro")
                USE IN cursor_4c_VerPro
            ENDIF

            IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto '" + loc_cCodigo + "'?")
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar produto
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * BtnPesquisaProdutoClick - Abre consulta de produto (legado: SigOpCgp)
    *--------------------------------------------------------------------------
    PROCEDURE BtnPesquisaProdutoClick()
        MsgInfo("Consulta de Produto em desenvolvimento.", "Pesquisa")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnArquivosProdutoClick - Abre documentos do produto (legado: SigOpDoc)
    *--------------------------------------------------------------------------
    PROCEDURE BtnArquivosProdutoClick()
        MsgInfo("Arquivos do Produto em desenvolvimento.", "Arquivos")
    ENDPROC

    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg, loc_cCodNovo, loc_cSQLDup, loc_nDup

        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- Validacao: codigo obrigatorio
        IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
            IF EMPTY(loc_oPg.txt_4c_Cpros.Value)
                MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o pode ficar em branco!")
                IF PEMSTATUS(loc_oPg.txt_4c_Cpros, "SetFocus", 5)
                    loc_oPg.txt_4c_Cpros.SetFocus()
                ENDIF
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
                THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
                RETURN
            ENDIF
        ENDIF

        *-- Validacao: codigo duplicado (apenas no modo INCLUIR)
        IF THIS.this_cModoAtual = "INCLUIR"
            IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
                loc_cCodNovo = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)

                TEXT TO loc_cSQLDup TEXTMERGE NOSHOW
                    SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCodNovo)>>
                ENDTEXT

                loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupPro")

                IF loc_nDup >= 0 AND NVL(cursor_4c_DupPro.nExiste, 0) > 0
                    IF USED("cursor_4c_DupPro")
                        USE IN cursor_4c_DupPro
                    ENDIF
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
                        loc_oPg.txt_4c_Cpros.SetFocus()
                    ENDIF
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
                    THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
                    RETURN
                ENDIF

                IF USED("cursor_4c_DupPro")
                    USE IN cursor_4c_DupPro
                ENDIF
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Produto salvo com sucesso!")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre FormBuscaAuxiliar para busca de produtos
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")

            loc_oBusca.mAddColuna("cpros", "", "Produto")
            loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("cgrus", "", "Grupo")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        THIS.BOParaForm()
                        THIS.this_cModoAtual = "VISUALIZAR"
                        THIS.HabilitarCampos(.F.)
                        THIS.AjustarBotoesPorModo()
                        THIS.AlternarPagina(2)
                        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
                        THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar produto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPesquisarClick - Recarregar lista com filtros aplicados
    *--------------------------------------------------------------------------
    PROCEDURE BtnPesquisarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdLista_DblClick - Duplo clique na grade abre visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE GrdLista_DblClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroGrupo_KeyPress - F4 no filtro de grupo abre lookup de grupos
    *--------------------------------------------------------------------------
    PROCEDURE FiltroGrupo_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115    && F4=115 (VFP9)
            THIS.AbrirLookupFiltroGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltroGrupo - LostFocus no filtro de grupo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltroGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCgru, loc_cSQL, loc_nRes, loc_oBusca
        loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)

        IF loc_cCgru == THIS.this_cUltFiltroGru
            RETURN
        ENDIF
        THIS.this_cUltFiltroGru = loc_cCgru

        IF EMPTY(loc_cCgru)
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCgru)>>
            ENDTEXT

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerGru")

            IF loc_nRes > 0 AND !EOF("cursor_4c_VerGru")
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_VerGru.dgrus)
            ELSE
                *-- Codigo nao encontrado: abrir lookup
                THIS.AbrirLookupFiltroGrupo()
            ENDIF

            IF USED("cursor_4c_VerGru")
                USE IN cursor_4c_VerGru
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarFiltroGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFiltroGrupo - Lookup F4 no filtro de grupo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupFiltroGrupo()
        LOCAL loc_oBusca, loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Gru", "cgrus", loc_cValor, "Selecionar Grupo")
            loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Gru")
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ALLTRIM(cursor_4c_Gru.cgrus)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_Gru.dgrus)
                ENDIF
            ELSE
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ""
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
            ENDIF

            IF USED("cursor_4c_Gru")
                USE IN cursor_4c_Gru
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFiltroGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroSituas_InteractiveChange - Mudar filtro de situacao
    *--------------------------------------------------------------------------
    PROCEDURE FiltroSituas_InteractiveChange()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis
    * Filtra por nome para evitar tornar containers flutuantes visiveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = LOWER(loc_oObjeto.Name)

                *-- Nao tornar visiveis containers flutuantes (Visible=.F. por design)
                IF INLIST(loc_cNome, "cntmensagem", "cntacabado", "cnt_4c_cabecalho")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpar recursos ao fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
        IF USED("cursor_4c_Registro")
            USE IN cursor_4c_Registro
        ENDIF

        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * === METODOS PUBLICOS DE LOOKUP / VALIDACAO (Tab Principal) ==============
    * BINDEVENT requer metodos PUBLIC
    *==========================================================================

    *--------------------------------------------------------------------------
    * TabPrincipal_CgruKeyPress - F4 no campo Grupo abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CgruKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115    && F4=115 em VFP9
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CgruLostFocus - LostFocus valida e carrega descricao do grupo
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CgruLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)

        IF loc_cCod == THIS.this_cUltCgrus
            RETURN
        ENDIF
        THIS.this_cUltCgrus = loc_cCod

        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
                loc_oPg.txt_4c_Dgrus.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGrp")
            IF loc_nR > 0 AND !EOF("cursor_4c_VGrp")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
                    loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_VGrp.dgrus)
                ENDIF
            ELSE
                THIS.AbrirLookupGrupo()
            ENDIF
            IF USED("cursor_4c_VGrp")
                USE IN cursor_4c_VGrp
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CgruLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Abre FormBuscaAuxiliar para selecionar grupo de produto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5), ALLTRIM(loc_oPg.txt_4c_Cgrus.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Grp", "cgrus", loc_cVal, "Selecionar Grupo")
            loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Grp")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
                        loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(cursor_4c_Grp.cgrus)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
                        loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_Grp.dgrus)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
                    loc_oPg.txt_4c_Cgrus.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
                    loc_oPg.txt_4c_Dgrus.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Grp")
                USE IN cursor_4c_Grp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_LinhasKeyPress - F4 no campo Linha abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_LinhasKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupLinha()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_LinhasLostFocus - LostFocus valida e carrega descricao da linha
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_LinhasLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)

        IF loc_cCod == THIS.this_cUltLinhas
            RETURN
        ENDIF
        THIS.this_cUltLinhas = loc_cCod

        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
                loc_oPg.txt_4c_Dlinhas.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VLin")
            IF loc_nR > 0 AND !EOF("cursor_4c_VLin")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
                    loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_VLin.Descs)
                ENDIF
            ELSE
                THIS.AbrirLookupLinha()
            ENDIF
            IF USED("cursor_4c_VLin")
                USE IN cursor_4c_VLin
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar linha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_LinhasLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLinha - Abre FormBuscaAuxiliar para selecionar linha de produto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupLinha()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5), ALLTRIM(loc_oPg.txt_4c_Linhas.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Lin", "Linhas", loc_cVal, "Selecionar Linha")
            loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Lin")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
                        loc_oPg.txt_4c_Linhas.Value  = ALLTRIM(cursor_4c_Lin.Linhas)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
                        loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_Lin.Descs)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
                    loc_oPg.txt_4c_Linhas.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
                    loc_oPg.txt_4c_Dlinhas.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Lin")
                USE IN cursor_4c_Lin
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de linha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupLinha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_ColecoesKeyPress - F4 no campo Grupo de Venda abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_ColecoesKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupColecao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_ColecoesLostFocus - LostFocus valida e carrega descricao
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_ColecoesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)

        IF loc_cCod == THIS.this_cUltColecoes
            RETURN
        ENDIF
        THIS.this_cUltColecoes = loc_cCod

        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
                loc_oPg.txt_4c_Dcolecoes.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCol")
            IF loc_nR > 0 AND !EOF("cursor_4c_VCol")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
                    loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_VCol.Descs)
                ENDIF
            ELSE
                THIS.AbrirLookupColecao()
            ENDIF
            IF USED("cursor_4c_VCol")
                USE IN cursor_4c_VCol
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_ColecoesLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupColecao - Abre FormBuscaAuxiliar para selecionar grupo de venda
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupColecao()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5), ALLTRIM(loc_oPg.txt_4c_Colecoes.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Col", "Colecoes", loc_cVal, "Selecionar Grupo de Venda")
            loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Col")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
                        loc_oPg.txt_4c_Colecoes.Value  = ALLTRIM(cursor_4c_Col.Colecoes)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
                        loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_Col.Descs)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
                    loc_oPg.txt_4c_Colecoes.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
                    loc_oPg.txt_4c_Dcolecoes.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Col")
                USE IN cursor_4c_Col
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupColecao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_IforsKeyPress - F4 no campo Fornecedor abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_IforsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupFornecedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_IforsLostFocus - LostFocus valida e carrega nome do fornecedor
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_IforsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)

        IF loc_cCod == THIS.this_cUltIfors
            RETURN
        ENDIF
        THIS.this_cUltIfors = loc_cCod

        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
                loc_oPg.txt_4c_Dfors.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 IClis, Rclis FROM SigCdCli WHERE IClis = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VFor")
            IF loc_nR > 0 AND !EOF("cursor_4c_VFor")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
                    loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_VFor.Rclis)
                ENDIF
            ELSE
                THIS.AbrirLookupFornecedor()
            ENDIF
            IF USED("cursor_4c_VFor")
                USE IN cursor_4c_VFor
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_IforsLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFornecedor - Abre FormBuscaAuxiliar para selecionar fornecedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupFornecedor()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5), ALLTRIM(loc_oPg.txt_4c_Ifors.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_For", "IClis", loc_cVal, "Selecionar Fornecedor")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_For")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
                        loc_oPg.txt_4c_Ifors.Value = ALLTRIM(cursor_4c_For.IClis)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
                        loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_For.Rclis)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
                    loc_oPg.txt_4c_Ifors.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
                    loc_oPg.txt_4c_Dfors.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_For")
                USE IN cursor_4c_For
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFornecedor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CproeqsKeyPress - F4 no campo Produto Equivalente
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CproeqsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEquivalente()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEquivalente - Abre FormBuscaAuxiliar para produto equivalente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupEquivalente()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5), ALLTRIM(loc_oPg.txt_4c_Cproeqs.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Eq", "cpros", loc_cVal, "Selecionar Produto Equivalente")
            loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Eq")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
                        loc_oPg.txt_4c_Cproeqs.Value = ALLTRIM(cursor_4c_Eq.cpros)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
                    loc_oPg.txt_4c_Cproeqs.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Eq")
                USE IN cursor_4c_Eq
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de equivalente:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupEquivalente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_MoeKeyPress - F4 nos campos de moeda abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_MoeKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_MoeLostFocus - LostFocus nos campos de moeda (sem acao)
    * Validacao de moeda ocorre no BO.Validar() ao salvar
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_MoeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - Abre FormBuscaAuxiliar para selecionar moeda
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oBusca, loc_oPg, loc_cMoeCod
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_Moe", "CMoes", "", "Selecionar Moeda")
            loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Moe")
                    loc_cMoeCod = ALLTRIM(cursor_4c_Moe.CMoes)
                    *-- Aplicar ao campo de moeda que nao estiver ReadOnly
                    IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
                        IF !loc_oPg.txt_4c_Moecs.ReadOnly
                            loc_oPg.txt_4c_Moecs.Value = loc_cMoeCod
                        ENDIF
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
                        IF !loc_oPg.txt_4c_Moepvs.ReadOnly
                            loc_oPg.txt_4c_Moepvs.Value = loc_cMoeCod
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_Moe")
                USE IN cursor_4c_Moe
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CunisKeyPress - F4 no campo Unidade 1 abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CunisKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CunisLostFocus - LostFocus valida unidade 1
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CunisLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_Cunis", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)

        IF loc_cCod == THIS.this_cUltCunis
            RETURN
        ENDIF
        THIS.this_cUltCunis = loc_cCod

        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
                loc_oPg.txt_4c_Dunis.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUni")
            IF loc_nR > 0 AND !EOF("cursor_4c_VUni")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
                    loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_VUni.dunis)
                ENDIF
            ELSE
                THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
            ENDIF
            IF USED("cursor_4c_VUni")
                USE IN cursor_4c_VUni
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunisLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CunipsKeyPress - F4 no campo Unidade 2 abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CunipsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CunipsLostFocus - LostFocus valida unidade 2
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CunipsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_Cunips", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunips.Value)

        IF loc_cCod == THIS.this_cUltCunips
            RETURN
        ENDIF
        THIS.this_cUltCunips = loc_cCod

        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
                loc_oPg.txt_4c_Dunips.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUn2")
            IF loc_nR > 0 AND !EOF("cursor_4c_VUn2")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
                    loc_oPg.txt_4c_Dunips.Value = ALLTRIM(cursor_4c_VUn2.dunis)
                ENDIF
            ELSE
                THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
            ENDIF
            IF USED("cursor_4c_VUn2")
                USE IN cursor_4c_VUn2
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar unidade 2:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunipsLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUnidade - Abre FormBuscaAuxiliar para selecionar unidade
    * par_cKeyField: campo chave na SigCdUni
    * par_cTxtCode: nome do TextBox de codigo na Page1
    * par_cTxtDesc: nome do TextBox de descricao na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupUnidade(par_cKeyField, par_cTxtCode, par_cTxtDesc)
        LOCAL loc_oBusca, loc_oPg, loc_cVal, loc_cTxtCodeRef, loc_cTxtDescRef
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg, par_cTxtCode, 5), ALLTRIM(loc_oPg.&par_cTxtCode..Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUni", "cursor_4c_Uni", par_cKeyField, loc_cVal, "Selecionar Unidade")
            loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Uni")
                    IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
                        loc_oPg.&par_cTxtCode..Value = ALLTRIM(cursor_4c_Uni.cunis)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
                        loc_oPg.&par_cTxtDesc..Value = ALLTRIM(cursor_4c_Uni.dunis)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
                    loc_oPg.&par_cTxtCode..Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
                    loc_oPg.&par_cTxtDesc..Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Uni")
                USE IN cursor_4c_Uni
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupUnidade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CodacbsKeyPress - F4 no campo Acabamento abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CodacbsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupAcabamento()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CodacbsLostFocus - LostFocus valida acabamento
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CodacbsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codacbs.Value)

        IF loc_cCod == THIS.this_cUltCodacbs
            RETURN
        ENDIF
        THIS.this_cUltCodacbs = loc_cCod

        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
                loc_oPg.txt_4c_Dcodacbs.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcb")
            IF loc_nR > 0 AND !EOF("cursor_4c_VAcb")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
                    loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_VAcb.descrs)
                ENDIF
            ELSE
                THIS.AbrirLookupAcabamento()
            ENDIF
            IF USED("cursor_4c_VAcb")
                USE IN cursor_4c_VAcb
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodacbsLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupAcabamento - Abre FormBuscaAuxiliar para selecionar acabamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupAcabamento()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5), ALLTRIM(loc_oPg.txt_4c_Codacbs.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_Acb", "cods", loc_cVal, "Selecionar Acabamento")
            loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Acb")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
                        loc_oPg.txt_4c_Codacbs.Value  = ALLTRIM(cursor_4c_Acb.cods)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
                        loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_Acb.descrs)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
                    loc_oPg.txt_4c_Codacbs.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
                    loc_oPg.txt_4c_Dcodacbs.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Acb")
                USE IN cursor_4c_Acb
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CodcorsKeyPress - F4 no campo Cor abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CodcorsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CodcorsLostFocus - LostFocus valida cor
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CodcorsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codcors.Value)

        IF loc_cCod == THIS.this_cUltCodcors
            RETURN
        ENDIF
        THIS.this_cUltCodcors = loc_cCod

        IF EMPTY(loc_cCod)
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCor")
            IF loc_nR <= 0
                THIS.AbrirLookupCor()
            ELSE
                IF EOF("cursor_4c_VCor")
                    THIS.AbrirLookupCor()
                ENDIF
            ENDIF
            IF USED("cursor_4c_VCor")
                USE IN cursor_4c_VCor
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodcorsLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCor - Abre FormBuscaAuxiliar para selecionar cor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupCor()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5), ALLTRIM(loc_oPg.txt_4c_Codcors.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_Cor", "cods", loc_cVal, "Selecionar Cor")
            loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Cor")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
                        loc_oPg.txt_4c_Codcors.Value = ALLTRIM(cursor_4c_Cor.cods)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
                    loc_oPg.txt_4c_Codcors.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Cor")
                USE IN cursor_4c_Cor
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de cor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabPrincipal_CodtamsKeyPress - F4 no campo Tamanho abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabPrincipal_CodtamsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupTamanho()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTamanho - Abre FormBuscaAuxiliar para selecionar tamanho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupTamanho()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5), ALLTRIM(loc_oPg.txt_4c_Codtams.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_Tam", "cods", loc_cVal, "Selecionar Tamanho")
            loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Tam")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
                        loc_oPg.txt_4c_Codtams.Value = ALLTRIM(cursor_4c_Tam.cods)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
                    loc_oPg.txt_4c_Codtams.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Tam")
                USE IN cursor_4c_Tam
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDesc - Helper: carrega descricao de um campo lookup via SQL
    * Retorna "" se nao encontrado ou valor vazio
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDesc(par_cTabela, par_cCampoChave, par_cValor, par_cCampoDesc)
        LOCAL loc_cDesc, loc_cSQL, loc_nR, loc_cAliasField
        loc_cDesc = ""

        IF !EMPTY(par_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SELECT TOP 1 <<par_cCampoDesc>> FROM <<par_cTabela>> WHERE <<par_cCampoChave>> = <<EscaparSQL(par_cValor)>>
                ENDTEXT
                loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescH")
                IF loc_nR > 0 AND !EOF("cursor_4c_DescH")
                    loc_cAliasField = "cursor_4c_DescH." + par_cCampoDesc
                    loc_cDesc = ALLTRIM(&loc_cAliasField)
                ENDIF
                IF USED("cursor_4c_DescH")
                    USE IN cursor_4c_DescH
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar descricao:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDesc")
            ENDTRY
        ENDIF

        RETURN loc_cDesc
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarComposicao - Carrega grid de composicao (Tab 2)
    * Tabela: SIGPRCPO JOIN SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarComposicao()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            *-- Composicao principal
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
                       c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
                       c.qtdcvs, c.cunips, c.ordems, c.compos
                FROM SIGPRCPO c
                LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
                WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                ORDER BY c.ordems
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_Compo")
                    SELECT cursor_4c_Compo
                    ZAP
                    APPEND FROM DBF("cursor_4c_CompoTmp")
                ENDIF
                IF USED("cursor_4c_CompoTmp")
                    USE IN cursor_4c_CompoTmp
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
                    loc_oPg.grd_4c_Compo.Refresh()
                ENDIF
            ENDIF

            *-- Sub-composicao
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT sc.mats, m.dpros AS dcompos, sc.unicompos, sc.pcompos, sc.qtds,
                       sc.totas, sc.moeds, sc.obscompos, sc.etiqs, sc.qtscons,
                       sc.qtdcvs, sc.cunips, sc.ordems, sc.matsubs, sc.codtams
                FROM sigsubcp sc
                LEFT JOIN SigCdPro m ON RTRIM(sc.mats) = RTRIM(m.cpros)
                WHERE RTRIM(sc.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                ORDER BY sc.ordems
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubCompoTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_SubCompo")
                    SELECT cursor_4c_SubCompo
                    ZAP
                    APPEND FROM DBF("cursor_4c_SubCompoTmp")
                ENDIF
                IF USED("cursor_4c_SubCompoTmp")
                    USE IN cursor_4c_SubCompoTmp
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
                    loc_oPg.grd_4c_SubCompo.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarComposicao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConsultaP - Carrega grids da aba Consulta P. (Tab 6 - PgDadosConsP)
    * GrdCons: SIGPRCPO JOIN SigCdPrf(fase) JOIN SigCdCat(categoria)
    * grDTEMP:  SIGPRCPO agrupado por fase (consumo total)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarConsultaP()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nCount, loc_oPg
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6

        IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            *-- Carregar componentes com descricao de fase e categoria
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT c.mats, c.qtds, c.unicompos, c.grupos,
                       ISNULL((SELECT TOP 1 g.Descrs FROM SigCdGcr g WHERE RTRIM(g.Codigos) = RTRIM(c.grupos)), '') AS dcompos,
                       c.ordems, c.qtscons, c.cats,
                       ISNULL(cat.descs, '') AS dscgrp
                FROM SIGPRCPO c
                LEFT JOIN SigCdCat cat ON RTRIM(c.cats) = RTRIM(cat.cods)
                WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                ORDER BY c.ordems, c.mats
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_Consulta")
                    SELECT cursor_4c_Consulta
                    ZAP
                    APPEND FROM DBF("cursor_4c_ConsultaTmp")
                ENDIF
                IF USED("cursor_4c_ConsultaTmp")
                    USE IN cursor_4c_ConsultaTmp
                ENDIF
                *-- Atualizar contagem de componentes
                loc_nCount = RECCOUNT("cursor_4c_Consulta")
                IF PEMSTATUS(loc_oPg, "txt_4c_QtdCpnt", 5)
                    loc_oPg.txt_4c_QtdCpnt.Value = loc_nCount
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
                    loc_oPg.grd_4c_Consulta.Refresh()
                ENDIF
            ENDIF

            *-- Carregar dados grDTEMP: consumo total agrupado por fase
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT c.grupos, SUM(c.qtscons) AS totas
                FROM SIGPRCPO c
                WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                  AND c.grupos IS NOT NULL
                  AND RTRIM(c.grupos) <> ''
                GROUP BY c.grupos
                ORDER BY c.grupos
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_Temp")
                    SELECT cursor_4c_Temp
                    ZAP
                    APPEND FROM DBF("cursor_4c_TempTmp")
                ENDIF
                IF USED("cursor_4c_TempTmp")
                    USE IN cursor_4c_TempTmp
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_Temp", 5)
                    loc_oPg.grd_4c_Temp.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar consulta de componentes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarConsultaP")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCustos - Carrega grid de custo da composicao (Tab 3 - pgCusto)
    * Tabela: SIGPRCPO filtrado por Tipos (tipo de calculo de custo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCustos()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

        IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            *-- Obter tipo selecionado no combo (0=Todos, 1/2/3=tipo especifico)
            loc_nTipo = 0
            IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
                loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1) - 1
            ENDIF

            *-- Composicao de custo
            IF loc_nTipo = 0
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
                           c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
                           c.qtdcvs, c.cunips
                    FROM SIGPRCPO c
                    LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
                    WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                    AND c.tipos IS NOT NULL
                    ORDER BY c.mats
                ENDTEXT
            ELSE
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
                           c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
                           c.qtdcvs, c.cunips
                    FROM SIGPRCPO c
                    LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
                    WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                    AND c.tipos = <<TRANSFORM(loc_nTipo)>>
                    ORDER BY c.mats
                ENDTEXT
            ENDIF

            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoCustoTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_CompoCusto")
                    SELECT cursor_4c_CompoCusto
                    ZAP
                    APPEND FROM DBF("cursor_4c_CompoCustoTmp")
                ENDIF
                IF USED("cursor_4c_CompoCustoTmp")
                    USE IN cursor_4c_CompoCustoTmp
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
                    WITH loc_oPg.grd_4c_CompoCusto
                        .Column1.ControlSource  = "cursor_4c_CompoCusto.mats"
                        .Column2.ControlSource  = "cursor_4c_CompoCusto.dcompos"
                        .Column3.ControlSource  = "cursor_4c_CompoCusto.unicompos"
                        .Column4.ControlSource  = "cursor_4c_CompoCusto.pcompos"
                        .Column5.ControlSource  = "cursor_4c_CompoCusto.qtds"
                        .Column6.ControlSource  = "cursor_4c_CompoCusto.totas"
                        .Column7.ControlSource  = "cursor_4c_CompoCusto.moeds"
                        .Column8.ControlSource  = "cursor_4c_CompoCusto.obscompos"
                        .Column9.ControlSource  = "cursor_4c_CompoCusto.etiqs"
                        .Column10.ControlSource = "cursor_4c_CompoCusto.qtscons"
                        .Column11.ControlSource = "cursor_4c_CompoCusto.qtdcvs"
                        .Column12.ControlSource = "cursor_4c_CompoCusto.cunips"
                    ENDWITH
                    loc_oPg.grd_4c_CompoCusto.Refresh()
                ENDIF
            ENDIF

            *-- Totais por grupo de custo (GradeGRUPO2)
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT RTRIM(m.cgrus) AS grupos,
                       SUM(c.totas) AS totas,
                       MAX(c.moeds) AS moeds
                FROM SIGPRCPO c
                LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
                WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                AND c.tipos IS NOT NULL
                GROUP BY m.cgrus
                ORDER BY m.cgrus
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoCompo2Tmp")
            IF loc_nR > 0
                IF USED("cursor_4c_GrupoCompo2")
                    SELECT cursor_4c_GrupoCompo2
                    ZAP
                    APPEND FROM DBF("cursor_4c_GrupoCompo2Tmp")
                ENDIF
                IF USED("cursor_4c_GrupoCompo2Tmp")
                    USE IN cursor_4c_GrupoCompo2Tmp
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_GrupoCompo2", 5)
                    WITH loc_oPg.grd_4c_GrupoCompo2
                        .Column1.ControlSource = "cursor_4c_GrupoCompo2.grupos"
                        .Column2.ControlSource = "cursor_4c_GrupoCompo2.totas"
                        .Column3.ControlSource = "cursor_4c_GrupoCompo2.moeds"
                    ENDWITH
                    loc_oPg.grd_4c_GrupoCompo2.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar custos:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarCustos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFases - Carrega grid de fases (Tab 7)
    * Tabela: SigCdPrf
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarFases()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_oBO
        loc_oBO    = THIS.this_oBusinessObject
        loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7

        IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            *-- Fases de producao
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT ordems, grupos, minutos, uniprdts, matprdts
                FROM SigCdPrf
                WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                ORDER BY ordems
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_Fases")
                    SELECT cursor_4c_Fases
                    ZAP
                    APPEND FROM DBF("cursor_4c_FasesTmp")
                ENDIF
                IF USED("cursor_4c_FasesTmp")
                    USE IN cursor_4c_FasesTmp
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_Fases", 5)
                    loc_oPg.grd_4c_Fases.Refresh()
                ENDIF
            ENDIF

            *-- Matrizes
            THIS.CarregarMatrizes()

            *-- Preencher campos do BO nas textboxes da tab
            IF PEMSTATUS(loc_oPg, "txt_4c_Qminfab", 5)
                loc_oPg.txt_4c_Qminfab.Value   = loc_oBO.this_nQtminfabs
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
                loc_oPg.txt_4c_Codgarras.Value = loc_oBO.this_cCodgarras
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
                loc_oPg.txt_4c_Conquilhas.Value = loc_oBO.this_cConquilhas
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Pesobris", 5)
                loc_oPg.txt_4c_Pesobris.Value   = loc_oBO.this_nPesobris
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Pesometal", 5)
                loc_oPg.txt_4c_Pesometal.Value  = loc_oBO.this_nPesometal
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Pesopdrs", 5)
                loc_oPg.txt_4c_Pesopdrs.Value   = loc_oBO.this_nPesopdrs
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CodcorsFas", 5)
                loc_oPg.txt_4c_CodcorsFas.Value  = loc_oBO.this_cCodcors
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CodtamsFas", 5)
                loc_oPg.txt_4c_CodtamsFas.Value  = loc_oBO.this_cCodtams
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CodacbsFas", 5)
                loc_oPg.txt_4c_CodacbsFas.Value  = loc_oBO.this_cCodacbs
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
                loc_oPg.txt_4c_DacbsFas.Value = THIS.CarregarDesc("SigCdAca", "cods", loc_oBO.this_cCodacbs, "descrs")
            ENDIF
            IF PEMSTATUS(loc_oPg, "chk_4c_CravCera", 5)
                loc_oPg.chk_4c_CravCera.Value = loc_oBO.this_lCravcers
            ENDIF
            IF PEMSTATUS(loc_oPg, "chk_4c_PesoVari", 5)
                loc_oPg.chk_4c_PesoVari.Value = loc_oBO.this_lVarias
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar fases:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarFases")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMatrizes - Carrega grid de matrizes (Tab 7 - sub-grid)
    * Tabela: SigPrMtz JOIN SigCdPro (para Locals)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarMatrizes()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7

        IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.cidchaves, a.cmats, a.cpros, a.qtds, b.locals
                FROM SigPrMtz a
                INNER JOIN SigCdPro b ON RTRIM(a.cmats) = RTRIM(b.cpros)
                WHERE RTRIM(a.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizesTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_Matrizes")
                    SELECT cursor_4c_Matrizes
                    ZAP
                    APPEND FROM DBF("cursor_4c_MatrizesTmp")
                ENDIF
                IF USED("cursor_4c_MatrizesTmp")
                    USE IN cursor_4c_MatrizesTmp
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
                    loc_oPg.grd_4c_Matrizes.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar matrizes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarMatrizes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescSgru - Carrega descricao do subgrupo (SigCdPsg com filtro grupo)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDescSgru(par_cCgrus, par_cSgrus)
        LOCAL loc_cDesc, loc_cSQL, loc_nR
        loc_cDesc = ""

        IF !EMPTY(par_cSgrus) AND !EMPTY(par_cCgrus) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SELECT TOP 1 codigos, descricaos FROM SigCdPsg
                    WHERE cgrus = <<EscaparSQL(par_cCgrus)>> AND codigos = <<EscaparSQL(par_cSgrus)>>
                ENDTEXT
                loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescSg")
                IF loc_nR > 0 AND !EOF("cursor_4c_DescSg")
                    loc_cDesc = ALLTRIM(cursor_4c_DescSg.descricaos)
                ENDIF
                IF USED("cursor_4c_DescSg")
                    USE IN cursor_4c_DescSg
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar subgrupo:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDescSgru")
            ENDTRY
        ENDIF

        RETURN loc_cDesc
    ENDFUNC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    * par_nPagina: 1=Lista, 2=Dados
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormProduto.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFiscal_ClfiscalKeyPress - F4 no campo Classif. Fiscal abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabFiscal_ClfiscalKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupClassFiscal()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupClassFiscal - Abre FormBuscaAuxiliar para Classif. Fiscal
    * Tabela: SigCdClf | Chave: clfiscals | Desc: dclfiscals
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupClassFiscal()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5), ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_Clf", "clfiscals", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
            loc_oBusca.mAddColuna("clfiscals",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dclfiscals", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Clf")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                        loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_Clf.clfiscals)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                        loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_Clf.dclfiscals)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                    loc_oPg.txt_4c_Clfiscal.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                    loc_oPg.txt_4c_Dclfiscal.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Clf")
                USE IN cursor_4c_Clf
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupClassFiscal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFiscal_MetalKeyPress - KeyPress no campo Metal (sem lookup auxiliar)
    * Metal e Teor sao campos de classificacao IPI preenchidos manualmente
    *--------------------------------------------------------------------------
    PROCEDURE TabFiscal_MetalKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        *-- Sem lookup: Metal e Teor sao codigos livres no contexto IPI
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFiscal_TeorKeyPress - KeyPress no campo Teor (sem lookup auxiliar)
    *--------------------------------------------------------------------------
    PROCEDURE TabFiscal_TeorKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        *-- Sem lookup: Teor e codigo livre no contexto IPI
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarClfiscal - LostFocus no campo Classificacao Fiscal
    * Tabela: SigCdClf | Chave: Codigos | Desc: Descricaos
    * Ao selecionar, popula AliqIPI com aliqipis da classificacao
    *--------------------------------------------------------------------------
    PROCEDURE ValidarClfiscal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)

        IF loc_cVal == THIS.this_cUltimoValidarClfiscalValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarClfiscalValidado = loc_cVal

        IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltClassFiscal
            RETURN
        ENDIF
        THIS.this_cUltClassFiscal = loc_cVal

        TRY
            LOCAL loc_oBusca, loc_cSQL, loc_nR
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfV", "Codigos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_ClfV")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                        loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfV.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                        loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfV.Descricaos)
                    ENDIF
                    *-- Popula AliqIPI com aliqipis da classificacao fiscal
                    IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
                        TEXT TO loc_cSQL TEXTMERGE NOSHOW
                            SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(cursor_4c_ClfV.Codigos))>>)
                        ENDTEXT
                        loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliq")
                        IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliq")
                            loc_oPg.txt_4c_AliqIPI.Value = cursor_4c_ClfAliq.aliqipis
                        ENDIF
                        IF USED("cursor_4c_ClfAliq")
                            USE IN cursor_4c_ClfAliq
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                    loc_oPg.txt_4c_Clfiscal.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                    loc_oPg.txt_4c_Dclfiscal.Value = ""
                ENDIF
                THIS.this_cUltClassFiscal = ""
            ENDIF

            IF USED("cursor_4c_ClfV")
                USE IN cursor_4c_ClfV
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao validar classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarClfiscal")
        ENDTRY

        IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            THIS.CarregarDadosFiscais()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDclfiscal - LostFocus no campo Descricao Classificacao Fiscal
    * Busca por descricao e preenche codigo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDclfiscal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)

        *-- So abre busca se o codigo estiver vazio (getDclfiscal.When logic)
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
                RETURN
            ENDIF
        ENDIF
        IF loc_cVal == THIS.this_cUltimoValidarDclfiscalValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarDclfiscalValidado = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfD", "Descricaos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_ClfD")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                        loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfD.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                        loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfD.Descricaos)
                    ENDIF
                    THIS.this_cUltClassFiscal = ALLTRIM(cursor_4c_ClfD.Codigos)
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                    loc_oPg.txt_4c_Dclfiscal.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_ClfD")
                USE IN cursor_4c_ClfD
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDclfiscal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOrigmerc - LostFocus no campo Origem Mercadoria
    * Tabela: SigCdOrg | Chave: Codigos | Desc: Descricaos
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOrigmerc(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)

        IF loc_cVal == THIS.this_cUltimoValidarOrigmercValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarOrigmercValidado = loc_cVal

        IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltOrganizacao
            RETURN
        ENDIF
        THIS.this_cUltOrganizacao = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_Org", "Codigos", loc_cVal, "Origem da Mercadoria")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Org")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
                        loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_Org.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
                        loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_Org.Descricaos)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
                    loc_oPg.txt_4c_Origmerc.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
                    loc_oPg.txt_4c_Dorigmerc.Value = ""
                ENDIF
                THIS.this_cUltOrganizacao = ""
            ENDIF

            IF USED("cursor_4c_Org")
                USE IN cursor_4c_Org
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao validar origem da mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarOrigmerc")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDorigmerc - LostFocus no campo Descricao Origem Mercadoria
    * Busca por descricao, preenche codigo (so se codigo estiver vazio)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDorigmerc(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
                RETURN
            ENDIF
        ENDIF
        IF loc_cVal == THIS.this_cUltimoValidarDorigmercValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarDorigmercValidado = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_OrgD", "Descricaos", loc_cVal, "Origem da Mercadoria")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_OrgD")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
                        loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_OrgD.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
                        loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgD.Descricaos)
                    ENDIF
                    THIS.this_cUltOrganizacao = ALLTRIM(cursor_4c_OrgD.Codigos)
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
                    loc_oPg.txt_4c_Dorigmerc.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_OrgD")
                USE IN cursor_4c_OrgD
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar origem mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDorigmerc")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSittricms - LostFocus no campo Situacao Tributaria ICMS
    * Tabela: SigCdIcm | Chave: Codigos | Desc: Descricaos
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSittricms(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c_Sittricms.Value)

        IF loc_cVal == THIS.this_cUltimoValidarSittricmsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarSittricmsValidado = loc_cVal

        IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltIcm
            RETURN
        ENDIF
        THIS.this_cUltIcm = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_Icm", "Codigos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Icm")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
                        loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_Icm.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
                        loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_Icm.Descricaos)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
                    loc_oPg.txt_4c_Sittricms.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
                    loc_oPg.txt_4c_Dsittricms.Value = ""
                ENDIF
                THIS.this_cUltIcm = ""
            ENDIF

            IF USED("cursor_4c_Icm")
                USE IN cursor_4c_Icm
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao validar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarSittricms")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsittricms - LostFocus no campo Descricao Situacao Tributaria ICMS
    * Busca por descricao (so se codigo estiver vazio)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsittricms(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dsittricms.Value)

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricms.Value))
                RETURN
            ENDIF
        ENDIF
        IF loc_cVal == THIS.this_cUltimoValidarDsittricmsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarDsittricmsValidado = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_IcmD", "Descricaos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_IcmD")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
                        loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_IcmD.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
                        loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_IcmD.Descricaos)
                    ENDIF
                    THIS.this_cUltIcm = ALLTRIM(cursor_4c_IcmD.Codigos)
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
                    loc_oPg.txt_4c_Dsittricms.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_IcmD")
                USE IN cursor_4c_IcmD
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDsittricms")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodServs - LostFocus no campo Codigo de Servicos ICMS
    * Tabela: SigCdIcm | tambem preenche getSittricm quando seleciona
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodServs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)

        IF loc_cVal == THIS.this_cUltimoValidarCodServsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarCodServsValidado = loc_cVal

        IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltIcm
            RETURN
        ENDIF
        THIS.this_cUltIcm = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_CodServ", "Codigos", loc_cVal, "C" + CHR(243) + "digo Servi" + CHR(231) + "os ICMS")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_CodServ")
                    IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
                        loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
                    ENDIF
                    *-- Tambem preenche Sittricms (como no legado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
                        loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
                        loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_CodServ.Descricaos)
                    ENDIF
                    THIS.this_cUltIcm = ALLTRIM(cursor_4c_CodServ.Codigos)
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
                    loc_oPg.txt_4c_CodServs.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_CodServ")
                USE IN cursor_4c_CodServ
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao validar c" + CHR(243) + "digo de servi" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarCodServs")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTptribs - LostFocus no campo Tipo de Tributacao
    * Tabela: SigPrTri | Chave: Tipos | Desc: Descs
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTptribs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c_Tptribs.Value)

        IF loc_cVal == THIS.this_cUltimoValidarTptribsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarTptribsValidado = loc_cVal

        IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltTptribs
            RETURN
        ENDIF
        THIS.this_cUltTptribs = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", "cursor_4c_TpTrib", "Tipos", loc_cVal, "Tipo de Tributa" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Tipos", "", "Tipo")
            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_TpTrib")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
                        loc_oPg.txt_4c_Tptribs.Value = ALLTRIM(cursor_4c_TpTrib.Tipos)
                    ENDIF
                    THIS.this_cUltTptribs = ALLTRIM(cursor_4c_TpTrib.Tipos)
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
                    loc_oPg.txt_4c_Tptribs.Value = ""
                ENDIF
                THIS.this_cUltTptribs = ""
            ENDIF

            IF USED("cursor_4c_TpTrib")
                USE IN cursor_4c_TpTrib
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao validar tipo de tributa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarTptribs")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarIat - LostFocus no campo IAT
    * Aceita apenas: 'A' (arredondamento), 'T' (truncamento) ou vazio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarIat(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
            RETURN
        ENDIF
        loc_cVal = UPPER(ALLTRIM(loc_oPg.txt_4c_Iat.Value))

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        IF !INLIST(loc_cVal, "A", "T")
            MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida. Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
            IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
                loc_oPg.txt_4c_Iat.Value = ""
            ENDIF
        ELSE
            IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
                loc_oPg.txt_4c_Iat.Value = loc_cVal
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAliqIPI - LostFocus no campo Aliquota IPI
    * Avisa se identica a aliquota da classificacao fiscal
    *--------------------------------------------------------------------------
    PROCEDURE ValidarAliqIPI(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_nVal, loc_cSQL, loc_nR, loc_nAliqClf
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
            RETURN
        ENDIF
        loc_nVal = loc_oPg.txt_4c_AliqIPI.Value

        IF loc_nVal = 0
            RETURN
        ENDIF
        IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliqV")
            IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliqV")
                loc_nAliqClf = cursor_4c_ClfAliqV.aliqipis
                IF loc_nVal = loc_nAliqClf
                    MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal." + CHR(13) + "Deixe zero para utilizar a classifica" + CHR(231) + CHR(227) + "o fiscal.", "Al" + CHR(237) + "quota IPI")
                ENDIF
            ENDIF
            IF USED("cursor_4c_ClfAliqV")
                USE IN cursor_4c_ClfAliqV
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar al" + CHR(237) + "quota IPI:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarAliqIPI")
        ENDTRY
        THIS.CarregarDadosFiscais()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMetal - LostFocus no campo Metal (codigo livre IPI)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMetal(par_nKeyCode, par_nShiftAltCtrl)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTeor - LostFocus no campo Teor (codigo livre IPI)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTeor(par_nKeyCode, par_nShiftAltCtrl)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoedaEstimada - LostFocus no campo Moeda Valor Estimado
    * Tabela: SigCdMoe | Chave: CMoes | Desc: DMoes
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoedaEstimada(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c_Moedas.Value)

        IF loc_cVal == THIS.this_cUltimoValidarMoedaEstimadaValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarMoedaEstimadaValidado = loc_cVal

        IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltMoeda
            RETURN
        ENDIF
        THIS.this_cUltMoeda = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_MoeEstim", "CMoes", loc_cVal, "Moeda")
            loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_MoeEstim")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
                        loc_oPg.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_MoeEstim.CMoes)
                    ENDIF
                    THIS.this_cUltMoeda = ALLTRIM(cursor_4c_MoeEstim.CMoes)
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
                    loc_oPg.txt_4c_Moedas.Value = ""
                ENDIF
                THIS.this_cUltMoeda = ""
            ENDIF

            IF USED("cursor_4c_MoeEstim")
                USE IN cursor_4c_MoeEstim
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao validar moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarMoedaEstimada")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGruccus - LostFocus no campo Grupo Conta Corrente Custo
    * Tabela: SigCdGcr | Chave: Codigos | Desc: Descrs
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGruccus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)

        IF loc_cVal == THIS.this_cUltimoValidarGruccusValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarGruccusValidado = loc_cVal

        IF EMPTY(loc_cVal)
            IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
                loc_oPg.txt_4c__dgruccus.Value  = ""
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
                loc_oPg.txt_4c__contaccus.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
                loc_oPg.txt_4c__dcontaccus.Value = ""
            ENDIF
            THIS.this_cUltGrupoCC = ""
            RETURN
        ENDIF

        IF loc_cVal = THIS.this_cUltGrupoCC
            RETURN
        ENDIF
        THIS.this_cUltGrupoCC = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_Gcr", "Codigos", loc_cVal, "Grupo Conta Corrente")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Gcr")
                    IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
                        loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_Gcr.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
                        loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_Gcr.Descrs)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
                    loc_oPg.txt_4c__gruccus.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
                    loc_oPg.txt_4c__dgruccus.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
                    loc_oPg.txt_4c__contaccus.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
                    loc_oPg.txt_4c__dcontaccus.Value = ""
                ENDIF
                THIS.this_cUltGrupoCC = ""
            ENDIF

            IF USED("cursor_4c_Gcr")
                USE IN cursor_4c_Gcr
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarGruccus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDgruccus - LostFocus na Descricao do Grupo Conta Corrente
    * Busca por descricao (so se codigo estiver vazio)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDgruccus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oPg.txt_4c__dgruccus.Value)

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
                RETURN
            ENDIF
        ENDIF
        IF loc_cVal == THIS.this_cUltimoValidarDgruccusValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarDgruccusValidado = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_GcrD", "Descrs", loc_cVal, "Grupo Conta Corrente")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_GcrD")
                    IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
                        loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_GcrD.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
                        loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_GcrD.Descrs)
                    ENDIF
                    THIS.this_cUltGrupoCC = ALLTRIM(cursor_4c_GcrD.Codigos)
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
                    loc_oPg.txt_4c__dgruccus.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_GcrD")
                USE IN cursor_4c_GcrD
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDgruccus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaccus - LostFocus no campo Conta Corrente Custo
    * Tabela: SigCdCli | Chave: IClis | Desc: Rclis
    * So acessivel quando grupo gruccus preenchido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaccus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal, loc_cGrupo
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
            RETURN
        ENDIF
        loc_cVal   = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
        loc_cGrupo = ""
        IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
        ENDIF

        IF loc_cVal == THIS.this_cUltimoValidarContaccusValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarContaccusValidado = loc_cVal

        *-- Grupo obrigatorio para acessar conta
        IF EMPTY(loc_cGrupo)
            IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
                loc_oPg.txt_4c__contaccus.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
                loc_oPg.txt_4c__dcontaccus.Value = ""
            ENDIF
            RETURN
        ENDIF

        IF EMPTY(loc_cVal)
            IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
                loc_oPg.txt_4c__dcontaccus.Value = ""
            ENDIF
            THIS.this_cUltContaCC = ""
            RETURN
        ENDIF

        IF loc_cVal = THIS.this_cUltContaCC
            RETURN
        ENDIF
        THIS.this_cUltContaCC = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCC", "IClis", loc_cVal, "Conta Corrente")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_ContaCC")
                    IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
                        loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCC.IClis)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
                        loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCC.Rclis)
                    ENDIF
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
                    loc_oPg.txt_4c__contaccus.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
                    loc_oPg.txt_4c__dcontaccus.Value = ""
                ENDIF
                THIS.this_cUltContaCC = ""
            ENDIF

            IF USED("cursor_4c_ContaCC")
                USE IN cursor_4c_ContaCC
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao validar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarContaccus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDcontaccus - LostFocus na Descricao Conta Corrente
    * Busca por nome (so se codigo estiver vazio e grupo preenchido)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDcontaccus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal, loc_cGrupo
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        IF !PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
            RETURN
        ENDIF
        loc_cVal   = ALLTRIM(loc_oPg.txt_4c__dcontaccus.Value)
        loc_cGrupo = ""
        IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
        ENDIF

        IF EMPTY(loc_cVal) OR EMPTY(loc_cGrupo)
            RETURN
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__contaccus.Value))
                RETURN
            ENDIF
        ENDIF
        IF loc_cVal == THIS.this_cUltimoValidarDcontaccusValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarDcontaccusValidado = loc_cVal

        TRY
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCCD", "Rclis", loc_cVal, "Conta Corrente")
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_ContaCCD")
                    IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
                        loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCCD.IClis)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
                        loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCCD.Rclis)
                    ENDIF
                    THIS.this_cUltContaCC = ALLTRIM(cursor_4c_ContaCCD.IClis)
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
                    loc_oPg.txt_4c__dcontaccus.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_ContaCCD")
                USE IN cursor_4c_ContaCCD
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDcontaccus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFiscal_ExtIpiGotFocus - GotFocus no campo Excecao da TIPI
    * Verifica se campo deve estar habilitado (IpiProds = 'S' em SigCdClf)
    *--------------------------------------------------------------------------
    PROCEDURE TabFiscal_ExtIpiGotFocus()
        LOCAL loc_oPg, loc_cClf, loc_cSQL, loc_nR, loc_lHabilitar
        loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        loc_lHabilitar = .F.

        IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
            RETURN
        ENDIF
        loc_cClf = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)

        IF EMPTY(loc_cClf)
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT IpiProds FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cClf)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfIpi")
            IF loc_nR > 0 AND !EOF("cursor_4c_ClfIpi")
                loc_lHabilitar = (ALLTRIM(cursor_4c_ClfIpi.IpiProds) = "S")
            ENDIF
            IF USED("cursor_4c_ClfIpi")
                USE IN cursor_4c_ClfIpi
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar IpiProds:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFiscal_ExtIpiGotFocus")
        ENDTRY

        IF !loc_lHabilitar
            IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
                loc_oPg.txt_4c_Extipi.ReadOnly = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDescFisClick - Gerar Descricao Fiscal automaticamente
    * Equivalente ao legacy fGerDescFis - stub funcional
    *--------------------------------------------------------------------------
    PROCEDURE BtnDescFisClick()
        LOCAL loc_oPg, loc_cCpros
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF EMPTY(loc_cCpros)
            MsgAviso("Selecione um produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
            RETURN
        ENDIF

        MsgAviso("Funcionalidade de gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica de descri" + CHR(231) + CHR(227) + "o fiscal n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o." + CHR(13) + "Edite a descri" + CHR(231) + CHR(227) + "o fiscal diretamente no campo.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosFiscais - Carrega grid CMV (custos gramas) da aba Fiscal
    * Tabela: SigCdCmv | Colunas: Datas, ValCuss, Moedas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDadosFiscais()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4

        IF EMPTY(loc_cCpros)
            IF USED("cursor_4c_Cmv")
                ZAP IN cursor_4c_Cmv
            ENDIF
            IF PEMSTATUS(loc_oPg, "grd_4c_Cmv", 5)
                loc_oPg.grd_4c_Cmv.Refresh()
            ENDIF
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT Datas AS periodos, ValCuss AS valcustos, Moedas AS moedas
                FROM SigCdCmv
                WHERE RTRIM(Cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                ORDER BY Datas DESC
            ENDTEXT

            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp")

            IF USED("cursor_4c_Cmv")
                ZAP IN cursor_4c_Cmv
            ENDIF

            IF loc_nR > 0
                IF !USED("cursor_4c_Cmv")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
                    SET NULL OFF
                ENDIF
                IF USED("cursor_4c_CmvTemp")
                    SELECT cursor_4c_Cmv
                    APPEND FROM DBF("cursor_4c_CmvTemp")
                ENDIF
            ENDIF

            IF USED("cursor_4c_CmvTemp")
                USE IN cursor_4c_CmvTemp
            ENDIF

            IF PEMSTATUS(loc_oPg, "grd_4c_Cmv", 5)
                loc_oPg.grd_4c_Cmv.ColumnCount = 3
                loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
                WITH loc_oPg.grd_4c_Cmv
                    .Column1.ControlSource = "cursor_4c_Cmv.periodos"
                    .Column2.ControlSource = "cursor_4c_Cmv.valcustos"
                    .Column3.ControlSource = "cursor_4c_Cmv.moedas"
                ENDWITH
                loc_oPg.grd_4c_Cmv.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar dados CMV:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDadosFiscais")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIniTarefaClick - Registra inicio de tarefa do Designer
    * Tabela: sigprtar (cpros, dtinis, usuars)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIniTarefaClick()
        LOCAL loc_cCpros, loc_cSQL, loc_nR
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF EMPTY(loc_cCpros)
            MsgAviso("Selecione um produto antes de iniciar tarefa.", "Tarefa Designer")
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO sigprtar (cpros, dtinis, usuars)
                VALUES (<<EscaparSQL(loc_cCpros)>>, <<FormatarDataSQL(DATE())>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarDesigner()
            ELSE
                MsgErro("Erro ao registrar in" + CHR(237) + "cio de tarefa.", "FormProduto.BtnIniTarefaClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao iniciar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnIniTarefaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFimTarefaClick - Registra fim de tarefa do Designer
    * Atualiza dtfims na ultima tarefa em aberto (dtfims IS NULL)
    *--------------------------------------------------------------------------
    PROCEDURE BtnFimTarefaClick()
        LOCAL loc_cCpros, loc_cSQL, loc_nR
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF EMPTY(loc_cCpros)
            MsgAviso("Selecione um produto antes de finalizar tarefa.", "Tarefa Designer")
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE TOP(1) sigprtar SET dtfims = <<FormatarDataSQL(DATE())>>
                WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarDesigner()
            ELSE
                MsgErro("Nenhuma tarefa em aberto para finalizar.", "FormProduto.BtnFimTarefaClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao finalizar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnFimTarefaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInsArqsClick - Insere arquivo do Designer via dialogo de arquivo
    * Tabela: sigprarq (cpros, arquivos)
    *--------------------------------------------------------------------------
    PROCEDURE BtnInsArqsClick()
        LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF EMPTY(loc_cCpros)
            MsgAviso("Selecione um produto para inserir arquivo.", "Arquivos Designer")
            RETURN
        ENDIF

        loc_cArquivo = GETFILE("*.*", "Selecionar Arquivo para Designer")
        IF EMPTY(loc_cArquivo)
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO sigprarq (cpros, arquivos)
                VALUES (<<EscaparSQL(loc_cCpros)>>, <<EscaparSQL(loc_cArquivo)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarDesigner()
            ELSE
                MsgErro("Erro ao inserir arquivo.", "FormProduto.BtnInsArqsClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInsArqsClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcArqsClick - Exclui arquivo selecionado no grid de arquivos
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcArqsClick()
        LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
            MsgAviso("Selecione um arquivo para excluir.", "Arquivos Designer")
            RETURN
        ENDIF

        loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)

        IF MsgConfirma("Excluir o arquivo selecionado?", "Arquivos Designer")
            TRY
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    DELETE FROM sigprarq
                    WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND RTRIM(arquivos) = RTRIM(<<EscaparSQL(loc_cArquivo)>>)
                ENDTEXT
                loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nR > 0
                    THIS.CarregarDesigner()
                ELSE
                    MsgErro("Erro ao excluir arquivo.", "FormProduto.BtnExcArqsClick")
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao excluir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcArqsClick")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao
    *--------------------------------------------------------------------------
    PROCEDURE BtnOpnArqsClick()
        LOCAL loc_cArquivo

        IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
            MsgAviso("Selecione um arquivo para abrir.", "Arquivos Designer")
            RETURN
        ENDIF

        loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)

        IF EMPTY(loc_cArquivo)
            MsgAviso("Caminho do arquivo n" + CHR(227) + "o informado.", "Arquivos Designer")
            RETURN
        ENDIF

        TRY
            DECLARE INTEGER ShellExecute IN "Shell32.dll" ;
                INTEGER hwnd, STRING lpOperation, STRING lpFile, ;
                STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
            ShellExecute(0, "open", loc_cArquivo, "", "", 1)
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnOpnArqsClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDesigner - Carrega grids de tarefas e arquivos do Designer (Tab 5)
    * Tabelas: sigprtar (tarefas), sigprarq (arquivos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDesigner()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

        IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            *-- Tarefas do Designer
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT dtinis, dtfims, usuars, tarefas
                FROM sigprtar
                WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                ORDER BY dtinis DESC
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesignerTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_Designer")
                    SELECT cursor_4c_Designer
                    ZAP
                    APPEND FROM DBF("cursor_4c_DesignerTmp")
                ENDIF
                IF USED("cursor_4c_DesignerTmp")
                    USE IN cursor_4c_DesignerTmp
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_Designer", 5)
                    loc_oPg.grd_4c_Designer.Refresh()
                ENDIF
            ENDIF

            *-- Arquivos do Designer
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT arquivos FROM sigprarq
                WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                ORDER BY arquivos
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArquivosTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_Arquivos")
                    SELECT cursor_4c_Arquivos
                    ZAP
                    APPEND FROM DBF("cursor_4c_ArquivosTmp")
                ENDIF
                IF USED("cursor_4c_ArquivosTmp")
                    USE IN cursor_4c_ArquivosTmp
                ENDIF
                IF PEMSTATUS(loc_oPg, "grd_4c_Arquivos", 5)
                    loc_oPg.grd_4c_Arquivos.Refresh()
                ENDIF
            ENDIF

            *-- Tarefas dispon?veis para lookup Column4 (SigPrTrf = tabela mestre de tarefas)
            IF USED("cursor_4c_Tarefas")
                ZAP IN cursor_4c_Tarefas
            ENDIF
            loc_nR = SQLEXEC(gnConnHandle, "SELECT CodCads, DesCads FROM SigPrTrf ORDER BY CodCads", "cursor_4c_TarefasTmp")
            IF loc_nR > 0
                IF USED("cursor_4c_Tarefas")
                    APPEND FROM DBF("cursor_4c_TarefasTmp")
                ENDIF
                IF USED("cursor_4c_TarefasTmp")
                    USE IN cursor_4c_TarefasTmp
                ENDIF
            ELSE
                *-- Tabela SigPrTrf nao localizada: cursor fica vazio (lookup manual)
                IF USED("cursor_4c_TarefasTmp")
                    USE IN cursor_4c_TarefasTmp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar designer:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDesigner")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    * Salvar: habilitado apenas em INCLUIR e ALTERAR
    * Cancelar: sempre habilitado em Page2
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesDados, loc_lEmEdicao
        loc_oBotoesDados = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados
        loc_lEmEdicao    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Salvar", 5)
                loc_oBotoesDados.cmd_4c_Salvar.Enabled = loc_lEmEdicao
            ENDIF
            IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Cancelar", 5)
                loc_oBotoesDados.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CompoGrd_AfterRowColChange - Grid composicao: ao mover linha/coluna
    * Atualiza campos Get_Desc e getObsOFs com dados da linha atual
    *--------------------------------------------------------------------------
    PROCEDURE CompoGrd_AfterRowColChange(par_nColIndex)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        TRY
            IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
                IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
                    loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_Compo.dcompos, ""))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CompoGrd_AfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SubCompoGrd_AfterRowColChange - Grid sub-componente: ao mover linha
    * Atualiza campos get_desccp e get_matsub com dados da linha atual
    *--------------------------------------------------------------------------
    PROCEDURE SubCompoGrd_AfterRowColChange(par_nColIndex)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        TRY
            IF USED("cursor_4c_SubCompo") AND !EOF("cursor_4c_SubCompo")
                IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
                    loc_oPg.txt_4c__desccp.Value = ALLTRIM(NVL(cursor_4c_SubCompo.dcompos, ""))
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
                    loc_oPg.txt_4c__matsub.Value = ALLTRIM(NVL(cursor_4c_SubCompo.matsubs, ""))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.SubCompoGrd_AfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkLiberaCustoClick - Checkbox liberar custo: habilita/desabilita campos
    *--------------------------------------------------------------------------
    PROCEDURE ChkLiberaCustoClick()
        LOCAL loc_oPg, loc_lLibera
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_lLibera = .F.

        TRY
            IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaCusto", 5)
                loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Pcus", 5)
                loc_oPg.txt_4c_Pcus.ReadOnly     = !loc_lLibera
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
                loc_oPg.txt_4c_PcusMoe.ReadOnly  = !loc_lLibera
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Fcusto", 5)
                loc_oPg.txt_4c_Fcusto.ReadOnly   = !loc_lLibera
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
                loc_oPg.txt_4c_Cmkpc.ReadOnly    = !loc_lLibera
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaCustoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkLiberaVendaClick - Checkbox liberar venda: habilita/desabilita campos
    *--------------------------------------------------------------------------
    PROCEDURE ChkLiberaVendaClick()
        LOCAL loc_oPg, loc_lLibera
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_lLibera = .F.

        TRY
            IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaVenda", 5)
                loc_lLibera = (loc_oPg.chk_4c_ChkLiberaVenda.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Margem", 5)
                loc_oPg.txt_4c_Margem.ReadOnly   = !loc_lLibera
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
                loc_oPg.txt_4c_Moeda.ReadOnly    = !loc_lLibera
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
                loc_oPg.txt_4c_Ftio.ReadOnly     = !loc_lLibera
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
                loc_oPg.txt_4c_Fvenda.ReadOnly   = !loc_lLibera
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
                loc_oPg.txt_4c_Moepv.ReadOnly    = !loc_lLibera
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
                loc_oPg.txt_4c_Moev.ReadOnly     = !loc_lLibera
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaVendaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkPvendaClick - Checkbox usar preco ideal: aplica preco ideal ao preco venda
    *--------------------------------------------------------------------------
    PROCEDURE ChkPvendaClick()
        LOCAL loc_oPg, loc_nPvideal, loc_nEncarg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        TRY
            IF PEMSTATUS(loc_oPg, "txt_4c_Pvideal", 5)
                loc_nPvideal = loc_oPg.txt_4c_Pvideal.Value
            ELSE
                loc_nPvideal = 0
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Encarg", 5)
                loc_nEncarg = loc_oPg.txt_4c_Encarg.Value
            ELSE
                loc_nEncarg = 1
            ENDIF
            IF loc_nEncarg = 0
                loc_nEncarg = 1
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
                loc_oPg.txt_4c_Pven.Value = loc_nPvideal / loc_nEncarg
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
                loc_oPg.txt_4c_Moev.Value = loc_oPg.txt_4c_Moeda.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.ChkPvendaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_MoecLostFocus - LostFocus de txt_4c_PcusMoe (getMoec)
    * Valida codigo de moeda de custo - lookup em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_MoecLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_lResultado = .T.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_PcusMoe.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            IF loc_cCod == THIS.this_cUltimoTabCompo_MoecLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_MoecLostFocusValidado = loc_cCod

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_MoecTmp")
                *-- Nao encontrou: abre lookup
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Moedas"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c_PcusMoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c_PcusMoe.Value = ""
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_MoecTmp")
                USE IN cursor_4c_MoecTmp
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_MoecusfLostFocus - LostFocus de txt_4c_MoecusFoe (getMoecusf)
    * Valida codigo de moeda de custo com feitio - lookup em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_MoecusfLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c_MoecusFoe", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_MoecusFoe.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            IF loc_cCod == THIS.this_cUltimoTabCompo_MoecusfLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_MoecusfLostFocusValidado = loc_cCod

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecusfTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_MoecusfTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Moedas"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c_MoecusFoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c_MoecusFoe.Value = ""
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_MoecusfTmp")
                USE IN cursor_4c_MoecusfTmp
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecusfLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_MoedaLostFocus - LostFocus de txt_4c_Moeda (getMoeda)
    * Valida moeda de venda - lookup em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_MoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            IF loc_cCod == THIS.this_cUltimoTabCompo_MoedaLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_MoedaLostFocusValidado = loc_cCod

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_MoedaTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Moedas"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c_Moeda.Value = ""
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_MoedaTmp")
                USE IN cursor_4c_MoedaTmp
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoedaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_MoepvLostFocus - LostFocus de txt_4c_Moepv (getMoepv)
    * Valida moeda do preco de venda - lookup em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_MoepvLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepv.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            IF loc_cCod == THIS.this_cUltimoTabCompo_MoepvLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_MoepvLostFocusValidado = loc_cCod

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoepvTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_MoepvTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Moedas"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c_Moepv.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c_Moepv.Value = ""
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_MoepvTmp")
                USE IN cursor_4c_MoepvTmp
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoepvLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_MoevLostFocus - LostFocus de txt_4c_Moev (getMoev)
    * Valida moeda do valor de venda - lookup em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_MoevLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moev.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            IF loc_cCod == THIS.this_cUltimoTabCompo_MoevLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_MoevLostFocusValidado = loc_cCod

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoevTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_MoevTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Moedas"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c_Moev.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c_Moev.Value = ""
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_MoevTmp")
                USE IN cursor_4c_MoevTmp
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoevLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_FtioLostFocus - LostFocus de txt_4c_Ftio (Getftio)
    * Valida codigo de feitio de venda - lookup em SigPrFti (Tipos<>1)
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_FtioLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
            IF EMPTY(loc_cCod)
                THIS.CarregarComposicao()
                RETURN
            ENDIF
            IF loc_cCod == THIS.this_cUltimoTabCompo_FtioLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_FtioLostFocusValidado = loc_cCod

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT Cods, Descs, Acrescs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos<>1"
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtioTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_FtioTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Feitios"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos<>1 ORDER BY Cods"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c_Ftio.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c_Ftio.Value = ""
                    IF USED("cursor_4c_FtioTmp")
                        USE IN cursor_4c_FtioTmp
                    ENDIF
                    THIS.CarregarComposicao()
                    RETURN
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_FtioTmp")
                USE IN cursor_4c_FtioTmp
            ENDIF
            THIS.CarregarComposicao()
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FtioLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_CmkpcLostFocus - LostFocus de txt_4c_Cmkpc (Get_cmkpc)
    * Valida codigo de feitio de custo - lookup em SigPrFti (Tipos=1)
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_CmkpcLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
            IF EMPTY(loc_cCod)
                THIS.CarregarComposicao()
                RETURN
            ENDIF
            IF loc_cCod == THIS.this_cUltimoTabCompo_CmkpcLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_CmkpcLostFocusValidado = loc_cCod

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT Cods, Descs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos=1"
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmkpcTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_CmkpcTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Feitios de Custo"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos=1 ORDER BY Cods"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c_Cmkpc.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c_Cmkpc.Value = ""
                    IF USED("cursor_4c_CmkpcTmp")
                        USE IN cursor_4c_CmkpcTmp
                    ENDIF
                    THIS.CarregarComposicao()
                    RETURN
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_CmkpcTmp")
                USE IN cursor_4c_CmkpcTmp
            ENDIF
            THIS.CarregarComposicao()
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_CmkpcLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_StatusLostFocus - LostFocus de txt_4c_Status (getStatus)
    * Atualiza composicao apos mudanca de status
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_StatusLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            THIS.CarregarComposicao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_StatusLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_MargemLostFocus - LostFocus de txt_4c_Margem (getMargem)
    * Recalcula preco de venda ao mudar margem/markup
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_MargemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            THIS.CarregarComposicao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MargemLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_FvendaLostFocus - LostFocus de txt_4c_Fvenda (getFvenda)
    * Recalcula preco de venda ao mudar fator
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_FvendaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            THIS.CarregarComposicao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FvendaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_DescLostFocus - LostFocus de txt_4c_Desc (Get_Desc)
    * Valida/atualiza descricao do material de composicao
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_DescLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
                RETURN
            ENDIF
            loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Desc.Value)
            IF EMPTY(loc_cDesc)
                RETURN
            ENDIF
            IF loc_cDesc == THIS.this_cUltimoTabCompo_DescLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_DescLostFocusValidado = loc_cDesc

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_DescTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Produtos"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
                    IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
                        loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
                    ENDIF
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c_Desc.Value = ""
                ENDIF
                loc_oForm.Release()
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
                    loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_DescTmp.CPros)
                ENDIF
            ENDIF
            IF USED("cursor_4c_DescTmp")
                USE IN cursor_4c_DescTmp
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DescLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_MatPLostFocus - LostFocus de txt_4c_MatP (Get_MatP)
    * Valida codigo de material principal - lookup em SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_MatPLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            IF loc_cCod == THIS.this_cUltimoTabCompo_MatPLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_MatPLostFocusValidado = loc_cCod

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatPTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_MatPTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Material Principal"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
                        loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
                    ENDIF
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c_MatP.Value = ""
                ENDIF
                loc_oForm.Release()
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
                    loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_MatPTmp.DPros)
                ENDIF
            ENDIF
            IF USED("cursor_4c_MatPTmp")
                USE IN cursor_4c_MatPTmp
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatPLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_DesccpLostFocus - LostFocus de txt_4c__desccp (get_desccp)
    * Valida descricao de sub-componente - lookup em SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_DesccpLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
                RETURN
            ENDIF
            loc_cDesc = ALLTRIM(loc_oPg.txt_4c__desccp.Value)
            IF EMPTY(loc_cDesc)
                RETURN
            ENDIF
            IF loc_cDesc == THIS.this_cUltimoTabCompo_DesccpLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_DesccpLostFocusValidado = loc_cDesc

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesccpTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_DesccpTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Sub-Componentes"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
                    IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
                        loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
                    ENDIF
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c__desccp.Value = ""
                ENDIF
                loc_oForm.Release()
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
                    loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_DesccpTmp.CPros)
                ENDIF
            ENDIF
            IF USED("cursor_4c_DesccpTmp")
                USE IN cursor_4c_DesccpTmp
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DesccpLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabCompo_MatsubLostFocus - LostFocus de txt_4c__matsub (get_matsub)
    * Valida codigo do substituto - lookup em SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE TabCompo_MatsubLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        TRY
            IF NOT PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c__matsub.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            IF loc_cCod == THIS.this_cUltimoTabCompo_MatsubLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTabCompo_MatsubLostFocusValidado = loc_cCod

            gb_4c_ValidandoUI = .T.
            loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
            loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatsubTmp")
            gb_4c_ValidandoUI = .F.

            IF loc_nR <= 0 OR EOF("cursor_4c_MatsubTmp")
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oForm.Caption = "Produto Substituto"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
                    loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
                    IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
                        loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
                    ENDIF
                    USE IN cursor_4c_BuscaAux
                ELSE
                    loc_oPg.txt_4c__matsub.Value = ""
                ENDIF
                loc_oForm.Release()
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
                    loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_MatsubTmp.DPros)
                ENDIF
            ENDIF
            IF USED("cursor_4c_MatsubTmp")
                USE IN cursor_4c_MatsubTmp
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatsubLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCompoIncluirClick - Botao incluir linha na composicao (grdCompo)
    *--------------------------------------------------------------------------
    PROCEDURE CmdCompoIncluirClick()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF EMPTY(loc_cCpros)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves) VALUES (" + ;
                       EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID())"
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarComposicao()
                IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
                    loc_oPg.grd_4c_Compo.SetFocus()
                ENDIF
            ELSE
                MsgErro("Erro ao incluir linha na composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoIncluirClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdCompoIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCompoExcluirClick - Botao excluir linha da composicao (grdCompo)
    *--------------------------------------------------------------------------
    PROCEDURE CmdCompoExcluirClick()
        LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
            RETURN
        ENDIF

        TRY
            loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
            IF EMPTY(loc_cMats)
                RETURN
            ENDIF
            loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
                       " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarComposicao()
            ELSE
                MsgErro("Erro ao excluir linha da composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoExcluirClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdCompoExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCompoAtualizarClick - Botao atualizar/recalcular precos da composicao
    *--------------------------------------------------------------------------
    PROCEDURE CmdCompoAtualizarClick()
        TRY
            THIS.CarregarComposicao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCompoAtuPesosClick - Botao atualizar pesos da composicao
    *--------------------------------------------------------------------------
    PROCEDURE CmdCompoAtuPesosClick()
        TRY
            THIS.CarregarComposicao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtuPesosClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCompoRecalcClick - Botao recalcular todos os precos
    *--------------------------------------------------------------------------
    PROCEDURE CmdCompoRecalcClick()
        TRY
            THIS.CarregarComposicao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdCompoRecalcClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSubCpIncluirClick - Botao incluir sub-componente (grdsubcp)
    *--------------------------------------------------------------------------
    PROCEDURE CmdSubCpIncluirClick()
        LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF EMPTY(loc_cCpros)
            RETURN
        ENDIF
        IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
            MsgAviso("Selecione um item na composi" + CHR(231) + CHR(227) + "o principal primeiro.")
            RETURN
        ENDIF

        TRY
            loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
            IF EMPTY(loc_cMats)
                MsgErro("Item da composi" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido.", "FormProduto.CmdSubCpIncluirClick")
                RETURN
            ENDIF
            loc_cSQL = "INSERT INTO sigsubcp (cpros, dtmovs, cidchaves, matsubs) VALUES (" + ;
                       EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + EscaparSQL(loc_cMats) + ")"
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarComposicao()
                IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
                    loc_oPg.grd_4c_SubCompo.SetFocus()
                ENDIF
            ELSE
                MsgErro("Erro ao incluir sub-componente.", "FormProduto.CmdSubCpIncluirClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSubCpExcluirClick - Botao excluir sub-componente (grdsubcp)
    *--------------------------------------------------------------------------
    PROCEDURE CmdSubCpExcluirClick()
        LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF NOT USED("cursor_4c_SubCompo") OR EOF("cursor_4c_SubCompo")
            RETURN
        ENDIF

        TRY
            loc_cMats = ALLTRIM(NVL(cursor_4c_SubCompo.mats, ""))
            IF EMPTY(loc_cMats)
                RETURN
            ENDIF
            loc_cSQL = "DELETE FROM sigsubcp WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
                       " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarComposicao()
            ELSE
                MsgErro("Erro ao excluir sub-componente.", "FormProduto.CmdSubCpExcluirClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCalcValsClick - Botao calcular valores de preco/custo
    *--------------------------------------------------------------------------
    PROCEDURE CmdCalcValsClick()
        TRY
            THIS.CarregarComposicao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdCalcValsClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdPesoMClick - Botao calcular/atualizar peso medio
    *--------------------------------------------------------------------------
    PROCEDURE CmdPesoMClick()
        LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_nR
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            *-- Busca peso calculado a partir da composicao
            loc_cSQL = "SELECT SUM(c.qtds * p.pesobs) AS peso_calc " + ;
                       "FROM SIGPRCPO c " + ;
                       "LEFT JOIN SigCdPro p ON RTRIM(c.mats) = RTRIM(p.cpros) " + ;
                       "WHERE RTRIM(c.cpros) = " + EscaparSQL(loc_cCpros)
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesoMTmp")
            IF loc_nR > 0 AND !EOF("cursor_4c_PesoMTmp")
                IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
                    loc_oPg.txt_4c_Pesom.Value = NVL(cursor_4c_PesoMTmp.peso_calc, 0)
                ENDIF
            ENDIF
            IF USED("cursor_4c_PesoMTmp")
                USE IN cursor_4c_PesoMTmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdPesoMClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CustosGrd_AfterRowColChange - Grid custos: ao mudar linha/coluna
    * Atualiza campos txt_4c_DescCusto e txt_4c_DGruCompos com dados do item
    *--------------------------------------------------------------------------
    PROCEDURE CustosGrd_AfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_cMats, loc_cSQL, loc_nR
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

        TRY
            IF USED("cursor_4c_CompoCusto") AND !EOF("cursor_4c_CompoCusto")
                *-- Atualizar campo Descricao
                IF PEMSTATUS(loc_oPg, "txt_4c_DescCusto", 5)
                    loc_oPg.txt_4c_DescCusto.Value = ALLTRIM(NVL(cursor_4c_CompoCusto.dcompos, ""))
                ENDIF

                *-- Buscar descricao do grupo com base no material
                loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
                IF !EMPTY(loc_cMats) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_cSQL = "SELECT g.dgrus FROM SigCdPro p " + ;
                               "INNER JOIN SigCdGrp g ON RTRIM(p.cgrus) = RTRIM(g.cgrus) " + ;
                               "WHERE RTRIM(p.cpros) = " + EscaparSQL(loc_cMats)
                    gb_4c_ValidandoUI = .T.
                    loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmpC")
                    gb_4c_ValidandoUI = .F.
                    IF loc_nR > 0 AND !EOF("cursor_4c_GrupoTmpC")
                        IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
                            loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(NVL(cursor_4c_GrupoTmpC.dgrus, ""))
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_GrupoTmpC")
                        USE IN cursor_4c_GrupoTmpC
                    ENDIF
                ELSE
                    IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
                        loc_oPg.txt_4c_DGruCompos.Value = ""
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            gb_4c_ValidandoUI = .F.
            MsgErro(loc_oErro.Message, "FormProduto.CustosGrd_AfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConsultaGrd_AfterRowColChange - Grid GrdCons consulta: ao sair de coluna
    * Col4 (Fase/Grupos): busca descricao em SigCdPrf; se nao encontrado abre lookup
    * Col5 (Descricao fase): busca grupos em SigCdPrf por descricao
    * Col8 (Cat): busca descricao em SigCdCat; se nao encontrado abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE ConsultaGrd_AfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_cSQL, loc_nR, loc_cGrupos, loc_cCats, loc_cDcompos
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
            RETURN
        ENDIF

        TRY
            DO CASE

            *-- Coluna 4 (Fase/Grupos): busca descricao da fase em SigCdPrf
            CASE par_nColIndex = 4
                loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
                IF !EMPTY(loc_cGrupos)
                    loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + EscaparSQL(loc_cGrupos)
                    loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfDesc")
                    IF loc_nR > 0 AND !EOF("cursor_4c_PrfDesc")
                        REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfDesc.descrs, ""))
                        IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
                            loc_oPg.grd_4c_Consulta.Refresh()
                        ENDIF
                    ELSE
                        THIS.AbrirLookupConsultaFase()
                    ENDIF
                    IF USED("cursor_4c_PrfDesc")
                        USE IN cursor_4c_PrfDesc
                    ENDIF
                ENDIF

            *-- Coluna 5 (Descricao fase): busca grupos em SigCdPrf por descricao
            CASE par_nColIndex = 5
                loc_cDcompos = ALLTRIM(NVL(cursor_4c_Consulta.dcompos, ""))
                IF !EMPTY(loc_cDcompos)
                    loc_cSQL = "SELECT TOP 1 Codigos AS grupos, Descrs AS descrs FROM SigCdGcr WHERE RTRIM(Descrs) = " + EscaparSQL(loc_cDcompos)
                    loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfGrp")
                    IF loc_nR > 0 AND !EOF("cursor_4c_PrfGrp")
                        REPLACE cursor_4c_Consulta.grupos  WITH ALLTRIM(NVL(cursor_4c_PrfGrp.grupos, ""))
                        REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfGrp.descrs, ""))
                        IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
                            loc_oPg.grd_4c_Consulta.Refresh()
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_PrfGrp")
                        USE IN cursor_4c_PrfGrp
                    ENDIF
                ENDIF

            *-- Coluna 8 (Cat): busca descricao em SigCdCat
            CASE par_nColIndex = 8
                loc_cCats = ALLTRIM(NVL(cursor_4c_Consulta.cats, ""))
                IF !EMPTY(loc_cCats)
                    loc_cSQL = "SELECT TOP 1 descs FROM SigCdCat WHERE RTRIM(cods) = " + EscaparSQL(loc_cCats)
                    loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CatDesc")
                    IF loc_nR > 0 AND !EOF("cursor_4c_CatDesc")
                        REPLACE cursor_4c_Consulta.dscgrp WITH ALLTRIM(NVL(cursor_4c_CatDesc.descs, ""))
                        IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
                            loc_oPg.grd_4c_Consulta.Refresh()
                        ENDIF
                    ELSE
                        THIS.AbrirLookupConsultaCat()
                    ENDIF
                    IF USED("cursor_4c_CatDesc")
                        USE IN cursor_4c_CatDesc
                    ENDIF
                ENDIF

            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.ConsultaGrd_AfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConsultaFase - Abre lookup SigCdPrf para selecionar fase (col 4)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConsultaFase()
        LOCAL loc_oPg, loc_oBusca, loc_cGrupos, loc_cDescrs

        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6

        TRY
            IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
                RETURN
            ENDIF

            loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
            loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", "cursor_4c_PrfSel", "grupos", loc_cGrupos, "Selecionar Fase")
            loc_oBusca.mAddColuna("grupos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_PrfSel")
                    loc_cGrupos = ALLTRIM(NVL(cursor_4c_PrfSel.grupos, ""))
                    loc_cDescrs = ALLTRIM(NVL(cursor_4c_PrfSel.descrs, ""))
                    REPLACE cursor_4c_Consulta.grupos  WITH loc_cGrupos
                    REPLACE cursor_4c_Consulta.dcompos WITH loc_cDescrs
                    IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
                        loc_oPg.grd_4c_Consulta.Refresh()
                    ENDIF
                ENDIF
            ELSE
                REPLACE cursor_4c_Consulta.grupos  WITH ""
                REPLACE cursor_4c_Consulta.dcompos WITH ""
            ENDIF

            IF USED("cursor_4c_PrfSel")
                USE IN cursor_4c_PrfSel
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaFase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConsultaCat - Abre lookup SigCdCat para selecionar categoria (col 8)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConsultaCat()
        LOCAL loc_oPg, loc_oBusca, loc_cCods, loc_cDescs

        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6

        TRY
            IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
                RETURN
            ENDIF

            loc_cCods  = ALLTRIM(NVL(cursor_4c_Consulta.cats, ""))
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCat", "cursor_4c_CatSel", "cods", loc_cCods, "Selecionar Categoria")
            loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_CatSel")
                    loc_cCods  = ALLTRIM(NVL(cursor_4c_CatSel.cods,  ""))
                    loc_cDescs = ALLTRIM(NVL(cursor_4c_CatSel.descs, ""))
                    REPLACE cursor_4c_Consulta.cats   WITH loc_cCods
                    REPLACE cursor_4c_Consulta.dscgrp WITH loc_cDescs
                    IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
                        loc_oPg.grd_4c_Consulta.Refresh()
                    ENDIF
                ENDIF
            ELSE
                REPLACE cursor_4c_Consulta.cats   WITH ""
                REPLACE cursor_4c_Consulta.dscgrp WITH ""
            ENDIF

            IF USED("cursor_4c_CatSel")
                USE IN cursor_4c_CatSel
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaCat")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmbTiposCustoValid - ComboBox tipo custo: ao mudar selecao, recarrega grid
    *--------------------------------------------------------------------------
    PROCEDURE CmbTiposCustoValid()
        TRY
            THIS.CarregarCustos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmbTiposCustoValid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCustoIncluirClick - Botao incluir linha no grid de custo
    * Insere novo registro em SIGPRCPO com Tipos = valor selecionado no combo
    *--------------------------------------------------------------------------
    PROCEDURE CmdCustoIncluirClick()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF EMPTY(loc_cCpros)
            RETURN
        ENDIF

        TRY
            loc_nTipo = 1
            IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
                loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1)
                *-- ListIndex 1=Todos: usar tipo 1; demais: usar o proprio valor
                IF loc_nTipo < 1
                    loc_nTipo = 1
                ENDIF
            ENDIF

            loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves, tipos) VALUES (" + ;
                       EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + TRANSFORM(loc_nTipo) + ")"
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarCustos()
                IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
                    loc_oPg.grd_4c_CompoCusto.SetFocus()
                ENDIF
            ELSE
                MsgErro("Erro ao incluir linha no custo.", "FormProduto.CmdCustoIncluirClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdCustoIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCustoExcluirClick - Botao excluir linha do grid de custo
    * Remove registro de SIGPRCPO com base no material selecionado
    *--------------------------------------------------------------------------
    PROCEDURE CmdCustoExcluirClick()
        LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg, loc_lConfirma
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF NOT USED("cursor_4c_CompoCusto") OR EOF("cursor_4c_CompoCusto")
            RETURN
        ENDIF

        TRY
            loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))

            IF EMPTY(loc_cMats)
                MsgAviso("Selecione um item para excluir.", "FormProduto")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do item '" + loc_cMats + "'?", "FormProduto")
            IF !loc_lConfirma
                RETURN
            ENDIF

            loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCpros) + ;
                       " AND RTRIM(mats) = " + EscaparSQL(loc_cMats)
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarCustos()
            ELSE
                MsgErro("Erro ao excluir linha do custo.", "FormProduto.CmdCustoExcluirClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.CmdCustoExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * METODOS DA ABA FASES (Tab 7 - PgDadosFaseP)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrdFasesAfterRowColChange - Atualiza imagem + descricao ao navegar no grid
    * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
    *--------------------------------------------------------------------------
    PROCEDURE GrdFasesAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_oPg, loc_cCpros, loc_cGrupos, loc_cSQL, loc_nR, loc_cArquivo
        LOCAL loc_nOrdems

        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
            loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

            IF EMPTY(loc_cCpros) OR !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
                RETURN
            ENDIF

            loc_cGrupos  = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
            loc_nOrdems  = NVL(cursor_4c_Fases.ordems, 0)

            *-- Limpar imagem anterior
            IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
                loc_oPg.img_4c_ImgFigJpg.Picture = ""
                loc_oPg.img_4c_ImgFigJpg.Visible = .F.
            ENDIF

            *-- Carregar imagem FigProcs da fase atual (campo binario em SigCdPrf)
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND loc_nOrdems > 0
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SELECT TOP 1 FigProcs FROM SigCdPrf
                    WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                    AND ordems = <<loc_nOrdems>>
                ENDTEXT
                loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigFase")
                IF loc_nR > 0 AND !EOF("cursor_4c_FigFase")
                    IF !EMPTY(NVL(cursor_4c_FigFase.FigProcs, ""))
                        loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                        IF (STRTOFILE(cursor_4c_FigFase.FigProcs, loc_cArquivo) > 0)
                            IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
                                loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
                                loc_oPg.img_4c_ImgFigJpg.Visible = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_FigFase")
                    USE IN cursor_4c_FigFase
                ENDIF
            ENDIF

            *-- Carregar descricao e observacao da fase (SigCdGcr)
            IF !EMPTY(loc_cGrupos) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cGrupos)>>)
                ENDTEXT
                loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FaseDesc")
                IF loc_nR > 0 AND !EOF("cursor_4c_FaseDesc")
                    IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
                        loc_oPg.txt_4c_DescFase.Value = ALLTRIM(NVL(cursor_4c_FaseDesc.Descrs, ""))
                    ENDIF
                ELSE
                    IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
                        loc_oPg.txt_4c_DescFase.Value = ""
                    ENDIF
                ENDIF
                IF USED("cursor_4c_FaseDesc")
                    USE IN cursor_4c_FaseDesc
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
                    loc_oPg.txt_4c_DescFase.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "edt_4c_ObsFase", 5)
                    loc_oPg.edt_4c_ObsFase.Value = ""
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar imagem da fase:" + CHR(13) + loc_oErro.Message, "FormProduto.GrdFasesAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdMatrizesAfterRowColChange - Atualiza imagem ao navegar no grid de matrizes
    * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
    *--------------------------------------------------------------------------
    PROCEDURE GrdMatrizesAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_oPg, loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFigB64

        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7

            *-- Limpar imagem anterior
            IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5)
                loc_oPg.img_4c_ImgBorracha.Picture = ""
                loc_oPg.img_4c_ImgBorracha.Visible = .F.
            ENDIF

            IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
                RETURN
            ENDIF

            loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
            IF EMPTY(loc_cCmats) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
                RETURN
            ENDIF

            *-- Carregar imagem FigJpgs do produto matriz (SigCdPro)
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 FigJpgs FROM SigCdPro WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigBorr")
            IF loc_nR > 0 AND !EOF("cursor_4c_FigBorr")
                loc_cFigB64 = NVL(cursor_4c_FigBorr.FigJpgs, "")
                IF !EMPTY(loc_cFigB64)
                    *-- Converter de Base64 para binario
                    LOCAL loc_cFigBin
                    loc_cFigBin = STRCONV( ;
                        STRTRAN(STRTRAN(STRTRAN(loc_cFigB64, ;
                            "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)
                    loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                    IF STRTOFILE(loc_cFigBin, loc_cArquivo) > 0
                        IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
                            loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
                            loc_oPg.img_4c_ImgBorracha.Visible = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_FigBorr")
                USE IN cursor_4c_FigBorr
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar imagem da matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.GrdMatrizesAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgClick - Clique na imagem da fase: abre zoom
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgClick()
        LOCAL loc_oPg, loc_cArquivo
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
            loc_cArquivo = loc_oPg.img_4c_ImgFigJpg.Picture
            IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
                MsgInfo("Zoom de imagem: " + loc_cArquivo, "Imagem da Fase")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_CodcorsKeyPress - F4 no campo Cor (aba Fases) abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_CodcorsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCorFas()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_CodcorsLostFocus - LostFocus valida cor na aba Fases
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_CodcorsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        IF !PEMSTATUS(loc_oPg, "txt_4c_CodcorsFas", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodcorsFas.Value)
        IF loc_cCod == THIS.this_cUltCorFas
            RETURN
        ENDIF
        THIS.this_cUltCorFas = loc_cCod
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCorFas")
            IF loc_nR <= 0 OR EOF("cursor_4c_VCorFas")
                THIS.AbrirLookupCorFas()
            ELSE
                THIS.this_oBusinessObject.this_cCodcors = loc_cCod
            ENDIF
            IF USED("cursor_4c_VCorFas")
                USE IN cursor_4c_VCorFas
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodcorsLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCorFas - Lookup Cor para a aba Fases
    * Atualiza Page7 e Page1 (campos sincronizados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupCorFas()
        LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
        loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodcorsFas.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_CorFas", "cods", loc_cVal, "Selecionar Cor")
            loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_CorFas")
                    LOCAL loc_cCodSel
                    loc_cCodSel = ALLTRIM(cursor_4c_CorFas.cods)
                    IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
                        loc_oPg7.txt_4c_CodcorsFas.Value = loc_cCodSel
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_Codcors", 5)
                        loc_oPg1.txt_4c_Codcors.Value = loc_cCodSel
                    ENDIF
                    THIS.this_oBusinessObject.this_cCodcors = loc_cCodSel
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
                    loc_oPg7.txt_4c_CodcorsFas.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_CorFas")
                USE IN cursor_4c_CorFas
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de cor (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCorFas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_CodtamsKeyPress - F4 no campo Tamanho (aba Fases) abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_CodtamsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupTamanhoFas()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_CodtamsLostFocus - LostFocus valida tamanho na aba Fases
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_CodtamsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        IF !PEMSTATUS(loc_oPg, "txt_4c_CodtamsFas", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodtamsFas.Value)
        IF loc_cCod == THIS.this_cUltTamFas
            RETURN
        ENDIF
        THIS.this_cUltTamFas = loc_cCod
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 Cods FROM SigCdTam WHERE Cods = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VTamFas")
            IF loc_nR <= 0 OR EOF("cursor_4c_VTamFas")
                THIS.AbrirLookupTamanhoFas()
            ELSE
                THIS.this_oBusinessObject.this_cCodtams = loc_cCod
            ENDIF
            IF USED("cursor_4c_VTamFas")
                USE IN cursor_4c_VTamFas
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodtamsLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTamanhoFas - Lookup Tamanho para a aba Fases
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupTamanhoFas()
        LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
        loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodtamsFas.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_TamFas", "Cods", loc_cVal, "Selecionar Tamanho")
            loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_TamFas")
                    LOCAL loc_cCodSel
                    loc_cCodSel = ALLTRIM(cursor_4c_TamFas.Cods)
                    IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
                        loc_oPg7.txt_4c_CodtamsFas.Value = loc_cCodSel
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_Codtams", 5)
                        loc_oPg1.txt_4c_Codtams.Value = loc_cCodSel
                    ENDIF
                    THIS.this_oBusinessObject.this_cCodtams = loc_cCodSel
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
                    loc_oPg7.txt_4c_CodtamsFas.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_TamFas")
                USE IN cursor_4c_TamFas
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de tamanho (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanhoFas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_CodacbsKeyPress - F4 no campo Acabamento (aba Fases) abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_CodacbsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupAcabamentoFas()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_CodacbsLostFocus - LostFocus valida acabamento na aba Fases
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_CodacbsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        IF !PEMSTATUS(loc_oPg, "txt_4c_CodacbsFas", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodacbsFas.Value)
        IF loc_cCod == THIS.this_cUltAcbFas
            RETURN
        ENDIF
        THIS.this_cUltAcbFas = loc_cCod
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
                loc_oPg.txt_4c_DacbsFas.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcbFas")
            IF loc_nR > 0 AND !EOF("cursor_4c_VAcbFas")
                IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
                    loc_oPg.txt_4c_DacbsFas.Value = ALLTRIM(cursor_4c_VAcbFas.descrs)
                ENDIF
                THIS.this_oBusinessObject.this_cCodacbs = loc_cCod
            ELSE
                THIS.AbrirLookupAcabamentoFas()
            ENDIF
            IF USED("cursor_4c_VAcbFas")
                USE IN cursor_4c_VAcbFas
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodacbsLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupAcabamentoFas - Lookup Acabamento para a aba Fases
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupAcabamentoFas()
        LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
        loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodacbsFas.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_AcbFas", "cods", loc_cVal, "Selecionar Acabamento")
            loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_AcbFas")
                    LOCAL loc_cCodSel, loc_cDescSel
                    loc_cCodSel  = ALLTRIM(cursor_4c_AcbFas.cods)
                    loc_cDescSel = ALLTRIM(cursor_4c_AcbFas.descrs)
                    IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
                        loc_oPg7.txt_4c_CodacbsFas.Value = loc_cCodSel
                    ENDIF
                    IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
                        loc_oPg7.txt_4c_DacbsFas.Value = loc_cDescSel
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_Codacbs", 5)
                        loc_oPg1.txt_4c_Codacbs.Value = loc_cCodSel
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_Dcodacbs", 5)
                        loc_oPg1.txt_4c_Dcodacbs.Value = loc_cDescSel
                    ENDIF
                    THIS.this_oBusinessObject.this_cCodacbs = loc_cCodSel
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
                    loc_oPg7.txt_4c_CodacbsFas.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
                    loc_oPg7.txt_4c_DacbsFas.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_AcbFas")
                USE IN cursor_4c_AcbFas
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de acabamento (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamentoFas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_ConquilhaKeyPress - F4 no campo Conquilha abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_ConquilhaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConquilha()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_ConquilhaLostFocus - LostFocus valida conquilha
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_ConquilhaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        IF !PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
        IF loc_cCod == THIS.this_cUltConquilha
            RETURN
        ENDIF
        THIS.this_cUltConquilha = loc_cCod
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 conquilhas FROM SigCdCnq WHERE RTRIM(conquilhas) = RTRIM(<<EscaparSQL(loc_cCod)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCnq")
            IF loc_nR <= 0 OR EOF("cursor_4c_VCnq")
                THIS.AbrirLookupConquilha()
            ELSE
                THIS.this_oBusinessObject.this_cConquilhas = loc_cCod
            ENDIF
            IF USED("cursor_4c_VCnq")
                USE IN cursor_4c_VCnq
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_ConquilhaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConquilha - Lookup para campo Conquilha (SigCdCnq)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupConquilha()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5), ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCnq", "cursor_4c_Cnq", "conquilhas", loc_cVal, "Selecionar Conquilha")
            loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Cnq")
                    LOCAL loc_cCodSel
                    loc_cCodSel = ALLTRIM(cursor_4c_Cnq.conquilhas)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
                        loc_oPg.txt_4c_Conquilhas.Value = loc_cCodSel
                    ENDIF
                    THIS.this_oBusinessObject.this_cConquilhas = loc_cCodSel
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
                    loc_oPg.txt_4c_Conquilhas.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Cnq")
                USE IN cursor_4c_Cnq
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupConquilha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_GarraKeyPress - F4 no campo Garra abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_GarraKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGarra()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabFases_GarraLostFocus - LostFocus valida garra
    *--------------------------------------------------------------------------
    PROCEDURE TabFases_GarraLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        IF !PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codgarras.Value)
        IF loc_cCod == THIS.this_cUltGarra
            RETURN
        ENDIF
        THIS.this_cUltGarra = loc_cCod
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 codgarras FROM SigCdGar WHERE RTRIM(codgarras) = RTRIM(<<EscaparSQL(loc_cCod)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGar")
            IF loc_nR <= 0 OR EOF("cursor_4c_VGar")
                THIS.AbrirLookupGarra()
            ELSE
                THIS.this_oBusinessObject.this_cCodgarras = loc_cCod
            ENDIF
            IF USED("cursor_4c_VGar")
                USE IN cursor_4c_VGar
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar garra:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_GarraLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGarra - Lookup para campo Garra (SigCdGar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupGarra()
        LOCAL loc_oBusca, loc_oPg, loc_cVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
        loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5), ALLTRIM(loc_oPg.txt_4c_Codgarras.Value), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGar", "cursor_4c_Gar", "codgarras", loc_cVal, "Selecionar Garra")
            loc_oBusca.mAddColuna("codgarras", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Gar")
                    LOCAL loc_cCodSel
                    loc_cCodSel = ALLTRIM(cursor_4c_Gar.codgarras)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
                        loc_oPg.txt_4c_Codgarras.Value = loc_cCodSel
                    ENDIF
                    THIS.this_oBusinessObject.this_cCodgarras = loc_cCodSel
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
                    loc_oPg.txt_4c_Codgarras.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_Gar")
                USE IN cursor_4c_Gar
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro no lookup de garra:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGarra")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirFaseClick - Inserir nova fase de producao em SigCdPrf
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirFaseClick()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nProxOrdem, loc_nMaxOrdem

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            MsgAviso("Salve ou edite o produto antes de inserir fases.", "FormProduto")
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        IF EMPTY(loc_cCpros)
            MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
            RETURN
        ENDIF

        TRY
            *-- Calcular proximo numero de ordem
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
                WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdem")
            IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdem")
                loc_nProxOrdem = NVL(cursor_4c_MaxOrdem.proximo, 1)
            ELSE
                loc_nProxOrdem = 1
            ENDIF
            IF USED("cursor_4c_MaxOrdem")
                USE IN cursor_4c_MaxOrdem
            ENDIF

            *-- Inserir nova fase
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
                VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, '', 0, '', '')
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarFases()
                LOCAL loc_oPg7
                loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
                    loc_oPg7.grd_4c_Fases.SetFocus()
                ENDIF
            ELSE
                MsgErro("Erro ao inserir fase.", "FormProduto.BtnInserirFaseClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirFaseClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirFaseClick - Excluir fase de producao selecionada
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirFaseClick()
        LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_lConfirma

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
            MsgAviso("Selecione uma fase para excluir.", "FormProduto")
            RETURN
        ENDIF

        loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)

        IF loc_nOrdems <= 0
            MsgAviso("Selecione uma fase v" + CHR(225) + "lida para excluir.", "FormProduto")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da fase " + TRANSFORM(loc_nOrdems) + "?", "FormProduto")
        IF !loc_lConfirma
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdPrf
                WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
                AND ordems = <<loc_nOrdems>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarFases()
            ELSE
                MsgErro("Erro ao excluir fase.", "FormProduto.BtnExcluirFaseClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirFaseClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlternativaFaseClick - Inserir fase alternativa (alternativa da fase atual)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlternativaFaseClick()
        LOCAL loc_cCpros, loc_cGrupoAtual, loc_cSQL, loc_nR, loc_nProxOrdem

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            MsgAviso("Salve ou edite o produto antes de inserir alternativas.", "FormProduto")
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        IF EMPTY(loc_cCpros)
            MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
            RETURN
        ENDIF

        IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
            MsgAviso("Selecione uma fase base para criar a alternativa.", "FormProduto")
            RETURN
        ENDIF

        loc_cGrupoAtual = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
        IF EMPTY(loc_cGrupoAtual)
            MsgAviso("A fase selecionada precisa ter um grupo definido.", "FormProduto")
            RETURN
        ENDIF

        TRY
            *-- Calcular proximo numero de ordem
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
                WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdAlt")
            IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdAlt")
                loc_nProxOrdem = NVL(cursor_4c_MaxOrdAlt.proximo, 1)
            ELSE
                loc_nProxOrdem = 1
            ENDIF
            IF USED("cursor_4c_MaxOrdAlt")
                USE IN cursor_4c_MaxOrdAlt
            ENDIF

            *-- Inserir fase alternativa copiando o grupo da fase atual
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
                VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, <<EscaparSQL(loc_cGrupoAtual)>>, 0, '', '')
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarFases()
            ELSE
                MsgErro("Erro ao inserir fase alternativa.", "FormProduto.BtnAlternativaFaseClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir alternativa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnAlternativaFaseClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdFichaClick - Imprimir ficha tecnica das fases do produto
    *--------------------------------------------------------------------------
    PROCEDURE CmdFichaClick()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oBO

        loc_oBO    = THIS.this_oBusinessObject
        loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)

        IF EMPTY(loc_cCpros)
            MsgAviso("Nenhum produto selecionado.", "FormProduto")
            RETURN
        ENDIF

        TRY
            *-- Criar cursor de cabecalho para o relatorio
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho ( ;
                _NmEmp  C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
                _cGrus  C(03), _dGrus C(20), _sGrus C(06), _sDesc C(20), ;
                _cLinh  C(10), _dLinh C(40), _cGVen C(10), _dGVen C(40), ;
                _nPeso  N(9,2), _DtIni D(08), _DtFin D(08), _TExec C(15), _cMode C(10))

            INSERT INTO CsCabecalho ;
                (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _dGrus, _cMode) ;
                VALUES( ;
                    go_4c_Sistema.cEmpresa, ;
                    "Ficha T" + CHR(233) + "cnica de Fases", ;
                    loc_cCpros, ;
                    loc_oBO.this_cDpros, ;
                    loc_oBO.this_cCgrus, ;
                    THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus"), ;
                    THIS.this_cModoAtual)

            MsgInfo("Ficha t" + CHR(233) + "cnica gerada. Configure o relat" + CHR(243) + "rio RelFase.frx para impress" + CHR(227) + "o.", "Ficha T" + CHR(233) + "cnica")

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao gerar ficha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdFichaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdgFiguraClick - Carregar/remover imagem da fase selecionada (FigProcs)
    *--------------------------------------------------------------------------
    PROCEDURE CmdgFiguraClick()
        LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig
        LOCAL loc_oPg, loc_lConfirma

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
            MsgAviso("Selecione uma fase para carregar a imagem.", "FormProduto")
            RETURN
        ENDIF

        loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)

        IF loc_nOrdems <= 0
            MsgAviso("Selecione uma fase v" + CHR(225) + "lida.", "FormProduto")
            RETURN
        ENDIF

        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7

        TRY
            *-- Verificar se ja tem imagem
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT TOP 1 CASE WHEN FigProcs IS NULL OR LEN(RTRIM(FigProcs))=0 THEN 0 ELSE 1 END AS temFig
                FROM SigCdPrf
                WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFig")
            LOCAL loc_lTemFig
            loc_lTemFig = .F.
            IF loc_nR > 0 AND !EOF("cursor_4c_VerFig")
                loc_lTemFig = (cursor_4c_VerFig.temFig > 0)
            ENDIF
            IF USED("cursor_4c_VerFig")
                USE IN cursor_4c_VerFig
            ENDIF

            IF loc_lTemFig
                *-- Oferecer opcoes: substituir ou remover
                loc_lConfirma = MsgConfirma("Esta fase j" + CHR(225) + " possui imagem. Deseja remov" + CHR(234) + "-la?", "Imagem da Fase")
                IF loc_lConfirma
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        UPDATE SigCdPrf SET FigProcs = NULL
                        WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
                    ENDTEXT
                    loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nR > 0
                        IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
                            loc_oPg.img_4c_ImgFigJpg.Picture = ""
                            loc_oPg.img_4c_ImgFigJpg.Visible = .F.
                        ENDIF
                        MsgInfo("Imagem removida.", "FormProduto")
                    ENDIF
                    RETURN
                ENDIF
            ENDIF

            *-- Selecionar arquivo de imagem
            loc_cFig = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar Imagem da Fase:")
            IF EMPTY(loc_cFig) OR !FILE(loc_cFig)
                RETURN
            ENDIF

            *-- Salvar imagem em SigCdPrf.FigProcs
            LOCAL loc_cBinImg
            loc_cBinImg = FILETOSTR(loc_cFig)
            IF EMPTY(loc_cBinImg)
                MsgErro("Falha ao ler arquivo de imagem.", "FormProduto.CmdgFiguraClick")
                RETURN
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdPrf SET FigProcs = ?loc_cBinImg
                WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                *-- Exibir imagem carregada
                loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                STRTOFILE(loc_cBinImg, loc_cArquivo)
                IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
                    loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
                    loc_oPg.img_4c_ImgFigJpg.Visible = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFiguraClick")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar imagem:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFiguraClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdgFigCamClick - Carregar/remover imagem de borracha (camera/molde)
    * Equivalente ao cmdgFigCam do legado: camera para imagem da borracha
    *--------------------------------------------------------------------------
    PROCEDURE CmdgFigCamClick()
        LOCAL loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig, loc_oPg

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
            MsgAviso("Selecione uma matriz para carregar a imagem.", "FormProduto")
            RETURN
        ENDIF

        loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
        IF EMPTY(loc_cCmats)
            MsgAviso("Selecione uma matriz v" + CHR(225) + "lida.", "FormProduto")
            RETURN
        ENDIF

        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7

        TRY
            *-- Selecionar arquivo de imagem
            loc_cFig = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar Imagem da Borracha:")
            IF EMPTY(loc_cFig) OR !FILE(loc_cFig)
                RETURN
            ENDIF

            *-- Converter para Base64 e salvar em SigCdPro.FigJpgs
            LOCAL loc_cBinImg, loc_cB64
            loc_cBinImg = FILETOSTR(loc_cFig)
            IF EMPTY(loc_cBinImg)
                MsgErro("Falha ao ler arquivo de imagem.", "FormProduto.CmdgFigCamClick")
                RETURN
            ENDIF

            loc_cB64 = "data:image/jpeg;base64," + STRCONV(loc_cBinImg, 13)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdPro SET FigJpgs = ?loc_cB64
                WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                *-- Exibir imagem
                loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                STRTOFILE(loc_cBinImg, loc_cArquivo)
                IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
                    loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
                    loc_oPg.img_4c_ImgBorracha.Visible = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFigCamClick")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar imagem de borracha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFigCamClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirMatrizClick - Inserir nova linha na grade de matrizes (SigPrMtz)
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirMatrizClick()
        LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            MsgAviso("Salve ou edite o produto antes de inserir matrizes.", "FormProduto")
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        IF EMPTY(loc_cCpros)
            MsgAviso("Produto n" + CHR(227) + "o identificado.", "FormProduto")
            RETURN
        ENDIF

        TRY
            *-- Inserir nova linha vazia em SigPrMtz com cIdChaves unico
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrMtz (cpros, cidchaves, cmats, qtds)
                VALUES (<<EscaparSQL(loc_cCpros)>>, NEWID(), '', 0)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarMatrizes()
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
                    loc_oPg.grd_4c_Matrizes.SetFocus()
                ENDIF
            ELSE
                MsgErro("Erro ao inserir matriz.", "FormProduto.BtnInserirMatrizClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirMatrizClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirMatrizClick - Excluir linha selecionada da grade de matrizes
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirMatrizClick()
        LOCAL loc_cCpros, loc_cCidChaves, loc_cSQL, loc_nR, loc_lConfirma

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
            MsgAviso("Selecione uma matriz para excluir.", "FormProduto")
            RETURN
        ENDIF

        loc_cCpros     = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Matrizes.cidchaves, ""))

        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione uma linha v" + CHR(225) + "lida para excluir.", "FormProduto")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o desta matriz?", "FormProduto")
        IF !loc_lConfirma
            RETURN
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigPrMtz
                WHERE RTRIM(cidchaves) = RTRIM(<<EscaparSQL(loc_cCidChaves)>>)
            ENDTEXT
            loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nR > 0
                THIS.CarregarMatrizes()
            ELSE
                MsgErro("Erro ao excluir matriz.", "FormProduto.BtnExcluirMatrizClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirMatrizClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesignerGrd_AfterRowColChange - Grid tarefas: ao navegar linha/coluna
    * Atualiza txt_4c_ObsTarefas com descricao da tarefa da linha atual
    * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
    *--------------------------------------------------------------------------
    PROCEDURE DesignerGrd_AfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_cCodTarefa, loc_cDesTarefa
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

        TRY
            IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
                loc_cCodTarefa = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
                loc_cDesTarefa = ""

                *-- Buscar descricao no cursor de tarefas
                IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas") AND !EMPTY(loc_cCodTarefa)
                    SELECT cursor_4c_Tarefas
                    LOCATE FOR ALLTRIM(CodCads) = loc_cCodTarefa
                    IF !EOF("cursor_4c_Tarefas")
                        loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
                    ENDIF
                ENDIF

                IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
                    loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
                    loc_oPg.txt_4c_ObsTarefas.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.DesignerGrd_AfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ArquivosGrd_AfterRowColChange - Grid arquivos: ao navegar linha/coluna
    * Exibe preview de imagem em img_4c_ImgArqJpg se arquivo for JPG/ICO/BMP/JPEG
    * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
    *--------------------------------------------------------------------------
    PROCEDURE ArquivosGrd_AfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_cArq, loc_cExt
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

        TRY
            IF !PEMSTATUS(loc_oPg, "img_4c_ImgArqJpg", 5)
                RETURN
            ENDIF

            *-- Limpar preview
            CLEAR RESOURCES
            loc_oPg.img_4c_ImgArqJpg.Picture = ""
            loc_oPg.img_4c_ImgArqJpg.Visible = .F.

            IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
                loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))

                IF !EMPTY(loc_cArq)
                    loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))

                    IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
                        loc_oPg.img_4c_ImgArqJpg.Picture = loc_cArq
                        loc_oPg.img_4c_ImgArqJpg.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.ArquivosGrd_AfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDesignerColReadOnlyWhen - Colunas 1/2/3 do grd_4c_Designer: sempre somente leitura
    * Retorna .F. para bloquear edicao (original: Return .f.)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDesignerColReadOnlyWhen()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDesignerCol4When - Column4 do grd_4c_Designer (Tarefa): editavel condicionalmente
    * Editavel apenas em INSERIR/ALTERAR, para o usuario atual, sem DtFims
    * Original: Return InList(pcEscolha, INSERIR, ALTERAR) And Usuars=Usuar And IsEmpty(DtFims)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDesignerCol4When()
        LOCAL loc_lEditavel, loc_cUsuars, loc_cDtFims

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
            loc_cUsuars = ALLTRIM(NVL(cursor_4c_Designer.usuars, ""))
            loc_cDtFims = NVL(cursor_4c_Designer.dtfims, {})

            IF loc_cUsuars <> ALLTRIM(gc_4c_UsuarioLogado)
                RETURN .F.
            ENDIF

            IF !EMPTY(loc_cDtFims)
                RETURN .F.
            ENDIF

            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDesignerCol4Valid - Column4 do grd_4c_Designer: valida/lookup de tarefa
    * Se cursor_4c_Tarefas tem dados: valida codigo; se nao encontrado, limpa campo
    * Se cursor_4c_Tarefas vazio (tabela SigPrTrf inexistente): aceita qualquer valor
    * Original: fwBuscaInt em crTarefas (CodCads/DesCads)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDesignerCol4Valid()
        LOCAL loc_oPg, loc_cValor, loc_cCodTarefa, loc_cDesTarefa, loc_lEncontrou
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

        TRY
            *-- Obter valor atual da celula via cursor_4c_Designer
            loc_cValor = ""
            IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
                loc_cValor = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
            ENDIF

            IF EMPTY(loc_cValor)
                loc_lResultado = .T.
            ENDIF

            *-- Cursor de tarefas vazio: tabela mestre nao disponivel, aceitar qualquer valor
            IF !USED("cursor_4c_Tarefas") OR RECCOUNT("cursor_4c_Tarefas") = 0
                loc_lResultado = .T.
            ENDIF

            *-- Verificar se codigo existe no cursor de tarefas
            loc_lEncontrou = .F.
            loc_cCodTarefa = ""
            loc_cDesTarefa = ""

            SELECT cursor_4c_Tarefas
            LOCATE FOR ALLTRIM(CodCads) = loc_cValor
            IF !EOF("cursor_4c_Tarefas")
                loc_lEncontrou = .T.
                loc_cCodTarefa = ALLTRIM(cursor_4c_Tarefas.CodCads)
                loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
            ENDIF

            *-- Atualizar descricao se encontrou; limpar se nao encontrou
            IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
                IF loc_lEncontrou
                    IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
                        loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
                    ENDIF
                ELSE
                    MsgAviso("C" + CHR(243) + "digo de tarefa n" + CHR(227) + "o encontrado.", "Tarefa Designer")
                    REPLACE cursor_4c_Designer.tarefas WITH ""
                    IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
                        loc_oPg.txt_4c_ObsTarefas.Value = ""
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4Valid")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDesignerCol4LostFocus - Column4 perde foco: navega para txt_4c_ObsTarefas ao Enter
    * Original: If Not Empty(This.Value) And (Lastkey()=13) -> getObsTarefas.SetFocus
    *--------------------------------------------------------------------------
    PROCEDURE GrdDesignerCol4LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

        TRY
            IF LASTKEY() = 13
                IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
                    IF !EMPTY(ALLTRIM(NVL(cursor_4c_Designer.tarefas, "")))
                        IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
                            loc_oPg.txt_4c_ObsTarefas.SetFocus()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4LostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdArquivosCol1When - Column1 do grd_4c_Arquivos: editavel em INCLUIR/ALTERAR
    * Original: Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
    *--------------------------------------------------------------------------
    PROCEDURE GrdArquivosCol1When()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgArqJpgClick - Clique na imagem: exibe caminho do arquivo
    * Original: Do Form SigOpZom (zoom view) - forma simplificada: exibe path
    *--------------------------------------------------------------------------
    PROCEDURE ImgArqJpgClick()
        LOCAL loc_cArq
        loc_cArq = ""

        IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
            loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))
        ENDIF

        IF !EMPTY(loc_cArq)
            MsgAviso(loc_cArq, "Arquivo Selecionado")
        ENDIF
    ENDPROC

ENDDEFINE
