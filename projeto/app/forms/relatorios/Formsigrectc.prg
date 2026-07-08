*==============================================================================
* FORMSIGRECTC.PRG
* Relat" + CHR(243) + "rio Movimenta" + CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECTC.SCX (frmrelatorio)
*
* Filtros:
*   - Per" + CHR(237) + "odo   (data inicial / data final)
*   - Empresa (c" + CHR(243) + "digo + raz" + CHR(227) + "o social - SigCdEmp)
*   - Nome do Cart" + CHR(227) + "o (fpags - SigOpFp, cursor cursor_4c_Cartoes)
*   - Tipo de movimenta" + CHR(231) + CHR(227) + "o: Entradas / " + CHR(192) + " Receber / " + CHR(192) + " Depositar / Baixados
*   - Tipo de Dep" + CHR(243) + "sito (OptionGroup: Entrada / Vencimento)
*
* FASE 8/8 - Form - Eventos Auxiliares e Consolida" + CHR(231) + CHR(227) + "o Final (COMPLETO)
*   * BtnBuscarClick, BtnSalvarClick, BtnCancelarClick (mapeados para op. de REPORT)
*   * HabilitarCampos(), CarregarLista(), AjustarBotoesPorModo() (API gen" + CHR(233) + "rica)
*   * Integra" + CHR(231) + CHR(227) + "o no menu.prg (popRelatorios BAR 83)
*   * BINDEVENTs para F4/F5/ENTER/TAB em todos os campos de lookup
*   * Handlers dos checkboxes de tipo de movimenta" + CHR(231) + CHR(227) + "o (AjustarOptTpDep)
*   * FormParaRelatorio(), LimparCampos()
*   * Eventos principais: BtnVisualizarClick, BtnImprimirClick, BtnExcelClick, BtnEncerrarClick
*==============================================================================

DEFINE CLASS Formsigrectc AS FormBase

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
    *   2. Instancia sigrectcBO e carrega cursor de cart" + CHR(245) + "es (pula em modo UI)
    *   3. Monta cabecalho escuro + botoes do relat" + CHR(243) + "rio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio Movimenta" + CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("sigrectcBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrectcBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar cursor de cart" + CHR(245) + "es para lookup do campo get_fpags.
            *   SQL original: Select dcarts From SigOpFp where Infos='T' group by dcarts
            *   Pulado em modo de valida" + CHR(231) + CHR(227) + "o de UI (sem conex" + CHR(227) + "o SQL).
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarCartoes()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio: Visualizar / Imprimir / Excel / Encerrar
                THIS.ConfigurarBotoes()

                *-- PageFrame com p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()

                *-- Campos de filtro na Page1 (checkboxes, datas, empresa, cart" + CHR(227) + "o)
                THIS.ConfigurarPaginaLista()

                *-- InputMask, MaxLength, Format, TabIndex (UI fidelity - Fase 5)
                THIS.ConfigurarPaginaDados()

                *-- BINDEVENT para bot" + CHR(245) + "es da CommandGroup (Visualizar/Imprimir/Excel/Encerrar)
                THIS.VincularBotoes()

                *-- Valores iniciais dos filtros
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
                .Caption   = "Relat" + CHR(243) + "rio Movimenta" + CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es"
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
                .Caption   = "Relat" + CHR(243) + "rio Movimenta" + CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es"
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
    * ConfigurarBotoes - CommandGroup de a" + CHR(231) + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
    *   Original: btnReport.Top=0, Left=530, Width~270
    *   Bot" + CHR(245) + "es: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 cada
    *   Eventos Click vinculados nas Fases 7-8 (BINDEVENTs).
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

            *-- Bot" + CHR(227) + "o 1: Visualizar (preview em tela)
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

            *-- Bot" + CHR(227) + "o 2: Imprimir (impressora padr" + CHR(227) + "o)
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

            *-- Bot" + CHR(227) + "o 3: Excel (exportar dados)
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

            *-- Bot" + CHR(227) + "o 4: Encerrar (ESC fecha o form)
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
    *   Form REPORT: sem page de lista CRUD + sem page de dados CRUD.
    *   Page1 recebe os campos de filtro nas Fases 4-6 (ConfigurarPaginaLista).
    *   Top=85: logo abaixo do cabecalho (80px) + margem de 5px.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabecalho ate o fim do form
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
    * AlternarPagina - Ativa a p" + CHR(225) + "gina especificada do PageFrame de filtros
    *   par_nPagina: n" + CHR(250) + "mero da p" + CHR(225) + "gina a ativar (1 = Filtros - " + CHR(250) + "nica do form)
    *   Form REPORT possui apenas 1 p" + CHR(225) + "gina; m" + CHR(233) + "todo mant" + CHR(233) + "m API consistente
    *   com forms CRUD e permite refresh program" + CHR(225) + "tico do PageFrame.
    *   Faz Refresh ap" + CHR(243) + "s ativar para garantir que controles fiquem vis" + CHR(237) + "veis.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_nMaxPag
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_nMaxPag = THIS.pgf_4c_Paginas.PageCount
        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 ;
                AND par_nPagina <= loc_nMaxPag
            loc_nPagina = par_nPagina
        ELSE
            loc_nPagina = 1
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
        THIS.pgf_4c_Paginas.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relat" + CHR(243) + "rio e cursor de cart" + CHR(245) + "es
    *   IMPORTANTE: BO herda de Custom (RelatorioBase), NAO tem .Release().
    *   Atribuir .NULL. aciona o Destroy() do Custom automaticamente.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularBotoes - BINDEVENT nos 4 botoes da CommandGroup do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularBotoes()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona campos de filtro em Page1
    *   Form REPORT: Page1 cont" + CHR(233) + "m os FILTROS (n" + CHR(227) + "o h" + CHR(225) + " grid de lista CRUD).
    *   O nome "Lista" mant" + CHR(233) + "m compatibilidade com o padr" + CHR(227) + "o do framework
    *   (frmcadastro usa ConfigurarPaginaLista para Page1=grid; em frmrelatorio
    *   Page1=filtros, pois " + CHR(233) + " a "lista de par" + CHR(226) + "metros" do relat" + CHR(243) + "rio).
    *   Posi" + CHR(231) + CHR(245) + "es: Top_original - 85 (PageFrame come" + CHR(231) + "a em Top=85 no form de 300px)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- ROW 1 (Top=123): Checkboxes de tipo de movimenta" + CHR(231) + CHR(227) + "o
        loc_oPag.AddObject("chk_4c_Entrada", "CheckBox")
        WITH loc_oPag.chk_4c_Entrada
            .Top       = 123
            .Left      = 288
            .Width     = 61
            .Height    = 15
            .Caption   = "Entradas"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("chk_4c_Receber", "CheckBox")
        WITH loc_oPag.chk_4c_Receber
            .Top       = 123
            .Left      = 363
            .Width     = 68
            .Height    = 15
            .Caption   = CHR(192) + " Receber"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("chk_4c_Depositar", "CheckBox")
        WITH loc_oPag.chk_4c_Depositar
            .Top       = 123
            .Left      = 447
            .Width     = 74
            .Height    = 15
            .Caption   = CHR(192) + " Depositar"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("chk_4c_Baixa", "CheckBox")
        WITH loc_oPag.chk_4c_Baixa
            .Top       = 123
            .Left      = 540
            .Width     = 61
            .Height    = 15
            .Caption   = "Baixados"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- ROW 2 (Top=58-64): Per" + CHR(237) + "odo + OptionGroup tipo dep" + CHR(243) + "sito
        loc_oPag.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPag.lbl_4c_Periodo
            .Top       = 64
            .Left      = 240
            .Width     = 50
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPag.txt_4c_DtInicial
            .Top           = 59
            .Left          = 288
            .Width         = 80
            .Height        = 25
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_A", "Label")
        WITH loc_oPag.lbl_4c_A
            .Top       = 62
            .Left      = 373
            .Width     = 12
            .Height    = 18
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPag.txt_4c_DtFinal
            .Top           = 59
            .Left          = 386
            .Width         = 80
            .Height        = 25
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- OptionGroup: tipo dep" + CHR(243) + "sito (habilitado apenas quando s" + CHR(243) + " Depositar marcado)
        loc_oPag.AddObject("opt_4c_TpDep", "OptionGroup")
        WITH loc_oPag.opt_4c_TpDep
            .Top         = 58
            .Left        = 466
            .Width       = 152
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Entrada"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 5
                .Top       = 5
                .Width     = 56
                .Height    = 15
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Vencimento"
                .Left      = 74
                .Top       = 5
                .Height    = 15
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- ROW 3 (Top=86-91): Empresa
        loc_oPag.AddObject("lbl_4c_Emps", "Label")
        WITH loc_oPag.lbl_4c_Emps
            .Top       = 91
            .Left      = 235
            .Width     = 50
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Cemps", "TextBox")
        WITH loc_oPag.txt_4c_Cemps
            .Top           = 86
            .Left          = 288
            .Width         = 35
            .Height        = 25
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Razas", "TextBox")
        WITH loc_oPag.txt_4c_Razas
            .Top           = 86
            .Left          = 325
            .Width         = 301
            .Height        = 25
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- ROW 4 (Top=113-118): Cart" + CHR(227) + "o / forma de pagamento
        loc_oPag.AddObject("lbl_4c_Fpags", "Label")
        WITH loc_oPag.lbl_4c_Fpags
            .Top       = 118
            .Left      = 198
            .Width     = 88
            .Height    = 18
            .Caption   = "Nome do Cart" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Fpags", "TextBox")
        WITH loc_oPag.txt_4c_Fpags
            .Top           = 113
            .Left          = 288
            .Width         = 94
            .Height        = 25
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENT: checkboxes tipo movimenta" + CHR(231) + CHR(227) + "o
        BINDEVENT(loc_oPag.chk_4c_Entrada,   "Click", THIS, "ChkEntradaClick")
        BINDEVENT(loc_oPag.chk_4c_Receber,   "Click", THIS, "ChkReceberClick")
        BINDEVENT(loc_oPag.chk_4c_Depositar, "Click", THIS, "ChkDepositarClick")
        BINDEVENT(loc_oPag.chk_4c_Baixa,     "Click", THIS, "ChkBaixaClick")

        *-- BINDEVENT: campos de lookup (F4=115, F5=116, ENTER=13, TAB=9)
        BINDEVENT(loc_oPag.txt_4c_Cemps, "KeyPress", THIS, "TeclaCemps")
        BINDEVENT(loc_oPag.txt_4c_Razas, "KeyPress", THIS, "TeclaRazas")
        BINDEVENT(loc_oPag.txt_4c_Fpags, "KeyPress", THIS, "TeclaFpags")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Finaliza propriedades dos controles de filtro
    *   Para form REPORT flat, esta fase aplica as propriedades de UI fidelity
    *   que nao foram definidas em ConfigurarPaginaLista():
    *   - InputMask / MaxLength / Format dos TextBoxes (identicos ao original)
    *   - TabIndex (ordem de tabulacao) identica ao SIGRECTC.SCX original
    *
    *   Propriedades originais:
    *     get_fpags : InputMask="!!!!!!!!!!!!" MaxLength=12
    *     get_cemps : Format="!"  MaxLength=3
    *     get_razas : Format="!"  MaxLength=40
    *     TabIndex  : OptTpDep=1, checkboxes=2-5, datas=6-7, lbl_a=8
    *                 lbl_periodo=9, get_cemps=10, get_razas=11
    *                 lbl_emps=12, get_fpags=13, lbl_fpags=14
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- get_fpags: InputMask uppercase 12 caracteres + limite de tamanho
        WITH loc_oPag.txt_4c_Fpags
            .InputMask = "!!!!!!!!!!!!"
            .MaxLength = 12
        ENDWITH

        *-- get_cemps: formato uppercase + limite de 3 caracteres
        WITH loc_oPag.txt_4c_Cemps
            .Format    = "!"
            .MaxLength = 3
        ENDWITH

        *-- get_razas: formato uppercase + limite de 40 caracteres
        WITH loc_oPag.txt_4c_Razas
            .Format    = "!"
            .MaxLength = 40
        ENDWITH

        *-- TabIndex: ordem de tabulacao identica ao codigo fonte original
        loc_oPag.opt_4c_TpDep.TabIndex     = 1
        loc_oPag.chk_4c_Entrada.TabIndex   = 2
        loc_oPag.chk_4c_Receber.TabIndex   = 3
        loc_oPag.chk_4c_Depositar.TabIndex = 4
        loc_oPag.chk_4c_Baixa.TabIndex     = 5
        loc_oPag.txt_4c_DtInicial.TabIndex = 6
        loc_oPag.txt_4c_DtFinal.TabIndex   = 7
        loc_oPag.lbl_4c_A.TabIndex         = 8
        loc_oPag.lbl_4c_Periodo.TabIndex   = 9
        loc_oPag.txt_4c_Cemps.TabIndex     = 10
        loc_oPag.txt_4c_Razas.TabIndex     = 11
        loc_oPag.lbl_4c_Emps.TabIndex      = 12
        loc_oPag.txt_4c_Fpags.TabIndex     = 13
        loc_oPag.lbl_4c_Fpags.TabIndex     = 14
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa / reseta todos os campos de filtro
    *   Data inicial e final = hoje (identico ao Init original do SIGRECTC.SCX)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_DtInicial.Value = DATE()
        loc_oPag.txt_4c_DtFinal.Value   = DATE()
        loc_oPag.txt_4c_Cemps.Value     = ""
        loc_oPag.txt_4c_Razas.Value     = ""
        loc_oPag.txt_4c_Fpags.Value     = ""

        loc_oPag.chk_4c_Entrada.Value   = 0
        loc_oPag.chk_4c_Receber.Value   = 0
        loc_oPag.chk_4c_Depositar.Value = 0
        loc_oPag.chk_4c_Baixa.Value     = 0

        loc_oPag.opt_4c_TpDep.Value              = 1
        loc_oPag.opt_4c_TpDep.Buttons(1).Enabled = .F.
        loc_oPag.opt_4c_TpDep.Buttons(2).Enabled = .F.

        loc_oPag.txt_4c_Razas.ReadOnly = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial  = loc_oPag.txt_4c_DtInicial.Value
            .this_dDtFinal    = loc_oPag.txt_4c_DtFinal.Value
            .this_cEmps       = ALLTRIM(loc_oPag.txt_4c_Cemps.Value)
            .this_cRazas      = ALLTRIM(loc_oPag.txt_4c_Razas.Value)
            .this_cFpags      = ALLTRIM(loc_oPag.txt_4c_Fpags.Value)
            .this_lEntrada    = (loc_oPag.chk_4c_Entrada.Value   = 1)
            .this_lReceber    = (loc_oPag.chk_4c_Receber.Value   = 1)
            .this_lDepositar  = (loc_oPag.chk_4c_Depositar.Value = 1)
            .this_lBaixa      = (loc_oPag.chk_4c_Baixa.Value     = 1)
            .this_nOptTpDep   = loc_oPag.opt_4c_TpDep.Value
            .this_lDepPrev    = (loc_oPag.opt_4c_TpDep.Buttons(2).Enabled AND ;
                                 loc_oPag.opt_4c_TpDep.Value = 2)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarOptTpDep - Habilita/desabilita opt_4c_TpDep conforme checkboxes
    *   Habilitado APENAS quando Depositar marcado E nenhum outro checkbox ativo.
    *   Equivale " + CHR(224) + " l" + CHR(243) + "gica dos Click events de entrada/receber/depositar/baixa do original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarOptTpDep()
        LOCAL loc_oPag, loc_oOpt, loc_lOutroAtivo, loc_lDepositar
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oOpt = loc_oPag.opt_4c_TpDep

        loc_lOutroAtivo = (loc_oPag.chk_4c_Entrada.Value = 1) OR ;
                          (loc_oPag.chk_4c_Receber.Value = 1) OR ;
                          (loc_oPag.chk_4c_Baixa.Value   = 1)
        loc_lDepositar  = (loc_oPag.chk_4c_Depositar.Value = 1)

        IF loc_lDepositar AND !loc_lOutroAtivo
            loc_oOpt.Buttons(1).Enabled = .T.
            loc_oOpt.Buttons(2).Enabled = .T.
        ELSE
            loc_oOpt.Buttons(1).Enabled = .F.
            loc_oOpt.Buttons(2).Enabled = .F.
        ENDIF
    ENDPROC

    *-- Handlers dos checkboxes de tipo de movimenta" + CHR(231) + CHR(227) + "o (BINDEVENT Click)
    PROCEDURE ChkEntradaClick()
        THIS.AjustarOptTpDep()
    ENDPROC

    PROCEDURE ChkReceberClick()
        THIS.AjustarOptTpDep()
    ENDPROC

    PROCEDURE ChkDepositarClick()
        THIS.AjustarOptTpDep()
    ENDPROC

    PROCEDURE ChkBaixaClick()
        THIS.AjustarOptTpDep()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaFpags - KeyPress do campo de cart" + CHR(227) + "o/forma de pagamento
    *   F4/F5/ENTER/TAB abre busca no cursor cursor_4c_Cartoes (cursor local)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaFpags(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116 OR ;
           par_nKeyCode = 13  OR par_nKeyCode = 9
            THIS.AbrirBuscaFpags()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCemps - KeyPress do campo de c" + CHR(243) + "digo de empresa
    *   F4/F5/ENTER/TAB busca em SigCdEmp por c" + CHR(243) + "digo (cemps)
    *   Campo vazio + TAB/ENTER: limpa razas e reabilita edi" + CHR(231) + CHR(227) + "o do nome
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCemps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115 OR par_nKeyCode = 116 OR ;
           par_nKeyCode = 13  OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Cemps.Value))
                loc_oPag.txt_4c_Razas.Value    = ""
                loc_oPag.txt_4c_Razas.ReadOnly = .F.
            ELSE
                THIS.AbrirBuscaCemps()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaRazas - KeyPress do campo de raz" + CHR(227) + "o social da empresa
    *   Ativo apenas quando txt_4c_Cemps estiver vazio (equivale ao When original)
    *   F4/F5/ENTER/TAB busca em SigCdEmp por raz" + CHR(227) + "o social (razas)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaRazas(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF loc_oPag.txt_4c_Razas.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115 OR par_nKeyCode = 116 OR ;
           par_nKeyCode = 13  OR par_nKeyCode = 9
            IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_Razas.Value))
                THIS.AbrirBuscaRazas()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaFpags - Busca cart" + CHR(227) + "o em cursor_4c_Cartoes (cursor local)
    *   Equivalente ao fwBuscaInt original em 'crfpagam' (indexado por 'Cartao')
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaFpags()
        LOCAL loc_oPag, loc_cValor, loc_oBusca, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Fpags.Value)
        TRY
            IF !USED("cursor_4c_Cartoes") AND VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.CarregarCartoes()
            ENDIF

            IF USED("cursor_4c_Cartoes")
                IF !EMPTY(loc_cValor)
                    SELECT cursor_4c_Cartoes
                    GO TOP
                    LOCATE FOR UPPER(ALLTRIM(dcarts)) = UPPER(loc_cValor)
                    IF FOUND()
                        loc_oPag.txt_4c_Fpags.Value = ALLTRIM(dcarts)
                        RETURN
                    ENDIF
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_Cartoes"
                    loc_oBusca.this_cTitulo        = "Selecionar Cart" + CHR(227) + "o"
                    loc_oBusca.mAddColuna("dcarts", "", "Cart" + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Cartoes")
                        SELECT cursor_4c_Cartoes
                        loc_oPag.txt_4c_Fpags.Value = ALLTRIM(dcarts)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCemps - Busca empresa por c" + CHR(243) + "digo (cemps) em SigCdEmp
    *   Equivalente ao fwBuscaExt original com campo 'cemps'
    *   Ap" + CHR(243) + "s sele" + CHR(231) + CHR(227) + "o preenche txt_4c_Razas automaticamente
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCemps()
        LOCAL loc_oPag, loc_cValor, loc_oBusca, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Cemps.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "cemps", loc_cValor, ;
                "Busca de Empresa")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaEmp
                    loc_oPag.txt_4c_Cemps.Value    = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                    loc_oPag.txt_4c_Razas.Value    = ALLTRIM(cursor_4c_BuscaEmp.razas)
                    loc_oPag.txt_4c_Razas.ReadOnly = .T.
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("razas", "", "Empresa")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        loc_oPag.txt_4c_Cemps.Value    = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                        loc_oPag.txt_4c_Razas.Value    = ALLTRIM(cursor_4c_BuscaEmp.razas)
                        loc_oPag.txt_4c_Razas.ReadOnly = .T.
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaRazas - Busca empresa por nome/raz" + CHR(227) + "o social em SigCdEmp
    *   Equivalente ao fwBuscaExt original com campo 'razas'
    *   Ap" + CHR(243) + "s sele" + CHR(231) + CHR(227) + "o preenche txt_4c_Cemps automaticamente
    *   Acesso controlado: ativo apenas quando txt_4c_Cemps estiver vazio
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaRazas()
        LOCAL loc_oPag, loc_cValor, loc_oBusca, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Razas.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmpNom", "razas", loc_cValor, ;
                "Busca de Empresa por Nome")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaEmpNom
                    loc_oPag.txt_4c_Razas.Value    = ALLTRIM(cursor_4c_BuscaEmpNom.razas)
                    loc_oPag.txt_4c_Cemps.Value    = ALLTRIM(cursor_4c_BuscaEmpNom.cemps)
                    loc_oPag.txt_4c_Razas.ReadOnly = .T.
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("razas", "", "Empresa")
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpNom")
                        SELECT cursor_4c_BuscaEmpNom
                        loc_oPag.txt_4c_Razas.Value    = ALLTRIM(cursor_4c_BuscaEmpNom.razas)
                        loc_oPag.txt_4c_Cemps.Value    = ALLTRIM(cursor_4c_BuscaEmpNom.cemps)
                        loc_oPag.txt_4c_Razas.ReadOnly = .T.
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_BuscaEmpNom")
            USE IN cursor_4c_BuscaEmpNom
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relat" + CHR(243) + "rio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Erro ao Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relat" + CHR(243) + "rio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Erro ao Imprimir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relat" + CHR(243) + "rio para Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.GerarExcel()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Erro ao Gerar Excel")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * EVENTOS CRUD MAPEADOS PARA REPORT (Fase 7)
    *
    * Form REPORT (frmrelatorio) n" + CHR(227) + "o possui opera" + CHR(231) + CHR(245) + "es CRUD reais (Incluir/Alterar/
    * Excluir registros). Os m" + CHR(233) + "todos abaixo mapeiam a API CRUD padr" + CHR(227) + "o do framework
    * (esperada pelo pipeline de migra" + CHR(231) + CHR(227) + "o) para as opera" + CHR(231) + CHR(245) + "es equivalentes do REPORT,
    * preservando uniformidade de chamada para outros componentes que invoquem
    * estes nomes (menu, atalhos, automa" + CHR(231) + CHR(227) + "o).
    *
    * Mapeamento sem" + CHR(226) + "ntico:
    *   BtnIncluirClick  -> Visualizar (gerar/exibir o relat" + CHR(243) + "rio em tela)
    *   BtnAlterarClick  -> Limpar filtros (alterar par" + CHR(226) + "metros do relat" + CHR(243) + "rio)
    *   BtnExcluirClick  -> Encerrar (cancelar/fechar o form de filtros)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em form REPORT equivale a gerar/incluir o relat" + CHR(243) + "rio
    *   no v" + CHR(237) + "deo. Reaproveita BtnVisualizarClick() para preview na tela.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro ao Gerar Relat" + CHR(243) + "rio")
                ENDIF
            ELSE
                MsgErro("Objeto de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em form REPORT equivale a alterar par" + CHR(226) + "metros de filtro
    *   Reseta todos os filtros e devolve o foco para o usu" + CHR(225) + "rio reconfigurar
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPag, loc_oErro
        TRY
            THIS.LimparCampos()
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPag.txt_4c_DtInicial) = "O"
                loc_oPag.txt_4c_DtInicial.SetFocus()
            ENDIF
            THIS.pgf_4c_Paginas.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em form REPORT equivale a cancelar/excluir a execu" + CHR(231) + CHR(227) + "o
    *   Pede confirma" + CHR(231) + CHR(227) + "o ao usu" + CHR(225) + "rio (igual ao bot" + CHR(227) + "o Encerrar/ESC) e fecha o form
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Deseja cancelar a gera" + CHR(231) + CHR(227) + "o do relat" + CHR(243) + "rio?", ;
            "Cancelar Relat" + CHR(243) + "rio")
        IF loc_lConfirma
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * FASE 8/8 - M" + CHR(233) + "todos de consolida" + CHR(231) + CHR(227) + "o final
    * Mapeia a API CRUD gen" + CHR(233) + "rica do framework para opera" + CHR(231) + CHR(245) + "es de REPORT.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em form REPORT equivale a Visualizar (gerar preview)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em form REPORT equivale a Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em form REPORT equivale a Encerrar (fecha o form)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de filtro conforme modo
    *   Form REPORT n" + CHR(227) + "o tem modos CRUD; garante que cmg_4c_Botoes esteja
    *   habilitado quando o BO de relat" + CHR(243) + "rio estiver inicializado.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        IF VARTYPE(par_lHabilitar) = "L"
            loc_lHab = par_lHabilitar
        ELSE
            loc_lHab = (VARTYPE(THIS.this_oRelatorio) = "O")
        ENDIF
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em form REPORT force-refresh da p" + CHR(225) + "gina de filtros
    *   Chamado pelo framework ap" + CHR(243) + "s opera" + CHR(231) + CHR(245) + "es gen" + CHR(233) + "ricas; sem efeito real no
    *   REPORT (n" + CHR(227) + "o h" + CHR(225) + " grid de lista), mas deve existir para evitar "Property not found".
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lHabilitado
        loc_lHabilitado = (VARTYPE(THIS.this_oRelatorio) = "O")
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHabilitado
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lHabilitado
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lHabilitado
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * FORMPARABO / BOPARAFORM - Alias da API CRUD gen" + CHR(233) + "rica do framework
    *
    * Forms CRUD usam FormParaBO/BOParaForm para mover valores entre tela e
    * Business Object. Em form REPORT (frmrelatorio) n" + CHR(227) + "o existe registro
    * persistido nem opera" + CHR(231) + CHR(227) + "o Buscar; o equivalente sem" + CHR(226) + "ntico " + CHR(233) + " mover os
    * valores dos campos de filtro para o BO de relat" + CHR(243) + "rio (FormParaRelatorio)
    * e resetar a tela de filtros (LimparCampos).
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Em REPORT delega para FormParaRelatorio (filtros -> BO)
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Em REPORT restaura tela de filtros para o estado inicial
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

ENDDEFINE
