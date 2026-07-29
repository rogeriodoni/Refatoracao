*===========================================================================
* Formcnl.prg - Formulario de Contagem de Produtos por Localizacao
* Migrado de: SIGCDCNL (frmcadastro)
* Tabelas   : SigCdCnL (cabecalho) + SigCdCnI (itens/localizacoes)
* Criado em : 2026-07-29
*
* ESTRUTURA DO FORM:
*   Page1 (Lista): grid de contagens + botoes CRUD + botoes especiais
*   Page2 (Dados): campos do cabecalho + grid de itens (GrdLoc) + OptionGroup
*===========================================================================

DEFINE CLASS Formcnl AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Inicializa o formulario
    * DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Formcnl:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("cnlBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object cnlBO", ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Configurar estrutura de paginas
                THIS.ConfigurarPageFrame()

                *-- Propagar titulo para labels do cabecalho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar lista inicial (pular se validando UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista + Dados)
    * PageFrame.Top = -29 oculta as abas (Tabs=.F.)
    * Todos os controles nas Pages precisam compensar +29 no Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            WITH THIS.pgf_4c_Paginas
                .Top       = -29
                .Left      = 0
                .Width     = 1000
                .Height    = 629
                .PageCount = 2
                .Tabs      = .F.
                .Visible   = .T.

                *-- Page1: Lista de contagens
                .Page1.Caption   = "Lista"
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page1.BackColor = RGB(100, 100, 100)

                *-- Page2: Dados da contagem (cabecalho + itens)
                .Page2.Caption   = "Dados"
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.BackColor = RGB(100, 100, 100)
            ENDWITH

            *-- Imagens de fundo das paginas
            THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Configurar conteudo das paginas
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar PageFrame:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD,
    *   botoes especiais (Espelho/Fechar/Abrir) e grid de listagem
    * TOPS compensados (+29 por PageFrame.Top=-29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *--------------------------------------------------------------
            * Container Cabecalho cinza (cntSombra no legado)
            * Original: Top=2 -> Compensado: Top=31
            *--------------------------------------------------------------
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
                .Top       = 15
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .Caption   = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
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
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .Caption   = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *--------------------------------------------------------------
            * Container Botoes CRUD (Grupo_Op no legado) - lado direito
            * Original: Top=0 -> Compensado: Top=29
            *--------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackStyle = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Incluir
            loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
            WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

            *-- Visualizar
            loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

            *-- Alterar
            loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
            WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

            *-- Excluir
            loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

            *-- Buscar
            loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
            WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

            *--------------------------------------------------------------
            * Container Saida - padrao canonico (PREVALECE SOBRE PILAR 1)
            *--------------------------------------------------------------
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
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *--------------------------------------------------------------
            * Botoes especiais do legado: Espelho / Fechar / Abrir
            * Original: Top=82 -> Compensado: Top=111
            * Posicoes: Left=14, 119, 224 (direto na Page1)
            *--------------------------------------------------------------
            loc_oPagina.AddObject("cmd_4c_Espelho", "CommandButton")
            WITH loc_oPagina.cmd_4c_Espelho
                .Caption       = "Espelho"
                .Top           = 111
                .Left          = 14
                .Width         = 105
                .Height        = 40
                .BackColor     = RGB(200, 200, 200)
                .ForeColor     = RGB(90, 90, 90)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .F.
                .Themes        = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_Espelho, "Click", THIS, "BtnEspelhoClick")

            loc_oPagina.AddObject("cmd_4c_Fechar", "CommandButton")
            WITH loc_oPagina.cmd_4c_Fechar
                .Caption       = "Encerrar"
                .Top           = 111
                .Left          = 119
                .Width         = 75
                .Height        = 75
                .BackColor     = RGB(200, 200, 200)
                .ForeColor     = RGB(90, 90, 90)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .F.
                .Themes        = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_Fechar, "Click", THIS, "BtnFecharContagemClick")

            loc_oPagina.AddObject("cmd_4c_Abrir", "CommandButton")
            WITH loc_oPagina.cmd_4c_Abrir
                .Caption       = "Abrir"
                .Top           = 111
                .Left          = 224
                .Width         = 105
                .Height        = 40
                .BackColor     = RGB(200, 200, 200)
                .ForeColor     = RGB(90, 90, 90)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .F.
                .Themes        = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_Abrir, "Click", THIS, "BtnAbrirContagemClick")

            *--------------------------------------------------------------
            * Grid de listagem de contagens
            * Abaixo dos botoes especiais: 111+40+4=155 -> Top=155
            * Width=900 para nao sobrepor cnt_4c_Saida (Left=917)
            *--------------------------------------------------------------
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            loc_oPagina.grd_4c_Dados.RecordSource = ""
            loc_oPagina.grd_4c_Dados.ColumnCount  = 7

            WITH loc_oPagina.grd_4c_Dados
                .Top                = 155
                .Left               = 12
                .Width              = 900
                .Height             = 440
                .FontName           = "Verdana"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .RowHeight          = 18
                .ScrollBars         = 3
                .GridLines          = 3
                .Visible            = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina Lista:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes, campos cabecalho (Fase 5)
    * TOPS compensados (+29 por PageFrame.Top=-29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *--------------------------------------------------------------
            * Container Botoes de Acao (Salvar/Cancelar) - Grupo_Salva no legado
            * Original: Top=4 -> Compensado: Top=33
            *--------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            *-- Confirmar (Salvar)
            loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

            *-- Cancelar
            loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *--------------------------------------------------------------
            * Shape1 - elemento visual decorativo da area de niveis
            * Original: Top=169, Left=626 -> Compensado: Top=198
            *--------------------------------------------------------------
            loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPagina.shp_4c_Shape1
                .Top         = 198
                .Left        = 626
                .Width       = 364
                .Height      = 144
                .BackStyle   = 0
                .BorderWidth = 1
                .BorderColor = RGB(128, 128, 128)
                .Visible     = .T.
            ENDWITH

            *--------------------------------------------------------------
            * Label4 "Codigo :" + txt_4c_Codigo (getCods - somente leitura)
            * Original: Label4.Top=99, getCods.Top=94 -> Compensados: +29
            *--------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPagina.lbl_4c_Label4
                .Caption   = "C" + CHR(243) + "digo : "
                .Top       = 128
                .Left      = 301
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPagina.txt_4c_Codigo
                .Value         = ""
                .Top           = 123
                .Left          = 349
                .Width         = 80
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------
            * Label2 "Vendedor :" + txt_4c_Conta (getConta) + txt_4c_DConta
            * Original: Label2.Top=127, getConta.Top=122, getDConta.Top=122 -> +29
            * getConta: habilitado apenas em INSERIR (When = INSERIR ou CONSULTAR)
            * getDConta: descricao do vendedor - somente leitura
            *--------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "Vendedor : "
                .Top       = 156
                .Left      = 288
                .Width     = 58
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
            WITH loc_oPagina.txt_4c_Conta
                .Value         = ""
                .Top           = 151
                .Left          = 349
                .Width         = 80
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .MaxLength     = 10
                .Enabled       = .T.
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarVendedor")
            BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress",  THIS, "TeclaContaKeyPress")

            loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
            WITH loc_oPagina.txt_4c_DConta
                .Value         = ""
                .Top           = 151
                .Left          = 431
                .Width         = 290
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------
            * Label9 "Ordenacao :" + opt_4c_OptOrdem (4 opcoes)
            * Original: Label9.Top=150, OptOrdem.Top=145 -> Compensados: +29
            * Opcoes: Local / Nv.2 / Nv.3 / Nv.4  (muda ordem do GrdLoc)
            *--------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPagina.lbl_4c_Label9
                .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
                .Top       = 179
                .Left      = 284
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("opt_4c_OptOrdem", "OptionGroup")
            WITH loc_oPagina.opt_4c_OptOrdem
                .ButtonCount = 4
                .Top         = 174
                .Left        = 346
                .Width       = 355
                .Height      = 25
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.
            ENDWITH
            WITH loc_oPagina.opt_4c_OptOrdem.Buttons(1)
                .Caption   = "Local"
                .BackStyle = 0
                .Left      = 5
                .Top       = 3
                .Width     = 60
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oPagina.opt_4c_OptOrdem.Buttons(2)
                .Caption   = "Nv. 2"
                .BackStyle = 0
                .Left      = 90
                .Top       = 3
                .Width     = 60
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oPagina.opt_4c_OptOrdem.Buttons(3)
                .Caption   = "Nv. 3"
                .BackStyle = 0
                .Left      = 180
                .Top       = 3
                .Width     = 60
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oPagina.opt_4c_OptOrdem.Buttons(4)
                .Caption   = "Nv. 4"
                .BackStyle = 0
                .Left      = 270
                .Top       = 3
                .Width     = 60
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            BINDEVENT(loc_oPagina.opt_4c_OptOrdem, "InteractiveChange", THIS, "OptOrdemChanged")

            *--------------------------------------------------------------
            * Label1 "Local :" - cabecalho da area do GrdLoc
            * Original: Top=172 -> Compensado: Top=201
            *--------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "Local : "
                .Top       = 201
                .Left      = 310
                .Width     = 36
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *--------------------------------------------------------------
            * GrdLoc - grid de itens (localizacoes + quantidades contadas)
            * Original: Top=169, Left=349, Width=263, Height=419 -> Top=198
            * Column1: Locals (readonly), Column2: QtdCtg (editavel), Column3: Qtde (readonly)
            *--------------------------------------------------------------
            loc_oPagina.AddObject("grd_4c_GrdLoc", "Grid")
            loc_oPagina.grd_4c_GrdLoc.RecordSource = ""
            loc_oPagina.grd_4c_GrdLoc.ColumnCount  = 3

            WITH loc_oPagina.grd_4c_GrdLoc
                .Top                = 198
                .Left               = 349
                .Width              = 263
                .Height             = 419
                .FontName           = "Verdana"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .RowHeight          = 18
                .ScrollBars         = 2
                .GridLines          = 3
                .Visible            = .T.
            ENDWITH
            WITH loc_oPagina.grd_4c_GrdLoc.Column1
                .Width    = 80
                .ReadOnly = .T.
                .Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH loc_oPagina.grd_4c_GrdLoc.Column2
                .Width    = 60
                .ReadOnly = .F.
                .Header1.Caption = "Qtde."
            ENDWITH
            WITH loc_oPagina.grd_4c_GrdLoc.Column3
                .Width    = 60
                .ReadOnly = .T.
                .Header1.Caption = "Estoque"
            ENDWITH
            BINDEVENT(loc_oPagina.grd_4c_GrdLoc, "AfterRowColChange", THIS, "GrdLocAfterRowColChange")

            *--------------------------------------------------------------
            * Painel direito: codigos e descricoes de cada nivel de localizacao
            * Todos dentro da area do Shape1 (Top=198, Left=626, Width=364, Height=144)
            * Label7 "Base :" / Label6 "Segundo Nivel :" / Label5 "Terceiro Nivel :" / Label3 "Quarto Nivel :"
            *--------------------------------------------------------------

            *-- Label7 "Base :"  Original: Top=192 -> Compensado: Top=221
            loc_oPagina.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPagina.lbl_4c_Label7
                .Caption   = "Base :"
                .Top       = 221
                .Left      = 707
                .Width     = 32
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Base (getBase) - somente leitura; preenchido por GrdLocAfterRowColChange
            loc_oPagina.AddObject("txt_4c_Base", "TextBox")
            WITH loc_oPagina.txt_4c_Base
                .Value         = ""
                .Top           = 216
                .Left          = 743
                .Width         = 54
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_DBase (getDBase) - descricao do nivel Base, somente leitura
            loc_oPagina.AddObject("txt_4c_DBase", "TextBox")
            WITH loc_oPagina.txt_4c_DBase
                .Value         = ""
                .Top           = 216
                .Left          = 799
                .Width         = 174
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- Label6 "Segundo Nivel :"  Original: Top=220 -> Compensado: Top=249
            loc_oPagina.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPagina.lbl_4c_Label6
                .Caption   = "Segundo N" + CHR(237) + "vel :"
                .Top       = 249
                .Left      = 662
                .Width     = 77
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Nvl2 (getNvl2) - somente leitura  Original: Top=215 -> Compensado: Top=244
            loc_oPagina.AddObject("txt_4c_Nvl2", "TextBox")
            WITH loc_oPagina.txt_4c_Nvl2
                .Value         = ""
                .Top           = 244
                .Left          = 743
                .Width         = 54
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_DNvl2 (getDNvl2) - descricao Nivel2, somente leitura
            loc_oPagina.AddObject("txt_4c_DNvl2", "TextBox")
            WITH loc_oPagina.txt_4c_DNvl2
                .Value         = ""
                .Top           = 244
                .Left          = 799
                .Width         = 174
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- Label5 "Terceiro Nivel :"  Original: Top=248 -> Compensado: Top=277
            loc_oPagina.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPagina.lbl_4c_Label5
                .Caption   = "Terceiro N" + CHR(237) + "vel :"
                .Top       = 277
                .Left      = 665
                .Width     = 74
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Nvl3 (getNvl3) - somente leitura  Original: Top=243 -> Compensado: Top=272
            loc_oPagina.AddObject("txt_4c_Nvl3", "TextBox")
            WITH loc_oPagina.txt_4c_Nvl3
                .Value         = ""
                .Top           = 272
                .Left          = 743
                .Width         = 54
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_DNvl3 (getDNvl3) - descricao Nivel3, somente leitura
            loc_oPagina.AddObject("txt_4c_DNvl3", "TextBox")
            WITH loc_oPagina.txt_4c_DNvl3
                .Value         = ""
                .Top           = 272
                .Left          = 799
                .Width         = 174
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- Label3 "Quarto Nivel :"  Original: Top=276 -> Compensado: Top=305
            loc_oPagina.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPagina.lbl_4c_Label3
                .Caption   = "Quarto N" + CHR(237) + "vel :"
                .Top       = 305
                .Left      = 670
                .Width     = 69
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Nvl4 (getNvl4) - somente leitura  Original: Top=271 -> Compensado: Top=300
            loc_oPagina.AddObject("txt_4c_Nvl4", "TextBox")
            WITH loc_oPagina.txt_4c_Nvl4
                .Value         = ""
                .Top           = 300
                .Left          = 743
                .Width         = 54
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_DNvl4 (getDNvl4) - descricao Nivel4, somente leitura
            loc_oPagina.AddObject("txt_4c_DNvl4", "TextBox")
            WITH loc_oPagina.txt_4c_DNvl4
                .Value         = ""
                .Top           = 300
                .Left          = 799
                .Width         = 174
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina Dados:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 e configura colunas
    * Colunas: Cods, Datas, Vends, DesVends, Locals, DLocals, Conferido
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oErro, loc_oGrid, loc_cCursor
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                LOCAL loc_cCursorUI
                loc_cCursorUI = THIS.this_oBusinessObject.this_cCursorDados
                IF USED(loc_cCursorUI)
                    USE IN (loc_cCursorUI)
                ENDIF
                CREATE CURSOR (loc_cCursorUI) (cidchaves C(20), cods C(10), ;
                    conferido N(1,0), datas T, locals C(10), qtds N(5,0), ;
                    vends C(10), emps C(3), desvends C(40), dlocals C(60))
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
                    loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                    loc_oGrid.RecordSource = loc_cCursor
                    loc_oGrid.ColumnCount  = 7

                    loc_oGrid.Column1.ControlSource = loc_cCursor + ".cods"
                    loc_oGrid.Column2.ControlSource = loc_cCursor + ".datas"
                    loc_oGrid.Column3.ControlSource = loc_cCursor + ".vends"
                    loc_oGrid.Column4.ControlSource = loc_cCursor + ".desvends"
                    loc_oGrid.Column5.ControlSource = loc_cCursor + ".locals"
                    loc_oGrid.Column6.ControlSource = loc_cCursor + ".dlocals"
                    loc_oGrid.Column7.ControlSource = loc_cCursor + ".conferido"

                    loc_oGrid.Column1.Width = 80
                    loc_oGrid.Column2.Width = 90
                    loc_oGrid.Column3.Width = 70
                    loc_oGrid.Column4.Width = 200
                    loc_oGrid.Column5.Width = 80
                    loc_oGrid.Column6.Width = 200
                    loc_oGrid.Column7.Width = 60

                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Data"
                    loc_oGrid.Column3.Header1.Caption = "Vendedor"
                    loc_oGrid.Column4.Header1.Caption = "Nome Vendedor"
                    loc_oGrid.Column5.Header1.Caption = "Local"
                    loc_oGrid.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Local"
                    loc_oGrid.Column7.Header1.Caption = "Conferido"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
            ENDIF

            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            THIS.AjustarBotoesPorModo()

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Controls de containers E Pages de PageFrames
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- PageFrame: iterar Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Container/Page: iterar controles filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista (fonte padrao)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inclui nova contagem
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro, loc_oPg2

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()

            *-- Criar cursor vazio para novo registro (colunas que SalvarItens espera)
            IF USED("csSigCdCnI")
                USE IN csSigCdCnI
            ENDIF
            CREATE CURSOR csSigCdCnI (Locals C(10), QtdCtg N(5,0), Qtde N(10,2))

            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
                loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
                loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
                loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
                loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
                loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
                loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
                loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
                loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
                loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
                loc_oPg2.grd_4c_GrdLoc.Refresh()
            ENDIF

            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza contagem selecionada (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Altera contagem selecionada
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.this_nConferido = 1
                        MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        THIS.this_oBusinessObject.EditarRegistro()
                        THIS.this_cModoAtual = "ALTERAR"
                        THIS.BOParaForm()
                        THIS.HabilitarCampos(.T.)
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui contagem selecionada
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.this_nConferido = 1
                        MsgAviso("Contagem J" + CHR(225) + " Encerrada - n" + CHR(227) + "o pode excluir.", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da contagem [" + ;
                                       ALLTRIM(loc_cCodigo) + "] ?", "Exclus" + CHR(227) + "o")
                            IF THIS.this_oBusinessObject.Excluir()
                                MsgSucesso("Contagem exclu" + CHR(237) + "da com sucesso!", "Sucesso")
                                THIS.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre busca de contagens por codigo
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "sigcdcnl", "cursor_4c_BuscaCnl", "cods", "", ;
                "Buscar Contagem")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cods",      "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("conferido", "", "Status")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnl")
                    SELECT cursor_4c_BuscaCnl
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCnl.cods)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCnl")
                USE IN cursor_4c_BuscaCnl
            ENDIF

            IF !EMPTY(loc_cCodigo)
                THIS.CarregarLista()
                IF USED(THIS.this_oBusinessObject.this_cCursorDados)
                    SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                    LOCATE FOR ALLTRIM(cods) == loc_cCodigo
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaCnl")
                USE IN cursor_4c_BuscaCnl
            ENDIF
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnEspelhoClick - Gera espelho do inventario por localizacao
    * Replica logica de cmdEspelho.Click do legado
    *==========================================================================
    PROCEDURE BtnEspelhoClick()
        LOCAL loc_cSQL, loc_oErro, loc_cEmpresa
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED("cursor_4c_Espelho")
                USE IN cursor_4c_Espelho
            ENDIF

            loc_cSQL = "SELECT localizas AS Locals, grupos, contas, empos," + ;
                       " SUM(Qtde) AS qtde, CONVERT(numeric(5,0),0) AS QtdCtg," + ;
                       " SPACE(100) AS Descr" + ;
                       " FROM (" + ;
                       " SELECT localizas, SPACE(10) AS grupos, SPACE(10) AS contas, a.empos," + ;
                       " COUNT(1) AS Qtde" + ;
                       " FROM SigOpEtq A" + ;
                       " LEFT JOIN (SELECT Cpros, Cgrus, Mercs, Colecoes, SGrus" + ;
                       " FROM SigCdPro) B ON b.cpros = a.cpros" + ;
                       " WHERE a.empos = " + EscaparSQL(loc_cEmpresa) + ;
                       " AND a.contas NOT IN ('15000','15001','15002','15003')" + ;
                       " GROUP BY localizas, a.empos" + ;
                       " ) AS dados" + ;
                       " GROUP BY localizas, grupos, contas, empos" + ;
                       " ORDER BY localizas"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Espelho") > 0
                MsgInfo("Espelho gerado com " + LTRIM(STR(RECCOUNT("cursor_4c_Espelho"))) + ;
                        " localiza" + CHR(231) + CHR(245) + "es.", "Espelho")
            ELSE
                MsgErro("Erro ao gerar espelho: " + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao gerar espelho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Espelho")
            USE IN cursor_4c_Espelho
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnFecharContagemClick - Encerra contagem selecionada (Fecha no legado)
    * Legado: Conferido=1 -> Update -> Commit
    *==========================================================================
    PROCEDURE BtnFecharContagemClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.this_nConferido = 1
                        MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF MsgConfirma("Este Contagem ser" + CHR(225) + " Finalizada," + ;
                                       " Deseja encerrar a Contagem ???", ;
                                       "ATEN" + CHR(199) + CHR(195) + "O !!!")
                            IF THIS.this_oBusinessObject.FecharContagem(loc_cCodigo)
                                THIS.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao fechar contagem:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAbrirContagemClick - Reabre contagem encerrada (Abre no legado)
    * Legado: Conferido=0 -> Update -> Commit
    *==========================================================================
    PROCEDURE BtnAbrirContagemClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.this_nConferido = 0
                        MsgAviso("Contagem N" + CHR(227) + "o est" + CHR(225) + " Encerrada !!!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF MsgConfirma("Este Contagem ser" + CHR(225) + " Aberta Novamente," + ;
                                       " Deseja Continuar a Contagem ???", ;
                                       "ATEN" + CHR(199) + CHR(195) + "O !!!")
                            IF THIS.this_oBusinessObject.ReobrirContagem(loc_cCodigo)
                                THIS.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao reabrir contagem:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do formulario
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro, loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cVends)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                loc_oPg2.txt_4c_DConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesVends)
            ENDIF

            *-- Resetar ordenacao ao carregar registro
            IF PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
                loc_oPg2.opt_4c_OptOrdem.Value = 1
            ENDIF

            *-- Carregar itens (csSigCdCnI) via SQL com aliasing correto para SalvarItens
            IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
                LOCAL loc_cSQLItens
                loc_cSQLItens = "SELECT locals AS Locals, qtds AS QtdCtg, estoque AS Qtde" + ;
                                " FROM sigcdcni WHERE cods = " + ;
                                EscaparSQL(THIS.this_oBusinessObject.this_cCodigo) + ;
                                " ORDER BY locals"
                IF USED("csSigCdCnI")
                    USE IN csSigCdCnI
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQLItens, "csSigCdCnI") > 0
                    SELECT csSigCdCnI
                    GO TOP
                    IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
                        loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
                        loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
                        loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
                        loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
                        loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
                        loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
                        loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
                        loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
                        loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
                        loc_oPg2.grd_4c_GrdLoc.Refresh()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do formulario para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro, loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                THIS.this_oBusinessObject.this_cVends = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos editaveis por modo
    * getCods  : sempre somente leitura (codigo gerado automaticamente)
    * getConta : habilitado apenas em INCLUIR (When legado: INSERIR ou CONSULTAR)
    * getDConta: sempre somente leitura (descricao preenchida pelo lookup)
    * OptOrdem : habilitado em INCLUIR e ALTERAR
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oErro, loc_oPg2, loc_lModoIncluir, loc_lModoEdicao

        TRY
            loc_oPg2        = THIS.pgf_4c_Paginas.Page2
            loc_lModoIncluir = (THIS.this_cModoAtual = "INCLUIR")
            loc_lModoEdicao  = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")

            *-- Codigo: sempre desabilitado (gerado pelo sistema)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Enabled = .F.
            ENDIF

            *-- Vendedor: apenas em INCLUIR (conforme When legado)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.Enabled = (par_lHabilitar AND loc_lModoIncluir)
            ENDIF

            *-- Descricao vendedor: sempre somente leitura
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                loc_oPg2.txt_4c_DConta.Enabled = .F.
            ENDIF

            *-- Ordenacao: habilitada em edicao quando ha itens carregados
            IF PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
                loc_oPg2.opt_4c_OptOrdem.Enabled = (par_lHabilitar AND loc_lModoEdicao)
            ENDIF

            *-- Grid de localizacoes: coluna Qtde. editavel apenas em INCLUIR/ALTERAR
            IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
                loc_oPg2.grd_4c_GrdLoc.Column2.ReadOnly = !(par_lHabilitar AND loc_lModoEdicao)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos do formulario
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro, loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                loc_oPg2.txt_4c_DConta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
                loc_oPg2.opt_4c_OptOrdem.Value = 1
            ENDIF

            *-- Campos de nivel de localizacao (painel direito)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Base", 5)
                loc_oPg2.txt_4c_Base.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DBase", 5)
                loc_oPg2.txt_4c_DBase.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl2", 5)
                loc_oPg2.txt_4c_Nvl2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl2", 5)
                loc_oPg2.txt_4c_DNvl2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl3", 5)
                loc_oPg2.txt_4c_Nvl3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl3", 5)
                loc_oPg2.txt_4c_DNvl3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl4", 5)
                loc_oPg2.txt_4c_Nvl4.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl4", 5)
                loc_oPg2.txt_4c_DNvl4.Value = ""
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva a contagem (Confirmar)
    * Valida campos obrigatorios fora do TRY conforme regra critica
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro, loc_oPg2, loc_cVend

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cVend = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
            loc_cVend = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
        ENDIF

        IF EMPTY(loc_cVend)
            MsgAviso("Vendedor obrigat" + CHR(243) + "rio!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.SetFocus()
            ENDIF
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                *-- Salvar itens de localizacao (csSigCdCnI) apos cabecalho
                IF USED("csSigCdCnI")
                    THIS.this_oBusinessObject.SalvarItens("csSigCdCnI", ;
                        THIS.this_oBusinessObject.this_cCodigo)
                ENDIF
                MsgSucesso("Contagem salva com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            IF USED("csSigCdCnI")
                USE IN csSigCdCnI
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro("Erro ao cancelar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OptOrdemChanged - Muda ordenacao do GrdLoc ao trocar opcao no OptionGroup
    * Replica OptOrdem.Valid do legado: SET ORDER TO {Locals/Nivel2s/Nivel3s/Nivel4s}
    *==========================================================================
    PROCEDURE OptOrdemChanged()
        LOCAL loc_oErro, loc_nOrdem, loc_oPg2, loc_lContinuar

        loc_lContinuar = .T.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF !PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar

            loc_nOrdem = loc_oPg2.opt_4c_OptOrdem.Value

            IF USED("csSigCdCnI")
                SELECT csSigCdCnI
                SET ORDER TO
                DO CASE
                CASE loc_nOrdem = 1
                    SET ORDER TO Locals
                CASE loc_nOrdem = 2
                    SET ORDER TO Nivel2s
                CASE loc_nOrdem = 3
                    SET ORDER TO Nivel3s
                CASE loc_nOrdem = 4
                    SET ORDER TO Nivel4s
                ENDCASE
                GO TOP IN csSigCdCnI

                *-- Atualizar grid de itens (adicionado na Fase 6)
                IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
                    loc_oPg2.grd_4c_GrdLoc.Refresh()
                ENDIF
            ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ordenar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarVendedor - Valida campo getConta (Vendedor) via SQL + lookup
    * Replica getConta.Valid do legado (busca em SigCdCli)
    * Preenche txt_4c_DConta com nome do vendedor encontrado
    *==========================================================================
    PROCEDURE ValidarVendedor
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oErro, loc_oPg2, loc_cVend, loc_cSQL, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
            RETURN
        ENDIF

        loc_cVend = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)

        IF EMPTY(loc_cVend)
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                loc_oPg2.txt_4c_DConta.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT a.iclis, a.rclis, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND a.iclis = " + EscaparSQL(loc_cVend)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidVend") > 0 AND ;
               RECCOUNT("cursor_4c_ValidVend") > 0
                SELECT cursor_4c_ValidVend
                IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                    loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidVend.rclis)
                ENDIF
                THIS.this_oBusinessObject.this_cVends    = loc_cVend
                THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_ValidVend.rclis)
            ELSE
                *-- Nao encontrado: abrir FormBuscaAuxiliar para selecao
                IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                    loc_oPg2.txt_4c_DConta.Value = ""
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaVend", "iclis", loc_cVend, ;
                    "Vendedor")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
                        SELECT cursor_4c_BuscaVend
                        loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaVend.iclis)
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                            loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaVend.rclis)
                        ENDIF
                        THIS.this_oBusinessObject.this_cVends    = ALLTRIM(cursor_4c_BuscaVend.iclis)
                        THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_BuscaVend.rclis)
                    ELSE
                        loc_oPg2.txt_4c_Conta.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaVend")
                    USE IN cursor_4c_BuscaVend
                ENDIF
            ENDIF

            IF USED("cursor_4c_ValidVend")
                USE IN cursor_4c_ValidVend
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_ValidVend")
                USE IN cursor_4c_ValidVend
            ENDIF
            MsgErro("Erro ao validar vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaContaKeyPress - Intercepta F4 em txt_4c_Conta para abrir lookup
    *==========================================================================
    PROCEDURE TeclaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.ValidarVendedor()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdLocAfterRowColChange - Atualiza painel de niveis ao navegar no GrdLoc
    * Parseia Locals (10 chars) em 4 niveis: Base(1,2) Nvl2(3,2) Nvl3(5,2) Nvl4(7,3)
    *==========================================================================
    PROCEDURE GrdLocAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro, loc_oPg2, loc_cLocal, loc_cBase, loc_cNvl2, loc_cNvl3, loc_cNvl4, loc_lContinuar

        loc_lContinuar = .T.
        TRY
            IF !USED("csSigCdCnI") OR EOF("csSigCdCnI")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar

            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cLocal = ALLTRIM(csSigCdCnI.Locals)
            loc_cBase  = ""
            loc_cNvl2  = ""
            loc_cNvl3  = ""
            loc_cNvl4  = ""

            IF LEN(loc_cLocal) >= 2
                loc_cBase = SUBSTR(loc_cLocal, 1, 2)
            ENDIF
            IF LEN(loc_cLocal) >= 4
                loc_cNvl2 = SUBSTR(loc_cLocal, 3, 2)
            ENDIF
            IF LEN(loc_cLocal) >= 6
                loc_cNvl3 = SUBSTR(loc_cLocal, 5, 2)
            ENDIF
            IF LEN(loc_cLocal) >= 9
                loc_cNvl4 = SUBSTR(loc_cLocal, 7, 3)
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Base", 5)
                loc_oPg2.txt_4c_Base.Value = loc_cBase
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DBase", 5)
                loc_oPg2.txt_4c_DBase.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl2", 5)
                loc_oPg2.txt_4c_Nvl2.Value = loc_cNvl2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl2", 5)
                loc_oPg2.txt_4c_DNvl2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl3", 5)
                loc_oPg2.txt_4c_Nvl3.Value = loc_cNvl3
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl3", 5)
                loc_oPg2.txt_4c_DNvl3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl4", 5)
                loc_oPg2.txt_4c_Nvl4.Value = loc_cNvl4
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl4", 5)
                loc_oPg2.txt_4c_DNvl4.Value = ""
            ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em GrdLocAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo atual
    * LISTA: todos os botoes habilitados
    * INCLUIR/ALTERAR/VISUALIZAR: botoes CRUD desabilitados (usuario esta em Page2)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro, loc_oPg1, loc_lEmLista

        TRY
            loc_oPg1    = THIS.pgf_4c_Paginas.Page1
            loc_lEmLista = (THIS.this_cModoAtual = "LISTA")

            IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = loc_lEmLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = loc_lEmLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = loc_lEmLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = loc_lEmLista
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oPg1, "cmd_4c_Espelho", 5)
                loc_oPg1.cmd_4c_Espelho.Enabled = loc_lEmLista
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_Fechar", 5)
                loc_oPg1.cmd_4c_Fechar.Enabled  = loc_lEmLista
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_Abrir", 5)
                loc_oPg1.cmd_4c_Abrir.Enabled   = loc_lEmLista
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF USED("csSigCdCnI")
                USE IN csSigCdCnI
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            DODEFAULT()

        CATCH TO loc_oErro
            MsgErro("Erro ao fechar formul" + CHR(225) + "rio:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
            DODEFAULT()
        ENDTRY
    ENDPROC

ENDDEFINE
