*==============================================================================
* FormEmn.prg - Formulario de Estoque Alvo (Minimo por Produto/Empresa)
* Legado: SIGCDEMN (frmcadastro)
* Herda de: FormBase
*==============================================================================

DEFINE CLASS FormEmn AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX Fidelity)
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 1000
    Caption     = "Estoque Alvo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *--------------------------------------------------------------------------
    * Propriedades do formulario
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"    && LISTA / INCLUIR / ALTERAR / VISUALIZAR

    *-- Modo externo: form chamado com produto fixado por outro form
    this_cProdutoExterno = ""         && Codigo do produto externo (se aplicavel)
    this_lProdutoFixo    = .F.        && .T. quando produto foi fixado externamente
    this_cEscolha        = ""         && INSERIR / ALTERAR / PROCURAR / VISUALIZAR (legado)

    *-- Guarda de reentrancia dos pickers da grade: o dialogo eh MODAL, tira o
    *-- foco e redispara Valid/LostFocus da propria celula (regra #37/#47)
    this_lEmLookupGrade  = .F.

    *-- Idem para os campos Produto/Descricao do cabecalho da Page2
    this_lEmLookupProduto = .F.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("EmnBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ELSE
                MsgErro("Falha ao criar EmnBO.", "FormEmn.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPg1, loc_oPg2

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .Visible    = .T.

            .Page1.BackColor = RGB(100, 100, 100)
            .Page2.BackColor = RGB(100, 100, 100)
        ENDWITH

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Imagem de fundo (legado: new_background.jpg)
        loc_oPg1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        loc_oPg2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.ConfigurarPaginaLista(loc_oPg1)
        THIS.ConfigurarPaginaDados(loc_oPg2)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria containers base na Page1 (Lista)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista(par_oPagina)

        *-- Cabecalho escuro com titulo (cntSombra legado)
        *-- Compensacao PageFrame: cntSombra.Top=1 + 29 = 30
        par_oPagina.AddObject("cnt_4c_Sombra", "Container")
        WITH par_oPagina.cnt_4c_Sombra
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 12
            .Height    = 40
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 12
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op legado)
        *-- Grupo_op.Top=-1 + 29 = 28, Left=544
        par_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH par_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Inserir legado: Top=5, Left=5)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
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
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Consultar legado: Top=5, Left=80)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
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
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Top=5, Left=155)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
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
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Top=5, Left=230)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
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
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Procurar legado: Top=5, Left=305)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
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
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida - padrao canonico (Grupo_Saida legado)
        par_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH par_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
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

        BINDEVENT(par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid da lista (Pagina.Lista.Grade legado: Top=121, Left=12, Width=939, Height=470)
        *-- Compensacao PageFrame: Top=121 + 29 = 150
        par_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH par_oPagina.grd_4c_Lista
            .Top               = 150
            .Left              = 12
            .Width             = 939
            .Height            = 470
            .FontName          = "Verdana"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .GridLines         = 3
            .RowHeight         = 16
            .HeaderHeight      = 20
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .HighlightStyle    = 2
            .HighlightBackColor = RGB(15, 41, 104)
            .HighlightForeColor = RGB(255, 255, 255)
            .ReadOnly          = .T.
            .AllowCellSelection = .F.
            .AllowHeaderSizing = .F.
            .ColumnCount       = 5
            .Visible           = .T.
        ENDWITH

        BINDEVENT(par_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnAlterarClick")

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega registros na grid da Page1 (cursor CrProdutos)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Lista")
                    USE IN cursor_4c_Lista
                ENDIF
                CREATE CURSOR cursor_4c_Lista (cpros C(14), dpros C(65), ifors C(10), reffs C(20), sgrus C(3))
                INSERT INTO cursor_4c_Lista VALUES ("", "", "", "", "")
                GO TOP IN cursor_4c_Lista
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                    MsgErro("Business Object nao inicializado.", "FormEmn.CarregarLista")
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    IF !THIS.this_oBusinessObject.Buscar("")
                        loc_lResultado = .F.
                    ELSE
                        *-- Bind no funil unico (reproduz o pColuna do Init legado)
                        THIS.VincularColunasLista(loc_oGrid)

                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            *-- FUNIL (regra #40): quem muda de modo tem de reavaliar os botoes
            *-- aqui, nao so no botao que entra. Sem isto o cmd_4c_BtnExcluir
            *-- fica com o Enabled da vez anterior - entrava em ALTERAR, voltava,
            *-- abria em VISUALIZAR e o botao continuava habilitado.
            THIS.AjustarBotoesPorModo()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.NovoRegistro()
            ENDIF

            THIS.this_cEscolha   = "INSERIR"
            THIS.this_cModoAtual = "INCLUIR"

            IF PEMSTATUS(THIS, "LimparCampos", 5)
                THIS.LimparCampos()
            ENDIF
            IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                THIS.HabilitarCampos(.T.)
            ENDIF

            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCPros, loc_lProsseguir
        loc_cCPros      = ""
        loc_lProsseguir = .T.

        TRY
            IF !USED("CrProdutos") OR EOF("CrProdutos")
                MsgAviso("Nenhum registro selecionado.", "Visualizar")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT CrProdutos
                loc_cCPros = ALLTRIM(CrProdutos.cpros)
                IF EMPTY(loc_cCPros)
                    MsgAviso("Produto inv" + CHR(225) + "lido.", "Visualizar")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
                MsgErro("Falha ao carregar produto " + loc_cCPros, "Visualizar")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                THIS.this_cEscolha   = "PROCURAR"
                THIS.this_cModoAtual = "VISUALIZAR"

                IF PEMSTATUS(THIS, "BOParaForm", 5)
                    THIS.BOParaForm()
                ENDIF
                IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                    THIS.HabilitarCampos(.F.)
                ENDIF

                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Altera registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCPros, loc_lProsseguir
        loc_cCPros      = ""
        loc_lProsseguir = .T.

        TRY
            IF !USED("CrProdutos") OR EOF("CrProdutos")
                MsgAviso("Nenhum registro selecionado.", "Alterar")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT CrProdutos
                loc_cCPros = ALLTRIM(CrProdutos.cpros)
                IF EMPTY(loc_cCPros)
                    MsgAviso("Produto inv" + CHR(225) + "lido.", "Alterar")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
                MsgErro("Falha ao carregar produto " + loc_cCPros, "Alterar")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cEscolha   = "ALTERAR"
                THIS.this_cModoAtual = "ALTERAR"

                IF PEMSTATUS(THIS, "BOParaForm", 5)
                    THIS.BOParaForm()
                ENDIF
                IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                    THIS.HabilitarCampos(.T.)
                ENDIF

                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCPros, loc_lConfirma, loc_lProsseguir
        loc_cCPros      = ""
        loc_lConfirma   = .F.
        loc_lProsseguir = .T.

        TRY
            IF !USED("CrProdutos") OR EOF("CrProdutos")
                MsgAviso("Nenhum registro selecionado.", "Excluir")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT CrProdutos
                loc_cCPros = ALLTRIM(CrProdutos.cpros)
                IF EMPTY(loc_cCPros)
                    MsgAviso("Produto inv" + CHR(225) + "lido.", "Excluir")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto " + loc_cCPros + " ?", "Excluir")
                IF !loc_lConfirma
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
                MsgErro("Falha ao carregar produto " + loc_cCPros, "Excluir")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar produto
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCPros, loc_lProsseguir4c
        loc_cCPros = ""

        loc_lProsseguir4c = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProd", "cpros", "", ;
                "Buscar Produto")

            IF VARTYPE(loc_oBusca) <> "O"
                loc_lProsseguir4c = .F.
            ENDIF

            IF loc_lProsseguir4c
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                    loc_cCPros = ALLTRIM(cursor_4c_BuscaProd.cpros)
                ENDIF

                IF USED("cursor_4c_BuscaProd")
                    USE IN cursor_4c_BuscaProd
                ENDIF

                loc_oBusca.Release()

                IF !EMPTY(loc_cCPros)
                    *-- Recarrega lista filtrando pelo produto selecionado
                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        IF THIS.this_oBusinessObject.Buscar(loc_cCPros)
                            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria containers e campos na Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPagina)

        *-- Cabecalho escuro com titulo (padrao nova arquitetura em Page2)
        *-- Top = 1 + 29 = 30
        par_oPagina.AddObject("cnt_4c_Sombra", "Container")
        WITH par_oPagina.cnt_4c_Sombra
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 12
            .Height    = 40
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 12
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes Salvar/Cancelar (Grupo_Salva legado)
        *-- Grupo_Salva.Top=8 + 29 = 37, Left=820
        par_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH par_oPagina.cnt_4c_Salva
            .Top         = 37
            .Left        = 820
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar/Salvar (Left=5, Top=5, Width=75, Height=75)
        par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH par_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
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

        *-- Botao Cancelar (Left=80, Top=5, Width=75, Height=75)
        par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
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

        *--------------------------------------------------------------------------
        *-- CAMPOS DA LINHA 1: Produto (Say1 + get_produto + getDpro)
        *-- Compensacao PageFrame +29: top=17->46, top=14->43
        *--------------------------------------------------------------------------

        *-- Label "Produto :" (Say1: top=17+29=46, left=199, width=47, height=15)
        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = "Produto :"
            .Top       = 118
            .Left      = 199
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Produto (get_produto: top=14+29=43, left=251, width=108, height=23)
        *-- Lookup SigCdPro por cpros (quando INSERIR); readonly em outros modos
        par_oPagina.AddObject("txt_4c_Produto", "TextBox")
        WITH par_oPagina.txt_4c_Produto
            .Top       = 115
            .Left      = 251
            .Width     = 108
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao Produto (getDpro: top=14+29=43, left=361, width=360, height=23)
        *-- Lookup SigCdPro por dpros (quando INSERIR); readonly em outros modos
        par_oPagina.AddObject("txt_4c_Dpro", "TextBox")
        WITH par_oPagina.txt_4c_Dpro
            .Top       = 115
            .Left      = 361
            .Width     = 360
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- CAMPOS DA LINHA 2: Grupo + Situacao
        *-- Compensacao PageFrame +29: top=44->73, top=40->69, top=38->67
        *--------------------------------------------------------------------------

        *-- Label "Grupo :" (Say8: top=44+29=73, left=208, width=38, height=15)
        par_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH par_oPagina.lbl_4c_Label8
            .Caption   = "Grupo :"
            .Top       = 145
            .Left      = 208
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Grupo (getCgru: top=40+29=69, left=251, width=31, height=23)
        *-- When=.F. -> sempre readonly (preenchido automaticamente pelo produto)
        par_oPagina.AddObject("txt_4c_Cgru", "TextBox")
        WITH par_oPagina.txt_4c_Cgru
            .Top       = 141
            .Left      = 251
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao Grupo (getDgru: top=40+29=69, left=284, width=150, height=23)
        *-- When=.F. -> sempre readonly
        par_oPagina.AddObject("txt_4c_Dgru", "TextBox")
        WITH par_oPagina.txt_4c_Dgru
            .Top       = 141
            .Left      = 284
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label "Situacao :" (Say19: top=44+29=73, left=456)
        par_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH par_oPagina.lbl_4c_Label19
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 145
            .Left      = 456
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Situacao (Opc_situacao: top=38+29=67, left=504, width=117, height=25)
        *-- When=.F. -> sempre desabilitado (informativo)
        par_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH par_oPagina.obj_4c_Opc_situacao
            .ButtonCount = 2
            .Width       = 117
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Enabled     = .F.
            .Visible     = .T.
            .Top         = 139
            .Left        = 504

            WITH .Buttons(1)
                .Caption   = "Ativa"
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Inativa"
                .Left      = 63
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *--------------------------------------------------------------------------
        *-- CAMPOS DA LINHA 3: Fornecedor
        *-- Compensacao PageFrame +29: top=69->98, top=66->95
        *--------------------------------------------------------------------------

        *-- Label "Fornecedor :" (Say11: top=69+29=98, left=182, width=64, height=15)
        par_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH par_oPagina.lbl_4c_Label11
            .Caption   = "Fornecedor :"
            .Top       = 170
            .Left      = 182
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Fornecedor (getIfor: top=66+29=95, left=251, width=80, height=23)
        *-- When=PROCURAR: habilitado apenas no modo busca (ReadOnly nos demais)
        par_oPagina.AddObject("txt_4c_Ifor", "TextBox")
        WITH par_oPagina.txt_4c_Ifor
            .Top       = 167
            .Left      = 251
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Nome Fornecedor (getDfor: top=66+29=95, left=333, width=290, height=23)
        *-- When=.F. -> sempre readonly
        par_oPagina.AddObject("txt_4c_Dfor", "TextBox")
        WITH par_oPagina.txt_4c_Dfor
            .Top       = 167
            .Left      = 333
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs para botoes Confirmar / Cancelar
        BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *--------------------------------------------------------------------------
        *-- LINHA 4: Referencia Fornecedor + Qtde Minima
        *-- Compensacao PageFrame +29: top=95->124, top=92->121
        *--------------------------------------------------------------------------

        *-- Label "Ref. Fornecedor :" (Say12: top=95+29=124, left=158, w=88, h=15)
        par_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH par_oPagina.lbl_4c_Label12
            .Caption   = "Ref. Fornecedor :"
            .Top       = 196
            .Left      = 158
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Ref. Fornecedor (getRefs: top=92+29=121, left=251, w=150, h=23)
        *-- When=PROCURAR: apenas no modo busca; readonly nos demais modos
        par_oPagina.AddObject("txt_4c_Refs", "TextBox")
        WITH par_oPagina.txt_4c_Refs
            .Top       = 193
            .Left      = 251
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label "Qtde Minima :" (Say13: top=95+29=124, left=470, w=68, h=15)
        par_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH par_oPagina.lbl_4c_Label13
            .Caption   = "Qtde M" + CHR(237) + "nima :"
            .Top       = 196
            .Left      = 470
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Qtde Minima (getQmin: top=92+29=121, left=543, w=80, h=23)
        *-- ReadOnly - calculado automaticamente pelo sistema
        par_oPagina.AddObject("txt_4c_Qmin", "TextBox")
        WITH par_oPagina.txt_4c_Qmin
            .Top       = 193
            .Left      = 543
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .InputMask = "999,999.99"
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Grid de itens (gradei: top=125+29=154, left=146, w=692, h=436, 8 colunas)
        *-- Colunas: emps, qmins, codtams, codcores, grupos, contas, locals, qideal
        *--------------------------------------------------------------------------
        par_oPagina.AddObject("grd_4c_GradeI", "Grid")
        WITH par_oPagina.grd_4c_GradeI
            .Top                = 226
            .Left               = 146
            .Width              = 692
            .Height             = 364
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .RowHeight          = 18
            .HeaderHeight       = 22
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 3
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(15, 41, 104)
            .HighlightForeColor = RGB(255, 255, 255)
            .AllowCellSelection = .T.
            .AllowHeaderSizing  = .F.
            .Visible            = .T.
        ENDWITH

        *-- ColumnCount FORA do WITH (Problem 36 - cria Text1 imediatamente)
        par_oPagina.grd_4c_GradeI.ColumnCount = 8

        *-- Colunas no funil unico (mesmos valores do SCX legado, inclusive ColumnOrder)
        THIS.FormatarColunasGrade(par_oPagina.grd_4c_GradeI)

        *-- Celulas da grade: TextBox proprio por coluna, com When/Valid/LostFocus
        *-- embutidos (regra #46 - BINDEVENT em Valid de Column nao eh confiavel).
        *-- Substitui os BINDEVENT "KeyPress" que existiam aqui e que nunca
        *-- abriam a lista (o legado abre no Valid, ao SAIR da celula).
        THIS.InstalarCelulasGrade(par_oPagina.grd_4c_GradeI)

        *-- BINDEVENT do GRID (nao de coluna) - este funciona
        BINDEVENT(par_oPagina.grd_4c_GradeI, "AfterRowColChange", THIS, "GradeIAfterRowColChange")

        *--------------------------------------------------------------------------
        *-- Botao Excluir linha do grid (btnExcluir: top=313+29=342, left=843, w=45, h=45)
        *-- Standalone com icone - usar Themes=.T. + DisabledPicture (Problem 29)
        *--------------------------------------------------------------------------
        par_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnExcluir
            .Caption         = ""
            .Top             = 414
            .Left            = 843
            .Width           = 45
            .Height          = 45
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 0
            .ToolTipText     = "Excluir linha"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLinhaClick")

        *--------------------------------------------------------------------------
        *-- PARTE INFERIOR: "Retiravel :" + OptionGroup optRetiras
        *-- Compensacao PageFrame +29: top=569->598, top=563->592
        *--------------------------------------------------------------------------

        *-- Label "Retiravel :" (Say2: top=569+29=598, left=156)
        par_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPagina.lbl_4c_Label2
            .Caption   = "Retir" + CHR(225) + "vel :"
            .Top       = 598
            .Left      = 156
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Retiravel (optRetiras: top=563+29=592, left=207, w=168, h=27, 3 botoes)
        *-- When=.F. no legado: display-only, atualizado via GradeIAfterRowColChange
        par_oPagina.AddObject("obj_4c_OptRetiras", "OptionGroup")
        WITH par_oPagina.obj_4c_OptRetiras
            .ButtonCount = 3
            .Width       = 168
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Enabled     = .F.
            .Visible     = .T.
            .Top         = 592
            .Left        = 207

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 50
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Produto"
                .Left      = 100
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- BINDEVENTs para lookup de produto (get_produto / getDpro) -- apenas em modo INSERIR
        *-- O legado abre a lista no Valid do get_produto, ou seja ao SAIR do
        *-- campo com qualquer valor digitado - por isso "LostFocus" (regra #47).
        *-- O KeyPress fica so para o F4/F5, que testa a tecla e por isso eh o
        *-- caso legitimo de KeyPress.
        BINDEVENT(par_oPagina.txt_4c_Produto, "LostFocus", THIS, "ProdutoCodLostFocus")
        BINDEVENT(par_oPagina.txt_4c_Produto, "KeyPress",  THIS, "ProdutoCodKeyPress")
        BINDEVENT(par_oPagina.txt_4c_Produto, "DblClick",  THIS, "ProdutoCodDblClick")
        BINDEVENT(par_oPagina.txt_4c_Dpro,    "LostFocus", THIS, "ProdutoDescLostFocus")
        BINDEVENT(par_oPagina.txt_4c_Dpro,    "KeyPress",  THIS, "ProdutoDescKeyPress")
        BINDEVENT(par_oPagina.txt_4c_Dpro,    "DblClick",  THIS, "ProdutoDescDblClick")

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Containers flutuantes que iniciam ocultos sao preservados (cnt_4c_Copia)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Preservar containers flutuantes que devem iniciar ocultos
                IF INLIST(loc_cNome, "CNT_4C_COPIA")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
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

                *-- Recursao em containers
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
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
    * FormatarColunasGrade - Funil unico das colunas da grade de itens (gradei)
    * Valores transcritos do SCX legado, inclusive a ColumnOrder:
    *   ordem visual = Emp, Qtde.Minima, Estoque Alvo, Cor, Tamanho, Grupo,
    *   Conta, Local (Column3.ColumnOrder=5, Column5=6, Column6=7, Column7=8,
    *   Column8=3; as demais ficam na ordem natural).
    * As chamadas vao em ordem CRESCENTE de posicao: cada coluna ja colocada
    * fica fixa, porque uma insercao posterior so desloca posicoes maiores.
    *==========================================================================
    PROTECTED PROCEDURE FormatarColunasGrade(par_oGrid)
        WITH par_oGrid
            THIS.FormatarColunaGrade(.Column1, "Emp",                                  44, "Courier New", "",           1)
            THIS.FormatarColunaGrade(.Column2, "Qtde. M" + CHR(237) + "nima",         100, "Tahoma",      "999,999.99", 2)
            THIS.FormatarColunaGrade(.Column8, "Estoque Alvo",                        100, "Courier New", "999,999.99", 3)
            THIS.FormatarColunaGrade(.Column4, "Cor",                                  55, "Courier New", "",           4)
            THIS.FormatarColunaGrade(.Column3, "Tamanho",                              55, "Tahoma",      "",           5)
            THIS.FormatarColunaGrade(.Column5, "Grupo",                               100, "Courier New", "",           6)
            THIS.FormatarColunaGrade(.Column6, "Conta",                               100, "Courier New", "",           7)
            THIS.FormatarColunaGrade(.Column7, "Local",                               100, "Arial",       "",           8)
        ENDWITH
    ENDPROC

    *==========================================================================
    * InstalarCelulasGrade - Poe um TextBoxCelulaEmn_4c como CurrentControl de
    * cada coluna da gradei. Sem CurrentControl + Sparse = .F. o controle eh
    * criado e NUNCA aparece / nunca recebe os eventos (regra #18).
    * Fontes por coluna transcritas dos Text1 do SCX legado.
    *==========================================================================
    PROTECTED PROCEDURE InstalarCelulasGrade(par_oGrid)
        THIS.InstalarCelulaGrade(par_oGrid.Column1, "cel_4c_Emp", "EMP", "Courier New", "")
        THIS.InstalarCelulaGrade(par_oGrid.Column2, "cel_4c_Qtd", "QTD", "Tahoma",      "999,999.99")
        THIS.InstalarCelulaGrade(par_oGrid.Column3, "cel_4c_Tam", "TAM", "Tahoma",      "")
        THIS.InstalarCelulaGrade(par_oGrid.Column4, "cel_4c_Cor", "COR", "Courier New", "")
        THIS.InstalarCelulaGrade(par_oGrid.Column5, "cel_4c_Gru", "GRU", "Courier New", "")
        THIS.InstalarCelulaGrade(par_oGrid.Column6, "cel_4c_Cta", "CTA", "Courier New", "")
        THIS.InstalarCelulaGrade(par_oGrid.Column7, "cel_4c_Lcl", "LCL", "Arial",       "")
        THIS.InstalarCelulaGrade(par_oGrid.Column8, "cel_4c_Qid", "QID", "Courier New", "999,999.99")
    ENDPROC

    *==========================================================================
    * InstalarCelulaGrade - Instala a celula de UMA coluna (idempotente)
    *==========================================================================
    PROTECTED PROCEDURE InstalarCelulaGrade(par_oColuna, par_cNome, par_cPapel, ;
                                            par_cFonte, par_cMascara)
        IF !PEMSTATUS(par_oColuna, par_cNome, 5)
            par_oColuna.AddObject(par_cNome, "TextBoxCelulaEmn_4c")
        ENDIF

        WITH EVALUATE("par_oColuna." + par_cNome)
            .this_cPapel = par_cPapel
            .FontName    = par_cFonte
            .FontSize    = 9
            .InputMask   = par_cMascara
            .Visible     = .T.
        ENDWITH

        par_oColuna.CurrentControl = par_cNome
        par_oColuna.Sparse         = .F.
    ENDPROC

    *==========================================================================
    * CelulaGradeEmnEditavel - reproduz os When dos Text1 das colunas do legado
    *==========================================================================
    PROCEDURE CelulaGradeEmnEditavel(par_cPapel, par_oTxt)
        LOCAL loc_lEdicao, loc_lTemProduto, loc_lTemEmpresa, loc_oBO
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF !loc_lEdicao OR !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN .F.
        ENDIF

        loc_oBO         = THIS.this_oBusinessObject
        loc_lTemProduto = !EMPTY(ALLTRIM(CrSigCdMin.cpros))
        loc_lTemEmpresa = !EMPTY(ALLTRIM(CrSigCdMin.emps))

        DO CASE
            *-- Empresa: so enquanto VAZIA (legado: And Empty(This.Value))
            CASE par_cPapel == "EMP"
                RETURN loc_lTemProduto AND !loc_lTemEmpresa

            CASE par_cPapel == "TAM"
                RETURN loc_lTemProduto AND loc_lTemEmpresa AND loc_oBO.this_lTemTam

            CASE par_cPapel == "COR"
                RETURN loc_lTemProduto AND loc_lTemEmpresa AND loc_oBO.this_lTemCor

            OTHERWISE
                RETURN loc_lTemProduto
        ENDCASE
    ENDPROC

    *==========================================================================
    * ValidarCelulaGradeEmn - reproduz os Valid dos Text1 das colunas do legado
    * O valor digitado esta em par_oTxt.Value; o cursor so recebe DEPOIS do
    * Valid, entao ler do cursor aqui validaria o valor ANTIGO (regra #46).
    *==========================================================================
    PROCEDURE ValidarCelulaGradeEmn(par_cPapel, par_oTxt)
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            DO CASE
                *-- Qtde. Minima e Estoque Alvo: legado so recusa negativo
                CASE INLIST(par_cPapel, "QTD", "QID")
                    IF VARTYPE(par_oTxt.Value) = "N" AND par_oTxt.Value < 0
                        MsgAviso("Quantidade Inv" + CHR(225) + "lida !!!", "ERRO")
                        par_oTxt.Value = 0
                        loc_lResultado = .F.
                    ENDIF

                *-- Demais: com valor digitado, o legado abre a lista
                OTHERWISE
                    IF !EMPTY(ALLTRIM(TRANSFORM(par_oTxt.Value)))
                        THIS.AbrirLookupCelulaEmn(par_cPapel, par_oTxt)
                    ENDIF
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.ValidarCelulaGradeEmn")
            loc_lResultado = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AbrirLookupCelulaEmn - despacha para o picker da coluna
    * Guarda de reentrancia: o picker eh MODAL, tira o foco e pode redisparar
    * o proprio Valid/LostFocus (regra #37/#47). Liberada por wrapper, para
    * valer tambem quando o corpo sai por RETURN ou por excecao.
    *==========================================================================
    PROCEDURE AbrirLookupCelulaEmn(par_cPapel, par_oTxt)
        IF THIS.this_lEmLookupGrade
            RETURN
        ENDIF

        THIS.this_lEmLookupGrade = .T.
        TRY
            DO CASE
                CASE par_cPapel == "EMP"
                    THIS.AbrirLookupEmpresa(par_oTxt)
                CASE par_cPapel == "TAM"
                    THIS.AbrirLookupTamanho(par_oTxt)
                CASE par_cPapel == "COR"
                    THIS.AbrirLookupCor(par_oTxt)
                CASE par_cPapel == "GRU"
                    THIS.AbrirLookupGrupo(par_oTxt)
                CASE par_cPapel == "CTA"
                    THIS.AbrirLookupConta(par_oTxt)
                CASE par_cPapel == "LCL"
                    THIS.AbrirLookupLocal(par_oTxt)
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupCelulaEmn")
        ENDTRY
        THIS.this_lEmLookupGrade = .F.
    ENDPROC

    *==========================================================================
    * NovaLinhaGradeEmn - LostFocus da celula Local (Column7.Text1 no legado):
    *   If !InList(LastKey(),4,5,19,24)
    *       ThisForm.MNovaLinha()
    *   EndIf
    * 4/5/19/24 = setas direita/cima/esquerda/baixo: navegar pela grade NAO
    * cria linha; sair com Tab/Enter/clique cria.
    *==========================================================================
    PROCEDURE NovaLinhaGradeEmn()
        IF INLIST(LASTKEY(), 4, 5, 19, 24)
            RETURN
        ENDIF

        IF THIS.this_lEmLookupGrade
            RETURN
        ENDIF

        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        TRY
            LOCAL loc_lTemVazia, loc_nRec
            loc_lTemVazia = .F.
            loc_nRec      = RECNO("CrSigCdMin")

            *-- O legado insere sempre; aqui so quando nao ha linha em branco,
            *-- senao cada passagem pelo Local acumula linha vazia.
            SELECT CrSigCdMin
            SCAN FOR !DELETED()
                IF EMPTY(ALLTRIM(CrSigCdMin.emps))
                    loc_lTemVazia = .T.
                    EXIT
                ENDIF
            ENDSCAN

            IF BETWEEN(loc_nRec, 1, RECCOUNT("CrSigCdMin"))
                GO loc_nRec IN CrSigCdMin
            ENDIF

            IF !loc_lTemVazia
                THIS.AdicionarLinhaGrid()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.NovaLinhaGradeEmn")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormatarColunaGrade - Propriedades de UMA coluna da gradei
    * ColumnOrder antes da Width; Width eh a ULTIMA atribuicao (regra #41)
    *==========================================================================
    PROTECTED PROCEDURE FormatarColunaGrade(par_oColuna, par_cTitulo, par_nLargura, ;
                                            par_cFonte, par_cMascara, par_nOrdem)
        WITH par_oColuna
            .Header1.Caption   = par_cTitulo
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .FontName          = par_cFonte
            .FontSize          = 9
            .InputMask         = par_cMascara
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .F.
            .Sparse            = .F.
            .ColumnOrder       = par_nOrdem
            .Width             = par_nLargura
        ENDWITH
    ENDPROC

    *==========================================================================
    * VincularColunasLista - Funil unico de bind da grade da Page1
    * Reproduz o pColuna do Init legado (sigclcnx.PRG):
    *   pColuna('cpros','','','Produto'   ,108,.T.)
    *   pColuna('dpros','','','Descricao' ,285,.T.)
    *   pColuna('ifors','','','Fornecedor', 75,.T.)
    *   pColuna('reffs','','','Referencia',150,.T.)
    *   pColuna('sgrus','','','Sub Grp'   , 45,.F.)
    * Ordem obrigatoria: RecordSource -> ColumnCount -> ControlSource ->
    * fonte do GRID -> propriedades -> Width POR ULTIMO (regra #41; o SQLEXEC do
    * BO recria o alias CrProdutos e derruba o ColumnCount)
    *==========================================================================
    PROTECTED PROCEDURE VincularColunasLista(par_oGrid)
        par_oGrid.RecordSource = "CrProdutos"
        par_oGrid.ColumnCount  = 5

        par_oGrid.Column1.ControlSource = "CrProdutos.cpros"
        par_oGrid.Column2.ControlSource = "CrProdutos.dpros"
        par_oGrid.Column3.ControlSource = "CrProdutos.ifors"
        par_oGrid.Column4.ControlSource = "CrProdutos.reffs"
        par_oGrid.Column5.ControlSource = "CrProdutos.sgrus"

        *-- fonte do GRID antes das colunas (senao sobrescreve a da coluna)
        THIS.FormatarGridLista(par_oGrid)

        THIS.FormatarColunaLista(par_oGrid.Column1, "Produto",    108)
        THIS.FormatarColunaLista(par_oGrid.Column2, "Descri" + CHR(231) + CHR(227) + "o", 285)
        THIS.FormatarColunaLista(par_oGrid.Column3, "Fornecedor",  75)
        THIS.FormatarColunaLista(par_oGrid.Column4, "Refer" + CHR(234) + "ncia", 150)
        THIS.FormatarColunaLista(par_oGrid.Column5, "Sub Grp",     45)

        par_oGrid.Refresh()
    ENDPROC

    *==========================================================================
    * FormatarColunaLista - Aplica a uma coluna o que o pColuna legado aplica
    * Width eh a ULTIMA atribuicao da coluna (regra #41)
    *==========================================================================
    PROTECTED PROCEDURE FormatarColunaLista(par_oColuna, par_cTitulo, par_nLargura)
        WITH par_oColuna
            .Header1.Caption   = par_cTitulo
            .Header1.FontName  = "Arial"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .FontName          = "Courier New"
            .FontSize          = 9
            .Format            = "K"
            .SelectOnEntry     = .F.
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Width             = par_nLargura
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Limpar cursores do BO
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("CrSigCdMin")
                USE IN CrSigCdMin
            ENDIF
            IF USED("CrProdutos")
                USE IN CrProdutos
            ENDIF
            IF USED("CsCabec")
                USE IN CsCabec
            ENDIF
            IF USED("CsCopia")
                USE IN CsCopia
            ENDIF

            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.Destroy")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva itens da grade e retorna para Page1
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        TRY
            LOCAL loc_cCPros, loc_lTemLinhas
            loc_cCPros     = ""
            loc_lTemLinhas = .F.

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Produto", 5)
                loc_cCPros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)
            ENDIF

            IF EMPTY(loc_cCPros)
                MsgAviso("Informe o produto antes de salvar.", "Salvar")
            ELSE
                IF USED("CrSigCdMin")
                    SELECT CrSigCdMin
                    SCAN FOR !DELETED()
                        IF !EMPTY(ALLTRIM(CrSigCdMin.emps))
                            loc_lTemLinhas = .T.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                IF !loc_lTemLinhas
                    MsgAviso("Inclua pelo menos um item na grade antes de salvar.", "Salvar")
                ELSE
                    THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Registros salvos com sucesso.", "Salvar")
                        THIS.AlternarPagina(1)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para Page1
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza campos do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        TRY
            LOCAL loc_oPg2
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.this_oBusinessObject.this_cCPros = ALLTRIM(loc_oPg2.txt_4c_Produto.Value)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos do form a partir do BO (modos VISUALIZAR/ALTERAR)
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        TRY
            LOCAL loc_oPg2, loc_oBO
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oBusinessObject

            loc_oPg2.txt_4c_Produto.Value = loc_oBO.this_cCPros
            loc_oPg2.txt_4c_Dpro.Value    = loc_oBO.this_cDPros
            loc_oPg2.txt_4c_Cgru.Value    = loc_oBO.this_cCGrus
            loc_oPg2.txt_4c_Dgru.Value    = loc_oBO.this_cDGrus
            loc_oPg2.txt_4c_Ifor.Value    = loc_oBO.this_cIFors
            loc_oPg2.txt_4c_Dfor.Value    = loc_oBO.this_cRClis
            loc_oPg2.txt_4c_Refs.Value    = loc_oBO.this_cReffs
            loc_oPg2.txt_4c_Qmin.Value    = loc_oBO.this_nQMins

            loc_oPg2.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 1, 1, 2)

            THIS.CarregarGrade(loc_oBO.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo de edicao
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        TRY
            LOCAL loc_oPg2, loc_lProdutoEdit
            loc_oPg2         = THIS.pgf_4c_Paginas.Page2
            loc_lProdutoEdit = (THIS.this_cModoAtual = "INCLUIR")

            loc_oPg2.txt_4c_Produto.ReadOnly = !loc_lProdutoEdit
            loc_oPg2.txt_4c_Dpro.ReadOnly    = !loc_lProdutoEdit

            loc_oPg2.txt_4c_Cgru.ReadOnly = .T.
            loc_oPg2.txt_4c_Dgru.ReadOnly = .T.
            loc_oPg2.txt_4c_Ifor.ReadOnly = .T.
            loc_oPg2.txt_4c_Dfor.ReadOnly = .T.
            loc_oPg2.txt_4c_Refs.ReadOnly = .T.
            loc_oPg2.txt_4c_Qmin.ReadOnly = .T.

            loc_oPg2.grd_4c_GradeI.ReadOnly                = !par_lHabilitar
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        TRY
            LOCAL loc_oPg2
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Produto.Value = ""
            loc_oPg2.txt_4c_Dpro.Value    = ""
            loc_oPg2.txt_4c_Cgru.Value    = ""
            loc_oPg2.txt_4c_Dgru.Value    = ""
            loc_oPg2.txt_4c_Ifor.Value    = ""
            loc_oPg2.txt_4c_Dfor.Value    = ""
            loc_oPg2.txt_4c_Refs.Value    = ""
            loc_oPg2.txt_4c_Qmin.Value    = 0

            loc_oPg2.obj_4c_Opc_situacao.Value = 1
            loc_oPg2.obj_4c_OptRetiras.Value   = 1

            THIS.CriarCursorGridVazio("")
            THIS.ConfigurarRecordSourceGrid()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarGrade - Carrega itens do grid para o produto especificado
    *==========================================================================
    PROTECTED PROCEDURE CarregarGrade(par_cCPros)
        TRY
            THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.RecordSource = ""

            IF !THIS.this_oBusinessObject.BuscarItens(par_cCPros)
                THIS.CriarCursorGridVazio(par_cCPros)
            ENDIF

            THIS.ConfigurarRecordSourceGrid()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.CarregarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarRecordSourceGrid - Vincula CrSigCdMin ao grid e seta ControlSources
    * Deve ser chamado APOS qualquer mudanca no cursor (Problem 48)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarRecordSourceGrid()
        TRY
            LOCAL loc_oGrid, loc_oBO
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
            loc_oBO   = THIS.this_oBusinessObject

            loc_oGrid.RecordSource = "CrSigCdMin"

            *-- ColumnCount APOS RecordSource: o SQLEXEC de BuscarItens recria o
            *-- alias e o grid volta ao modo automatico - sem isto ele cria uma
            *-- coluna por campo do cursor (21) e mostra os nomes crus do SELECT.
            *-- Reduzir eh seguro aqui: nenhuma Column usa AddObject/CurrentControl,
            *-- e os BINDEVENT estao nos Text1 das Column1..8, que sobrevivem.
            loc_oGrid.ColumnCount = 8

            *-- ControlSources APOS RecordSource (Problem 48 - RecordSource reseta bindings)
            loc_oGrid.Column1.ControlSource = "CrSigCdMin.emps"
            loc_oGrid.Column2.ControlSource = "CrSigCdMin.qmins"
            loc_oGrid.Column3.ControlSource = "CrSigCdMin.codtams"
            loc_oGrid.Column4.ControlSource = "CrSigCdMin.codcores"
            loc_oGrid.Column5.ControlSource = "CrSigCdMin.grupos"
            loc_oGrid.Column6.ControlSource = "CrSigCdMin.contas"
            loc_oGrid.Column7.ControlSource = "CrSigCdMin.locals"
            loc_oGrid.Column8.ControlSource = "CrSigCdMin.qideal"

            *-- Captions, ColumnOrder, fontes e Width - RecordSource reseta tudo (regra #41)
            THIS.FormatarColunasGrade(loc_oGrid)

            *-- Reafirma CurrentControl/Sparse das celulas: e idempotente (nao
            *-- recria o AddObject). Sem CurrentControl a coluna volta a desenhar
            *-- o Text1 e os eventos de lookup somem (regra #18).
            THIS.InstalarCelulasGrade(loc_oGrid)

            *-- Habilitar/desabilitar colunas Tamanho e Cor conforme flags do produto
            loc_oGrid.Column3.ReadOnly = !loc_oBO.this_lTemTam
            loc_oGrid.Column4.ReadOnly = !loc_oBO.this_lTemCor

            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.ConfigurarRecordSourceGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CriarCursorGridVazio - Cria cursor CrSigCdMin com estrutura completa e
    *                        uma linha em branco para entrada de dados
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorGridVazio(par_cCPros)
        TRY
            IF USED("CrSigCdMin")
                USE IN CrSigCdMin
            ENDIF

            SET NULL ON
            CREATE CURSOR CrSigCdMin ( ;
                cpros    C(14), emps     C(3),   locals   C(10), ;
                qmins    N(8,2), codtams  C(4),   codcores C(4),  ;
                ordems   C(1),  cidchaves C(20),  contas   C(10), ;
                grupos   C(10), qideal   N(7,2),  retiras  N(1,0), ;
                pideal   N(7,3), pmins    N(7,3),  dpros    C(65), ;
                ifors    C(10), reffs    C(20),  cgrus    C(3),  ;
                situas   N(1,0), rclis    C(50),  dgrus    C(20))
            SET NULL OFF

            INSERT INTO CrSigCdMin ;
                (cpros,      emps, locals, qmins, codtams, codcores, ;
                 ordems,     cidchaves, contas, grupos, qideal, ;
                 retiras,    pideal, pmins) ;
                VALUES ;
                (par_cCPros, "",   "",    0,     "",      "",       ;
                 " ",        "",   "",    "",    0,       ;
                 1,          0,    0)

            GO TOP IN CrSigCdMin
        CATCH TO loc_oErro
            SET NULL OFF
            MsgErro(loc_oErro.Message, "FormEmn.CriarCursorGridVazio")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AdicionarLinhaGrid - Insere nova linha vazia no cursor do grid
    *==========================================================================
    PROTECTED PROCEDURE AdicionarLinhaGrid()
        IF !USED("CrSigCdMin")
            RETURN
        ENDIF

        TRY
            LOCAL loc_cCPros, loc_oGrid, loc_nRegs, loc_nLinha
            loc_cCPros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)

            INSERT INTO CrSigCdMin ;
                (cpros,      emps, locals, qmins, codtams, codcores, ;
                 ordems,     cidchaves, contas, grupos, qideal, ;
                 retiras,    pideal, pmins) ;
                VALUES ;
                (loc_cCPros, "",   "",    0,     "",      "",       ;
                 " ",        "",   "",    "",    0,       ;
                 1,          0,    0)

            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
            SELECT CrSigCdMin
            COUNT TO loc_nRegs FOR !DELETED()
            GO BOTTOM
            loc_oGrid.Refresh()

            *-- ActivateCell recebe a linha RELATIVA do grid, nao o RECNO: o
            *-- RECCOUNT conta ate os DELETED() e estoura assim que a grade passa
            *-- das linhas visiveis. Teto do legado (mnovalinha): > 12 -> 10.
            loc_nLinha = IIF(loc_nRegs > 12, 10, MAX(loc_nRegs, 1))
            loc_oGrid.ActivateCell(loc_nLinha, 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AdicionarLinhaGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDadosProduto - Popula cabecalho ao selecionar produto novo
    *==========================================================================
    PROTECTED PROCEDURE CarregarDadosProduto(par_cCPros)
        IF EMPTY(ALLTRIM(par_cCPros))
            RETURN
        ENDIF

        LOCAL loc_cSQL, loc_nRes, loc_nAreaAnterior
        *-- o USE IN de cursor de picker pode deixar a sessao SEM area corrente
        loc_nAreaAnterior = SELECT()
        loc_cSQL = ""
        loc_nRes = 0

        TRY
            loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
                " b.rclis, g.dgrus" + ;
                " FROM SigCdPro a" + ;
                " LEFT JOIN SigCdCli b ON b.iclis = a.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros))

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdDados")

            IF loc_nRes > 0 AND USED("cursor_4c_ProdDados") AND RECCOUNT("cursor_4c_ProdDados") > 0
                SELECT cursor_4c_ProdDados
                GO TOP

                LOCAL loc_oPg2, loc_oBO, loc_nSituas, loc_cCod, loc_lAceito
                loc_oPg2    = THIS.pgf_4c_Paginas.Page2
                loc_oBO     = THIS.this_oBusinessObject
                loc_nSituas = TratarNulo(cursor_4c_ProdDados.situas, "N")
                loc_cCod    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cpros, "C"))
                loc_lAceito = .T.

                *-- Guardas do get_produto.Valid legado, que so valem na INCLUSAO.
                *-- IF ANINHADO: o VFP9 nao faz curto-circuito e chamaria o
                *-- ContarItens (um SELECT) mesmo com loc_lAceito ja em .F.
                IF THIS.this_cModoAtual = "INCLUIR"
                    *-- If TmpPro.situas = 2 And CrSigCdPam.gesind = 1
                    IF loc_nSituas = 2 AND loc_oBO.ObterGesInd() = 1
                        MsgAviso("Produto Inativo !!!", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lAceito = .F.
                    ENDIF

                    *-- AcertaGrade + If !Eof(CrSigCdMin) -> ja tem estoque alvo.
                    *-- Sem esta guarda o CriarCursorGridVazio abaixo descarta as
                    *-- linhas existentes e o Confirmar (DELETE + re-INSERT do
                    *-- SalvarGrid) apagaria o que o produto ja tinha.
                    IF loc_lAceito
                        IF loc_oBO.ContarItens(loc_cCod) > 0
                            MsgAviso("Produto j" + CHR(225) + " cadastrado !!!", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                            loc_lAceito = .F.
                        ENDIF
                    ENDIF
                ENDIF

                IF !loc_lAceito
                    *-- Legado: This.Value = '' / GetDPro.Value = '' / Refresh
                    loc_oPg2.txt_4c_Produto.Value = ""
                    loc_oPg2.txt_4c_Dpro.Value    = ""
                    loc_oPg2.txt_4c_Produto.Refresh()
                    loc_oPg2.txt_4c_Dpro.Refresh()
                ELSE

                    loc_oPg2.txt_4c_Produto.Value = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cpros, "C"))
                    loc_oPg2.txt_4c_Dpro.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dpros, "C"))
                    loc_oPg2.txt_4c_Cgru.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cgrus, "C"))
                    loc_oPg2.txt_4c_Dgru.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dgrus, "C"))
                    loc_oPg2.txt_4c_Ifor.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.ifors, "C"))
                    loc_oPg2.txt_4c_Dfor.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.rclis, "C"))
                    loc_oPg2.txt_4c_Refs.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.reffs, "C"))
                    loc_oPg2.obj_4c_Opc_situacao.Value = IIF(loc_nSituas = 1, 1, 2)

                    loc_oBO.this_cCPros  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cpros, "C"))
                    loc_oBO.this_cDPros  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dpros, "C"))
                    loc_oBO.this_cCGrus  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cgrus, "C"))
                    loc_oBO.this_cIFors  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.ifors, "C"))
                    loc_oBO.this_nSituas = loc_nSituas

                    loc_oBO.BuscarFlags(ALLTRIM(par_cCPros))
                    THIS.CriarCursorGridVazio(ALLTRIM(par_cCPros))
                    THIS.ConfigurarRecordSourceGrid()

                ENDIF
            ELSE
                MsgAviso("Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCPros), "Produto")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.CarregarDadosProduto")
        ENDTRY

        IF USED("cursor_4c_ProdDados")
            USE IN cursor_4c_ProdDados
        ENDIF

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupProdutoCodigo - FormBuscaAuxiliar em SigCdPro por cpros
    *==========================================================================
    PROCEDURE AbrirLookupProdutoCodigo()
        LOCAL loc_oBusca, loc_cCPros, loc_cValorAtual, loc_nAreaAnterior
        *-- o USE IN de cursor de picker pode deixar a sessao SEM area corrente
        loc_nAreaAnterior = SELECT()
        loc_cCPros      = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProd", "cpros", loc_cValorAtual, ;
                "Buscar Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                    loc_cCPros = ALLTRIM(cursor_4c_BuscaProd.cpros)
                ENDIF

                IF USED("cursor_4c_BuscaProd")
                    USE IN cursor_4c_BuscaProd
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCPros)
                THIS.CarregarDadosProduto(loc_cCPros)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupProdutoCodigo")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC

    *==========================================================================
    * ProdutoCodLostFocus - get_produto.Valid do legado:
    *   If !Empty(This.Value) And pcEscolha = 'INSERIR' -> abre a lista
    * Wrapper fino: libera a guarda mesmo quando o corpo sai por RETURN
    * antecipado (regra #47).
    *==========================================================================
    PROCEDURE ProdutoCodLostFocus()
        IF THIS.this_lEmLookupProduto
            RETURN
        ENDIF

        THIS.this_lEmLookupProduto = .T.
        THIS.ProdutoCodLostFocusExec()
        THIS.this_lEmLookupProduto = .F.
    ENDPROC

    PROCEDURE ProdutoCodLostFocusExec()
        IF THIS.this_cModoAtual <> "INCLUIR"
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value))
            RETURN
        ENDIF

        THIS.AbrirLookupProdutoCodigo()
    ENDPROC

    *-- F4/F5 abrem o picker mesmo com o campo VAZIO (afordancia do sistema
    *-- novo). Guarda em save/restore porque o irmao LostFocus dispara logo
    *-- depois, quando o modal devolve o foco.
    PROCEDURE ProdutoCodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lAnterior

        IF THIS.this_cModoAtual = "INCLUIR" AND INLIST(par_nKeyCode, 115, 116)
            loc_lAnterior = THIS.this_lEmLookupProduto
            THIS.this_lEmLookupProduto = .T.
            THIS.AbrirLookupProdutoCodigo()
            THIS.this_lEmLookupProduto = loc_lAnterior
        ENDIF
    ENDPROC

    PROCEDURE ProdutoCodDblClick()
        LOCAL loc_lAnterior

        IF THIS.this_cModoAtual = "INCLUIR"
            loc_lAnterior = THIS.this_lEmLookupProduto
            THIS.this_lEmLookupProduto = .T.
            THIS.AbrirLookupProdutoCodigo()
            THIS.this_lEmLookupProduto = loc_lAnterior
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupProdutoDescricao - FormBuscaAuxiliar em SigCdPro por dpros
    *==========================================================================
    PROCEDURE AbrirLookupProdutoDescricao()
        LOCAL loc_oBusca, loc_cCPros, loc_cValorAtual, loc_nAreaAnterior
        *-- o USE IN de cursor de picker pode deixar a sessao SEM area corrente
        loc_nAreaAnterior = SELECT()
        loc_cCPros      = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProdD", "dpros", loc_cValorAtual, ;
                "Buscar Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdD")
                    loc_cCPros = ALLTRIM(cursor_4c_BuscaProdD.cpros)
                ENDIF

                IF USED("cursor_4c_BuscaProdD")
                    USE IN cursor_4c_BuscaProdD
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCPros)
                THIS.CarregarDadosProduto(loc_cCPros)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupProdutoDescricao")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC

    *==========================================================================
    * ProdutoDescLostFocus - espelho do ProdutoCodLostFocus pela DESCRICAO
    * (o getDPro do legado eh a 2a porta de entrada do produto)
    *==========================================================================
    PROCEDURE ProdutoDescLostFocus()
        IF THIS.this_lEmLookupProduto
            RETURN
        ENDIF

        THIS.this_lEmLookupProduto = .T.
        THIS.ProdutoDescLostFocusExec()
        THIS.this_lEmLookupProduto = .F.
    ENDPROC

    PROCEDURE ProdutoDescLostFocusExec()
        IF THIS.this_cModoAtual <> "INCLUIR"
            RETURN
        ENDIF

        *-- so entra pela descricao enquanto o CODIGO estiver vazio
        IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value))
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.Value))
            RETURN
        ENDIF

        THIS.AbrirLookupProdutoDescricao()
    ENDPROC

    PROCEDURE ProdutoDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lAnterior

        IF THIS.this_cModoAtual = "INCLUIR" AND INLIST(par_nKeyCode, 115, 116)
            loc_lAnterior = THIS.this_lEmLookupProduto
            THIS.this_lEmLookupProduto = .T.
            THIS.AbrirLookupProdutoDescricao()
            THIS.this_lEmLookupProduto = loc_lAnterior
        ENDIF
    ENDPROC

    PROCEDURE ProdutoDescDblClick()
        LOCAL loc_lAnterior

        IF THIS.this_cModoAtual = "INCLUIR"
            loc_lAnterior = THIS.this_lEmLookupProduto
            THIS.this_lEmLookupProduto = .T.
            THIS.AbrirLookupProdutoDescricao()
            THIS.this_lEmLookupProduto = loc_lAnterior
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresa - FormBuscaAuxiliar em SigCdEmp por Cemps
    * Substitui fAcessoEmpresa() (funcao do framework legado nao portada)
    *==========================================================================
    PROCEDURE AbrirLookupEmpresa(par_oTxt)
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCemps, loc_cValorAtual, loc_lTinhaOpcoes, loc_nAreaAnterior
        *-- O Grid do picker SELECIONA o proprio cursor; o USE IN abaixo fecha
        *-- essa area e deixa a sessao SEM area corrente - dai o REPLACE sem
        *-- IN <alias> estourar "No table is open in the current work area".
        loc_nAreaAnterior = SELECT()
        loc_lTinhaOpcoes = .F.
        loc_cCemps      = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(TRANSFORM(par_oTxt.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValorAtual, ;
                "Buscar Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    loc_cCemps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                ENDIF

                *-- Universo VAZIO nao eh ESC do usuario: nao apagar o digitado (regra #50)
                IF USED("cursor_4c_BuscaEmp")
                    loc_lTinhaOpcoes = (RECCOUNT("cursor_4c_BuscaEmp") > 0)
                ENDIF

                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCemps)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    par_oTxt.Value = loc_cCemps
                    REPLACE emps WITH loc_cCemps IN CrSigCdMin
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ELSE
                *-- Legado: If LastKey() <> 27 ... Else This.Value = '' - ESC limpa
                IF LASTKEY() = 27 AND loc_lTinhaOpcoes
                    par_oTxt.Value = ""
                    IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                        REPLACE emps WITH "" IN CrSigCdMin
                        THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupEmpresa")
        ENDTRY

        *-- repoe a area de trabalho para quem chamou
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC
    *==========================================================================
    * AbrirLookupTamanho - FormBuscaAuxiliar em SigCdTam por cods/descs
    *==========================================================================
    PROCEDURE AbrirLookupTamanho(par_oTxt)
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCods, loc_cValorAtual, loc_lTinhaOpcoes, loc_nAreaAnterior
        *-- O Grid do picker SELECIONA o proprio cursor; o USE IN abaixo fecha
        *-- essa area e deixa a sessao SEM area corrente - dai o REPLACE sem
        *-- IN <alias> estourar "No table is open in the current work area".
        loc_nAreaAnterior = SELECT()
        loc_lTinhaOpcoes = .F.
        loc_cCods       = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(TRANSFORM(par_oTxt.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cValorAtual, ;
                "Buscar Tamanho")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
                    loc_cCods = ALLTRIM(cursor_4c_BuscaTam.cods)
                ENDIF

                *-- Universo VAZIO nao eh ESC do usuario: nao apagar o digitado (regra #50)
                IF USED("cursor_4c_BuscaTam")
                    loc_lTinhaOpcoes = (RECCOUNT("cursor_4c_BuscaTam") > 0)
                ENDIF

                IF USED("cursor_4c_BuscaTam")
                    USE IN cursor_4c_BuscaTam
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCods)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    par_oTxt.Value = loc_cCods
                    REPLACE codtams WITH loc_cCods IN CrSigCdMin
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ELSE
                *-- Legado: If LastKey() <> 27 ... Else This.Value = '' - ESC limpa
                IF LASTKEY() = 27 AND loc_lTinhaOpcoes
                    par_oTxt.Value = ""
                    IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                        REPLACE codtams WITH "" IN CrSigCdMin
                        THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupTamanho")
        ENDTRY

        *-- repoe a area de trabalho para quem chamou
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC
    *==========================================================================
    * AbrirLookupCor - FormBuscaAuxiliar em SigCdCor por cods/descs
    *==========================================================================
    PROCEDURE AbrirLookupCor(par_oTxt)
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCods, loc_cValorAtual, loc_lTinhaOpcoes, loc_nAreaAnterior
        *-- O Grid do picker SELECIONA o proprio cursor; o USE IN abaixo fecha
        *-- essa area e deixa a sessao SEM area corrente - dai o REPLACE sem
        *-- IN <alias> estourar "No table is open in the current work area".
        loc_nAreaAnterior = SELECT()
        loc_lTinhaOpcoes = .F.
        loc_cCods       = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(TRANSFORM(par_oTxt.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValorAtual, ;
                "Buscar Cor")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
                    loc_cCods = ALLTRIM(cursor_4c_BuscaCor.cods)
                ENDIF

                *-- Universo VAZIO nao eh ESC do usuario: nao apagar o digitado (regra #50)
                IF USED("cursor_4c_BuscaCor")
                    loc_lTinhaOpcoes = (RECCOUNT("cursor_4c_BuscaCor") > 0)
                ENDIF

                IF USED("cursor_4c_BuscaCor")
                    USE IN cursor_4c_BuscaCor
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCods)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    par_oTxt.Value = loc_cCods
                    REPLACE codcores WITH loc_cCods IN CrSigCdMin
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ELSE
                *-- Legado: If LastKey() <> 27 ... Else This.Value = '' - ESC limpa
                IF LASTKEY() = 27 AND loc_lTinhaOpcoes
                    par_oTxt.Value = ""
                    IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                        REPLACE codcores WITH "" IN CrSigCdMin
                        THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupCor")
        ENDTRY

        *-- repoe a area de trabalho para quem chamou
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC
    *==========================================================================
    * AbrirLookupGrupo - FormBuscaAuxiliar em SigCdGcr por Codigos/Descrs
    * Substitui fAcessoContab() (funcao do framework legado nao portada)
    *==========================================================================
    PROCEDURE AbrirLookupGrupo(par_oTxt)
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCodigos, loc_cValorAtual, loc_lTinhaOpcoes, loc_nAreaAnterior
        *-- O Grid do picker SELECIONA o proprio cursor; o USE IN abaixo fecha
        *-- essa area e deixa a sessao SEM area corrente - dai o REPLACE sem
        *-- IN <alias> estourar "No table is open in the current work area".
        loc_nAreaAnterior = SELECT()
        loc_lTinhaOpcoes = .F.
        loc_cCodigos    = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(TRANSFORM(par_oTxt.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrp", "Codigos", loc_cValorAtual, ;
                "Buscar Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                    loc_cCodigos = ALLTRIM(cursor_4c_BuscaGrp.Codigos)
                ENDIF

                *-- Universo VAZIO nao eh ESC do usuario: nao apagar o digitado (regra #50)
                IF USED("cursor_4c_BuscaGrp")
                    loc_lTinhaOpcoes = (RECCOUNT("cursor_4c_BuscaGrp") > 0)
                ENDIF

                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCodigos)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    par_oTxt.Value = loc_cCodigos
                    REPLACE grupos WITH loc_cCodigos IN CrSigCdMin
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ELSE
                *-- Legado: If LastKey() <> 27 ... Else This.Value = '' - ESC limpa
                IF LASTKEY() = 27 AND loc_lTinhaOpcoes
                    par_oTxt.Value = ""
                    IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                        REPLACE grupos WITH "" IN CrSigCdMin
                        THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupGrupo")
        ENDTRY

        *-- repoe a area de trabalho para quem chamou
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC
    *==========================================================================
    * AbrirLookupConta - FormBuscaAuxiliar em SigCdCli por iclis/rclis
    * Substitui fAcessoContas() (funcao do framework legado nao portada)
    *==========================================================================
    PROCEDURE AbrirLookupConta(par_oTxt)
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cIclis, loc_cValorAtual, loc_lTinhaOpcoes, loc_nAreaAnterior
        *-- O Grid do picker SELECIONA o proprio cursor; o USE IN abaixo fecha
        *-- essa area e deixa a sessao SEM area corrente - dai o REPLACE sem
        *-- IN <alias> estourar "No table is open in the current work area".
        loc_nAreaAnterior = SELECT()
        loc_lTinhaOpcoes = .F.
        loc_cIclis      = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(TRANSFORM(par_oTxt.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cValorAtual, ;
                "Buscar Conta")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    loc_cIclis = ALLTRIM(cursor_4c_BuscaCli.iclis)
                ENDIF

                *-- Universo VAZIO nao eh ESC do usuario: nao apagar o digitado (regra #50)
                IF USED("cursor_4c_BuscaCli")
                    loc_lTinhaOpcoes = (RECCOUNT("cursor_4c_BuscaCli") > 0)
                ENDIF

                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cIclis)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    par_oTxt.Value = loc_cIclis
                    REPLACE contas WITH loc_cIclis IN CrSigCdMin
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ELSE
                *-- Legado: If LastKey() <> 27 ... Else This.Value = '' - ESC limpa
                IF LASTKEY() = 27 AND loc_lTinhaOpcoes
                    par_oTxt.Value = ""
                    IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                        REPLACE contas WITH "" IN CrSigCdMin
                        THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupConta")
        ENDTRY

        *-- repoe a area de trabalho para quem chamou
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC
    *==========================================================================
    * AbrirLookupLocal - FormBuscaAuxiliar em SigPrLcl (filtro Tipos=3)
    *==========================================================================
    PROCEDURE AbrirLookupLocal(par_oTxt)
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCodigos, loc_cValorAtual, loc_lTinhaOpcoes, loc_nAreaAnterior
        *-- O Grid do picker SELECIONA o proprio cursor; o USE IN abaixo fecha
        *-- essa area e deixa a sessao SEM area corrente - dai o REPLACE sem
        *-- IN <alias> estourar "No table is open in the current work area".
        loc_nAreaAnterior = SELECT()
        loc_lTinhaOpcoes = .F.
        loc_cCodigos    = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(TRANSFORM(par_oTxt.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLcl", "cursor_4c_BuscaLcl", "Codigos", loc_cValorAtual, ;
                "Buscar Local", .F., .T., "Tipos = 3")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLcl")
                    loc_cCodigos = ALLTRIM(cursor_4c_BuscaLcl.Codigos)
                ENDIF

                *-- Universo VAZIO nao eh ESC do usuario: nao apagar o digitado (regra #50)
                IF USED("cursor_4c_BuscaLcl")
                    loc_lTinhaOpcoes = (RECCOUNT("cursor_4c_BuscaLcl") > 0)
                ENDIF

                IF USED("cursor_4c_BuscaLcl")
                    USE IN cursor_4c_BuscaLcl
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCodigos)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    par_oTxt.Value = loc_cCodigos
                    REPLACE locals WITH loc_cCodigos IN CrSigCdMin
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ELSE
                *-- Legado: If LastKey() <> 27 ... Else This.Value = '' - ESC limpa
                IF LASTKEY() = 27 AND loc_lTinhaOpcoes
                    par_oTxt.Value = ""
                    IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                        REPLACE locals WITH "" IN CrSigCdMin
                        THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupLocal")
        ENDTRY

        *-- repoe a area de trabalho para quem chamou
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC
    *==========================================================================
    * GradeIAfterRowColChange - Atualiza flags de coluna e OptRetiras ao mudar linha
    *==========================================================================
    PROCEDURE GradeIAfterRowColChange(par_nColIndex)

        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        TRY
            LOCAL loc_oGrid, loc_oPg2, loc_oBO, loc_nRetiras
            loc_oBO   = THIS.this_oBusinessObject
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2

            *-- Manter ReadOnly de Tamanho/Cor conforme flags do produto
            loc_oGrid.Column3.ReadOnly = !loc_oBO.this_lTemTam
            loc_oGrid.Column4.ReadOnly = !loc_oBO.this_lTemCor

            *-- Sincronizar OptionGroup Retiravel com linha corrente
            loc_nRetiras = TratarNulo(CrSigCdMin.retiras, "N")
            IF loc_nRetiras < 1 OR loc_nRetiras > 3
                loc_nRetiras = 3
            ENDIF
            loc_oPg2.obj_4c_OptRetiras.Value = loc_nRetiras

            *-- fonte unica da condicao (o When do legado eh reavaliado a cada
            *-- chegada de foco, por isso tambem roda aqui)
            loc_oPg2.cmd_4c_BtnExcluir.Enabled = THIS.PodeExcluirLinhaGrade()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.GradeIAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PodeExcluirLinhaGrade - FONTE UNICA do When do btnExcluir legado:
    *   Return(InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
    *          And !Empty(ThisForm.Pagina.Dados.Get_Produto.Value))
    * Usada pelo AjustarBotoesPorModo, pelo GradeIAfterRowColChange e pelo
    * proprio BtnExcluirLinhaClick - assim as tres nao podem divergir.
    *==========================================================================
    PROCEDURE PodeExcluirLinhaGrade()
        LOCAL loc_lPode
        loc_lPode = .F.

        TRY
            loc_lPode = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
                !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value))
        CATCH TO loc_oErro
            loc_lPode = .F.
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo corrente
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        TRY
            LOCAL loc_oPg1, loc_oPg2, loc_lEdicao
            loc_oPg1    = THIS.pgf_4c_Paginas.Page1
            loc_oPg2    = THIS.pgf_4c_Paginas.Page2
            loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .T.
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .T.
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.

            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.

            *-- btnExcluir do legado fica SEMPRE visivel; quem o inibe eh o When,
            *-- ou seja o Enabled - nao esconder o botao.
            loc_oPg2.cmd_4c_BtnExcluir.Visible = .T.
            loc_oPg2.cmd_4c_BtnExcluir.Enabled = THIS.PodeExcluirLinhaGrade()

            THIS.HabilitarCampos(loc_lEdicao)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirLinhaClick - Exclui a linha corrente do cursor CrSigCdMin
    *==========================================================================
    PROCEDURE BtnExcluirLinhaClick()
        LOCAL loc_cEmps, loc_cCPros, loc_lConfirma, loc_cPergunta, loc_nAreaAnterior
        loc_nAreaAnterior = SELECT()

        IF !USED("CrSigCdMin")
            RETURN
        ENDIF

        *-- Guarda da propria ACAO, nao so do Enabled: um botao que ficou
        *-- habilitado por engano (ex.: em VISUALIZAR) nao pode custar dado.
        IF !THIS.PodeExcluirLinhaGrade()
            RETURN
        ENDIF

        TRY
            SELECT CrSigCdMin

            *-- Legado (btnExcluir.Click): lcEmps = Space(3) e, se a linha corrente
            *-- tem empresa, lcEmps = CrSigCdMin.emps. SEM ALLTRIM: emps eh char(3)
            *-- e o SET EXACT ON do projeto compara com o padding.
            loc_cEmps = SPACE(3)
            IF !EOF("CrSigCdMin") AND !EMPTY(ALLTRIM(CrSigCdMin.emps))
                loc_cEmps = CrSigCdMin.emps
            ENDIF

            IF EMPTY(ALLTRIM(loc_cEmps))
                loc_cPergunta = "Excluir as linhas em branco da grade?"
            ELSE
                loc_cPergunta = "Excluir TODAS as linhas da empresa " + ;
                    ALLTRIM(loc_cEmps) + " nesta grade?"
            ENDIF

            loc_lConfirma = MsgConfirma(loc_cPergunta, "Excluir Linha")

            IF loc_lConfirma
                *-- Legado: Delete From CrSigCdMin Where emps = lcEmps
                *-- Apaga o BLOCO da empresa, nao so a linha corrente.
                *-- SEM PACK: CrSigCdMin vem de SQLEXEC (cursor REMOTO) e PACK
                *-- estoura "Function is not supported on remote tables"; o legado
                *-- tambem nao usa - o SET DELETED ON do config.prg ja esconde.
                DELETE FROM CrSigCdMin WHERE emps = m.loc_cEmps

                *-- Legado: se o cursor ficou vazio, repoe UMA linha em branco
                SELECT CrSigCdMin
                GO TOP
                IF EOF()
                    loc_cCPros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)
                    INSERT INTO CrSigCdMin ;
                        (cpros,      emps, locals, qmins, codtams, codcores, ;
                         ordems,     cidchaves, contas, grupos, qideal, ;
                         retiras,    pideal, pmins) ;
                        VALUES ;
                        (loc_cCPros, "",   "",    0,     "",      "",       ;
                         " ",        "",   "",    "",    0,       ;
                         1,          0,    0)
                ENDIF

                SELECT CrSigCdMin
                GO TOP
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnExcluirLinhaClick")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC

ENDDEFINE
