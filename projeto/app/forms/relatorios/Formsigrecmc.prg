*==============================================================================
* FORMSIGRECMC.PRG
* Relat" + CHR(243) + "rio de Clientes que Mais/Menos/N" + CHR(227) + "o
* Compram em Valores e Quantidades
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECMC.SCX (frmrelatorio)
*
* Layout FLAT: controles diretamente na Page1 do PageFrame
* Form: Width=800, Height=500
*==============================================================================

DEFINE CLASS Formsigrecmc AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SIGRECMC.SCX)
    Height      = 500
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

    *-- BO de relatorio
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Clientes que Mais/Menos/N" + ;
                CHR(227) + "o Compram em Valores e Quantidades"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigrecmcBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecmcBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.this_oRelatorio.CarregarDadosIniciais()
                        MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.this_oRelatorio.CarregarTiposOperacao()
                        MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarGrade()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarBINDEVENTs()
                THIS.AlternarPagina(1)

                *-- NAO sobrescrever os Captions encurtados definidos em ConfigurarCabecalho

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.LimparCampos()
                ENDIF

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Formsigrecmc:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Caption do header eh ENCURTADO para nao sobrepor Graficos+CommandGroup (Left=460)
        LOCAL loc_cTituloCurto
        loc_cTituloCurto = "Clientes Mais/Menos/N" + CHR(227) + "o Compram"

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .F.
            .Width     = 440
            .Height    = 30
            .Caption   = loc_cTituloCurto
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 20
            .Left      = 10
            .AutoSize  = .F.
            .Width     = 440
            .Height    = 30
            .Caption   = loc_cTituloCurto
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
    * Left=528 (equivalente ao btnReport.Left=525 do original)
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
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .Visible         = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Visible         = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Doc Excel"
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .Visible         = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- Botao Graficos a esquerda do Visualizar (mesmo padrao visual)
        *-- Themes=.T. + DisabledPicture garantem que o icone aparece mesmo desabilitado
        THIS.AddObject("cmd_4c_Graficos", "CommandButton")
        WITH THIS.cmd_4c_Graficos
            .Top              = 5
            .Left             = 460
            .Width            = 65
            .Height           = 70
            .Caption          = "Gr" + CHR(225) + "ficos"
            .FontName         = "Tahoma"
            .FontBold         = .T.
            .FontItalic       = .T.
            .FontSize         = 8
            .ForeColor        = RGB(90, 90, 90)
            .BackColor        = RGB(255, 255, 255)
            .PicturePosition  = 13
            .SpecialEffect    = 0
            .MousePointer     = 15
            .Themes           = .T.
            .ToolTipText      = "Gr" + CHR(225) + "ficos"
            .Picture          = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
            .DisabledPicture  = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
            .Enabled          = .T.
            .Visible          = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - 1 pagina, abaixo do cabecalho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
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

        loc_oPgf.Page2.Caption   = "Filtros"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria todos os controles de filtro na Page1
    * Coordenadas: original - 85 (Page1 comeca em Top=85 do form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Empresa (Say8: Left=41, Top=144->59; Get_Empresa: L=96, T=141->56, W=33, H=21)
        loc_oPg.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPg.lbl_4c_Empresa
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Left      = 41
            .Top       = 59
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPg.txt_4c_Empresa
            .Height        = 21
            .Left          = 96
            .Top           = 56
            .Width         = 33
            .MaxLength     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DEmpresa
            .Height        = 21
            .Left          = 131
            .Top           = 56
            .Width         = 365
            .MaxLength     = 40
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Movimentacao (lbl_dopes: L=13, T=169->84; get_nm_operacao: L=96, T=164->79)
        loc_oPg.AddObject("lbl_4c_DopEs", "Label")
        WITH loc_oPg.lbl_4c_DopEs
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Left      = 13
            .Top       = 84
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_NmOperacao", "TextBox")
        WITH loc_oPg.txt_4c_NmOperacao
            .Height        = 25
            .Left          = 96
            .Top           = 79
            .Width         = 156
            .MaxLength     = 20
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Periodo (lbl_periodo: L=46, T=196->111; get_dt_inicial: L=96, T=191->106)
        loc_oPg.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPg.lbl_4c_Periodo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 46
            .Top       = 111
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Height        = 25
            .Left          = 96
            .Top           = 106
            .Width         = 84
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPg.lbl_4c_PeriodoA
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = CHR(224)
            .Left      = 189
            .Top       = 110
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Height        = 25
            .Left          = 206
            .Top           = 106
            .Width         = 84
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- Moeda (lbl_moeda: L=50, T=222->137; get_moeda: L=96, T=218->133)
        loc_oPg.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPg.lbl_4c_Moeda
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Moeda :"
            .Left      = 50
            .Top       = 137
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg.txt_4c_Moeda
            .Height        = 25
            .Left          = 96
            .Top           = 133
            .Width         = 31
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_MoedaDesc", "TextBox")
        WITH loc_oPg.txt_4c_MoedaDesc
            .Height        = 25
            .Left          = 129
            .Top           = 133
            .Width         = 154
            .MaxLength     = 15
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Quantidade/Minimo (Say2: L=26, T=250->165; Get_Qtde: L=96, T=245->160)
        loc_oPg.AddObject("lbl_4c_Quantidade", "Label")
        WITH loc_oPg.lbl_4c_Quantidade
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Quantidade :"
            .Left      = 26
            .Top       = 165
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Qtde", "TextBox")
        WITH loc_oPg.txt_4c_Qtde
            .Height        = 25
            .Left          = 96
            .Top           = 160
            .Width         = 53
            .Format        = "K"
            .Alignment     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = 50
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Minimo", "Label")
        WITH loc_oPg.lbl_4c_Minimo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "M" + CHR(237) + "nimo :"
            .Left      = 162
            .Top       = 165
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_QtMin", "TextBox")
        WITH loc_oPg.txt_4c_QtMin
            .Height        = 25
            .Left          = 206
            .Top           = 160
            .Width         = 53
            .Format        = "K"
            .Alignment     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Conta (lbl_estoque: L=53, T=276->191; getCdEstoque: L=96, T=272->187)
        loc_oPg.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg.lbl_4c_Conta
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Conta :"
            .Left      = 53
            .Top       = 191
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdConta", "TextBox")
        WITH loc_oPg.txt_4c_CdConta
            .Height        = 25
            .Left          = 96
            .Top           = 187
            .Width         = 108
            .MaxLength     = 10
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsConta", "TextBox")
        WITH loc_oPg.txt_4c_DsConta
            .Height        = 25
            .Left          = 206
            .Top           = 187
            .Width         = 290
            .MaxLength     = 40
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Vendedor (Say4: L=36, T=303->218; getCdVendedor: L=96, T=299->214)
        loc_oPg.AddObject("lbl_4c_Vendedor1", "Label")
        WITH loc_oPg.lbl_4c_Vendedor1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Vendedor :"
            .Left      = 36
            .Top       = 218
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdVendedor", "TextBox")
        WITH loc_oPg.txt_4c_CdVendedor
            .Height        = 25
            .Left          = 96
            .Top           = 214
            .Width         = 108
            .MaxLength     = 10
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsVendedor", "TextBox")
        WITH loc_oPg.txt_4c_DsVendedor
            .Height        = 25
            .Left          = 206
            .Top           = 214
            .Width         = 290
            .MaxLength     = 40
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Produto (lbl_codigo: L=44, T=330->245; get_cd_codigo: L=96, T=326->241)
        loc_oPg.AddObject("lbl_4c_Produto", "Label")
        WITH loc_oPg.lbl_4c_Produto
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produto :"
            .Left      = 44
            .Top       = 245
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdProduto", "TextBox")
        WITH loc_oPg.txt_4c_CdProduto
            .Height        = 25
            .Left          = 96
            .Top           = 241
            .Width         = 108
            .MaxLength     = 14
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsProduto", "TextBox")
        WITH loc_oPg.txt_4c_DsProduto
            .Height        = 25
            .Left          = 206
            .Top           = 241
            .Width         = 290
            .MaxLength     = 40
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Ordem (Say1: L=50, T=363->278; opt_ordem: L=93, T=356->271)
        loc_oPg.AddObject("lbl_4c_Ordem", "Label")
        WITH loc_oPg.lbl_4c_Ordem
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Ordem :"
            .Left      = 50
            .Top       = 278
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("ogp_4c_Ordem", "OptionGroup")
        WITH loc_oPg.ogp_4c_Ordem
            .AutoSize      = .T.
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 62
            .Left          = 93
            .SpecialEffect = 0
            .Top           = 271
            .Width         = 107
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.ogp_4c_Ordem.Buttons(1)
            .Caption   = "Mais Compram"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_Ordem.Buttons(2)
            .Caption   = "Menos Compram"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 23
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_Ordem.Buttons(3)
            .Caption   = "N" + CHR(227) + "o Compram"
            .WordWrap        = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 42
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- chkCidade (L=227, T=362->277)
        loc_oPg.AddObject("chk_4c_Cidade", "CheckBox")
        WITH loc_oPg.chk_4c_Cidade
            .Left      = 227
            .Top       = 277
            .Height    = 15
            .Width     = 70
            .Caption   = "Cidades"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkComparativo (L=227, T=380->295) -- compensacao -85 (Page1 Top=85)
        loc_oPg.AddObject("chk_4c_Comparativo", "CheckBox")
        WITH loc_oPg.chk_4c_Comparativo
            .Left      = 227
            .Top       = 295
            .Height    = 15
            .Width     = 90
            .Caption   = "Comparativo"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container1 com ChkDadosCli e chkValor (L=224, T=396->311, W=313, H=20) -- compensacao -85
        loc_oPg.AddObject("cnt_4c_OpcoesDados", "Container")
        WITH loc_oPg.cnt_4c_OpcoesDados
            .Top         = 311
            .Left        = 224
            .Width       = 313
            .Height      = 20
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg.cnt_4c_OpcoesDados.AddObject("chk_4c_DadosCli", "CheckBox")
        WITH loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli
            .Top       = 2
            .Left      = 3
            .Height    = 15
            .Width     = 110
            .Caption   = "Dados do Cliente"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg.cnt_4c_OpcoesDados.AddObject("chk_4c_Valor", "CheckBox")
        WITH loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor
            .Top       = 2
            .Left      = 148
            .Height    = 15
            .Width     = 70
            .Caption   = "Com Valor"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Selecao (Say6: L=45, T=423->338)
        loc_oPg.AddObject("lbl_4c_Selecao", "Label")
        WITH loc_oPg.lbl_4c_Selecao
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Sele" + CHR(231) + CHR(227) + "o :"
            .Left      = 45
            .Top       = 338
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Opt_selrel (L=93, T=417->332, H=27, W=220, ButtonCount=2)
        loc_oPg.AddObject("ogp_4c_SelRel", "OptionGroup")
        WITH loc_oPg.ogp_4c_SelRel
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 27
            .Left          = 93
            .SpecialEffect = 0
            .Top           = 332
            .Width         = 225
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.ogp_4c_SelRel.Buttons(1)
            .Caption   = "Valor"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 6
            .Width     = 82
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_SelRel.Buttons(2)
            .Caption   = "Quantidade"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 133
            .Top       = 5
            .Width     = 82
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Comparativo label (Say5: L=21, T=447->362)
        loc_oPg.AddObject("lbl_4c_LblCompara", "Label")
        WITH loc_oPg.lbl_4c_LblCompara
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Comparativo :"
            .Left      = 21
            .Top       = 362
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Opt_Compara (L=93, T=441->356, H=26, W=217, ButtonCount=2)
        loc_oPg.AddObject("ogp_4c_Compara", "OptionGroup")
        WITH loc_oPg.ogp_4c_Compara
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 26
            .Left          = 93
            .SpecialEffect = 0
            .Top           = 356
            .Width         = 222
            .Value         = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.ogp_4c_Compara.Buttons(1)
            .Caption   = "Cliente"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 6
            .Width     = 51
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_Compara.Buttons(2)
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 133
            .Top       = 5
            .Width     = 79
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Vendedor label 2 (Say7: L=36, T=470->385)
        loc_oPg.AddObject("lbl_4c_Vendedor2", "Label")
        WITH loc_oPg.lbl_4c_Vendedor2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Vendedor :"
            .Left      = 36
            .Top       = 385
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Opt_MovCad (L=93, T=465->380, H=25, W=200, ButtonCount=2)
        loc_oPg.AddObject("ogp_4c_MovCad", "OptionGroup")
        WITH loc_oPg.ogp_4c_MovCad
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 25
            .Left          = 93
            .SpecialEffect = 0
            .Top           = 380
            .Width         = 200
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.ogp_4c_MovCad.Buttons(1)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .Value     = 1
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_MovCad.Buttons(2)
            .Caption   = "Cadastro"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 133
            .Top       = 5
            .AutoSize  = .T.
            .Value     = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Grid para tipos de operacao (GrdTipo original)
    * GrdTipo: Left=503, Top=141->56, W=228, H=218
    * cmd_4c_SelTudo: L=735, T=204; cmd_4c_Apaga: L=735, T=248
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oPg, loc_oGrd
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = loc_oPg.grd_4c_Dados
        WITH loc_oGrd
            .Top          = 56
            .Left         = 503
            .Width        = 228
            .Height       = 218
            .ColumnCount  = 2
            .AllowRowSizing = .F.
            .DeleteMark   = .F.
            .GridLines    = 3
            .HeaderHeight = 0
            .RowHeight    = 18
            .ScrollBars   = 2
            .RecordMark   = .F.
            .GridLineColor = RGB(255, 255, 255)
            .Themes       = .F.
            .Visible      = .T.
        ENDWITH

        *-- Column1: CheckBox para nMarca (Width=20, Sparse=.F.)
        WITH loc_oGrd.Column1
            .Width         = 20
            .Sparse        = .F.
            .Enabled       = .T.
        ENDWITH
        loc_oGrd.Column1.AddObject("chk_4c_Mark", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_Mark
            .Caption   = ""
            .Alignment = 2
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "chk_4c_Mark"

        *-- Column2: TextBox para Descri (Width=205, ReadOnly=.T.)
        WITH loc_oGrd.Column2
            .Width    = 205
            .ReadOnly = .T.
            .Enabled  = .T.
        ENDWITH
        WITH loc_oGrd.Column2.Text1
            .BorderStyle = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Vincular grid ao cursor CrSigCdTom
        IF USED("CrSigCdTom")
            loc_oGrd.RecordSource              = "CrSigCdTom"
            loc_oGrd.Column1.ControlSource     = "CrSigCdTom.nMarca"
            loc_oGrd.Column2.ControlSource     = "CrSigCdTom.Descri"
        ENDIF

        *-- Botao Selecionar todos (SelTudo: L=735, T=204, W=45, H=45)
        *-- Themes=.T. + DisabledPicture: icone renderiza estado disabled
        *-- (Themes=.F. tambem funciona quando enabled mas quebra quando disabled em runtime)
        loc_oPg.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oPg.cmd_4c_SelTudo
            .Top              = 204
            .Left             = 735
            .Width            = 45
            .Height           = 45
            .Caption          = ""
            .FontName         = "Verdana"
            .FontSize         = 8
            .Themes           = .T.
            .Enabled          = .T.
            .Picture          = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture  = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .PicturePosition  = 13
            .ForeColor        = RGB(36, 84, 155)
            .BackColor        = RGB(255, 255, 255)
            .SpecialEffect    = 0
            .TabStop          = .F.
            .ToolTipText      = "Selecionar"
            .Visible          = .T.
        ENDWITH

        *-- Botao Desmarcar (apaga: L=735, T=248, W=45, H=45)
        loc_oPg.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH loc_oPg.cmd_4c_Apaga
            .Top              = 248
            .Left             = 735
            .Width            = 45
            .Height           = 45
            .Caption          = ""
            .FontName         = "Verdana"
            .FontSize         = 8
            .Themes           = .T.
            .Enabled          = .T.
            .Picture          = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture  = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition  = 13
            .ForeColor        = RGB(36, 84, 155)
            .BackColor        = RGB(255, 255, 255)
            .SpecialEffect    = 0
            .TabStop          = .F.
            .ToolTipText      = "Desmarcar"
            .Visible          = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Container "Aguarde!!!" durante processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cnt_4c_Mensagem", "Container")
        WITH loc_oPg.cnt_4c_Mensagem
            .Top         = 150
            .Left        = 175
            .Width       = 473
            .Height      = 56
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH

        loc_oPg.cnt_4c_Mensagem.AddObject("lbl_4c_LblMensagem", "Label")
        WITH loc_oPg.cnt_4c_Mensagem.lbl_4c_LblMensagem
            .Top       = 18
            .Left      = 20
            .Width     = 445
            .Height    = 22
            .Caption   = "Aguarde!!!"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 2
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com valores padrao do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_oPg.txt_4c_Empresa.Value    = THIS.this_oRelatorio.this_cEmpresa
            loc_oPg.txt_4c_DEmpresa.Value   = THIS.this_oRelatorio.this_cDEmpresa
            loc_oPg.txt_4c_Moeda.Value      = THIS.this_oRelatorio.this_cMoedaPadrao
            loc_oPg.txt_4c_MoedaDesc.Value  = THIS.this_oRelatorio.this_cMoedaDesc
        ELSE
            loc_oPg.txt_4c_Empresa.Value    = ""
            loc_oPg.txt_4c_DEmpresa.Value   = ""
            loc_oPg.txt_4c_Moeda.Value      = ""
            loc_oPg.txt_4c_MoedaDesc.Value  = ""
        ENDIF

        loc_oPg.txt_4c_NmOperacao.Value             = ""
        loc_oPg.txt_4c_DtInicial.Value              = DATE()
        loc_oPg.txt_4c_DtFinal.Value                = DATE()
        loc_oPg.txt_4c_Qtde.Value                   = 50
        loc_oPg.txt_4c_QtMin.Value                  = 0
        loc_oPg.txt_4c_CdConta.Value                = ""
        loc_oPg.txt_4c_DsConta.Value                = ""
        loc_oPg.txt_4c_CdVendedor.Value             = ""
        loc_oPg.txt_4c_DsVendedor.Value             = ""
        loc_oPg.txt_4c_CdProduto.Value              = ""
        loc_oPg.txt_4c_DsProduto.Value              = ""
        loc_oPg.ogp_4c_Ordem.Value                  = 1
        loc_oPg.ogp_4c_SelRel.Value                 = 1
        loc_oPg.ogp_4c_Compara.Value                = 1
        loc_oPg.ogp_4c_MovCad.Value                 = 1
        loc_oPg.chk_4c_Cidade.Value                 = 0
        loc_oPg.chk_4c_Comparativo.Value            = 0
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 0
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = 0
        loc_oPg.ogp_4c_Compara.Enabled              = .F.
        THIS.cmd_4c_Graficos.Enabled             = .F.
        loc_oPg.grd_4c_Dados.Enabled                = .T.
        THIS.AjustarCamposMoeda()
        THIS.AjustarCamposProduto()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
           VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        BINDEVENT(THIS.cmg_4c_Botoes, "Click", THIS, "CmgBotoesClick")

        BINDEVENT(loc_oPg.txt_4c_Empresa,     "KeyPress", THIS, "TxtEmpresaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DEmpresa,    "KeyPress", THIS, "TxtDEmpresaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_NmOperacao,  "KeyPress", THIS, "TxtNmOperacaoKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DtInicial,   "KeyPress", THIS, "TxtDtInicialKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,     "KeyPress", THIS, "TxtDtFinalKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moeda,       "KeyPress", THIS, "TxtMoedaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_MoedaDesc,   "KeyPress", THIS, "TxtMoedaDescKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CdConta,     "KeyPress", THIS, "TxtCdContaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DsConta,     "KeyPress", THIS, "TxtDsContaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CdVendedor,  "KeyPress", THIS, "TxtCdVendedorKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DsVendedor,  "KeyPress", THIS, "TxtDsVendedorKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CdProduto,   "KeyPress", THIS, "TxtCdProdutoKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DsProduto,   "KeyPress", THIS, "TxtDsProdutoKeyPress")

        *-- DblClick para campos com lookup
        BINDEVENT(loc_oPg.txt_4c_Empresa,    "DblClick", THIS, "TxtEmpresaDblClick")
        BINDEVENT(loc_oPg.txt_4c_DEmpresa,   "DblClick", THIS, "TxtDEmpresaDblClick")
        BINDEVENT(loc_oPg.txt_4c_NmOperacao, "DblClick", THIS, "TxtNmOperacaoDblClick")
        BINDEVENT(loc_oPg.txt_4c_Moeda,      "DblClick", THIS, "TxtMoedaDblClick")
        BINDEVENT(loc_oPg.txt_4c_MoedaDesc,  "DblClick", THIS, "TxtMoedaDescDblClick")
        BINDEVENT(loc_oPg.txt_4c_CdConta,    "DblClick", THIS, "TxtCdContaDblClick")
        BINDEVENT(loc_oPg.txt_4c_DsConta,    "DblClick", THIS, "TxtDsContaDblClick")
        BINDEVENT(loc_oPg.txt_4c_CdVendedor, "DblClick", THIS, "TxtCdVendedorDblClick")
        BINDEVENT(loc_oPg.txt_4c_DsVendedor, "DblClick", THIS, "TxtDsVendedorDblClick")
        BINDEVENT(loc_oPg.txt_4c_CdProduto,  "DblClick", THIS, "TxtCdProdutoDblClick")
        BINDEVENT(loc_oPg.txt_4c_DsProduto,  "DblClick", THIS, "TxtDsProdutoDblClick")

        BINDEVENT(loc_oPg.ogp_4c_Ordem,  "InteractiveChange", THIS, "OgpOrdemInteractiveChange")
        BINDEVENT(loc_oPg.ogp_4c_SelRel, "Click",             THIS, "OgpSelRelClick")
        BINDEVENT(loc_oPg.ogp_4c_MovCad, "InteractiveChange", THIS, "OgpMovCadInteractiveChange")

        BINDEVENT(loc_oPg.chk_4c_Cidade,       "Click", THIS, "ChkCidadeClick")
        BINDEVENT(loc_oPg.chk_4c_Comparativo,  "Click", THIS, "ChkComparativoClick")
        BINDEVENT(loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli, "Click", THIS, "ChkDadosCliClick")
        BINDEVENT(loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor,    "Click", THIS, "ChkValorClick")

        BINDEVENT(loc_oPg.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
        BINDEVENT(loc_oPg.cmd_4c_Apaga,   "Click", THIS, "CmdApagaClick")
        BINDEVENT(THIS.cmd_4c_Graficos,"Click", THIS, "CmdGraficosClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposMoeda - Habilita/desabilita desc moeda conforme opt_selrel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarCamposMoeda()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg) = "O"
            LOCAL loc_lValor
            loc_lValor = (loc_oPg.ogp_4c_SelRel.Value = 1)
            loc_oPg.txt_4c_Moeda.Enabled     = loc_lValor
            loc_oPg.txt_4c_MoedaDesc.Enabled = loc_lValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposProduto - Quando produto preenchido, SelRel = Quantidade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarCamposProduto()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg) = "O"
            LOCAL loc_lTemProduto
            loc_lTemProduto = !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdProduto.Value))
            IF loc_lTemProduto
                loc_oPg.ogp_4c_SelRel.Value   = 2
                loc_oPg.ogp_4c_SelRel.Enabled = .F.
            ELSE
                loc_oPg.ogp_4c_SelRel.Enabled = .T.
            ENDIF
            THIS.AjustarCamposMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cEmpresa    = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            .this_cDEmpresa   = ALLTRIM(loc_oPg.txt_4c_DEmpresa.Value)
            .this_cNmOperacao = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)
            .this_dDtInicial  = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal    = loc_oPg.txt_4c_DtFinal.Value
            .this_cMoeda      = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
            .this_cMoedaDesc  = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
            .this_nQtde       = loc_oPg.txt_4c_Qtde.Value
            .this_nQtMin      = loc_oPg.txt_4c_QtMin.Value
            .this_cCdConta    = ALLTRIM(loc_oPg.txt_4c_CdConta.Value)
            .this_cDsConta    = ALLTRIM(loc_oPg.txt_4c_DsConta.Value)
            .this_cCdVendedor = ALLTRIM(loc_oPg.txt_4c_CdVendedor.Value)
            .this_cDsVendedor = ALLTRIM(loc_oPg.txt_4c_DsVendedor.Value)
            .this_cCdProduto  = ALLTRIM(loc_oPg.txt_4c_CdProduto.Value)
            .this_cDsProduto  = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
            .this_nOrdem      = loc_oPg.ogp_4c_Ordem.Value
            .this_nOptSelRel  = loc_oPg.ogp_4c_SelRel.Value
            .this_nOptCompara = loc_oPg.ogp_4c_Compara.Value
            .this_nOptMovCad  = loc_oPg.ogp_4c_MovCad.Value
            .this_nComparativo = loc_oPg.chk_4c_Comparativo.Value
            .this_nChkCidade  = loc_oPg.chk_4c_Cidade.Value
            .this_nChkDadosCli = loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value
            .this_nChkValor   = loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            loc_oPg.txt_4c_Empresa.Value    = NVL(.this_cEmpresa,    "")
            loc_oPg.txt_4c_DEmpresa.Value   = NVL(.this_cDEmpresa,   "")
            loc_oPg.txt_4c_NmOperacao.Value = NVL(.this_cNmOperacao, "")
            loc_oPg.txt_4c_DtInicial.Value  = IIF(EMPTY(.this_dDtInicial), DATE(), .this_dDtInicial)
            loc_oPg.txt_4c_DtFinal.Value    = IIF(EMPTY(.this_dDtFinal),   DATE(), .this_dDtFinal)
            loc_oPg.txt_4c_Moeda.Value      = NVL(.this_cMoeda,      "")
            loc_oPg.txt_4c_MoedaDesc.Value  = NVL(.this_cMoedaDesc,  "")
            loc_oPg.txt_4c_Qtde.Value       = NVL(.this_nQtde,  50)
            loc_oPg.txt_4c_QtMin.Value      = NVL(.this_nQtMin,  0)
            loc_oPg.txt_4c_CdConta.Value    = NVL(.this_cCdConta,    "")
            loc_oPg.txt_4c_DsConta.Value    = NVL(.this_cDsConta,    "")
            loc_oPg.txt_4c_CdVendedor.Value = NVL(.this_cCdVendedor, "")
            loc_oPg.txt_4c_DsVendedor.Value = NVL(.this_cDsVendedor, "")
            loc_oPg.txt_4c_CdProduto.Value  = NVL(.this_cCdProduto,  "")
            loc_oPg.txt_4c_DsProduto.Value  = NVL(.this_cDsProduto,  "")
            loc_oPg.ogp_4c_Ordem.Value      = IIF(.this_nOrdem >= 1 AND .this_nOrdem <= 3, .this_nOrdem, 1)
            loc_oPg.ogp_4c_SelRel.Value     = IIF(.this_nOptSelRel >= 1 AND .this_nOptSelRel <= 2, .this_nOptSelRel, 1)
            loc_oPg.ogp_4c_Compara.Value    = IIF(.this_nOptCompara >= 1 AND .this_nOptCompara <= 2, .this_nOptCompara, 1)
            loc_oPg.ogp_4c_MovCad.Value     = IIF(.this_nOptMovCad >= 1 AND .this_nOptMovCad <= 2, .this_nOptMovCad, 1)
            loc_oPg.chk_4c_Comparativo.Value = NVL(.this_nComparativo, 0)
            loc_oPg.chk_4c_Cidade.Value      = NVL(.this_nChkCidade,   0)
            loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = NVL(.this_nChkDadosCli, 0)
            loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = NVL(.this_nChkValor,    0)
        ENDWITH
        THIS.AjustarCamposMoeda()
        THIS.AjustarCamposProduto()
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES PRINCIPAIS
    *==========================================================================

    PROCEDURE CmgBotoesClick()
        LOCAL loc_nBotao
        loc_nBotao = THIS.cmg_4c_Botoes.Value
        DO CASE
        CASE loc_nBotao = 1
            THIS.BtnVisualizarClick()
        CASE loc_nBotao = 2
            THIS.BtnImprimirClick()
        CASE loc_nBotao = 3
            THIS.BtnExcelClick()
        CASE loc_nBotao = 4
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.ValidarFiltros()
            THIS.MostrarAguarde()
            THIS.this_oRelatorio.Visualizar()
            THIS.OcultarAguarde()
        ELSE
            MsgAviso(THIS.this_oRelatorio.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.ValidarFiltros()
            THIS.MostrarAguarde()
            THIS.this_oRelatorio.Imprimir()
            THIS.OcultarAguarde()
        ELSE
            MsgAviso(THIS.this_oRelatorio.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    PROCEDURE BtnExcelClick()
        MsgInfo("Fun" + CHR(231) + CHR(227) + "o Excel n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel neste relat" + CHR(243) + "rio.", "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
        THIS.AlternarPagina(2)
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg) = "O"
            loc_oPg.txt_4c_NmOperacao.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * HANDLERS DE AGUARDE
    *==========================================================================

    PROCEDURE MostrarAguarde()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg.cnt_4c_Mensagem) = "O"
            loc_oPg.cnt_4c_Mensagem.Visible = .T.
            loc_oPg.cnt_4c_Mensagem.Refresh()
            THIS.Refresh()
            DOEVENTS
        ENDIF
    ENDPROC

    PROCEDURE OcultarAguarde()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg.cnt_4c_Mensagem) = "O"
            loc_oPg.cnt_4c_Mensagem.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE OPTIONGROUPS E CHECKBOXES
    *==========================================================================

    *-- opt_ordem.InteractiveChange: Value=3 (Nao Compram) -> MovCad=2, Cidade=0
    PROCEDURE OgpOrdemInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.ogp_4c_Ordem.Value = 3
            loc_oPg.ogp_4c_MovCad.Value    = 2
            loc_oPg.chk_4c_Cidade.Value    = 0
        ENDIF
    ENDPROC

    *-- Opt_selrel.Click: Valor -> habilita moeda; Quantidade -> desabilita
    PROCEDURE OgpSelRelClick()
        THIS.AjustarCamposMoeda()
        THIS.Refresh()
    ENDPROC

    *-- Opt_MovCad.InteractiveChange: Value=1 (Movimentacao) -> Ordem=1
    PROCEDURE OgpMovCadInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.ogp_4c_MovCad.Value = 1
            loc_oPg.ogp_4c_Ordem.Value = 1
        ENDIF
    ENDPROC

    *-- Comparativo.Click
    PROCEDURE ChkComparativoClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        LOCAL loc_lComparativo
        loc_lComparativo = (loc_oPg.chk_4c_Comparativo.Value = 1)
        IF loc_lComparativo AND loc_oPg.ogp_4c_SelRel.Value = 1
            loc_oPg.ogp_4c_Compara.Enabled  = .T.
            THIS.cmd_4c_Graficos.Enabled = .T.
        ELSE
            loc_oPg.ogp_4c_Compara.Enabled  = .F.
            THIS.cmd_4c_Graficos.Enabled = .F.
        ENDIF
        IF loc_lComparativo
            loc_oPg.chk_4c_Cidade.Value = 0
        ENDIF
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 0
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = 0
    ENDPROC

    *-- chkCidade.Click
    PROCEDURE ChkCidadeClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.chk_4c_Cidade.Value = 1
            loc_oPg.chk_4c_Comparativo.Value = 0
            IF loc_oPg.ogp_4c_Ordem.Value = 3
                loc_oPg.ogp_4c_Ordem.Value = 1
            ENDIF
        ENDIF
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 0
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = 0
        loc_oPg.ogp_4c_Compara.Enabled  = .F.
        THIS.cmd_4c_Graficos.Enabled = .F.
    ENDPROC

    *-- ChkDadosCli.Click
    PROCEDURE ChkDadosCliClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 1
            THIS.cmd_4c_Graficos.Enabled  = .F.
            loc_oPg.chk_4c_Cidade.Value      = 0
            loc_oPg.chk_4c_Comparativo.Value = 0
            loc_oPg.ogp_4c_Compara.Enabled   = .F.
        ENDIF
    ENDPROC

    *-- ChkValor.Click
    PROCEDURE ChkValorClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value = 1
            THIS.cmd_4c_Graficos.Enabled             = .F.
            loc_oPg.chk_4c_Cidade.Value                 = 0
            loc_oPg.chk_4c_Comparativo.Value            = 0
            loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 1
            loc_oPg.ogp_4c_Compara.Enabled              = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES DA GRADE
    *==========================================================================

    PROCEDURE CmdSelTudoClick()
        IF USED("CrSigCdTom")
            SELECT CrSigCdTom
            REPLACE ALL CrSigCdTom.nMarca WITH 1
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE CmdApagaClick()
        IF USED("CrSigCdTom")
            SELECT CrSigCdTom
            REPLACE ALL CrSigCdTom.nMarca WITH 0
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE CmdGraficosClick()
        MsgInfo("Gr" + CHR(225) + "ficos n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel nesta vers" + CHR(227) + "o.", "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * KEYPRESS HANDLERS
    *==========================================================================

    PROCEDURE TxtEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DEmpresa.Value = ""
            ELSE
                THIS.AbrirBuscaEmpresa("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DEmpresa.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
            ELSE
                THIS.AbrirBuscaEmpresa("D")
            ENDIF
        ENDIF
    ENDPROC

    *-- NmOperacao: Valid logic - quando preenchido, desabilita grade
    *-- Botoes SelTudo/Apaga permanecem enabled (icone-only + Themes=.T. + Enabled=.F.
    *-- some no theme rendering); handlers alteram marcas do cursor mas relatorio
    *-- ignora quando Movimentacao esta preenchida (usa apenas o filtro selecionado)
    PROCEDURE TxtNmOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor, loc_oPg
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)
            IF !EMPTY(loc_cValor)
                THIS.AbrirBuscaOperacao()
                loc_oPg.grd_4c_Dados.Enabled   = .F.
            ELSE
                loc_oPg.grd_4c_Dados.Enabled   = .T.
            ENDIF
        ENDIF
    ENDPROC

    *-- DtInicial: valida intervalo maximo de 6 anos
    PROCEDURE TxtDtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dDti, loc_dDtf
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dDti = loc_oPg.txt_4c_DtInicial.Value
        loc_dDtf = loc_oPg.txt_4c_DtFinal.Value
        IF VARTYPE(loc_dDti) = "D" AND VARTYPE(loc_dDtf) = "D"
            IF (YEAR(loc_dDtf) - YEAR(loc_dDti)) >= 6
                MsgAviso("O per" + CHR(237) + "odo n" + CHR(227) + "o pode passar de 6 anos!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!")
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .F.
            ELSE
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dDti, loc_dDtf
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dDti = loc_oPg.txt_4c_DtInicial.Value
        loc_dDtf = loc_oPg.txt_4c_DtFinal.Value
        IF VARTYPE(loc_dDti) = "D" AND VARTYPE(loc_dDtf) = "D"
            IF (YEAR(loc_dDtf) - YEAR(loc_dDti)) >= 6
                MsgAviso("O per" + CHR(237) + "odo n" + CHR(227) + "o pode passar de 6 anos!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!")
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .F.
            ELSE
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value     = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_MoedaDesc.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtMoedaDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_MoedaDesc.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value     = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_MoedaDesc.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("D")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtCdContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdConta.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsConta.Value = ""
            ELSE
                THIS.AbrirBuscaConta("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDsContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsConta.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdConta.Value = ""
            ELSE
                THIS.AbrirBuscaConta("D")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtCdVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ""
            ELSE
                THIS.AbrirBuscaVendedor("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDsVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ""
            ELSE
                THIS.AbrirBuscaVendedor("D")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtCdProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdProduto.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsProduto.Value = ""
                THIS.AjustarCamposProduto()
            ELSE
                THIS.AbrirBuscaProduto("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDsProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsProduto.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdProduto.Value = ""
                THIS.AjustarCamposProduto()
            ELSE
                THIS.AbrirBuscaProduto("D")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * DBLCLICK HANDLERS
    *==========================================================================

    PROCEDURE TxtEmpresaDblClick()
        THIS.AbrirBuscaEmpresa("C")
    ENDPROC

    PROCEDURE TxtDEmpresaDblClick()
        THIS.AbrirBuscaEmpresa("D")
    ENDPROC

    PROCEDURE TxtNmOperacaoDblClick()
        THIS.AbrirBuscaOperacao()
    ENDPROC

    PROCEDURE TxtMoedaDblClick()
        THIS.AbrirBuscaMoeda("C")
    ENDPROC

    PROCEDURE TxtMoedaDescDblClick()
        THIS.AbrirBuscaMoeda("D")
    ENDPROC

    PROCEDURE TxtCdContaDblClick()
        THIS.AbrirBuscaConta("C")
    ENDPROC

    PROCEDURE TxtDsContaDblClick()
        THIS.AbrirBuscaConta("D")
    ENDPROC

    PROCEDURE TxtCdVendedorDblClick()
        THIS.AbrirBuscaVendedor("C")
    ENDPROC

    PROCEDURE TxtDsVendedorDblClick()
        THIS.AbrirBuscaVendedor("D")
    ENDPROC

    PROCEDURE TxtCdProdutoDblClick()
        THIS.AbrirBuscaProduto("C")
    ENDPROC

    PROCEDURE TxtDsProdutoDblClick()
        THIS.AbrirBuscaProduto("D")
    ENDPROC

    *==========================================================================
    * METODOS DE LOOKUP (FormBuscaAuxiliar)
    *==========================================================================

    PROTECTED PROCEDURE AbrirBuscaEmpresa(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            loc_cCampo = "cemps"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DEmpresa.Value)
            loc_cCampo = "razas"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpresa", loc_cCampo, ;
            loc_cValor, "Empresa")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
            SELECT cursor_4c_BuscaEmpresa
            IF !EOF()
                loc_oPg.txt_4c_Empresa.Value  = ALLTRIM(cemps)
                loc_oPg.txt_4c_DEmpresa.Value = ALLTRIM(razas)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_oBusca, loc_oPg, loc_cValor
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpe", "cursor_4c_BuscaOpe", "dopes", ;
            loc_cValor, "Opera" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
            SELECT cursor_4c_BuscaOpe
            IF !EOF()
                loc_oPg.txt_4c_NmOperacao.Value = ALLTRIM(dopes)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaMoeda(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
            loc_cCampo = "cmoes"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
            loc_cCampo = "dmoes"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", loc_cCampo, ;
            loc_cValor, "Moeda")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
            SELECT cursor_4c_BuscaMoeda
            IF !EOF()
                loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cmoes)
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(dmoes)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaConta(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdConta.Value)
            loc_cCampo = "iclis"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsConta.Value)
            loc_cCampo = "rclis"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaConta", loc_cCampo, ;
            loc_cValor, "Conta/Cliente")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("rclis", "", "Nome")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
            SELECT cursor_4c_BuscaConta
            IF !EOF()
                loc_oPg.txt_4c_CdConta.Value = ALLTRIM(iclis)
                loc_oPg.txt_4c_DsConta.Value = ALLTRIM(rclis)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaVendedor(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdVendedor.Value)
            loc_cCampo = "iclis"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsVendedor.Value)
            loc_cCampo = "rclis"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaVendedor", loc_cCampo, ;
            loc_cValor, "Vendedor")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("rclis", "", "Nome")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVendedor")
            SELECT cursor_4c_BuscaVendedor
            IF !EOF()
                loc_oPg.txt_4c_CdVendedor.Value = ALLTRIM(iclis)
                loc_oPg.txt_4c_DsVendedor.Value = ALLTRIM(rclis)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaVendedor")
            USE IN cursor_4c_BuscaVendedor
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaProduto(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdProduto.Value)
            loc_cCampo = "cpros"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
            loc_cCampo = "dpros"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaProduto", loc_cCampo, ;
            loc_cValor, "Produto")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
            SELECT cursor_4c_BuscaProduto
            IF !EOF()
                loc_oPg.txt_4c_CdProduto.Value = ALLTRIM(cpros)
                loc_oPg.txt_4c_DsProduto.Value = ALLTRIM(dpros)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposProduto()
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE API CRUD
    *==========================================================================

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROCEDURE CarregarLista()
        THIS.AlternarPagina(1)
        THIS.OcultarAguarde()
        THIS.AjustarCamposMoeda()
        THIS.AjustarCamposProduto()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Alias de BtnVisualizarClick (preview do relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de filtro
    * par_lHabilitar: .T. = habilita, .F. = desabilita
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg) != "O"
            RETURN
        ENDIF

        loc_oPg.txt_4c_Empresa.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_DEmpresa.Enabled   = par_lHabilitar
        loc_oPg.txt_4c_NmOperacao.Enabled = par_lHabilitar
        loc_oPg.txt_4c_DtInicial.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_DtFinal.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Qtde.Enabled       = par_lHabilitar
        loc_oPg.txt_4c_QtMin.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_CdConta.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_DsConta.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_CdVendedor.Enabled = par_lHabilitar
        loc_oPg.txt_4c_DsVendedor.Enabled = par_lHabilitar
        loc_oPg.txt_4c_CdProduto.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_DsProduto.Enabled  = par_lHabilitar
        loc_oPg.ogp_4c_Ordem.Enabled      = par_lHabilitar
        loc_oPg.ogp_4c_SelRel.Enabled     = par_lHabilitar
        loc_oPg.ogp_4c_MovCad.Enabled     = par_lHabilitar
        loc_oPg.chk_4c_Cidade.Enabled     = par_lHabilitar
        loc_oPg.chk_4c_Comparativo.Enabled = par_lHabilitar
        loc_oPg.grd_4c_Dados.Enabled      = par_lHabilitar

        IF par_lHabilitar
            THIS.AjustarCamposMoeda()
            THIS.AjustarCamposProduto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes do CommandGroup
    * Para form REPORT: botoes de imprimir/visualizar sempre habilitados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF
        *-- Botoes 1(Visualizar) 2(Imprimir) 3(Excel) 4(Encerrar) sempre ativos
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        IF USED("CrSigCdTom")
            USE IN CrSigCdTom
        ENDIF
        IF USED("CrSigCdPam")
            USE IN CrSigCdPam
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
