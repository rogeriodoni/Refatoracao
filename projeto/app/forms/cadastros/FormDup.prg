*==============================================================================
* FormDup.prg - Formulario de Configuracao de Series de Duplicatas
* Migracao de SIGCDDUP para nova arquitetura em camadas
* Tabela: SigCnFDU | PK: series
* Herda de: FormBase (app/classes/formbase.prg)
* Fase 4/8: Grid e Botoes CRUD (Page1 completa + handlers)
*==============================================================================

DEFINE CLASS FormDup AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity - SIGCDDUP 1000x600)
    Height      = 600
    Width       = 1000
    Caption     = "Configura" + CHR(231) + CHR(227) + "o de S" + CHR(233) + "ries de Duplicatas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de negocio
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Inicializa o formulario
    * FormBase.Init() chama InicializarForm() automaticamente
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro ao inicializar FormDup:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DupBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar DupBO", "Erro")
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
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inicializar formulario:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .PageCount  = 2
                .Top        = -29
                .Left       = 0
                .Width      = THIS.Width
                .Height     = THIS.Height + 29
                .Tabs       = .F.
                .Visible    = .T.
                .Page1.Caption   = "Lista"
                .Page1.BackColor = RGB(236, 236, 236)
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Caption   = "Dados"
                .Page2.BackColor = RGB(236, 236, 236)
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loException
            MsgErro("Erro ao configurar PageFrame:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 completa
    * Cabecalho + botoes CRUD + Encerrar + grid + botao Copiar + painel flutuante
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container cabecalho (cntSombra no legado) - Top=2 dentro da Page
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 2
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

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

            *-- Container botoes CRUD (Grupo_Op no legado) - lado direito
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

                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
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
                ENDWITH

                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 80
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
                ENDWITH

                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 155
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
                ENDWITH

                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 230
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
                ENDWITH

                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 305
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
                ENDWITH
            ENDWITH

            *-- Container saida - padrao canonico (CLAUDE.md regra #10)
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
                    .Width           = 90
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
                ENDWITH
            ENDWITH

            *-- Botao Copiar (Copia no legado) - original top=4 -> migrado 4+29=33
            loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
            WITH loc_oPagina.cmd_4c_Copia
                .Caption         = "Copiar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 474
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

            *-- Grade principal - cursor_4c_Dados / series
            *-- Top=117 = 88 (posicao padrao framework) + 29 (compensacao PageFrame)
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (series C(3))
            ENDIF
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oPagina.grd_4c_Lista.ColumnCount = 1
            loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
            loc_oPagina.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.series"
            WITH loc_oPagina.grd_4c_Lista
                .Top                = 117
                .Left               = 12
                .Width              = 890
                .Height             = 490
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
                .Visible            = .T.

                WITH .Column1
                    .ControlSource    = "cursor_4c_Dados.series"
                    .Width            = 100
                    .Resizable        = .T.
                    .Header1.Caption  = "S" + CHR(233) + "rie"
                ENDWITH
            ENDWITH

            *-- Painel flutuante de copia de series (cntcopia no legado - Visible=.F.)
            *-- Top=270 = 241 (original) + 29 (compensacao PageFrame)
            *-- Nome "cnt_4c_CopiaFl" -> UPPER = "CNT_4C_COPIAFL" (guardado em TornarControlesVisiveis)
            loc_oPagina.AddObject("cnt_4c_CopiaFl", "Container")
            WITH loc_oPagina.cnt_4c_CopiaFl
                .Top         = 270
                .Left        = 335
                .Width       = 317
                .Height      = 123
                .BackColor   = RGB(220, 220, 220)
                .BorderWidth = 1
                .Visible     = .F.

                .AddObject("lbl_4c_LblSerieOrigem", "Label")
                WITH .lbl_4c_LblSerieOrigem
                    .Caption   = "S" + CHR(233) + "rie Origem :"
                    .Top       = 40
                    .Left      = 29
                    .Width     = 72
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_SeriesOrigem", "TextBox")
                WITH .txt_4c_SeriesOrigem
                    .Top      = 36
                    .Left     = 103
                    .Width    = 34
                    .Height   = 24
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Value    = ""
                    .ReadOnly = .T.
                    .Visible  = .T.
                ENDWITH

                .AddObject("lbl_4c_LblSerieDestino", "Label")
                WITH .lbl_4c_LblSerieDestino
                    .Caption   = "S" + CHR(233) + "rie Destino :"
                    .Top       = 66
                    .Left      = 27
                    .Width     = 72
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_SerieDestino", "TextBox")
                WITH .txt_4c_SerieDestino
                    .Top      = 62
                    .Left     = 103
                    .Width    = 34
                    .Height   = 24
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Value    = ""
                    .Visible  = .T.
                ENDWITH

                .AddObject("cmd_4c_OKCopia", "CommandButton")
                WITH .cmd_4c_OKCopia
                    .Caption       = "Confirmar"
                    .Top           = 5
                    .Left          = 158
                    .Width         = 75
                    .Height        = 75
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .ForeColor     = RGB(90, 90, 90)
                    .BackColor     = RGB(255, 255, 255)
                    .Themes        = .F.
                    .SpecialEffect = 0
                    .MousePointer  = 15
                    .Visible       = .T.
                ENDWITH

                .AddObject("cmd_4c_CancelarCopia", "CommandButton")
                WITH .cmd_4c_CancelarCopia
                    .Caption       = "Cancelar"
                    .Top           = 5
                    .Left          = 239
                    .Width         = 75
                    .Height        = 75
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .ForeColor     = RGB(90, 90, 90)
                    .BackColor     = RGB(255, 255, 255)
                    .Themes        = .F.
                    .SpecialEffect = 0
                    .MousePointer  = 15
                    .Visible       = .T.
                ENDWITH
            ENDWITH

            *-- BINDEVENTs da Page1
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,        "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,     "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,        "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,        "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,         "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,        "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(loc_oPagina.cmd_4c_Copia,                        "Click", THIS, "BtnCopiarClick")
            BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_OKCopia,       "Click", THIS, "BtnOKCopiarClick")
            BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiarClick")
            BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.txt_4c_SerieDestino,  "KeyPress", THIS, "ValidarSerieDestino")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MsgErro("Erro ao configurar Page1:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Fase 5: Serie, Cabecalho e primeira linha do Sacado
    * Fase 6: Segunda linha Sacado, Observacao e Impressora (a adicionar)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *------------------------------------------------------------------
            * SERIE (PK) - txt_4c_Series: top=70+29=99 / Label40: top=72+29=101
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_LblSerie", "Label")
            WITH loc_oPagina.lbl_4c_LblSerie
                .Caption   = "S" + CHR(233) + "rie :"
                .Top       = 101
                .Left      = 185
                .Width     = 37
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Series", "TextBox")
            WITH loc_oPagina.txt_4c_Series
                .Value    = ""
                .Top      = 99
                .Left     = 229
                .Width    = 31
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *------------------------------------------------------------------
            * SECAO CABECALHO (linha/coluna impressao dados do documento)
            * Label27 top=103+29=132 / Shape1 top=119+29=148
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_SecCabecalho", "Label")
            WITH loc_oPagina.lbl_4c_SecCabecalho
                .Caption   = "Cabe" + CHR(231) + "alho"
                .Top       = 132
                .Left      = 183
                .Width     = 80
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPagina.shp_4c_Shape1
                .Top           = 148
                .Left          = 173
                .Width         = 560
                .Height        = 2
                .FillColor     = RGB(150, 150, 150)
                .ForeColor     = RGB(150, 150, 150)
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Data Emissao (Label5/Text5/Label6/Text6) top=124+29=153 / 138+29=167
            loc_oPagina.AddObject("lbl_4c_LblDtDoc", "Label")
            WITH loc_oPagina.lbl_4c_LblDtDoc
                .Caption   = "Data Emiss" + CHR(227) + "o"
                .Top       = 153
                .Left      = 184
                .Width     = 66
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text5", "TextBox")
            WITH loc_oPagina.txt_4c_Text5
                .Value    = 0
                .Top      = 167
                .Left     = 184
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XDtDoc", "Label")
            WITH loc_oPagina.lbl_4c_XDtDoc
                .Caption   = "x"
                .Top       = 169
                .Left      = 226
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text6", "TextBox")
            WITH loc_oPagina.txt_4c_Text6
                .Value    = 0
                .Top      = 167
                .Left     = 233
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Nota Fiscal (Label1/Text1/Label2/Text2) top=153 / 167
            loc_oPagina.AddObject("lbl_4c_LblNota", "Label")
            WITH loc_oPagina.lbl_4c_LblNota
                .Caption   = "Nota Fiscal"
                .Top       = 153
                .Left      = 293
                .Width     = 54
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text1", "TextBox")
            WITH loc_oPagina.txt_4c_Text1
                .Value    = 0
                .Top      = 167
                .Left     = 293
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XNota", "Label")
            WITH loc_oPagina.lbl_4c_XNota
                .Caption   = "x"
                .Top       = 169
                .Left      = 335
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text2", "TextBox")
            WITH loc_oPagina.txt_4c_Text2
                .Value    = 0
                .Top      = 167
                .Left     = 342
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Valor da Duplicata (Label9/Text9/Label10/Text10)
            loc_oPagina.AddObject("lbl_4c_LblVlDoc", "Label")
            WITH loc_oPagina.lbl_4c_LblVlDoc
                .Caption   = "Valor da Duplicata"
                .Top       = 153
                .Left      = 403
                .Width     = 88
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text9", "TextBox")
            WITH loc_oPagina.txt_4c_Text9
                .Value    = 0
                .Top      = 168
                .Left     = 403
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XVlDoc", "Label")
            WITH loc_oPagina.lbl_4c_XVlDoc
                .Caption   = "x"
                .Top       = 169
                .Left      = 445
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text10", "TextBox")
            WITH loc_oPagina.txt_4c_Text10
                .Value    = 0
                .Top      = 168
                .Left     = 452
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- N da Duplicata (Label7/Text7/Label8/Text8)
            loc_oPagina.AddObject("lbl_4c_LblNrDoc", "Label")
            WITH loc_oPagina.lbl_4c_LblNrDoc
                .Caption   = "N" + CHR(176) + " da Duplicata"
                .Top       = 153
                .Left      = 513
                .Width     = 76
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text7", "TextBox")
            WITH loc_oPagina.txt_4c_Text7
                .Value    = 0
                .Top      = 167
                .Left     = 513
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XNrDoc", "Label")
            WITH loc_oPagina.lbl_4c_XNrDoc
                .Caption   = "x"
                .Top       = 169
                .Left      = 555
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text8", "TextBox")
            WITH loc_oPagina.txt_4c_Text8
                .Value    = 0
                .Top      = 167
                .Left     = 562
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Vencimento (Label3/Text3/Label4/Text4)
            loc_oPagina.AddObject("lbl_4c_LblDtVenc", "Label")
            WITH loc_oPagina.lbl_4c_LblDtVenc
                .Caption   = "Vencimento"
                .Top       = 153
                .Left      = 623
                .Width     = 57
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text3", "TextBox")
            WITH loc_oPagina.txt_4c_Text3
                .Value    = 0
                .Top      = 167
                .Left     = 623
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XDtVenc", "Label")
            WITH loc_oPagina.lbl_4c_XDtVenc
                .Caption   = "x"
                .Top       = 169
                .Left      = 665
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text4", "TextBox")
            WITH loc_oPagina.txt_4c_Text4
                .Value    = 0
                .Top      = 167
                .Left     = 672
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *------------------------------------------------------------------
            * SECAO SACADO - primeira linha (linha/coluna dados do cliente)
            * Label31 top=174+29=203 / Shape3 top=190+29=219
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_SecSacado", "Label")
            WITH loc_oPagina.lbl_4c_SecSacado
                .Caption   = "Sacado"
                .Top       = 203
                .Left      = 183
                .Width     = 43
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
            WITH loc_oPagina.shp_4c_Shape3
                .Top           = 219
                .Left          = 173
                .Width         = 560
                .Height        = 2
                .FillColor     = RGB(150, 150, 150)
                .ForeColor     = RGB(150, 150, 150)
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Razao Social (Label13/Text15/Label14/Text16) top=195+29=224 / 210+29=239
            loc_oPagina.AddObject("lbl_4c_LblRazCli", "Label")
            WITH loc_oPagina.lbl_4c_LblRazCli
                .Caption   = "Raz" + CHR(227) + "o Social"
                .Top       = 224
                .Left      = 183
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text15", "TextBox")
            WITH loc_oPagina.txt_4c_Text15
                .Value    = 0
                .Top      = 239
                .Left     = 183
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XRazCli", "Label")
            WITH loc_oPagina.lbl_4c_XRazCli
                .Caption   = "x"
                .Top       = 240
                .Left      = 225
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text16", "TextBox")
            WITH loc_oPagina.txt_4c_Text16
                .Value    = 0
                .Top      = 239
                .Left     = 232
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- C.G.C./C.P.F. (Label15/Text17/Label16/Text18)
            loc_oPagina.AddObject("lbl_4c_LblCgcCli", "Label")
            WITH loc_oPagina.lbl_4c_LblCgcCli
                .Caption   = "C.G.C./C.P.F."
                .Top       = 224
                .Left      = 293
                .Width     = 70
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text17", "TextBox")
            WITH loc_oPagina.txt_4c_Text17
                .Value    = 0
                .Top      = 239
                .Left     = 293
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XCgcCli", "Label")
            WITH loc_oPagina.lbl_4c_XCgcCli
                .Caption   = "x"
                .Top       = 240
                .Left      = 335
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text18", "TextBox")
            WITH loc_oPagina.txt_4c_Text18
                .Value    = 0
                .Top      = 239
                .Left     = 342
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Insc. Estadual (Label11/Text11/Label12/Text12)
            loc_oPagina.AddObject("lbl_4c_LblEstCli", "Label")
            WITH loc_oPagina.lbl_4c_LblEstCli
                .Caption   = "Insc. Estadual"
                .Top       = 224
                .Left      = 403
                .Width     = 70
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text11", "TextBox")
            WITH loc_oPagina.txt_4c_Text11
                .Value    = 0
                .Top      = 239
                .Left     = 403
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XEstCli", "Label")
            WITH loc_oPagina.lbl_4c_XEstCli
                .Caption   = "x"
                .Top       = 240
                .Left      = 445
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text12", "TextBox")
            WITH loc_oPagina.txt_4c_Text12
                .Value    = 0
                .Top      = 239
                .Left     = 452
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Valor por Extenso (Label28/Text13/Label29/Text14)
            loc_oPagina.AddObject("lbl_4c_LblExtens", "Label")
            WITH loc_oPagina.lbl_4c_LblExtens
                .Caption   = "Valor por Extenso"
                .Top       = 223
                .Left      = 516
                .Width     = 87
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text13", "TextBox")
            WITH loc_oPagina.txt_4c_Text13
                .Value    = 0
                .Top      = 238
                .Left     = 516
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XExtens", "Label")
            WITH loc_oPagina.lbl_4c_XExtens
                .Caption   = "x"
                .Top       = 239
                .Left      = 558
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text14", "TextBox")
            WITH loc_oPagina.txt_4c_Text14
                .Value    = 0
                .Top      = 238
                .Left     = 565
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Praca (Label30/Text32/Label37/Text33)
            loc_oPagina.AddObject("lbl_4c_LblPraca", "Label")
            WITH loc_oPagina.lbl_4c_LblPraca
                .Caption   = "Pra" + CHR(231) + "a"
                .Top       = 224
                .Left      = 626
                .Width     = 32
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text32", "TextBox")
            WITH loc_oPagina.txt_4c_Text32
                .Value    = 0
                .Top      = 239
                .Left     = 626
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XPraca", "Label")
            WITH loc_oPagina.lbl_4c_XPraca
                .Caption   = "x"
                .Top       = 240
                .Left      = 668
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text33", "TextBox")
            WITH loc_oPagina.txt_4c_Text33
                .Value    = 0
                .Top      = 239
                .Left     = 675
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *------------------------------------------------------------------
            * SACADO - segunda linha: Endereco, Bairro, CEP, Cidade, UF
            * Shapes Shape2 e Shape6 top=289+29=318
            *------------------------------------------------------------------
            loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPagina.shp_4c_Shape2
                .Top           = 318
                .Left          = 174
                .Width         = 262
                .Height        = 2
                .FillColor     = RGB(150, 150, 150)
                .ForeColor     = RGB(150, 150, 150)
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
            WITH loc_oPagina.shp_4c_Shape6
                .Top           = 318
                .Left          = 437
                .Width         = 217
                .Height        = 2
                .FillColor     = RGB(150, 150, 150)
                .ForeColor     = RGB(150, 150, 150)
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Endereco (Label17/Text19/lbl_4c_XEnd/Text20) top=229+29=258 / 244+29=273
            loc_oPagina.AddObject("lbl_4c_LblEnd", "Label")
            WITH loc_oPagina.lbl_4c_LblEnd
                .Caption   = "Endere" + CHR(231) + "o"
                .Top       = 258
                .Left      = 183
                .Width     = 47
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text19", "TextBox")
            WITH loc_oPagina.txt_4c_Text19
                .Value    = 0
                .Top      = 273
                .Left     = 183
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XEnd", "Label")
            WITH loc_oPagina.lbl_4c_XEnd
                .Caption   = "x"
                .Top       = 275
                .Left      = 225
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text20", "TextBox")
            WITH loc_oPagina.txt_4c_Text20
                .Value    = 0
                .Top      = 273
                .Left     = 232
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Bairro (Label19/Text21/Label20/Text22)
            loc_oPagina.AddObject("lbl_4c_LblBairro", "Label")
            WITH loc_oPagina.lbl_4c_LblBairro
                .Caption   = "Bairro"
                .Top       = 258
                .Left      = 293
                .Width     = 30
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text21", "TextBox")
            WITH loc_oPagina.txt_4c_Text21
                .Value    = 0
                .Top      = 273
                .Left     = 293
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XBairro", "Label")
            WITH loc_oPagina.lbl_4c_XBairro
                .Caption   = "x"
                .Top       = 274
                .Left      = 335
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text22", "TextBox")
            WITH loc_oPagina.txt_4c_Text22
                .Value    = 0
                .Top      = 273
                .Left     = 342
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- C.E.P. (Label25/Text27/Label26/Text28)
            loc_oPagina.AddObject("lbl_4c_LblCep", "Label")
            WITH loc_oPagina.lbl_4c_LblCep
                .Caption   = "C.E.P."
                .Top       = 259
                .Left      = 403
                .Width     = 33
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text27", "TextBox")
            WITH loc_oPagina.txt_4c_Text27
                .Value    = 0
                .Top      = 273
                .Left     = 403
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XCep", "Label")
            WITH loc_oPagina.lbl_4c_XCep
                .Caption   = "x"
                .Top       = 274
                .Left      = 445
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text28", "TextBox")
            WITH loc_oPagina.txt_4c_Text28
                .Value    = 0
                .Top      = 273
                .Left     = 452
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Cidade (Label21/Text23/Label22/Text24)
            loc_oPagina.AddObject("lbl_4c_LblCidade", "Label")
            WITH loc_oPagina.lbl_4c_LblCidade
                .Caption   = "Cidade"
                .Top       = 259
                .Left      = 516
                .Width     = 35
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text23", "TextBox")
            WITH loc_oPagina.txt_4c_Text23
                .Value    = 0
                .Top      = 273
                .Left     = 516
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XCidade", "Label")
            WITH loc_oPagina.lbl_4c_XCidade
                .Caption   = "x"
                .Top       = 274
                .Left      = 558
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text24", "TextBox")
            WITH loc_oPagina.txt_4c_Text24
                .Value    = 0
                .Top      = 273
                .Left     = 565
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- U.F. (Label23/Text25/Label24/Text26)
            loc_oPagina.AddObject("lbl_4c_LblUF", "Label")
            WITH loc_oPagina.lbl_4c_LblUF
                .Caption   = "U.F."
                .Top       = 259
                .Left      = 626
                .Width     = 23
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text25", "TextBox")
            WITH loc_oPagina.txt_4c_Text25
                .Value    = 0
                .Top      = 273
                .Left     = 626
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XUF", "Label")
            WITH loc_oPagina.lbl_4c_XUF
                .Caption   = "x"
                .Top       = 274
                .Left      = 668
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text26", "TextBox")
            WITH loc_oPagina.txt_4c_Text26
                .Value    = 0
                .Top      = 273
                .Left     = 675
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *------------------------------------------------------------------
            * SECAO OBSERVACAO
            * Label44 (Observacao) top=273+29=302
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_SecObs", "Label")
            WITH loc_oPagina.lbl_4c_SecObs
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
                .Top       = 302
                .Left      = 184
                .Width     = 69
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Obs linha/coluna (Text36/lbl_4c_XObs/Text37) top=292+29=321 / 304+29=333
            loc_oPagina.AddObject("txt_4c_Text36", "TextBox")
            WITH loc_oPagina.txt_4c_Text36
                .Value    = 0
                .Top      = 333
                .Left     = 184
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XObs", "Label")
            WITH loc_oPagina.lbl_4c_XObs
                .Caption   = "x"
                .Top       = 335
                .Left      = 227
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text37", "TextBox")
            WITH loc_oPagina.txt_4c_Text37
                .Value    = 0
                .Top      = 333
                .Left     = 233
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- N Colunas/N Linhas Obs (Label42/Text38/Label43/Text39) top=292+29=321 / 304+29=333
            loc_oPagina.AddObject("lbl_4c_LblNcol", "Label")
            WITH loc_oPagina.lbl_4c_LblNcol
                .Caption   = "N" + CHR(176) + " Colunas"
                .Top       = 321
                .Left      = 298
                .Width     = 55
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text38", "TextBox")
            WITH loc_oPagina.txt_4c_Text38
                .Value    = 0
                .Top      = 333
                .Left     = 298
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_LblNlin", "Label")
            WITH loc_oPagina.lbl_4c_LblNlin
                .Caption   = "N" + CHR(176) + " Linhas"
                .Top       = 321
                .Left      = 369
                .Width     = 47
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text39", "TextBox")
            WITH loc_oPagina.txt_4c_Text39
                .Value    = 0
                .Top      = 333
                .Left     = 369
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Valor da NF linha/coluna (Label38/Text34/Label39/Text35) top=291+29=320 / 306+29=335
            loc_oPagina.AddObject("lbl_4c_LblVlNF", "Label")
            WITH loc_oPagina.lbl_4c_LblVlNF
                .Caption   = "Valor da NF"
                .Top       = 320
                .Left      = 443
                .Width     = 57
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text34", "TextBox")
            WITH loc_oPagina.txt_4c_Text34
                .Value    = 0
                .Top      = 335
                .Left     = 443
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XVlNF", "Label")
            WITH loc_oPagina.lbl_4c_XVlNF
                .Caption   = "x"
                .Top       = 336
                .Left      = 485
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text35", "TextBox")
            WITH loc_oPagina.txt_4c_Text35
                .Value    = 0
                .Top      = 335
                .Left     = 492
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Codigo linha/coluna (Label45/Text41/Label46/Text42) top=291+29=320 / 306+29=335
            loc_oPagina.AddObject("lbl_4c_LblCod", "Label")
            WITH loc_oPagina.lbl_4c_LblCod
                .Caption   = "C" + CHR(243) + "digo"
                .Top       = 320
                .Left      = 556
                .Width     = 35
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text41", "TextBox")
            WITH loc_oPagina.txt_4c_Text41
                .Value    = 0
                .Top      = 335
                .Left     = 556
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            loc_oPagina.AddObject("lbl_4c_XCod", "Label")
            WITH loc_oPagina.lbl_4c_XCod
                .Caption   = "x"
                .Top       = 336
                .Left      = 598
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text42", "TextBox")
            WITH loc_oPagina.txt_4c_Text42
                .Value    = 0
                .Top      = 335
                .Left     = 605
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Shape4: separador top=354+29=383
            loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
            WITH loc_oPagina.shp_4c_Shape4
                .Top           = 383
                .Left          = 173
                .Width         = 263
                .Height        = 2
                .FillColor     = RGB(150, 150, 150)
                .ForeColor     = RGB(150, 150, 150)
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *------------------------------------------------------------------
            * SECAO IMPRESSORA / FONTE
            * Label35 top=338+29=367
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_SecImpr", "Label")
            WITH loc_oPagina.lbl_4c_SecImpr
                .Caption   = "Impressora / Fonte"
                .Top       = 367
                .Left      = 183
                .Width     = 112
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Nome da Impressora (Label32/Text29) top=359+29=388 / 373+29=402
            loc_oPagina.AddObject("lbl_4c_LblNomeImp", "Label")
            WITH loc_oPagina.lbl_4c_LblNomeImp
                .Caption   = "Nome da Impressora"
                .Top       = 388
                .Left      = 183
                .Width     = 101
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text29", "TextBox")
            WITH loc_oPagina.txt_4c_Text29
                .Value    = ""
                .Top      = 402
                .Left     = 183
                .Width    = 240
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Fonte Padrao (Label33/Text30) top=392+29=421 / 406+29=435
            loc_oPagina.AddObject("lbl_4c_LblFonte", "Label")
            WITH loc_oPagina.lbl_4c_LblFonte
                .Caption   = "Fonte Padr" + CHR(227) + "o"
                .Top       = 421
                .Left      = 183
                .Width     = 67
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text30", "TextBox")
            WITH loc_oPagina.txt_4c_Text30
                .Value    = ""
                .Top      = 435
                .Left     = 183
                .Width    = 192
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Tamanho da Fonte (Label34/Text31) top=392+29=421 / 406+29=435
            loc_oPagina.AddObject("lbl_4c_LblTamFonte", "Label")
            WITH loc_oPagina.lbl_4c_LblTamFonte
                .Caption   = "Tamanho"
                .Top       = 421
                .Left      = 384
                .Width     = 46
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text31", "TextBox")
            WITH loc_oPagina.txt_4c_Text31
                .Value    = 0
                .Top      = 435
                .Left     = 384
                .Width    = 41
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Tamanho da Folha (Label47/Text40) top=424+29=453 / 439+29=468
            loc_oPagina.AddObject("lbl_4c_LblTamFolha", "Label")
            WITH loc_oPagina.lbl_4c_LblTamFolha
                .Caption   = "Tamanho da Folha"
                .Top       = 453
                .Left      = 183
                .Width     = 90
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPagina.AddObject("txt_4c_Text40", "TextBox")
            WITH loc_oPagina.txt_4c_Text40
                .Value    = ""
                .Top      = 468
                .Left     = 183
                .Width    = 240
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *------------------------------------------------------------------
            * BOTOES DE ACAO (Confirmar / Cancelar) - Grupo_Salva no legado
            *-- Top=33 = 4 (original) + 29 (compensacao PageFrame)
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
                ENDWITH
            ENDWITH

            *-- BINDEVENTs da Page2
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MsgErro("Erro ao configurar Page2:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega e vincula dados na grade Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            loc_lResultado = .T.
        ELSE
            TRY
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 1
                    loc_oGrid.RecordSource              = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.series"
                    loc_oGrid.Column1.Width             = 100
                    loc_oGrid.Column1.Header1.Caption   = "S" + CHR(233) + "rie"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir nova serie (navega para Page2)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.pgf_4c_Paginas.ActivePage = 2
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
        ELSE
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar serie selecionada (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cSeries
        loc_cSeries = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
        ENDIF

        IF EMPTY(loc_cSeries)
            MsgAviso("Selecione uma s" + CHR(233) + "rie na lista.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSeries)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.pgf_4c_Paginas.ActivePage = 2
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar serie selecionada
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cSeries
        loc_cSeries = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
        ENDIF

        IF EMPTY(loc_cSeries)
            MsgAviso("Selecione uma s" + CHR(233) + "rie na lista.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSeries)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.pgf_4c_Paginas.ActivePage = 2
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Text5", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Text5.SetFocus
            ELSE
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir serie selecionada
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cSeries, loc_lResultado
        loc_cSeries  = ""
        loc_lResultado = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
        ENDIF

        IF EMPTY(loc_cSeries)
            MsgAviso("Selecione uma s" + CHR(233) + "rie na lista.", "Aviso")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da s" + CHR(233) + "rie '" + ;
                       loc_cSeries + "'?", "Confirmar Exclus" + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSeries)
                loc_lResultado = THIS.this_oBusinessObject.Excluir()
                IF loc_lResultado
                    MsgSucesso("S" + CHR(233) + "rie exclu" + CHR(237) + "da com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Buscar/filtrar series (navega para Page2 em modo BUSCAR)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "BUSCAR"
        THIS.pgf_4c_Paginas.ActivePage = 2
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
        ELSE
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirmar na Page2 (salva ou busca conforme modo)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_cFiltro
        loc_lResultado = .F.
        loc_cFiltro    = ""

        IF THIS.this_cModoAtual = "BUSCAR"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
                loc_cFiltro = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value)
            ENDIF
            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 1
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource            = "cursor_4c_Dados"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.series"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "S" + CHR(233) + "rie"
                THIS.FormatarGridLista(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista)
                THIS.this_cModoAtual = "LISTA"
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
            ENDIF
            RETURN
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "VISUALIZAR")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        THIS.FormParaBO()

        loc_lResultado = THIS.this_oBusinessObject.Salvar()
        IF loc_lResultado
            MsgSucesso("Registro salvo com sucesso!")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar na Page2 e voltar para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnCopiarClick - Exibe painel flutuante para copiar serie selecionada
    * Logica baseada no legado: SIGCDDUP.Pagina.Lista.Copia.Click
    *==========================================================================
    PROCEDURE BtnCopiarClick()
        LOCAL loc_oPg1, loc_cSeries
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cSeries = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
        ENDIF

        IF EMPTY(loc_cSeries)
            MsgAviso("Selecione uma s" + CHR(233) + "rie para copiar.", "Aviso")
            RETURN
        ENDIF

        *-- Desabilitar controles durante a copia (como no legado)
        loc_oPg1.cnt_4c_Botoes.Enabled = .F.
        loc_oPg1.grd_4c_Lista.Enabled  = .F.
        loc_oPg1.cnt_4c_Saida.Enabled  = .F.
        loc_oPg1.cmd_4c_Copia.Enabled  = .F.

        *-- Preencher e exibir painel
        loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value  = loc_cSeries
        loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value  = ""
        loc_oPg1.cnt_4c_CopiaFl.Visible                    = .T.
        loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
    ENDPROC

    *==========================================================================
    * BtnOKCopiarClick - Executa copia da serie
    * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.OK.Click
    *==========================================================================
    PROCEDURE BtnOKCopiarClick()
        LOCAL loc_oPg1, loc_cSerieOrigem, loc_cSerieDestino
        LOCAL loc_cSQLCheck, loc_nCheck, loc_lResultado
        loc_oPg1          = THIS.pgf_4c_Paginas.Page1
        loc_cSerieOrigem  = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value)
        loc_cSerieDestino = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value)
        loc_lResultado    = .F.

        IF EMPTY(loc_cSerieDestino)
            MsgAviso("Informe a s" + CHR(233) + "rie de Destino...", "Aviso")
            loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
            RETURN
        ENDIF

        *-- Verificar se destino ja existe em SigCnFDU
        loc_cSQLCheck = "SELECT 1 AS existe FROM SigCnFDU WHERE series = " + ;
                        EscaparSQL(loc_cSerieDestino)
        loc_nCheck = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_CopiaChk")
        IF loc_nCheck >= 0 AND RECCOUNT("cursor_4c_CopiaChk") > 0
            MsgAviso("A s" + CHR(233) + "rie de Destino j" + CHR(225) + ;
                     " est" + CHR(225) + " cadastrada...", "Aviso")
            IF USED("cursor_4c_CopiaChk")
                USE IN cursor_4c_CopiaChk
            ENDIF
            loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
            RETURN
        ENDIF
        IF USED("cursor_4c_CopiaChk")
            USE IN cursor_4c_CopiaChk
        ENDIF

        *-- Copiar: carregar propriedades da origem, criar novo com serie destino
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSerieOrigem)
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_oBusinessObject.this_cSeries = loc_cSerieDestino
            loc_lResultado = THIS.this_oBusinessObject.Salvar()
            IF loc_lResultado
                MsgSucesso("S" + CHR(233) + "rie copiada com sucesso!")
                THIS.BtnCancelarCopiarClick()
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarCopiarClick - Cancela copia e restaura controles
    * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.Cancela.Click
    *==========================================================================
    PROCEDURE BtnCancelarCopiarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_oPg1.cnt_4c_Botoes.Enabled = .T.
        loc_oPg1.grd_4c_Lista.Enabled  = .T.
        loc_oPg1.cnt_4c_Saida.Enabled  = .T.
        loc_oPg1.cmd_4c_Copia.Enabled  = .T.
        loc_oPg1.cnt_4c_CopiaFl.Visible = .F.
        loc_oPg1.grd_4c_Lista.SetFocus
    ENDPROC

    *==========================================================================
    * ValidarSerieDestino - Abre lookup de series ao sair do campo destino
    * Baseado no legado: SIGCDDUP.Pagina.Lista.cntcopia.nomedest.Valid
    * Tabela SigCdSer (series disponiveis)
    *==========================================================================
    PROCEDURE ValidarSerieDestino
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg1, loc_cSerieDest, loc_oBusca
        loc_oPg1      = THIS.pgf_4c_Paginas.Page1
        loc_cSerieDest = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value)

        IF EMPTY(loc_cSerieDest)
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdSer", "cursor_4c_BuscaSer", "cods", loc_cSerieDest, ;
            "S" + CHR(233) + "ries")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
                    loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value = ;
                        ALLTRIM(cursor_4c_BuscaSer.cods)
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaSer")
            USE IN cursor_4c_BuscaSer
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos de Page2 para o BO
    * Implementacao completa adicionada nas Fases 5-6
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Serie (PK): apenas no modo INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            IF PEMSTATUS(loc_oPg2, "txt_4c_Series", 5)
                THIS.this_oBusinessObject.this_cSeries = ALLTRIM(loc_oPg2.txt_4c_Series.Value)
            ENDIF
        ENDIF

        *-- Cabecalho: Data Emissao
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
            THIS.this_oBusinessObject.this_nNlnDtDocs = loc_oPg2.txt_4c_Text5.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
            THIS.this_oBusinessObject.this_nNclDtDocs = loc_oPg2.txt_4c_Text6.Value
        ENDIF

        *-- Cabecalho: Nota Fiscal
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
            THIS.this_oBusinessObject.this_nNlnNotas = loc_oPg2.txt_4c_Text1.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
            THIS.this_oBusinessObject.this_nNclNotas = loc_oPg2.txt_4c_Text2.Value
        ENDIF

        *-- Cabecalho: Valor da Duplicata
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
            THIS.this_oBusinessObject.this_nNlnVlDocs = loc_oPg2.txt_4c_Text9.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
            THIS.this_oBusinessObject.this_nNclVlDocs = loc_oPg2.txt_4c_Text10.Value
        ENDIF

        *-- Cabecalho: N da Duplicata
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
            THIS.this_oBusinessObject.this_nNlnNrDocs = loc_oPg2.txt_4c_Text7.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
            THIS.this_oBusinessObject.this_nNclNrDocs = loc_oPg2.txt_4c_Text8.Value
        ENDIF

        *-- Cabecalho: Vencimento
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
            THIS.this_oBusinessObject.this_nNlnDtVencs = loc_oPg2.txt_4c_Text3.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
            THIS.this_oBusinessObject.this_nNclDtVencs = loc_oPg2.txt_4c_Text4.Value
        ENDIF

        *-- Sacado: Razao Social
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
            THIS.this_oBusinessObject.this_nNlnRazClis = loc_oPg2.txt_4c_Text15.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text16", 5)
            THIS.this_oBusinessObject.this_nNclRazClis = loc_oPg2.txt_4c_Text16.Value
        ENDIF

        *-- Sacado: C.G.C./C.P.F.
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text17", 5)
            THIS.this_oBusinessObject.this_nNlnCgcClis = loc_oPg2.txt_4c_Text17.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text18", 5)
            THIS.this_oBusinessObject.this_nNclCgcClis = loc_oPg2.txt_4c_Text18.Value
        ENDIF

        *-- Sacado: Insc. Estadual
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
            THIS.this_oBusinessObject.this_nNlnEstClis = loc_oPg2.txt_4c_Text11.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
            THIS.this_oBusinessObject.this_nNclEstClis = loc_oPg2.txt_4c_Text12.Value
        ENDIF

        *-- Sacado: Valor por Extenso
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
            THIS.this_oBusinessObject.this_nNlnExtens = loc_oPg2.txt_4c_Text13.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
            THIS.this_oBusinessObject.this_nNclExtens = loc_oPg2.txt_4c_Text14.Value
        ENDIF

        *-- Sacado: Praca
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text32", 5)
            THIS.this_oBusinessObject.this_nNlPracas = loc_oPg2.txt_4c_Text32.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text33", 5)
            THIS.this_oBusinessObject.this_nNcPracas = loc_oPg2.txt_4c_Text33.Value
        ENDIF

        *-- Endereco do Sacado
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
            THIS.this_oBusinessObject.this_nNlnEndCobs = loc_oPg2.txt_4c_Text19.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
            THIS.this_oBusinessObject.this_nNclEndCobs = loc_oPg2.txt_4c_Text20.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
            THIS.this_oBusinessObject.this_nNlnBaiCobs = loc_oPg2.txt_4c_Text21.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
            THIS.this_oBusinessObject.this_nNclBaiCobs = loc_oPg2.txt_4c_Text22.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
            THIS.this_oBusinessObject.this_nNlnCepCobs = loc_oPg2.txt_4c_Text27.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
            THIS.this_oBusinessObject.this_nNclCepCobs = loc_oPg2.txt_4c_Text28.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text23", 5)
            THIS.this_oBusinessObject.this_nNlnCidCobs = loc_oPg2.txt_4c_Text23.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text24", 5)
            THIS.this_oBusinessObject.this_nNclCidCobs = loc_oPg2.txt_4c_Text24.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text25", 5)
            THIS.this_oBusinessObject.this_nNlnEstCobs = loc_oPg2.txt_4c_Text25.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text26", 5)
            THIS.this_oBusinessObject.this_nNclEstCobs = loc_oPg2.txt_4c_Text26.Value
        ENDIF

        *-- Observacao
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text36", 5)
            THIS.this_oBusinessObject.this_nNlObs = loc_oPg2.txt_4c_Text36.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text37", 5)
            THIS.this_oBusinessObject.this_nNcObs = loc_oPg2.txt_4c_Text37.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text38", 5)
            THIS.this_oBusinessObject.this_nTamColObs = loc_oPg2.txt_4c_Text38.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text39", 5)
            THIS.this_oBusinessObject.this_nTamLinObs = loc_oPg2.txt_4c_Text39.Value
        ENDIF

        *-- Valor NF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text34", 5)
            THIS.this_oBusinessObject.this_nLNota = loc_oPg2.txt_4c_Text34.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text35", 5)
            THIS.this_oBusinessObject.this_nCNota = loc_oPg2.txt_4c_Text35.Value
        ENDIF

        *-- Codigo
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text41", 5)
            THIS.this_oBusinessObject.this_nNlnCods = loc_oPg2.txt_4c_Text41.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text42", 5)
            THIS.this_oBusinessObject.this_nNclCods = loc_oPg2.txt_4c_Text42.Value
        ENDIF

        *-- Impressora / Fonte
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
            THIS.this_oBusinessObject.this_cNomeImps = ALLTRIM(loc_oPg2.txt_4c_Text29.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
            THIS.this_oBusinessObject.this_cFontePdrs = ALLTRIM(loc_oPg2.txt_4c_Text30.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
            THIS.this_oBusinessObject.this_nTamFontes = loc_oPg2.txt_4c_Text31.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
            THIS.this_oBusinessObject.this_cTamFolhas = ALLTRIM(loc_oPg2.txt_4c_Text40.Value)
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos de Page2
    * Implementacao completa adicionada nas Fases 5-6
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Serie (PK)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Series", 5)
            loc_oPg2.txt_4c_Series.Value = THIS.this_oBusinessObject.this_cSeries
        ENDIF

        *-- Cabecalho: Data Emissao
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
            loc_oPg2.txt_4c_Text5.Value = THIS.this_oBusinessObject.this_nNlnDtDocs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
            loc_oPg2.txt_4c_Text6.Value = THIS.this_oBusinessObject.this_nNclDtDocs
        ENDIF

        *-- Cabecalho: Nota Fiscal
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
            loc_oPg2.txt_4c_Text1.Value = THIS.this_oBusinessObject.this_nNlnNotas
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
            loc_oPg2.txt_4c_Text2.Value = THIS.this_oBusinessObject.this_nNclNotas
        ENDIF

        *-- Cabecalho: Valor da Duplicata
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
            loc_oPg2.txt_4c_Text9.Value = THIS.this_oBusinessObject.this_nNlnVlDocs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
            loc_oPg2.txt_4c_Text10.Value = THIS.this_oBusinessObject.this_nNclVlDocs
        ENDIF

        *-- Cabecalho: N da Duplicata
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
            loc_oPg2.txt_4c_Text7.Value = THIS.this_oBusinessObject.this_nNlnNrDocs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
            loc_oPg2.txt_4c_Text8.Value = THIS.this_oBusinessObject.this_nNclNrDocs
        ENDIF

        *-- Cabecalho: Vencimento
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
            loc_oPg2.txt_4c_Text3.Value = THIS.this_oBusinessObject.this_nNlnDtVencs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
            loc_oPg2.txt_4c_Text4.Value = THIS.this_oBusinessObject.this_nNclDtVencs
        ENDIF

        *-- Sacado: Razao Social
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
            loc_oPg2.txt_4c_Text15.Value = THIS.this_oBusinessObject.this_nNlnRazClis
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text16", 5)
            loc_oPg2.txt_4c_Text16.Value = THIS.this_oBusinessObject.this_nNclRazClis
        ENDIF

        *-- Sacado: C.G.C./C.P.F.
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text17", 5)
            loc_oPg2.txt_4c_Text17.Value = THIS.this_oBusinessObject.this_nNlnCgcClis
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text18", 5)
            loc_oPg2.txt_4c_Text18.Value = THIS.this_oBusinessObject.this_nNclCgcClis
        ENDIF

        *-- Sacado: Insc. Estadual
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
            loc_oPg2.txt_4c_Text11.Value = THIS.this_oBusinessObject.this_nNlnEstClis
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
            loc_oPg2.txt_4c_Text12.Value = THIS.this_oBusinessObject.this_nNclEstClis
        ENDIF

        *-- Sacado: Valor por Extenso
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
            loc_oPg2.txt_4c_Text13.Value = THIS.this_oBusinessObject.this_nNlnExtens
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
            loc_oPg2.txt_4c_Text14.Value = THIS.this_oBusinessObject.this_nNclExtens
        ENDIF

        *-- Sacado: Praca
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text32", 5)
            loc_oPg2.txt_4c_Text32.Value = THIS.this_oBusinessObject.this_nNlPracas
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text33", 5)
            loc_oPg2.txt_4c_Text33.Value = THIS.this_oBusinessObject.this_nNcPracas
        ENDIF

        *-- Endereco do Sacado
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
            loc_oPg2.txt_4c_Text19.Value = THIS.this_oBusinessObject.this_nNlnEndCobs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
            loc_oPg2.txt_4c_Text20.Value = THIS.this_oBusinessObject.this_nNclEndCobs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
            loc_oPg2.txt_4c_Text21.Value = THIS.this_oBusinessObject.this_nNlnBaiCobs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
            loc_oPg2.txt_4c_Text22.Value = THIS.this_oBusinessObject.this_nNclBaiCobs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
            loc_oPg2.txt_4c_Text27.Value = THIS.this_oBusinessObject.this_nNlnCepCobs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
            loc_oPg2.txt_4c_Text28.Value = THIS.this_oBusinessObject.this_nNclCepCobs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text23", 5)
            loc_oPg2.txt_4c_Text23.Value = THIS.this_oBusinessObject.this_nNlnCidCobs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text24", 5)
            loc_oPg2.txt_4c_Text24.Value = THIS.this_oBusinessObject.this_nNclCidCobs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text25", 5)
            loc_oPg2.txt_4c_Text25.Value = THIS.this_oBusinessObject.this_nNlnEstCobs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text26", 5)
            loc_oPg2.txt_4c_Text26.Value = THIS.this_oBusinessObject.this_nNclEstCobs
        ENDIF

        *-- Observacao
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text36", 5)
            loc_oPg2.txt_4c_Text36.Value = THIS.this_oBusinessObject.this_nNlObs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text37", 5)
            loc_oPg2.txt_4c_Text37.Value = THIS.this_oBusinessObject.this_nNcObs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text38", 5)
            loc_oPg2.txt_4c_Text38.Value = THIS.this_oBusinessObject.this_nTamColObs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text39", 5)
            loc_oPg2.txt_4c_Text39.Value = THIS.this_oBusinessObject.this_nTamLinObs
        ENDIF

        *-- Valor NF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text34", 5)
            loc_oPg2.txt_4c_Text34.Value = THIS.this_oBusinessObject.this_nLNota
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text35", 5)
            loc_oPg2.txt_4c_Text35.Value = THIS.this_oBusinessObject.this_nCNota
        ENDIF

        *-- Codigo
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text41", 5)
            loc_oPg2.txt_4c_Text41.Value = THIS.this_oBusinessObject.this_nNlnCods
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text42", 5)
            loc_oPg2.txt_4c_Text42.Value = THIS.this_oBusinessObject.this_nNclCods
        ENDIF

        *-- Impressora / Fonte
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
            loc_oPg2.txt_4c_Text29.Value = THIS.this_oBusinessObject.this_cNomeImps
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
            loc_oPg2.txt_4c_Text30.Value = THIS.this_oBusinessObject.this_cFontePdrs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
            loc_oPg2.txt_4c_Text31.Value = THIS.this_oBusinessObject.this_nTamFontes
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
            loc_oPg2.txt_4c_Text40.Value = THIS.this_oBusinessObject.this_cTamFolhas
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao na Page2
    * VISUALIZAR: todos ReadOnly / INCLUIR+ALTERAR: editaveis
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lRO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lRO  = !(par_lHabilitar = .T.)

        *-- Serie (PK) so editavel no modo INCLUIR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Series", 5)
            loc_oPg2.txt_4c_Series.ReadOnly = !(par_lHabilitar = .T. AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        *-- Cabecalho: Data Emissao, Nota Fiscal, Valor Duplicata, Nr Duplicata, Vencimento
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text5",  5)
            loc_oPg2.txt_4c_Text5.ReadOnly  = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text6",  5)
            loc_oPg2.txt_4c_Text6.ReadOnly  = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text1",  5)
            loc_oPg2.txt_4c_Text1.ReadOnly  = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text2",  5)
            loc_oPg2.txt_4c_Text2.ReadOnly  = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text9",  5)
            loc_oPg2.txt_4c_Text9.ReadOnly  = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
            loc_oPg2.txt_4c_Text10.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text7",  5)
            loc_oPg2.txt_4c_Text7.ReadOnly  = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text8",  5)
            loc_oPg2.txt_4c_Text8.ReadOnly  = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text3",  5)
            loc_oPg2.txt_4c_Text3.ReadOnly  = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text4",  5)
            loc_oPg2.txt_4c_Text4.ReadOnly  = loc_lRO
        ENDIF

        *-- Sacado: Razao Social, CGC/CPF, Insc. Estadual, Extenso, Praca
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
            loc_oPg2.txt_4c_Text15.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text16", 5)
            loc_oPg2.txt_4c_Text16.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text17", 5)
            loc_oPg2.txt_4c_Text17.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text18", 5)
            loc_oPg2.txt_4c_Text18.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
            loc_oPg2.txt_4c_Text11.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
            loc_oPg2.txt_4c_Text12.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
            loc_oPg2.txt_4c_Text13.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
            loc_oPg2.txt_4c_Text14.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text32", 5)
            loc_oPg2.txt_4c_Text32.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text33", 5)
            loc_oPg2.txt_4c_Text33.ReadOnly = loc_lRO
        ENDIF

        *-- Endereco do Sacado
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
            loc_oPg2.txt_4c_Text19.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
            loc_oPg2.txt_4c_Text20.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
            loc_oPg2.txt_4c_Text21.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
            loc_oPg2.txt_4c_Text22.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
            loc_oPg2.txt_4c_Text27.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
            loc_oPg2.txt_4c_Text28.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text23", 5)
            loc_oPg2.txt_4c_Text23.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text24", 5)
            loc_oPg2.txt_4c_Text24.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text25", 5)
            loc_oPg2.txt_4c_Text25.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text26", 5)
            loc_oPg2.txt_4c_Text26.ReadOnly = loc_lRO
        ENDIF

        *-- Observacao, Valor NF, Codigo
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text36", 5)
            loc_oPg2.txt_4c_Text36.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text37", 5)
            loc_oPg2.txt_4c_Text37.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text38", 5)
            loc_oPg2.txt_4c_Text38.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text39", 5)
            loc_oPg2.txt_4c_Text39.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text34", 5)
            loc_oPg2.txt_4c_Text34.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text35", 5)
            loc_oPg2.txt_4c_Text35.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text41", 5)
            loc_oPg2.txt_4c_Text41.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text42", 5)
            loc_oPg2.txt_4c_Text42.ReadOnly = loc_lRO
        ENDIF

        *-- Impressora / Fonte / Tamanho / Folha
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
            loc_oPg2.txt_4c_Text29.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
            loc_oPg2.txt_4c_Text30.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
            loc_oPg2.txt_4c_Text31.ReadOnly = loc_lRO
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
            loc_oPg2.txt_4c_Text40.ReadOnly = loc_lRO
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera/limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Series",  5)
            loc_oPg2.txt_4c_Series.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text1",   5)
            loc_oPg2.txt_4c_Text1.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text2",   5)
            loc_oPg2.txt_4c_Text2.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text3",   5)
            loc_oPg2.txt_4c_Text3.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text4",   5)
            loc_oPg2.txt_4c_Text4.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text5",   5)
            loc_oPg2.txt_4c_Text5.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text6",   5)
            loc_oPg2.txt_4c_Text6.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text7",   5)
            loc_oPg2.txt_4c_Text7.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text8",   5)
            loc_oPg2.txt_4c_Text8.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text9",   5)
            loc_oPg2.txt_4c_Text9.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text10",  5)
            loc_oPg2.txt_4c_Text10.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text11",  5)
            loc_oPg2.txt_4c_Text11.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text12",  5)
            loc_oPg2.txt_4c_Text12.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text13",  5)
            loc_oPg2.txt_4c_Text13.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text14",  5)
            loc_oPg2.txt_4c_Text14.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text15",  5)
            loc_oPg2.txt_4c_Text15.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text16",  5)
            loc_oPg2.txt_4c_Text16.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text17",  5)
            loc_oPg2.txt_4c_Text17.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text18",  5)
            loc_oPg2.txt_4c_Text18.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text19",  5)
            loc_oPg2.txt_4c_Text19.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text20",  5)
            loc_oPg2.txt_4c_Text20.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text21",  5)
            loc_oPg2.txt_4c_Text21.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text22",  5)
            loc_oPg2.txt_4c_Text22.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text23",  5)
            loc_oPg2.txt_4c_Text23.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text24",  5)
            loc_oPg2.txt_4c_Text24.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text25",  5)
            loc_oPg2.txt_4c_Text25.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text26",  5)
            loc_oPg2.txt_4c_Text26.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text27",  5)
            loc_oPg2.txt_4c_Text27.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text28",  5)
            loc_oPg2.txt_4c_Text28.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text29",  5)
            loc_oPg2.txt_4c_Text29.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text30",  5)
            loc_oPg2.txt_4c_Text30.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text31",  5)
            loc_oPg2.txt_4c_Text31.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text32",  5)
            loc_oPg2.txt_4c_Text32.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text33",  5)
            loc_oPg2.txt_4c_Text33.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text34",  5)
            loc_oPg2.txt_4c_Text34.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text35",  5)
            loc_oPg2.txt_4c_Text35.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text36",  5)
            loc_oPg2.txt_4c_Text36.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text37",  5)
            loc_oPg2.txt_4c_Text37.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text38",  5)
            loc_oPg2.txt_4c_Text38.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text39",  5)
            loc_oPg2.txt_4c_Text39.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text40",  5)
            loc_oPg2.txt_4c_Text40.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text41",  5)
            loc_oPg2.txt_4c_Text41.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Text42",  5)
            loc_oPg2.txt_4c_Text42.Value  = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    * VISUALIZAR: Confirmar disabled, Cancelar enabled
    * INCLUIR/ALTERAR/BUSCAR: ambos habilitados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_oBtnConf, loc_oBtnCanc
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            RETURN
        ENDIF

        loc_oBtnConf = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
        loc_oBtnCanc = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar

        DO CASE
        CASE THIS.this_cModoAtual = "VISUALIZAR"
            loc_oBtnConf.Caption = "OK"
            loc_oBtnConf.Enabled = .T.
            loc_oBtnCanc.Enabled = .T.
        CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oBtnConf.Caption = "Confirmar"
            loc_oBtnConf.Enabled = .T.
            loc_oBtnCanc.Enabled = .T.
        CASE THIS.this_cModoAtual = "BUSCAR"
            loc_oBtnConf.Caption = "Buscar"
            loc_oBtnConf.Enabled = .T.
            loc_oBtnCanc.Enabled = .T.
        OTHERWISE
            loc_oBtnConf.Caption = "Confirmar"
            loc_oBtnConf.Enabled = .T.
            loc_oBtnCanc.Enabled = .T.
        ENDCASE
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Guarda o painel flutuante cnt_4c_CopiaFl como oculto
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Containers que devem manter Visible original (nao forcado para .T.)
                *-- CNT_4C_COPIAFL: painel flutuante de copia, exibido apenas por BtnCopiarClick
                *-- CNT_4C_CABECALHO e CNT_4C_BOTOESACAO: gerenciados pelo modo CRUD
                IF INLIST(loc_cNome, "CNT_4C_COPIAFL", "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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

    *==========================================================================
    * FormatarGridLista - Formata visual da grade
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * Destroy - Cleanup ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
