*==============================================================================
* FORMSIGRECOP.PRG
* Relatorio Comiss" + CHR(245) + "es por Recebimento - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECOP.SCX (frmrelatorio)
*
* Filtros (Page1):
*   - Periodo     : txt_4c_DtInicial / txt_4c_DtFinal
*   - Empresa     : txt_4c_CdEmpresa (c=3) + txt_4c_DsEmpresa (c=40)
*   - Grupo       : txt_4c_CdGrEstoque (c=10) + txt_4c_DsGrEstoque (c=20)
*   - Conta       : txt_4c_CdEstoque (c=10) + txt_4c_DsEstoque (c=40)
*   - Moeda       : txt_4c_CdMoeda (c=3) + txt_4c_DsMoeda (c=15)
*   - Unifica     : opt_4c_Unifica (2: Unificar/Filtrar)
*   - Tipo        : opt_4c_Tipo (4: Anal./ Sint./ Resumido / Anal. por parcelas)
*   - Selecao     : opt_4c_Quebras (3: Todos / Pagos / Nao Pagos)
*   - Movimento   : opt_4c_Movs (3: Ambas / Entradas / Saidas)
*   - % Comissao  : chk_4c_PComis (checkbox)
*   - Saldo       : opt_4c_Saldo (2: Sim / Nao; default=2)
*
* Form: Width=800, Height=400
* Cabecalho: Top=0, Height=80
* PageFrame: Top=85, Height=315, Width=802
* Page1 controls: Top_page1 = Top_original - 85
*==============================================================================

DEFINE CLASS Formsigrecop AS FormBase

    Height      = 400
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
    * InicializarForm - Cria estrutura visual e instancia BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Comiss" + CHR(245) + "es por Recebimento"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigrecopBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecopBO" + CHR(13) + ;
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
    * ConfigurarCabecalho - Container cinza escuro com titulo e botoes de acao
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
                .Caption   = "Comiss" + CHR(245) + "es por Recebimento"
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
                .Caption   = "Comiss" + CHR(245) + "es por Recebimento"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

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
    *   Form Height=400; Cabecalho Height=80; PageFrame Top=85, Height=315
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
    *   (Form original: Top=108..333; PageFrame.Top=85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Periodo (top_orig=111, left=203 -> page1 top=26)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 26
            .Left      = 203
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
            .Top           = 23
            .Left          = 252
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")

        loc_oPagina.AddObject("lbl_4c_PeriodoSep", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoSep
            .Top       = 27
            .Left      = 336
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
            .Top           = 23
            .Left          = 348
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")

        *-- Empresa (top_orig=137, left=198 -> page1 top=52)
        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 52
            .Left      = 198
            .Width     = 50
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_CdEmpresa
            .Top           = 48
            .Left          = 252
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
        BINDEVENT(loc_oPagina.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")

        loc_oPagina.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_DsEmpresa
            .Top           = 48
            .Left          = 285
            .Width         = 360
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaDsEmpresa")

        *-- Grupo Estoque (top_orig=164, left=210 -> page1 top=79)
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Top       = 79
            .Left      = 210
            .Width     = 38
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdGrEstoque
            .Top           = 75
            .Left          = 252
            .Width         = 79
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K!"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")

        loc_oPagina.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsGrEstoque
            .Top           = 75
            .Left          = 333
            .Width         = 290
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K!"
            .MaxLength     = 20
            .SpecialEffect = 1
            .BorderStyle   = 1
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")

        *-- Conta Estoque (top_orig=191, left=210 -> page1 top=106)
        loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
        WITH loc_oPagina.lbl_4c_Estoque
            .Top       = 106
            .Left      = 210
            .Width     = 38
            .Height    = 15
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdEstoque
            .Top           = 102
            .Left          = 252
            .Width         = 79
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K!"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderStyle   = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque, "KeyPress", THIS, "TeclaCdEstoque")

        loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsEstoque
            .Top           = 102
            .Left          = 333
            .Width         = 290
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderStyle   = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque, "KeyPress", THIS, "TeclaDsEstoque")

        *-- Moeda (top_orig=216, left=207 -> page1 top=131)
        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Top       = 131
            .Left      = 207
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
            .Top           = 128
            .Left          = 252
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

        loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_DsMoeda
            .Top           = 128
            .Left          = 285
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

        *-- Unifica (top_orig=214, left=401 -> page1 top=129)
        loc_oPagina.AddObject("opt_4c_Unifica", "OptionGroup")
        WITH loc_oPagina.opt_4c_Unifica
            .Top         = 129
            .Left        = 401
            .Width       = 134
            .Height      = 25
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Unificar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 5
                .Left      = 5
                .Width     = 54
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Filtrar"
                .Top       = 5
                .Left      = 78
                .Width     = 46
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Tipo (top_orig=243, left=219 -> page1 top=158)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Top       = 158
            .Left      = 219
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
            .Top         = 154
            .Left        = 247
            .Width       = 368
            .Height      = 27
            .ButtonCount = 4
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Anal" + CHR(237) + "tico"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 5
                .Left      = 5
                .Width     = 58
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Sint" + CHR(233) + "tico"
                .Top       = 5
                .Left      = 82
                .Width     = 59
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Resumido"
                .WordWrap        = .T.
                .Top       = 5
                .Left      = 157
                .Width     = 76
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "Anal" + CHR(237) + "tico por parcelas"
                .WordWrap        = .T.
                .Top       = 7
                .Left      = 243
                .Width     = 120
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Selecao / Quebras (top_orig=265, left=202 -> page1 top=180)
        loc_oPagina.AddObject("lbl_4c_Selecao", "Label")
        WITH loc_oPagina.lbl_4c_Selecao
            .Top       = 180
            .Left      = 202
            .Width     = 43
            .Height    = 18
            .Caption   = "Sele" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Quebras", "OptionGroup")
        WITH loc_oPagina.opt_4c_Quebras
            .Top         = 176
            .Left        = 247
            .Width       = 231
            .Height      = 25
            .ButtonCount = 3
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Todos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 5
                .Left      = 5
                .Width     = 47
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Pagos"
                .Top       = 5
                .Left      = 82
                .Width     = 47
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "N" + CHR(227) + "o Pagos"
                .WordWrap        = .T.
                .Top       = 5
                .Left      = 157
                .Width     = 69
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Movimento (top_orig=287, left=187 -> page1 top=202)
        loc_oPagina.AddObject("lbl_4c_Movimento", "Label")
        WITH loc_oPagina.lbl_4c_Movimento
            .Top       = 202
            .Left      = 187
            .Width     = 57
            .Height    = 18
            .Caption   = "Movimento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Movs", "OptionGroup")
        WITH loc_oPagina.opt_4c_Movs
            .Top         = 198
            .Left        = 247
            .Width       = 211
            .Height      = 25
            .ButtonCount = 3
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Ambas"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 5
                .Left      = 5
                .Width     = 50
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Entradas"
                .Top       = 5
                .Left      = 82
                .Width     = 61
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Sa" + CHR(237) + "das"
                .WordWrap        = .T.
                .Top       = 5
                .Left      = 157
                .Width     = 49
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- % Comissao (top_orig=312, left=397 -> page1 top=227)
        loc_oPagina.AddObject("chk_4c_PComis", "CheckBox")
        WITH loc_oPagina.chk_4c_PComis
            .Top       = 227
            .Left      = 397
            .Width     = 77
            .Height    = 15
            .Caption   = "% Comiss" + CHR(227) + "o"
            .Value     = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Saldo (top_orig=333, left=213 -> page1 top=248)
        loc_oPagina.AddObject("lbl_4c_Saldo", "Label")
        WITH loc_oPagina.lbl_4c_Saldo
            .Top       = 248
            .Left      = 213
            .Width     = 35
            .Height    = 15
            .Caption   = "Saldo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Saldo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Saldo
            .Top         = 244
            .Left        = 247
            .Width       = 117
            .Height      = 25
            .ButtonCount = 2
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 5
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 75
                .Width     = 37
                .Height    = 15
                .AutoSize  = .T.
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
    * LimparCampos - Inicializa filtros com valores padrao
    *   Empresa: inicializa com a empresa atual do sistema
    *   Datas: hoje / hoje
    *   Opcoes: valores padrao conforme original
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_cCodEmp, loc_cNmEmp, loc_cSQL, loc_nRes, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodEmp = ""
            loc_cNmEmp  = ""

            IF TYPE("go_4c_Sistema") = "O" AND ;
               VARTYPE(go_4c_Sistema) = "O"
                loc_cCodEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            IF !EMPTY(loc_cCodEmp)
                loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                           EscaparSQL(PADR(loc_cCodEmp, 3))
                IF USED("cursor_4c_EmpInit")
                    USE IN cursor_4c_EmpInit
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpInit")
                IF loc_nRes > 0 AND !EOF("cursor_4c_EmpInit")
                    SELECT cursor_4c_EmpInit
                    loc_cNmEmp = ALLTRIM(cursor_4c_EmpInit.razas)
                ENDIF
                IF USED("cursor_4c_EmpInit")
                    USE IN cursor_4c_EmpInit
                ENDIF
            ENDIF

            WITH loc_oPagina
                .txt_4c_DtInicial.Value    = DATE()
                .txt_4c_DtFinal.Value      = DATE()
                .txt_4c_CdEmpresa.Value    = loc_cCodEmp
                .txt_4c_DsEmpresa.Value    = loc_cNmEmp
                .txt_4c_CdGrEstoque.Value  = ""
                .txt_4c_DsGrEstoque.Value  = ""
                .txt_4c_CdEstoque.Value    = ""
                .txt_4c_DsEstoque.Value    = ""
                .txt_4c_CdMoeda.Value      = ""
                .txt_4c_DsMoeda.Value      = ""
                .opt_4c_Unifica.Value      = 1
                .opt_4c_Tipo.Value         = 1
                .opt_4c_Quebras.Value      = 1
                .opt_4c_Movs.Value         = 1
                .chk_4c_PComis.Value       = 1
                .opt_4c_Saldo.Value        = 2
            ENDWITH

            THIS.AtualizarEstadoCamposEstoque()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa pagina informada (forms REPORT tem so Page1)
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
            .this_dDtInicial     = loc_oPagina.txt_4c_DtInicial.Value
            .this_dDtFinal       = loc_oPagina.txt_4c_DtFinal.Value
            .this_cCdEmpresa     = ALLTRIM(loc_oPagina.txt_4c_CdEmpresa.Value)
            .this_cDsEmpresa     = ALLTRIM(loc_oPagina.txt_4c_DsEmpresa.Value)
            .this_cCdGrEstoque   = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            .this_cDsGrEstoque   = ALLTRIM(loc_oPagina.txt_4c_DsGrEstoque.Value)
            .this_cCdEstoque     = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
            .this_cDsEstoque     = ALLTRIM(loc_oPagina.txt_4c_DsEstoque.Value)
            .this_cCdMoeda       = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)
            .this_cDsMoeda       = ALLTRIM(loc_oPagina.txt_4c_DsMoeda.Value)
            .this_nUnifica       = loc_oPagina.opt_4c_Unifica.Value
            .this_nTipo          = loc_oPagina.opt_4c_Tipo.Value
            .this_nQuebras       = loc_oPagina.opt_4c_Quebras.Value
            .this_nMovs          = loc_oPagina.opt_4c_Movs.Value
            .this_nSaldo         = loc_oPagina.opt_4c_Saldo.Value
            .this_nPComis        = loc_oPagina.chk_4c_PComis.Value
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
    * TeclaDataInicial / TeclaDataFinal - KeyPress em campos de data (sem acao)
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
    *   ENTER(13)/TAB(9): valida (abre busca por descricao)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdEmpresa - KeyPress em txt_4c_CdEmpresa
    *   F4(115)/F5(116): abre lookup de empresa por codigo
    *   ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaEmpresa("cemps")
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsEmpresa - KeyPress em txt_4c_DsEmpresa
    *   ENTER(13)/TAB(9): abre busca por nome
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.AbrirBuscaEmpresa("razas")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdGrEstoque - KeyPress em txt_4c_CdGrEstoque
    *   F4/F5(115/116): abre lookup de grupo contabil por codigo
    *   ENTER(13)/TAB(9): valida codigo via fAcessoContab
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF INLIST(par_nKeyCode, 115, 116)
            loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            fAcessoContab(gc_4c_UsuarioLogado, 'C', loc_cValor, ;
                loc_oPagina.txt_4c_CdGrEstoque, loc_oPagina.txt_4c_DsGrEstoque)
            THIS.AtualizarEstadoCamposEstoque()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            IF EMPTY(loc_cValor)
                loc_oPagina.txt_4c_DsGrEstoque.Value = ""
            ELSE
                fAcessoContab(gc_4c_UsuarioLogado, 'C', loc_cValor, ;
                    loc_oPagina.txt_4c_CdGrEstoque, loc_oPagina.txt_4c_DsGrEstoque)
            ENDIF
            THIS.AtualizarEstadoCamposEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsGrEstoque - KeyPress em txt_4c_DsGrEstoque
    *   F4/F5(115/116) ou ENTER(13)/TAB(9): busca grupo por descricao via fAcessoContab
    *   (ativo apenas quando CdGrEstoque esta vazio)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            loc_cValor = ALLTRIM(loc_oPagina.txt_4c_DsGrEstoque.Value)
            IF EMPTY(loc_cValor)
                loc_oPagina.txt_4c_CdGrEstoque.Value = ""
            ELSE
                fAcessoContab(gc_4c_UsuarioLogado, 'D', loc_cValor, ;
                    loc_oPagina.txt_4c_CdGrEstoque, loc_oPagina.txt_4c_DsGrEstoque)
            ENDIF
            THIS.AtualizarEstadoCamposEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdEstoque - KeyPress em txt_4c_CdEstoque
    *   F4/F5(115/116): abre lookup de conta por codigo via fAcessoContas
    *   ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor, loc_cGrupo, loc_lAcesso
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
        IF INLIST(par_nKeyCode, 115, 116)
            loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
            fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, 'C', loc_cValor, ;
                loc_oPagina.txt_4c_CdEstoque, loc_oPagina.txt_4c_DsEstoque)
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
            IF EMPTY(loc_cValor)
                loc_oPagina.txt_4c_DsEstoque.Value = ""
            ELSE
                loc_lAcesso = fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, 'C', loc_cValor, ;
                    loc_oPagina.txt_4c_CdEstoque, loc_oPagina.txt_4c_DsEstoque)
                IF !loc_lAcesso
                    MsgAviso("Acesso Negado !!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oPagina.txt_4c_CdEstoque.Value = ""
                    loc_oPagina.txt_4c_DsEstoque.Value = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsEstoque - KeyPress em txt_4c_DsEstoque
    *   F4/F5(115/116) ou ENTER(13)/TAB(9): busca conta por descricao via fAcessoContas
    *   (ativo apenas quando CdEstoque esta vazio e Grupo preenchido)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor, loc_cGrupo, loc_lAcesso
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            loc_cValor = ALLTRIM(loc_oPagina.txt_4c_DsEstoque.Value)
            IF EMPTY(loc_cValor)
                loc_oPagina.txt_4c_CdEstoque.Value = ""
            ELSE
                loc_lAcesso = fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, 'D', loc_cValor, ;
                    loc_oPagina.txt_4c_CdEstoque, loc_oPagina.txt_4c_DsEstoque)
                IF !loc_lAcesso
                    MsgAviso("Acesso Negado !!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oPagina.txt_4c_DsEstoque.Value = ""
                    loc_oPagina.txt_4c_CdEstoque.Value = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Busca moeda pelo codigo e preenche descricao
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
    * ValidarDsMoeda - Busca moeda pela descricao e preenche codigo
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
    * ValidarCdEmpresa - Busca empresa pelo codigo e preenche razao social
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oErro
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdEmpresa.Value)

        TRY
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsEmpresa.Value = ""
            ELSE
                loc_cSQL = "SELECT cemps, razas FROM SigCdEmp " + ;
                           "WHERE cemps = " + EscaparSQL(PADR(loc_cValor, 3))
                IF USED("cursor_4c_EmpVal")
                    USE IN cursor_4c_EmpVal
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
                IF loc_nResult > 0 AND !EOF("cursor_4c_EmpVal")
                    SELECT cursor_4c_EmpVal
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdEmpresa.Value = ;
                        ALLTRIM(cursor_4c_EmpVal.cemps)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsEmpresa.Value = ;
                        ALLTRIM(cursor_4c_EmpVal.razas)
                ELSE
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdEmpresa.Value = ""
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsEmpresa.Value = ""
                    THIS.AbrirBuscaEmpresa("cemps")
                ENDIF
                IF USED("cursor_4c_EmpVal")
                    USE IN cursor_4c_EmpVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - Abre FormBuscaAuxiliar para selecao de moeda
    *   par_cCampoBusca: "cmoes" (por codigo) ou "dmoes" (por descricao)
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
    * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecao de empresa
    *   par_cCampoBusca: "cemps" (por codigo) ou "razas" (por nome)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa(par_cCampoBusca)
        LOCAL loc_oBusca, loc_oErro, loc_cCampo, loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_cCampo = IIF(LOWER(ALLTRIM(par_cCampoBusca)) = "razas", "razas", "cemps")
            IF loc_cCampo = "cemps"
                loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CdEmpresa.Value)
            ELSE
                loc_cValor = ALLTRIM(loc_oPagina.txt_4c_DsEmpresa.Value)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                loc_cCampo, ;
                loc_cValor, ;
                "Selecionar Empresa")

            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar janela de busca de Empresa.", "Erro")
            ELSE
                IF loc_cCampo = "cemps"
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                ELSE
                    loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                ENDIF
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                        loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
                    ENDIF
                ELSE
                    IF loc_cCampo = "cemps"
                        loc_oPagina.txt_4c_CdEmpresa.Value = ""
                    ENDIF
                    loc_oPagina.txt_4c_DsEmpresa.Value = ""
                ENDIF

                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCamposEstoque - Gerencia ReadOnly de Grupo e Conta
    *   Logica dos When events originais:
    *   get_Ds_GrEstoque.When = IsEmpty(get_Cd_GrEstoque)  -> editavel p/ busca por nome
    *   get_cd_estoque.When   = !IsEmpty(get_Cd_GrEstoque) -> habilitado so com grupo
    *   get_ds_estoque.When   = !IsEmpty(grupo) AND IsEmpty(cd_estoque)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCamposEstoque()
        LOCAL loc_oPagina, loc_lGrupoPreench, loc_lEstoquePreench, loc_oErro
        TRY
            loc_oPagina         = THIS.pgf_4c_Paginas.Page1
            loc_lGrupoPreench   = !EMPTY(ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value))
            loc_lEstoquePreench = !EMPTY(ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value))

            *-- DsGrEstoque: editavel somente quando Cd esta vazio (busca por descricao)
            loc_oPagina.txt_4c_DsGrEstoque.ReadOnly = loc_lGrupoPreench

            *-- CdEstoque: habilitado somente quando Grupo preenchido
            loc_oPagina.txt_4c_CdEstoque.ReadOnly = !loc_lGrupoPreench

            *-- DsEstoque: editavel quando Grupo preenchido E Cd esta vazio
            loc_oPagina.txt_4c_DsEstoque.ReadOnly = !loc_lGrupoPreench OR loc_lEstoquePreench

            IF !loc_lGrupoPreench
                loc_oPagina.txt_4c_CdEstoque.Value = ""
                loc_oPagina.txt_4c_DsEstoque.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AtualizarEstadoCamposEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Aliases de interface CRUD exigidos pelo pipeline multi-fase
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
                    loc_oPg.txt_4c_CdEmpresa.Value   = .this_cCdEmpresa
                    loc_oPg.txt_4c_DsEmpresa.Value   = .this_cDsEmpresa
                    loc_oPg.txt_4c_CdGrEstoque.Value = .this_cCdGrEstoque
                    loc_oPg.txt_4c_DsGrEstoque.Value = .this_cDsGrEstoque
                    loc_oPg.txt_4c_CdEstoque.Value   = .this_cCdEstoque
                    loc_oPg.txt_4c_DsEstoque.Value   = .this_cDsEstoque
                    IF !EMPTY(.this_cCdMoeda)
                        loc_oPg.txt_4c_CdMoeda.Value = .this_cCdMoeda
                    ENDIF
                    IF !EMPTY(.this_cDsMoeda)
                        loc_oPg.txt_4c_DsMoeda.Value = .this_cDsMoeda
                    ENDIF
                    loc_oPg.opt_4c_Unifica.Value  = .this_nUnifica
                    loc_oPg.opt_4c_Tipo.Value      = .this_nTipo
                    loc_oPg.opt_4c_Quebras.Value   = .this_nQuebras
                    loc_oPg.opt_4c_Movs.Value      = .this_nMovs
                    loc_oPg.opt_4c_Saldo.Value     = .this_nSaldo
                    loc_oPg.chk_4c_PComis.Value    = .this_nPComis
                ENDWITH
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
                IF PEMSTATUS(loc_oPg, "txt_4c_CdEmpresa", 5)
                    loc_oPg.txt_4c_CdEmpresa.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoque", 5)
                    loc_oPg.txt_4c_CdGrEstoque.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdEstoque", 5)
                    loc_oPg.txt_4c_CdEstoque.ReadOnly = !loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Forms REPORT nao tem grid CRUD
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
