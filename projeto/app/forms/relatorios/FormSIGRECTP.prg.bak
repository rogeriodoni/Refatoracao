*==============================================================================
* FORMSIGRECTP.PRG
* Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + "o de Compras
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECTP.SCX (frmrelatorio)
*
* Filtros:
*   - Per" + CHR(237) + "odo de cota" + CHR(231) + CHR(227) + "o (data inicial / final) - obrigat" + CHR(243) + "rio
*   - Per" + CHR(237) + "odo de validade (data v" + CHR(225) + "lida inicial / final) - opcional
*   - Comprador (sigcdusu.Usuarios, MaxLen=10)
*   - Aprovador (sigcdusu.Usuarios, MaxLen=10)
*   - Produto: c" + CHR(243) + "digo (SigCdPro.CPros, MaxLen=14) + descri" + CHR(231) + CHR(227) + "o (SigCdPro.DPros, MaxLen=40)
*   - Fornecedor: c" + CHR(243) + "digo (SigCdCli.IClis, MaxLen=10) + nome (SigCdCli.RClis, MaxLen=40)
*   - Pedidos (Sim/N" + CHR(227) + "o/Ambos)
*   - Aprovados (Sim/N" + CHR(227) + "o/Ambos)
*==============================================================================

DEFINE CLASS FormSIGRECTP AS FormBase

    *-- Dimens" + CHR(245) + "es exatas do original: Width=800, Height=230
    Height      = 230
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *   1. Cria SIGRECTPBO
    *   2. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es + PageFrame com filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + "o de Compras"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("SIGRECTPBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGRECTPBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com 1 p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Controles de filtro na Page1
                THIS.ConfigurarPaginaLista()

                *-- Vincular Click dos bot" + CHR(245) + "es de relat" + CHR(243) + "rio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Valores iniciais dos campos de filtro
                THIS.LimparCampos()

                THIS.Visible = .T.
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
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
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
                .Caption   = "Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + "o de Compras"
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
                .Caption   = "Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + "o de Compras"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es de relat" + CHR(243) + "rio
    *   Original: btnReport.Top=-2, Left=495, Height=85, Width=310
    *   Framework: cmg_4c_Botoes.Top=0, Left=529, Width=273, Height=80
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina (Filtros)
    *   Posicionado logo abaixo do cabe" + CHR(231) + "alho (80px + 5px margem) at" + CHR(233) + " o fim do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

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
    * ConfigurarPaginaLista - Adiciona controles de filtro na Page1
    *   Posi" + CHR(231) + CHR(245) + "es originais SIGRECTP (800x230px) menos offset PageFrame (85px):
    *     Linha 1 (Cota" + CHR(231) + CHR(227) + "o + Comprador): top_original=94 -> page.top=9
    *     Linha 2 (Validade + Aprovador): top_original=119 -> page.top=34
    *     Linha 3 (Produto):   top_original=144 -> page.top=59
    *     Linha 4 (Fornecedor): top_original=169 -> page.top=84
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Linha 1: Cota" + CHR(231) + CHR(227) + "o (per" + CHR(237) + "odo obrigat" + CHR(243) + "rio) + Comprador
        loc_oPg.AddObject("lbl_4c_Cotacao", "Label")
        WITH loc_oPg.lbl_4c_Cotacao
            .Top       = 12
            .Left      = 195
            .Width     = 47
            .Height    = 15
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top         = 9
            .Left        = 246
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Sep1", "Label")
        WITH loc_oPg.lbl_4c_Sep1
            .Top       = 12
            .Left      = 332
            .Width     = 9
            .Height    = 15
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top         = 9
            .Left        = 343
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Comprador", "Label")
        WITH loc_oPg.lbl_4c_Comprador
            .Top       = 12
            .Left      = 474
            .Width     = 62
            .Height    = 15
            .Caption   = "Comprador :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Comprador", "TextBox")
        WITH loc_oPg.txt_4c_Comprador
            .Top         = 9
            .Left        = 538
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .MaxLength   = 10
            .Format      = "K"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Linha 2: Validade (per" + CHR(237) + "odo opcional) + Aprovador
        loc_oPg.AddObject("lbl_4c_Validade", "Label")
        WITH loc_oPg.lbl_4c_Validade
            .Top       = 37
            .Left      = 195
            .Width     = 56
            .Height    = 15
            .Caption   = "Validade :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtValidIs", "TextBox")
        WITH loc_oPg.txt_4c_DtValidIs
            .Top         = 34
            .Left        = 246
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Sep2", "Label")
        WITH loc_oPg.lbl_4c_Sep2
            .Top       = 37
            .Left      = 332
            .Width     = 9
            .Height    = 15
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtValidFs", "TextBox")
        WITH loc_oPg.txt_4c_DtValidFs
            .Top         = 34
            .Left        = 343
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Aprovador", "Label")
        WITH loc_oPg.lbl_4c_Aprovador
            .Top       = 37
            .Left      = 476
            .Width     = 60
            .Height    = 15
            .Caption   = "Aprovador :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Aprovador", "TextBox")
        WITH loc_oPg.txt_4c_Aprovador
            .Top         = 34
            .Left        = 538
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .MaxLength   = 10
            .Format      = "K"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Linha 3: Produto (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
        loc_oPg.AddObject("lbl_4c_Produto", "Label")
        WITH loc_oPg.lbl_4c_Produto
            .Top       = 62
            .Left      = 197
            .Width     = 47
            .Height    = 15
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CPros", "TextBox")
        WITH loc_oPg.txt_4c_CPros
            .Top         = 59
            .Left        = 246
            .Width       = 108
            .Height      = 23
            .Value       = ""
            .MaxLength   = 14
            .Format      = "K"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DPros", "TextBox")
        WITH loc_oPg.txt_4c_DPros
            .Top         = 59
            .Left        = 356
            .Width       = 262
            .Height      = 23
            .Value       = ""
            .MaxLength   = 40
            .Format      = "K"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Linha 4: Fornecedor (c" + CHR(243) + "digo + nome)
        loc_oPg.AddObject("lbl_4c_Fornecedor", "Label")
        WITH loc_oPg.lbl_4c_Fornecedor
            .Top       = 87
            .Left      = 180
            .Width     = 64
            .Height    = 15
            .Caption   = "Fornecedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_IClis", "TextBox")
        WITH loc_oPg.txt_4c_IClis
            .Top         = 84
            .Left        = 246
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .MaxLength   = 10
            .Format      = "K"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_RClis", "TextBox")
        WITH loc_oPg.txt_4c_RClis
            .Top         = 84
            .Left        = 328
            .Width       = 290
            .Height      = 23
            .Value       = ""
            .MaxLength   = 40
            .Format      = "K"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- OptionGroups e BINDEVENTs na sequ" + CHR(234) + "ncia
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona OptionGroups e vincula todos os BINDEVENTs
    *   Linha 5: Pedidos + Aprovados (top_original=195 -> page.top=110)
    *   Todos os handlers de teclado e DblClick tamb" + CHR(233) + "m s" + CHR(227) + "o vinculados aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Pedidos :"
        loc_oPg.AddObject("lbl_4c_Pedidos", "Label")
        WITH loc_oPg.lbl_4c_Pedidos
            .Top       = 114
            .Left      = 198
            .Width     = 46
            .Height    = 15
            .Caption   = "Pedidos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Pedidos (Sim/N" + CHR(227) + "o/Ambos) - ButtonCount ANTES de Buttons(N)
        loc_oPg.AddObject("opt_4c_Pedidos", "OptionGroup")
        loc_oPg.opt_4c_Pedidos.ButtonCount = 3
        WITH loc_oPg.opt_4c_Pedidos
            .Top         = 110
            .Left        = 239
            .Width       = 156
            .Height      = 24
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_Pedidos.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 4
            .Width     = 34
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Pedidos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 4
            .Width     = 37
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Pedidos.Buttons(3)
            .Caption   = "Ambos"
            .WordWrap        = .T.
            .Left      = 96
            .Top       = 4
            .Width     = 50
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_Pedidos.Value = 3

        *-- Label "Aprova" + CHR(231) + CHR(227) + "o :"
        loc_oPg.AddObject("lbl_4c_Aprovacao", "Label")
        WITH loc_oPg.lbl_4c_Aprovacao
            .Top       = 115
            .Left      = 416
            .Width     = 61
            .Height    = 15
            .Caption   = "Aprova" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Aprovados (Sim/N" + CHR(227) + "o/Ambos)
        loc_oPg.AddObject("opt_4c_Aprovados", "OptionGroup")
        loc_oPg.opt_4c_Aprovados.ButtonCount = 3
        WITH loc_oPg.opt_4c_Aprovados
            .Top         = 110
            .Left        = 474
            .Width       = 149
            .Height      = 24
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_Aprovados.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 4
            .Width     = 34
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Aprovados.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 46
            .Top       = 4
            .Width     = 37
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Aprovados.Buttons(3)
            .Caption   = "Ambos"
            .WordWrap        = .T.
            .Left      = 89
            .Top       = 4
            .Width     = 50
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_Aprovados.Value = 3

        *-- BINDEVENTs: KeyPress nos campos de data (valida per" + CHR(237) + "odo)
        BINDEVENT(loc_oPg.txt_4c_DtInicial,  "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,    "KeyPress", THIS, "TeclaDataFinal")
        BINDEVENT(loc_oPg.txt_4c_DtValidIs,  "KeyPress", THIS, "TeclaDataValidIs")
        BINDEVENT(loc_oPg.txt_4c_DtValidFs,  "KeyPress", THIS, "TeclaDataValidFs")

        *-- BINDEVENTs: KeyPress + DblClick nos campos com lookup
        BINDEVENT(loc_oPg.txt_4c_Comprador, "KeyPress", THIS, "TeclaComprador")
        BINDEVENT(loc_oPg.txt_4c_Comprador, "DblClick", THIS, "AbrirBuscaComprador")
        BINDEVENT(loc_oPg.txt_4c_Aprovador, "KeyPress", THIS, "TeclaAprovador")
        BINDEVENT(loc_oPg.txt_4c_Aprovador, "DblClick", THIS, "AbrirBuscaAprovador")
        BINDEVENT(loc_oPg.txt_4c_CPros,     "KeyPress", THIS, "TeclaCPros")
        BINDEVENT(loc_oPg.txt_4c_CPros,     "DblClick", THIS, "AbrirBuscaCPros")
        BINDEVENT(loc_oPg.txt_4c_DPros,     "KeyPress", THIS, "TeclaDPros")
        BINDEVENT(loc_oPg.txt_4c_DPros,     "DblClick", THIS, "AbrirBuscaDPros")
        BINDEVENT(loc_oPg.txt_4c_IClis,     "KeyPress", THIS, "TeclaIClis")
        BINDEVENT(loc_oPg.txt_4c_IClis,     "DblClick", THIS, "AbrirBuscaIClis")
        BINDEVENT(loc_oPg.txt_4c_RClis,     "KeyPress", THIS, "TeclaRClis")
        BINDEVENT(loc_oPg.txt_4c_RClis,     "DblClick", THIS, "AbrirBuscaRClis")

        *-- Inicializar estado de habilita" + CHR(231) + CHR(227) + "o dos campos de descri" + CHR(231) + CHR(227) + "o
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padr" + CHR(227) + "o
    *   Datas cota" + CHR(231) + CHR(227) + "o = DATE(), validade = {} (vazia), textos em branco, op" + CHR(231) + CHR(245) + "es = Ambos
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DtInicial.Value  = DATE()
            loc_oPg.txt_4c_DtFinal.Value    = DATE()
            loc_oPg.txt_4c_DtValidIs.Value  = {}
            loc_oPg.txt_4c_DtValidFs.Value  = {}
            loc_oPg.txt_4c_Comprador.Value  = ""
            loc_oPg.txt_4c_Aprovador.Value  = ""
            loc_oPg.txt_4c_CPros.Value      = ""
            loc_oPg.txt_4c_DPros.Value      = ""
            loc_oPg.txt_4c_IClis.Value      = ""
            loc_oPg.txt_4c_RClis.Value      = ""
            loc_oPg.opt_4c_Pedidos.Value    = 3
            loc_oPg.opt_4c_Aprovados.Value  = 3
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a p" + CHR(225) + "gina solicitada no PageFrame
    *   Este form tem apenas 1 p" + CHR(225) + "gina (Filtros). Reposiciona foco em DtInicial.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                loc_oPg.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *   Equivalente ao bloco .loObj.Xxx = campo do legado SIGRECTP.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial   = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal     = loc_oPg.txt_4c_DtFinal.Value
            .this_dDtValidIs   = loc_oPg.txt_4c_DtValidIs.Value
            .this_dDtValidFs   = loc_oPg.txt_4c_DtValidFs.Value
            .this_cComprador   = ALLTRIM(loc_oPg.txt_4c_Comprador.Value)
            .this_cAprovador   = ALLTRIM(loc_oPg.txt_4c_Aprovador.Value)
            .this_cCPros       = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
            .this_cDPros       = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
            .this_cIClis       = ALLTRIM(loc_oPg.txt_4c_IClis.Value)
            .this_cRClis       = ALLTRIM(loc_oPg.txt_4c_RClis.Value)
            .this_nPedidos     = loc_oPg.opt_4c_Pedidos.Value
            .this_nAprovados   = loc_oPg.opt_4c_Aprovados.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros obrigat" + CHR(243) + "rios antes de gerar relat" + CHR(243) + "rio
    *   Equivalente ao Do Case llRet = ... do btnReport.Click do legado.
    *   Retorna .T. se v" + CHR(225) + "lido, .F. se inv" + CHR(225) + "lido (j" + CHR(225) + " exibe mensagem e seta foco).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_cErro, loc_oPg
        THIS.FormParaRelatorio()
        loc_cErro = THIS.this_oRelatorio.ValidarFiltros()
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        DO CASE
            CASE loc_cErro = "DataInicial"
                MsgAviso("Data Inicial de Cota" + CHR(231) + CHR(227) + "o Inv" + ;
                    CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_DtInicial.SetFocus()
                RETURN .F.
            CASE loc_cErro = "DataFinal"
                MsgAviso("Data Final de Cota" + CHR(231) + CHR(227) + "o Inv" + ;
                    CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_DtInicial.SetFocus()
                RETURN .F.
            CASE loc_cErro = "Periodo"
                MsgAviso("Data Final de Cota" + CHR(231) + CHR(227) + "o Menor Que a Inicial!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_DtInicial.SetFocus()
                RETURN .F.
            CASE loc_cErro = "PeriodoV"
                MsgAviso("Data Final de Validade Menor Que a Inicial!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_DtValidIs.SetFocus()
                RETURN .F.
        ENDCASE
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relat" + CHR(243) + "rio em preview na tela
    *   Equivalente ao btnReport.Click com Value=1 (Visualiza) do legado.
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF


        *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        RETURN .T.
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFrxPath, loc_oErro
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
                RETURN
            ENDIF
            THIS.ExecutarReportForm("relsigrectp", "PREVIEW", THIS.this_oRelatorio.this_cCursorDados)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relat" + CHR(243) + "rio na impressora com di" + CHR(225) + "logo
    *   Equivalente ao btnReport.Click com Value=2 (Imprime) do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cFrxPath, loc_oErro
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
                RETURN
            ENDIF
            THIS.ExecutarReportForm("relsigrectp", "PRINTER_PROMPT", THIS.this_oRelatorio.this_cCursorDados)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do cursor para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_cCursor, loc_oErro
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
                RETURN
            ENDIF
            loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                RETURN
            ENDIF
            loc_cArquivo = PUTFILE("Salvar como...", "SigReCtp", "XLS")
            IF !EMPTY(loc_cArquivo)
                SELECT (loc_cCursor)
                COPY TO (loc_cArquivo) TYPE XLS
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
                    loc_cArquivo, "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formul" + CHR(225) + "rio
    *   Equivalente ao btnReport.Click com Value=3 (Sair) do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCamposDescricao - Simula eventos "When" do legado
    *   getDPros.When: Return Empty(getCPros.Value)
    *     -> txt_4c_DPros s" + CHR(243) + " edit" + CHR(225) + "vel quando CPros est" + CHR(225) + " vazio
    *   getRClis.When: Return Empty(getIClis.Value)
    *     -> txt_4c_RClis s" + CHR(243) + " edit" + CHR(225) + "vel quando IClis est" + CHR(225) + " vazio
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCamposDescricao()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DPros.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c_CPros.Value))
            loc_oPg.txt_4c_RClis.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c_IClis.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - BINDEVENT KeyPress
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg2, loc_dIni2, loc_dFim2
            loc_oPg2  = THIS.pgf_4c_Paginas.Page1
            loc_dIni2 = loc_oPg2.txt_4c_DtInicial.Value
            loc_dFim2 = loc_oPg2.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni2) AND !EMPTY(loc_dFim2) AND loc_dIni2 > loc_dFim2
                loc_oPg2.txt_4c_DtFinal.Value = loc_dIni2
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaDataValidIs(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg3, loc_dVi, loc_dVf
            loc_oPg3 = THIS.pgf_4c_Paginas.Page1
            loc_dVi  = loc_oPg3.txt_4c_DtValidIs.Value
            loc_dVf  = loc_oPg3.txt_4c_DtValidFs.Value
            IF !EMPTY(loc_dVi) AND !EMPTY(loc_dVf) AND loc_dVi > loc_dVf
                loc_oPg3.txt_4c_DtValidFs.Value = loc_dVi
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataValidFs(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaComprador(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaComprador()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarComprador()
        ENDIF
    ENDPROC

    PROCEDURE TeclaAprovador(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaAprovador()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarAprovador()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCPros(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCPros()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCPros()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDPros(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDPros()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDPros()
        ENDIF
    ENDPROC

    PROCEDURE TeclaIClis(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaIClis()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarIClis()
        ENDIF
    ENDPROC

    PROCEDURE TeclaRClis(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaRClis()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarRClis()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - COMPRADOR (sigcdusu, CAtivos='S')
    *==========================================================================

    PROCEDURE AbrirBuscaComprador()
        LOCAL loc_cValor, loc_oBusca, loc_oPg, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Comprador.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "sigcdusu", "cursor_4c_BuscaComprador", "Usuarios", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Comprador", ;
                .F., .T., ;
                "CAtivos = " + EscaparSQL("S"))
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPg.txt_4c_Comprador.Value = ALLTRIM(cursor_4c_BuscaComprador.Usuarios)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("NComps",   "", "Nome")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaComprador")
                            loc_oPg.txt_4c_Comprador.Value = ALLTRIM(cursor_4c_BuscaComprador.Usuarios)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaComprador")
                USE IN cursor_4c_BuscaComprador
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarComprador()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg, loc_oErro
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Comprador.Value)
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF
            loc_cSQL = "SELECT RTRIM(Usuarios) AS Usuarios FROM sigcdusu" + ;
                " WHERE CAtivos = " + EscaparSQL("S") + ;
                " AND RTRIM(Usuarios) = " + EscaparSQL(loc_cValor)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ComprVal")
            IF loc_nResult > 0
                SELECT cursor_4c_ComprVal
                IF EOF()
                    THIS.AbrirBuscaComprador()
                ENDIF
            ELSE
                THIS.AbrirBuscaComprador()
            ENDIF
            IF USED("cursor_4c_ComprVal")
                USE IN cursor_4c_ComprVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUP - APROVADOR (sigcdusu, CAtivos='S')
    *==========================================================================

    PROCEDURE AbrirBuscaAprovador()
        LOCAL loc_cValor, loc_oBusca, loc_oPg, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Aprovador.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "sigcdusu", "cursor_4c_BuscaAprovador", "Usuarios", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Aprovador", ;
                .F., .T., ;
                "CAtivos = " + EscaparSQL("S"))
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPg.txt_4c_Aprovador.Value = ALLTRIM(cursor_4c_BuscaAprovador.Usuarios)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("NComps",   "", "Nome")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAprovador")
                            loc_oPg.txt_4c_Aprovador.Value = ALLTRIM(cursor_4c_BuscaAprovador.Usuarios)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaAprovador")
                USE IN cursor_4c_BuscaAprovador
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarAprovador()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg, loc_oErro
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Aprovador.Value)
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF
            loc_cSQL = "SELECT RTRIM(Usuarios) AS Usuarios FROM sigcdusu" + ;
                " WHERE CAtivos = " + EscaparSQL("S") + ;
                " AND RTRIM(Usuarios) = " + EscaparSQL(loc_cValor)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AproVal")
            IF loc_nResult > 0
                SELECT cursor_4c_AproVal
                IF EOF()
                    THIS.AbrirBuscaAprovador()
                ENDIF
            ELSE
                THIS.AbrirBuscaAprovador()
            ENDIF
            IF USED("cursor_4c_AproVal")
                USE IN cursor_4c_AproVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUP - PRODUTO (SigCdPro: CPros=c" + CHR(243) + "digo, DPros=descri" + CHR(231) + CHR(227) + "o)
    *==========================================================================

    PROCEDURE AbrirBuscaCPros()
        LOCAL loc_cValor, loc_oBusca, loc_oPg, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaCPros", "CPros", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
                .F., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaCPros.CPros)
                    loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaCPros.DPros)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCPros")
                            loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaCPros.CPros)
                            loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaCPros.DPros)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaCPros")
                USE IN cursor_4c_BuscaCPros
            ENDIF
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaDPros()
        LOCAL loc_cValor, loc_oBusca, loc_oPg, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaDPros", "DPros", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
                .F., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaDPros.DPros)
                    loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaDPros.CPros)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDPros")
                            loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaDPros.DPros)
                            loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaDPros.CPros)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaDPros")
                USE IN cursor_4c_BuscaDPros
            ENDIF
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarCPros()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg, loc_oErro
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
            IF EMPTY(loc_cValor)
                loc_oPg.txt_4c_DPros.Value = ""
                THIS.AtualizarEstadoCamposDescricao()
                RETURN
            ENDIF
            loc_cSQL = "SELECT RTRIM(CPros) AS CPros, RTRIM(DPros) AS DPros" + ;
                " FROM SigCdPro WHERE RTRIM(CPros) = " + EscaparSQL(loc_cValor)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CProsVal")
            IF loc_nResult > 0
                SELECT cursor_4c_CProsVal
                IF !EOF()
                    loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_CProsVal.DPros)
                ELSE
                    loc_oPg.txt_4c_DPros.Value = ""
                    THIS.AbrirBuscaCPros()
                ENDIF
            ELSE
                loc_oPg.txt_4c_DPros.Value = ""
                THIS.AbrirBuscaCPros()
            ENDIF
            IF USED("cursor_4c_CProsVal")
                USE IN cursor_4c_CProsVal
            ENDIF
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarDPros()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg, loc_oErro
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
            IF EMPTY(loc_cValor)
                loc_oPg.txt_4c_CPros.Value = ""
                THIS.AtualizarEstadoCamposDescricao()
                RETURN
            ENDIF
            loc_cSQL = "SELECT RTRIM(CPros) AS CPros, RTRIM(DPros) AS DPros" + ;
                " FROM SigCdPro WHERE DPros LIKE " + EscaparSQL(loc_cValor + "%")
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DProsVal")
            IF loc_nResult > 0
                SELECT cursor_4c_DProsVal
                IF !EOF()
                    loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_DProsVal.CPros)
                    loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_DProsVal.DPros)
                ELSE
                    THIS.AbrirBuscaDPros()
                ENDIF
            ELSE
                THIS.AbrirBuscaDPros()
            ENDIF
            IF USED("cursor_4c_DProsVal")
                USE IN cursor_4c_DProsVal
            ENDIF
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUP - FORNECEDOR (SigCdCli: IClis=c" + CHR(243) + "digo, RClis=nome)
    *==========================================================================

    PROCEDURE AbrirBuscaIClis()
        LOCAL loc_cValor, loc_oBusca, loc_oPg, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_IClis.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaIClis", "IClis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", ;
                .F., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPg.txt_4c_IClis.Value = ALLTRIM(cursor_4c_BuscaIClis.IClis)
                    loc_oPg.txt_4c_RClis.Value = ALLTRIM(cursor_4c_BuscaIClis.RClis)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("RClis", "", "Nome")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIClis")
                            loc_oPg.txt_4c_IClis.Value = ALLTRIM(cursor_4c_BuscaIClis.IClis)
                            loc_oPg.txt_4c_RClis.Value = ALLTRIM(cursor_4c_BuscaIClis.RClis)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaIClis")
                USE IN cursor_4c_BuscaIClis
            ENDIF
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaRClis()
        LOCAL loc_cValor, loc_oBusca, loc_oPg, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_RClis.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaRClis", "RClis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", ;
                .F., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPg.txt_4c_RClis.Value = ALLTRIM(cursor_4c_BuscaRClis.RClis)
                    loc_oPg.txt_4c_IClis.Value = ALLTRIM(cursor_4c_BuscaRClis.IClis)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("RClis", "", "Nome")
                        loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRClis")
                            loc_oPg.txt_4c_RClis.Value = ALLTRIM(cursor_4c_BuscaRClis.RClis)
                            loc_oPg.txt_4c_IClis.Value = ALLTRIM(cursor_4c_BuscaRClis.IClis)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaRClis")
                USE IN cursor_4c_BuscaRClis
            ENDIF
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarIClis()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg, loc_oErro
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_IClis.Value)
            IF EMPTY(loc_cValor)
                loc_oPg.txt_4c_RClis.Value = ""
                THIS.AtualizarEstadoCamposDescricao()
                RETURN
            ENDIF
            loc_cSQL = "SELECT RTRIM(IClis) AS IClis, RTRIM(RClis) AS RClis" + ;
                " FROM SigCdCli WHERE RTRIM(IClis) = " + EscaparSQL(loc_cValor)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IClisVal")
            IF loc_nResult > 0
                SELECT cursor_4c_IClisVal
                IF !EOF()
                    loc_oPg.txt_4c_RClis.Value = ALLTRIM(cursor_4c_IClisVal.RClis)
                ELSE
                    loc_oPg.txt_4c_RClis.Value = ""
                    THIS.AbrirBuscaIClis()
                ENDIF
            ELSE
                loc_oPg.txt_4c_RClis.Value = ""
                THIS.AbrirBuscaIClis()
            ENDIF
            IF USED("cursor_4c_IClisVal")
                USE IN cursor_4c_IClisVal
            ENDIF
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarRClis()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg, loc_oErro
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_RClis.Value)
            IF EMPTY(loc_cValor)
                loc_oPg.txt_4c_IClis.Value = ""
                THIS.AtualizarEstadoCamposDescricao()
                RETURN
            ENDIF
            loc_cSQL = "SELECT RTRIM(IClis) AS IClis, RTRIM(RClis) AS RClis" + ;
                " FROM SigCdCli WHERE RClis LIKE " + EscaparSQL(loc_cValor + "%")
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RClisVal")
            IF loc_nResult > 0
                SELECT cursor_4c_RClisVal
                IF !EOF()
                    loc_oPg.txt_4c_IClis.Value = ALLTRIM(cursor_4c_RClisVal.IClis)
                    loc_oPg.txt_4c_RClis.Value = ALLTRIM(cursor_4c_RClisVal.RClis)
                ELSE
                    THIS.AbrirBuscaRClis()
                ENDIF
            ELSE
                THIS.AbrirBuscaRClis()
            ENDIF
            IF USED("cursor_4c_RClisVal")
                USE IN cursor_4c_RClisVal
            ENDIF
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE CRUD -> REPORT
    * M" + CHR(233) + "todos do pipeline CRUD que precisam de equivalente neste relat" + CHR(243) + "rio.
    *==========================================================================

    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                loc_oPg.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
                loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
                loc_oPg.txt_4c_DtValidIs.Value  = .this_dDtValidIs
                loc_oPg.txt_4c_DtValidFs.Value  = .this_dDtValidFs
                loc_oPg.txt_4c_Comprador.Value  = .this_cComprador
                loc_oPg.txt_4c_Aprovador.Value  = .this_cAprovador
                loc_oPg.txt_4c_CPros.Value      = .this_cCPros
                loc_oPg.txt_4c_DPros.Value      = .this_cDPros
                loc_oPg.txt_4c_IClis.Value      = .this_cIClis
                loc_oPg.txt_4c_RClis.Value      = .this_cRClis
                loc_oPg.opt_4c_Pedidos.Value    = .this_nPedidos
                loc_oPg.opt_4c_Aprovados.Value  = .this_nAprovados
            ENDWITH
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            IF PCOUNT() = 0
                loc_lHab = .T.
            ELSE
                loc_lHab = par_lHabilitar
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DtInicial.Enabled  = loc_lHab
            loc_oPg.txt_4c_DtFinal.Enabled    = loc_lHab
            loc_oPg.txt_4c_DtValidIs.Enabled  = loc_lHab
            loc_oPg.txt_4c_DtValidFs.Enabled  = loc_lHab
            loc_oPg.txt_4c_Comprador.Enabled  = loc_lHab
            loc_oPg.txt_4c_Aprovador.Enabled  = loc_lHab
            loc_oPg.txt_4c_CPros.Enabled      = loc_lHab
            loc_oPg.txt_4c_IClis.Enabled      = loc_lHab
            loc_oPg.opt_4c_Pedidos.Enabled    = loc_lHab
            loc_oPg.opt_4c_Aprovados.Enabled  = loc_lHab
            IF loc_lHab
                THIS.AtualizarEstadoCamposDescricao()
            ELSE
                loc_oPg.txt_4c_DPros.Enabled = .F.
                loc_oPg.txt_4c_RClis.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPg, loc_oErro
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                loc_oPg.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera refer" + CHR(234) + "ncia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
