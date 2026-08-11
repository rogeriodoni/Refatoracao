*==============================================================================
* Formepd.prg - Finaliza" + CHR(231) + CHR(227) + "o Antecipada
* Migra" + CHR(231) + CHR(227) + "o de SIGCDEPD para arquitetura em camadas
* Fase 8/8: Form completo (estrutura, eventos, lookups, data binding)
*==============================================================================

DEFINE CLASS Formepd AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Finaliza" + CHR(231) + CHR(227) + "o Antecipada"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Estado do formul?rio
    this_cModoAtual = "LISTA"

    *==========================================================================
    * INICIALIZA??O
    *==========================================================================

    *--------------------------------------------------------------------------
    * Init - FormBase.Init() chama InicializarForm() automaticamente
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("epdBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cios (epdBO).", ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Left       = 0
            .Top        = -29
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .Visible    = .T.
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(236, 233, 216)
            .Page2.BackColor = RGB(236, 233, 216)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e bot?es CRUD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabe?alho escuro com t?tulo (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 2
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
            .Width     = THIS.Width - 12
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o Antecipada"
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 12
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o Antecipada"
            .Visible   = .T.
        ENDWITH

        *-- Container bot?es CRUD lado direito (Grupo_Op no legado)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 0
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes = loc_oPagina.cnt_4c_Botoes

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

        *-- Container Encerrar - padr?o can?nico (Left=917, Width=90, cmd Width=75)
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

        loc_oSaida = loc_oPagina.cnt_4c_Saida
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

        *-- Grid principal (grd_4c_Lista) - registros de SigCdNec
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top         = 88
        loc_oGrid.Left        = 5
        loc_oGrid.Width       = 905
        loc_oGrid.Height      = 490
        loc_oGrid.ColumnCount = 7

        WITH loc_oGrid
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
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width           = 75
            .Alignment       = 2
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oGrid.Column2
            .Width           = 80
            .Header1.Caption = "Data"
        ENDWITH
        WITH loc_oGrid.Column3
            .Width           = 90
            .Header1.Caption = "Gr. Origem"
        ENDWITH
        WITH loc_oGrid.Column4
            .Width           = 130
            .Header1.Caption = "Ct. Origem"
        ENDWITH
        WITH loc_oGrid.Column5
            .Width           = 90
            .Header1.Caption = "Gr. Destino"
        ENDWITH
        WITH loc_oGrid.Column6
            .Width           = 130
            .Header1.Caption = "Ct. Destino"
        ENDWITH
        WITH loc_oGrid.Column7
            .Width           = 100
            .Header1.Caption = "Usu" + CHR(225) + "rio"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados) - Campos Parte 1/2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oSalva, loc_oSaida, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container bot" + CHR(245) + "es Confirmar/Cancelar (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSalva = loc_oPagina.cnt_4c_BotoesAcao

        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
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
        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
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
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Container Encerrar - padr" + CHR(227) + "o can" + CHR(244) + "nico
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

        loc_oSaida = loc_oPagina.cnt_4c_Saida
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

        *-- Bot" + CHR(245) + "es de a" + CHR(231) + CHR(227) + "o no topo da Page2 (top=6+29=35)
        loc_oPagina.AddObject("cmd_4c_Operacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Operacao
            .Caption       = "\<Movimento"
            .Top           = 35
            .Left          = 616
            .Width         = 70
            .Height        = 25
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Operacao, "Click", THIS, "BtnOperacaoClick")

        loc_oPagina.AddObject("cmd_4c_Boleto", "CommandButton")
        WITH loc_oPagina.cmd_4c_Boleto
            .Caption       = "\<Boleto"
            .Top           = 35
            .Left          = 692
            .Width         = 70
            .Height        = 25
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")

        loc_oPagina.AddObject("cmd_4c_Documento", "CommandButton")
        WITH loc_oPagina.cmd_4c_Documento
            .Caption       = "\<Documento"
            .Top           = 35
            .Left          = 768
            .Width         = 70
            .Height        = 25
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Documento, "Click", THIS, "BtnDocumentoClick")

        *-- Separador visual (shpBtnGs no legado, top=143+29=172)
        loc_oPagina.AddObject("shp_4c_ShpBtnGs", "Shape")
        WITH loc_oPagina.shp_4c_ShpBtnGs
            .Top     = 172
            .Left    = 635
            .Width   = 18
            .Height  = 50
            .Visible = .T.
        ENDWITH

        *-- Container1: C" + CHR(243) + "digo e Data (top=268+29=297)
        loc_oPagina.AddObject("cnt_4c_Container1", "Container")
        WITH loc_oPagina.cnt_4c_Container1
            .Top         = 297
            .Left        = 214
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(236, 233, 216)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_Container1

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo"
            .Top       = 8
            .Left      = 11
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Numps", "TextBox")
        WITH loc_oCnt.txt_4c_Numps
            .Top      = 28
            .Left     = 11
            .Width    = 81
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Caption   = "Data"
            .Top       = 8
            .Left      = 109
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oCnt.txt_4c_Datas
            .Top      = 28
            .Left     = 109
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = {}
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lin_4c_Line1", "Line")
        WITH loc_oCnt.lin_4c_Line1
            .Top     = 24
            .Left    = 11
            .Width   = 340
            .Height  = 0
            .Visible = .T.
        ENDWITH

        *-- Container Origem: Grupo/Conta/Nome de Origem (top=349+29=378)
        loc_oPagina.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPagina.cnt_4c_Origem
            .Top         = 378
            .Left        = 214
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(236, 233, 216)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_Origem

        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Caption   = "Origem"
            .Top       = 6
            .Left      = 11
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lin_4c_line12", "Line")
        WITH loc_oCnt.lin_4c_line12
            .Top     = 22
            .Left    = 12
            .Width   = 340
            .Height  = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label12", "Label")
        WITH loc_oCnt.lbl_4c_label12
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label22", "Label")
        WITH loc_oCnt.lbl_4c_label22
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_GrupoOs", "TextBox")
        WITH loc_oCnt.txt_4c_GrupoOs
            .Top      = 42
            .Left     = 11
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_GrupoOs, "KeyPress", THIS, "TxtGrupoOsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_GrupoOs, "KeyPress", THIS, "TxtGrupoOsLostFocus")

        loc_oCnt.AddObject("txt_4c_ContaOs", "TextBox")
        WITH loc_oCnt.txt_4c_ContaOs
            .Top      = 42
            .Left     = 96
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_ContaOs, "KeyPress", THIS, "TxtContaOsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_ContaOs, "KeyPress", THIS, "TxtContaOsLostFocus")

        loc_oCnt.AddObject("txt_4c_NomeContaOs", "TextBox")
        WITH loc_oCnt.txt_4c_NomeContaOs
            .Top      = 42
            .Left     = 180
            .Width    = 360
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_NomeContaOs, "KeyPress", THIS, "TxtNomeContaOsKeyPress")

        *-- Container Destino: Grupo/Conta/Nome de Destino (top=429+29=458)
        loc_oPagina.AddObject("cnt_4c_Destino", "Container")
        WITH loc_oPagina.cnt_4c_Destino
            .Top         = 458
            .Left        = 214
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(236, 233, 216)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_Destino

        loc_oCnt.AddObject("lbl_4c_label42", "Label")
        WITH loc_oCnt.lbl_4c_label42
            .Caption   = "Destino"
            .Top       = 6
            .Left      = 11
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lin_4c_line13", "Line")
        WITH loc_oCnt.lin_4c_line13
            .Top     = 22
            .Left    = 12
            .Width   = 340
            .Height  = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label13", "Label")
        WITH loc_oCnt.lbl_4c_label13
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label23", "Label")
        WITH loc_oCnt.lbl_4c_label23
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label32", "Label")
        WITH loc_oCnt.lbl_4c_label32
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_GrupoDs", "TextBox")
        WITH loc_oCnt.txt_4c_GrupoDs
            .Top      = 42
            .Left     = 11
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_GrupoDs, "KeyPress", THIS, "TxtGrupoDsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_GrupoDs, "KeyPress", THIS, "TxtGrupoDsLostFocus")

        loc_oCnt.AddObject("txt_4c_ContaDs", "TextBox")
        WITH loc_oCnt.txt_4c_ContaDs
            .Top      = 42
            .Left     = 96
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_ContaDs, "KeyPress", THIS, "TxtContaDsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_ContaDs, "KeyPress", THIS, "TxtContaDsLostFocus")

        loc_oCnt.AddObject("txt_4c_NomeContaDs", "TextBox")
        WITH loc_oCnt.txt_4c_NomeContaDs
            .Top      = 42
            .Left     = 180
            .Width    = 360
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_NomeContaDs, "KeyPress", THIS, "TxtNomeContaDsKeyPress")

        *-- Container Responsavel: Grupo/Conta/Nome do Responsavel (top=508+29=537)
        loc_oPagina.AddObject("cnt_4c_Responsavel", "Container")
        WITH loc_oPagina.cnt_4c_Responsavel
            .Top         = 537
            .Left        = 214
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(236, 233, 216)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_Responsavel

        loc_oCnt.AddObject("lbl_4c_label43", "Label")
        WITH loc_oCnt.lbl_4c_label43
            .Caption   = "Respons" + CHR(225) + "vel"
            .Top       = 6
            .Left      = 11
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lin_4c_line14", "Line")
        WITH loc_oCnt.lin_4c_line14
            .Top     = 22
            .Left    = 12
            .Width   = 340
            .Height  = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label14", "Label")
        WITH loc_oCnt.lbl_4c_label14
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label24", "Label")
        WITH loc_oCnt.lbl_4c_label24
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label33", "Label")
        WITH loc_oCnt.lbl_4c_label33
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_GrVends", "TextBox")
        WITH loc_oCnt.txt_4c_GrVends
            .Top      = 42
            .Left     = 11
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_GrVends, "KeyPress", THIS, "TxtGrVendsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_GrVends, "KeyPress", THIS, "TxtGrVendsLostFocus")

        loc_oCnt.AddObject("txt_4c_Vends", "TextBox")
        WITH loc_oCnt.txt_4c_Vends
            .Top      = 42
            .Left     = 96
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Vends, "KeyPress", THIS, "TxtVendsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Vends, "KeyPress", THIS, "TxtVendsLostFocus")

        loc_oCnt.AddObject("txt_4c_NomeVends", "TextBox")
        WITH loc_oCnt.txt_4c_NomeVends
            .Top      = 42
            .Left     = 180
            .Width    = 360
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_NomeVends, "KeyPress", THIS, "TxtNomeVendsKeyPress")

        *-- Grade de Operacao (top=68+29=97, Visible=.F. por padrao)
        loc_oPagina.AddObject("grd_4c_GradeOperacao", "Grid")
        WITH loc_oPagina.grd_4c_GradeOperacao
            .Top         = 97
            .Left        = 266
            .Width       = 171
            .Height      = 182
            .ColumnCount = 1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .RowHeight   = 16
            .ScrollBars  = 2
            .GridLines   = 3
            .ReadOnly    = .T.
            .Visible     = .F.
        ENDWITH

        WITH loc_oPagina.grd_4c_GradeOperacao.Column1
            .Width           = 165
            .Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- Botao de Ordens ao lado da grade (top=69+29=98)
        loc_oPagina.AddObject("cmd_4c_BotOrdens", "CommandButton")
        WITH loc_oPagina.cmd_4c_BotOrdens
            .Caption       = "..."
            .Top           = 98
            .Left          = 440
            .Width         = 40
            .Height        = 40
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BotOrdens, "Click", THIS, "BtnBotOrdensClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * NAVEGA??O
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (empdnps C(33), numps N(10), datas D, ;
                        grupoos C(10), contaos C(10), grupods C(10), contads C(10), usuars C(10))
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 7
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numps"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grupoos"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.contaos"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupods"
                    loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contads"
                    loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usuars"

                    *-- Reconfigurar headers ap?s RecordSource (VFP reseta ao mudar RecordSource)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Data"
                    loc_oGrid.Column3.Header1.Caption = "Gr. Origem"
                    loc_oGrid.Column4.Header1.Caption = "Ct. Origem"
                    loc_oGrid.Column5.Header1.Caption = "Gr. Destino"
                    loc_oGrid.Column6.Header1.Caption = "Ct. Destino"
                    loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1) e Page2 (2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AUXILIARES
    *==========================================================================

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles vis?veis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lExcluido

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_lExcluido = INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "GRD_4C_GRADEOPERACAO")

                IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND !loc_lExcluido
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF !loc_lExcluido
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
    * FormatarGridLista - Formata visual do grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * EVENTOS DOS BOT?ES - Page1 (Lista)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara formul?rio para inclus?o de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
           EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
        ELSE
            SELECT cursor_4c_Dados
            loc_cChave = ALLTRIM(cursor_4c_Dados.empdnps)
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edi??o
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
           EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
        ELSE
            SELECT cursor_4c_Dados
            loc_cChave = ALLTRIM(cursor_4c_Dados.empdnps)
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado ap?s confirma??o
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_nNumero
        loc_cChave  = ""
        loc_nNumero = 0

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
           EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
        ELSE
            SELECT cursor_4c_Dados
            loc_cChave  = ALLTRIM(cursor_4c_Dados.empdnps)
            loc_nNumero = cursor_4c_Dados.numps

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
                               TRANSFORM(loc_nNumero) + "?", "Excluir")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista (refresh)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formul?rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * EVENTOS DOS BOT" + CHR(213) + "ES - Page2 (Dados)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva registro (Inserir ou Atualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !THIS.ValidarDados()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOperacaoClick - Abre form de Movimento de Opera" + CHR(231) + CHR(227) + "o (SigOpMpd)
    *--------------------------------------------------------------------------
    PROCEDURE BtnOperacaoClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF INLIST(THIS.this_cModoAtual, "ALTERAR", "VISUALIZAR")
            THIS.Enabled = .F.
            TRY
                DO FORM FormSigOpMpd WITH THIS
                loc_lResultado = .T.
            CATCH TO loc_oErro
                MsgErro("Erro ao abrir Movimento de Opera" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + loc_oErro.Message, "Erro")
                loc_lResultado = .F.
            ENDTRY
            THIS.Enabled = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBoletoClick - Imprime boleto se opera" + CHR(231) + CHR(227) + "o permite
    *--------------------------------------------------------------------------
    PROCEDURE BtnBoletoClick()
        LOCAL loc_lResultado, loc_lTemBoleto
        loc_lResultado = .F.
        loc_lTemBoleto = .F.

        TRY
            IF USED("cursor_4c_OpConfig") AND !EOF("cursor_4c_OpConfig")
                SELECT cursor_4c_OpConfig
                loc_lTemBoleto = (cursor_4c_OpConfig.boletos = 1)
            ENDIF

            IF loc_lTemBoleto
                THIS.ImprimirBoleto()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBoletoClick: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirBoleto - Imprime boleto banc" + CHR(225) + "rio do registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirBoleto()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                DO SigPrBol WITH ALLTRIM(cursor_4c_Dados.emps), ;
                                  ALLTRIM(cursor_4c_Dados.dopps), ;
                                  cursor_4c_Dados.numps
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao imprimir boleto: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Imprime documento se opera" + CHR(231) + CHR(227) + "o permite
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_lResultado, loc_lTemDoc, loc_nQtdDocs
        loc_lResultado = .F.
        loc_lTemDoc    = .F.
        loc_nQtdDocs   = 0

        TRY
            IF USED("cursor_4c_OpConfig") AND !EOF("cursor_4c_OpConfig")
                SELECT cursor_4c_OpConfig
                loc_lTemDoc  = (cursor_4c_OpConfig.docus = 1)
                loc_nQtdDocs = cursor_4c_OpConfig.qtddocs
            ENDIF

            IF loc_lTemDoc AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                DO SigPrIdc WITH ALLTRIM(cursor_4c_Dados.emps), ;
                                  ALLTRIM(cursor_4c_Dados.dopps), ;
                                  cursor_4c_Dados.numps, 0, ;
                                  loc_nQtdDocs, ;
                                  .F., .F., .F., .F., .F., .F., THIS
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnDocumentoClick: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VALIDA" + CHR(199) + CHR(195) + "O
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigat" + CHR(243) + "rios da Page2 antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_oPg2
        loc_lValido = .T.
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value)
            MsgAviso("Data " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.cnt_4c_Container1.txt_4c_Datas.SetFocus
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value))
            MsgAviso("Grupo de Origem " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.SetFocus
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND ;
           EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)) AND ;
           EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value))
            MsgAviso("Conta ou Nome de Origem " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.SetFocus
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value))
            MsgAviso("Grupo de Destino " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.SetFocus
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND ;
           EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)) AND ;
           EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value))
            MsgAviso("Conta ou Nome de Destino " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.SetFocus
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * LOOKUPS - ORIGEM
    *==========================================================================

    *--------------------------------------------------------------------------
    * TxtGrupoOsKeyPress - F4 abre lookup de Grupos Cont" + CHR(225) + "beis (Origem)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoOs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrupoOsLostFocus - Valida Grupo de Origem ao sair do campo
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oPg2, loc_cSQL, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value)

        IF !EMPTY(loc_cGrupo)
            TRY
                loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
                              EscaparSQL(loc_cGrupo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOsVal")

                IF loc_nResult < 0 OR !USED("cursor_4c_GrupoOsVal") OR ;
                   RECCOUNT("cursor_4c_GrupoOsVal") = 0
                    THIS.AbrirLookupGrupoOs()
                ENDIF

                IF USED("cursor_4c_GrupoOsVal")
                    USE IN cursor_4c_GrupoOsVal
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao validar Grupo: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupoOs - Abre picker de Grupos Cont" + CHR(225) + "beis (SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupoOs()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdGcr", "cursor_4c_BuscaGrupoOs", ;
                                      "Codigos", loc_cValor, ;
                                      "Grupos Cont" + CHR(225) + "beis")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoOs")
                    SELECT cursor_4c_BuscaGrupoOs
                    loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value = ALLTRIM(cursor_4c_BuscaGrupoOs.Codigos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de Grupos: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupoOs")
            USE IN cursor_4c_BuscaGrupoOs
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaOsKeyPress - F4 abre lookup de Contas por C" + CHR(243) + "digo (Origem)
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaOs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaOsLostFocus - Valida Conta e preenche Nome de Origem ao sair
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_oPg2, loc_cSQL, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)

        IF !EMPTY(loc_cConta)
            TRY
                loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                              EscaparSQL(loc_cConta)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaOsVal")

                IF loc_nResult >= 0 AND USED("cursor_4c_ContaOsVal") AND ;
                   RECCOUNT("cursor_4c_ContaOsVal") > 0
                    SELECT cursor_4c_ContaOsVal
                    loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_ContaOsVal.RClis)
                ELSE
                    THIS.AbrirLookupContaOs()
                ENDIF

                IF USED("cursor_4c_ContaOsVal")
                    USE IN cursor_4c_ContaOsVal
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao validar Conta: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaOs - Abre picker de Contas por C" + CHR(243) + "digo (SigCdCli.IClis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaOs()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdCli", "cursor_4c_BuscaContaOs", ;
                                      "IClis", loc_cValor, ;
                                      "Contas")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "Conta")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaOs")
                    SELECT cursor_4c_BuscaContaOs
                    loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value    = ALLTRIM(cursor_4c_BuscaContaOs.IClis)
                    loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_BuscaContaOs.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de Contas: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaContaOs")
            USE IN cursor_4c_BuscaContaOs
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtNomeContaOsKeyPress - F4 abre lookup de Contas por Nome (Origem)
    *--------------------------------------------------------------------------
    PROCEDURE TxtNomeContaOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupNomeContaOs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupNomeContaOs - Abre picker de Contas por Nome (SigCdCli.RClis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupNomeContaOs()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdCli", "cursor_4c_BuscaNomeContaOs", ;
                                      "RClis", loc_cValor, ;
                                      "Contas por Nome")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "Conta")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeContaOs")
                    SELECT cursor_4c_BuscaNomeContaOs
                    loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value     = ALLTRIM(cursor_4c_BuscaNomeContaOs.IClis)
                    loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_BuscaNomeContaOs.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca por Nome: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaNomeContaOs")
            USE IN cursor_4c_BuscaNomeContaOs
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - DESTINO
    *==========================================================================

    *--------------------------------------------------------------------------
    * TxtGrupoDsKeyPress - F4 abre lookup de Grupos Contabeis (Destino)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoDs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrupoDsLostFocus - Valida Grupo de Destino ao sair do campo
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoDsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oPg2, loc_cSQL, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value)

        IF !EMPTY(loc_cGrupo)
            TRY
                loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
                              EscaparSQL(loc_cGrupo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDsVal")

                IF loc_nResult < 0 OR !USED("cursor_4c_GrupoDsVal") OR ;
                   RECCOUNT("cursor_4c_GrupoDsVal") = 0
                    THIS.AbrirLookupGrupoDs()
                ENDIF

                IF USED("cursor_4c_GrupoDsVal")
                    USE IN cursor_4c_GrupoDsVal
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao validar Grupo Destino: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupoDs - Abre picker de Grupos Contabeis (SigCdGcr) - Destino
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupoDs()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdGcr", "cursor_4c_BuscaGrupoDs", ;
                                      "Codigos", loc_cValor, ;
                                      "Grupos Cont" + CHR(225) + "beis")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoDs")
                    SELECT cursor_4c_BuscaGrupoDs
                    loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value = ALLTRIM(cursor_4c_BuscaGrupoDs.Codigos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de Grupos Destino: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupoDs")
            USE IN cursor_4c_BuscaGrupoDs
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaDsKeyPress - F4 abre lookup de Contas por Codigo (Destino)
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaDs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaDsLostFocus - Valida Conta e preenche Nome de Destino ao sair
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaDsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_oPg2, loc_cSQL, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)

        IF !EMPTY(loc_cConta)
            TRY
                loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                              EscaparSQL(loc_cConta)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDsVal")

                IF loc_nResult >= 0 AND USED("cursor_4c_ContaDsVal") AND ;
                   RECCOUNT("cursor_4c_ContaDsVal") > 0
                    SELECT cursor_4c_ContaDsVal
                    loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_ContaDsVal.RClis)
                ELSE
                    THIS.AbrirLookupContaDs()
                ENDIF

                IF USED("cursor_4c_ContaDsVal")
                    USE IN cursor_4c_ContaDsVal
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao validar Conta Destino: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaDs - Abre picker de Contas por Codigo (SigCdCli) - Destino
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaDs()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdCli", "cursor_4c_BuscaContaDs", ;
                                      "IClis", loc_cValor, ;
                                      "Contas")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "Conta")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaDs")
                    SELECT cursor_4c_BuscaContaDs
                    loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(cursor_4c_BuscaContaDs.IClis)
                    loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_BuscaContaDs.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de Contas Destino: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaContaDs")
            USE IN cursor_4c_BuscaContaDs
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtNomeContaDsKeyPress - F4 abre lookup de Contas por Nome (Destino)
    *--------------------------------------------------------------------------
    PROCEDURE TxtNomeContaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupNomeContaDs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupNomeContaDs - Abre picker de Contas por Nome - Destino
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupNomeContaDs()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdCli", "cursor_4c_BuscaNomeContaDs", ;
                                      "RClis", loc_cValor, ;
                                      "Contas por Nome")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "Conta")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeContaDs")
                    SELECT cursor_4c_BuscaNomeContaDs
                    loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(cursor_4c_BuscaNomeContaDs.IClis)
                    loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_BuscaNomeContaDs.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca por Nome Destino: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaNomeContaDs")
            USE IN cursor_4c_BuscaNomeContaDs
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - RESPONSAVEL
    *==========================================================================

    *--------------------------------------------------------------------------
    * TxtGrVendsKeyPress - F4 abre lookup de Grupos Contabeis (Responsavel)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrVendsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrVends()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrVendsLostFocus - Valida Grupo do Responsavel ao sair do campo
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrVendsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oPg2, loc_cSQL, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value)

        IF !EMPTY(loc_cGrupo)
            TRY
                loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
                              EscaparSQL(loc_cGrupo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrVendsVal")

                IF loc_nResult < 0 OR !USED("cursor_4c_GrVendsVal") OR ;
                   RECCOUNT("cursor_4c_GrVendsVal") = 0
                    THIS.AbrirLookupGrVends()
                ENDIF

                IF USED("cursor_4c_GrVendsVal")
                    USE IN cursor_4c_GrVendsVal
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao validar Grupo Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrVends - Abre picker de Grupos Contabeis - Responsavel
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrVends()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdGcr", "cursor_4c_BuscaGrVends", ;
                                      "Codigos", loc_cValor, ;
                                      "Grupos Cont" + CHR(225) + "beis")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrVends")
                    SELECT cursor_4c_BuscaGrVends
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value = ALLTRIM(cursor_4c_BuscaGrVends.Codigos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de Grupos Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrVends")
            USE IN cursor_4c_BuscaGrVends
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtVendsKeyPress - F4 abre lookup de Contas por Codigo (Responsavel)
    *--------------------------------------------------------------------------
    PROCEDURE TxtVendsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupVends()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtVendsLostFocus - Valida Conta e preenche Nome do Responsavel ao sair
    *--------------------------------------------------------------------------
    PROCEDURE TxtVendsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_oPg2, loc_cSQL, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value)

        IF !EMPTY(loc_cConta)
            TRY
                loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                              EscaparSQL(loc_cConta)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendsVal")

                IF loc_nResult >= 0 AND USED("cursor_4c_VendsVal") AND ;
                   RECCOUNT("cursor_4c_VendsVal") > 0
                    SELECT cursor_4c_VendsVal
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_VendsVal.RClis)
                ELSE
                    THIS.AbrirLookupVends()
                ENDIF

                IF USED("cursor_4c_VendsVal")
                    USE IN cursor_4c_VendsVal
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao validar Conta Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupVends - Abre picker de Contas por Codigo - Responsavel
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupVends()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdCli", "cursor_4c_BuscaVends", ;
                                      "IClis", loc_cValor, ;
                                      "Contas")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "Conta")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVends")
                    SELECT cursor_4c_BuscaVends
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(cursor_4c_BuscaVends.IClis)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_BuscaVends.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de Contas Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaVends")
            USE IN cursor_4c_BuscaVends
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtNomeVendsKeyPress - F4 abre lookup de Contas por Nome (Responsavel)
    *--------------------------------------------------------------------------
    PROCEDURE TxtNomeVendsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupNomeVends()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupNomeVends - Abre picker de Contas por Nome - Responsavel
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupNomeVends()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdCli", "cursor_4c_BuscaNomeVends", ;
                                      "RClis", loc_cValor, ;
                                      "Contas por Nome")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "Conta")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeVends")
                    SELECT cursor_4c_BuscaNomeVends
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(cursor_4c_BuscaNomeVends.IClis)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_BuscaNomeVends.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca por Nome Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaNomeVends")
            USE IN cursor_4c_BuscaNomeVends
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBotOrdensClick - Exibe/oculta grade de Ordens de Producao em aberto
    *--------------------------------------------------------------------------
    PROCEDURE BtnBotOrdensClick()
        LOCAL loc_oPg2, loc_oGrade, loc_cSQL, loc_nResult, loc_lResultado
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_oGrade    = loc_oPg2.grd_4c_GradeOperacao
        loc_lResultado = .F.

        TRY
            IF loc_oGrade.Visible
                loc_oGrade.Visible = .F.
                loc_lResultado     = .T.
            ELSE
                IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cEmpDNps))
                    loc_cSQL    = "SELECT a.nops AS nops FROM SigCdNei a" + ;
                                  " WHERE a.empdnps = " + ;
                                  EscaparSQL(THIS.this_oBusinessObject.this_cEmpDNps) + ;
                                  " ORDER BY a.nops"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTemp")

                    IF loc_nResult >= 0 AND USED("cursor_4c_OperacoesTemp")
                        IF USED("cursor_4c_Operacoes")
                            SELECT cursor_4c_Operacoes
                            ZAP
                            APPEND FROM DBF("cursor_4c_OperacoesTemp")
                        ELSE
                            SELECT * FROM cursor_4c_OperacoesTemp INTO CURSOR cursor_4c_Operacoes NOFILTER READWRITE
                        ENDIF
                        IF USED("cursor_4c_OperacoesTemp")
                            USE IN cursor_4c_OperacoesTemp
                        ENDIF
                        loc_oGrade.ColumnCount = 1
                        loc_oGrade.RecordSource          = "cursor_4c_Operacoes"
                        loc_oGrade.Column1.ControlSource = "cursor_4c_Operacoes.nops"
                        loc_oGrade.Column1.Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
                        loc_oGrade.Visible = .T.
                        loc_lResultado     = .T.
                    ENDIF
                ELSE
                    loc_oGrade.Visible = .T.
                    loc_lResultado     = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBotOrdensClick: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DATA BINDING
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_nNumps   = loc_oPg2.cnt_4c_Container1.txt_4c_Numps.Value
        THIS.this_oBusinessObject.this_dDatas   = loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value
        THIS.this_oBusinessObject.this_cGrupoOs = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value)
        THIS.this_oBusinessObject.this_cContaOs = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)
        THIS.this_oBusinessObject.this_cGrupoDs = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value)
        THIS.this_oBusinessObject.this_cContaDs = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)
        THIS.this_oBusinessObject.this_cGrVends = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value)
        THIS.this_oBusinessObject.this_cVends   = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cSQL, loc_nResult
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.cnt_4c_Container1.txt_4c_Numps.Value  = THIS.this_oBusinessObject.this_nNumps
        loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value  = THIS.this_oBusinessObject.this_dDatas
        loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoOs)
        loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaOs)
        loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ""

        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cContaOs))
            TRY
                loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cContaOs))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeOsBo")
                IF loc_nResult >= 0 AND USED("cursor_4c_NomeOsBo") AND ;
                   RECCOUNT("cursor_4c_NomeOsBo") > 0
                    SELECT cursor_4c_NomeOsBo
                    loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_NomeOsBo.RClis)
                ENDIF
                IF USED("cursor_4c_NomeOsBo")
                    USE IN cursor_4c_NomeOsBo
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar nome conta origem: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoDs)
        loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaDs)
        loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ""

        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cContaDs))
            TRY
                loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cContaDs))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeDsBo")
                IF loc_nResult >= 0 AND USED("cursor_4c_NomeDsBo") AND ;
                   RECCOUNT("cursor_4c_NomeDsBo") > 0
                    SELECT cursor_4c_NomeDsBo
                    loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_NomeDsBo.RClis)
                ENDIF
                IF USED("cursor_4c_NomeDsBo")
                    USE IN cursor_4c_NomeDsBo
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar nome conta destino: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cGrVends)
        loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cVends)
        loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ""

        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cVends))
            TRY
                loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cVends))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeVendsBo")
                IF loc_nResult >= 0 AND USED("cursor_4c_NomeVendsBo") AND ;
                   RECCOUNT("cursor_4c_NomeVendsBo") > 0
                    SELECT cursor_4c_NomeVendsBo
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_NomeVendsBo.RClis)
                ENDIF
                IF USED("cursor_4c_NomeVendsBo")
                    USE IN cursor_4c_NomeVendsBo
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar nome respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos editaveis na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.cnt_4c_Container1.txt_4c_Numps.ReadOnly = ;
            !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        loc_oPg2.cnt_4c_Container1.txt_4c_Datas.ReadOnly   = !par_lHabilitar
        loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Enabled      = par_lHabilitar
        loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Enabled      = par_lHabilitar
        loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.ReadOnly  = .T.
        loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Enabled     = par_lHabilitar
        loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Enabled     = par_lHabilitar
        loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.ReadOnly = .T.
        loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Enabled  = par_lHabilitar
        loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Enabled    = par_lHabilitar
        loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.ReadOnly = .T.
        loc_oPg2.cmd_4c_Operacao.Enabled  = THIS.this_cModoAtual <> "INCLUIR"
        loc_oPg2.cmd_4c_Boleto.Enabled    = THIS.this_cModoAtual <> "INCLUIR"
        loc_oPg2.cmd_4c_Documento.Enabled = THIS.this_cModoAtual <> "INCLUIR"
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.cnt_4c_Container1.txt_4c_Numps.Value    = 0
        loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value    = {}
        loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value      = ""
        loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value      = ""
        loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value  = ""
        loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value     = ""
        loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value     = ""
        loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ""
        loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value  = ""
        loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ""
        loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ""
        loc_oPg2.grd_4c_GradeOperacao.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estados dos bot" + CHR(245) + "es conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        loc_oPg2.cmd_4c_Operacao.Enabled  = THIS.this_cModoAtual <> "INCLUIR"
        loc_oPg2.cmd_4c_Boleto.Enabled    = THIS.this_cModoAtual <> "INCLUIR"
        loc_oPg2.cmd_4c_Documento.Enabled = THIS.this_cModoAtual <> "INCLUIR"
    ENDPROC

    *==========================================================================
    * DESTRUI" + CHR(199) + CHR(195) + "O
    *==========================================================================

    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
