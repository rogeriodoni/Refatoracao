*==============================================================================
* FORMSIGRECOR.PRG
* Relat" + CHR(243) + "rio: Comiss" + CHR(227) + "o por Vendedor (filtro PenPag)
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECOR.SCX (frmrelatorio)
*
* Filtros:
*   - Per" + CHR(237) + "odo (data inicial / data final)
*   - Grupo de estoque (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - fAcessoContab)
*   - Conta de estoque  (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - fAcessoContas)
*   - Moeda (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe, via fwBuscaExt)
*   - Op" + CHR(231) + CHR(227) + "o SNA (Sim / N" + CHR(227) + "o / Ambos)
*   - Tipo (Anal" + CHR(237) + "tico / Sint" + CHR(233) + "tico / Resumo)
*   - Quebra (Datas / Data+Movimenta" + CHR(231) + CHR(227) + "o / Cliente)
*   - PenPag: pagamento em aberto (CheckBox)
*
* FASE 3/8 - Estrutura base do form
*   * Propriedades visuais do form (Width=800, Height=300, TitleBar=0)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho() (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
*   * ConfigurarBotoes()    (Visualizar / Imprimir / Excel / Encerrar)
*   * ConfigurarPageFrame() (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
*==============================================================================

DEFINE CLASS Formsigrecor AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=300)
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
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigrecorBO
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Comiss" + CHR(227) + "o Pendente por Vendedor"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO do relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("sigrecorBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecorBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente ao cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()

                *-- Controles de filtro em Page1
                THIS.ConfigurarPaginaLista()

                *-- Vincula eventos (BINDEVENTs) dos botoes e campos (Fase 5)
                THIS.ConfigurarPaginaDados()

                *-- Inicializa filtros com valores padrao
                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

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
    *   Largura = Width do form (cobre toda a faixa superior).
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

            *-- Sombra (deslocada 2px para efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Comiss" + CHR(227) + "o Pendente por Vendedor"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Comiss" + CHR(227) + "o Pendente por Vendedor"
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
    * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
    *   Original: btnReport.Left=529, Top=0, ButtonCount=4
    *   Botoes: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 cada
    *   BINDEVENTs Click s" + CHR(227) + "o vinculados na Fase 7.
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

            *-- Visualizar (preview em tela)
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

            *-- Imprimir (impressora padr" + CHR(227) + "o)
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

            *-- Excel (exportar dados)
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

            *-- Encerrar (fechar form)
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
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina ("Filtros")
    *   O form legado SIGRECOR " + CHR(233) + " FLAT (controles direto no form), mas no novo
    *   padr" + CHR(227) + "o os campos s" + CHR(227) + "o agrupados em PageFrame de 1 p" + CHR(225) + "gina para
    *   consist" + CHR(234) + "ncia com o restante do sistema.
    *
    *   Posicionamento: abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form (300px).
    *   Os campos de filtro s" + CHR(227) + "o adicionados em ConfigurarPaginaLista() (Fase 4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
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
    * Destroy - Libera recursos do relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles de filtro em Page1 (Filtros)
    *   Form REPORT: Page1 contem campos de filtro (sem grid, sem CRUD).
    *   Replica layout flat do legado SIGRECOR dentro do PageFrame.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- --- Periodo ---
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Top       = 15
                .Left      = 191
                .Width     = 50
                .Height    = 15
                .Caption   = "Per" + CHR(237) + "odo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__dt_inicial", "TextBox")
            WITH loc_oPagina.txt_4c__dt_inicial
                .Top         = 11
                .Left        = 240
                .Width       = 80
                .Height      = 25
                .Value       = {}
                .Format      = "D"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPagina.lbl_4c_Label4
                .Top       = 16
                .Left      = 324
                .Width     = 20
                .Height    = 15
                .Caption   = "at" + CHR(233)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__dt_final", "TextBox")
            WITH loc_oPagina.txt_4c__dt_final
                .Top         = 11
                .Left        = 348
                .Width       = 80
                .Height      = 25
                .Value       = {}
                .Format      = "D"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            *-- --- Grupo de Estoque ---
            loc_oPagina.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPagina.lbl_4c_Label3
                .Top       = 40
                .Left      = 198
                .Width     = 38
                .Height    = 15
                .Caption   = "Grupo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
            WITH loc_oPagina.txt_4c__Cd_GrEstoque
                .Top         = 36
                .Left        = 240
                .Width       = 79
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
            WITH loc_oPagina.txt_4c__Ds_GrEstoque
                .Top         = 36
                .Left        = 321
                .Width       = 290
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            *-- --- Conta de Estoque ---
            loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_estoque
                .Top       = 67
                .Left      = 198
                .Width     = 38
                .Height    = 15
                .Caption   = "Conta :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__cd_estoque", "TextBox")
            WITH loc_oPagina.txt_4c__cd_estoque
                .Top         = 63
                .Left        = 240
                .Width       = 79
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__ds_estoque", "TextBox")
            WITH loc_oPagina.txt_4c__ds_estoque
                .Top         = 63
                .Left        = 321
                .Width       = 290
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            *-- --- Moeda ---
            loc_oPagina.AddObject("lbl_4c_Lbl_moeda", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_moeda
                .Top       = 94
                .Left      = 195
                .Width     = 42
                .Height    = 15
                .Caption   = "Moeda :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__cd_moeda", "TextBox")
            WITH loc_oPagina.txt_4c__cd_moeda
                .Top         = 90
                .Left        = 240
                .Width       = 31
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__ds_moeda", "TextBox")
            WITH loc_oPagina.txt_4c__ds_moeda
                .Top         = 90
                .Left        = 273
                .Width       = 115
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            *-- CheckBox PenPag (pagamento em aberto)
            loc_oPagina.AddObject("chk_4c_OptPenPag", "CheckBox")
            WITH loc_oPagina.chk_4c_OptPenPag
                .Top       = 94
                .Left      = 442
                .Width     = 136
                .Height    = 15
                .Caption   = "Pendente de Pagamento"
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .BackColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH

            *-- --- Opcao SNA (Sim / Nao / Ambos) ---
            loc_oPagina.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPagina.lbl_4c_Label6
                .Top       = 120
                .Left      = 196
                .Width     = 42
                .Height    = 15
                .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("obj_4c_OptSNA", "OptionGroup")
            WITH loc_oPagina.obj_4c_OptSNA
                .Top         = 116
                .Left        = 235
                .Width       = 220
                .Height      = 23
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top       = 0
                    .Left      = 0
                    .Width     = 73
                    .Height    = 23
                    .Caption   = "Sim"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 0
                    .Left      = 73
                    .Width     = 73
                    .Height    = 23
                    .Caption   = "N" + CHR(227) + "o"
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Top       = 0
                    .Left      = 146
                    .Width     = 74
                    .Height    = 23
                    .Caption   = "Ambos"
                    .WordWrap        = .T.
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- --- Tipo (Analitico / Sintetico / Resumo) ---
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Top       = 145
                .Left      = 207
                .Width     = 30
                .Height    = 15
                .Caption   = "Tipo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("obj_4c_OptTipo", "OptionGroup")
            WITH loc_oPagina.obj_4c_OptTipo
                .Top         = 141
                .Left        = 235
                .Width       = 220
                .Height      = 23
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 1
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top       = 0
                    .Left      = 0
                    .Width     = 73
                    .Height    = 23
                    .Caption   = "Anal" + CHR(237) + "tico"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 0
                    .Left      = 73
                    .Width     = 73
                    .Height    = 23
                    .Caption   = "Sint" + CHR(233) + "tico"
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Top       = 0
                    .Left      = 146
                    .Width     = 74
                    .Height    = 23
                    .Caption   = "Resumo"
                    .WordWrap        = .T.
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- --- Quebra (Datas / Data+Mov. / Cliente) ---
            loc_oPagina.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPagina.lbl_4c_Label5
                .Top       = 168
                .Left      = 191
                .Width     = 45
                .Height    = 15
                .Caption   = "Quebra :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("obj_4c_OptQuebras", "OptionGroup")
            WITH loc_oPagina.obj_4c_OptQuebras
                .Top         = 164
                .Left        = 235
                .Width       = 303
                .Height      = 25
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 1
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top       = 0
                    .Left      = 0
                    .Width     = 101
                    .Height    = 25
                    .Caption   = "Datas"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 0
                    .Left      = 101
                    .Width     = 101
                    .Height    = 25
                    .Caption   = "Data+Mov."
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Top       = 0
                    .Left      = 202
                    .Width     = 101
                    .Height    = 25
                    .Caption   = "Cliente"
                    .WordWrap        = .T.
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reinicia filtros com valores padrao
    *   Data inicial/final = DATE(); opcoes = defaults do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_oErro, loc_nResultMoe
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.txt_4c__dt_inicial.Value   = DATE()
            loc_oPagina.txt_4c__dt_final.Value     = DATE()
            loc_oPagina.txt_4c__Cd_GrEstoque.Value = ""
            loc_oPagina.txt_4c__Ds_GrEstoque.Value = ""
            loc_oPagina.txt_4c__cd_estoque.Value   = ""
            loc_oPagina.txt_4c__ds_estoque.Value   = ""
            *-- Moeda padrao: R$ (identico ao Init do legado que inicializava com 'R')
            loc_oPagina.txt_4c__cd_moeda.Value = "R"
            loc_nResultMoe = SQLEXEC(gnConnHandle, ;
                "SELECT cmoes, dmoes FROM SigCdMoe WHERE RTRIM(cmoes) = 'R'", ;
                "cursor_4c_MoeInit")
            IF loc_nResultMoe > 0
                SELECT cursor_4c_MoeInit
                GO TOP
                IF !EOF()
                    loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ELSE
                    loc_oPagina.txt_4c__ds_moeda.Value = ""
                ENDIF
                USE IN cursor_4c_MoeInit
            ELSE
                IF USED("cursor_4c_MoeInit")
                    USE IN cursor_4c_MoeInit
                ENDIF
                loc_oPagina.txt_4c__ds_moeda.Value = ""
            ENDIF
            loc_oPagina.obj_4c_OptSNA.Value        = 3
            loc_oPagina.obj_4c_OptTipo.Value       = 1
            loc_oPagina.obj_4c_OptQuebras.Value    = 1
            loc_oPagina.chk_4c_OptPenPag.Value     = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial   = loc_oPagina.txt_4c__dt_inicial.Value
            .this_dDtFinal     = loc_oPagina.txt_4c__dt_final.Value
            .this_cCdGrEstoque = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
            .this_cDsGrEstoque = ALLTRIM(loc_oPagina.txt_4c__Ds_GrEstoque.Value)
            .this_cCdEstoque   = ALLTRIM(loc_oPagina.txt_4c__cd_estoque.Value)
            .this_cDsEstoque   = ALLTRIM(loc_oPagina.txt_4c__ds_estoque.Value)
            .this_cCdMoeda     = ALLTRIM(loc_oPagina.txt_4c__cd_moeda.Value)
            .this_cDsMoeda     = ALLTRIM(loc_oPagina.txt_4c__ds_moeda.Value)
            .this_nOptSNA      = loc_oPagina.obj_4c_OptSNA.Value
            .this_nOptTipo     = loc_oPagina.obj_4c_OptTipo.Value
            .this_nOptQuebras  = loc_oPagina.obj_4c_OptQuebras.Value
            .this_nOptPenPag   = loc_oPagina.chk_4c_OptPenPag.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Vincula BINDEVENTs dos botoes e dos campos de
    * filtro (primeira metade: datas + grupo de estoque + conta de estoque).
    * O form REPORT nao tem Page2/Dados - todos os controles estao em Page1.
    * Fase 5/8: botoes do relatorio + campos data + grupo + conta de estoque.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

            *-- Campos de data (handler trivial - dados tipo D nao precisam de lookup)
            BINDEVENT(loc_oPagina.txt_4c__dt_inicial, "KeyPress", THIS, "TeclaDataInicial")
            BINDEVENT(loc_oPagina.txt_4c__dt_final,   "KeyPress", THIS, "TeclaDataFinal")

            *-- Grupo de Estoque: F4 abre busca; Enter/Tab valida codigo e preenche desc
            BINDEVENT(loc_oPagina.txt_4c__Cd_GrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
            BINDEVENT(loc_oPagina.txt_4c__Ds_GrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")

            *-- Conta de Estoque: F4 abre busca filtrada por grupo; Enter/Tab valida
            BINDEVENT(loc_oPagina.txt_4c__cd_estoque, "KeyPress", THIS, "TeclaCdEstoque")
            BINDEVENT(loc_oPagina.txt_4c__ds_estoque, "KeyPress", THIS, "TeclaDsEstoque")

            *-- Moeda: F4 abre busca; Enter/Tab valida codigo e preenche descricao
            BINDEVENT(loc_oPagina.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")
            BINDEVENT(loc_oPagina.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")

            *-- OptionGroups e CheckBox: Click handlers para controle mutuo (padrao legado)
            BINDEVENT(loc_oPagina.obj_4c_OptTipo,    "Click", THIS, "OptTipoClick")
            BINDEVENT(loc_oPagina.obj_4c_OptQuebras, "Click", THIS, "OptQuebrasClick")
            BINDEVENT(loc_oPagina.chk_4c_OptPenPag,  "Click", THIS, "OptPenPagClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArq, loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                IF USED("cursor_4c_Analitico")
                    loc_cArq = ADDBS(SYS(2023)) + "sigrecor_" + DTOS(DATE()) + ".xls"
                    SELECT cursor_4c_Analitico
                    SET SAFETY OFF
                    COPY TO (loc_cArq) TYPE XL5
                    SET SAFETY ON
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArq, "Excel")
                ELSE
                    MsgAviso("Nenhum dado para exportar.", "Excel")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Eventos CRUD nomeados (interface generica FormBase)
    *
    * Este form e um RELATORIO (frmrelatorio), nao um CRUD. As acoes nativas
    * sao: Visualizar (preview) / Imprimir / Excel / Encerrar.
    *
    * Os handlers CRUD abaixo existem para satisfazer a interface comum do
    * FormBase e quaisquer integradores externos (menu, atalhos de teclado).
    * Eles delegam para a acao de relatorio semanticamente mais proxima:
    *   - BtnIncluirClick  -> Visualizar (gerar nova previa do relatorio)
    *   - BtnAlterarClick  -> Visualizar (mesma previa, parametros editaveis)
    *   - BtnExcluirClick  -> Visualizar (sem operacao destrutiva em REPORT)
    *
    * Padrao identico aos demais forms REPORT do projeto (ver Formsigrecop.prg
    * linhas 1485-1495 - delegacao para BtnVisualizarClick).
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
    * TeclaDataInicial - Handler KeyPress do campo data inicial
    * Campos de data nao precisam de lookup; aceita qualquer tecla.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataFinal - Handler KeyPress do campo data final
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdGrEstoque - KeyPress do campo Codigo do Grupo de Estoque
    * F4(115): abre busca direta por codigo. Enter(13)/Tab(9): valida codigo.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdGrEstoque()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCdGrEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsGrEstoque - KeyPress do campo Descricao do Grupo de Estoque
    * F4(115): abre busca por descricao. Enter(13)/Tab(9): aciona lookup reverso.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsGrEstoque()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDsGrEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdEstoque - KeyPress do campo Codigo da Conta de Estoque
    * F4(115): abre busca filtrada pelo grupo selecionado.
    * Enter(13)/Tab(9): valida codigo e preenche descricao.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdEstoque()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsEstoque - KeyPress do campo Descricao da Conta de Estoque
    * F4(115): abre busca por descricao. Enter(13)/Tab(9): aciona lookup reverso.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsEstoque()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDsEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdGrEstoque - Valida codigo de grupo digitado; preenche descricao
    * Replica comportamento de get_Cd_GrEstoque.Valid (modo 'C') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_oPagina, loc_cCod, loc_cSQL, loc_nResult, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCod    = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        IF EMPTY(loc_cCod)
            loc_oPagina.txt_4c__Ds_GrEstoque.Value = ""
            loc_oPagina.txt_4c__cd_estoque.Value   = ""
            loc_oPagina.txt_4c__ds_estoque.Value   = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                       " WHERE codigos = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrVal")
            IF loc_nResult > 0
                SELECT cursor_4c_GrVal
                GO TOP
                IF !EOF()
                    loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                ELSE
                    loc_oPagina.txt_4c__Ds_GrEstoque.Value = ""
                    USE IN cursor_4c_GrVal
                    THIS.AbrirBuscaCdGrEstoque()
                    RETURN
                ENDIF
                USE IN cursor_4c_GrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdGrEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsGrEstoque - Valida descricao de grupo digitada; aciona lookup reverso
    * Replica comportamento de get_Ds_GrEstoque.Valid (modo 'D') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsGrEstoque()
        LOCAL loc_oPagina, loc_cDs
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cDs = ALLTRIM(loc_oPagina.txt_4c__Ds_GrEstoque.Value)
        IF EMPTY(loc_cDs)
            loc_oPagina.txt_4c__Cd_GrEstoque.Value = ""
            loc_oPagina.txt_4c__cd_estoque.Value   = ""
            loc_oPagina.txt_4c__ds_estoque.Value   = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsGrEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEstoque - Valida codigo de conta digitado; preenche descricao
    * Replica comportamento de get_cd_estoque.Valid (modo 'C') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEstoque()
        LOCAL loc_oPagina, loc_cCod, loc_cGrupo, loc_cSQL, loc_nResult, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCod   = ALLTRIM(loc_oPagina.txt_4c__cd_estoque.Value)
        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        IF EMPTY(loc_cCod)
            loc_oPagina.txt_4c__ds_estoque.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                       " WHERE codigos = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CntVal")
            IF loc_nResult > 0
                SELECT cursor_4c_CntVal
                GO TOP
                IF !EOF()
                    loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                ELSE
                    loc_oPagina.txt_4c__ds_estoque.Value = ""
                    USE IN cursor_4c_CntVal
                    THIS.AbrirBuscaCdEstoque()
                    RETURN
                ENDIF
                USE IN cursor_4c_CntVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsEstoque - Valida descricao de conta digitada; aciona lookup reverso
    * Replica comportamento de get_ds_estoque.Valid (modo 'D') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsEstoque()
        LOCAL loc_oPagina, loc_cDs
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cDs = ALLTRIM(loc_oPagina.txt_4c__ds_estoque.Value)
        IF EMPTY(loc_cDs)
            loc_oPagina.txt_4c__cd_estoque.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdGrEstoque - Abre FormBuscaAuxiliar para selecionar Grupo de
    * Estoque por codigo. Tabela: SigCdGcr (codigos / descrs).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdGrEstoque()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGr", "codigos", loc_cValor, ;
                "Grupos")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaGr
                    loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGr")
                        SELECT cursor_4c_BuscaGr
                        loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
                        loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaGr")
                USE IN cursor_4c_BuscaGr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCdGrEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsGrEstoque - Abre FormBuscaAuxiliar para selecionar Grupo de
    * Estoque por descricao (busca reversa). Tabela: SigCdGcr.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsGrEstoque()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Ds_GrEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGr", "descrs", loc_cValor, ;
                "Grupos")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaGr
                    loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGr")
                        SELECT cursor_4c_BuscaGr
                        loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
                        loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaGr")
                USE IN cursor_4c_BuscaGr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDsGrEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdEstoque - Abre FormBuscaAuxiliar para selecionar Conta de
    * Estoque por codigo, filtrada pelo grupo selecionado.
    * Tabela: SigCdGcr (codigos / descrs).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdEstoque()
        LOCAL loc_oPagina, loc_cValor, loc_cGrupo, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__cd_estoque.Value)
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaCnt", "codigos", loc_cValor, ;
                "Contas")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaCnt
                    loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnt")
                        SELECT cursor_4c_BuscaCnt
                        loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
                        loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaCnt")
                USE IN cursor_4c_BuscaCnt
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCdEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsEstoque - Abre FormBuscaAuxiliar para selecionar Conta de
    * Estoque por descricao (busca reversa), filtrada pelo grupo selecionado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsEstoque()
        LOCAL loc_oPagina, loc_cValor, loc_cGrupo, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__ds_estoque.Value)
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaCnt", "descrs", loc_cValor, ;
                "Contas")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaCnt
                    loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnt")
                        SELECT cursor_4c_BuscaCnt
                        loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
                        loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaCnt")
                USE IN cursor_4c_BuscaCnt
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDsEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para pagina (REPORT: apenas Page1 existe)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.Visible = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress do campo Codigo da Moeda
    * F4(115): abre busca direta por codigo. Enter(13)/Tab(9): valida codigo.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdMoeda()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress do campo Descricao da Moeda
    * F4(115): abre busca por descricao. Enter(13)/Tab(9): aciona lookup reverso.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsMoeda()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Valida codigo de moeda digitado; preenche descricao
    * Replica comportamento de get_cd_moeda.Valid do legado (via fwBuscaExt).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda()
        LOCAL loc_oPagina, loc_cCod, loc_cSQL, loc_nResult, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCod    = ALLTRIM(loc_oPagina.txt_4c__cd_moeda.Value)
        IF EMPTY(loc_cCod)
            loc_oPagina.txt_4c__ds_moeda.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL    = "SELECT cmoes, dmoes FROM SigCdMoe WHERE RTRIM(cmoes) = " + ;
                          EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
            IF loc_nResult > 0
                SELECT cursor_4c_MoeVal
                GO TOP
                IF !EOF()
                    loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                    loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ELSE
                    loc_oPagina.txt_4c__ds_moeda.Value = ""
                    USE IN cursor_4c_MoeVal
                    THIS.AbrirBuscaCdMoeda()
                    RETURN
                ENDIF
                USE IN cursor_4c_MoeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Valida descricao de moeda digitada; aciona lookup reverso
    * Replica comportamento de get_ds_moeda.Valid do legado (via fwBuscaExt).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda()
        LOCAL loc_oPagina, loc_cDs
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cDs = ALLTRIM(loc_oPagina.txt_4c__ds_moeda.Value)
        IF EMPTY(loc_cDs)
            loc_oPagina.txt_4c__cd_moeda.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdMoeda - Abre FormBuscaAuxiliar para selecionar Moeda por codigo
    * Tabela: SigCdMoe (cmoes / dmoes).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdMoeda()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__cd_moeda.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", loc_cValor, ;
                "Moedas")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaMoe
                    loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                    loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        SELECT cursor_4c_BuscaMoe
                        loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                        loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCdMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsMoeda - Abre FormBuscaAuxiliar para selecionar Moeda por
    * descricao (busca reversa). Tabela: SigCdMoe.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsMoeda()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__ds_moeda.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "dmoes", loc_cValor, ;
                "Moedas")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaMoe
                    loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                    loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        SELECT cursor_4c_BuscaMoe
                        loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                        loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDsMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTipoClick - Click no OptionGroup Tipo
    * Replica: se tipo != Analitico, desmarca optPenPag (nao faz sentido).
    *--------------------------------------------------------------------------
    PROCEDURE OptTipoClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF loc_oPagina.obj_4c_OptTipo.Value <> 1
            loc_oPagina.chk_4c_OptPenPag.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptQuebrasClick - Click no OptionGroup Quebras
    * Replica: se quebra != Datas, desmarca optPenPag.
    *--------------------------------------------------------------------------
    PROCEDURE OptQuebrasClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF loc_oPagina.obj_4c_OptQuebras.Value <> 1
            loc_oPagina.chk_4c_OptPenPag.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptPenPagClick - Click no CheckBox PenPag
    * Replica: ao marcar PenPag, forca tipo=Analitico e quebra=Datas.
    *--------------------------------------------------------------------------
    PROCEDURE OptPenPagClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF loc_oPagina.chk_4c_OptPenPag.Value = 1
            loc_oPagina.obj_4c_OptTipo.Value    = 1
            loc_oPagina.obj_4c_OptQuebras.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Gera preview do relatorio (interface generica FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Envia relatorio para impressora (interface generica FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa filtros e restaura valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Delega para FormParaRelatorio (padrao REPORT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Restaura filtros do BO para os controles do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                IF VARTYPE(.this_dDtInicial) = "D" AND !EMPTY(.this_dDtInicial)
                    loc_oPagina.txt_4c__dt_inicial.Value = .this_dDtInicial
                ENDIF
                IF VARTYPE(.this_dDtFinal) = "D" AND !EMPTY(.this_dDtFinal)
                    loc_oPagina.txt_4c__dt_final.Value = .this_dDtFinal
                ENDIF
                loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(.this_cCdGrEstoque)
                loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(.this_cDsGrEstoque)
                loc_oPagina.txt_4c__cd_estoque.Value   = ALLTRIM(.this_cCdEstoque)
                loc_oPagina.txt_4c__ds_estoque.Value   = ALLTRIM(.this_cDsEstoque)
                loc_oPagina.txt_4c__cd_moeda.Value     = ALLTRIM(.this_cCdMoeda)
                loc_oPagina.txt_4c__ds_moeda.Value     = ALLTRIM(.this_cDsMoeda)
                loc_oPagina.obj_4c_OptSNA.Value        = .this_nOptSNA
                loc_oPagina.obj_4c_OptTipo.Value       = .this_nOptTipo
                loc_oPagina.obj_4c_OptQuebras.Value    = .this_nOptQuebras
                loc_oPagina.chk_4c_OptPenPag.Value     = .this_nOptPenPag
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em forms REPORT todos os filtros ficam sempre habilitados
    * par_lHabilitar ignorado (sem modos INCLUIR/ALTERAR/VISUALIZAR)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oPagina.txt_4c__dt_inicial.Enabled   = .T.
        loc_oPagina.txt_4c__dt_final.Enabled     = .T.
        loc_oPagina.txt_4c__Cd_GrEstoque.Enabled = .T.
        loc_oPagina.txt_4c__Ds_GrEstoque.Enabled = .T.
        loc_oPagina.txt_4c__cd_estoque.Enabled   = .T.
        loc_oPagina.txt_4c__ds_estoque.Enabled   = .T.
        loc_oPagina.txt_4c__cd_moeda.Enabled     = .T.
        loc_oPagina.txt_4c__ds_moeda.Enabled     = .T.
        loc_oPagina.obj_4c_OptSNA.Enabled        = .T.
        loc_oPagina.obj_4c_OptTipo.Enabled       = .T.
        loc_oPagina.obj_4c_OptQuebras.Enabled    = .T.
        loc_oPagina.chk_4c_OptPenPag.Enabled     = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel em form REPORT (sem grid de lista)
    * Existe para compatibilidade com interface generica FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel em form REPORT (sem modos CRUD)
    * Existe para compatibilidade com interface generica FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

ENDDEFINE
