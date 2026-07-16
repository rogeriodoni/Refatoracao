*==============================================================================
* FORMSIGREHCP.PRG
* Relatorio de Historico de Custo de Produtos
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREHCP.SCX (frmrelatorio)
*
* Filtros (Page1):
*   - Empresa  (txt_4c_CEmps/txt_4c_DEmps) - oculto quando CalcCustos=1
*   - Periodo  (txt_4c_DtInicial / txt_4c_DtFinal)
*   - Produto  (txt_4c_CPros/txt_4c_DPros) - lookup SigCdPro
*   - Tipo Impressao: opt_4c_OptTipImps (1=Relacao Padrao / 2=Modelo 3)
*
* Relatorios:
*   SigRehc1.frx -> Empresa+Produto (CalcCustos<>1, TipoImps=1)
*   SigRehc2.frx -> Produto apenas  (CalcCustos=1,  TipoImps=1)
*   SigRehc3.frx -> Modelo 3 Livro Fiscal (TipoImps=2)
*==============================================================================

DEFINE CLASS FormSIGREHCP AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
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

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura do formulario de relatorio
    *   1. Instancia SIGREHCPBO (le CalcCustos de SigCdPaC)
    *   2. Monta cabecalho escuro + botoes + PageFrame com filtros
    *   3. Oculta campos de empresa quando CalcCustos=1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
                "rico de Custo de Produtos"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio (lera CalcCustos em ObterParametros)
            THIS.this_oRelatorio = CREATEOBJECT("SIGREHCPBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREHCPBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Estrutura visual: cabecalho + botoes + pagframe com filtros
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()

                *-- Vincular botoes do CommandGroup
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Ocultar campos de empresa quando CalcCustos=1 (por produto apenas)
                *   Pulado em modo de validacao de UI (sem conexao SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF THIS.this_oRelatorio.this_nCalcCustos = 1
                        THIS.OcultarCamposEmpresa()
                    ENDIF
                ENDIF

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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
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
                .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
                             "rico de Custo de Produtos"
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
                .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
                             "rico de Custo de Produtos"
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
    * ConfigurarBotoes - CommandGroup de 4 botoes de relatorio
    *   Original: btnReport.Left=526, 4 botoes (Visualiza/Imprime/DocExcel/Sair)
    *   Geometria do framework frmrelatorio: Left=529, Width=273, Height=80
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

            *-- Imprimir (impressora)
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

            *-- Encerrar (fechar form - ESC)
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
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   O form legado SIGREHCP e FLAT (sem PageFrame), mas no novo padrao
    *   os filtros sao agrupados em um PageFrame de 1 pagina para consistencia.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Abaixo do cabecalho (80px) ate o fundo do form
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
    *   Posicoes: top_original_form - 85 (offset do PageFrame).
    *   Empresa: top=35 | Periodo: top=61 | Produto: top=87 | TipImps: top=111
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- EMPRESA (original: lblEmpresa.Top=123; getCEmps.Top=120 -> 35)
        loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg.lbl_4c_LblEmpresa
            .Top       = 123
            .Left      = 199
            .Width     = 50
            .Height    = 15
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo da empresa (3 chars, InputMask XXX)
        loc_oPg.AddObject("txt_4c_CEmps", "TextBox")
        WITH loc_oPg.txt_4c_CEmps
            .Top           = 35
            .Left          = 254
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .InputMask     = "XXX"
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao da empresa (preenchida pelo lookup ou digitacao)
        loc_oPg.AddObject("txt_4c_DEmps", "TextBox")
        WITH loc_oPg.txt_4c_DEmps
            .Top           = 35
            .Left          = 288
            .Width         = 303
            .Height        = 23
            .Value         = ""
            .MaxLength     = 40
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- PERIODO (original: Say1.Top=149 -> 64; getDtInicial.Top=146 -> 61)
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Top       = 64
            .Left      = 204
            .Width     = 45
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data inicial (original: getDtInicial.Left=254)
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top           = 61
            .Left          = 254
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "ate" (original: Say4.Top=149 -> 64; Left=339)
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Top       = 64
            .Left      = 339
            .Width     = 20
            .Height    = 15
            .Caption   = "at" + CHR(233)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data final (original: getDtFinal.Left=364)
        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top           = 61
            .Left          = 364
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- PRODUTO (original: Say3.Top=175 -> 90; getCPros.Top=172 -> 87)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Top       = 90
            .Left      = 202
            .Width     = 47
            .Height    = 15
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo do produto (14 chars, F4 abre lookup SigCdPro)
        loc_oPg.AddObject("txt_4c_CPros", "TextBox")
        WITH loc_oPg.txt_4c_CPros
            .Top           = 87
            .Left          = 254
            .Width         = 108
            .Height        = 23
            .Value         = ""
            .MaxLength     = 14
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao do produto (preenchida pelo lookup)
        loc_oPg.AddObject("txt_4c_DPros", "TextBox")
        WITH loc_oPg.txt_4c_DPros
            .Top           = 87
            .Left          = 365
            .Width         = 290
            .Height        = 23
            .Value         = ""
            .MaxLength     = 40
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- OptionGroup TipoImps e BINDEVENTs configurados em ConfigurarPaginaDados
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona OptionGroup TipoImps e vincula eventos
    *   Mantido separado para seguir padrao do pipeline (lista/dados).
    *   Todos os BINDEVENTs de teclado e DblClick sao vinculados aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- TIPO DE IMPRESSAO (original: Say11.Top=201 -> 116; opt.Top=196)
        loc_oPg.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPg.lbl_4c_Label11
            .Top       = 116
            .Left      = 152
            .Width     = 97
            .Height    = 15
            .Caption   = "Tipo de Impress" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: Relacao Padrao / Modelo 3
        *   ButtonCount ANTES de acessar Buttons(N)
        loc_oPg.AddObject("opt_4c_OptTipImps", "OptionGroup")
        loc_oPg.opt_4c_OptTipImps.ButtonCount = 2
        WITH loc_oPg.opt_4c_OptTipImps
            .Top         = 196
            .Left        = 248
            .Width       = 222
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OptTipImps.Buttons(1)
            .Caption     = "Rela" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o"
            .Left        = 5
            .Top         = 6
            .Width       = 108
            .Height      = 15
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .BackStyle   = 0
            .AutoSize    = .F.
            .ForeColor   = RGB(90, 90, 90)
            .ToolTipText = "Impress" + CHR(227) + "o de Relat" + CHR(243) + "rio Padr" + CHR(227) + "o"
        ENDWITH
        WITH loc_oPg.opt_4c_OptTipImps.Buttons(2)
            .Caption     = "Modelo 3"
            .Left        = 129
            .Top         = 6
            .Width       = 83
            .Height      = 17
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .BackStyle   = 0
            .AutoSize    = .F.
            .ForeColor   = RGB(90, 90, 90)
            .ToolTipText = "Imprimir o Modelo 3 Para Livro Fiscal"
        ENDWITH

        *-- Empresa: KeyPress e DblClick
        BINDEVENT(loc_oPg.txt_4c_CEmps, "KeyPress", THIS, "TeclaCEmps")
        BINDEVENT(loc_oPg.txt_4c_DEmps, "KeyPress", THIS, "TeclaDEmps")
        BINDEVENT(loc_oPg.txt_4c_CEmps, "DblClick", THIS, "AbrirBuscaCEmps")
        BINDEVENT(loc_oPg.txt_4c_DEmps, "DblClick", THIS, "AbrirBuscaDEmps")

        *-- Produto: KeyPress e DblClick
        BINDEVENT(loc_oPg.txt_4c_CPros, "KeyPress", THIS, "TeclaCPros")
        BINDEVENT(loc_oPg.txt_4c_DPros, "KeyPress", THIS, "TeclaDPros")
        BINDEVENT(loc_oPg.txt_4c_CPros, "DblClick", THIS, "AbrirBuscaCPros")
        BINDEVENT(loc_oPg.txt_4c_DPros, "DblClick", THIS, "AbrirBuscaDPros")

        *-- Data inicial: ao sair (ENTER/TAB) ajusta data final se anterior
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")

        *-- Estado inicial: getDEmps/getDPros so editaveis se codigo vazio (When)
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao
    *   Equivalente ao estado inicial definido em SIGREHCP.Init
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_CEmps.Value       = ""
            loc_oPg.txt_4c_DEmps.Value       = ""
            loc_oPg.txt_4c_DtInicial.Value   = DATE()
            loc_oPg.txt_4c_DtFinal.Value     = DATE()
            loc_oPg.txt_4c_CPros.Value       = ""
            loc_oPg.txt_4c_DPros.Value       = ""
            loc_oPg.opt_4c_OptTipImps.Value  = 1
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OcultarCamposEmpresa - Oculta e desabilita campos de empresa
    *   Chamado quando CalcCustos=1: custo calculado por produto apenas,
    *   sem necessidade de filtrar por empresa.
    *   Equivalente ao bloco do Init original que oculta getCEmps/getDEmps/lblEmpresa.
    *--------------------------------------------------------------------------
    PROCEDURE OcultarCamposEmpresa()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.lbl_4c_LblEmpresa.Visible = .F.
            loc_oPg.txt_4c_CEmps.Visible      = .F.
            loc_oPg.txt_4c_DEmps.Visible      = .F.
            loc_oPg.txt_4c_CEmps.Enabled      = .F.
            loc_oPg.txt_4c_DEmps.Enabled      = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCamposDescricao - Simula evento "When" do legado
    *   getDEmps.When: Return Empty(getCEmps.Value)
    *   getDPros.When: Return Empty(getCPros.Value)
    *   Campo de descricao editavel somente quando codigo esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCamposDescricao()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DEmps.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c_CEmps.Value))
            loc_oPg.txt_4c_DPros.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c_CPros.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia filtros do form para o BO
    *   Equivalente ao metodo "processamento" do form legado SIGREHCP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal   = loc_oPg.txt_4c_DtFinal.Value
            .this_cCPros     = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
            .this_cDPros     = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
            .this_cCEmps     = ALLTRIM(loc_oPg.txt_4c_CEmps.Value)
            .this_cDEmps     = ALLTRIM(loc_oPg.txt_4c_DEmps.Value)
            .this_nTipoImps  = loc_oPg.opt_4c_OptTipImps.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida datas antes de imprimir/visualizar
    *   Equivalente a validacao no btnReport.Click do form legado SIGREHCP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c_DtInicial.Value
        loc_dFim = loc_oPg.txt_4c_DtFinal.Value

        IF EMPTY(loc_dIni)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtInicial.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(loc_dFim)
            MsgAviso("Data Final Inv" + CHR(225) + "lida!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF

        IF loc_dFim < loc_dIni
            MsgAviso("Data Final Menor Que a Inicial!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtInicial.SetFocus()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *   Equivalente ao procedure "visualizacao" do form legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio na impressora com dialogo de selecao
    *   Equivalente ao procedure "impressao" do form legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados para arquivo XLS
    *   Equivalente ao btnReport.DocExcel do framework legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_cCursor
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cCursor = "cursor_4c_Rehcp"
            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                RETURN
            ENDIF
            loc_cArquivo = PUTFILE("Salvar como...", "SigRehcp", "XLS")
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
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - BINDEVENT KeyPress
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaCEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCEmps()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCEmps()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDEmps()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDEmps()
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

    *--------------------------------------------------------------------------
    * TeclaDataInicial - Equivalente ao getDatai.Valid do legado:
    *   ao sair do campo (ENTER/TAB), ajusta data final se menor que inicial
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg, loc_dIni, loc_dFim
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
                loc_oPg.txt_4c_DtFinal.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - PRODUTO (SigCdPro: cpros/dpros)
    *   Equivalente ao fwBuscaExt de getCPros.Valid e getDPros.Valid do legado
    *==========================================================================

    PROCEDURE AbrirBuscaCPros()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaCPros", "cpros", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaCPros.cpros)
                loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaCPros.dpros)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCPros")
                        loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaCPros.cpros)
                        loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaCPros.dpros)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCPros")
            USE IN cursor_4c_BuscaCPros
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    PROCEDURE AbrirBuscaDPros()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaDPros", "dpros", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaDPros.dpros)
                loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaDPros.cpros)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDPros")
                        loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaDPros.dpros)
                        loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaDPros.cpros)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaDPros")
            USE IN cursor_4c_BuscaDPros
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    PROTECTED PROCEDURE ValidarCPros()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DPros.Value = ""
            THIS.AtualizarEstadoCamposDescricao()
            RETURN
        ENDIF
        loc_cSQL = "SELECT cpros, dpros FROM SigCdPro" + ;
            " WHERE cpros = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProsVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ProsVal
            IF !EOF()
                loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_ProsVal.dpros)
            ELSE
                loc_oPg.txt_4c_DPros.Value = ""
                THIS.AbrirBuscaCPros()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DPros.Value = ""
            THIS.AbrirBuscaCPros()
        ENDIF
        IF USED("cursor_4c_ProsVal")
            USE IN cursor_4c_ProsVal
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    PROTECTED PROCEDURE ValidarDPros()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CPros.Value = ""
            THIS.AtualizarEstadoCamposDescricao()
            RETURN
        ENDIF
        loc_cSQL = "SELECT cpros, dpros FROM SigCdPro" + ;
            " WHERE dpros LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProsVal2")
        IF loc_nResult > 0
            SELECT cursor_4c_ProsVal2
            IF !EOF()
                loc_oPg.txt_4c_CPros.Value = ALLTRIM(cursor_4c_ProsVal2.cpros)
                loc_oPg.txt_4c_DPros.Value = ALLTRIM(cursor_4c_ProsVal2.dpros)
            ELSE
                THIS.AbrirBuscaDPros()
            ENDIF
        ELSE
            THIS.AbrirBuscaDPros()
        ENDIF
        IF USED("cursor_4c_ProsVal2")
            USE IN cursor_4c_ProsVal2
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA (SigCdEmp: cemps/razas)
    *   Equivalente ao fAcessoEmpresa(modo 'C') e fAcessoEmpresa(modo 'D')
    *   do form legado SIGREHCP
    *==========================================================================

    PROCEDURE AbrirBuscaCEmps()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CEmps.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaCEmps", "cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_BuscaCEmps.cemps)
                loc_oPg.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaCEmps.razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("razas", "", "Empresa")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCEmps")
                        loc_oPg.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_BuscaCEmps.cemps)
                        loc_oPg.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaCEmps.razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCEmps")
            USE IN cursor_4c_BuscaCEmps
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    PROCEDURE AbrirBuscaDEmps()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DEmps.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaDEmps", "razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaDEmps.razas)
                loc_oPg.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_BuscaDEmps.cemps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("razas", "", "Empresa")
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDEmps")
                        loc_oPg.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaDEmps.razas)
                        loc_oPg.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_BuscaDEmps.cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaDEmps")
            USE IN cursor_4c_BuscaDEmps
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    PROTECTED PROCEDURE ValidarCEmps()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CEmps.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DEmps.Value = ""
            THIS.AtualizarEstadoCamposDescricao()
            RETURN
        ENDIF
        loc_cSQL = "SELECT cemps, razas FROM SigCdEmp" + ;
            " WHERE cemps = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpsVal
            IF !EOF()
                loc_oPg.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpsVal.razas)
            ELSE
                loc_oPg.txt_4c_DEmps.Value = ""
                THIS.AbrirBuscaCEmps()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DEmps.Value = ""
            THIS.AbrirBuscaCEmps()
        ENDIF
        IF USED("cursor_4c_EmpsVal")
            USE IN cursor_4c_EmpsVal
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    PROTECTED PROCEDURE ValidarDEmps()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DEmps.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CEmps.Value = ""
            THIS.AtualizarEstadoCamposDescricao()
            RETURN
        ENDIF
        loc_cSQL = "SELECT cemps, razas FROM SigCdEmp" + ;
            " WHERE razas LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsVal2")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpsVal2
            IF !EOF()
                loc_oPg.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_EmpsVal2.cemps)
                loc_oPg.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpsVal2.razas)
            ELSE
                THIS.AbrirBuscaDEmps()
            ENDIF
        ELSE
            THIS.AbrirBuscaDEmps()
        ENDIF
        IF USED("cursor_4c_EmpsVal2")
            USE IN cursor_4c_EmpsVal2
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Forms de relatorio nao tem operacoes CRUD. Os metodos abaixo traduzem
    * o conceito CRUD para a semantica de relatorio.
    *==========================================================================

    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        LOCAL loc_oPg
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
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
                loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
                loc_oPg.txt_4c_CPros.Value      = .this_cCPros
                loc_oPg.txt_4c_DPros.Value      = .this_cDPros
                loc_oPg.txt_4c_CEmps.Value      = .this_cCEmps
                loc_oPg.txt_4c_DEmps.Value      = .this_cDEmps
                loc_oPg.opt_4c_OptTipImps.Value = .this_nTipoImps
            ENDWITH
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        TRY
            IF PCOUNT() = 0
                loc_lHab = .T.
            ELSE
                loc_lHab = par_lHabilitar
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_CEmps.Enabled         = loc_lHab
            loc_oPg.txt_4c_DtInicial.Enabled     = loc_lHab
            loc_oPg.txt_4c_DtFinal.Enabled       = loc_lHab
            loc_oPg.txt_4c_CPros.Enabled         = loc_lHab
            loc_oPg.opt_4c_OptTipImps.Enabled    = loc_lHab
            IF loc_lHab
                THIS.AtualizarEstadoCamposDescricao()
            ELSE
                loc_oPg.txt_4c_DEmps.Enabled = .F.
                loc_oPg.txt_4c_DPros.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
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

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nDestino, loc_oPgf, loc_oPg
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) != "O"
                RETURN
            ENDIF
            IF PCOUNT() = 0 OR VARTYPE(par_nPagina) != "N"
                loc_nDestino = 1
            ELSE
                loc_nDestino = INT(par_nPagina)
            ENDIF
            IF loc_nDestino < 1
                loc_nDestino = 1
            ENDIF
            IF loc_nDestino > loc_oPgf.PageCount
                loc_nDestino = loc_oPgf.PageCount
            ENDIF
            loc_oPgf.ActivePage = loc_nDestino
            loc_oPg = loc_oPgf.Pages(loc_nDestino)
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                loc_oPg.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
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
        LOCAL loc_oPg
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
    * Destroy - Libera referencia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
