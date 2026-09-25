*==============================================================================
* Formsigmvdis.prg - Formulario de Distribuicao por Movimentacao de Produtos
* Migrado de: SIGMVDIS.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS Formsigmvdis AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Distribui" + CHR(231) + CHR(227) + "o por Movimenta" + CHR(231) + CHR(227) + "o de Produtos"
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

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvdisBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigmvdisBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigmvdis.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formsigmvdis:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formsigmvdis.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
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
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 (estrutura base)
    * Grid e botoes CRUD sao adicionados na Fase 4
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
        *-- Original: Top=1. Com compensacao +29: Top=31
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
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
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
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado)
        *-- Canonico: Left=542, Top=29, Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPagina.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
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

        *-- Botao Visualizar
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

        *-- Botao Alterar
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

        *-- Botao Excluir
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

        *-- Botao Buscar
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

        *-- Container Encerrar (canonico: Left=917, Width=90 - regra #10 CLAUDE.md)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPagina.cnt_4c_Saida
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

        *-- Grid de lotes de distribuicao (Top = 88 + 29 = 117, compensacao PageFrame.Top=-29)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 2
        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (estrutura base)
    * Campos e demais abas (Pageframe1 legado) sao adicionados nas proximas fases
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - regra #11 CLAUDE.md
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
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

        *-- Container BotoesAcao (Grupo_Salva legado)
        *-- Canonico: Left=842, Top=33, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar/Salvar (Left=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Left=80)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Campos de dados (Top >= 109: 29 compensacao PageFrame + 80 altura cabecalho)
        *-- FASE 5/8: primeiros 6 de 12 campos (codigos, datas, cpros, codcors, codtams, empds)

        *-- Codigo do lote (codigos char(10))
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 125
            .Left      = 30
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top       = 122
            .Left      = 95
            .Width     = 100
            .Height    = 21
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Data da distribuicao (datas datetime)
        loc_oPagina.AddObject("lbl_4c_Data", "Label")
        WITH loc_oPagina.lbl_4c_Data
            .Caption   = "Data :"
            .Top       = 125
            .Left      = 210
            .Width     = 40
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPagina.txt_4c_Data
            .Top       = 122
            .Left      = 255
            .Width     = 100
            .Height    = 21
            .Format    = "D"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Produto (cpros char(14))
        loc_oPagina.AddObject("lbl_4c_CodProduto", "Label")
        WITH loc_oPagina.lbl_4c_CodProduto
            .Caption   = "Produto :"
            .Top       = 155
            .Left      = 30
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CodProduto", "TextBox")
        WITH loc_oPagina.txt_4c_CodProduto
            .Top       = 152
            .Left      = 95
            .Width     = 260
            .Height    = 21
            .MaxLength = 14
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Cor (codcors char(4))
        loc_oPagina.AddObject("lbl_4c_CodCor", "Label")
        WITH loc_oPagina.lbl_4c_CodCor
            .Caption   = "Cor :"
            .Top       = 185
            .Left      = 30
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CodCor", "TextBox")
        WITH loc_oPagina.txt_4c_CodCor
            .Top       = 182
            .Left      = 95
            .Width     = 70
            .Height    = 21
            .MaxLength = 4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Tamanho (codtams char(4))
        loc_oPagina.AddObject("lbl_4c_CodTamanho", "Label")
        WITH loc_oPagina.lbl_4c_CodTamanho
            .Caption   = "Tamanho :"
            .Top       = 185
            .Left      = 180
            .Width     = 70
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CodTamanho", "TextBox")
        WITH loc_oPagina.txt_4c_CodTamanho
            .Top       = 182
            .Left      = 255
            .Width     = 70
            .Height    = 21
            .MaxLength = 4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Empresa de destino (empds char(3))
        loc_oPagina.AddObject("lbl_4c_EmpDestino", "Label")
        WITH loc_oPagina.lbl_4c_EmpDestino
            .Caption   = "Empresa Destino :"
            .Top       = 215
            .Left      = 30
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmpDestino", "TextBox")
        WITH loc_oPagina.txt_4c_EmpDestino
            .Top       = 212
            .Left      = 145
            .Width     = 70
            .Height    = 21
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Local de estoque (locals char(4)) - LOOKUP SigPrLcl
        loc_oPagina.AddObject("lbl_4c_Local", "Label")
        WITH loc_oPagina.lbl_4c_Local
            .Caption   = "Local :"
            .Top       = 245
            .Left      = 30
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Local", "TextBox")
        WITH loc_oPagina.txt_4c_Local
            .Top       = 242
            .Left      = 95
            .Width     = 100
            .Height    = 21
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Empresa+Documento+Numero de origem (empdopnums char(29))
        loc_oPagina.AddObject("lbl_4c_EmpDopNum", "Label")
        WITH loc_oPagina.lbl_4c_EmpDopNum
            .Caption   = "Emp/Doc/N" + CHR(250) + "mero Origem :"
            .Top       = 275
            .Left      = 30
            .Width     = 180
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmpDopNum", "TextBox")
        WITH loc_oPagina.txt_4c_EmpDopNum
            .Top       = 272
            .Left      = 215
            .Width     = 300
            .Height    = 21
            .MaxLength = 29
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Empresa+Documento+Numero original (oridopnums char(29))
        loc_oPagina.AddObject("lbl_4c_OriDopNum", "Label")
        WITH loc_oPagina.lbl_4c_OriDopNum
            .Caption   = "Documento Original :"
            .Top       = 305
            .Left      = 30
            .Width     = 180
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OriDopNum", "TextBox")
        WITH loc_oPagina.txt_4c_OriDopNum
            .Top       = 302
            .Left      = 215
            .Width     = 300
            .Height    = 21
            .MaxLength = 29
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Empresa+Grupo+Estabelecimento (empgruests char(23))
        loc_oPagina.AddObject("lbl_4c_EmpGrupoEstab", "Label")
        WITH loc_oPagina.lbl_4c_EmpGrupoEstab
            .Caption   = "Emp/Grupo/Estab. :"
            .Top       = 335
            .Left      = 30
            .Width     = 180
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmpGrupoEstab", "TextBox")
        WITH loc_oPagina.txt_4c_EmpGrupoEstab
            .Top       = 332
            .Left      = 215
            .Width     = 260
            .Height    = 21
            .MaxLength = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Quantidade de origem (qtdos numeric(10,2))
        loc_oPagina.AddObject("lbl_4c_QtdOrigem", "Label")
        WITH loc_oPagina.lbl_4c_QtdOrigem
            .Caption   = "Qtd. Origem :"
            .Top       = 365
            .Left      = 30
            .Width     = 90
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_QtdOrigem", "TextBox")
        WITH loc_oPagina.txt_4c_QtdOrigem
            .Top       = 362
            .Left      = 125
            .Width     = 90
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Quantidade distribuida (qtds numeric(10,2))
        loc_oPagina.AddObject("lbl_4c_Qtd", "Label")
        WITH loc_oPagina.lbl_4c_Qtd
            .Caption   = "Qtd. Distribu" + CHR(237) + "da :"
            .Top       = 365
            .Left      = 230
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Qtd", "TextBox")
        WITH loc_oPagina.txt_4c_Qtd
            .Top       = 362
            .Left      = 345
            .Width     = 90
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs de lookup (F4/F5 via KeyPress + DblClick + validacao via LostFocus)
        BINDEVENT(loc_oPagina.txt_4c_CodProduto, "DblClick", THIS, "AbrirBuscaCodProduto")
        BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress", THIS, "TeclaLookupCodProduto")
        BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress", THIS, "ValidarCodProduto")

        BINDEVENT(loc_oPagina.txt_4c_CodCor, "DblClick", THIS, "AbrirBuscaCodCor")
        BINDEVENT(loc_oPagina.txt_4c_CodCor, "KeyPress", THIS, "TeclaLookupCodCor")
        BINDEVENT(loc_oPagina.txt_4c_CodCor, "KeyPress", THIS, "ValidarCodCor")

        BINDEVENT(loc_oPagina.txt_4c_CodTamanho, "DblClick", THIS, "AbrirBuscaCodTamanho")
        BINDEVENT(loc_oPagina.txt_4c_CodTamanho, "KeyPress", THIS, "TeclaLookupCodTamanho")
        BINDEVENT(loc_oPagina.txt_4c_CodTamanho, "KeyPress", THIS, "ValidarCodTamanho")

        BINDEVENT(loc_oPagina.txt_4c_EmpDestino, "DblClick", THIS, "AbrirBuscaEmpDestino")
        BINDEVENT(loc_oPagina.txt_4c_EmpDestino, "KeyPress", THIS, "TeclaLookupEmpDestino")
        BINDEVENT(loc_oPagina.txt_4c_EmpDestino, "KeyPress", THIS, "ValidarEmpDestino")

        BINDEVENT(loc_oPagina.txt_4c_Local, "DblClick", THIS, "AbrirBuscaLocal")
        BINDEVENT(loc_oPagina.txt_4c_Local, "KeyPress", THIS, "TeclaLookupLocal")
        BINDEVENT(loc_oPagina.txt_4c_Local, "KeyPress", THIS, "ValidarLocal")

        THIS.ConfigurarPgPage1()
        THIS.ConfigurarPgPage2()
        THIS.ConfigurarPgPage3()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgPage1 - Sub-pagina "Filtrar" do PageFrame interno
    * (Pageframe1.Page1 do legado): grade de estoques/movimentacoes
    * disponiveis para distribuir (marcacao via checkbox) e botao Processar.
    * Mapeamento: SIGMVDIS.Pagina.Dados.Pageframe1.Page1 -> pgf_4c_DadosInternos.Page2
    * (Page1 do PageFrame interno fica reservada, seguindo o padrao ja usado
    * em outros forms wrapper - ver feedback_gate_fase*/regra #11 CLAUDE.md).
    * O PageFrame interno precisa de mais espaco vertical do que a secao de
    * campos "resumo do lote" acima permite; por isso ele fica posicionado
    * logo abaixo do cabecalho (Top=115) e cobre visualmente aquela secao
    * quando exibido - as duas nao coexistem na mesma area.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage1()
        LOCAL loc_oPgDados, loc_oPgN, loc_oGrid, loc_oGrupo

        loc_oPgDados = THIS.pgf_4c_Paginas.Page2

        *-- Cria o PageFrame interno (Pageframe1 do legado) se ainda nao existir
        IF !PEMSTATUS(loc_oPgDados, "pgf_4c_DadosInternos", 5)
            loc_oPgDados.AddObject("pgf_4c_DadosInternos", "PageFrame")
            WITH loc_oPgDados.pgf_4c_DadosInternos
                .PageCount = 4
                .Top       = 115
                .Left      = 0
                .Width     = THIS.Width
                .Height    = 460
                .Tabs      = .T.
                .Visible   = .T.
                .Page1.Caption = "Reservada"
                .Page2.Caption = "Filtrar"
                .Page3.Caption = "Distribui" + CHR(231) + CHR(227) + "o"
                .Page4.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
            ENDWITH
        ENDIF

        loc_oPgN = loc_oPgDados.pgf_4c_DadosInternos.Page2

        *-- Label "Movimentacoes para distribuir" (Say5 no legado)
        loc_oPgN.AddObject("lbl_4c_MovsDistribuir", "Label")
        WITH loc_oPgN.lbl_4c_MovsDistribuir
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es para distribuir"
            .Top       = 189
            .Left      = 356
            .Width     = 300
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Botao Processar (fwbtng no legado)
        loc_oPgN.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oPgN.cmd_4c_Processar
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .Top             = 10
            .Left            = 733
            .Width           = 90
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPgN.cmd_4c_Processar, "Click", THIS, "BtnProcessarDistribuicaoClick")

        *-- CommandGroup Marcar/Desmarcar Todas (cmdMarcaDesmarca no legado)
        loc_oPgN.AddObject("cmg_4c_MarcaDesmarca", "CommandGroup")
        loc_oGrupo = loc_oPgN.cmg_4c_MarcaDesmarca
        WITH loc_oGrupo
            .ButtonCount = 2
            .Top         = 227
            .Left        = 731
            .Width       = 87
            .Height      = 205
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Visible     = .T.
        ENDWITH

        WITH loc_oGrupo.Buttons(1)
            .Caption         = "Marcar Todas"
            .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
            .PicturePosition = 7
            .Top             = 5
            .Left            = 5
            .Width           = 80
            .Height          = 100
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .ToolTipText     = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
        ENDWITH

        WITH loc_oGrupo.Buttons(2)
            .Caption         = "Desmarcar Todas"
            .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .PicturePosition = 7
            .Top             = 105
            .Left            = 5
            .Width           = 80
            .Height          = 100
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .ToolTipText     = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
        ENDWITH
        BINDEVENT(loc_oGrupo.Buttons(1), "Click", THIS, "BtnMarcarTodasClick")
        BINDEVENT(loc_oGrupo.Buttons(2), "Click", THIS, "BtnDesmarcarTodasClick")

        *-- Grid de estoques/movimentacoes (grdEstoque no legado)
        loc_oPgN.AddObject("grd_4c_Estoque", "Grid")
        loc_oGrid = loc_oPgN.grd_4c_Estoque
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 6
        WITH loc_oGrid
            .Top               = 205
            .Left              = 179
            .Width             = 554
            .Height            = 244
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLineColor     = RGB(128, 128, 128)
            .Visible           = .T.
        ENDWITH

        *-- Coluna 1: Checkbox de marcacao (nMarca) - regra #18 CLAUDE.md
        WITH loc_oGrid.Column1
            .Width           = 17
            .Header1.Caption = ""
        ENDWITH
        loc_oGrid.Column1.AddObject("chk_4c_Marca", "CheckBox")
        WITH loc_oGrid.Column1.chk_4c_Marca
            .Top       = 9
            .Left      = 2
            .Width     = 22
            .Height    = 17
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 0
            .Caption   = ""
            .Visible   = .T.
            .ReadOnly  = .F.
        ENDWITH
        loc_oGrid.Column1.CurrentControl = "chk_4c_Marca"
        loc_oGrid.Column1.Sparse         = .F.
        loc_oGrid.Column1.ReadOnly       = .F.
        BINDEVENT(loc_oGrid.Column1.chk_4c_Marca, "MouseDown", THIS, "ToggleMarcaEstoqueMouseDown")
        BINDEVENT(loc_oGrid.Column1.chk_4c_Marca, "KeyPress", THIS, "ToggleMarcaEstoqueKeyPress")
        BINDEVENT(loc_oGrid.Column1.chk_4c_Marca, "Click", THIS, "SuprimirClickPadraoMarca")

        *-- Coluna 2: Empresa
        WITH loc_oGrid.Column2
            .Width             = 70
            .Header1.Caption   = "Empresa"
            .Header1.Alignment = 2
        ENDWITH

        *-- Coluna 3: Movimentacao (Dopes)
        WITH loc_oGrid.Column3
            .Width             = 200
            .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
        ENDWITH

        *-- Coluna 4: Numero
        WITH loc_oGrid.Column4
            .Width             = 80
            .Header1.Caption   = "Numero"
            .Header1.Alignment = 2
        ENDWITH

        *-- Coluna 5: Grupo (somente leitura no legado)
        WITH loc_oGrid.Column5
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Caption   = "Grupo"
            .Header1.Alignment = 2
        ENDWITH

        *-- Coluna 6: Conta (somente leitura no legado)
        WITH loc_oGrid.Column6
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Caption   = "Conta"
            .Header1.Alignment = 2
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarPgPage2 - Sub-pagina "Distribuicao" do PageFrame interno
    * (Pageframe1.Page2 do legado): grade de estoques disponiveis (grdDisponivel),
    * grade de distribuicao por empresa (grdDistribui), filtro por Grupo/Subgrupo
    * e detalhe (somente leitura) do produto em foco na grade de disponiveis.
    * Mapeamento: SIGMVDIS.Pagina.Dados.Pageframe1.Page2 -> pgf_4c_DadosInternos.Page3
    * (Page1 do PageFrame interno fica reservada - regra ja adotada em
    * ConfigurarPgPage1; BtnProcessarDistribuicaoClick ja navega para ActivePage=3).
    * Os cursores cursor_4c_Disponivel/cursor_4c_Distribui ainda nao sao
    * populados nesta fase (grade de disponiveis/estoques - fase futura); os
    * metodos abaixo sao guardados por USED() e ficam inertes até a populacao.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage2()
        LOCAL loc_oPgDados, loc_oPgN, loc_oGrid

        loc_oPgDados = THIS.pgf_4c_Paginas.Page2

        *-- Cria o PageFrame interno (Pageframe1 do legado) se ainda nao existir
        IF !PEMSTATUS(loc_oPgDados, "pgf_4c_DadosInternos", 5)
            loc_oPgDados.AddObject("pgf_4c_DadosInternos", "PageFrame")
            WITH loc_oPgDados.pgf_4c_DadosInternos
                .PageCount = 4
                .Top       = 115
                .Left      = 0
                .Width     = THIS.Width
                .Height    = 460
                .Tabs      = .T.
                .Visible   = .T.
                .Page1.Caption = "Reservada"
                .Page2.Caption = "Filtrar"
                .Page3.Caption = "Distribui" + CHR(231) + CHR(227) + "o"
                .Page4.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
            ENDWITH
        ENDIF

        loc_oPgN = loc_oPgDados.pgf_4c_DadosInternos.Page3

        *-- Moldura decorativa ao redor da foto do produto (Shape5 no legado)
        loc_oPgN.AddObject("shp_4c_Foto", "Shape")
        WITH loc_oPgN.shp_4c_Foto
            .Top           = 5
            .Left          = 4
            .Width         = 163
            .Height        = 93
            .BackStyle     = 0
            .BorderStyle   = 1
            .BorderWidth   = 2
            .SpecialEffect = 0
            .BorderColor   = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        *-- Foto do produto (FigJpg no legado)
        loc_oPgN.AddObject("img_4c_Foto", "Image")
        WITH loc_oPgN.img_4c_Foto
            .Top     = 7
            .Left    = 6
            .Width   = 159
            .Height  = 89
            .Stretch = 1
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPgN.img_4c_Foto, "DblClick", THIS, "ImgFotoDblClick")

        *-- Grid de estoque disponivel para distribuicao (grdDisponivel no legado)
        loc_oPgN.AddObject("grd_4c_Disponivel", "Grid")
        loc_oGrid = loc_oPgN.grd_4c_Disponivel
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 7
        WITH loc_oGrid
            .Top                = 141
            .Left               = 1
            .Width              = 663
            .Height             = 327
            .FontName           = "Courier New"
            .FontSize           = 8
            .ReadOnly           = .T.
            .RecordMark         = .F.
            .RowHeight          = 17
            .BackColor          = RGB(237, 242, 243)
            .GridLineColor      = RGB(136, 189, 188)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .Visible            = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .FontBold          = .T.
            .FontUnderline     = .T.
            .Width             = 105
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 255)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column2
            .Width             = 250
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column3
            .Width             = 35
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Cor"
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column4
            .Width             = 35
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Tam"
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column5
            .FontBold          = .T.
            .Width             = 70
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Format            = "9"
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Estoque"
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column6
            .FontBold          = .T.
            .ColumnOrder       = 7
            .Width             = 70
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Format            = "9"
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Saldo"
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column7
            .FontBold          = .T.
            .ColumnOrder       = 6
            .Width             = 70
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Format            = "9"
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Distribuido"
            .Header1.Alignment = 2
        ENDWITH

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")

        *-- Grid de distribuicao por empresa (grdDistribui no legado)
        loc_oPgN.AddObject("grd_4c_Distribui", "Grid")
        loc_oGrid = loc_oPgN.grd_4c_Distribui
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 4
        WITH loc_oGrid
            .Top                = 141
            .Left               = 664
            .Width              = 334
            .Height             = 327
            .FontName           = "Courier New"
            .FontSize           = 8
            .RecordMark         = .F.
            .RowHeight          = 17
            .BackColor          = RGB(237, 242, 243)
            .GridLineColor      = RGB(136, 189, 188)
            .HighlightBackColor = RGB(168, 177, 202)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .Visible            = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Alignment         = 2
            .Enabled           = .F.
            .Width             = 70
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Empresa"
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column2
            .FontBold          = .T.
            .Alignment         = 1
            .Enabled           = .F.
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Saldo"
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column3
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .F.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Distribuido"
            .Header1.Alignment = 2
        ENDWITH
        BINDEVENT(loc_oGrid.Column3.Text1, "KeyPress", THIS, "DistribuidoLostFocus")

        WITH loc_oGrid.Column4
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .F.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(237, 242, 243)
            .Header1.Caption   = "Local"
            .Header1.Alignment = 2
        ENDWITH
        BINDEVENT(loc_oGrid.Column4.Text1, "DblClick",  THIS, "AbrirBuscaLocalDistribui")
        BINDEVENT(loc_oGrid.Column4.Text1, "KeyPress",  THIS, "TeclaLookupLocalDistribui")
        BINDEVENT(loc_oGrid.Column4.Text1, "KeyPress", THIS, "ValidarLocalDistribui")

        *-- Filtro por Grupo (get_cgrupo/get_dgrupo no legado)
        loc_oPgN.AddObject("lbl_4c_FiltroGrupo", "Label")
        WITH loc_oPgN.lbl_4c_FiltroGrupo
            .Caption   = "Grupo :"
            .Top       = 59
            .Left      = 174
            .Width     = 46
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_FiltroCodGrupo", "TextBox")
        WITH loc_oPgN.txt_4c_FiltroCodGrupo
            .Top       = 74
            .Left      = 175
            .Width     = 35
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Courier New"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_FiltroDescGrupo", "TextBox")
        WITH loc_oPgN.txt_4c_FiltroDescGrupo
            .Top       = 74
            .Left      = 211
            .Width     = 208
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Courier New"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPgN.txt_4c_FiltroCodGrupo, "DblClick",  THIS, "AbrirBuscaFiltroGrupo")
        BINDEVENT(loc_oPgN.txt_4c_FiltroCodGrupo, "KeyPress",  THIS, "TeclaLookupFiltroGrupo")
        BINDEVENT(loc_oPgN.txt_4c_FiltroCodGrupo, "KeyPress", THIS, "ValidarFiltroCodGrupo")
        BINDEVENT(loc_oPgN.txt_4c_FiltroDescGrupo, "KeyPress", THIS, "ValidarFiltroDescGrupo")

        *-- Filtro por Subgrupo (get_csgrupo/get_dsgrupo no legado)
        loc_oPgN.AddObject("lbl_4c_FiltroSubgrupo", "Label")
        WITH loc_oPgN.lbl_4c_FiltroSubgrupo
            .Caption   = "Subgrupo :"
            .Top       = 100
            .Left      = 174
            .Width     = 66
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_FiltroCodSubgrupo", "TextBox")
        WITH loc_oPgN.txt_4c_FiltroCodSubgrupo
            .Top       = 115
            .Left      = 175
            .Width     = 52
            .Height    = 23
            .MaxLength = 6
            .FontName  = "Courier New"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_FiltroDescSubgrupo", "TextBox")
        WITH loc_oPgN.txt_4c_FiltroDescSubgrupo
            .Top       = 115
            .Left      = 228
            .Width     = 236
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Courier New"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPgN.txt_4c_FiltroCodSubgrupo, "DblClick",  THIS, "AbrirBuscaFiltroSubgrupo")
        BINDEVENT(loc_oPgN.txt_4c_FiltroCodSubgrupo, "KeyPress",  THIS, "TeclaLookupFiltroSubgrupo")
        BINDEVENT(loc_oPgN.txt_4c_FiltroCodSubgrupo, "KeyPress", THIS, "ValidarFiltroCodSubgrupo")
        BINDEVENT(loc_oPgN.txt_4c_FiltroDescSubgrupo, "KeyPress", THIS, "ValidarFiltroDescSubgrupo")

        *-- Botao Filtrar (fwbtng "Filtrar" no legado)
        loc_oPgN.AddObject("cmd_4c_Filtrar", "CommandButton")
        WITH loc_oPgN.cmd_4c_Filtrar
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_circulo_16.jpg"
            .PicturePosition = 13
            .Top             = 73
            .Left            = 424
            .Width           = 40
            .Height          = 40
            .ToolTipText     = "Filtrar"
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPgN.cmd_4c_Filtrar, "Click", THIS, "BtnFiltrarDisponivelClick")

        *-- Procurar produto na grade de disponiveis (lbl_produto/get_produto_inicial no legado)
        loc_oPgN.AddObject("lbl_4c_Procurar", "Label")
        WITH loc_oPgN.lbl_4c_Procurar
            .Caption   = "Procurar"
            .Top       = 100
            .Left      = 4
            .Width     = 51
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_ProdutoInicial", "TextBox")
        WITH loc_oPgN.txt_4c_ProdutoInicial
            .Top       = 116
            .Left      = 2
            .Width     = 108
            .Height    = 22
            .MaxLength = 14
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPgN.txt_4c_ProdutoInicial, "KeyPress", THIS, "ValidarProdutoInicial")

        *-- Detalhe do produto em foco na grade de disponiveis (somente leitura,
        *-- preenchido em GrdDisponivelAfterRowColChange - espelha AfterRowColChange
        *-- do legado). ForeColor corrigido de RGB(231,254,253) "quase-branco" para
        *-- RGB(36,84,155), igual aos labels irmaos Say9/Say11 (regra #12 CLAUDE.md).

        *-- Movimentacao de origem (Emps/Dopes/Numes)
        loc_oPgN.AddObject("lbl_4c_DetMovimentacao", "Label")
        WITH loc_oPgN.lbl_4c_DetMovimentacao
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Top       = 472
            .Left      = 20
            .Width     = 93
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetEmp", "TextBox")
        WITH loc_oPgN.txt_4c_DetEmp
            .Top       = 469
            .Left      = 116
            .Width     = 65
            .Height    = 21
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetDopes", "TextBox")
        WITH loc_oPgN.txt_4c_DetDopes
            .Top       = 469
            .Left      = 182
            .Width     = 205
            .Height    = 21
            .MaxLength = 20
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetNumes", "TextBox")
        WITH loc_oPgN.txt_4c_DetNumes
            .Top       = 469
            .Left      = 387
            .Width     = 65
            .Height    = 21
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Grupo / Linha (lbl_grupo/get_cd_grupo/get_ds_grupo + Say5/Get_CdLinha/Get_DsLinha)
        loc_oPgN.AddObject("lbl_4c_DetGrupo", "Label")
        WITH loc_oPgN.lbl_4c_DetGrupo
            .Caption   = "Grupo :"
            .Top       = 493
            .Left      = 67
            .Width     = 46
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetCodGrupo", "TextBox")
        WITH loc_oPgN.txt_4c_DetCodGrupo
            .Top       = 490
            .Left      = 116
            .Width     = 65
            .Height    = 21
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetDescGrupo", "TextBox")
        WITH loc_oPgN.txt_4c_DetDescGrupo
            .Top       = 490
            .Left      = 182
            .Width     = 270
            .Height    = 21
            .MaxLength = 20
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_DetLinha", "Label")
        WITH loc_oPgN.lbl_4c_DetLinha
            .Caption   = "Linha :"
            .Top       = 493
            .Left      = 549
            .Width     = 41
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetCodLinha", "TextBox")
        WITH loc_oPgN.txt_4c_DetCodLinha
            .Top       = 490
            .Left      = 593
            .Width     = 80
            .Height    = 21
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetDescLinha", "TextBox")
        WITH loc_oPgN.txt_4c_DetDescLinha
            .Top       = 490
            .Left      = 674
            .Width     = 255
            .Height    = 21
            .MaxLength = 20
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Subgrupo / Fornecedor (Say2/get_cd_sgrupo/get_ds_sgrupo + lbl_fornecedor/get_cd_fornecedor/get_ds_fornecedor)
        loc_oPgN.AddObject("lbl_4c_DetSubgrupo", "Label")
        WITH loc_oPgN.lbl_4c_DetSubgrupo
            .Caption   = "Subgrupo :"
            .Top       = 514
            .Left      = 47
            .Width     = 66
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetCodSubgrupo", "TextBox")
        WITH loc_oPgN.txt_4c_DetCodSubgrupo
            .Top       = 511
            .Left      = 116
            .Width     = 65
            .Height    = 21
            .MaxLength = 6
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetDescSubgrupo", "TextBox")
        WITH loc_oPgN.txt_4c_DetDescSubgrupo
            .Top       = 511
            .Left      = 182
            .Width     = 270
            .Height    = 21
            .MaxLength = 20
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_DetFornecedor", "Label")
        WITH loc_oPgN.lbl_4c_DetFornecedor
            .Caption   = "Fornecedor :"
            .Top       = 514
            .Left      = 515
            .Width     = 75
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetCodFornecedor", "TextBox")
        WITH loc_oPgN.txt_4c_DetCodFornecedor
            .Top       = 511
            .Left      = 593
            .Width     = 80
            .Height    = 21
            .MaxLength = 10
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetDescFornecedor", "TextBox")
        WITH loc_oPgN.txt_4c_DetDescFornecedor
            .Top       = 511
            .Left      = 674
            .Width     = 255
            .Height    = 21
            .MaxLength = 40
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Ref. Fornecedor / Modelo (lbl_ref_fornecedor/get_ref_fornecedor + Say14/getCodFinP/getDesFinP)
        loc_oPgN.AddObject("lbl_4c_DetRefFornecedor", "Label")
        WITH loc_oPgN.lbl_4c_DetRefFornecedor
            .Caption   = "Ref. Fornecedor :"
            .Top       = 535
            .Left      = 488
            .Width     = 102
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetRefFornecedor", "TextBox")
        WITH loc_oPgN.txt_4c_DetRefFornecedor
            .Top       = 532
            .Left      = 593
            .Width     = 190
            .Height    = 21
            .MaxLength = 20
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_DetModelo", "Label")
        WITH loc_oPgN.lbl_4c_DetModelo
            .Caption   = "Modelo :"
            .Top       = 535
            .Left      = 62
            .Width     = 51
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetCodModelo", "TextBox")
        WITH loc_oPgN.txt_4c_DetCodModelo
            .Top       = 532
            .Left      = 116
            .Width     = 65
            .Height    = 21
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetDescModelo", "TextBox")
        WITH loc_oPgN.txt_4c_DetDescModelo
            .Top       = 532
            .Left      = 182
            .Width     = 270
            .Height    = 21
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Grupo de Venda / Preco de Venda / Peso (Say4/Get_GrVenda/Get_GrDvenda,
        *-- lbl_pr_venda/get_pr_venda/get_pr_venda_moeda, Say1/get_peso_medio)
        loc_oPgN.AddObject("lbl_4c_DetGrupoVenda", "Label")
        WITH loc_oPgN.lbl_4c_DetGrupoVenda
            .Caption   = "Grupo de Venda :"
            .Top       = 556
            .Left      = 9
            .Width     = 104
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetCodGrupoVenda", "TextBox")
        WITH loc_oPgN.txt_4c_DetCodGrupoVenda
            .Top       = 553
            .Left      = 116
            .Width     = 80
            .Height    = 21
            .MaxLength = 10
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetDescGrupoVenda", "TextBox")
        WITH loc_oPgN.txt_4c_DetDescGrupoVenda
            .Top       = 553
            .Left      = 197
            .Width     = 255
            .Height    = 21
            .MaxLength = 40
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_DetPrecoVenda", "Label")
        WITH loc_oPgN.lbl_4c_DetPrecoVenda
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .Top       = 556
            .Left      = 507
            .Width     = 83
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetPrecoVenda", "TextBox")
        WITH loc_oPgN.txt_4c_DetPrecoVenda
            .Top       = 553
            .Left      = 593
            .Width     = 108
            .Height    = 21
            .MaxLength = 10
            .InputMask = "99,999.99999"
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetMoedaVenda", "TextBox")
        WITH loc_oPgN.txt_4c_DetMoedaVenda
            .Top       = 553
            .Left      = 703
            .Width     = 31
            .Height    = 21
            .MaxLength = 3
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_DetPeso", "Label")
        WITH loc_oPgN.lbl_4c_DetPeso
            .Caption   = "Peso :"
            .Top       = 556
            .Left      = 775
            .Width     = 38
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("txt_4c_DetPeso", "TextBox")
        WITH loc_oPgN.txt_4c_DetPeso
            .Top       = 553
            .Left      = 816
            .Width     = 75
            .Height    = 21
            .MaxLength = 10
            .InputMask = "99,999.999"
            .Alignment = 3
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarPgPage3 - Sub-pagina "Movimentacoes" do PageFrame interno
    * (Pageframe1.Page3 do legado): PageFrame interno com as movimentacoes
    * de origem (grdCabOperas) e os itens da movimentacao em foco
    * (grdItnOperas), grupo de observacao (cntOperacao) e botao de
    * finalizacao (cmdProcessar/btnProcessar).
    * Mapeamento: SIGMVDIS.Pagina.Dados.Pageframe1.Page3 -> pgf_4c_DadosInternos.Page4
    * (Page1 do PageFrame interno fica reservada - regra ja adotada em
    * ConfigurarPgPage1/ConfigurarPgPage2).
    * Os cursores cursor_4c_CabOpera/cursor_4c_ItnOpera (crCabOpera/crItnOpera
    * no legado) ainda nao sao populados nesta fase; os handlers abaixo que os
    * referenciam ficam guardados por USED() e inertes ate a populacao (fase
    * futura), seguindo o mesmo padrao adotado em ConfigurarPgPage2 para
    * cursor_4c_Disponivel/cursor_4c_Distribui.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage3()
        LOCAL loc_oPgDados, loc_oPgN, loc_oPgOps, loc_oGrid, loc_oGrupo, loc_oCnt

        loc_oPgDados = THIS.pgf_4c_Paginas.Page2

        *-- Cria o PageFrame interno (Pageframe1 do legado) se ainda nao existir
        IF !PEMSTATUS(loc_oPgDados, "pgf_4c_DadosInternos", 5)
            loc_oPgDados.AddObject("pgf_4c_DadosInternos", "PageFrame")
            WITH loc_oPgDados.pgf_4c_DadosInternos
                .PageCount = 4
                .Top       = 115
                .Left      = 0
                .Width     = THIS.Width
                .Height    = 460
                .Tabs      = .T.
                .Visible   = .T.
                .Page1.Caption = "Reservada"
                .Page2.Caption = "Filtrar"
                .Page3.Caption = "Distribui" + CHR(231) + CHR(227) + "o"
                .Page4.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
            ENDWITH
        ENDIF

        loc_oPgN = loc_oPgDados.pgf_4c_DadosInternos.Page4

        *-- PageFrame interno de Movimentacoes/Itens (pgOperacoes no legado)
        loc_oPgN.AddObject("pgf_4c_Operacoes", "PageFrame")
        loc_oPgOps = loc_oPgN.pgf_4c_Operacoes
        WITH loc_oPgOps
            .PageCount = 2
            .Top        = 191
            .Left       = 1
            .Width      = 997
            .Height     = 377
            .Tabs       = .T.
            .Visible    = .T.
            .Page1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
            .Page2.Caption = "Itens"
        ENDWITH

        *-- Grid de movimentacoes de origem (grdCabOperas no legado)
        loc_oPgOps.Page1.AddObject("grd_4c_CabOperas", "Grid")
        loc_oGrid = loc_oPgOps.Page1.grd_4c_CabOperas
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 8
        WITH loc_oGrid
            .Top           = 6
            .Left          = 9
            .Width         = 975
            .Height        = 339
            .FontSize      = 8
            .ReadOnly      = .T.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(128, 128, 128)
            .Visible       = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width             = 45
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Emp O"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column2
            .Width             = 325
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column3
            .Width             = 111
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column4
            .Width             = 45
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Emp D"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column5
            .Alignment         = 3
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Grupo Orig"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column6
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Conta Orig"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column7
            .Alignment         = 2
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Grupo Dest"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column8
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Conta Dest"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        *-- Grid de itens da movimentacao em foco (grdItnOperas no legado)
        loc_oPgOps.Page2.AddObject("grd_4c_ItnOperas", "Grid")
        loc_oGrid = loc_oPgOps.Page2.grd_4c_ItnOperas
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 9
        WITH loc_oGrid
            .Top           = 5
            .Left          = 9
            .Width         = 975
            .Height        = 340
            .FontSize      = 8
            .ReadOnly      = .T.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(128, 128, 128)
            .Visible       = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Alignment         = 3
            .ColumnOrder       = 1
            .Width             = 36
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Item"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column2
            .ColumnOrder       = 2
            .Width             = 106
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column3
            .ColumnOrder       = 3
            .Width             = 382
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column4
            .ColumnOrder       = 6
            .Width             = 35
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Uni"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column5
            .ColumnOrder       = 7
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Quantidade"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column6
            .Alignment         = 3
            .ColumnOrder       = 8
            .Width             = 100
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Unit" + CHR(225) + "rio"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column7
            .ColumnOrder       = 9
            .Width             = 130
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Total"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column8
            .ColumnOrder       = 4
            .Width             = 38
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Cor"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column9
            .ColumnOrder       = 5
            .Width             = 38
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Header1.Caption   = "Tam"
            .Header1.FontBold  = .T.
            .Header1.Alignment = 2
        ENDWITH

        *-- Ativa a pagina "Itens" ordenando/filtrando pelo cabecalho em foco
        *-- (pgItens.Activate no legado)
        BINDEVENT(loc_oPgOps.Page2, "Activate", THIS, "AtivarPgItensOperacoes")

        *-- CommandGroup com o botao de finalizacao (cmdProcessar/btnProcessar
        *-- no legado)
        loc_oPgN.AddObject("cmg_4c_ProcessarOperacoes", "CommandGroup")
        loc_oGrupo = loc_oPgN.cmg_4c_ProcessarOperacoes
        WITH loc_oGrupo
            .ButtonCount = 1
            .Top         = 11
            .Left        = 733
            .Width       = 80
            .Height      = 100
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Visible     = .T.
        ENDWITH

        WITH loc_oGrupo.Buttons(1)
            .Caption         = "Processar Distribui" + CHR(231) + CHR(227) + "o"
            .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
            .PicturePosition = 7
            .Top             = 0
            .Left            = 0
            .Width           = 80
            .Height          = 100
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .ToolTipText     = "Gerar Opera" + CHR(231) + CHR(245) + "es dos Pedidos"
        ENDWITH
        BINDEVENT(loc_oGrupo.Buttons(1), "Click", THIS, "BtnProcessarOperacoesClick")

        *-- Container com a observacao do lote (cntOperacao no legado)
        loc_oPgN.AddObject("cnt_4c_Operacao", "Container")
        loc_oCnt = loc_oPgN.cnt_4c_Operacao
        WITH loc_oCnt
            .Top         = 13
            .Left        = 3
            .Width       = 564
            .Height      = 165
            .BackStyle   = 0
            .BorderWidth = 0
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Obs", "Label")
        WITH loc_oCnt.lbl_4c_Obs
            .Caption   = "Obs. :"
            .Top       = 10
            .Left      = 12
            .Width     = 40
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
        WITH loc_oCnt.txt_4c_CodObs
            .Top               = 10
            .Left              = 52
            .Width             = 27
            .Height            = 20
            .Margin            = 2
            .MaxLength         = 3
            .Alignment         = 3
            .Format            = "K"
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .FontName          = "Arial"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = 0
            .Visible           = .T.
        ENDWITH

        loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
        WITH loc_oCnt.edt_4c_Obs
            .Top           = 10
            .Left          = 83
            .Width         = 407
            .Height        = 112
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .FontName      = "Arial"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores da Page2 (Form) para o Business Object
    * Cobre TODOS os campos editaveis do BO (16 propriedades - PK/auditoria
    * ficam de fora, pois sao geradas/preenchidas internamente pelo BO).
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo        = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_dData          = loc_oPg2.txt_4c_Data.Value
        THIS.this_oBusinessObject.this_cCodProduto    = ALLTRIM(loc_oPg2.txt_4c_CodProduto.Value)
        THIS.this_oBusinessObject.this_cCodCor        = ALLTRIM(loc_oPg2.txt_4c_CodCor.Value)
        THIS.this_oBusinessObject.this_cCodTamanho    = ALLTRIM(loc_oPg2.txt_4c_CodTamanho.Value)
        THIS.this_oBusinessObject.this_cEmpDestino    = ALLTRIM(loc_oPg2.txt_4c_EmpDestino.Value)
        THIS.this_oBusinessObject.this_cLocal         = ALLTRIM(loc_oPg2.txt_4c_Local.Value)
        THIS.this_oBusinessObject.this_cEmpDopNum     = ALLTRIM(loc_oPg2.txt_4c_EmpDopNum.Value)
        THIS.this_oBusinessObject.this_cOriDopNum     = ALLTRIM(loc_oPg2.txt_4c_OriDopNum.Value)
        THIS.this_oBusinessObject.this_cEmpGrupoEstab = ALLTRIM(loc_oPg2.txt_4c_EmpGrupoEstab.Value)
        THIS.this_oBusinessObject.this_nQtdOrigem     = loc_oPg2.txt_4c_QtdOrigem.Value
        THIS.this_oBusinessObject.this_nQtd           = loc_oPg2.txt_4c_Qtd.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do Business Object para a Page2 (Form)
    * Cobre TODOS os campos editaveis do BO.
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value        = THIS.this_oBusinessObject.this_cCodigo
        loc_oPg2.txt_4c_Data.Value          = ConverterParaData(THIS.this_oBusinessObject.this_dData)
        loc_oPg2.txt_4c_CodProduto.Value    = THIS.this_oBusinessObject.this_cCodProduto
        loc_oPg2.txt_4c_CodCor.Value        = THIS.this_oBusinessObject.this_cCodCor
        loc_oPg2.txt_4c_CodTamanho.Value    = THIS.this_oBusinessObject.this_cCodTamanho
        loc_oPg2.txt_4c_EmpDestino.Value    = THIS.this_oBusinessObject.this_cEmpDestino
        loc_oPg2.txt_4c_Local.Value         = THIS.this_oBusinessObject.this_cLocal
        loc_oPg2.txt_4c_EmpDopNum.Value     = THIS.this_oBusinessObject.this_cEmpDopNum
        loc_oPg2.txt_4c_OriDopNum.Value     = THIS.this_oBusinessObject.this_cOriDopNum
        loc_oPg2.txt_4c_EmpGrupoEstab.Value = THIS.this_oBusinessObject.this_cEmpGrupoEstab
        loc_oPg2.txt_4c_QtdOrigem.Value     = THIS.this_oBusinessObject.this_nQtdOrigem
        loc_oPg2.txt_4c_Qtd.Value           = THIS.this_oBusinessObject.this_nQtd
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os valores dos campos da Page2
    * Cobre TODOS os campos editaveis do BO.
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value        = ""
        loc_oPg2.txt_4c_Data.Value          = {}
        loc_oPg2.txt_4c_CodProduto.Value    = ""
        loc_oPg2.txt_4c_CodCor.Value        = ""
        loc_oPg2.txt_4c_CodTamanho.Value    = ""
        loc_oPg2.txt_4c_EmpDestino.Value    = ""
        loc_oPg2.txt_4c_Local.Value         = ""
        loc_oPg2.txt_4c_EmpDopNum.Value     = ""
        loc_oPg2.txt_4c_OriDopNum.Value     = ""
        loc_oPg2.txt_4c_EmpGrupoEstab.Value = ""
        loc_oPg2.txt_4c_QtdOrigem.Value     = 0
        loc_oPg2.txt_4c_Qtd.Value           = 0
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega lotes de distribuicao (Codigos/Datas) no Grid
    * Espelha o legado: Select Distinct Codigos, Datas from SigPrDis
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource ANTES de ControlSource (auto-bind seria sobrescrito - Problema 48)
                loc_oGrid.ColumnCount   = 2
                loc_oGrid.RecordSource  = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"

                loc_oGrid.Column1.Width    = 150
                loc_oGrid.Column2.Width    = 725

                loc_oGrid.Column1.ReadOnly = .T.
                loc_oGrid.Column2.ReadOnly = .T.

                *-- Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Data"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigmvdis.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Lista (1) e Dados (2)
    *===========================================================================
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
            MsgErro(loc_oErro.Message, "Formsigmvdis.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os controles editaveis da Page2
    * Generico: percorre a pagina e ajusta .Enabled de campos de entrada
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_nI, loc_oCtrl
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        FOR loc_nI = 1 TO loc_oPg2.ControlCount
            loc_oCtrl = loc_oPg2.Controls(loc_nI)
            IF VARTYPE(loc_oCtrl) = "O" AND INLIST(UPPER(loc_oCtrl.BaseClass), "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", "OPTIONGROUP")
                IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
                    loc_oCtrl.Enabled = par_lHabilitar
                ENDIF
            ENDIF
        ENDFOR

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta caption/estado dos botoes de acao da Page2
    * (cnt_4c_BotoesAcao) conforme this_cModoAtual (INCLUIR/ALTERAR/VISUALIZAR).
    * Chamado junto com HabilitarCampos() apos this_cModoAtual ser definido.
    * Confirmar fica desabilitado em VISUALIZAR (regra #20 CLAUDE.md: modo
    * somente-leitura nunca deixa o botao de gravar acionavel); Cancelar vira
    * "Voltar" nesse modo, pois nao ha alteracao a descartar.
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes
        loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .F.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Voltar"

            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"

            OTHERWISE
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
        ENDCASE
    ENDPROC

    *===========================================================================
    * LOOKUPS (F4/F5 + DblClick + validacao em LostFocus)
    * Padrao: docs/lookup_implementation.md - 3 metodos por campo
    *===========================================================================

    *-- Produto (cpros) -> SigCdPro (cpros/dpros)
    PROCEDURE TeclaLookupCodProduto(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCodProduto()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCodProduto()
        LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_CodProduto.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaProduto", "cpros", loc_cValorAtual, ;
            "Buscar Produto")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaProduto")
                    loc_oPg2.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_BuscaProduto.cpros)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                        loc_oPg2.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_BuscaProduto.cpros)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF
    ENDPROC

    PROCEDURE ValidarCodProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_CodProduto.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT cpros, dpros FROM SigCdPro WHERE CAST(cpros AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaProduto")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaProduto") = 1
            loc_oPg2.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ValidaProduto.cpros)
            IF USED("cursor_4c_ValidaProduto")
                USE IN cursor_4c_ValidaProduto
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaProduto")
                USE IN cursor_4c_ValidaProduto
            ENDIF
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaCodProduto()
        ENDIF
    ENDPROC

    *-- Cor (codcors) -> SigCdCor (cods/descs)
    PROCEDURE TeclaLookupCodCor(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCodCor()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCodCor()
        LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_CodCor.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValorAtual, ;
            "Buscar Cor")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaCor")
                    loc_oPg2.txt_4c_CodCor.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
                        loc_oPg2.txt_4c_CodCor.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaCor")
            USE IN cursor_4c_BuscaCor
        ENDIF
    ENDPROC

    PROCEDURE ValidarCodCor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_CodCor.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT cods, descs FROM SigCdCor WHERE CAST(cods AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaCor")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaCor") = 1
            loc_oPg2.txt_4c_CodCor.Value = ALLTRIM(cursor_4c_ValidaCor.cods)
            IF USED("cursor_4c_ValidaCor")
                USE IN cursor_4c_ValidaCor
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaCor")
                USE IN cursor_4c_ValidaCor
            ENDIF
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaCodCor()
        ENDIF
    ENDPROC

    *-- Tamanho (codtams) -> SigCdTam (cods/descs)
    PROCEDURE TeclaLookupCodTamanho(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCodTamanho()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCodTamanho()
        LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_CodTamanho.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdTam", "cursor_4c_BuscaTamanho", "cods", loc_cValorAtual, ;
            "Buscar Tamanho")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaTamanho")
                    loc_oPg2.txt_4c_CodTamanho.Value = ALLTRIM(cursor_4c_BuscaTamanho.cods)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamanho")
                        loc_oPg2.txt_4c_CodTamanho.Value = ALLTRIM(cursor_4c_BuscaTamanho.cods)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaTamanho")
            USE IN cursor_4c_BuscaTamanho
        ENDIF
    ENDPROC

    PROCEDURE ValidarCodTamanho(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_CodTamanho.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT cods, descs FROM SigCdTam WHERE CAST(cods AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaTamanho")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaTamanho") = 1
            loc_oPg2.txt_4c_CodTamanho.Value = ALLTRIM(cursor_4c_ValidaTamanho.cods)
            IF USED("cursor_4c_ValidaTamanho")
                USE IN cursor_4c_ValidaTamanho
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaTamanho")
                USE IN cursor_4c_ValidaTamanho
            ENDIF
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaCodTamanho()
        ENDIF
    ENDPROC

    *-- Empresa de destino (empds) -> SigCdEmp (cemps/razas)
    PROCEDURE TeclaLookupEmpDestino(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaEmpDestino()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpDestino()
        LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_EmpDestino.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpresa", "cemps", loc_cValorAtual, ;
            "Buscar Empresa")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaEmpresa")
                    loc_oPg2.txt_4c_EmpDestino.Value = ALLTRIM(cursor_4c_BuscaEmpresa.cemps)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
                        loc_oPg2.txt_4c_EmpDestino.Value = ALLTRIM(cursor_4c_BuscaEmpresa.cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
    ENDPROC

    PROCEDURE ValidarEmpDestino(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_EmpDestino.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE CAST(cemps AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaEmpresa")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaEmpresa") = 1
            loc_oPg2.txt_4c_EmpDestino.Value = ALLTRIM(cursor_4c_ValidaEmpresa.cemps)
            IF USED("cursor_4c_ValidaEmpresa")
                USE IN cursor_4c_ValidaEmpresa
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaEmpresa")
                USE IN cursor_4c_ValidaEmpresa
            ENDIF
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaEmpDestino()
        ENDIF
    ENDPROC

    *-- Local de estoque (locals) -> SigPrLcl (codigos/descricaos)
    PROCEDURE TeclaLookupLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaLocal()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaLocal()
        LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_Local.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", loc_cValorAtual, ;
            "Buscar Localiza" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaLocal")
                    loc_oPg2.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
                        loc_oPg2.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaLocal")
            USE IN cursor_4c_BuscaLocal
        ENDIF
    ENDPROC

    PROCEDURE ValidarLocal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_Local.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT codigos, descricaos FROM SigPrLcl WHERE CAST(codigos AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaLocal")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaLocal") = 1
            loc_oPg2.txt_4c_Local.Value = ALLTRIM(cursor_4c_ValidaLocal.codigos)
            IF USED("cursor_4c_ValidaLocal")
                USE IN cursor_4c_ValidaLocal
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaLocal")
                USE IN cursor_4c_ValidaLocal
            ENDIF
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaLocal()
        ENDIF
    ENDPROC

    *===========================================================================
    * PGDADOSINTERNOS.PAGE2 (Filtrar) - handlers da grade de estoques
    * Espelham SIGMVDIS.Pagina.Dados.Pageframe1.Page1 do legado.
    * PUBLIC: exigido por BINDEVENT (regra #3 CLAUDE.md).
    *===========================================================================

    *-- Marca/Desmarca Todas (cmdMarcaDesmarca.btnMarcar/btnDesmarcar no legado)
    *-- Legado: Update crSigMvDis Set nMarca = 1/0
    PROCEDURE BtnMarcarTodasClick()
        IF USED("cursor_4c_Estoque")
            SELECT cursor_4c_Estoque
            REPLACE ALL nMarca WITH 1
            THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarTodasClick()
        IF USED("cursor_4c_Estoque")
            SELECT cursor_4c_Estoque
            REPLACE ALL nMarca WITH 0
            THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
        ENDIF
    ENDPROC

    *-- Checkbox da Coluna1 (nMarca): alterna no MouseDown/KeyPress, igual ao
    *-- legado (Click/MouseUp so fazem NoDefault - regra #18 CLAUDE.md)
    PROCEDURE ToggleMarcaEstoqueMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        IF USED("cursor_4c_Estoque")
            REPLACE nMarca WITH IIF(cursor_4c_Estoque.nMarca = 0, 1, 0) IN cursor_4c_Estoque
            THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ToggleMarcaEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Estoque")
            REPLACE nMarca WITH IIF(cursor_4c_Estoque.nMarca = 0, 1, 0) IN cursor_4c_Estoque
            THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE SuprimirClickPadraoMarca()
        NODEFAULT
    ENDPROC

    *-- Processar (fwbtng "processar" no legado): conta selecionados e avanca
    *-- para a sub-pagina de Distribuicao (Page3 - implementada em fase futura)
    PROCEDURE BtnProcessarDistribuicaoClick()
        LOCAL loc_nSelecionados
        loc_nSelecionados = 0

        IF USED("cursor_4c_Estoque")
            SELECT cursor_4c_Estoque
            COUNT FOR nMarca = 1 TO loc_nSelecionados
        ENDIF

        IF loc_nSelecionados = 0
            MsgAviso("Nenhum estoque foi selecionado.", "Aviso")
        ELSE
            THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.ActivePage = 3
        ENDIF
    ENDPROC

    *===========================================================================
    * PGDADOSINTERNOS.PAGE3 (Distribuicao) - handlers
    * Espelham SIGMVDIS.Pagina.Dados.Pageframe1.Page2 do legado.
    * cursor_4c_Disponivel/cursor_4c_Distribui ainda nao sao populados nesta
    * fase (fase futura) - todo handler que os referencia esta guardado por
    * USED() e fica inerte enquanto os cursores nao existem.
    * PUBLIC: exigido por BINDEVENT (regra #3 CLAUDE.md).
    *===========================================================================

    *-- AfterRowColChange do grd_4c_Disponivel: mostra detalhe do produto em
    *-- foco (Grupo/Subgrupo/Linha/Fornecedor/Modelo/Grupo Venda/Preco/Peso/Foto)
    *-- Espelha o legado (AfterRowColChange de grdDisponivel).
    PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
        LOCAL loc_oPgN, loc_cCpros, loc_cSQL, loc_nResultado
        LOCAL loc_cMoeDetqs, loc_cMoeVenda, loc_nCotAlvo, loc_nCotVenda
        LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cOriDopNums

        IF !USED("cursor_4c_Disponivel") OR RECCOUNT("cursor_4c_Disponivel") = 0
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(NVL(cursor_4c_Disponivel.Cpros, ""))
        IF EMPTY(loc_cCpros)
            RETURN
        ENDIF

        loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3

        loc_cSQL = "SELECT a.cpros, a.ifors, a.reffs, a.cgrus, a.sgrus, a.pesoms," + ;
            " a.colecoes, a.linhas, a.CodFinP, a.pvens, a.moevs, a.FigJpgs," + ;
            " g.dgrus, c.rclis, b.descs AS desccol, l.descs AS desclin" + ;
            " FROM SigCdPro a" + ;
            " LEFT JOIN SigCdGrp g ON a.cgrus = g.cgrus" + ;
            " LEFT JOIN SigCdCli c ON a.ifors = c.iclis" + ;
            " LEFT JOIN SigCdCol b ON a.colecoes = b.colecoes" + ;
            " LEFT JOIN SigCdLin l ON a.linhas = l.linhas" + ;
            " WHERE a.cpros = " + EscaparSQL(loc_cCpros)

        IF USED("cursor_4c_DetalheProduto")
            USE IN cursor_4c_DetalheProduto
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DetalheProduto")

        IF loc_nResultado < 0 OR !USED("cursor_4c_DetalheProduto") OR RECCOUNT("cursor_4c_DetalheProduto") = 0
            RETURN
        ENDIF

        SELECT cursor_4c_DetalheProduto
        GO TOP

        loc_oPgN.txt_4c_DetCodFornecedor.Value  = ALLTRIM(NVL(cursor_4c_DetalheProduto.ifors, ""))
        loc_oPgN.txt_4c_DetDescFornecedor.Value = ALLTRIM(NVL(cursor_4c_DetalheProduto.rclis, ""))
        loc_oPgN.txt_4c_DetRefFornecedor.Value  = ALLTRIM(NVL(cursor_4c_DetalheProduto.reffs, ""))
        loc_oPgN.txt_4c_DetCodGrupo.Value       = ALLTRIM(NVL(cursor_4c_DetalheProduto.cgrus, ""))
        loc_oPgN.txt_4c_DetDescGrupo.Value      = ALLTRIM(NVL(cursor_4c_DetalheProduto.dgrus, ""))
        loc_oPgN.txt_4c_DetCodSubgrupo.Value    = ALLTRIM(NVL(cursor_4c_DetalheProduto.sgrus, ""))
        loc_oPgN.txt_4c_DetPeso.Value           = NVL(cursor_4c_DetalheProduto.pesoms, 0)
        loc_oPgN.txt_4c_DetCodGrupoVenda.Value  = ALLTRIM(NVL(cursor_4c_DetalheProduto.colecoes, ""))
        loc_oPgN.txt_4c_DetDescGrupoVenda.Value = ALLTRIM(NVL(cursor_4c_DetalheProduto.desccol, ""))
        loc_oPgN.txt_4c_DetCodLinha.Value       = ALLTRIM(NVL(cursor_4c_DetalheProduto.linhas, ""))
        loc_oPgN.txt_4c_DetDescLinha.Value      = ALLTRIM(NVL(cursor_4c_DetalheProduto.desclin, ""))
        loc_oPgN.txt_4c_DetCodModelo.Value      = ALLTRIM(NVL(cursor_4c_DetalheProduto.CodFinP, ""))

        *-- Descricao do Subgrupo (Tmp_Sgru no legado: SigCdPsg por cgrus+codigos)
        loc_oPgN.txt_4c_DetDescSubgrupo.Value = ""
        IF !EMPTY(loc_oPgN.txt_4c_DetCodSubgrupo.Value)
            IF USED("cursor_4c_DetalheSubgrupo")
                USE IN cursor_4c_DetalheSubgrupo
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdPsg WHERE cgrus = " + ;
                    EscaparSQL(loc_oPgN.txt_4c_DetCodGrupo.Value) + " AND codigos = " + ;
                    EscaparSQL(loc_oPgN.txt_4c_DetCodSubgrupo.Value), "cursor_4c_DetalheSubgrupo") > 0 ;
                    AND USED("cursor_4c_DetalheSubgrupo") AND RECCOUNT("cursor_4c_DetalheSubgrupo") > 0
                loc_oPgN.txt_4c_DetDescSubgrupo.Value = ALLTRIM(NVL(cursor_4c_DetalheSubgrupo.descricaos, ""))
            ENDIF
            IF USED("cursor_4c_DetalheSubgrupo")
                USE IN cursor_4c_DetalheSubgrupo
            ENDIF
        ENDIF

        *-- Descricao do Modelo (getDesFinP no legado: SigCdFip por Cods=CodFinP)
        loc_oPgN.txt_4c_DetDescModelo.Value = ""
        IF !EMPTY(loc_oPgN.txt_4c_DetCodModelo.Value)
            IF USED("cursor_4c_DetalheModelo")
                USE IN cursor_4c_DetalheModelo
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdFip WHERE cods = " + ;
                    EscaparSQL(loc_oPgN.txt_4c_DetCodModelo.Value), "cursor_4c_DetalheModelo") > 0 ;
                    AND USED("cursor_4c_DetalheModelo") AND RECCOUNT("cursor_4c_DetalheModelo") > 0
                loc_oPgN.txt_4c_DetDescModelo.Value = ALLTRIM(NVL(cursor_4c_DetalheModelo.descs, ""))
            ENDIF
            IF USED("cursor_4c_DetalheModelo")
                USE IN cursor_4c_DetalheModelo
            ENDIF
        ENDIF

        *-- Preco de venda: converte para moeda padrao se configurada (SigCdPam.moedetqs)
        loc_cMoeDetqs = ""
        IF USED("cursor_4c_DetalhePam")
            USE IN cursor_4c_DetalhePam
        ENDIF
        IF SQLEXEC(gnConnHandle, "SELECT TOP 1 moedetqs FROM SigCdPam", "cursor_4c_DetalhePam") > 0 ;
                AND USED("cursor_4c_DetalhePam") AND RECCOUNT("cursor_4c_DetalhePam") > 0
            loc_cMoeDetqs = ALLTRIM(NVL(cursor_4c_DetalhePam.moedetqs, ""))
            USE IN cursor_4c_DetalhePam
        ENDIF

        IF EMPTY(loc_cMoeDetqs)
            loc_oPgN.txt_4c_DetPrecoVenda.Value = NVL(cursor_4c_DetalheProduto.pvens, 0)
            loc_oPgN.txt_4c_DetMoedaVenda.Value = ALLTRIM(NVL(cursor_4c_DetalheProduto.moevs, ""))
        ELSE
            loc_nCotAlvo  = 1
            loc_nCotVenda = 1
            IF USED("cursor_4c_DetalheCot")
                USE IN cursor_4c_DetalheCot
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
                    EscaparSQL(loc_cMoeDetqs) + " ORDER BY datas DESC", "cursor_4c_DetalheCot") > 0 ;
                    AND USED("cursor_4c_DetalheCot") AND RECCOUNT("cursor_4c_DetalheCot") > 0
                loc_nCotAlvo = NVL(cursor_4c_DetalheCot.valos, 1)
                USE IN cursor_4c_DetalheCot
            ENDIF
            loc_cMoeVenda = ALLTRIM(NVL(cursor_4c_DetalheProduto.moevs, ""))
            IF !EMPTY(loc_cMoeVenda)
                IF USED("cursor_4c_DetalheCot")
                    USE IN cursor_4c_DetalheCot
                ENDIF
                IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
                        EscaparSQL(loc_cMoeVenda) + " ORDER BY datas DESC", "cursor_4c_DetalheCot") > 0 ;
                        AND USED("cursor_4c_DetalheCot") AND RECCOUNT("cursor_4c_DetalheCot") > 0
                    loc_nCotVenda = NVL(cursor_4c_DetalheCot.valos, 1)
                    USE IN cursor_4c_DetalheCot
                ENDIF
            ENDIF
            loc_oPgN.txt_4c_DetPrecoVenda.Value = ROUND(NVL(cursor_4c_DetalheProduto.pvens, 0) * ;
                loc_nCotVenda / IIF(loc_nCotAlvo = 0, 1, loc_nCotAlvo), 2)
            loc_oPgN.txt_4c_DetMoedaVenda.Value = loc_cMoeDetqs
        ENDIF

        *-- Movimentacao de origem (Emps/Dopes/Numes a partir de OriDopNums)
        loc_cOriDopNums = ALLTRIM(NVL(cursor_4c_Disponivel.OriDopNums, ""))
        loc_oPgN.txt_4c_DetEmp.Value   = SUBSTR(loc_cOriDopNums, 1, 3)
        loc_oPgN.txt_4c_DetDopes.Value = SUBSTR(loc_cOriDopNums, 4, 20)
        loc_oPgN.txt_4c_DetNumes.Value = ALLTRIM(RIGHT(loc_cOriDopNums, 6))

        *-- Foto do produto (thumbnail decodificado do base64 em FigJpgs)
        loc_cFigJpgs = NVL(cursor_4c_DetalheProduto.FigJpgs, "")
        IF USED("cursor_4c_DetalheProduto")
            USE IN cursor_4c_DetalheProduto
        ENDIF

        loc_oPgN.img_4c_Foto.Picture = ""
        IF !EMPTY(loc_cFigJpgs) AND !ISNULL(loc_cFigJpgs)
            loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
            loc_cFoto = STRCONV(;
                STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
                    "data:image/png;base64,", ""), ;
                    "data:image/jpeg;base64,", ""), ;
                    "data:image/jpg;base64,", ""), 14)
            STRTOFILE(loc_cFoto, loc_cArqTemp)
            IF FILE(loc_cArqTemp)
                loc_oPgN.img_4c_Foto.Picture = loc_cArqTemp
            ENDIF
        ENDIF
    ENDPROC

    *-- Duplo clique na foto: abre zoom (Do Form SigOpZom no legado). Sem o
    *-- form legado no acervo, cai para o visualizador padrao do Windows
    *-- (regra #27 CLAUDE.md - nunca chamar form nao portado sem guard).
    PROCEDURE ImgFotoDblClick()
        LOCAL loc_cCpros, loc_cSQL, loc_nResultado, loc_cFigJpgs
        LOCAL loc_cArqTemp, loc_cFoto, loc_cCaption

        IF !USED("cursor_4c_Disponivel") OR RECCOUNT("cursor_4c_Disponivel") = 0
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(NVL(cursor_4c_Disponivel.Cpros, ""))
        IF EMPTY(loc_cCpros)
            RETURN
        ENDIF

        loc_cSQL = "SELECT cpros, dpros, FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
        IF USED("cursor_4c_ZoomProduto")
            USE IN cursor_4c_ZoomProduto
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ZoomProduto")

        IF loc_nResultado < 0 OR !USED("cursor_4c_ZoomProduto") OR RECCOUNT("cursor_4c_ZoomProduto") = 0
            RETURN
        ENDIF

        SELECT cursor_4c_ZoomProduto
        GO TOP
        loc_cFigJpgs = NVL(cursor_4c_ZoomProduto.FigJpgs, "")
        loc_cCaption = "Produto : " + loc_cCpros + " - " + ALLTRIM(NVL(cursor_4c_ZoomProduto.dpros, ""))
        IF USED("cursor_4c_ZoomProduto")
            USE IN cursor_4c_ZoomProduto
        ENDIF

        IF EMPTY(loc_cFigJpgs) OR ISNULL(loc_cFigJpgs)
            RETURN
        ENDIF

        loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
        loc_cFoto = STRCONV(;
            STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
                "data:image/png;base64,", ""), ;
                "data:image/jpeg;base64,", ""), ;
                "data:image/jpg;base64,", ""), 14)
        STRTOFILE(loc_cFoto, loc_cArqTemp)

        IF FILE(loc_cArqTemp)
            IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") OR ;
                    FILE(gc_4c_CaminhoForms + "FormSigOpZom.prg")
                DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") ;
                    WITH loc_cArqTemp, loc_cCaption, " "
            ELSE
                DECLARE INTEGER ShellExecute IN shell32.dll ;
                    INTEGER hWnd, STRING lpOperation, STRING lpFile, ;
                    STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
                ShellExecute(0, "open", loc_cArqTemp, "", "", 1)
            ENDIF
        ENDIF
    ENDPROC

    *-- Filtrar (fwbtng "Filtrar" no legado): filtra grd_4c_Disponivel por
    *-- Grupo/Subgrupo digitados. Legado usa Index+Set Key; aqui usamos
    *-- SET FILTER TO, mais seguro sobre cursor vindo de SQLEXEC.
    PROCEDURE BtnFiltrarDisponivelClick()
        LOCAL loc_oPgN, loc_cCodGrupo, loc_cCodSubgrupo, loc_cFiltro

        IF !USED("cursor_4c_Disponivel")
            RETURN
        ENDIF

        loc_oPgN         = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
        loc_cCodGrupo    = ALLTRIM(loc_oPgN.txt_4c_FiltroCodGrupo.Value)
        loc_cCodSubgrupo = ALLTRIM(loc_oPgN.txt_4c_FiltroCodSubgrupo.Value)

        SELECT cursor_4c_Disponivel

        DO CASE
            CASE EMPTY(loc_cCodGrupo) AND EMPTY(loc_cCodSubgrupo)
                loc_cFiltro = ""
            CASE !EMPTY(loc_cCodGrupo) AND EMPTY(loc_cCodSubgrupo)
                loc_cFiltro = "ALLTRIM(Cgrus) = " + EscaparSQL(loc_cCodGrupo)
            CASE EMPTY(loc_cCodGrupo) AND !EMPTY(loc_cCodSubgrupo)
                loc_cFiltro = "ALLTRIM(Sgrus) = " + EscaparSQL(loc_cCodSubgrupo)
            OTHERWISE
                loc_cFiltro = "ALLTRIM(Cgrus) = " + EscaparSQL(loc_cCodGrupo) + ;
                    " AND ALLTRIM(Sgrus) = " + EscaparSQL(loc_cCodSubgrupo)
        ENDCASE

        SET FILTER TO &loc_cFiltro.
        GO TOP
        loc_oPgN.grd_4c_Disponivel.Refresh()
    ENDPROC

    *-- Procurar produto na grade de disponiveis (get_produto_inicial no legado)
    PROCEDURE ValidarProdutoInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPgN, loc_cValor, loc_nRegAtual

        loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
        loc_cValor = ALLTRIM(loc_oPgN.txt_4c_ProdutoInicial.Value)

        IF EMPTY(loc_cValor) OR !USED("cursor_4c_Disponivel")
            RETURN
        ENDIF

        SELECT cursor_4c_Disponivel
        loc_nRegAtual = RECNO()
        GO TOP
        LOCATE FOR ALLTRIM(Cpros) = loc_cValor
        IF EOF()
            GO loc_nRegAtual
        ENDIF
        loc_oPgN.grd_4c_Disponivel.Refresh()
    ENDPROC

    *-- Filtro Grupo (get_cgrupo/get_dgrupo no legado) -> SigCdGrp (cgrus/dgrus)
    PROCEDURE TeclaLookupFiltroGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaFiltroGrupo()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaFiltroGrupo()
        LOCAL loc_oPgN, loc_cValorAtual, loc_oBusca
        loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
        loc_cValorAtual = ALLTRIM(loc_oPgN.txt_4c_FiltroCodGrupo.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaFiltroGrupo", "cgrus", loc_cValorAtual, "Grupos")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaFiltroGrupo")
                    loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_BuscaFiltroGrupo.cgrus)
                    loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_BuscaFiltroGrupo.dgrus)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFiltroGrupo")
                        loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_BuscaFiltroGrupo.cgrus)
                        loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_BuscaFiltroGrupo.dgrus)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaFiltroGrupo")
            USE IN cursor_4c_BuscaFiltroGrupo
        ENDIF
    ENDPROC

    PROCEDURE ValidarFiltroCodGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPgN, loc_cValor, loc_nResultado
        loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
        loc_cValor = UPPER(ALLTRIM(loc_oPgN.txt_4c_FiltroCodGrupo.Value))

        IF EMPTY(loc_cValor)
            loc_oPgN.txt_4c_FiltroDescGrupo.Value = ""
            RETURN
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp WHERE " + ;
            "CAST(cgrus AS VARCHAR(20)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroGrupo")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroGrupo") = 1
            loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroGrupo.cgrus)
            loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroGrupo.dgrus)
            IF USED("cursor_4c_ValidaFiltroGrupo")
                USE IN cursor_4c_ValidaFiltroGrupo
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaFiltroGrupo")
                USE IN cursor_4c_ValidaFiltroGrupo
            ENDIF
            loc_oPgN.txt_4c_FiltroDescGrupo.Value = ""
            THIS.AbrirBuscaFiltroGrupo()
        ENDIF
    ENDPROC

    PROCEDURE ValidarFiltroDescGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPgN, loc_cValor, loc_nResultado
        loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
        loc_cValor = UPPER(ALLTRIM(loc_oPgN.txt_4c_FiltroDescGrupo.Value))

        IF EMPTY(loc_cValor)
            loc_oPgN.txt_4c_FiltroCodGrupo.Value = ""
            RETURN
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp WHERE " + ;
            "CAST(dgrus AS VARCHAR(60)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroGrupo")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroGrupo") = 1
            loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroGrupo.cgrus)
            loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroGrupo.dgrus)
            IF USED("cursor_4c_ValidaFiltroGrupo")
                USE IN cursor_4c_ValidaFiltroGrupo
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaFiltroGrupo")
                USE IN cursor_4c_ValidaFiltroGrupo
            ENDIF
            loc_oPgN.txt_4c_FiltroCodGrupo.Value = ""
            THIS.AbrirBuscaFiltroGrupo()
        ENDIF
    ENDPROC

    *-- Filtro Subgrupo (get_csgrupo/get_dsgrupo no legado) -> SigCdPsg (codigos/descricaos)
    PROCEDURE TeclaLookupFiltroSubgrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaFiltroSubgrupo()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaFiltroSubgrupo()
        LOCAL loc_oPgN, loc_cValorAtual, loc_oBusca
        loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
        loc_cValorAtual = ALLTRIM(loc_oPgN.txt_4c_FiltroCodSubgrupo.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPsg", "cursor_4c_BuscaFiltroSubgrupo", "codigos", loc_cValorAtual, "Sub-Grupos")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaFiltroSubgrupo")
                    loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_BuscaFiltroSubgrupo.codigos)
                    loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_BuscaFiltroSubgrupo.descricaos)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("codigos", "", "Sub-Grupo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cgrus", "", "Grupo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFiltroSubgrupo")
                        loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_BuscaFiltroSubgrupo.codigos)
                        loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_BuscaFiltroSubgrupo.descricaos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaFiltroSubgrupo")
            USE IN cursor_4c_BuscaFiltroSubgrupo
        ENDIF
    ENDPROC

    PROCEDURE ValidarFiltroCodSubgrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPgN, loc_cValor, loc_nResultado
        loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
        loc_cValor = UPPER(ALLTRIM(loc_oPgN.txt_4c_FiltroCodSubgrupo.Value))

        IF EMPTY(loc_cValor)
            loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ""
            RETURN
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdPsg WHERE " + ;
            "CAST(codigos AS VARCHAR(20)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroSubgrupo")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroSubgrupo") = 1
            loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.codigos)
            loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.descricaos)
            IF USED("cursor_4c_ValidaFiltroSubgrupo")
                USE IN cursor_4c_ValidaFiltroSubgrupo
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaFiltroSubgrupo")
                USE IN cursor_4c_ValidaFiltroSubgrupo
            ENDIF
            loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ""
            THIS.AbrirBuscaFiltroSubgrupo()
        ENDIF
    ENDPROC

    PROCEDURE ValidarFiltroDescSubgrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPgN, loc_cValor, loc_nResultado
        loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
        loc_cValor = UPPER(ALLTRIM(loc_oPgN.txt_4c_FiltroDescSubgrupo.Value))

        IF EMPTY(loc_cValor)
            loc_oPgN.txt_4c_FiltroCodSubgrupo.Value = ""
            RETURN
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdPsg WHERE " + ;
            "CAST(descricaos AS VARCHAR(60)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroSubgrupo")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroSubgrupo") = 1
            loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.codigos)
            loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.descricaos)
            IF USED("cursor_4c_ValidaFiltroSubgrupo")
                USE IN cursor_4c_ValidaFiltroSubgrupo
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaFiltroSubgrupo")
                USE IN cursor_4c_ValidaFiltroSubgrupo
            ENDIF
            loc_oPgN.txt_4c_FiltroCodSubgrupo.Value = ""
            THIS.AbrirBuscaFiltroSubgrupo()
        ENDIF
    ENDPROC

    *-- Coluna "Distribuido" do grd_4c_Distribui: recalcula saldo entre
    *-- cursor_4c_Disponivel/cursor_4c_Distribui (Calcula_Saldo no legado).
    PROCEDURE DistribuidoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.RecalcularSaldoDistribuicao()
    ENDPROC

    PROCEDURE RecalcularSaldoDistribuicao()
        LOCAL loc_oPgN, loc_cCpros, loc_cCodCor, loc_cCodTam, loc_nTotalDistr

        IF !USED("cursor_4c_Distribui") OR !USED("cursor_4c_Disponivel")
            RETURN
        ENDIF

        loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3

        SELECT cursor_4c_Distribui
        IF NVL(QtdDistr, 0) <= 0
            REPLACE QtdDistr WITH 0
        ENDIF

        loc_cCpros  = ALLTRIM(NVL(cursor_4c_Disponivel.Cpros, ""))
        loc_cCodCor = ALLTRIM(NVL(cursor_4c_Disponivel.CodCors, ""))
        loc_cCodTam = ALLTRIM(NVL(cursor_4c_Disponivel.CodTams, ""))

        SELECT cursor_4c_Distribui
        SUM QtdDistr TO loc_nTotalDistr FOR ALLTRIM(NVL(Cpros, "")) = loc_cCpros ;
            AND ALLTRIM(NVL(CodCors, "")) = loc_cCodCor AND ALLTRIM(NVL(CodTams, "")) = loc_cCodTam

        IF NVL(cursor_4c_Disponivel.Sqtds, 0) - loc_nTotalDistr < 0
            MsgAviso("Saldo insuficiente para movimentar.", "Aviso")
        ENDIF

        SELECT cursor_4c_Disponivel
        REPLACE QtdSaida WITH loc_nTotalDistr, QtdSaldo WITH NVL(Sqtds, 0) - loc_nTotalDistr

        loc_oPgN.grd_4c_Disponivel.Refresh()
        loc_oPgN.grd_4c_Distribui.Refresh()
    ENDPROC

    *-- Coluna "Local" do grd_4c_Distribui -> SigPrLcl (codigos/descricaos)
    PROCEDURE TeclaLookupLocalDistribui(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaLocalDistribui()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaLocalDistribui()
        LOCAL loc_oGrid, loc_cValorAtual, loc_oBusca
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3.grd_4c_Distribui
        loc_cValorAtual = ALLTRIM(loc_oGrid.Column4.Text1.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_BuscaLocalDistribui", "codigos", loc_cValorAtual, ;
            "Buscar Localiza" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaLocalDistribui")
                    loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_BuscaLocalDistribui.codigos)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocalDistribui")
                        loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_BuscaLocalDistribui.codigos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaLocalDistribui")
            USE IN cursor_4c_BuscaLocalDistribui
        ENDIF
    ENDPROC

    PROCEDURE ValidarLocalDistribui(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrid, loc_cValor, loc_nResultado
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3.grd_4c_Distribui
        loc_cValor = UPPER(ALLTRIM(loc_oGrid.Column4.Text1.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigPrLcl WHERE " + ;
            "CAST(codigos AS VARCHAR(20)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaLocalDistribui")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaLocalDistribui") = 1
            loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_ValidaLocalDistribui.codigos)
            IF USED("cursor_4c_ValidaLocalDistribui")
                USE IN cursor_4c_ValidaLocalDistribui
            ENDIF
        ELSE
            IF USED("cursor_4c_ValidaLocalDistribui")
                USE IN cursor_4c_ValidaLocalDistribui
            ENDIF
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaLocalDistribui()
        ENDIF
    ENDPROC

    *===========================================================================
    * PGDADOSINTERNOS.PAGE4 (Movimentacoes) - handlers
    * Espelham SIGMVDIS.Pagina.Dados.Pageframe1.Page3 do legado.
    * cursor_4c_CabOpera/cursor_4c_ItnOpera ainda nao sao populados nesta fase
    * (fase futura) - todo handler que os referencia esta guardado por USED()
    * e fica inerte enquanto os cursores nao existem.
    * PUBLIC: exigido por BINDEVENT (regra #3 CLAUDE.md).
    *===========================================================================

    *-- Ativa a pagina "Itens" do pgf_4c_Operacoes: ordena/filtra
    *-- cursor_4c_ItnOpera pelo cabecalho em foco (pgItens.Activate no legado)
    PROCEDURE AtivarPgItensOperacoes()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_ItnOpera") OR !USED("cursor_4c_CabOpera")
            RETURN
        ENDIF

        SELECT cursor_4c_ItnOpera
        SET ORDER TO Ordem
        SET KEY TO cursor_4c_CabOpera.Dopes + STR(cursor_4c_CabOpera.Numes, 6) IN cursor_4c_ItnOpera
        GO TOP IN cursor_4c_ItnOpera

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page4.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
        loc_oGrid.Refresh()
        loc_oGrid.Column1.SetFocus()
    ENDPROC

    *-- Processar Distribuicao (cmdProcessar.btnProcessar no legado): mesmas
    *-- duas guard clauses do legado, transcritas literalmente (regra #21
    *-- CLAUDE.md - a condicao ao redor da validacao e regra). A geracao das
    *-- movimentacoes (crSigMvCab/crSigMvItn/crSigMvHst/crSigOpEtq/SigPrDis,
    *-- etiquetas e commit no SQL Server - cerca de 400 linhas no legado) fica
    *-- para fase futura, junto com a populacao de
    *-- cursor_4c_Disponivel/cursor_4c_Distribui (ver ConfigurarPgPage2).
    PROCEDURE BtnProcessarOperacoesClick()
        LOCAL loc_nTotalDistribuido, loc_nSaldoNegativo

        IF !USED("cursor_4c_Distribui") OR !USED("cursor_4c_Disponivel")
            RETURN
        ENDIF

        loc_nTotalDistribuido = 0
        SELECT cursor_4c_Distribui
        COUNT FOR QtdDistr > 0 TO loc_nTotalDistribuido
        IF loc_nTotalDistribuido = 0
            MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
            RETURN
        ENDIF

        loc_nSaldoNegativo = 0
        SELECT cursor_4c_Disponivel
        GO TOP
        COUNT FOR QtdSaldo < 0 TO loc_nSaldoNegativo
        IF loc_nSaldoNegativo > 0
            MsgAviso("Existe produtos distribu" + CHR(237) + "dos que est" + CHR(227) + "o ficando com saldo negativo." + CHR(13) + ;
                "Favor checar antes de processar.", "Aviso")
            RETURN
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Inicia um novo lote de distribuicao
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.BOParaForm()
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigmvdis.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega o lote selecionado em modo somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um lote de distribui" + CHR(231) + CHR(227) + "o na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

                IF THIS.this_oBusinessObject.BuscarItensPorLote(loc_cCodigo)
                    THIS.this_oBusinessObject.this_cCodigo = loc_cCodigo
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigmvdis.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega o lote selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um lote de distribui" + CHR(231) + CHR(227) + "o na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

                IF THIS.this_oBusinessObject.BuscarItensPorLote(loc_cCodigo)
                    THIS.this_oBusinessObject.this_cCodigo = loc_cCodigo
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigmvdis.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui TODOS os itens do lote selecionado
    * Espelha o legado: Delete From SigPrDis Where Codigos = ?_Codigo
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um lote de distribui" + CHR(231) + CHR(227) + "o na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

                IF MsgConfirma("Confirma exclus" + CHR(227) + "o do lote " + loc_cCodigo + "?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.ExcluirPorCodigo(loc_cCodigo)
                        MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigmvdis.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar lote de distribuicao
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo, loc_oGrid
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrDis", "cursor_4c_BuscaLote", "codigos", "", ;
                "Buscar Lote de Distribui" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("datas", "", "Data")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLote")
                    SELECT cursor_4c_BuscaLote
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaLote.codigos)
                    loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaLote")
                USE IN cursor_4c_BuscaLote
            ENDIF
        CATCH TO loc_oErro
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaLote")
                USE IN cursor_4c_BuscaLote
            ENDIF
            MsgErro(loc_oErro.Message, "Formsigmvdis.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Transfere Form->BO e grava (Inserir/Atualizar conforme
    * this_lNovoRegistro, controlado pelo BusinessBase). PUBLIC: BINDEVENT.
    * Regra #20 CLAUDE.md: falha de gravacao nunca eh muda - BusinessBase ja
    * chama ExibirFalha() em todo caminho que retorna .F.; o form so cobre o
    * caso raro de this_lErroExibido nao ter sido setado.
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Descarta alteracoes e volta para a lista
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames
    *===========================================================================
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

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        IF USED("cursor_4c_ItensLote")
            USE IN cursor_4c_ItensLote
        ENDIF

        IF USED("cursor_4c_Estoque")
            USE IN cursor_4c_Estoque
        ENDIF

        IF USED("cursor_4c_Disponivel")
            USE IN cursor_4c_Disponivel
        ENDIF

        IF USED("cursor_4c_Distribui")
            USE IN cursor_4c_Distribui
        ENDIF

        IF USED("cursor_4c_CabOpera")
            USE IN cursor_4c_CabOpera
        ENDIF

        IF USED("cursor_4c_ItnOpera")
            USE IN cursor_4c_ItnOpera
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
