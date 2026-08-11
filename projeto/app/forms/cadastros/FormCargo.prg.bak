*==============================================================================
* FormCargo.prg
* Formulario de Cadastro de Cargos (SIGCDCRG)
*
* Tabela principal: SIGCDCRG (ccargs PK)
* Sub-tabelas: SIGCRRCC (acesso financeiro), sigcarct (categorias)
* Tipo: CRUD (frmcadastro)
* BO: CargoBO
*==============================================================================

DEFINE CLASS FormCargo AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Cargos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

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
            MsgErro(loc_oErro.Message, "FormCargo.Init")
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
            THIS.this_oBusinessObject = CREATEOBJECT("CargoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar CargoBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.InicializarForm")
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
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, grid lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
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

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90)
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

        *-- Grid lista: ccargs (Cargo) + dcargs (Descricao)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.RecordSource = ""
        loc_oPg1.grd_4c_Lista.ColumnCount  = 2

        WITH loc_oPg1.grd_4c_Lista
            .Top                     = 117
            .Left                    = 12
            .Width                   = 890
            .Height                  = 480
            .FontName                = "Verdana"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 16
            .ScrollBars              = 2
            .GridLines               = 3
            .ReadOnly                = .T.
            .Visible                 = .T.
            .Column1.Width           = 100
            .Column2.Width           = 760
            .Column1.ReadOnly        = .T.
            .Column2.ReadOnly        = .T.
            .Column1.Header1.Caption = "Cargo"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: todos os campos, grids e botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao, loc_oGridAcesso, loc_oGridCat
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Botoes Confirmar/Cancelar
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
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

        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *======================================================================
        * LINHA 1: Cargo + Senha
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbCargo", "Label")
        WITH loc_oPg2.lbl_4c_LbCargo
            .Caption   = "Cargo :"
            .Top       = 51
            .Left      = 212
            .Width     = 38
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Ccargs", "TextBox")
        WITH loc_oPg2.txt_4c_Ccargs
            .Value         = ""
            .Top           = 47
            .Left          = 252
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        *-- Botao busca template (cmdGarqicone: abre picker p/ copiar cargo base)
        loc_oPg2.AddObject("cmd_4c_BuscarBase", "CommandButton")
        WITH loc_oPg2.cmd_4c_BuscarBase
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
            .PicturePosition = 0
            .Top             = 47
            .Left            = 335
            .Width           = 22
            .Height          = 22
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.cmd_4c_BuscarBase, "Click", THIS, "BtnBuscarBaseClick")

        loc_oPg2.AddObject("lbl_4c_LbSenha", "Label")
        WITH loc_oPg2.lbl_4c_LbSenha
            .Caption   = "Senha :"
            .Top       = 50
            .Left      = 578
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nivels", "TextBox")
        WITH loc_oPg2.txt_4c_Nivels
            .Value         = ""
            .Top           = 46
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbSenhaSN", "Label")
        WITH loc_oPg2.lbl_4c_LbSenhaSN
            .Caption   = "(S/N)"
            .Top       = 50
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * LINHA 2: Descricao + Altera Cotacao
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbDescr", "Label")
        WITH loc_oPg2.lbl_4c_LbDescr
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 76
            .Left      = 195
            .Width     = 55
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Dcargs", "TextBox")
        WITH loc_oPg2.txt_4c_Dcargs
            .Value         = ""
            .Top           = 72
            .Left          = 252
            .Width         = 155
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 20
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbAltCot", "Label")
        WITH loc_oPg2.lbl_4c_LbAltCot
            .Caption   = "Altera Cota" + CHR(231) + CHR(227) + "o :"
            .Top       = 75
            .Left      = 536
            .Width     = 82
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Altcots", "TextBox")
        WITH loc_oPg2.txt_4c_Altcots
            .Value         = ""
            .Top           = 71
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbAltCotSN", "Label")
        WITH loc_oPg2.lbl_4c_LbAltCotSN
            .Caption   = "(S/N)"
            .Top       = 75
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * LINHA 3: Limite Desconto + Libera Limite
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbLimDesc", "Label")
        WITH loc_oPg2.lbl_4c_LbLimDesc
            .Caption   = "Limite Desconto :"
            .Top       = 101
            .Left      = 166
            .Width     = 84
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Limdescs", "TextBox")
        WITH loc_oPg2.txt_4c_Limdescs
            .Value         = 0
            .Top           = 97
            .Left          = 252
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "99999999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Descpors", "TextBox")
        WITH loc_oPg2.txt_4c_Descpors
            .Value         = 0
            .Top           = 97
            .Left          = 362
            .Width         = 45
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbDescPct", "Label")
        WITH loc_oPg2.lbl_4c_LbDescPct
            .Caption   = "(%)"
            .Top       = 101
            .Left      = 410
            .Width     = 25
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibLim", "Label")
        WITH loc_oPg2.lbl_4c_LbLibLim
            .Caption   = "Libera Limite :"
            .Top       = 100
            .Left      = 549
            .Width     = 68
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Limites", "TextBox")
        WITH loc_oPg2.txt_4c_Limites
            .Value         = ""
            .Top           = 96
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibLimSN", "Label")
        WITH loc_oPg2.lbl_4c_LbLibLimSN
            .Caption   = "(S/N)"
            .Top       = 100
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * LINHA 4: Limite Acrescimo + Cancela Item Cupom
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbLimAcre", "Label")
        WITH loc_oPg2.lbl_4c_LbLimAcre
            .Caption   = "Limite Acr" + CHR(233) + "scimo :"
            .Top       = 126
            .Left      = 163
            .Width     = 87
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Limacres", "TextBox")
        WITH loc_oPg2.txt_4c_Limacres
            .Value         = 0
            .Top           = 122
            .Left          = 252
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "99999999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Acrepors", "TextBox")
        WITH loc_oPg2.txt_4c_Acrepors
            .Value         = 0
            .Top           = 122
            .Left          = 362
            .Width         = 45
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbAcrePct", "Label")
        WITH loc_oPg2.lbl_4c_LbAcrePct
            .Caption   = "(%)"
            .Top       = 126
            .Left      = 410
            .Width     = 25
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbCancItem", "Label")
        WITH loc_oPg2.lbl_4c_LbCancItem
            .Caption   = "Cancela Item Cupom Fiscal:"
            .Top       = 125
            .Left      = 483
            .Width     = 135
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Cancitens", "TextBox")
        WITH loc_oPg2.txt_4c_Cancitens
            .Value         = ""
            .Top           = 121
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbCancSN", "Label")
        WITH loc_oPg2.lbl_4c_LbCancSN
            .Caption   = "(S/N)"
            .Top       = 125
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * LINHA 5: Liberar Pagamentos + Excluir Cond Pagto
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbVlPag", "Label")
        WITH loc_oPg2.lbl_4c_LbVlPag
            .Caption   = "Liberar Pagamentos at" + CHR(233) + " :"
            .Top       = 151
            .Left      = 127
            .Width     = 123
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Vllibpgs", "TextBox")
        WITH loc_oPg2.txt_4c_Vllibpgs
            .Value         = 0
            .Top           = 147
            .Left          = 252
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "99999999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbVlPagRS", "Label")
        WITH loc_oPg2.lbl_4c_LbVlPagRS
            .Caption   = "(R$)"
            .Top       = 151
            .Left      = 365
            .Width     = 30
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibFpag", "Label")
        WITH loc_oPg2.lbl_4c_LbLibFpag
            .Caption   = "Excluir Condi" + CHR(231) + CHR(227) + "o Pagto (ecf):"
            .Top       = 150
            .Left      = 476
            .Width     = 142
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Libfpags", "TextBox")
        WITH loc_oPg2.txt_4c_Libfpags
            .Value         = ""
            .Top           = 146
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibFpagSN", "Label")
        WITH loc_oPg2.lbl_4c_LbLibFpagSN
            .Caption   = "(S/N)"
            .Top       = 150
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * LINHA 6: Liberar Cotacoes + Libera Saldo Insuficiente
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbVlCot", "Label")
        WITH loc_oPg2.lbl_4c_LbVlCot
            .Caption   = "Liberar Cota" + CHR(231) + CHR(245) + "es at" + CHR(233) + " :"
            .Top       = 176
            .Left      = 141
            .Width     = 109
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Vllibcots", "TextBox")
        WITH loc_oPg2.txt_4c_Vllibcots
            .Value         = 0
            .Top           = 172
            .Left          = 252
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "99999999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbVlCotRS", "Label")
        WITH loc_oPg2.lbl_4c_LbVlCotRS
            .Caption   = "(R$)"
            .Top       = 176
            .Left      = 365
            .Width     = 30
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbSdIns", "Label")
        WITH loc_oPg2.lbl_4c_LbSdIns
            .Caption   = "Libera Saldo Insuficiente :"
            .Top       = 175
            .Left      = 491
            .Width     = 127
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Libsdins", "TextBox")
        WITH loc_oPg2.txt_4c_Libsdins
            .Value         = ""
            .Top           = 171
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbSdInsSN", "Label")
        WITH loc_oPg2.lbl_4c_LbSdInsSN
            .Caption   = "(S/N)"
            .Top       = 175
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * LINHA 7: Liberar Movimentacoes + Liberar Cond Pagto
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbVlOps", "Label")
        WITH loc_oPg2.lbl_4c_LbVlOps
            .Caption   = "Liberar Movimenta" + CHR(231) + CHR(245) + "es at" + CHR(233) + " :"
            .Top       = 201
            .Left      = 112
            .Width     = 138
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Vllibopes", "TextBox")
        WITH loc_oPg2.txt_4c_Vllibopes
            .Value         = 0
            .Top           = 197
            .Left          = 252
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "99999999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbVlOpsRS", "Label")
        WITH loc_oPg2.lbl_4c_LbVlOpsRS
            .Caption   = "(R$)"
            .Top       = 201
            .Left      = 365
            .Width     = 30
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibFpgs", "Label")
        WITH loc_oPg2.lbl_4c_LbLibFpgs
            .Caption   = "Liberar Condi" + CHR(231) + CHR(227) + "o Pagto :"
            .Top       = 200
            .Left      = 497
            .Width     = 121
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Libfpgs", "TextBox")
        WITH loc_oPg2.txt_4c_Libfpgs
            .Value         = ""
            .Top           = 196
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibFpgsSN", "Label")
        WITH loc_oPg2.lbl_4c_LbLibFpgsSN
            .Caption   = "(S/N)"
            .Top       = 200
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * LINHA 8: Variacao Cotacao + Liberar Movs Estoque
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbVarCot", "Label")
        WITH loc_oPg2.lbl_4c_LbVarCot
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o Cota" + CHR(231) + CHR(227) + "o :"
            .Top       = 226
            .Left      = 157
            .Width     = 93
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Varcots", "TextBox")
        WITH loc_oPg2.txt_4c_Varcots
            .Value         = 0
            .Top           = 222
            .Left          = 252
            .Width         = 52
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbVarCotPct", "Label")
        WITH loc_oPg2.lbl_4c_LbVarCotPct
            .Caption   = "(%)"
            .Top       = 226
            .Left      = 309
            .Width     = 25
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibOpes", "Label")
        WITH loc_oPg2.lbl_4c_LbLibOpes
            .Caption   = "Liberar Movimenta" + CHR(231) + CHR(245) + "es de Estoque :"
            .Top       = 225
            .Left      = 441
            .Width     = 177
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Libopes", "TextBox")
        WITH loc_oPg2.txt_4c_Libopes
            .Value         = ""
            .Top           = 221
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibOpesSN", "Label")
        WITH loc_oPg2.lbl_4c_LbLibOpesSN
            .Caption   = "(S/N)"
            .Top       = 225
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * LINHA 9: Grupo Financeiro + Libera Excluir Mov Producao
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbGrupo", "Label")
        WITH loc_oPg2.lbl_4c_LbGrupo
            .Caption   = "Grupo Financeiro :"
            .Top       = 251
            .Left      = 160
            .Width     = 90
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Grcomis", "TextBox")
        WITH loc_oPg2.txt_4c_Grcomis
            .Value         = ""
            .Top           = 247
            .Left          = 252
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Grcomis, "KeyPress", THIS, "BuscarGrupoFinan")

        loc_oPg2.AddObject("lbl_4c_LbLibExprd", "Label")
        WITH loc_oPg2.lbl_4c_LbLibExprd
            .Caption   = "Libera Excluir Movimenta" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o :"
            .Top       = 250
            .Left      = 410
            .Width     = 208
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Libexprd", "TextBox")
        WITH loc_oPg2.txt_4c_Libexprd
            .Value         = ""
            .Top           = 246
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibExprdSN", "Label")
        WITH loc_oPg2.lbl_4c_LbLibExprdSN
            .Caption   = "(S/N)"
            .Top       = 250
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * LINHA 10: Fator Comissao (tipo S/N + valor %)
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbFcomis", "Label")
        WITH loc_oPg2.lbl_4c_LbFcomis
            .Caption   = "Fator de Comiss" + CHR(227) + "o :"
            .Top       = 275
            .Left      = 519
            .Width     = 99
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Fcomis", "TextBox")
        WITH loc_oPg2.txt_4c_Fcomis
            .Value         = ""
            .Top           = 271
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbFcomisSN", "Label")
        WITH loc_oPg2.lbl_4c_LbFcomisSN
            .Caption   = "(S/N)"
            .Top       = 275
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Acomis", "TextBox")
        WITH loc_oPg2.txt_4c_Acomis
            .Value         = 0
            .Top           = 271
            .Left          = 680
            .Width         = 52
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "9999.99"
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Acomis, "KeyPress", THIS, "ValidarAcomis")

        loc_oPg2.AddObject("lbl_4c_LbAcomisPct", "Label")
        WITH loc_oPg2.lbl_4c_LbAcomisPct
            .Caption   = "(%)"
            .Top       = 275
            .Left      = 737
            .Width     = 25
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * OPTION GROUPS - Esquerda (2 botoes: Sim/Nao)
        *======================================================================

        *-- Libera Produtos Bloqueados (libleilaos)
        loc_oPg2.AddObject("lbl_4c_LbLibleilaos", "Label")
        WITH loc_oPg2.lbl_4c_LbLibleilaos
            .Caption   = "Libera Produtos Bloqueados :"
            .Top       = 276
            .Left      = 108
            .Width     = 138
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("opt_4c_Libleilaos", "OptionGroup")
        WITH loc_oPg2.opt_4c_Libleilaos
            .ButtonCount = 2
            .Top         = 272
            .Left        = 247
            .Width       = 89
            .Height      = 22
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .Left      = 2
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .Left      = 46
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Libera Duplicidade (libdupends)
        loc_oPg2.AddObject("lbl_4c_LbLibdupends", "Label")
        WITH loc_oPg2.lbl_4c_LbLibdupends
            .Caption   = "Libera Duplicidade :"
            .Top       = 296
            .Left      = 155
            .Width     = 91
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("opt_4c_Libdupends", "OptionGroup")
        WITH loc_oPg2.opt_4c_Libdupends
            .ButtonCount = 2
            .Top         = 292
            .Left        = 247
            .Width       = 89
            .Height      = 22
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .Left      = 2
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .Left      = 46
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *======================================================================
        * LINHA 11: Comissao + Tipo Comissao (direita)
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbComis", "Label")
        WITH loc_oPg2.lbl_4c_LbComis
            .Caption   = "Comiss" + CHR(227) + "o :"
            .Top       = 299
            .Left      = 563
            .Width     = 55
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Comis", "TextBox")
        WITH loc_oPg2.txt_4c_Comis
            .Value         = 0
            .Top           = 295
            .Left          = 619
            .Width         = 52
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbComisPct", "Label")
        WITH loc_oPg2.lbl_4c_LbComisPct
            .Caption   = "(%)"
            .Top       = 299
            .Left      = 675
            .Width     = 25
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbTpComis", "Label")
        WITH loc_oPg2.lbl_4c_LbTpComis
            .Caption   = "Tipo : "
            .Top       = 296
            .Left      = 719
            .Width     = 32
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Tipo Comissao (3 botoes: Venda, Caixa, O.S.)
        loc_oPg2.AddObject("opt_4c_Tpcomis", "OptionGroup")
        WITH loc_oPg2.opt_4c_Tpcomis
            .ButtonCount = 3
            .Top         = 292
            .Left        = 749
            .Width       = 141
            .Height      = 21
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Venda"
                .Left      = 2
                .Top       = 2
                .Width     = 44
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Caixa"
                .Left      = 48
                .Top       = 2
                .Width     = 44
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "O.S."
                .Left      = 94
                .Top       = 2
                .Width     = 44
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Libera Variacao de Custo (custoprod)
        loc_oPg2.AddObject("lbl_4c_LbCustoprod", "Label")
        WITH loc_oPg2.lbl_4c_LbCustoprod
            .Caption   = "Libera Varia" + CHR(231) + CHR(227) + "o de Custo :"
            .Top       = 317
            .Left      = 122
            .Width     = 124
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("opt_4c_Custoprod", "OptionGroup")
        WITH loc_oPg2.opt_4c_Custoprod
            .ButtonCount = 2
            .Top         = 313
            .Left        = 247
            .Width       = 89
            .Height      = 22
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .Left      = 2
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .Left      = 46
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Variacao Mov Dupla (varmovdup)
        loc_oPg2.AddObject("lbl_4c_LbVarMovDup", "Label")
        WITH loc_oPg2.lbl_4c_LbVarMovDup
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o Mov. Dupla :"
            .Top       = 326
            .Left      = 510
            .Width     = 108
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Varmovdup", "TextBox")
        WITH loc_oPg2.txt_4c_Varmovdup
            .Value         = 0
            .Top           = 320
            .Left          = 619
            .Width         = 52
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbVarMovDupPct", "Label")
        WITH loc_oPg2.lbl_4c_LbVarMovDupPct
            .Caption   = "(%)"
            .Top       = 324
            .Left      = 676
            .Width     = 25
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Libera Valor Max Malote (libValMMax)
        loc_oPg2.AddObject("lbl_4c_LbLibValmmax", "Label")
        WITH loc_oPg2.lbl_4c_LbLibValmmax
            .Caption   = "Libera Valor Max. Malote :"
            .Top       = 338
            .Left      = 123
            .Width     = 123
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("opt_4c_LibValmmax", "OptionGroup")
        WITH loc_oPg2.opt_4c_LibValmmax
            .ButtonCount = 2
            .Top         = 334
            .Left        = 247
            .Width       = 89
            .Height      = 22
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .Left      = 2
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .Left      = 46
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Liberar Variacao Mov Dupla (libvmovdup)
        loc_oPg2.AddObject("lbl_4c_LbLibVMovDup", "Label")
        WITH loc_oPg2.lbl_4c_LbLibVMovDup
            .Caption   = "Liberar Varia" + CHR(231) + CHR(227) + "o Mov. Dupla :"
            .Top       = 350
            .Left      = 474
            .Width     = 144
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Libvmovdup", "TextBox")
        WITH loc_oPg2.txt_4c_Libvmovdup
            .Value         = ""
            .Top           = 346
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbLibVMovDupSN", "Label")
        WITH loc_oPg2.lbl_4c_LbLibVMovDupSN
            .Caption   = "(S/N)"
            .Top       = 350
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Liberar Titulos Iguais (libduptits)
        loc_oPg2.AddObject("lbl_4c_LbLibduptits", "Label")
        WITH loc_oPg2.lbl_4c_LbLibduptits
            .Caption   = "Liberar T" + CHR(237) + "tulos Iguais :"
            .Top       = 356
            .Left      = 142
            .Width     = 104
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("opt_4c_Libduptits", "OptionGroup")
        WITH loc_oPg2.opt_4c_Libduptits
            .ButtonCount = 2
            .Top         = 352
            .Left        = 247
            .Width       = 89
            .Height      = 22
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .Left      = 2
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .Left      = 46
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Libera Prazo de Entrega (libprzes)
        loc_oPg2.AddObject("lbl_4c_LbLibprzes", "Label")
        WITH loc_oPg2.lbl_4c_LbLibprzes
            .Caption   = "Libera Prazo de Entrega :"
            .Top       = 377
            .Left      = 126
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("opt_4c_Libprzes", "OptionGroup")
        WITH loc_oPg2.opt_4c_Libprzes
            .ButtonCount = 2
            .Top         = 373
            .Left        = 247
            .Width       = 89
            .Height      = 22
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .Left      = 2
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .Left      = 46
                .Top       = 3
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Libera Consulta de Todos Subniveis (ConsSubn)
        loc_oPg2.AddObject("lbl_4c_LbConsSubn", "Label")
        WITH loc_oPg2.lbl_4c_LbConsSubn
            .Caption   = "Libera Consulta de Todos Subniveis :"
            .Top       = 375
            .Left      = 439
            .Width     = 179
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_ConsSubn", "TextBox")
        WITH loc_oPg2.txt_4c_ConsSubn
            .Value         = ""
            .Top           = 371
            .Left          = 619
            .Width         = 20
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_LbConsSubnSN", "Label")
        WITH loc_oPg2.lbl_4c_LbConsSubnSN
            .Caption   = "(S/N)"
            .Top       = 375
            .Left      = 642
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * SUB-GRADE: Acesso Financeiro (SIGCRRCC)
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbGradeAcesso", "Label")
        WITH loc_oPg2.lbl_4c_LbGradeAcesso
            .Caption   = "Liberar Pagamentos por Centro de Custo"
            .Top       = 403
            .Left      = 66
            .Width     = 231
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("grd_4c_AcessoFinan", "Grid")
        loc_oPg2.grd_4c_AcessoFinan.RecordSource = ""
        loc_oPg2.grd_4c_AcessoFinan.ColumnCount  = 4

        loc_oGridAcesso = loc_oPg2.grd_4c_AcessoFinan
        WITH loc_oGridAcesso
            .Top                     = 419
            .Left                    = 66
            .Width                   = 310
            .Height                  = 205
            .FontName                = "Verdana"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 16
            .ScrollBars              = 3
            .GridLines               = 3
            .ReadOnly                = .F.
            .Visible                 = .T.
            .Column1.Width           = 70
            .Column2.Width           = 85
            .Column3.Width           = 90
            .Column4.Width           = 55
            .Column1.Header1.Caption = "Grupo"
            .Column2.Header1.Caption = "Conta"
            .Column3.Header1.Caption = "Valor"
            .Column4.Header1.Caption = "Moeda"
        ENDWITH

        BINDEVENT(loc_oGridAcesso.Column1.Text1, "KeyPress", THIS, "ValidarGrupoGrade")
        BINDEVENT(loc_oGridAcesso.Column2.Text1, "KeyPress", THIS, "ValidarContaGrade")
        BINDEVENT(loc_oGridAcesso.Column4.Text1, "KeyPress", THIS, "ValidarMoedaGrade")

        *-- Botoes Inserir/Excluir linhas da grade de acesso
        loc_oPg2.AddObject("cmd_4c_InserirAcesso", "CommandButton")
        WITH loc_oPg2.cmd_4c_InserirAcesso
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 482
            .Left            = 380
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 7
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPg2.AddObject("cmd_4c_ExcluirAcesso", "CommandButton")
        WITH loc_oPg2.cmd_4c_ExcluirAcesso
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .Top             = 528
            .Left            = 380
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 7
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.cmd_4c_InserirAcesso, "Click", THIS, "BtnInserirAcessoClick")
        BINDEVENT(loc_oPg2.cmd_4c_ExcluirAcesso, "Click", THIS, "BtnExcluirAcessoClick")

        *======================================================================
        * SUB-GRADE: Categorias (sigcarct + sigcdctg)
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_LbGradeCat", "Label")
        WITH loc_oPg2.lbl_4c_LbGradeCat
            .Caption   = "Categorias"
            .Top       = 403
            .Left      = 509
            .Width     = 63
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("grd_4c_Categorias", "Grid")
        loc_oPg2.grd_4c_Categorias.RecordSource = ""
        loc_oPg2.grd_4c_Categorias.ColumnCount  = 3

        loc_oGridCat = loc_oPg2.grd_4c_Categorias
        WITH loc_oGridCat
            .Top                     = 419
            .Left                    = 509
            .Width                   = 310
            .Height                  = 205
            .FontName                = "Verdana"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 16
            .ScrollBars              = 3
            .GridLines               = 3
            .ReadOnly                = .F.
            .Visible                 = .T.
            .Column1.Width           = 60
            .Column2.Width           = 170
            .Column3.Width           = 75
            .Column1.Header1.Caption = "Categoria"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Caption = "Validar"
            .Column2.ReadOnly        = .T.
        ENDWITH

        BINDEVENT(loc_oGridCat.Column1.Text1, "KeyPress", THIS, "ValidarCategoriaGrade")
        BINDEVENT(loc_oGridCat.Column3.Text1, "KeyPress", THIS, "ValidarTipoCategoria")

        *-- Botoes Inserir/Excluir linhas da grade de categorias
        loc_oPg2.AddObject("cmd_4c_InserirCat", "CommandButton")
        WITH loc_oPg2.cmd_4c_InserirCat
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 482
            .Left            = 380
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 7
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPg2.AddObject("cmd_4c_ExcluirCat", "CommandButton")
        WITH loc_oPg2.cmd_4c_ExcluirCat
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .Top             = 528
            .Left            = 823
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 7
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.cmd_4c_InserirCat, "Click", THIS, "BtnInserirCatClick")
        BINDEVENT(loc_oPg2.cmd_4c_ExcluirCat, "Click", THIS, "BtnExcluirCatClick")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca cargos e carrega grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (ccargs C(10), dcargs C(20))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount  = 2
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ccargs"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dcargs"

                        loc_oGrid.Column1.Width = 100
                        loc_oGrid.Column2.Width = 760

                        loc_oGrid.Column1.ReadOnly = .T.
                        loc_oGrid.Column2.ReadOnly = .T.

                        loc_oGrid.Column1.Header1.Caption = "Cargo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrades - Conecta cursores das sub-tabelas aos grids de Page2
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrades()
        LOCAL loc_oPg2, loc_oGridAcesso, loc_oGridCat
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Grid acesso financeiro
            IF PEMSTATUS(loc_oPg2, "grd_4c_AcessoFinan", 5)
                loc_oGridAcesso = loc_oPg2.grd_4c_AcessoFinan
                IF USED("cursor_4c_AcessoFinan")
                    loc_oGridAcesso.ColumnCount = 4
                    loc_oGridAcesso.RecordSource = "cursor_4c_AcessoFinan"
                    loc_oGridAcesso.Column1.ControlSource = "cursor_4c_AcessoFinan.grupos"
                    loc_oGridAcesso.Column2.ControlSource = "cursor_4c_AcessoFinan.contas"
                    loc_oGridAcesso.Column3.ControlSource = "cursor_4c_AcessoFinan.valors"
                    loc_oGridAcesso.Column4.ControlSource = "cursor_4c_AcessoFinan.moedas"
                    loc_oGridAcesso.Column1.Header1.Caption = "Grupo"
                    loc_oGridAcesso.Column2.Header1.Caption = "Conta"
                    loc_oGridAcesso.Column3.Header1.Caption = "Valor"
                    loc_oGridAcesso.Column4.Header1.Caption = "Moeda"
                    loc_oGridAcesso.Refresh
                ENDIF
            ENDIF

            *-- Grid categorias
            IF PEMSTATUS(loc_oPg2, "grd_4c_Categorias", 5)
                loc_oGridCat = loc_oPg2.grd_4c_Categorias
                IF USED("cursor_4c_Categorias")
                    loc_oGridCat.ColumnCount = 3
                    loc_oGridCat.RecordSource = "cursor_4c_Categorias"
                    loc_oGridCat.Column1.ControlSource = "cursor_4c_Categorias.categoria"
                    loc_oGridCat.Column2.ControlSource = "cursor_4c_Categorias.descs"
                    loc_oGridCat.Column3.ControlSource = "cursor_4c_Categorias.tipo"
                    loc_oGridCat.Column1.Header1.Caption = "Categoria"
                    loc_oGridCat.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGridCat.Column3.Header1.Caption = "Validar"
                    loc_oGridCat.Refresh
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.CarregarGrades")
        ENDTRY
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
            MsgErro(loc_oErro.Message, "FormCargo.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

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
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para inclusao de novo cargo
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.this_oBusinessObject.InicializarCursoresGrid()
            THIS.CarregarGrades()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCcargs, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.CarregarGrades()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCcargs, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.CarregarGrades()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui cargo selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCcargs, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do cargo " + loc_cCcargs + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Cargo exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Vai para Page2 no modo BUSCAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "BUSCAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnBuscarClick")
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
    * BtnConfirmarClick - Salva cargo (ou localiza em modo BUSCAR)
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oPg2, loc_cCodBusca, loc_lResultado
        loc_lResultado = .F.

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes antes do TRY (RETURN valido aqui)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Ccargs", 5) AND ;
           EMPTY(ALLTRIM(loc_oPg2.txt_4c_Ccargs.Value)) AND ;
           THIS.this_cModoAtual = "INCLUIR"
            MsgAviso("O c" + CHR(243) + "digo do cargo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "")
            loc_oPg2.txt_4c_Ccargs.SetFocus
            RETURN .F.
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Dcargs", 5) AND ;
           EMPTY(ALLTRIM(loc_oPg2.txt_4c_Dcargs.Value)) AND ;
           !INLIST(THIS.this_cModoAtual, "BUSCAR", "VISUALIZAR")
            MsgAviso("A descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
            loc_oPg2.txt_4c_Dcargs.SetFocus
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_cModoAtual = "BUSCAR"
                IF PEMSTATUS(loc_oPg2, "txt_4c_Ccargs", 5)
                    loc_cCodBusca = ALLTRIM(loc_oPg2.txt_4c_Ccargs.Value)
                ELSE
                    loc_cCodBusca = ""
                ENDIF
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodBusca)
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(cursor_4c_Dados.ccargs) = loc_cCodBusca
                    IF !FOUND()
                        LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.dcargs)) = UPPER(loc_cCodBusca)
                    ENDIF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Cargo salvo com sucesso!")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnConfirmarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias canonico para BtnConfirmarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarBaseClick - Abre picker para copiar cargo existente como modelo
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarBaseClick()
        IF THIS.this_cModoAtual != "INCLUIR"
            RETURN
        ENDIF

        LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCargoSelecionado
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Ccargs.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDCRG", "cursor_4c_BuscaCargoBase", "ccargs", loc_cValor, ;
                "Selecionar Cargo Base")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("ccargs", "", "Cargo")
                    loc_oBusca.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCargoBase")
                    SELECT cursor_4c_BuscaCargoBase
                    loc_cCargoSelecionado = ALLTRIM(cursor_4c_BuscaCargoBase.ccargs)

                    IF !EMPTY(loc_cCargoSelecionado)
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargoSelecionado)
                            THIS.BOParaForm()
                            *-- Limpa o codigo para o usuario digitar o novo
                            loc_oPg2.txt_4c_Ccargs.Value = ""
                            THIS.CarregarGrades()
                        ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnBuscarBaseClick")
        ENDTRY

        IF USED("cursor_4c_BuscaCargoBase")
            USE IN cursor_4c_BuscaCargoBase
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirAcessoClick - Adiciona linha na grade de acesso financeiro
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirAcessoClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("cursor_4c_AcessoFinan")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_AcessoFinan
            APPEND BLANK
            THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
            THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Column1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnInserirAcessoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirAcessoClick - Remove linha da grade de acesso financeiro
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirAcessoClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("cursor_4c_AcessoFinan")
            RETURN
        ENDIF

        SELECT cursor_4c_AcessoFinan
        IF BOF() OR EOF()
            RETURN
        ENDIF

        TRY
            DELETE
            PACK
            THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirAcessoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirCatClick - Adiciona linha na grade de categorias
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirCatClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("cursor_4c_Categorias")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Categorias
            APPEND BLANK
            THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
            THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Column1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnInserirCatClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirCatClick - Remove linha da grade de categorias
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirCatClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("cursor_4c_Categorias")
            RETURN
        ENDIF

        SELECT cursor_4c_Categorias
        IF BOF() OR EOF()
            RETURN
        ENDIF

        TRY
            DELETE
            PACK
            THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirCatClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            THIS.this_oBusinessObject.this_cCcargs      = ALLTRIM(loc_oPg2.txt_4c_Ccargs.Value)
            THIS.this_oBusinessObject.this_cDcargs      = ALLTRIM(loc_oPg2.txt_4c_Dcargs.Value)
            THIS.this_oBusinessObject.this_nLimdescs    = loc_oPg2.txt_4c_Limdescs.Value
            THIS.this_oBusinessObject.this_nDescpors    = loc_oPg2.txt_4c_Descpors.Value
            THIS.this_oBusinessObject.this_nLimacres    = loc_oPg2.txt_4c_Limacres.Value
            THIS.this_oBusinessObject.this_nAcrepors    = loc_oPg2.txt_4c_Acrepors.Value
            THIS.this_oBusinessObject.this_nVllibpgs    = loc_oPg2.txt_4c_Vllibpgs.Value
            THIS.this_oBusinessObject.this_nVllibcots   = loc_oPg2.txt_4c_Vllibcots.Value
            THIS.this_oBusinessObject.this_nVllibopes   = loc_oPg2.txt_4c_Vllibopes.Value
            THIS.this_oBusinessObject.this_nVarcots     = loc_oPg2.txt_4c_Varcots.Value
            THIS.this_oBusinessObject.this_cGrcomis     = ALLTRIM(loc_oPg2.txt_4c_Grcomis.Value)
            THIS.this_oBusinessObject.this_nAcomis      = loc_oPg2.txt_4c_Acomis.Value
            THIS.this_oBusinessObject.this_nComis       = loc_oPg2.txt_4c_Comis.Value
            THIS.this_oBusinessObject.this_nVarmovdup   = loc_oPg2.txt_4c_Varmovdup.Value
            THIS.this_oBusinessObject.this_cNivels      = ALLTRIM(loc_oPg2.txt_4c_Nivels.Value)
            THIS.this_oBusinessObject.this_cAltcots     = ALLTRIM(loc_oPg2.txt_4c_Altcots.Value)
            THIS.this_oBusinessObject.this_cLimites     = ALLTRIM(loc_oPg2.txt_4c_Limites.Value)
            THIS.this_oBusinessObject.this_cCancitens   = ALLTRIM(loc_oPg2.txt_4c_Cancitens.Value)
            THIS.this_oBusinessObject.this_cLibfpags    = ALLTRIM(loc_oPg2.txt_4c_Libfpags.Value)
            THIS.this_oBusinessObject.this_cLibsdins    = ALLTRIM(loc_oPg2.txt_4c_Libsdins.Value)
            THIS.this_oBusinessObject.this_cLibfpgs     = ALLTRIM(loc_oPg2.txt_4c_Libfpgs.Value)
            THIS.this_oBusinessObject.this_cLibopes     = ALLTRIM(loc_oPg2.txt_4c_Libopes.Value)
            THIS.this_oBusinessObject.this_cLibexprd    = ALLTRIM(loc_oPg2.txt_4c_Libexprd.Value)
            THIS.this_oBusinessObject.this_cFcomis      = ALLTRIM(loc_oPg2.txt_4c_Fcomis.Value)
            THIS.this_oBusinessObject.this_cLibvmovdup  = ALLTRIM(loc_oPg2.txt_4c_Libvmovdup.Value)
            THIS.this_oBusinessObject.this_cConsSubn    = ALLTRIM(loc_oPg2.txt_4c_ConsSubn.Value)
            THIS.this_oBusinessObject.this_nLibleilaos  = loc_oPg2.opt_4c_Libleilaos.Value
            THIS.this_oBusinessObject.this_nLibdupends  = loc_oPg2.opt_4c_Libdupends.Value
            THIS.this_oBusinessObject.this_nCustoprod   = loc_oPg2.opt_4c_Custoprod.Value
            THIS.this_oBusinessObject.this_nLibValmmax  = loc_oPg2.opt_4c_LibValmmax.Value
            THIS.this_oBusinessObject.this_nLibduptits  = loc_oPg2.opt_4c_Libduptits.Value
            THIS.this_oBusinessObject.this_nLibprzes    = loc_oPg2.opt_4c_Libprzes.Value
            THIS.this_oBusinessObject.this_nTpcomis     = loc_oPg2.opt_4c_Tpcomis.Value

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_lResultado, loc_nTpcomis
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Ccargs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCcargs)
            loc_oPg2.txt_4c_Dcargs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cDcargs)
            loc_oPg2.txt_4c_Limdescs.Value  = THIS.this_oBusinessObject.this_nLimdescs
            loc_oPg2.txt_4c_Descpors.Value  = THIS.this_oBusinessObject.this_nDescpors
            loc_oPg2.txt_4c_Limacres.Value  = THIS.this_oBusinessObject.this_nLimacres
            loc_oPg2.txt_4c_Acrepors.Value  = THIS.this_oBusinessObject.this_nAcrepors
            loc_oPg2.txt_4c_Vllibpgs.Value  = THIS.this_oBusinessObject.this_nVllibpgs
            loc_oPg2.txt_4c_Vllibcots.Value = THIS.this_oBusinessObject.this_nVllibcots
            loc_oPg2.txt_4c_Vllibopes.Value = THIS.this_oBusinessObject.this_nVllibopes
            loc_oPg2.txt_4c_Varcots.Value   = THIS.this_oBusinessObject.this_nVarcots
            loc_oPg2.txt_4c_Grcomis.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cGrcomis)
            loc_oPg2.txt_4c_Acomis.Value    = THIS.this_oBusinessObject.this_nAcomis
            loc_oPg2.txt_4c_Comis.Value     = THIS.this_oBusinessObject.this_nComis
            loc_oPg2.txt_4c_Varmovdup.Value = THIS.this_oBusinessObject.this_nVarmovdup
            loc_oPg2.txt_4c_Nivels.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cNivels)
            loc_oPg2.txt_4c_Altcots.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cAltcots)
            loc_oPg2.txt_4c_Limites.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLimites)
            loc_oPg2.txt_4c_Cancitens.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCancitens)
            loc_oPg2.txt_4c_Libfpags.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cLibfpags)
            loc_oPg2.txt_4c_Libsdins.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cLibsdins)
            loc_oPg2.txt_4c_Libfpgs.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLibfpgs)
            loc_oPg2.txt_4c_Libopes.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLibopes)
            loc_oPg2.txt_4c_Libexprd.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cLibexprd)
            loc_oPg2.txt_4c_Fcomis.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cFcomis)
            loc_oPg2.txt_4c_Libvmovdup.Value = ALLTRIM(THIS.this_oBusinessObject.this_cLibvmovdup)
            loc_oPg2.txt_4c_ConsSubn.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cConsSubn)

            *-- OptionGroups binarios (0 no BO = Nao = 2 no form)
            loc_oPg2.opt_4c_Libleilaos.Value = IIF(THIS.this_oBusinessObject.this_nLibleilaos = 1, 1, 2)
            loc_oPg2.opt_4c_Libdupends.Value = IIF(THIS.this_oBusinessObject.this_nLibdupends = 1, 1, 2)
            loc_oPg2.opt_4c_Custoprod.Value  = IIF(THIS.this_oBusinessObject.this_nCustoprod  = 1, 1, 2)
            loc_oPg2.opt_4c_LibValmmax.Value = IIF(THIS.this_oBusinessObject.this_nLibValmmax = 1, 1, 2)
            loc_oPg2.opt_4c_Libduptits.Value = IIF(THIS.this_oBusinessObject.this_nLibduptits = 1, 1, 2)
            loc_oPg2.opt_4c_Libprzes.Value   = IIF(THIS.this_oBusinessObject.this_nLibprzes   = 1, 1, 2)

            *-- Tipo comissao (1-3, default 1)
            loc_nTpcomis = THIS.this_oBusinessObject.this_nTpcomis
            loc_oPg2.opt_4c_Tpcomis.Value = IIF(loc_nTpcomis >= 1 AND loc_nTpcomis <= 3, loc_nTpcomis, 1)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Ccargs.Value    = ""
            loc_oPg2.txt_4c_Dcargs.Value    = ""
            loc_oPg2.txt_4c_Limdescs.Value  = 0
            loc_oPg2.txt_4c_Descpors.Value  = 0
            loc_oPg2.txt_4c_Limacres.Value  = 0
            loc_oPg2.txt_4c_Acrepors.Value  = 0
            loc_oPg2.txt_4c_Vllibpgs.Value  = 0
            loc_oPg2.txt_4c_Vllibcots.Value = 0
            loc_oPg2.txt_4c_Vllibopes.Value = 0
            loc_oPg2.txt_4c_Varcots.Value   = 0
            loc_oPg2.txt_4c_Grcomis.Value   = ""
            loc_oPg2.txt_4c_Acomis.Value    = 0
            loc_oPg2.txt_4c_Comis.Value     = 0
            loc_oPg2.txt_4c_Varmovdup.Value = 0
            loc_oPg2.txt_4c_Nivels.Value    = ""
            loc_oPg2.txt_4c_Altcots.Value   = ""
            loc_oPg2.txt_4c_Limites.Value   = ""
            loc_oPg2.txt_4c_Cancitens.Value = ""
            loc_oPg2.txt_4c_Libfpags.Value  = ""
            loc_oPg2.txt_4c_Libsdins.Value  = ""
            loc_oPg2.txt_4c_Libfpgs.Value   = ""
            loc_oPg2.txt_4c_Libopes.Value   = ""
            loc_oPg2.txt_4c_Libexprd.Value  = ""
            loc_oPg2.txt_4c_Fcomis.Value    = ""
            loc_oPg2.txt_4c_Libvmovdup.Value = ""
            loc_oPg2.txt_4c_ConsSubn.Value  = ""
            loc_oPg2.opt_4c_Libleilaos.Value = 2
            loc_oPg2.opt_4c_Libdupends.Value = 2
            loc_oPg2.opt_4c_Custoprod.Value  = 2
            loc_oPg2.opt_4c_LibValmmax.Value = 2
            loc_oPg2.opt_4c_Libduptits.Value = 2
            loc_oPg2.opt_4c_Libprzes.Value   = 2
            loc_oPg2.opt_4c_Tpcomis.Value    = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lCodHabilitar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Codigo do cargo: apenas em INCLUIR e BUSCAR
            loc_lCodHabilitar = INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
            loc_oPg2.txt_4c_Ccargs.Enabled     = loc_lCodHabilitar
            loc_oPg2.cmd_4c_BuscarBase.Enabled = (THIS.this_cModoAtual = "INCLUIR")

            *-- Demais campos
            loc_oPg2.txt_4c_Dcargs.Enabled     = par_lHabilitar
            loc_oPg2.txt_4c_Limdescs.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Descpors.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Limacres.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Acrepors.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Vllibpgs.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Vllibcots.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_Vllibopes.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_Varcots.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Grcomis.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Acomis.Enabled     = par_lHabilitar
            loc_oPg2.txt_4c_Comis.Enabled      = par_lHabilitar
            loc_oPg2.txt_4c_Varmovdup.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_Nivels.Enabled     = par_lHabilitar
            loc_oPg2.txt_4c_Altcots.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Limites.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Cancitens.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_Libfpags.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Libsdins.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Libfpgs.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Libopes.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Libexprd.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Fcomis.Enabled     = par_lHabilitar
            loc_oPg2.txt_4c_Libvmovdup.Enabled = par_lHabilitar
            loc_oPg2.txt_4c_ConsSubn.Enabled   = par_lHabilitar
            loc_oPg2.opt_4c_Libleilaos.Enabled = par_lHabilitar
            loc_oPg2.opt_4c_Libdupends.Enabled = par_lHabilitar
            loc_oPg2.opt_4c_Custoprod.Enabled  = par_lHabilitar
            loc_oPg2.opt_4c_LibValmmax.Enabled = par_lHabilitar
            loc_oPg2.opt_4c_Libduptits.Enabled = par_lHabilitar
            loc_oPg2.opt_4c_Libprzes.Enabled   = par_lHabilitar
            loc_oPg2.opt_4c_Tpcomis.Enabled    = par_lHabilitar

            *-- Sub-grids: ReadOnly nos modos nao-edicao
            IF PEMSTATUS(loc_oPg2, "grd_4c_AcessoFinan", 5)
                loc_oPg2.grd_4c_AcessoFinan.ReadOnly = !par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "grd_4c_Categorias", 5)
                loc_oPg2.grd_4c_Categorias.ReadOnly = !par_lHabilitar
            ENDIF

            *-- Botoes das sub-grades
            IF PEMSTATUS(loc_oPg2, "cmd_4c_InserirAcesso", 5)
                loc_oPg2.cmd_4c_InserirAcesso.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcluirAcesso", 5)
                loc_oPg2.cmd_4c_ExcluirAcesso.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_InserirCat", 5)
                loc_oPg2.cmd_4c_InserirCat.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcluirCat", 5)
                loc_oPg2.cmd_4c_ExcluirCat.Enabled = par_lHabilitar
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupoFinan - Lookup Grupo Financeiro (SigCdGcr) via F4/Enter/Tab
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGrupoFinan(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        LOCAL loc_oPg2, loc_cValor, loc_oBusca
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Grcomis.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cValor, ;
                "Grupo Financeiro")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_oPg2.txt_4c_Grcomis.Value = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.BuscarGrupoFinan")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoGrade - Lookup SigCdGcr para coluna Grupos da grade acesso
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoGrade(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        LOCAL loc_oGrid, loc_cValor, loc_oBusca
        loc_oGrid  = THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan
        loc_cValor = ALLTRIM(loc_oGrid.Column1.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr2", "Codigos", loc_cValor, ;
                "Grupo Financeiro")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
                    SELECT cursor_4c_BuscaGcr2
                    REPLACE grupos WITH ALLTRIM(cursor_4c_BuscaGcr2.Codigos) IN cursor_4c_AcessoFinan
                    loc_oGrid.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
                    loc_oGrid.Refresh
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.ValidarGrupoGrade")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr2")
            USE IN cursor_4c_BuscaGcr2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaGrade - Lookup conta financeira para coluna Contas da grade
    * Nota: contas referencia tabela de contas financeiras (verificar FK)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaGrade(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        LOCAL loc_oGrid, loc_cValor, loc_cGrupo, loc_oBusca
        loc_oGrid  = THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan
        loc_cValor = ALLTRIM(loc_oGrid.Column2.Text1.Value)
        loc_cGrupo = ALLTRIM(loc_oGrid.Column1.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaConta", "Codigos", loc_cValor, ;
                "Conta Financeira")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    REPLACE contas WITH ALLTRIM(cursor_4c_BuscaConta.Codigos) IN cursor_4c_AcessoFinan
                    loc_oGrid.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaConta.Codigos)
                    loc_oGrid.Refresh
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.ValidarContaGrade")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoedaGrade - Lookup SigCdMoe para coluna Moedas da grade acesso
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoedaGrade(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        LOCAL loc_oGrid, loc_cValor, loc_oBusca
        loc_oGrid  = THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan
        loc_cValor = ALLTRIM(loc_oGrid.Column4.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
                "Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "Moeda")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    REPLACE moedas WITH ALLTRIM(cursor_4c_BuscaMoe.CMoes) IN cursor_4c_AcessoFinan
                    loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    loc_oGrid.Refresh
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.ValidarMoedaGrade")
        ENDTRY

        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCategoriaGrade - Lookup SigCdCtg para coluna Categoria da grade
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCategoriaGrade(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        LOCAL loc_oGridCat, loc_cValor, loc_oBusca
        loc_oGridCat = THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias
        loc_cValor   = ALLTRIM(loc_oGridCat.Column1.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCtg", "cursor_4c_BuscaCtg", "Cods", loc_cValor, ;
                "Categoria")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtg")
                    SELECT cursor_4c_BuscaCtg
                    REPLACE categoria WITH ALLTRIM(cursor_4c_BuscaCtg.Cods), ;
                            descs     WITH ALLTRIM(cursor_4c_BuscaCtg.Descs) ;
                        IN cursor_4c_Categorias
                    loc_oGridCat.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Cods)
                    loc_oGridCat.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Descs)
                    loc_oGridCat.Refresh
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.ValidarCategoriaGrade")
        ENDTRY

        IF USED("cursor_4c_BuscaCtg")
            USE IN cursor_4c_BuscaCtg
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAcomis - Valida que o percentual de comissao nao eh negativo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarAcomis(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF loc_oPg2.txt_4c_Acomis.Value < 0
                MsgAviso("O percentual de comiss" + CHR(227) + "o n" + CHR(227) + "o pode ser negativo.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Acomis.Value = 0
                loc_oPg2.txt_4c_Acomis.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.ValidarAcomis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTipoCategoria - Lookup Tipo na grade de categorias via F4/F5
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTipoCategoria(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115, 116)
            RETURN
        ENDIF

        IF !INLIST(par_nKeyCode, 115, 116)
            RETURN
        ENDIF

        LOCAL loc_oGridCat, loc_cValor, loc_oBusca
        loc_oGridCat = THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias
        loc_cValor   = ALLTRIM(loc_oGridCat.Column3.Text1.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "sigcarct", "cursor_4c_BuscaTipo", "tipo", loc_cValor, ;
                "Tipo de Categoria")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("tipo", "", "Tipo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTipo")
                    SELECT cursor_4c_BuscaTipo
                    REPLACE tipo WITH ALLTRIM(cursor_4c_BuscaTipo.tipo) ;
                        IN cursor_4c_Categorias
                    loc_oGridCat.Column3.Text1.Value = ALLTRIM(cursor_4c_BuscaTipo.tipo)
                    loc_oGridCat.Refresh
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.ValidarTipoCategoria")
        ENDTRY

        IF USED("cursor_4c_BuscaTipo")
            USE IN cursor_4c_BuscaTipo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos e cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("cursor_4c_AcessoFinan")
                USE IN cursor_4c_AcessoFinan
            ENDIF
            IF USED("cursor_4c_Categorias")
                USE IN cursor_4c_Categorias
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCargo.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
