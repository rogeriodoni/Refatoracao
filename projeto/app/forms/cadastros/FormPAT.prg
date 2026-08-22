*==============================================================================
* FormPAT.prg - Formulario de Pedido de Atendimento
* Migrado de: SIGCDPAT.SCX (frmcadastro)
* Tabela: SigCdPat (pkchaves, emps, datas, codvends, clientes, perguntas, vendconcs)
*==============================================================================

DEFINE CLASS FormPAT AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Pedido de Atendimento"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    MaxButton   = .F.
    Closable    = .F.
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2
    ShowTips    = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, cursor, PageFrame e controles
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("PATBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar PATBO.", "FormPAT")
            ELSE
                *-- Criar cursor vazio para o grid (DataSession=2 isolado)
                CREATE CURSOR cursor_4c_Dados ;
                    (pkchaves C(20), emps C(3), datas T, codvends C(10), ;
                     clientes C(50), perguntas M, vendconcs N(1,0))

                THIS.ConfigurarPageFrame()

                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                    .lbl_4c_Sombra.Caption = THIS.Caption
                    .lbl_4c_Titulo.Caption = THIS.Caption
                    .Visible = .T.
                ENDWITH

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormPAT:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormPAT.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame com 2 paginas (Lista + Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(100, 100, 100)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grade
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (Top=30 para compensar -29 do PageFrame)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top       = 30
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
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
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Top=29, sobrep-se ao cabecalho)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top       = 29
            .Left      =  542
            .Width     = 385
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        *-- Botao Incluir
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

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Excluir
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

        *-- Botao Buscar
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

        *-- Container de Saida (Encerrar)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top       = 29
            .Left      = 917
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
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
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container de Filtros (abaixo do cabecalho, acima do grid)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top       = 114
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 44
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        *-- Label Empresa
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LEmpr", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LEmpr
            .Caption   = "Empresa :"
            .Top       = 12
            .Left      = 71
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Empresa (cod, MaxLength=3, Width=35)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Empr", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Empr
            .Value         = go_4c_Sistema.cCodEmpresa
            .Top           = 10
            .Left          = 124
            .Width         = 35
            .Height        = 23
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Filtro de Empresa"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Empr, "LostFocus", THIS, "ValidarFiltroEmpr")

        *-- Label separador ~
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LSep", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LSep
            .Caption   = "~"
            .Top       = 12
            .Left      = 250
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Inicial
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
            .Value         = DATE() - 30
            .Top           = 10
            .Left          = 163
            .Width         = 78
            .Height        = 23
            .Format        = "K"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Filtro de Data Inicial de Lan" + CHR(231) + "amentos"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni, "LostFocus", THIS, "ValidarFiltroData")

        *-- TextBox Data Final
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim
            .Value         = DATE() + 30
            .Top           = 10
            .Left          = 266
            .Width         = 78
            .Height        = 23
            .Format        = "K"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Filtro de Data Final de Lan" + CHR(231) + "amentos"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim, "LostFocus", THIS, "ValidarFiltroData")

        *-- Grid cursor_4c_Dados
        *-- Top=159 (130 original + 29 offset)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top             = 159
            .Left            = 12
            .Width           = 970
            .Height          = 450
            .RecordSource    = "cursor_4c_Dados"
            .ReadOnly        = .T.
            .DeleteMark      = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .ColumnCount     = 4
            .Visible         = .T.
            .RecordMark   = .F.
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column1
            .ControlSource    = "cursor_4c_Dados.emps"
            .Width            = 80
            .Header1.Caption  = "Empresa"
            .Header1.Alignment = 0
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column2
            .ControlSource    = "cursor_4c_Dados.datas"
            .Width            = 140
            .Header1.Caption  = "Data"
            .Header1.Alignment = 0
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column3
            .ControlSource    = "cursor_4c_Dados.codvends"
            .Width            = 100
            .Header1.Caption  = "Vendedor"
            .Header1.Alignment = 0
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column4
            .ControlSource    = "cursor_4c_Dados.clientes"
            .Width            = 416
            .Header1.Caption  = "Cliente"
            .Header1.Alignment = 0
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos de entrada de dados
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Label + TextBox Data (ReadOnly - preenchido automaticamente)
        *-- Top=163 (134 original + 29 offset)
        loc_oPagina.AddObject("lbl_4c_LDatas", "Label")
        WITH loc_oPagina.lbl_4c_LDatas
            .Caption   = "Data :"
            .Top       = 167
            .Left      = 116
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPagina.txt_4c_Datas
            .Top           = 163
            .Left          = 153
            .Width         = 150
            .Height        = 23
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox Empresa
        *-- Top=193 (164 original + 29 offset)
        loc_oPagina.AddObject("lbl_4c_LEmps", "Label")
        WITH loc_oPagina.lbl_4c_LEmps
            .Caption   = "Empresa :"
            .Top       = 198
            .Left      = 98
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Top           = 193
            .Left          = 153
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "C" + CHR(243) + "digo da Empresa"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Emps, "LostFocus", THIS, "ValidarEmps")

        loc_oPagina.AddObject("txt_4c_DEmps", "TextBox")
        WITH loc_oPagina.txt_4c_DEmps
            .Top           = 193
            .Left          = 191
            .Width         = 422
            .Height        = 23
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Empresa"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DEmps, "LostFocus", THIS, "ValidarDEmps")

        *-- Label + TextBox Vendedor/Conta
        *-- Top=223 (194 original + 29 offset)
        loc_oPagina.AddObject("lbl_4c_LCodvends", "Label")
        WITH loc_oPagina.lbl_4c_LCodvends
            .Caption   = "Conta :"
            .Top       = 229
            .Left      = 110
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codvends", "TextBox")
        WITH loc_oPagina.txt_4c_Codvends
            .Top           = 223
            .Left          = 153
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "C" + CHR(243) + "digo do Vendedor"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Codvends, "LostFocus", THIS, "ValidarCodvends")

        loc_oPagina.AddObject("txt_4c_DVends", "TextBox")
        WITH loc_oPagina.txt_4c_DVends
            .Top           = 223
            .Left          = 240
            .Width         = 373
            .Height        = 23
            .MaxLength     = 50
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o do Vendedor"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DVends, "LostFocus", THIS, "ValidarDVends")

        *-- Label + TextBox Cliente
        *-- Top=253 (224 original + 29 offset)
        loc_oPagina.AddObject("lbl_4c_LClientes", "Label")
        WITH loc_oPagina.lbl_4c_LClientes
            .Caption   = "Cliente :"
            .Top       = 256
            .Left      = 106
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Clientes", "TextBox")
        WITH loc_oPagina.txt_4c_Clientes
            .Top           = 253
            .Left          = 153
            .Width         = 460
            .Height        = 23
            .MaxLength     = 50
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Nome do Cliente"
            .Visible       = .T.
        ENDWITH

        *-- Label + OptionGroup Venda Concluida
        *-- Top=284 (255 original + 29 offset)
        loc_oPagina.AddObject("lbl_4c_LVendconcs", "Label")
        WITH loc_oPagina.lbl_4c_LVendconcs
            .Caption   = "Venda Conclu" + CHR(237) + "da :"
            .Top       = 287
            .Left      = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Vendconcs", "OptionGroup")
        WITH loc_oPagina.opt_4c_Vendconcs
            .Value       = 2
            .Top         = 284
            .Left        = 153
            .Width       = 93
            .Height      = 25
            .AutoSize    = .T.
            .BackStyle   = 0
            .SpecialEffect = 0
            .ButtonCount = 2
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.opt_4c_Vendconcs.Buttons(1)
            .Caption   = "Sim"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
        ENDWITH

        WITH loc_oPagina.opt_4c_Vendconcs.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 5
            .Left      = 51
            .AutoSize  = .T.
            .FontSize  = 8
            .BackStyle = 0
        ENDWITH

        BINDEVENT(loc_oPagina.opt_4c_Vendconcs, "InteractiveChange", THIS, "VendconcsInteractiveChange")

        *-- Label + EditBox Pergunta/Intencao
        *-- Top=317 (288 original + 29 offset)
        loc_oPagina.AddObject("lbl_4c_LPerguntas", "Label")
        WITH loc_oPagina.lbl_4c_LPerguntas
            .Caption   = "Inten" + CHR(231) + CHR(227) + "o :"
            .Top       = 320
            .Left      = 96
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("edt_4c_Perguntas", "EditBox")
        WITH loc_oPagina.edt_4c_Perguntas
            .Top           = 317
            .Left          = 153
            .Width         = 460
            .Height        = 126
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Botoes Confirmar e Cancelar
        loc_oPagina.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Confirmar
            .Caption       = "Confirmar"
            .Top           = 456
            .Left          = 153
            .Width         = 90
            .Height        = 27
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        loc_oPagina.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cancelar
            .Caption       = "Cancelar"
            .Top           = 456
            .Left          = 253
            .Width         = 90
            .Height        = 27
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca dados com filtros da tela
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cFiltro, loc_cEmpr, loc_cDtIni, loc_cDtFim
        LOCAL loc_oPg1
        loc_lSucesso = .F.

        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1

            *-- Ler filtros da tela
            loc_cEmpr  = ""
            loc_cDtIni = ""
            loc_cDtFim = ""

            IF PEMSTATUS(loc_oPg1, "cnt_4c_Filtros", 5)
                WITH loc_oPg1.cnt_4c_Filtros
                    IF PEMSTATUS(.Self, "txt_4c_Empr", 5)
                        loc_cEmpr = ALLTRIM(.txt_4c_Empr.Value)
                    ENDIF
                    IF PEMSTATUS(.Self, "txt_4c_DtIni", 5)
                        IF !EMPTY(.txt_4c_DtIni.Value)
                            loc_cDtIni = FormatarDataSQL(.txt_4c_DtIni.Value)
                        ENDIF
                    ENDIF
                    IF PEMSTATUS(.Self, "txt_4c_DtFim", 5)
                        IF !EMPTY(.txt_4c_DtFim.Value)
                            loc_cDtFim = FormatarDataSQL(.txt_4c_DtFim.Value + 1)
                        ENDIF
                    ENDIF
                    .Visible     = .T.
                ENDWITH
            ENDIF

            *-- Montar filtro SQL
            loc_cFiltro = ""

            IF !EMPTY(loc_cEmpr)
                loc_cFiltro = "emps = " + EscaparSQL(loc_cEmpr)
            ENDIF

            IF !EMPTY(loc_cDtIni) AND !EMPTY(loc_cDtFim)
                IF !EMPTY(loc_cFiltro)
                    loc_cFiltro = loc_cFiltro + " AND "
                ENDIF
                loc_cFiltro = loc_cFiltro + ;
                    "datas >= " + loc_cDtIni + " AND datas < " + loc_cDtFim
            ELSEIF !EMPTY(loc_cDtIni)
                IF !EMPTY(loc_cFiltro)
                    loc_cFiltro = loc_cFiltro + " AND "
                ENDIF
                loc_cFiltro = loc_cFiltro + "datas >= " + loc_cDtIni
            ELSEIF !EMPTY(loc_cDtFim)
                IF !EMPTY(loc_cFiltro)
                    loc_cFiltro = loc_cFiltro + " AND "
                ENDIF
                loc_cFiltro = loc_cFiltro + "datas < " + loc_cDtFim
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)

            IF PEMSTATUS(loc_oPg1, "grd_4c_Dados", 5)
                loc_oPg1.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormPAT.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * IrParaDados - Muda para pagina de dados e carrega registro
    *==========================================================================
    PROTECTED PROCEDURE IrParaDados(par_cModo)
        LOCAL loc_lSucesso, loc_oPg2
        loc_lSucesso = .F.

        TRY
            THIS.this_cModoAtual = par_cModo
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            LOCAL loc_lReadOnly
            loc_lReadOnly = (par_cModo == "VISUALIZAR")
            LOCAL loc_lNovo
            loc_lNovo = (par_cModo == "INCLUIR")

            *-- Carregar dados do cursor para o BO (exceto INCLUIR)
            LOCAL loc_lPodeNavegar
            loc_lPodeNavegar = .T.

            IF !loc_lNovo
                IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                    MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lPodeNavegar = .F.
                ELSE
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
                ENDIF
            ENDIF

            IF !loc_lPodeNavegar
                loc_lSucesso = .F.
            ELSE

            *-- Preencher controles da tela
            THIS.BOParaForm()

            *-- Ajustar ReadOnly conforme modo
            WITH loc_oPg2
                IF PEMSTATUS(.Self, "txt_4c_Datas", 5)
                    .txt_4c_Datas.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Emps", 5)
                    .txt_4c_Emps.ReadOnly = loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_DEmps", 5)
                    .txt_4c_DEmps.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Codvends", 5)
                    .txt_4c_Codvends.ReadOnly = loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_DVends", 5)
                    .txt_4c_DVends.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Clientes", 5)
                    .txt_4c_Clientes.ReadOnly = loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "opt_4c_Vendconcs", 5)
                    .opt_4c_Vendconcs.Enabled = !loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "edt_4c_Perguntas", 5)
                    .edt_4c_Perguntas.ReadOnly = loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "cmd_4c_Confirmar", 5)
                    .cmd_4c_Confirmar.Enabled = !loc_lReadOnly
                ENDIF
            ENDWITH

            *-- Para INCLUIR: pre-preencher empresa atual e data/hora
            IF loc_lNovo
                IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                    loc_oPg2.txt_4c_Emps.Value     = go_4c_Sistema.cCodEmpresa
                    loc_oPg2.txt_4c_Emps.ReadOnly  = .F.
                    loc_oPg2.txt_4c_DEmps.Value    = THIS.this_oBusinessObject.BuscarDescEmpresa(go_4c_Sistema.cCodEmpresa)
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_Datas", 5)
                    loc_oPg2.txt_4c_Datas.Value = TTOC(DATETIME())
                ENDIF
            ENDIF

            THIS.pgf_4c_Paginas.ActivePage = 2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5) AND !loc_lReadOnly
                loc_oPg2.txt_4c_Emps.SetFocus()
            ELSE
                IF PEMSTATUS(loc_oPg2, "cmd_4c_Confirmar", 5) AND loc_lReadOnly
                loc_oPg2.cmd_4c_Confirmar.SetFocus()
                ENDIF
            ENDIF

            loc_lSucesso = .T.

            ENDIF && loc_lPodeNavegar

        CATCH TO loc_oErro
            MsgErro("Erro ao ir para dados:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormPAT.IrParaDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * IrParaLista - Volta para a pagina de lista
    *==========================================================================
    PROTECTED PROCEDURE IrParaLista()
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
        THIS.pgf_4c_Paginas.ActivePage = 1
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Filtros", 5)
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "txt_4c_Empr", 5)
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Empr.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Escreve propriedades do BO nos controles
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            WITH loc_oPg2
                IF PEMSTATUS(.Self, "txt_4c_Datas", 5)
                    IF VARTYPE(loc_oBO.this_tDatas) = "T" AND !EMPTY(loc_oBO.this_tDatas)
                        .txt_4c_Datas.Value = TTOC(loc_oBO.this_tDatas)
                    ELSEIF VARTYPE(loc_oBO.this_tDatas) = "D" AND !EMPTY(loc_oBO.this_tDatas)
                        .txt_4c_Datas.Value = DTOC(loc_oBO.this_tDatas)
                    ELSE
                        .txt_4c_Datas.Value = ""
                    ENDIF
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Emps", 5)
                    .txt_4c_Emps.Value = loc_oBO.this_cEmps
                    .txt_4c_DEmps.Value = IIF(!EMPTY(loc_oBO.this_cEmps), ;
                        loc_oBO.BuscarDescEmpresa(loc_oBO.this_cEmps), "")
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Codvends", 5)
                    .txt_4c_Codvends.Value = loc_oBO.this_cCodvends
                    .txt_4c_DVends.Value = IIF(!EMPTY(loc_oBO.this_cCodvends), ;
                        loc_oBO.BuscarDescVendedor(loc_oBO.this_cCodvends), "")
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Clientes", 5)
                    .txt_4c_Clientes.Value = loc_oBO.this_cClientes
                ENDIF
                IF PEMSTATUS(.Self, "opt_4c_Vendconcs", 5)
                    .opt_4c_Vendconcs.Value = IIF(loc_oBO.this_nVendconcs = 1, 1, 2)
                ENDIF
                IF PEMSTATUS(.Self, "edt_4c_Perguntas", 5)
                    .edt_4c_Perguntas.Value = loc_oBO.this_cPerguntas
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPAT.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Le controles e escreve no BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            WITH loc_oPg2
                IF PEMSTATUS(.Self, "txt_4c_Emps", 5)
                    loc_oBO.this_cEmps = ALLTRIM(.txt_4c_Emps.Value)
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Codvends", 5)
                    loc_oBO.this_cCodvends = ALLTRIM(.txt_4c_Codvends.Value)
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Clientes", 5)
                    loc_oBO.this_cClientes = ALLTRIM(.txt_4c_Clientes.Value)
                ENDIF
                IF PEMSTATUS(.Self, "opt_4c_Vendconcs", 5)
                    loc_oBO.this_nVendconcs = .opt_4c_Vendconcs.Value
                ENDIF
                IF PEMSTATUS(.Self, "edt_4c_Perguntas", 5)
                    loc_oBO.this_cPerguntas = ALLTRIM(.edt_4c_Perguntas.Value)
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPAT.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_oPg2
        loc_lValido = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Cliente obrigatorio
            IF PEMSTATUS(loc_oPg2, "txt_4c_Clientes", 5)
                IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Clientes.Value))
                    MsgAviso("Obrigat" + CHR(243) + "rio Informar o Cliente.", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c_Clientes.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Vendedor obrigatorio
            IF loc_lValido AND PEMSTATUS(loc_oPg2, "txt_4c_Codvends", 5)
                IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codvends.Value))
                    MsgAviso("Obrigat" + CHR(243) + "rio Informar o Vendedor.", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c_Codvends.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPAT.ValidarDados")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Handlers de botoes da pagina Lista
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject.this_cPkchaves  = ""
            THIS.this_oBusinessObject.this_cEmps      = go_4c_Sistema.cCodEmpresa
            THIS.this_oBusinessObject.this_tDatas     = DATETIME()
            THIS.this_oBusinessObject.this_cCodvends  = ""
            THIS.this_oBusinessObject.this_cClientes  = ""
            THIS.this_oBusinessObject.this_cPerguntas = ""
            THIS.this_oBusinessObject.this_nVendconcs = 2

            loc_lSucesso = THIS.IrParaDados("INCLUIR")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPAT.BtnIncluirClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = THIS.IrParaDados("ALTERAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPAT.BtnAlterarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = THIS.IrParaDados("VISUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPAT.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ELSE
                THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")

                IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.this_oBusinessObject.Excluir()

                    IF loc_lSucesso
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                        THIS.IrParaLista()
                    ELSE
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Excluir")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPAT.BtnExcluirClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Handlers de botoes da pagina Dados
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ELSE
                *-- Para INCLUIR: atualizar data/hora
                IF THIS.this_cModoAtual == "INCLUIR"
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Datas", 5)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Datas.Value = TTOC(DATETIME())
                    ENDIF
                ENDIF

                THIS.FormParaBO()

                loc_lSucesso = THIS.this_oBusinessObject.Salvar()

                IF loc_lSucesso
                    THIS.IrParaLista()
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPAT.BtnConfirmarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.IrParaLista()
    ENDPROC

    *==========================================================================
    * Handlers de validacao de filtros (Page1)
    *==========================================================================
    PROCEDURE ValidarFiltroEmpr()
        LOCAL loc_cEmpr, loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg1, "cnt_4c_Filtros", 5)
            RETURN
        ENDIF
        loc_cEmpr = ALLTRIM(loc_oPg1.cnt_4c_Filtros.txt_4c_Empr.Value)
        IF EMPTY(loc_cEmpr)
            MsgAviso("Empresa obrigat" + CHR(243) + "ria.", "Empresa")
            RETURN
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    PROCEDURE ValidarFiltroData()
        LOCAL loc_oPg1, loc_dIni, loc_dFim
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg1, "cnt_4c_Filtros", 5)
            RETURN
        ENDIF
        WITH loc_oPg1.cnt_4c_Filtros
            IF PEMSTATUS(.Self, "txt_4c_DtIni", 5) AND PEMSTATUS(.Self, "txt_4c_DtFim", 5)
                loc_dIni = .txt_4c_DtIni.Value
                loc_dFim = .txt_4c_DtFim.Value
                IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim)
                    IF loc_dIni > loc_dFim
                        .txt_4c_DtFim.Value = loc_dIni
                    ENDIF
                ENDIF
            ENDIF
        ENDWITH
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * Handlers de validacao de campos (Page2)
    *==========================================================================
    PROCEDURE ValidarEmps()
        LOCAL loc_cEmps, loc_cDesc, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
            RETURN
        ENDIF
        loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
        IF EMPTY(loc_cEmps)
            MsgAviso("Empresa obrigat" + CHR(243) + "ria.", "Empresa")
            RETURN
        ENDIF
        loc_cDesc = THIS.this_oBusinessObject.BuscarDescEmpresa(loc_cEmps)
        IF EMPTY(loc_cDesc)
            MsgAviso("Empresa " + CHR(34) + loc_cEmps + CHR(34) + " n" + CHR(227) + "o encontrada.", "Empresa")
            loc_oPg2.txt_4c_Emps.Value  = ""
            loc_oPg2.txt_4c_DEmps.Value = ""
            loc_oPg2.txt_4c_Emps.SetFocus()
        ELSE
            loc_oPg2.txt_4c_DEmps.Value = loc_cDesc
        ENDIF
    ENDPROC

    PROCEDURE ValidarDEmps()
        *-- Descricao e ReadOnly, nao requer validacao
    ENDPROC

    PROCEDURE ValidarCodvends()
        LOCAL loc_cCodvends, loc_cDesc, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "txt_4c_Codvends", 5)
            RETURN
        ENDIF
        loc_cCodvends = ALLTRIM(loc_oPg2.txt_4c_Codvends.Value)
        IF EMPTY(loc_cCodvends)
            loc_oPg2.txt_4c_DVends.Value = ""
            RETURN
        ENDIF
        loc_cDesc = THIS.this_oBusinessObject.BuscarDescVendedor(loc_cCodvends)
        IF EMPTY(loc_cDesc)
            MsgAviso("Vendedor " + CHR(34) + loc_cCodvends + CHR(34) + " n" + CHR(227) + "o encontrado.", "Vendedor")
            loc_oPg2.txt_4c_Codvends.Value = ""
            loc_oPg2.txt_4c_DVends.Value   = ""
            loc_oPg2.txt_4c_Codvends.SetFocus()
        ELSE
            loc_oPg2.txt_4c_DVends.Value = loc_cDesc
        ENDIF
    ENDPROC

    PROCEDURE ValidarDVends()
        *-- Descricao e ReadOnly, nao requer validacao
    ENDPROC

    PROCEDURE VendconcsInteractiveChange()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF PEMSTATUS(loc_oPg2, "opt_4c_Vendconcs", 5)
            IF loc_oPg2.opt_4c_Vendconcs.Value <> 1
                loc_oPg2.opt_4c_Vendconcs.Value = 2
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Handler AfterRowColChange do grid
    *==========================================================================
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        *-- Nenhuma acao necessaria - selecao visual apenas
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_DadosTemp")
            USE IN cursor_4c_DadosTemp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
