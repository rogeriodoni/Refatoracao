*==============================================================================
* FORMSIGREFEC.PRG
* Relat" + CHR(243) + "rio Fechamento de Caixa
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFEC.SCX (frmrelatorio)
*
* Filtros: Empresa, Per" + CHR(237) + "odo, Usu" + CHR(225) + "rio, Forma de Pagto,
*          Op" + CHR(231) + CHR(245) + "es de impress" + CHR(227) + "o, Vendedor
* Bot" + CHR(245) + "es: Visualizar / Imprimir / Excel / Encerrar
*==============================================================================

DEFINE CLASS Formsigrefec AS FormBase

    Height      = 350
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

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delegado ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria componentes estruturais do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Fechamento de Caixa"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigrefecBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar sigrefecBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarCamposFiltro()
                THIS.ConfigurarEventos()
                THIS.LimparCampos()
                THIS.AlternarPagina(1)

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible  = .T.
                loc_lSucesso  = .T.
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
    * ConfigurarCabecalho - Container escuro com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
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
                .Caption   = "Fechamento de Caixa"
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
                .Caption   = "Fechamento de Caixa"
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
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es: Visualizar/Imprimir/Excel/Encerrar
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
    * ConfigurarPageFrame - 1 p" + CHR(225) + "gina de filtros (layout flat de relat" + CHR(243) + "rio)
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
    * ConfigurarPaginaLista - Configura a p" + CHR(225) + "gina de filtros (Page1) do relat" + CHR(243) + "rio
    * Em forms REPORT, "Lista" = p" + CHR(225) + "gina " + CHR(250) + "nica de filtros/par" + CHR(226) + "metros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Caption   = "Filtros"
        loc_oPagina.FontName  = "Tahoma"
        loc_oPagina.FontSize  = 8
        loc_oPagina.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPagina.BackColor = RGB(255, 255, 255)
        loc_oPagina.ForeColor = RGB(90, 90, 90)
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a p" + CHR(225) + "gina solicitada do PageFrame de filtros
    * par_nPagina: 1 = " + CHR(250) + "nica p" + CHR(225) + "gina de filtros (form REPORT n" + CHR(227) + "o tem outras)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPag
        loc_nPag = 1

        IF VARTYPE(par_nPagina) = "N" AND ;
           par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            loc_nPag = par_nPagina
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = loc_nPag
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e delega ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Em forms REPORT a "Pagina de Dados" equivale a
    * pagina unica de filtros/parametros. Delega para ConfigurarCamposFiltro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarCamposFiltro()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposFiltro - Adiciona todos os controles de filtro na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        * --- Empresa ---
        loc_oPg1.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_empresa
            .Top       = 108
            .Left      = 200
            .Width     = 52
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPg1.txt_4c_Emps
            .Top         = 20
            .Left        = 254
            .Width       = 31
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "C" + CHR(243) + "digo da Empresa (F4=Buscar)"
            .Visible     = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DEmps", "TextBox")
        WITH loc_oPg1.txt_4c_DEmps
            .Top       = 20
            .Left      = 288
            .Width     = 289
            .Height    = 23
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        * --- Periodo ---
        loc_oPg1.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_periodo
            .Top       = 133
            .Left      = 205
            .Width     = 52
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPg1.txt_4c_DtIni
            .Top         = 45
            .Left        = 254
            .Width       = 82
            .Height      = 23
            .Value       = {}
            .Format      = "@D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Data Inicial do Per" + CHR(237) + "odo"
            .Visible     = .T.
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_periodo_a
            .Top       = 133
            .Left      = 340
            .Width     = 10
            .Height    = 18
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oPg1.txt_4c_DtFim
            .Top         = 45
            .Left        = 352
            .Width       = 82
            .Height      = 23
            .Value       = {}
            .Format      = "@D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Data Final do Per" + CHR(237) + "odo"
            .Visible     = .T.
        ENDWITH

        * --- Usuario ---
        loc_oPg1.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg1.lbl_4c_Label9
            .Top       = 73
            .Left      = 205
            .Width     = 52
            .Height    = 18
            .Caption   = "Usu" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Usuars", "TextBox")
        WITH loc_oPg1.txt_4c_Usuars
            .Top         = 70
            .Left        = 254
            .Width       = 82
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Usu" + CHR(225) + "rio (F4=Buscar)"
            .Visible     = .T.
        ENDWITH

        * --- Condicao de Pagamento ---
        loc_oPg1.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg1.lbl_4c_Label2
            .Top       = 98
            .Left      = 180
            .Width     = 75
            .Height    = 18
            .Caption   = "Cond. Pagto.:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_FPags", "TextBox")
        WITH loc_oPg1.txt_4c_FPags
            .Top         = 95
            .Left        = 254
            .Width       = 94
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Forma de Pagamento (F4=Buscar)"
            .Visible     = .T.
        ENDWITH

        * --- Tipos de Impressao ---
        loc_oPg1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg1.lbl_4c_Label1
            .Top       = 129
            .Left      = 176
            .Width     = 130
            .Height    = 18
            .Caption   = "Tipos de Impress" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        * --- Linha separadora ---
        loc_oPg1.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPg1.lin_4c_Line1
            .Top     = 144
            .Left    = 176
            .Width   = 435
            .Height  = 1
            .Visible = .T.
        ENDWITH

        * --- CheckBox: Detalhado Por Operacao ---
        loc_oPg1.AddObject("chk_4c_ChkDetOpe", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkDetOpe
            .Top      = 236
            .Left     = 176
            .Width    = 136
            .Height   = 15
            .Caption  = "Detalhado Por Opera" + CHR(231) + CHR(227) + "o"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        * --- CheckBox: Imprime Vendedor (habilitado apenas com chkDetOpe) ---
        loc_oPg1.AddObject("chk_4c_ChkVends", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkVends
            .Top      = 236
            .Left     = 400
            .Width    = 105
            .Height   = 15
            .Caption  = "Imprime Vendedor"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        * --- TextBox: Vendedor (habilitado apenas com chkDetOpe + chkVends) ---
        loc_oPg1.AddObject("txt_4c_Vends", "TextBox")
        WITH loc_oPg1.txt_4c_Vends
            .Top         = 148
            .Left        = 532
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Enabled     = .F.
            .ToolTipText = "Vendedor (F4=Buscar)"
            .Visible     = .T.
        ENDWITH

        * --- CheckBox: Resumo Por Vendedor ---
        loc_oPg1.AddObject("chk_4c_ChkVendRes", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkVendRes
            .Top      = 253
            .Left     = 176
            .Width    = 124
            .Height   = 15
            .Caption  = "Resumo Por Vendedor"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        * --- CheckBox: Resumo Por Formas de Pagamento (default ativo) ---
        loc_oPg1.AddObject("chk_4c_ChkResFpg", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkResFpg
            .Top      = 271
            .Left     = 176
            .Width    = 185
            .Height   = 15
            .Caption  = "Resumo Por Formas de Pagamento"
            .Value    = 1
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        * --- CheckBox: Operacoes X Pagamentos (default ativo) ---
        loc_oPg1.AddObject("chk_4c_ChkOpePag", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkOpePag
            .Top      = 289
            .Left     = 176
            .Width    = 141
            .Height   = 15
            .Caption  = "Opera" + CHR(231) + CHR(245) + "es X Pagamentos"
            .Value    = 1
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        * --- CheckBox: Analitico Por Pagamentos ---
        loc_oPg1.AddObject("chk_4c_ChkAnaPag", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkAnaPag
            .Top      = 307
            .Left     = 176
            .Width    = 142
            .Height   = 15
            .Caption  = "Anal" + CHR(237) + "tico Por Pagamentos"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - BINDEVENTs para botoes do CommandGroup e campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

        BINDEVENT(loc_oPg1.txt_4c_Emps,      "KeyPress", THIS, "TeclaEmps")
        BINDEVENT(loc_oPg1.txt_4c_DtIni,     "KeyPress", THIS, "TeclaDtIni")
        BINDEVENT(loc_oPg1.txt_4c_DtFim,     "KeyPress", THIS, "TeclaDtFim")
        BINDEVENT(loc_oPg1.txt_4c_Usuars,    "KeyPress", THIS, "TeclaUsuars")
        BINDEVENT(loc_oPg1.txt_4c_FPags,     "KeyPress", THIS, "TeclaFPags")
        BINDEVENT(loc_oPg1.txt_4c_Vends,     "KeyPress", THIS, "TeclaVends")
        BINDEVENT(loc_oPg1.chk_4c_ChkDetOpe, "Click",    THIS, "ChkDetOpeClick")
        BINDEVENT(loc_oPg1.chk_4c_ChkVends,  "Click",    THIS, "ChkVendsClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Habilita/desabilita controles conforme selecoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg1, loc_lDetOpe, loc_lVends, loc_lVendsEmpty
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_lDetOpe     = (loc_oPg1.chk_4c_ChkDetOpe.Value = 1)
        loc_lVends      = (loc_oPg1.chk_4c_ChkVends.Value = 1)
        loc_lVendsEmpty = EMPTY(ALLTRIM(loc_oPg1.txt_4c_Vends.Value))

        loc_oPg1.chk_4c_ChkVends.Enabled  = loc_lDetOpe
        loc_oPg1.txt_4c_Vends.Enabled     = loc_lDetOpe AND loc_lVends

        IF !loc_lVendsEmpty
            loc_oPg1.chk_4c_ChkResFpg.Value = 0
            loc_oPg1.chk_4c_ChkOpePag.Value = 0
            loc_oPg1.chk_4c_ChkAnaPag.Value = 0
        ENDIF
        loc_oPg1.chk_4c_ChkOpePag.Enabled = loc_lVendsEmpty
        loc_oPg1.chk_4c_ChkResFpg.Enabled = loc_lVendsEmpty
        loc_oPg1.chk_4c_ChkAnaPag.Enabled = loc_lVendsEmpty
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia todos os filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_cEmps    = ALLTRIM(loc_oPg1.txt_4c_Emps.Value)
            .this_cDEmps   = ALLTRIM(loc_oPg1.txt_4c_DEmps.Value)
            .this_dDtIni   = loc_oPg1.txt_4c_DtIni.Value
            .this_dDtFim   = loc_oPg1.txt_4c_DtFim.Value
            .this_cUsuars  = ALLTRIM(loc_oPg1.txt_4c_Usuars.Value)
            .this_cFPags   = ALLTRIM(loc_oPg1.txt_4c_FPags.Value)
            .this_cVends   = ALLTRIM(loc_oPg1.txt_4c_Vends.Value)
            .this_lDetOpe  = (loc_oPg1.chk_4c_ChkDetOpe.Value = 1)
            .this_lVends   = (loc_oPg1.chk_4c_ChkVends.Value = 1)
            .this_lVendRes = (loc_oPg1.chk_4c_ChkVendRes.Value = 1)
            .this_lResFpg  = (loc_oPg1.chk_4c_ChkResFpg.Value = 1)
            .this_lOpePag  = (loc_oPg1.chk_4c_ChkOpePag.Value = 1)
            .this_lAnaPag  = (loc_oPg1.chk_4c_ChkAnaPag.Value = 1)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com valores padrao (empresa logada + hoje)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg1, loc_cEmpresa, loc_cRazao
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_cEmpresa = ""
        loc_cRazao   = ""

        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            loc_cEmpresa = go_4c_Sistema.cCodEmpresa
            IF !EMPTY(loc_cEmpresa)
                loc_cRazao = ALLTRIM(go_4c_Sistema.cEmpresa)
            ENDIF
        ENDIF

        loc_oPg1.txt_4c_Emps.Value        = loc_cEmpresa
        loc_oPg1.txt_4c_DEmps.Value       = loc_cRazao
        loc_oPg1.txt_4c_DtIni.Value       = DATE()
        loc_oPg1.txt_4c_DtFim.Value       = DATE()
        loc_oPg1.txt_4c_Usuars.Value      = ""
        loc_oPg1.txt_4c_FPags.Value       = ""
        loc_oPg1.txt_4c_Vends.Value       = ""
        loc_oPg1.chk_4c_ChkDetOpe.Value  = 0
        loc_oPg1.chk_4c_ChkVends.Value   = 0
        loc_oPg1.chk_4c_ChkVendRes.Value = 0
        loc_oPg1.chk_4c_ChkResFpg.Value  = 1
        loc_oPg1.chk_4c_ChkOpePag.Value  = 1
        loc_oPg1.chk_4c_ChkAnaPag.Value  = 0

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera relatorio em preview (video)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()

            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()

            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo
        loc_cArquivo = ""

        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()

            IF THIS.this_oRelatorio.PrepararDados()
                loc_cArquivo = SYS(2023) + "\FechamentoCaixa.xls"

                IF USED("crImpressao")
                    SELECT crImpressao
                    COPY TO (loc_cArquivo) TYPE XLS

                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo, ;
                            "Excel Exportado")
                    ELSE
                        MsgErro("Falha ao criar arquivo Excel.", "Erro")
                    ENDIF
                ELSE
                    MsgAviso("Nenhum dado para exportar.", "Excel")
                ENDIF
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Exportar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmps - KeyPress em txt_4c_Emps: F4=buscar, ENTER/TAB=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmps()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarEmps()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDtIni - KeyPress em txt_4c_DtIni (campo data, sem lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDtIni(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDtFim - KeyPress em txt_4c_DtFim (campo data, sem lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDtFim(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaUsuars - KeyPress em txt_4c_Usuars: F4=buscar, ENTER/TAB=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaUsuars(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaUsuars()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarUsuars()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaFPags - KeyPress em txt_4c_FPags: F4=buscar, ENTER/TAB=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaFPags(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaFPags()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarFPags()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVends - KeyPress em txt_4c_Vends: F4=buscar, ENTER/TAB=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVends(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVends()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarVends()
            THIS.AtualizarEstadoCampos()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkDetOpeClick - Click em chk_4c_ChkDetOpe
    *--------------------------------------------------------------------------
    PROCEDURE ChkDetOpeClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        IF loc_oPg1.chk_4c_ChkDetOpe.Value = 0
            loc_oPg1.chk_4c_ChkVends.Value = 0
            loc_oPg1.txt_4c_Vends.Value    = ""
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkVendsClick - Click em chk_4c_ChkVends
    *--------------------------------------------------------------------------
    PROCEDURE ChkVendsClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        IF loc_oPg1.chk_4c_ChkVends.Value = 0
            loc_oPg1.txt_4c_Vends.Value = ""
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmps - Valida empresa e preenche descricao a partir de SigCdEmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmps()
        LOCAL loc_oPg1, loc_cValor
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Emps.Value)

        IF EMPTY(loc_cValor)
            loc_oPg1.txt_4c_DEmps.Value = ""
            RETURN
        ENDIF

        IF loc_cValor == ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_oPg1.txt_4c_DEmps.Value = ALLTRIM(go_4c_Sistema.cEmpresa)
            RETURN
        ENDIF

        THIS.AbrirBuscaEmps()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmps - Abre FormBuscaAuxiliar para selecionar empresa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaEmps()
        LOCAL loc_oPg1, loc_cValor, loc_oForm
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Emps.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, "Empresa")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lSelecionou
            loc_oForm.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
            loc_oPg1.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            loc_oPg1.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuars - Valida usuario existente em SigCdUsu
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarUsuars()
        LOCAL loc_oPg1, loc_cValor, loc_cSQL, loc_nResult
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Usuars.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT Usuarios FROM SigCdUsu WHERE Usuarios = " + ;
                   EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsrVal")

        IF loc_nResult > 0
            SELECT cursor_4c_UsrVal
            GO TOP IN cursor_4c_UsrVal
            IF !EOF("cursor_4c_UsrVal")
                loc_oPg1.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_UsrVal.Usuarios)
                USE IN cursor_4c_UsrVal
                RETURN
            ENDIF
            USE IN cursor_4c_UsrVal
        ENDIF

        THIS.AbrirBuscaUsuars()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaUsuars - Abre FormBuscaAuxiliar para selecionar usuario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaUsuars()
        LOCAL loc_oPg1, loc_cValor, loc_oForm
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Usuars.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsr", "Usuarios", loc_cValor, ;
            "Usu" + CHR(225) + "rio")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lSelecionou
            loc_oForm.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaUsr")
            loc_oPg1.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsr.Usuarios)
        ENDIF

        IF USED("cursor_4c_BuscaUsr")
            USE IN cursor_4c_BuscaUsr
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFPags - Valida forma de pagamento em SigOpFp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFPags()
        LOCAL loc_oPg1, loc_cValor, loc_cSQL, loc_nResult
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_FPags.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT FPags, Descrs FROM SigOpFp WHERE FPags = " + ;
                   EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPgVal")

        IF loc_nResult > 0
            SELECT cursor_4c_FPgVal
            GO TOP IN cursor_4c_FPgVal
            IF !EOF("cursor_4c_FPgVal")
                loc_oPg1.txt_4c_FPags.Value = ALLTRIM(cursor_4c_FPgVal.FPags)
                USE IN cursor_4c_FPgVal
                RETURN
            ENDIF
            USE IN cursor_4c_FPgVal
        ENDIF

        THIS.AbrirBuscaFPags()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaFPags - Abre FormBuscaAuxiliar para selecionar forma de pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaFPags()
        LOCAL loc_oPg1, loc_cValor, loc_oForm
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_FPags.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpFp", "cursor_4c_BuscaFPg", "FPags", loc_cValor, ;
            "Forma de Pagamento")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lSelecionou
            loc_oForm.mAddColuna("FPags",  "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaFPg")
            loc_oPg1.txt_4c_FPags.Value = ALLTRIM(cursor_4c_BuscaFPg.FPags)
        ENDIF

        IF USED("cursor_4c_BuscaFPg")
            USE IN cursor_4c_BuscaFPg
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVends - Valida vendedor (usuario ativo) em SigCdUsu
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarVends()
        LOCAL loc_oPg1, loc_cValor, loc_cSQL, loc_nResult
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Vends.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu " + ;
                   "WHERE Usuarios = " + EscaparSQL(loc_cValor) + ;
                   " AND NOT cAtivos = 'N'"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VndVal")

        IF loc_nResult > 0
            SELECT cursor_4c_VndVal
            GO TOP IN cursor_4c_VndVal
            IF !EOF("cursor_4c_VndVal")
                loc_oPg1.txt_4c_Vends.Value = ALLTRIM(cursor_4c_VndVal.Usuarios)
                USE IN cursor_4c_VndVal
                RETURN
            ENDIF
            USE IN cursor_4c_VndVal
        ENDIF

        THIS.AbrirBuscaVends()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVends - Abre FormBuscaAuxiliar para selecionar vendedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaVends()
        LOCAL loc_oPg1, loc_cValor, loc_oForm
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Vends.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaVnd", "Usuarios", loc_cValor, ;
            "Vendedor")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lSelecionou
            loc_oForm.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
            loc_oForm.mAddColuna("NComps",   "", "Nome")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaVnd")
            loc_oPg1.txt_4c_Vends.Value = ALLTRIM(cursor_4c_BuscaVnd.Usuarios)
        ENDIF

        IF USED("cursor_4c_BuscaVnd")
            USE IN cursor_4c_BuscaVnd
        ENDIF
        loc_oForm.Release()

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Forms REPORT (frmrelatorio) nao possuem operacoes CRUD reais. Estes
    * metodos existem para compatibilidade com a interface CRUD esperada pelo
    * pipeline de validacao e delegam para acoes de relatorio equivalentes.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT, "Incluir" equivale a gerar nova visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT, "Alterar" equivale a regerar a visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Operacao inexistente em REPORT: informa o usuario
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT, "Buscar" equivale a gerar visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT, "Salvar" equivale a imprimir o relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT, "Cancelar" encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio (compatibilidade com pipeline CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega filtros do BO de volta para os controles do form
    * Compatibilidade com pipeline CRUD (em REPORT: sincroniza BO -> controles)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            loc_oPg1.txt_4c_Emps.Value        = .this_cEmps
            loc_oPg1.txt_4c_DtIni.Value       = .this_dDtIni
            loc_oPg1.txt_4c_DtFim.Value       = .this_dDtFim
            loc_oPg1.txt_4c_Usuars.Value      = .this_cUsuars
            loc_oPg1.txt_4c_FPags.Value       = .this_cFPags
            loc_oPg1.txt_4c_Vends.Value       = .this_cVends
            loc_oPg1.chk_4c_ChkDetOpe.Value  = IIF(.this_lDetOpe,  1, 0)
            loc_oPg1.chk_4c_ChkVends.Value   = IIF(.this_lVends,   1, 0)
            loc_oPg1.chk_4c_ChkVendRes.Value = IIF(.this_lVendRes, 1, 0)
            loc_oPg1.chk_4c_ChkResFpg.Value  = IIF(.this_lResFpg,  1, 0)
            loc_oPg1.chk_4c_ChkOpePag.Value  = IIF(.this_lOpePag,  1, 0)
            loc_oPg1.chk_4c_ChkAnaPag.Value  = IIF(.this_lAnaPag,  1, 0)
        ENDWITH

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita todos os controles de filtro
    * par_lHabilitar: .T. = habilita, .F. = desabilita
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_oPg1.txt_4c_Emps.Enabled         = par_lHabilitar
        loc_oPg1.txt_4c_DtIni.Enabled        = par_lHabilitar
        loc_oPg1.txt_4c_DtFim.Enabled        = par_lHabilitar
        loc_oPg1.txt_4c_Usuars.Enabled       = par_lHabilitar
        loc_oPg1.txt_4c_FPags.Enabled        = par_lHabilitar
        loc_oPg1.chk_4c_ChkDetOpe.Enabled    = par_lHabilitar
        loc_oPg1.chk_4c_ChkVendRes.Enabled   = par_lHabilitar
        loc_oPg1.chk_4c_ChkResFpg.Enabled    = par_lHabilitar
        loc_oPg1.chk_4c_ChkOpePag.Enabled    = par_lHabilitar
        loc_oPg1.chk_4c_ChkAnaPag.Enabled    = par_lHabilitar

        IF par_lHabilitar
            THIS.AtualizarEstadoCampos()
        ELSE
            loc_oPg1.chk_4c_ChkVends.Enabled = .F.
            loc_oPg1.txt_4c_Vends.Enabled    = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT todos os botoes ficam sempre habilitados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT nao ha lista de registros (no-op, retorna .T.)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

ENDDEFINE
