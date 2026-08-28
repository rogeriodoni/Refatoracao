*==============================================================================
* FormCVE.prg - Formulario de Cadastro de Comissoes de Vendedores por Cargos
* Herda de: FormBase
* Tabela:   SigCcCmI
* BO:       CVEBO
* FASE 6/8: Menu integration + Copia de Periodo + Lookups completos
*==============================================================================

DEFINE CLASS FormCVE AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX Fidelity)
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Comissoes de Vendedores por Cargos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    FontSize    = 8

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - FormBase.Init() chama THIS.InicializarForm() via DODEFAULT
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormCVE:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configuracao completa do formulario
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                THIS.ConfigurarPageFrame()
                loc_lResultado = .T.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    MsgErro("Sem conex" + CHR(227) + "o com o banco de dados!", "Erro")
                ELSE
                    THIS.this_oBusinessObject = CREATEOBJECT("CVEBO")

                    IF VARTYPE(THIS.this_oBusinessObject) != "O"
                        MsgErro("Erro ao criar CVEBO!", "Erro")
                    ELSE
                        THIS.Caption = "Cadastro de Comiss" + CHR(245) + "es de " + ;
                                       "Vendedores por Cargos"

                        THIS.ConfigurarPageFrame()
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                        THIS.pgf_4c_Paginas.Visible = .T.
                        THIS.pgf_4c_Paginas.ActivePage = 1
                        THIS.this_cModoAtual = "LISTA"

                        THIS.CarregarLista()

                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            WITH THIS.pgf_4c_Paginas
                .PageCount = 2
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height + 29
                .Tabs      = .F.
                .Page1.Caption   = "Lista"
                .Page1.BackColor = RGB(100, 100, 100)
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Caption   = "Dados"
                .Page2.BackColor = RGB(100, 100, 100)
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Visible = .T.
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPageFrame:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1 completa:
    *   Cabecalho, Botoes CRUD, Encerrar, Filtro de Periodo,
    *   Botao Copia, Container Copia flutuante, Grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_cCaption, loc_oGrid
        loc_oPagina  = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_cCaption = THIS.Caption

        TRY
            *-- Cabecalho (Top=2+29=31)
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption   = loc_cCaption
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
                    .Caption   = loc_cCaption
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

            *-- Botoes CRUD (Top=0+29=29, Left=542 - lado direito)
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
                    .Top             = 5
                    .Left            =  542
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
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Top             = 5
                    .Left            =  542
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

                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Top             = 5
                    .Left            =  542
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

                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Top             = 5
                    .Left            =  542
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

                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Top             = 5
                    .Left            =  542
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
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

            *-- Encerrar - padrao canonico (CLAUDE.md Regra #10)
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
                    .Top             = 5
                    .Left            = 917
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
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Filtro Periodo (top=119+29=148)
            loc_oPagina.AddObject("cnt_4c_Filtro", "Container")
            WITH loc_oPagina.cnt_4c_Filtro
                .Top         = 148
                .Left        = 11
                .Width       = 162
                .Height      = 33
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Periodo", "Label")
                WITH .lbl_4c_Periodo
                    .Caption   = "Per" + CHR(237) + "odo :"
                    .Top       = 9
                    .Left      = 23
                    .Width     = 50
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_FiltroMess", "TextBox")
                WITH .txt_4c_FiltroMess
                    .Value     = PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")
                    .Top       = 6
                    .Left      = 71
                    .Width     = 24
                    .Height    = 23
                    .InputMask = "99"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Barra", "Label")
                WITH .lbl_4c_Barra
                    .Caption   = "/"
                    .Top       = 9
                    .Left      = 100
                    .Width     = 8
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_FiltroAnos", "TextBox")
                WITH .txt_4c_FiltroAnos
                    .Value     = PADL(ALLTRIM(STR(YEAR(DATE()))), 4, "0")
                    .Top       = 6
                    .Left      = 113
                    .Width     = 38
                    .Height    = 23
                    .InputMask = "9999"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess, "KeyPress", THIS, "FiltroMesLostFocus")
            BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos, "KeyPress", THIS, "FiltroAnosLostFocus")

            *-- Botao Copia de Periodo (top=91+29=120, left=347)
            loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
            WITH loc_oPagina.cmd_4c_Copia
                .Caption       = "C" + CHR(243) + "pia"
                .Top           = 120
                .Left          = 347
                .Width         = 105
                .Height        = 45
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .T.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiarClick")

            *-- Container flutuante Copia de Periodo (top=264+29=293, inicia oculto)
            loc_oPagina.AddObject("cnt_4c_Copia", "Container")
            WITH loc_oPagina.cnt_4c_Copia
                .Top         = 293
                .Left        = 226
                .Width       = 348
                .Height      = 77
                .BackColor   = RGB(240, 240, 240)
                .BackStyle   = 1
                .BorderWidth = 1
                .Visible     = .F.

                .AddObject("lbl_4c_TituloCopia", "Label")
                WITH .lbl_4c_TituloCopia
                    .Caption   = "C" + CHR(243) + "pia de Per" + CHR(237) + "odo"
                    .Top       = 5
                    .Left      = 8
                    .Width     = 150
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Origem", "Label")
                WITH .lbl_4c_Origem
                    .Caption   = "Per" + CHR(237) + "odo de Origem :"
                    .Top       = 27
                    .Left      = 28
                    .Width     = 97
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_OMess", "TextBox")
                WITH .txt_4c_OMess
                    .Value     = ""
                    .Top       = 24
                    .Left      = 128
                    .Width     = 24
                    .InputMask = "99"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_BarraO", "Label")
                WITH .lbl_4c_BarraO
                    .Caption   = "/"
                    .Top       = 27
                    .Left      = 157
                    .Width     = 8
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_OAnos", "TextBox")
                WITH .txt_4c_OAnos
                    .Value     = ""
                    .Top       = 24
                    .Left      = 166
                    .Width     = 38
                    .InputMask = "9999"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Destino", "Label")
                WITH .lbl_4c_Destino
                    .Caption   = "Per" + CHR(237) + "odo de Destino :"
                    .Top       = 52
                    .Left      = 26
                    .Width     = 99
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DMess", "TextBox")
                WITH .txt_4c_DMess
                    .Value     = ""
                    .Top       = 48
                    .Left      = 128
                    .Width     = 24
                    .InputMask = "99"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_BarraD", "Label")
                WITH .lbl_4c_BarraD
                    .Caption   = "/"
                    .Top       = 51
                    .Left      = 157
                    .Width     = 8
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DAnos", "TextBox")
                WITH .txt_4c_DAnos
                    .Value     = ""
                    .Top       = 48
                    .Left      = 166
                    .Width     = 38
                    .InputMask = "9999"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("cmd_4c_OkCopia", "CommandButton")
                WITH .cmd_4c_OkCopia
                    .Caption      = "Confirmar"
                    .Top          = 13
                    .Left         = 218
                    .Width        = 64
                    .Height       = 55
                    .FontName     = "Tahoma"
                    .FontSize     = 8
                    .FontBold     = .T.
                    .ForeColor    = RGB(90, 90, 90)
                    .BackColor    = RGB(255, 255, 255)
                    .Themes       = .T.
                    .MousePointer = 15
                    .Visible      = .T.
                ENDWITH

                .AddObject("cmd_4c_CancelarCopia", "CommandButton")
                WITH .cmd_4c_CancelarCopia
                    .Caption      = "Encerrar"
                    .Top          = 13
                    .Left         = 282
                    .Width        = 64
                    .Height       = 55
                    .FontName     = "Tahoma"
                    .FontSize     = 8
                    .FontBold     = .T.
                    .ForeColor    = RGB(90, 90, 90)
                    .BackColor    = RGB(255, 255, 255)
                    .Themes       = .T.
                    .MousePointer = 15
                    .Visible      = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_OkCopia,       "Click", THIS, "BtnOkCopiaClick")
            BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiaClick")

            *-- Grid (top=185, left=11)
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")

            loc_oGrid             = loc_oPagina.grd_4c_Lista
            loc_oGrid.ColumnCount = 8

            WITH loc_oGrid
                .Top                = 185
                .Left               = 11
                .Width              = 895
                .Height             = 390
                .FontName           = "Tahoma"
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
                    .Width           = 110
                    .Header1.Caption = "Usu" + CHR(225) + "rio"
                ENDWITH
                WITH .Column2
                    .Width           = 35
                    .Header1.Caption = "M" + CHR(234) + "s"
                ENDWITH
                WITH .Column3
                    .Width           = 45
                    .Header1.Caption = "Ano"
                ENDWITH
                WITH .Column4
                    .Width           = 20
                    .Header1.Caption = "V"
                ENDWITH
                WITH .Column5
                    .Width           = 160
                    .Header1.Caption = "Cargo"
                ENDWITH
                WITH .Column6
                    .Width           = 70
                    .Alignment       = 2
                    .Header1.Caption = "Adicional"
                ENDWITH
                WITH .Column7
                    .Width           = 100
                    .Alignment       = 2
                    .Header1.Caption = "M" + CHR(237) + "nimo"
                ENDWITH
                WITH .Column8
                    .Width           = 100
                    .Alignment       = 2
                    .Header1.Caption = "Experi" + CHR(234) + "ncia"
                ENDWITH
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaLista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2 com todos os campos de SigCcCmI
    *   Usuars (lookup SigCdUsu), Mess, Anos, Indivs, Setors (lookup SigCdCrg),
    *   Adics, Minimos, MinExps + botoes Confirmar/Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Botoes Acao: Confirmar e Cancelar
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
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
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
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            *-- Label: Usu?rio (layout top=179 +29=208)
            loc_oPagina.AddObject("lbl_4c_Usuars", "Label")
            WITH loc_oPagina.lbl_4c_Usuars
                .Caption   = "Usu" + CHR(225) + "rio :"
                .Top       = 208
                .Left      = 248
                .Width     = 54
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Usu?rio (layout top=176 +29=205)
            loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
            WITH loc_oPagina.txt_4c_Usuars
                .Value     = ""
                .Top       = 205
                .Left      = 311
                .Width     = 80
                .Height    = 23
                .MaxLength = 10
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_Usuars, "DblClick",  THIS, "AbrirBuscaUsuars")
            BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress",  THIS, "TeclaLookupUsuars")
            BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress", THIS, "ValidarUsuars")

            *-- Label: Per?odo (layout top=204 +29=233)
            loc_oPagina.AddObject("lbl_4c_Periodo2", "Label")
            WITH loc_oPagina.lbl_4c_Periodo2
                .Caption   = "Per" + CHR(237) + "odo :"
                .Top       = 233
                .Left      = 248
                .Width     = 54
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: M?s Per?odo (layout top=201 +29=230)
            loc_oPagina.AddObject("txt_4c_Mess", "TextBox")
            WITH loc_oPagina.txt_4c_Mess
                .Value     = ""
                .Top       = 230
                .Left      = 311
                .Width     = 24
                .Height    = 23
                .InputMask = "99"
                .MaxLength = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Separador "/" entre M?s e Ano (layout top=202 +29=231)
            loc_oPagina.AddObject("lbl_4c_BarraMesAno", "Label")
            WITH loc_oPagina.lbl_4c_BarraMesAno
                .Caption   = "/"
                .Top       = 231
                .Left      = 340
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Ano Per?odo (layout top=201 +29=230)
            loc_oPagina.AddObject("txt_4c_Anos", "TextBox")
            WITH loc_oPagina.txt_4c_Anos
                .Value     = ""
                .Top       = 230
                .Left      = 353
                .Width     = 38
                .Height    = 23
                .InputMask = "9999"
                .MaxLength = 4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Label: Vendedor (layout top=229 +29=258)
            loc_oPagina.AddObject("lbl_4c_Vendedor", "Label")
            WITH loc_oPagina.lbl_4c_Vendedor
                .Caption   = "Vendedor :"
                .Top       = 258
                .Left      = 236
                .Width     = 66
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Vendedor Individual S/N (layout top=226 +29=255)
            loc_oPagina.AddObject("txt_4c_Indivs", "TextBox")
            WITH loc_oPagina.txt_4c_Indivs
                .Value     = "N"
                .Top       = 255
                .Left      = 311
                .Width     = 17
                .Height    = 23
                .InputMask = "!"
                .MaxLength = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Label: (S/N) (layout top=229 +29=258)
            loc_oPagina.AddObject("lbl_4c_IndivsSN", "Label")
            WITH loc_oPagina.lbl_4c_IndivsSN
                .Caption   = "(S/N)"
                .Top       = 258
                .Left      = 331
                .Width     = 33
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Label: Cargo (layout top=254 +29=283)
            loc_oPagina.AddObject("lbl_4c_Setors", "Label")
            WITH loc_oPagina.lbl_4c_Setors
                .Caption   = "Cargo :"
                .Top       = 283
                .Left      = 256
                .Width     = 46
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Cargo (layout top=251 +29=280)
            loc_oPagina.AddObject("txt_4c_Setors", "TextBox")
            WITH loc_oPagina.txt_4c_Setors
                .Value     = ""
                .Top       = 280
                .Left      = 311
                .Width     = 80
                .Height    = 23
                .MaxLength = 10
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_Setors, "DblClick",  THIS, "AbrirBuscaSetors")
            BINDEVENT(loc_oPagina.txt_4c_Setors, "KeyPress",  THIS, "TeclaLookupSetors")
            BINDEVENT(loc_oPagina.txt_4c_Setors, "KeyPress", THIS, "ValidarSetors")

            *-- Label: Adicional (layout top=278 +29=307)
            loc_oPagina.AddObject("lbl_4c_Adics", "Label")
            WITH loc_oPagina.lbl_4c_Adics
                .Caption   = "Adicional :"
                .Top       = 307
                .Left      = 240
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Adicional % (layout top=275 +29=304)
            loc_oPagina.AddObject("txt_4c_Adics", "TextBox")
            WITH loc_oPagina.txt_4c_Adics
                .Value    = 0.00
                .Top      = 304
                .Left     = 311
                .Width    = 52
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Label: % (layout top=280 +29=309)
            loc_oPagina.AddObject("lbl_4c_PctAdics", "Label")
            WITH loc_oPagina.lbl_4c_PctAdics
                .Caption   = "%"
                .Top       = 309
                .Left      = 368
                .Width     = 14
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Label: M?nimo (layout top=303 +29=332)
            loc_oPagina.AddObject("lbl_4c_Minimos", "Label")
            WITH loc_oPagina.lbl_4c_Minimos
                .Caption   = "M" + CHR(237) + "nimo :"
                .Top       = 332
                .Left      = 251
                .Width     = 51
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: M?nimo (layout top=300 +29=329)
            loc_oPagina.AddObject("txt_4c_Minimos", "TextBox")
            WITH loc_oPagina.txt_4c_Minimos
                .Value    = 0.00
                .Top      = 329
                .Left     = 311
                .Width    = 101
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Label: Experi?ncia (layout top=328 +29=357)
            loc_oPagina.AddObject("lbl_4c_MinExps", "Label")
            WITH loc_oPagina.lbl_4c_MinExps
                .Caption   = "Experi" + CHR(234) + "ncia :"
                .Top       = 357
                .Left      = 225
                .Width     = 77
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Experi?ncia m?nima (layout top=325 +29=354)
            loc_oPagina.AddObject("txt_4c_MinExps", "TextBox")
            WITH loc_oPagina.txt_4c_MinExps
                .Value    = 0.00
                .Top      = 354
                .Left     = 311
                .Width    = 101
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaDados:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Containers excluidos (mantem Visible original):
    *   cnt_4c_Copia      - container flutuante de copia de periodo (inicia oculto)
    *   cnt_4c_Cabecalho  - cabecalho cinza (Visible gerenciado por ConfigurarPaginaLista)
    *   cnt_4c_BotoesAcao - botoes Confirmar/Cancelar (Visible gerenciado por HabilitarCampos)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                IF INLIST(loc_cNome, "CNT_4C_COPIA", "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

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

    *==========================================================================
    * FormatarGridLista - Formata visual do grid
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
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
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega grid com dados de SigCcCmI filtrados por periodo
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        LOCAL loc_cMesI, loc_cMesF, loc_cAnoI, loc_cAnoF
        LOCAL loc_oPagina, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Lista")
                    CREATE CURSOR cursor_4c_Lista (cIdChaves C(20), Usuars C(10), ;
                                                   Mess C(2), Anos C(4), Indivs C(1), ;
                                                   Setors C(10), Adics N(5,2), ;
                                                   Minimos N(11,2), MinExps N(11,2))
                ENDIF
                loc_lResultado = .T.
            ELSE
                loc_oPagina = THIS.pgf_4c_Paginas.Page1
                loc_oGrid   = loc_oPagina.grd_4c_Lista

                loc_cMesI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
                loc_cAnoI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
                loc_cMesF = IIF(loc_cMesI = "00", "12", loc_cMesI)
                loc_cAnoF = IIF(loc_cAnoI = "0000", "9999", loc_cAnoI)

                IF USED("cursor_4c_Lista")
                    USE IN cursor_4c_Lista
                ENDIF

                loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs, Setors," + ;
                           " Adics, Minimos, MinExps" + ;
                           " FROM SigCcCmI" + ;
                           " WHERE Mess BETWEEN " + EscaparSQL(loc_cMesI) + ;
                           " AND " + EscaparSQL(loc_cMesF) + ;
                           " AND Anos BETWEEN " + EscaparSQL(loc_cAnoI) + ;
                           " AND " + EscaparSQL(loc_cAnoF) + ;
                           " ORDER BY Anos, Mess, Usuars, Setors"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

                IF loc_nResult < 0
                    MsgErro("Erro ao carregar comiss" + CHR(245) + "es:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_oGrid.ColumnCount = 8
                    loc_oGrid.RecordSource           = "cursor_4c_Lista"
                    loc_oGrid.Column1.ControlSource  = "cursor_4c_Lista.Usuars"
                    loc_oGrid.Column2.ControlSource  = "cursor_4c_Lista.Mess"
                    loc_oGrid.Column3.ControlSource  = "cursor_4c_Lista.Anos"
                    loc_oGrid.Column4.ControlSource  = "cursor_4c_Lista.Indivs"
                    loc_oGrid.Column5.ControlSource  = "cursor_4c_Lista.Setors"
                    loc_oGrid.Column6.ControlSource  = "cursor_4c_Lista.Adics"
                    loc_oGrid.Column7.ControlSource  = "cursor_4c_Lista.Minimos"
                    loc_oGrid.Column8.ControlSource  = "cursor_4c_Lista.MinExps"

                    loc_oGrid.Column1.Width           = 110
                    loc_oGrid.Column2.Width           = 35
                    loc_oGrid.Column3.Width           = 45
                    loc_oGrid.Column4.Width           = 20
                    loc_oGrid.Column5.Width           = 160
                    loc_oGrid.Column6.Width           = 70
                    loc_oGrid.Column7.Width           = 100
                    loc_oGrid.Column8.Width           = 100

                    loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
                    loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s"
                    loc_oGrid.Column3.Header1.Caption = "Ano"
                    loc_oGrid.Column4.Header1.Caption = "V"
                    loc_oGrid.Column5.Header1.Caption = "Cargo"
                    loc_oGrid.Column6.Header1.Caption = "Adicional"
                    loc_oGrid.Column7.Header1.Caption = "M" + CHR(237) + "nimo"
                    loc_oGrid.Column8.Header1.Caption = "Experi" + CHR(234) + "ncia"

                    loc_oGrid.Column6.Alignment = 2
                    loc_oGrid.Column7.Alignment = 2
                    loc_oGrid.Column8.Alignment = 2

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FiltroMesLostFocus - Ao sair do campo mes, padroniza e foca ano
    *==========================================================================
    PROCEDURE FiltroMesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value = ;
                PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
            loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.SetFocus
        CATCH TO loc_oErro
            MsgErro("Erro em FiltroMesLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FiltroAnosLostFocus - Ao sair do campo ano, padroniza e recarrega grid
    *==========================================================================
    PROCEDURE FiltroAnosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value = ;
                PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro("Erro em FiltroAnosLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara novo registro e navega para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.NovoRegistro()
            ENDIF
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Usuars.SetFocus
        CATCH TO loc_oErro
            MsgErro("Erro em BtnIncluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado e navega para Page2
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
                MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Lista
                loc_cChave = ALLTRIM(cursor_4c_Lista.cIdChaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Indivs.SetFocus
                ELSE
                    MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o!", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
                MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Lista
                loc_cChave = ALLTRIM(cursor_4c_Lista.cIdChaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ELSE
                    MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o!", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_lConfirma
        TRY
            IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
                MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Lista
                loc_cChave   = ALLTRIM(cursor_4c_Lista.cIdChaves)
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
                                            "Excluir")

                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                            THIS.CarregarLista()
                        ELSE
                            MsgErro("Erro ao excluir registro!", "Erro")
                        ENDIF
                    ELSE
                        MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega grid com filtro atual
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
            IF USED("cursor_4c_Lista") AND !EOF("cursor_4c_Lista")
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            *-- Ignorar erros ao fechar
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva registro
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "")
                THIS.AlternarPagina(1)
            ELSE
                MsgErro("Erro ao salvar registro!", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCopiarClick - Mostra container de copia de periodo
    *==========================================================================
    PROCEDURE BtnCopiarClick()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_oPagina.grd_4c_Lista.Enabled  = .F.
            loc_oPagina.cnt_4c_Botoes.Enabled = .F.
            loc_oPagina.cnt_4c_Saida.Enabled  = .F.
            loc_oPagina.cmd_4c_Copia.Enabled  = .F.

            WITH loc_oPagina.cnt_4c_Copia
                .txt_4c_OMess.Value = ""
                .txt_4c_OAnos.Value = ""
                .txt_4c_DMess.Value = ""
                .txt_4c_DAnos.Value = ""
                .Visible = .T.
                .ZOrder(0)
                .txt_4c_OMess.SetFocus
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCopiarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnOkCopiaClick - Executa copia de todos os registros do periodo origem
    *                   para o periodo destino no SQL Server
    *==========================================================================
    PROCEDURE BtnOkCopiaClick()
        LOCAL loc_oPagina, loc_cOMess, loc_cDMess, loc_cOAnos, loc_cDAnos
        LOCAL loc_nResult, loc_cSQL, loc_lCopiar
        loc_lCopiar = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_cOMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OMess.Value), 2, "0")
            loc_cOAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.Value), 4, "0")
            loc_cDMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DMess.Value), 2, "0")
            loc_cDAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.Value), 4, "0")

            IF EMPTY(loc_cOMess) OR loc_cOMess = "00" OR VAL(loc_cOMess) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
                         "s de Origem!", "")
                loc_oPagina.cnt_4c_Copia.txt_4c_OMess.SetFocus
            ELSE
                IF EMPTY(loc_cOAnos) OR loc_cOAnos = "0000" OR VAL(loc_cOAnos) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Origem!", "")
                loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.SetFocus
            ELSE
                IF EMPTY(loc_cDMess) OR loc_cDMess = "00" OR VAL(loc_cDMess) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
                         "s de Destino!", "")
                loc_oPagina.cnt_4c_Copia.txt_4c_DMess.SetFocus
            ELSE
                IF EMPTY(loc_cDAnos) OR loc_cDAnos = "0000" OR VAL(loc_cDAnos) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Destino!", "")
                loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.SetFocus
            ELSE
                *-- Verificar se destino ja tem registros
                loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCcCmI" + ;
                           " WHERE Mess = " + EscaparSQL(loc_cDMess) + ;
                           " AND Anos = " + EscaparSQL(loc_cDAnos)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifDest")

                IF loc_nResult >= 0 AND USED("cursor_4c_VerifDest") AND ;
                   cursor_4c_VerifDest.Total > 0
                    IF MsgConfirma("O per" + CHR(237) + "odo de destino j" + CHR(225) + ;
                                   " possui registros. Deseja sobrepor?", "Confirmar")
                        loc_lCopiar = .T.
                    ENDIF
                ELSE
                    loc_lCopiar = .T.
                ENDIF

                IF USED("cursor_4c_VerifDest")
                    USE IN cursor_4c_VerifDest
                ENDIF

                IF loc_lCopiar
                    loc_cSQL = "INSERT INTO SigCcCmI" + ;
                               " (cIdChaves, Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
                               " Mess, Anos)" + ;
                               " SELECT NEWID(), Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
                               " " + EscaparSQL(loc_cDMess) + ", " + EscaparSQL(loc_cDAnos) + ;
                               " FROM SigCcCmI" + ;
                               " WHERE Mess = " + EscaparSQL(loc_cOMess) + ;
                               " AND Anos = " + EscaparSQL(loc_cOAnos) + ;
                               " AND NOT EXISTS (" + ;
                               "   SELECT 1 FROM SigCcCmI d" + ;
                               "   WHERE d.Mess = " + EscaparSQL(loc_cDMess) + ;
                               "   AND d.Anos = " + EscaparSQL(loc_cDAnos) + ;
                               "   AND d.Usuars = SigCcCmI.Usuars)"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopRes")

                    IF loc_nResult >= 0
                        MsgInfo("Per" + CHR(237) + "odo copiado com sucesso!", "")
                        THIS.BtnCancelarCopiaClick()
                        THIS.CarregarLista()
                    ELSE
                        MsgErro("Erro ao copiar per" + CHR(237) + "odo: " + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF

                    IF USED("cursor_4c_CopRes")
                        USE IN cursor_4c_CopRes
                    ENDIF
                ENDIF
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnOkCopiaClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            IF USED("cursor_4c_VerifDest")
                USE IN cursor_4c_VerifDest
            ENDIF
            IF USED("cursor_4c_CopRes")
                USE IN cursor_4c_CopRes
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarCopiaClick - Oculta container de copia e reabilita area
    *==========================================================================
    PROCEDURE BtnCancelarCopiaClick()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_oPagina.cnt_4c_Copia.Visible  = .F.
            loc_oPagina.grd_4c_Lista.Enabled  = .T.
            loc_oPagina.cnt_4c_Botoes.Enabled = .T.
            loc_oPagina.cnt_4c_Saida.Enabled  = .T.
            loc_oPagina.cmd_4c_Copia.Enabled  = .T.

            IF USED("cursor_4c_Lista")
                loc_oPagina.grd_4c_Lista.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCancelarCopiaClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.NovoRegistro()
            ENDIF
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.txt_4c_Usuars.Value  = ""
            loc_oPagina.txt_4c_Mess.Value    = ""
            loc_oPagina.txt_4c_Anos.Value    = ""
            loc_oPagina.txt_4c_Indivs.Value  = "N"
            loc_oPagina.txt_4c_Setors.Value  = ""
            loc_oPagina.txt_4c_Adics.Value   = 0.00
            loc_oPagina.txt_4c_Minimos.Value = 0.00
            loc_oPagina.txt_4c_MinExps.Value = 0.00
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita todos os campos editaveis da Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.txt_4c_Usuars.Enabled  = par_lHabilitar
            loc_oPagina.txt_4c_Mess.Enabled    = par_lHabilitar
            loc_oPagina.txt_4c_Anos.Enabled    = par_lHabilitar
            loc_oPagina.txt_4c_Indivs.Enabled  = par_lHabilitar
            loc_oPagina.txt_4c_Setors.Enabled  = par_lHabilitar
            loc_oPagina.txt_4c_Adics.Enabled   = par_lHabilitar
            loc_oPagina.txt_4c_Minimos.Enabled = par_lHabilitar
            loc_oPagina.txt_4c_MinExps.Enabled = par_lHabilitar
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .cmd_4c_Confirmar.Enabled = par_lHabilitar
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditar
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            WITH loc_oPagina.cnt_4c_BotoesAcao
                .cmd_4c_Confirmar.Enabled = loc_lEditar
                .cmd_4c_Cancelar.Enabled  = .T.
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPagina, loc_oBO
        loc_lResultado = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oBO     = THIS.this_oBusinessObject

            loc_oPagina.txt_4c_Usuars.Value  = ALLTRIM(loc_oBO.this_cUsuars)
            loc_oPagina.txt_4c_Mess.Value    = ALLTRIM(loc_oBO.this_cMess)
            loc_oPagina.txt_4c_Anos.Value    = ALLTRIM(loc_oBO.this_cAnos)
            loc_oPagina.txt_4c_Indivs.Value  = IIF(EMPTY(ALLTRIM(loc_oBO.this_cIndivs)), ;
                                                    "N", UPPER(ALLTRIM(loc_oBO.this_cIndivs)))
            loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(loc_oBO.this_cSetors)
            loc_oPagina.txt_4c_Adics.Value   = loc_oBO.this_nAdics
            loc_oPagina.txt_4c_Minimos.Value = loc_oBO.this_nMinimos
            loc_oPagina.txt_4c_MinExps.Value = loc_oBO.this_nMinExps

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormParaBO - Valida campos da Page2 e transfere para o BO
    * Retorna .T. se valido, .F. se ha erro de validacao
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oPagina, loc_oBO
        LOCAL loc_cUsuars, loc_cMess, loc_cAnos, loc_cIndivs, loc_cSetors
        LOCAL loc_cMsgDupI, loc_cMsgDupV
        loc_lResultado = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oBO     = THIS.this_oBusinessObject

            loc_cUsuars = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
            loc_cMess   = PADL(ALLTRIM(loc_oPagina.txt_4c_Mess.Value),  2, "0")
            loc_cAnos   = PADL(ALLTRIM(loc_oPagina.txt_4c_Anos.Value),  4, "0")
            loc_cIndivs = UPPER(ALLTRIM(loc_oPagina.txt_4c_Indivs.Value))
            loc_cSetors = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))

            IF EMPTY(loc_cUsuars)
                MsgAviso("Obrigat" + CHR(243) + "rio informar o Usu" + CHR(225) + "rio!!!", "")
                loc_oPagina.txt_4c_Usuars.SetFocus
            ELSE
                IF EMPTY(loc_cMess) OR loc_cMess = "00" OR VAL(loc_cMess) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
                         "s de Refer" + CHR(234) + "ncia!!!", "")
                loc_oPagina.txt_4c_Mess.SetFocus
            ELSE
                IF EMPTY(loc_cAnos) OR loc_cAnos = "0000" OR VAL(loc_cAnos) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
                         "ncia!!!", "")
                loc_oPagina.txt_4c_Anos.SetFocus
            ELSE
                IF !EMPTY(loc_cIndivs) AND !INLIST(loc_cIndivs, "S", "N")
                MsgAviso("Vendedor deve ser S ou N!!!", "")
                loc_oPagina.txt_4c_Indivs.SetFocus
            ELSE
                loc_oBO.this_cUsuars    = loc_cUsuars
                loc_oBO.this_cMess      = loc_cMess
                loc_oBO.this_cAnos      = loc_cAnos
                loc_oBO.this_cIndivs    = IIF(EMPTY(loc_cIndivs), "N", loc_cIndivs)
                loc_oBO.this_cSetors    = loc_cSetors
                loc_oBO.this_nAdics     = loc_oPagina.txt_4c_Adics.Value
                loc_oBO.this_nMinimos   = loc_oPagina.txt_4c_Minimos.Value
                loc_oBO.this_nMinExps   = loc_oPagina.txt_4c_MinExps.Value

                loc_cMsgDupI = loc_oBO.ValidarDuplicidadeEmSigCcCmI()
                IF !EMPTY(loc_cMsgDupI)
                    MsgAviso(loc_cMsgDupI, "")
                ELSE
                    loc_cMsgDupV = loc_oBO.ValidarDuplicidadeEmSigCcCmV()
                    IF !EMPTY(loc_cMsgDupV)
                        MsgAviso(loc_cMsgDupV, "")
                    ELSE
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AbrirBuscaUsuars - Abre picker FormBuscaAuxiliar para SigCdUsu
    *==========================================================================
    PROCEDURE AbrirBuscaUsuars()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdUsu", "cursor_4c_BuscaUsu", ;
                                      "Usuarios", loc_cValor, ;
                                      "Busca de Usu" + CHR(225) + "rios")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
                    loc_oBusca.mAddColuna("NComps",   "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                        THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirBuscaUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaLookupUsuars - Dispara AbrirBuscaUsuars com F4 ou F5
    *==========================================================================
    PROCEDURE TeclaLookupUsuars(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaUsuars()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarUsuars - Valida codigo de usuario ao sair do campo
    *==========================================================================
    PROCEDURE ValidarUsuars(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResultado
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))

            IF EMPTY(loc_cValor)
                RETURN
            ENDIF

            loc_cSQL       = "SELECT Usuars, NComps FROM SigCdUsu" + ;
                             " WHERE Usuars = " + EscaparSQL(loc_cValor)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValUsu")

            IF loc_nResultado > 0 AND USED("cursor_4c_ValUsu") AND ;
               RECCOUNT("cursor_4c_ValUsu") > 0
                loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_ValUsu.Usuars)
                THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_ValUsu.Usuars))
            ELSE
                IF USED("cursor_4c_ValUsu")
                    USE IN cursor_4c_ValUsu
                ENDIF
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaUsuars()
                RETURN
            ENDIF

            IF USED("cursor_4c_ValUsu")
                USE IN cursor_4c_ValUsu
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ValidarUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValUsu")
                USE IN cursor_4c_ValUsu
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * PreencherPeriodoDoUsuario - Ao selecionar usuario sem periodo preenchido,
    * carrega o ultimo periodo cadastrado para ele (auto-preenchimento)
    *==========================================================================
    PROTECTED PROCEDURE PreencherPeriodoDoUsuario(par_cUsuars)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Mess.Value)) OR ;
               ALLTRIM(loc_oPagina.txt_4c_Mess.Value) = "00"

                IF THIS.this_oBusinessObject.CarregarUltimoPeriodoUsuario(par_cUsuars)
                    IF USED("cursor_4c_UltPer") AND RECCOUNT("cursor_4c_UltPer") > 0
                        SELECT cursor_4c_UltPer
                        loc_oPagina.txt_4c_Mess.Value   = ALLTRIM(cursor_4c_UltPer.mess)
                        loc_oPagina.txt_4c_Anos.Value   = ALLTRIM(cursor_4c_UltPer.anos)
                        loc_oPagina.txt_4c_Indivs.Value = IIF(EMPTY(cursor_4c_UltPer.indivs), ;
                                                              "N", UPPER(cursor_4c_UltPer.indivs))
                        loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.setors)
                        loc_oPagina.txt_4c_Adics.Value   = cursor_4c_UltPer.adics
                        loc_oPagina.txt_4c_Minimos.Value = cursor_4c_UltPer.minimos
                        loc_oPagina.txt_4c_MinExps.Value = cursor_4c_UltPer.minexps
                    ENDIF
                    IF USED("cursor_4c_UltPer")
                        USE IN cursor_4c_UltPer
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PreencherPeriodoDoUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_UltPer")
                USE IN cursor_4c_UltPer
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaSetors - Abre picker FormBuscaAuxiliar para SigCdCrg (Cargos)
    *==========================================================================
    PROCEDURE AbrirBuscaSetors()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdCrg", "cursor_4c_BuscaCrg", ;
                                      "CCargs", loc_cValor, ;
                                      "Busca de Cargos")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CCargs", "", "Cargo")
                    loc_oBusca.mAddColuna("DCargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCrg")
                        loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCrg")
                USE IN cursor_4c_BuscaCrg
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirBuscaSetors:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaCrg")
                USE IN cursor_4c_BuscaCrg
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaLookupSetors - Dispara AbrirBuscaSetors com F4 ou F5
    *==========================================================================
    PROCEDURE TeclaLookupSetors(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaSetors()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarSetors - Valida codigo de cargo ao sair do campo
    *==========================================================================
    PROCEDURE ValidarSetors(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))

            IF EMPTY(loc_cValor)
                RETURN
            ENDIF

            THIS.AbrirBuscaSetors()
        CATCH TO loc_oErro
            MsgErro("Erro em ValidarSetors:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF
            IF USED("cursor_4c_VerifDest")
                USE IN cursor_4c_VerifDest
            ENDIF
            IF USED("cursor_4c_CopRes")
                USE IN cursor_4c_CopRes
            ENDIF
            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
            IF USED("cursor_4c_ValUsu")
                USE IN cursor_4c_ValUsu
            ENDIF
            IF USED("cursor_4c_BuscaCrg")
                USE IN cursor_4c_BuscaCrg
            ENDIF
            IF USED("cursor_4c_UltPer")
                USE IN cursor_4c_UltPer
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar erros no Destroy
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
