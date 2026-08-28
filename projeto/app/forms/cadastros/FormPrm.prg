*====================================================================
* FormPrm.prg
*
* Formulario de Cadastro de Promocoes
* Tabelas: SigPrPmc (cabecalho), SigPrPmi (itens/produtos),
*           SigPrPmv (grupos de venda)
* Herda de: FormBase
*====================================================================

DEFINE CLASS FormPrm AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Promocoes"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cTipo           = ""

    *====================================================================
    * Init - Inicializa o formulario
    * par_cTipo: "" = Cadastro padrao, "E" = Cadastro e-Commerce
    *====================================================================
    PROCEDURE Init(par_cTipo)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_cTipo) = "C"
                THIS.this_cTipo = UPPER(ALLTRIM(par_cTipo))
            ENDIF

            IF THIS.this_cTipo == "E"
                THIS.Caption = "Cadastro de Promo" + CHR(231) + CHR(245) + "es e-Commerce"
            ELSE
                THIS.Caption = "Cadastro de Promo" + CHR(231) + CHR(245) + "es"
            ENDIF

            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro(loException, "FormPrm.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarForm - Configura estrutura do formulario
    * Chamado pelo FormBase.Init()
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("PrmBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar PrmBO", "Erro")
                loc_lSucesso = .F.
            ENDIF
            THIS.this_oBusinessObject.this_cTipo = THIS.this_cTipo

            THIS.CriarCursoresLocais()
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarPaginaDados()

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarLista()
            ENDIF

            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FormPrm.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursoresLocais - Cria cursores de trabalho locais
    * Equivalente ao LOAD do legado (Load nao existe em .prg)
    * csSigPrPmi: produtos/itens da promocao (edicao em grid)
    * TcrSigPrPmi: log temporario de alteracoes
    * csSigPrPmv: grupos de venda da promocao (edicao em grid)
    *====================================================================
    PROTECTED PROCEDURE CriarCursoresLocais()
        SET NULL ON
        CREATE CURSOR csSigPrPmi (CPros c(14), DPros c(40), Pecas c(10), ;
            Promos c(25), CBars n(8), Datas d NULL, DtAlts t NULL, ;
            PromoPro c(35), Vendavels n(1), cIdChaves c(20))
        SELECT csSigPrPmi
        INDEX ON CPros TAG CPros

        CREATE CURSOR TcrSigPrPmi (CPros c(14), Datas d NULL, Pecas c(10), Vendavels n(1))
        INDEX ON CPros TAG idxTcpros

        CREATE CURSOR csSigPrPmv (Promos c(25), Colecoes c(10), Datas t NULL, cIdChaves c(20))
        SELECT csSigPrPmv

        CREATE CURSOR cursor_4c_Itens ;
            (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
             Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
             PromoPro C(35), Vendavels N(1,0) NULL)
        INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)

        CREATE CURSOR cursor_4c_Grupos ;
            (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
        INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())

        SET NULL OFF
    ENDPROC

    *====================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .TabStop   = .F.
            .Visible   = .T.
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e botoes CRUD
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho - Top=31 (2 + 29 compensacao PageFrame.Top=-29)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (lado direito) - Top=29 (0+29 compensacao)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container saida (padrao canonico, Top=29)
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
                .Left            = 917
                .Width           = 90
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid principal: Top=117 (88+29), Width=910 (nao sobrepoem cnt_4c_Saida em Left=917)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 5
        WITH loc_oGrid
            .Top                = 117
            .Left               = 0
            .Width              = 910
            .Height             = 478
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
            .Column1.Width      = 250
            .Column2.Width      = 60
            .Column3.Width      = 85
            .Column4.Width      = 60
            .Column5.Width      = 200
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *====================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados) com campos do cabecalho
    * Fase 5: botoes, campos principais (Promos, Codigo, Comissao, eCommerce)
    * Fase 6: sub-pageframe pgGrades com grids de produtos e grupos
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (canonico: Top=33, Left=842)
        *-- Legado: Grupo_Salva.Left=611, Top=13 -> usar canonico
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
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
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label "Promoção :" + txt_4c_Promos
        *-- Legado: lbl_promocao Top=133, Left=31 -> compensado +29 = 162
        *-- Legado: get_promos   Top=130, Left=101 -> compensado +29 = 159
        loc_oPagina.AddObject("lbl_4c_Promocao", "Label")
        WITH loc_oPagina.lbl_4c_Promocao
            .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
            .Top       = 162
            .Left      = 31
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Promos", "TextBox")
        WITH loc_oPagina.txt_4c_Promos
            .Value     = ""
            .Top       = 159
            .Left      = 101
            .Width     = 185
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 25
            .Visible   = .T.
        ENDWITH

        *-- Label "Código :" + txt_4c_Codigo
        *-- Legado: Say1     Top=157, Left=48  -> compensado +29 = 186
        *-- Legado: getCodigo Top=154, Left=101 -> compensado +29 = 183
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 186
            .Left      = 48
            .Width     = 51
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 183
            .Left      = 101
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .Visible   = .T.
        ENDWITH

        *-- CheckBox "Comissão Incentivada :" + txt_4c_Comiss
        *-- Legado: chkComissao Top=133, Left=310 -> compensado +29 = 162
        *-- Legado: getComiss   Top=130, Left=466 -> compensado +29 = 159
        loc_oPagina.AddObject("chk_4c_Comissao", "CheckBox")
        WITH loc_oPagina.chk_4c_Comissao
            .Caption   = "Comiss" + CHR(227) + "o Incentivada :"
            .Value     = 0
            .Top       = 162
            .Left      = 310
            .Width     = 155
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Comiss", "TextBox")
        WITH loc_oPagina.txt_4c_Comiss
            .Value     = 0
            .Top       = 159
            .Left      = 466
            .Width     = 52
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99.99"
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- CheckBox "Integrar e-Commerce :" + txt_4c_LPrecos
        *-- Legado: chkeCommerce Top=157, Left=311 -> compensado +29 = 186
        *-- Legado: getLPrecos   Top=154, Left=466 -> compensado +29 = 183
        loc_oPagina.AddObject("chk_4c_eCommerce", "CheckBox")
        WITH loc_oPagina.chk_4c_eCommerce
            .Caption   = "Integrar e-Commerce :"
            .Value     = 0
            .Top       = 186
            .Left      = 311
            .Width     = 148
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_LPrecos", "TextBox")
        WITH loc_oPagina.txt_4c_LPrecos
            .Value     = ""
            .Top       = 183
            .Left      = 466
            .Width     = 220
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 30
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs validacao e lookup
        BINDEVENT(loc_oPagina.txt_4c_Promos,    "KeyPress",         THIS, "ValidarPromos")
        BINDEVENT(loc_oPagina.txt_4c_LPrecos,   "KeyPress",         THIS, "ValidarLPrecos")
        BINDEVENT(loc_oPagina.chk_4c_Comissao,  "InteractiveChange", THIS, "chkComissaoChanged")
        BINDEVENT(loc_oPagina.chk_4c_eCommerce, "InteractiveChange", THIS, "chkeCommerceChanged")

        *-- Sub-pageframe para produtos e grupos de venda
        *-- Legado: pgGrades Top=181 -> compensado +29 = 210 (em Page2 do pgf_4c_Paginas com Top=-29)
        loc_oPagina.AddObject("pgf_4c_Grades", "PageFrame")
        WITH loc_oPagina.pgf_4c_Grades
            .Top       = 210
            .Left      = 23
            .Width     = 762
            .Height    = 396
            .PageCount = 2
            .Tabs      = .T.
            .TabStop   = .F.
            .Page1.Caption = "Produtos"
            .Page2.Caption = "Grupos de Venda"
        ENDWITH

        THIS.ConfigurarGradeProdutos(loc_oPagina.pgf_4c_Grades.Page1)
        THIS.ConfigurarGradeGrupos(loc_oPagina.pgf_4c_Grades.Page2)

        BINDEVENT(loc_oPagina.pgf_4c_Grades.Page2, "Activate", THIS, "GradesActivate")

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Imagem inicialmente invisivel (mostra somente quando produto tem foto)
        loc_oPagina.pgf_4c_Grades.Page1.img_4c_ImgProd.Visible = .F.
    ENDPROC

    *====================================================================
    * CarregarLista - Carrega lista de promocoes no grid da Page1
    *====================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), Promos C(25), Cods C(3), ;
                    Comiss N(5,2), Incentivs N(1,0), eCommerce N(1,0), LPrecos C(30))
            ENDIF
            loc_lSucesso = .T.
        ELSE
            TRY
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lSucesso = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Promos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Cods"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Comiss"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.eCommerce"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.LPrecos"
                    *-- Redefinir Headers APOS RecordSource (obrigatorio - RecordSource os reseta)
                    loc_oGrid.Column1.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column3.Header1.Caption = "Comiss%"
                    loc_oGrid.Column4.Header1.Caption = "e-Com."
                    loc_oGrid.Column5.Header1.Caption = "Lista Pre" + CHR(231) + "os"
                    loc_oGrid.Column3.Alignment = 1
                    loc_oGrid.Column4.Alignment = 1
                    THIS.FormatarGridLista(loc_oGrid)
                    IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                        GO TOP IN cursor_4c_Dados
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loException
                MostrarErro(loException, "FormPrm.CarregarLista")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Destroy - Libera recursos do formulario
    *====================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("csSigPrPmi")
                USE IN csSigPrPmi
            ENDIF
            IF USED("TcrSigPrPmi")
                USE IN TcrSigPrPmi
            ENDIF
            IF USED("csSigPrPmv")
                USE IN csSigPrPmv
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao fechar: " + loException.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *====================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *====================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lOcultar

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_lOcultar = INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")

                IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND !loc_lOcultar
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF !loc_lOcultar
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

    *====================================================================
    * FormatarGridLista - Formata visual do grid principal (Page1)
    *====================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *====================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *====================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormPrm.AlternarPagina")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BtnIncluirClick - Inicia inclusao de nova promocao (PUBLIC)
    *====================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FormPrm.BtnIncluirClick")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BtnVisualizarClick - Visualiza promocao selecionada em modo leitura (PUBLIC)
    *====================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidChaves
        loc_cCidChaves = ""
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF
        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *====================================================================
    * BtnAlterarClick - Inicia alteracao da promocao selecionada (PUBLIC)
    *====================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidChaves
        loc_cCidChaves = ""
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF
        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *====================================================================
    * BtnExcluirClick - Exclui promocao selecionada apos confirmacao (PUBLIC)
    *====================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidChaves, loc_lConfirma
        loc_cCidChaves = ""
        loc_lConfirma  = .F.
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF
        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
            RETURN
        ENDIF
        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o desta promo" + ;
            CHR(231) + CHR(227) + "o?", "Confirmar Exclus" + CHR(227) + "o")
        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Promo" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + ;
                        "da com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * BtnBuscarClick - Recarrega lista (filtro avancado na Fase 5) (PUBLIC)
    *====================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *====================================================================
    * BtnEncerrarClick - Fecha o formulario (PUBLIC)
    *====================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnSalvarClick - Salva promocao (cabecalho + itens + grupos) (PUBLIC)
    *====================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oPg2
        loc_lSucesso = .F.
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes obrigatorias ANTES do TRY
        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Promos.Value))
            MsgAviso("Promo" + CHR(231) + CHR(227) + "o inv" + CHR(225) + ;
                     "lida!!!", "Campo n" + CHR(227) + "o preenchido")
            loc_oPg2.txt_4c_Promos.SetFocus
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_cModoAtual == "INCLUIR"
                IF THIS.this_oBusinessObject.VerificarPromoExiste( ;
                        THIS.this_oBusinessObject.this_cPromos, ;
                        THIS.this_oBusinessObject.this_cCods)
                    MsgAviso("Promo" + CHR(231) + CHR(227) + "o J" + ;
                             CHR(225) + " Cadastrada!!!", "")
                    loc_oPg2.txt_4c_Promos.SetFocus
                ELSE
                    IF THIS.this_oBusinessObject.Salvar()
                        THIS.this_oBusinessObject.SalvarItens( ;
                            ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
                        THIS.this_oBusinessObject.SalvarGrupos( ;
                            ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
                        MsgInfo("Promo" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ELSE
                IF THIS.this_oBusinessObject.Salvar()
                    THIS.this_oBusinessObject.SalvarItens( ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
                    THIS.this_oBusinessObject.SalvarGrupos( ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
                    MsgInfo("Promo" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormPrm.BtnSalvarClick")
        ENDTRY

        IF loc_lSucesso
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista (PUBLIC)
    *====================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *====================================================================
    * FormParaBO - Transfere valores dos campos do Form para o BO
    *====================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cPromos    = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
        THIS.this_oBusinessObject.this_cCods      = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_nIncentivs = IIF(loc_oPg2.chk_4c_Comissao.Value, 1, 0)
        THIS.this_oBusinessObject.this_nComiss    = loc_oPg2.txt_4c_Comiss.Value
        THIS.this_oBusinessObject.this_nECommerce = IIF(loc_oPg2.chk_4c_eCommerce.Value, 1, 0)
        THIS.this_oBusinessObject.this_cLPrecos   = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
    ENDPROC

    *====================================================================
    * BOParaForm - Transfere valores do BO para os campos do Form
    *====================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cPromos
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cPromos = ALLTRIM(THIS.this_oBusinessObject.this_cPromos)

        loc_oPg2.txt_4c_Promos.Value    = loc_cPromos
        loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
        loc_oPg2.chk_4c_Comissao.Value  = IIF(THIS.this_oBusinessObject.this_nIncentivs = 1, 1, 0)
        loc_oPg2.txt_4c_Comiss.Value    = THIS.this_oBusinessObject.this_nComiss
        loc_oPg2.chk_4c_eCommerce.Value = IIF(THIS.this_oBusinessObject.this_nECommerce = 1, 1, 0)
        loc_oPg2.txt_4c_LPrecos.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLPrecos)

        *-- Habilitar dependencias visuais conforme checkboxes
        loc_oPg2.txt_4c_Comiss.Enabled  = (THIS.this_oBusinessObject.this_nIncentivs = 1)
        loc_oPg2.txt_4c_LPrecos.Enabled = (THIS.this_oBusinessObject.this_nECommerce = 1)

        *-- Carregar itens e grupos nos cursores e atualizar grids
        IF !EMPTY(loc_cPromos)
            THIS.this_oBusinessObject.BuscarItens(loc_cPromos)
            THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
        ENDIF
        TRY
            loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
            loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
        CATCH TO loException
            MostrarErro(loException, "FormPrm.BOParaForm")
        ENDTRY
    ENDPROC

    *====================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    *====================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Promos e Codigo: editaveis somente em INCLUIR
        loc_oPg2.txt_4c_Promos.Enabled = par_lHabilitar AND ;
                                          (THIS.this_cModoAtual == "INCLUIR")
        loc_oPg2.txt_4c_Codigo.Enabled = par_lHabilitar AND ;
                                          (THIS.this_cModoAtual == "INCLUIR")

        *-- Checkboxes: editaveis em INCLUIR/ALTERAR
        loc_oPg2.chk_4c_Comissao.Enabled  = par_lHabilitar
        loc_oPg2.chk_4c_eCommerce.Enabled = par_lHabilitar AND !(THIS.this_cTipo == "E")

        *-- Campos vinculados ao checkbox
        loc_oPg2.txt_4c_Comiss.Enabled = par_lHabilitar AND ;
                                          (loc_oPg2.chk_4c_Comissao.Value = 1)
        loc_oPg2.txt_4c_LPrecos.Enabled = par_lHabilitar AND ;
                                           (loc_oPg2.chk_4c_eCommerce.Value = 1)

        *-- Botoes de acao
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.

        *-- Grids de edicao: ReadOnly em VISUALIZAR, editaveis em INCLUIR/ALTERAR
        IF PEMSTATUS(loc_oPg2, "pgf_4c_Grades", 5)
            loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.ReadOnly   = !par_lHabilitar
            loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.ReadOnly     = !par_lHabilitar
            loc_oPg2.pgf_4c_Grades.Page1.cmd_4c_ApagarItem.Enabled  = par_lHabilitar
            loc_oPg2.pgf_4c_Grades.Page2.cmd_4c_ApagarGrupo.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *====================================================================
    * LimparCampos - Limpa valores de todos os campos da Page2
    *====================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Promos.Value    = ""
        loc_oPg2.txt_4c_Codigo.Value    = ""
        loc_oPg2.chk_4c_Comissao.Value  = 0
        loc_oPg2.txt_4c_Comiss.Value    = 0
        loc_oPg2.txt_4c_Comiss.Enabled  = .F.
        loc_oPg2.chk_4c_eCommerce.Value = 0
        loc_oPg2.txt_4c_LPrecos.Value   = ""
        loc_oPg2.txt_4c_LPrecos.Enabled = .F.

        *-- Recriar cursores de edicao vazios (com linha em branco para o grid)
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Itens ;
            (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
             Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
             PromoPro C(35), Vendavels N(1,0) NULL)
        SET NULL OFF
        INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)

        SET NULL ON
        CREATE CURSOR cursor_4c_Grupos ;
            (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
        SET NULL OFF
        INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())

        *-- Reatribuir RecordSource e ControlSources apos recriar cursores (AUTOBIND VFP9)
        TRY
            LOCAL loc_oGridProd, loc_oGridGrp
            loc_oGridProd = loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos
            loc_oGridProd.ColumnCount = 6
            loc_oGridProd.RecordSource              = "cursor_4c_Itens"
            loc_oGridProd.Column1.ControlSource     = "cursor_4c_Itens.CPros"
            loc_oGridProd.Column2.ControlSource     = "cursor_4c_Itens.DPros"
            loc_oGridProd.Column3.ControlSource     = "cursor_4c_Itens.Pecas"
            loc_oGridProd.Column4.ControlSource     = "cursor_4c_Itens.CBars"
            loc_oGridProd.Column5.ControlSource     = "cursor_4c_Itens.Datas"
            loc_oGridProd.Column6.ControlSource     = "cursor_4c_Itens.Vendavels"
            loc_oGridProd.Refresh

            loc_oGridGrp = loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos
            loc_oGridGrp.ColumnCount = 2
            loc_oGridGrp.RecordSource           = "cursor_4c_Grupos"
            loc_oGridGrp.Column1.ControlSource  = "cursor_4c_Grupos.Colecoes"
            loc_oGridGrp.Column2.ControlSource  = "cursor_4c_Grupos.Datas"
            loc_oGridGrp.Refresh
        CATCH TO loException
            MostrarErro(loException, "FormPrm.LimparCampos")
        ENDTRY
    ENDPROC

    *====================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *====================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        DO CASE
        CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        OTHERWISE
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDCASE
    ENDPROC

    *====================================================================
    * ValidarPromos - Valida campo promocao ao perder foco (PUBLIC - BINDEVENT)
    * Em modo INCLUIR: verifica unicidade e pre-carrega grupos do banco
    *====================================================================
    PROCEDURE ValidarPromos(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cPromos
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)

        IF EMPTY(loc_cPromos) OR !INLIST(THIS.this_cModoAtual, "INCLUIR")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.VerificarPromoExiste(loc_cPromos, ;
                ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
            MsgAviso("Promo" + CHR(231) + CHR(227) + "o J" + ;
                     CHR(225) + " Cadastrada!!!", "")
            loc_oPg2.txt_4c_Promos.Value = ""
            loc_oPg2.txt_4c_Promos.SetFocus
            RETURN
        ENDIF

        *-- Pre-carregar grupos de venda existentes para esta promocao (se houver)
        THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
        CATCH TO loException
            MostrarErro(loException, "FormPrm.ValidarPromos")
        ENDTRY
    ENDPROC

    *====================================================================
    * ValidarLPrecos - Valida campo lista de precos ao perder foco (PUBLIC - BINDEVENT)
    * Substitui fwBuscaExt para SigCdLpc
    *====================================================================
    PROCEDURE ValidarLPrecos(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cLPrecos, loc_oBusca
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_cLPrecos = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)

        IF EMPTY(loc_cLPrecos)
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF
            THIS.this_oBusinessObject.BuscarListaPrecos(loc_cLPrecos)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaLpc"
                loc_oBusca.DefinirCursor("cursor_4c_BuscaLpc", "LPrecos", "LPrecos", ;
                    "Lista de Pre" + CHR(231) + "os")
                IF loc_oBusca.Mostrar()
                    loc_oPg2.txt_4c_LPrecos.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ELSE
                    loc_oPg2.txt_4c_LPrecos.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormPrm.ValidarLPrecos")
            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF
        ENDTRY
    ENDPROC

    *====================================================================
    * chkComissaoChanged - Habilita/desabilita txt_4c_Comiss (PUBLIC - BINDEVENT)
    *====================================================================
    PROCEDURE chkComissaoChanged()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF loc_oPg2.chk_4c_Comissao.Value = 0
            loc_oPg2.txt_4c_Comiss.Value   = 0
            loc_oPg2.txt_4c_Comiss.Enabled = .F.
        ELSE
            loc_oPg2.txt_4c_Comiss.Enabled = .T.
        ENDIF
        loc_oPg2.txt_4c_Comiss.Refresh
    ENDPROC

    *====================================================================
    * chkeCommerceChanged - Habilita/desabilita txt_4c_LPrecos (PUBLIC - BINDEVENT)
    *====================================================================
    PROCEDURE chkeCommerceChanged()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF loc_oPg2.chk_4c_eCommerce.Value = 0
            loc_oPg2.txt_4c_LPrecos.Value   = ""
            loc_oPg2.txt_4c_LPrecos.Enabled = .F.
        ELSE
            loc_oPg2.txt_4c_LPrecos.Enabled = .T.
        ENDIF
        loc_oPg2.txt_4c_LPrecos.Refresh
    ENDPROC

    *====================================================================
    * ConfigurarGradeProdutos - Configura grd_4c_Produtos na aba Produtos
    * Legado: grd_produtos Top=3,Left=8,W=742,H=220, 6 colunas
    *====================================================================
    PROTECTED PROCEDURE ConfigurarGradeProdutos(par_oPgProdutos)
        LOCAL loc_oGrid

        par_oPgProdutos.AddObject("grd_4c_Produtos", "Grid")
        loc_oGrid = par_oPgProdutos.grd_4c_Produtos
        WITH loc_oGrid
            .Top             = 3
            .Left            = 8
            .Width           = 742
            .Height          = 220
            .ColumnCount     = 6
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .GridLineColor   = RGB(238, 238, 238)
            .GridLines       = 3
            .HighlightStyle  = 2
            .DeleteMark      = .F.
            .RecordMark      = .F.
            .RowHeight       = 18
            .ScrollBars      = 3
            .ReadOnly        = .F.
        ENDWITH

        *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
        loc_oGrid.ColumnCount = 6
        loc_oGrid.RecordSource = "cursor_4c_Itens"

        *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
        WITH loc_oGrid.Column1
            .ControlSource   = "cursor_4c_Itens.CPros"
            .Width           = 100
            .Sparse          = .F.
            .Header1.Caption = ""
        ENDWITH
        BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")

        WITH loc_oGrid.Column2
            .ControlSource   = "cursor_4c_Itens.DPros"
            .Width           = 200
            .ReadOnly        = .T.
            .Sparse          = .F.
            .Header1.Caption = ""
        ENDWITH

        WITH loc_oGrid.Column3
            .ControlSource   = "cursor_4c_Itens.Pecas"
            .Width           = 70
            .Sparse          = .F.
            .Header1.Caption = ""
        ENDWITH

        WITH loc_oGrid.Column4
            .ControlSource   = "cursor_4c_Itens.CBars"
            .Width           = 80
            .Sparse          = .F.
            .ReadOnly        = .T.
            .Header1.Caption = "C" + CHR(243) + "d. Barra"
        ENDWITH

        WITH loc_oGrid.Column5
            .ControlSource   = "cursor_4c_Itens.Datas"
            .Width           = 80
            .Sparse          = .F.
            .Header1.Caption = "Data Inicial"
        ENDWITH
        BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")

        *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
        WITH loc_oGrid.Column6
            .ControlSource   = "cursor_4c_Itens.Vendavels"
            .Width           = 35
            .Sparse          = .F.
            .Header1.Caption = "V"
            .AddObject("chk_4c_Vendavel", "CheckBox")
            WITH .chk_4c_Vendavel
                .Caption       = ""
                .Alignment     = 0
                .ReadOnly      = .F.
                .Visible       = .T.
                .Top           = 9
                .Left          = 2
                .Height        = 17
                .Width         = 22
            ENDWITH
            .CurrentControl  = "chk_4c_Vendavel"
        ENDWITH
        BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")
        BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "KeyPress", THIS, "GridProdutosKeyPress")

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridProdutosAfterRowColChange")

        *-- Label "Busca :" (legado: Say2 Top=276,Left=299)
        par_oPgProdutos.AddObject("lbl_4c_Busca", "Label")
        WITH par_oPgProdutos.lbl_4c_Busca
            .Caption   = "Busca :"
            .Top       = 276
            .Left      = 299
            .Width     = 37
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox busca rapida (legado: getBusca Top=273,Left=344,W=108)
        par_oPgProdutos.AddObject("txt_4c_Busca", "TextBox")
        WITH par_oPgProdutos.txt_4c_Busca
            .Value     = ""
            .Top       = 273
            .Left      = 344
            .Width     = 108
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 14
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPgProdutos.txt_4c_Busca, "LostFocus",     THIS, "BuscaItemValid")
        BINDEVENT(par_oPgProdutos.txt_4c_Busca, "KeyPress", THIS, "BuscaItemLostFocus")

        *-- Botao Apagar Item (legado: cmdApagar Top=252,Left=551,W=50,H=50)
        par_oPgProdutos.AddObject("cmd_4c_ApagarItem", "CommandButton")
        WITH par_oPgProdutos.cmd_4c_ApagarItem
            .Caption      = "Apagar"
            .Top          = 252
            .Left         = 551
            .Width        = 50
            .Height       = 50
            .FontName     = "Tahoma"
            .FontSize     = 8
            .MousePointer = 15
            .Visible      = .T.
        ENDWITH
        BINDEVENT(par_oPgProdutos.cmd_4c_ApagarItem, "Click", THIS, "BtnApagarItemClick")

        *-- Imagem produto (legado: ImgProd Top=228,Left=59,W=175,H=104)
        par_oPgProdutos.AddObject("img_4c_ImgProd", "Image")
        WITH par_oPgProdutos.img_4c_ImgProd
            .Top     = 228
            .Left    = 59
            .Width   = 175
            .Height  = 104
            .Stretch = 2
            .Visible = .F.
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarGradeGrupos - Configura grd_4c_Grupos na aba Grupos de Venda
    * Legado: grdColecoes Top=24,Left=256,W=192,H=324, 2 colunas
    *====================================================================
    PROTECTED PROCEDURE ConfigurarGradeGrupos(par_oPgGrupos)
        LOCAL loc_oGrid

        par_oPgGrupos.AddObject("grd_4c_Grupos", "Grid")
        loc_oGrid = par_oPgGrupos.grd_4c_Grupos
        WITH loc_oGrid
            .Top             = 24
            .Left            = 256
            .Width           = 192
            .Height          = 324
            .ColumnCount     = 2
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .GridLineColor   = RGB(238, 238, 238)
            .GridLines       = 3
            .HighlightStyle  = 2
            .DeleteMark      = .F.
            .RecordMark      = .F.
            .RowHeight       = 18
            .ScrollBars      = 3
            .ReadOnly        = .F.
        ENDWITH

        *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
        loc_oGrid.ColumnCount = 2
        loc_oGrid.RecordSource = "cursor_4c_Grupos"

        *-- ControlSources e Headers APOS RecordSource
        WITH loc_oGrid.Column1
            .ControlSource   = "cursor_4c_Grupos.Colecoes"
            .Width           = 80
            .Sparse          = .F.
            .Header1.Caption = "Grp. Venda"
        ENDWITH
        BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")

        WITH loc_oGrid.Column2
            .ControlSource   = "cursor_4c_Grupos.Datas"
            .Width           = 80
            .Sparse          = .F.
            .Header1.Caption = "Data Inicial"
        ENDWITH
        BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")

        *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
        par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
        WITH par_oPgGrupos.cmd_4c_ApagarGrupo
            .Caption      = "Apagar"
            .Top          = 161
            .Left         = 451
            .Width        = 50
            .Height       = 50
            .FontName     = "Tahoma"
            .FontSize     = 8
            .MousePointer = 15
            .Visible      = .T.
        ENDWITH
        BINDEVENT(par_oPgGrupos.cmd_4c_ApagarGrupo, "Click", THIS, "BtnApagarGrupoClick")
    ENDPROC

    *====================================================================
    * GridProdutosAfterRowColChange - Carrega imagem do produto ao mudar linha
    * Legado: grd_produtos.AfterRowColChange - SQLEXEC FigJpgs FROM SigCdPro
    *====================================================================
    PROCEDURE GridProdutosAfterRowColChange(par_nColIndex)
        LOCAL loc_cCpros, loc_nResult, loc_cArqTemp, loc_oPgP
        loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1

        *-- Sem conexao valida (modo teste / gnConnHandle=0): nao tentar SQL
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            loc_oPgP.img_4c_ImgProd.Visible = .F.
            RETURN
        ENDIF

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            loc_oPgP.img_4c_ImgProd.Visible = .F.
            RETURN
        ENDIF

        loc_cCpros   = ALLTRIM(cursor_4c_Itens.CPros)
        loc_cArqTemp = SYS(2023) + "4c_imgprod.jpg"

        IF EMPTY(loc_cCpros)
            loc_oPgP.img_4c_ImgProd.Visible = .F.
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_FigJpg")
                USE IN cursor_4c_FigJpg
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(loc_cCpros), "cursor_4c_FigJpg")
            IF loc_nResult > 0 AND USED("cursor_4c_FigJpg") AND ;
                    !EOF("cursor_4c_FigJpg") AND ;
                    !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
                    LEN(cursor_4c_FigJpg.FigJpgs) > 0
                STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp)
                loc_oPgP.img_4c_ImgProd.Picture = loc_cArqTemp
                loc_oPgP.img_4c_ImgProd.Visible = .T.
            ELSE
                loc_oPgP.img_4c_ImgProd.Visible = .F.
            ENDIF
            IF USED("cursor_4c_FigJpg")
                USE IN cursor_4c_FigJpg
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormPrm.GridProdutosAfterRowColChange")
            loc_oPgP.img_4c_ImgProd.Visible = .F.
        ENDTRY
    ENDPROC

    *====================================================================
    * ValidarProdutoCodigo - Valida CPros na Column1 do grd_4c_Produtos
    * Legado: txt_cpros.Valid - busca SigCdPro + deteccao de codigo de barras (SigOpEtq)
    * Usa BuscarProdutoPorCodigo do BO que trata barcode automaticamente
    *====================================================================
    PROCEDURE ValidarProdutoCodigo()
        LOCAL loc_cCpros, loc_oBusca

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            RETURN .T.
        ENDIF

        loc_cCpros = ALLTRIM(cursor_4c_Itens.CPros)

        IF EMPTY(loc_cCpros)
            REPLACE cursor_4c_Itens.DPros WITH ""
            REPLACE cursor_4c_Itens.CBars WITH 0
            RETURN .T.
        ENDIF

        TRY
            *-- BO detecta automaticamente se e codigo de barras (SigOpEtq) ou codigo de produto (SigCdPro)
            IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCpros)
                IF USED("cursor_4c_BuscaProd") AND !EOF("cursor_4c_BuscaProd")
                    SELECT cursor_4c_BuscaProd
                    REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(cursor_4c_BuscaProd.cPros)
                    REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(cursor_4c_BuscaProd.dPros)
                ENDIF
                IF USED("cursor_4c_BuscaProd")
                    USE IN cursor_4c_BuscaProd
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaProd")
                    USE IN cursor_4c_BuscaProd
                ENDIF
                *-- Nao encontrado: abrir picker (Pattern A canonico)
                THIS.this_oBusinessObject.BuscarProdutoParaLookup(loc_cCpros)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProd"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cPros", "dPros", ;
                        "Selecionar Produto")
                    IF loc_oBusca.Mostrar()
                        REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
                        REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ELSE
                        REPLACE cursor_4c_Itens.CPros WITH ""
                        REPLACE cursor_4c_Itens.DPros WITH ""
                        REPLACE cursor_4c_Itens.CBars WITH 0
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaProd")
                    USE IN cursor_4c_BuscaProd
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormPrm.ValidarProdutoCodigo")
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF
        ENDTRY

        THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
        RETURN .T.
    ENDPROC

    *====================================================================
    * GridProdutosDatasValid - Column5 Valid: adiciona linha na ultima posicao
    * Legado: Column5.Text1.Valid - insere blank se ultima linha e CPros preenchido
    *====================================================================
    PROCEDURE GridProdutosDatasValid()
        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            RETURN .T.
        ENDIF

        IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
                !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
            TRY
                INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
                GO BOTTOM IN cursor_4c_Itens
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
            CATCH TO loException
                MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
            ENDTRY
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
    * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
    *====================================================================
    PROCEDURE GridCheckVendavelClick()
        LOCAL loc_oChk
        TRY
            IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
                loc_oChk = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1 ;
                    .grd_4c_Produtos.Column6.chk_4c_Vendavel
                IF VARTYPE(loc_oChk) = "O"
                    REPLACE cursor_4c_Itens.Vendavels WITH IIF(loc_oChk.Value = 1, 1, 0)
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormPrm.GridCheckVendavelClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * GridProdutosKeyPress - KeyPress no CheckBox Vendavel (Column6)
    * Legado: TAB=Salva.SetFocus, SHIFT+TAB=Get_Promos.SetFocus
    *====================================================================
    PROCEDURE GridProdutosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF par_nKeyCode = 9
            IF BITAND(par_nShiftAltCtrl, 1) = 1
                *-- SHIFT+TAB: voltar para campo Promocao
                loc_oPg2.txt_4c_Promos.SetFocus
            ELSE
                *-- TAB: ir para botao Confirmar
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * BuscaItemValid - Valid do txt_4c_Busca: navega no grid de produtos
    * Legado: getBusca.Valid - SEEK by CPros in csSigPrPmi
    *====================================================================
    PROCEDURE BuscaItemValid()
        LOCAL loc_oPgP, loc_cBusca
        loc_oPgP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
        loc_cBusca = ALLTRIM(loc_oPgP.txt_4c_Busca.Value)

        IF EMPTY(loc_cBusca) OR !USED("cursor_4c_Itens")
            RETURN .T.
        ENDIF

        SELECT cursor_4c_Itens
        LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca

        IF FOUND()
            loc_oPgP.grd_4c_Produtos.Refresh
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
    * Legado: getBusca.LostFocus - focus col_CPros
    *====================================================================
    PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPgP
        loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1

        IF PEMSTATUS(loc_oPgP, "grd_4c_Produtos", 5)
            loc_oPgP.grd_4c_Produtos.SetFocus
            loc_oPgP.grd_4c_Produtos.ActiveColumn = 1
            loc_oPgP.grd_4c_Produtos.Refresh
        ENDIF
    ENDPROC

    *====================================================================
    * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
    * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
    *====================================================================
    PROCEDURE BtnApagarItemClick()
        LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
        loc_lAbortou = .F.

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
            RETURN
        ENDIF

        loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)

        TRY
            *-- Excluir do banco se registro ja persistido e conexao valida
            IF !EMPTY(loc_cIdChaves) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir item da promo" + CHR(231) + CHR(227) + "o.", "Erro")
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortou
                SELECT cursor_4c_Itens
                DELETE
                PACK
                IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
                    INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
                ENDIF
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormPrm.BtnApagarItemClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
    * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
    *====================================================================
    PROCEDURE ValidarColecao()
        LOCAL loc_cColecoes, loc_nResult, loc_oBusca

        IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
            RETURN .T.
        ENDIF

        loc_cColecoes = ALLTRIM(cursor_4c_Grupos.Colecoes)

        IF EMPTY(loc_cColecoes)
            RETURN .T.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 colecoes, descs FROM SigCdCol WHERE colecoes = " + ;
                EscaparSQL(loc_cColecoes), "cursor_4c_BuscaCol")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaCol") AND !EOF("cursor_4c_BuscaCol")
                *-- Encontrado: manter valor atual
            ELSE
                *-- Nao encontrado: abrir picker (Pattern A canonico)
                IF USED("cursor_4c_BuscaCol")
                    USE IN cursor_4c_BuscaCol
                ENDIF
                THIS.this_oBusinessObject.BuscarColecaoParaLookup(loc_cColecoes)

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCol"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "colecoes", "descs", ;
                        "Selecionar Grupo de Venda")
                    IF loc_oBusca.Mostrar()
                        REPLACE cursor_4c_Grupos.Colecoes WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ELSE
                        REPLACE cursor_4c_Grupos.Colecoes WITH ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaCol")
                    USE IN cursor_4c_BuscaCol
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormPrm.ValidarColecao")
        ENDTRY

        THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
        RETURN .T.
    ENDPROC

    *====================================================================
    * ValidarDataGrupo - Column2 Valid: adiciona linha na ultima posicao
    * Legado: Column2.Text1.Valid - insere blank se ultima linha e Colecoes preenchido
    *====================================================================
    PROCEDURE ValidarDataGrupo()
        IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
            RETURN .T.
        ENDIF

        IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
                !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
            TRY
                INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
                GO BOTTOM IN cursor_4c_Grupos
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
            CATCH TO loException
                MostrarErro(loException, "FormPrm.ValidarDataGrupo")
            ENDTRY
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
    * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
    *====================================================================
    PROCEDURE BtnApagarGrupoClick()
        LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
        loc_lAbortou = .F.

        IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
            RETURN
        ENDIF

        loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)

        TRY
            *-- Excluir do banco se registro ja persistido e conexao valida
            IF !EMPTY(loc_cIdChaves) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir grupo de venda.", "Erro")
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortou
                SELECT cursor_4c_Grupos
                DELETE
                PACK
                IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
                    INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
                ENDIF
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
    * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
    *====================================================================
    PROCEDURE GradesActivate()
        LOCAL loc_cPromos, loc_oPg2
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Grupos")
            RETURN
        ENDIF

        TRY
            GO BOTTOM IN cursor_4c_Grupos
            IF EOF("cursor_4c_Grupos") OR ;
                    !EMPTY(ALLTRIM(NVL(cursor_4c_Grupos.Colecoes, "")))
                DELETE FROM cursor_4c_Grupos WHERE EMPTY(NVL(Colecoes, ""))
                INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
                    VALUES (loc_cPromos, DATETIME())
            ENDIF
            loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
        CATCH TO loException
            MostrarErro(loException, "FormPrm.GradesActivate")
        ENDTRY
    ENDPROC

ENDDEFINE
