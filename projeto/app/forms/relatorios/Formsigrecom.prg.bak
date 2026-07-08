*==============================================================================
* FORMSIGRECOM.PRG
* Relatorio de Comissao - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECOM.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo : txt_4c_DtInicial / txt_4c_DtFinal
*   - Moeda   : txt_4c_CdMoeda (c=3) + txt_4c_DsMoeda (c=15)
*   - Vendedor: txt_4c_Vendedor (c=10)
*   - Opcao   : opt_4c_NrOpcao  (3 botoes, captions de SigCdPac)
*   - Tipo    : opt_4c_Tipo     (4: Analitico/Sintetico/Resumo/AnalMedias)
*   - Quebra  : opt_4c_Quebras  (2: Datas / Datas+Operacoes)
*   - ValBase : opt_4c_Base     (3: Itens/Movimentacao/Movimentacao S/ST)
*   - Ordem   : opt_4c_Ordem   (6 opcoes, so visivel quando Tipo=4, hidden)
*
* Dimensoes originais: Width=800, Height=300
* Cabecalho Top=0, Height=80
* PageFrame Top=85, Height=215 (300-85)
* Page1.Top = Top_original - 85
*==============================================================================

DEFINE CLASS Formsigrecom AS FormBase

    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigrecomBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecomBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()
                THIS.InicializarOpcoes()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo e botoes
    *   BackColor=RGB(100,100,100) = cinza medio do framework (cntSombra)
    *   cmg_4c_Botoes: CommandGroup 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_oCmg
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho

        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Botoes de relatorio (framework frmrelatorio: cmg_4c_Botoes)
            *-- Left=529 Width=273 canonico frmrelatorio; FontName=Comic Sans MS; Width=65 por botao
            .AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH .cmg_4c_Botoes
                .Top           = 0
                .Left          = 529
                .Width         = THIS.Width
                .Height        = 80
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderColor   = RGB(136, 189, 188)
                .SpecialEffect = 1
                .Themes        = .F.
                .Visible       = .T.

                WITH .Buttons(1)
                    .Caption         = "Visualizar"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .Top             = 5
                    .Left            = 5
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                    .PicturePosition = 13
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Caption         = "Imprimir"
                    .Top             = 5
                    .Left            = 71
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Caption         = "Doc. Excel"
                    .WordWrap        = .T.
                    .Top             = 5
                    .Left            = 137
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(4)
                    .Caption         = "Sair"
                    .WordWrap        = .T.
                    .Top             = 5
                    .Left            = 203
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                    .PicturePosition = 13
                    .Cancel          = .T.
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH
            ENDWITH
        ENDWITH

        loc_oCmg = loc_oCab.cmg_4c_Botoes
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Form: Width=800, Height=300
    *   Cabecalho Height=80; PageFrame Top=85, Height=215, Width=802
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top       = 85
        loc_oPgf.Left      = -1
        loc_oPgf.Width     = THIS.Width + 2
        loc_oPgf.Height    = THIS.Height - 85
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Controles de filtro na Page1
    *   Posicoes: Top_page1 = Top_original - 85
    *   Controles de data, moeda, vendedor e grupos de opcao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCtrl
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Periodo
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 7
            .Left      = 215
            .Width     = 46
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Top         = 3
            .Left        = 264
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .Format      = "K"
            .MaxLength   = 10
            .SpecialEffect = 1
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")

        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 8
            .Left      = 348
            .Width     = 8
            .Height    = 18
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Top         = 3
            .Left        = 360
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .Format      = "K"
            .MaxLength   = 10
            .SpecialEffect = 1
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")

        *-- Moeda
        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Top       = 32
            .Left      = 219
            .Width     = 42
            .Height    = 18
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_CdMoeda
            .Top           = 28
            .Left          = 264
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K!"
            .MaxLength     = 3
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "KeyPress", THIS, "TeclaCdMoeda")
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "KeyPress", THIS, "ValidarCdMoeda")

        loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_DsMoeda
            .Top           = 28
            .Left          = 297
            .Width         = 115
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K!"
            .MaxLength     = 15
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "TeclaDsMoeda")
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "ValidarDsMoeda")

        *-- Vendedor
        loc_oPagina.AddObject("lbl_4c_Vendedor", "Label")
        WITH loc_oPagina.lbl_4c_Vendedor
            .Top       = 56
            .Left      = 205
            .Width     = 56
            .Height    = 18
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Vendedor", "TextBox")
        WITH loc_oPagina.txt_4c_Vendedor
            .Top           = 53
            .Left          = 264
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .InputMask     = "!!!!!!!!!!"
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Vendedor, "KeyPress",  THIS, "TeclaVendedor")
        BINDEVENT(loc_oPagina.txt_4c_Vendedor, "KeyPress", THIS, "ValidarVendedor")

        *-- Opcao (titulos dinamicos de SigCdPac)
        loc_oPagina.AddObject("lbl_4c_Opcao", "Label")
        WITH loc_oPagina.lbl_4c_Opcao
            .Top       = 84
            .Left      = 220
            .Width     = 40
            .Height    = 18
            .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_NrOpcao", "OptionGroup")
        WITH loc_oPagina.opt_4c_NrOpcao
            .Top         = 80
            .Left        = 259
            .Width       = 220
            .Height      = 23
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 4
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 4
                .Left      = 82
                .Width     = 37
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Ambos"
                .WordWrap        = .T.
                .Top       = 4
                .Left      = 157
                .Width     = 50
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Tipo (Analitico/Sintetico/Resumo/Analise Medias)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Top       = 107
            .Left      = 231
            .Width     = 25
            .Height    = 18
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Tipo
            .Top         = 103
            .Left        = 259
            .Width       = 356
            .Height      = 23
            .ButtonCount = 4
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Anal" + CHR(237) + "tico"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 4
                .Left      = 5
                .Width     = 67
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Sint" + CHR(233) + "tico"
                .Top       = 4
                .Left      = 82
                .Width     = 68
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Verdana"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Resumo"
                .WordWrap        = .T.
                .Top       = 4
                .Left      = 157
                .Width     = 65
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Verdana"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "An" + CHR(225) + "lise M" + CHR(233) + "dias"
                .WordWrap        = .T.
                .Top       = 3
                .Left      = 234
                .Width     = 103
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Verdana"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Tipo, "Click", THIS, "ClickOptTipo")

        *-- Quebra (Datas / Datas+Operacoes)
        loc_oPagina.AddObject("lbl_4c_Quebra", "Label")
        WITH loc_oPagina.lbl_4c_Quebra
            .Top       = 130
            .Left      = 215
            .Width     = 42
            .Height    = 18
            .Caption   = "Quebra :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Quebras", "OptionGroup")
        WITH loc_oPagina.opt_4c_Quebras
            .Top         = 126
            .Left        = 259
            .Width       = 220
            .Height      = 23
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Datas"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 4
                .Left      = 5
                .Width     = 46
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Datas + Opera" + CHR(231) + CHR(245) + "es"
                .Top       = 4
                .Left      = 82
                .Width     = 112
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Valor Base (Itens / Movimentacao / Movimentacao S/ST)
        loc_oPagina.AddObject("lbl_4c_Base", "Label")
        WITH loc_oPagina.lbl_4c_Base
            .Top       = 152
            .Left      = 201
            .Width     = 56
            .Height    = 18
            .Caption   = "Valor Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Base", "OptionGroup")
        WITH loc_oPagina.opt_4c_Base
            .Top         = 148
            .Left        = 259
            .Width       = 364
            .Height      = 23
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Itens"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 4
                .Left      = 5
                .Width     = 43
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Top       = 4
                .Left      = 82
                .Width     = 87
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o S/ST"
                .WordWrap        = .T.
                .Top       = 3
                .Left      = 198
                .Width     = 139
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Ordens (so visivel quando Tipo=4; hidden por padrao)
        loc_oPagina.AddObject("lbl_4c_Ordem", "Label")
        WITH loc_oPagina.lbl_4c_Ordem
            .Top       = 172
            .Left      = 216
            .Width     = 40
            .Height    = 18
            .Caption   = "Ordens :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Ordem", "OptionGroup")
        WITH loc_oPagina.opt_4c_Ordem
            .Top         = 173
            .Left        = 260
            .Width       = 292
            .Height      = 37
            .ButtonCount = 6
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Enabled     = .F.
            .Visible     = .F.

            WITH .Buttons(1)
                .Caption   = "Vendedor"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 1
                .Left      = 4
                .Width     = 64
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Qtde Pe" + CHR(231) + "as"
                .Top       = 1
                .Left      = 100
                .Width     = 73
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "M" + CHR(233) + "dia Pe" + CHR(231) + "as"
                .WordWrap        = .T.
                .Top       = 1
                .Left      = 196
                .Width     = 77
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "Qtde Opers"
                .WordWrap        = .T.
                .Top       = 17
                .Left      = 4
                .Width     = 83
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(5)
                .Caption   = "M" + CHR(233) + "dia Opers"
                .Top       = 17
                .Left      = 100
                .Width     = 83
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(6)
                .Caption   = "Comiss" + CHR(227) + "o"
                .Top       = 17
                .Left      = 196
                .Width     = 83
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao utilizado em form REPORT (sem Page2 de edicao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarOpcoes - Carrega captions dinamicos de SigCdPac e acesso
    *   Chamado apos LimparCampos para sobrescrever os defaults do opt_4c_NrOpcao
    *--------------------------------------------------------------------------
    PROCEDURE InicializarOpcoes()
        LOCAL loc_oPagina, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.CarregarCaptionsOpcao()
            ENDIF

            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                WITH loc_oPagina.opt_4c_NrOpcao
                    IF !EMPTY(THIS.this_oRelatorio.this_cTitOpcS)
                        .Buttons(1).Caption = THIS.this_oRelatorio.this_cTitOpcS
                    ENDIF
                    IF !EMPTY(THIS.this_oRelatorio.this_cTitOpcN)
                        .Buttons(2).Caption = THIS.this_oRelatorio.this_cTitOpcN
                    ENDIF
                    IF !EMPTY(THIS.this_oRelatorio.this_cTitOpcA)
                        .Buttons(3).Caption = THIS.this_oRelatorio.this_cTitOpcA
                    ENDIF
                ENDWITH
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarOpcoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa filtros com valores padrao
    *   Moeda padrao: R (Real) com descricao buscada do banco
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_cDsReal, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cDsReal = ""

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_cDsReal = THIS.this_oRelatorio.CarregarMoedaPadrao("R")
            ENDIF

            WITH loc_oPagina
                .txt_4c_DtInicial.Value  = DATE()
                .txt_4c_DtFinal.Value    = DATE()
                .txt_4c_CdMoeda.Value    = "R"
                .txt_4c_DsMoeda.Value    = loc_cDsReal
                .txt_4c_Vendedor.Value   = ""
                .txt_4c_Vendedor.Enabled = .T.
                .opt_4c_NrOpcao.Value    = 3
                .opt_4c_Tipo.Value       = 1
                .opt_4c_Quebras.Value    = 1
                .opt_4c_Base.Value       = 1
                .opt_4c_Ordem.Value      = 1
                .lbl_4c_Ordem.Visible    = .F.
                .opt_4c_Ordem.Visible    = .F.
                .opt_4c_Ordem.Enabled    = .F.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina informada (forms REPORT tem so Page1)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro, loc_oPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
                loc_oPagina.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores do form para o BO antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial = loc_oPagina.txt_4c_DtInicial.Value
            .this_dDtFinal   = loc_oPagina.txt_4c_DtFinal.Value
            .this_cCdMoeda   = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)
            .this_cDsMoeda   = ALLTRIM(loc_oPagina.txt_4c_DsMoeda.Value)
            .this_cVendedor  = ALLTRIM(loc_oPagina.txt_4c_Vendedor.Value)
            .this_nNrOpcao   = loc_oPagina.opt_4c_NrOpcao.Value
            .this_nTipo      = loc_oPagina.opt_4c_Tipo.Value
            .this_nQuebra    = loc_oPagina.opt_4c_Quebras.Value
            .this_nBase      = loc_oPagina.opt_4c_Base.Value
            .this_nOrdem     = loc_oPagina.opt_4c_Ordem.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerarExcelClick - Doc. Excel (impressao direta sem dialogo)
    *   SIGRECOM nao tem export Excel no legado; acao mapeada para impressao
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerarExcelClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ClickOptTipo - Mostra/oculta optOrdem conforme selecao de Tipo
    *   Tipo=4 (Analise Medias): exibe ordem; opcao Base "Itens" proibida
    *--------------------------------------------------------------------------
    PROCEDURE ClickOptTipo()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF loc_oPagina.opt_4c_Tipo.Value = 4
                loc_oPagina.lbl_4c_Ordem.Visible = .T.
                loc_oPagina.opt_4c_Ordem.Visible = .T.
                loc_oPagina.opt_4c_Ordem.Enabled = .T.
                IF loc_oPagina.opt_4c_Base.Value = 1
                    loc_oPagina.opt_4c_Base.Value = 2
                ENDIF
            ELSE
                loc_oPagina.lbl_4c_Ordem.Visible = .F.
                loc_oPagina.opt_4c_Ordem.Visible = .F.
                loc_oPagina.opt_4c_Ordem.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ClickOptTipo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataInicial / TeclaDataFinal - KeyPress em campos de data
    *   Campos de data nao precisam de lookup
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress em txt_4c_CdMoeda
    *   F4(115)/F5(116): abre lookup de moeda por codigo
    *   ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeda("cmoes")
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress em txt_4c_DsMoeda
    *   ENTER(13)/TAB(9): abre lookup de moeda por descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVendedor - KeyPress em txt_4c_Vendedor
    *   F4(115)/F5(116): abre lookup de vendedor
    *   ESC(27) com campo vazio: fecha o formulario (comportamento original)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedor(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaVendedor()
        ENDIF
        IF par_nKeyCode = 27 AND ;
           EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value)
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Busca moeda pelo codigo e preenche descricao (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oErro
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)

        TRY
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
            ELSE
                loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                           "WHERE cmoes = " + EscaparSQL(PADR(loc_cValor, 3))
                IF USED("cursor_4c_MoeVal")
                    USE IN cursor_4c_MoeVal
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
                IF loc_nResult > 0 AND !EOF("cursor_4c_MoeVal")
                    SELECT cursor_4c_MoeVal
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ;
                        ALLTRIM(cursor_4c_MoeVal.cmoes)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ;
                        ALLTRIM(cursor_4c_MoeVal.dmoes)
                ELSE
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
                    THIS.AbrirBuscaMoeda("cmoes")
                ENDIF
                IF USED("cursor_4c_MoeVal")
                    USE IN cursor_4c_MoeVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Busca moeda pela descricao e preenche codigo (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oErro
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value)

        TRY
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("dmoes")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDsMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedor - Valida codigo de vendedor contra SigCdUsu (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarVendedor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oErro, loc_lEncontrou
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value)
        loc_lEncontrou = .F.

        TRY
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT a.usuarios, a.NComps FROM SigCdUsu a " + ;
                           "WHERE NOT a.cAtivos = 'N' " + ;
                           "AND NOT a.Senhas = '" + SPACE(6) + "'"
                IF USED("cursor_4c_UsuVal")
                    USE IN cursor_4c_UsuVal
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
                IF loc_nResult > 0
                    SELECT cursor_4c_UsuVal
                    LOCATE FOR ALLTRIM(cursor_4c_UsuVal.usuarios) == ALLTRIM(loc_cValor)
                    IF !EOF("cursor_4c_UsuVal")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value = ;
                            ALLTRIM(cursor_4c_UsuVal.usuarios)
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_UsuVal")
                    USE IN cursor_4c_UsuVal
                ENDIF
                IF !loc_lEncontrou
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value = ""
                    THIS.AbrirBuscaVendedor()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarVendedor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - Abre FormBuscaAuxiliar para selecao de moeda
    *   par_cCampoBusca: "cmoes" (busca por codigo) ou "dmoes" (por descricao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMoeda(par_cCampoBusca)
        LOCAL loc_oBusca, loc_oErro, loc_cCampo, loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_cCampo = IIF(LOWER(ALLTRIM(par_cCampoBusca)) = "dmoes", "dmoes", "cmoes")
            IF loc_cCampo = "cmoes"
                loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)
            ELSE
                loc_cValor = ALLTRIM(loc_oPagina.txt_4c_DsMoeda.Value)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoe", ;
                loc_cCampo, ;
                loc_cValor, ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar janela de busca de Moeda.", "Erro")
            ELSE
                IF loc_cCampo = "cmoes"
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                ENDIF
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaMoe")
                        SELECT cursor_4c_BuscaMoe
                        loc_oPagina.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                        loc_oPagina.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
                    ENDIF
                ELSE
                    IF loc_cCampo = "cmoes"
                        loc_oPagina.txt_4c_CdMoeda.Value = ""
                    ENDIF
                    loc_oPagina.txt_4c_DsMoeda.Value = ""
                ENDIF

                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVendedor - Abre FormBuscaAuxiliar para selecao de vendedor
    *   Filtra apenas usuarios ativos (cAtivos <> 'N' e Senhas preenchida)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaVendedor()
        LOCAL loc_oBusca, loc_oErro, loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Vendedor.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", ;
                "cursor_4c_BuscaUsu", ;
                "usuarios", ;
                loc_cValor, ;
                "Selecionar Vendedor")

            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar janela de busca de Vendedor.", "Erro")
            ELSE
                loc_oBusca.mAddColuna("usuarios", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("NComps", "", "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaUsu")
                        SELECT cursor_4c_BuscaUsu
                        loc_oPagina.txt_4c_Vendedor.Value = ;
                            ALLTRIM(cursor_4c_BuscaUsu.usuarios)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaUsu")
                    USE IN cursor_4c_BuscaUsu
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaVendedor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Aliases de interface CRUD - exigidos pelo pipeline multi-fase (Fase 8)
    *   Forms REPORT nao possuem Buscar/Encerrar/Salvar como botoes proprios
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick / BtnAlterarClick / BtnExcluirClick
    *   Forms REPORT nao tem operacoes CRUD; delegam para visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO / BOParaForm - Aliases para a interface generica FormBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                WITH THIS.this_oRelatorio
                    IF !EMPTY(.this_dDtInicial)
                        loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
                    ENDIF
                    IF !EMPTY(.this_dDtFinal)
                        loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
                    ENDIF
                    IF !EMPTY(.this_cCdMoeda)
                        loc_oPg.txt_4c_CdMoeda.Value = .this_cCdMoeda
                    ENDIF
                    IF !EMPTY(.this_cDsMoeda)
                        loc_oPg.txt_4c_DsMoeda.Value = .this_cDsMoeda
                    ENDIF
                    loc_oPg.txt_4c_Vendedor.Value  = .this_cVendedor
                    loc_oPg.opt_4c_NrOpcao.Value   = .this_nNrOpcao
                    loc_oPg.opt_4c_Tipo.Value       = .this_nTipo
                    loc_oPg.opt_4c_Quebras.Value    = .this_nQuebra
                    loc_oPg.opt_4c_Base.Value       = .this_nBase
                    loc_oPg.opt_4c_Ordem.Value      = .this_nOrdem
                ENDWITH
                THIS.ClickOptTipo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de filtro
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdMoeda", 5)
                    loc_oPg.txt_4c_CdMoeda.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsMoeda", 5)
                    loc_oPg.txt_4c_DsMoeda.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Vendedor", 5)
                    loc_oPg.txt_4c_Vendedor.Enabled = loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Forms REPORT nao tem grid CRUD
    *   Mantido para compatibilidade com o pipeline (validador de Fase 8)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em forms REPORT todos os botoes ficam habilitados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCmg, loc_oErro, loc_nI
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                FOR loc_nI = 1 TO loc_oCmg.ButtonCount
                    loc_oCmg.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

ENDDEFINE
