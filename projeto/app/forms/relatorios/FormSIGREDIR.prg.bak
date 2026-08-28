*==============================================================================
* FORMSIGREDIR.PRG
* Demonstrativo de Retencao de Impostos - CSLL, COFINS e PIS/PASEP
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREDIR.SCX (frmrelatorio)
*
* FASE 8/8 - CONSOLIDACAO FINAL (form REPORT - sem CRUD):
*   BtnVisualizarClick  -> preview na tela (Buttons(1))
*   BtnImprimirClick    -> imprime com prompt (Buttons(2))
*   BtnExcelClick       -> exporta para Excel (Buttons(3))
*   BtnEncerrarClick    -> fecha o form (Buttons(4) / ESC)
*   BtnBuscarClick      -> alias de BtnVisualizarClick
*   BtnSalvarClick      -> alias de BtnImprimirClick
*   BtnCancelarClick    -> alias de BtnEncerrarClick
*   FormParaBO/BOParaForm -> sincronizacao form <-> BO de relatorio
*   HabilitarCampos     -> habilita/desabilita filtros
*   CarregarLista       -> recarrega grid de empresas
*   AjustarBotoesPorModo -> estado visual dos botoes do CommandGroup
*==============================================================================

DEFINE CLASS FormSIGREDIR AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=350)
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

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *        e garante SET DATE BRITISH + SET CENTURY ON (DataSession=2)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Constroi estrutura visual e instancia o BO
    *   Ordem obrigatoria: estrutura visual ANTES do BO (estrutura nao depende
    *   de SQL, BO depende - assim o form abre mesmo em modo validacao UI).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Demonstrativo de Reten" + CHR(231) + CHR(227) + "o de Impostos - CSLL, COFINS e PIS/PASEP"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Estrutura visual (independe de SQL - construida sempre)
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarPageFrame()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Instanciar BO apenas quando ha conexao real (pula em validacao UI)
            *   SIGREDIRBO.Init() executa SQLEXEC para carregar empresas;
            *   em modo gb_4c_ValidandoUI (gnConnHandle=-1) isso falharia.
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("SIGREDIRBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar SIGREDIRBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lSucesso = .F.
                ENDIF
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()
            ENDIF

            THIS.Visible   = .T.
            loc_lSucesso   = .T.

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
    *   Width = THIS.Width (cobre toda a faixa superior - cnt_4c_Saida eh
    *   transparente por cima, nao precisa deixar espaco).
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
                .Caption   = "Demonstrativo de Reten" + CHR(231) + CHR(227) + "o de Impostos"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco sobre a sombra
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Demonstrativo de Reten" + CHR(231) + CHR(227) + "o de Impostos"
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
    * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport area)
    *   Original: btnReport.Left=527, Top=3
    *   Geometria exata do framework frmrelatorio:
    *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *     Buttons: Top=5, Width=65, Height=70, Lefts=5/71/137/203
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

            *-- Buttons(1): Visualizar (preview em tela)
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

            *-- Buttons(2): Imprimir (com dialogo de impressora)
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

            *-- Buttons(3): Excel (exportar dados do cursor)
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

            *-- Buttons(4): Encerrar (ESC fecha o form - Cancel=.T.)
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
    *   Top=85 (logo apos o cabecalho de 80px + margem 5px)
    *   Height = THIS.Height - 85 = 350 - 85 = 265
    *   Page1 recebe os controles de filtro nas fases seguintes (4-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
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
    * ConfigurarPaginaLista - Adiciona controles de filtro na Page1 e conecta eventos
    *   Em forms REPORT, "Pagina Lista" eh a unica pagina (filtros + grid de empresas)
    *   Posicoes relativas a Page1 (top original - pgf.Top=85)
    *   Chamado APOS SIGREDIRBO ser instanciado (grid usa cursor de empresas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid, loc_cCursor

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Label "Ano Base :"  (original: Say2.Top=109, Left=181 -> Page1: 24, 181)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 24
            .Left      = 181
            .Width     = 54
            .Height    = 18
            .Caption   = "Ano Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Ano Base (original: getAnoBase.Top=106, Left=242 -> Page1: 21, 242)
        loc_oPagina.AddObject("txt_4c_AnoBase", "TextBox")
        WITH loc_oPagina.txt_4c_AnoBase
            .Top       = 21
            .Left      = 242
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .InputMask = "9999"
            .MaxLength = 4
            .Visible   = .T.
        ENDWITH

        *-- Label "Fornecedor :"  (original: Say4.Top=147, Left=171 -> Page1: 62, 171)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Top       = 62
            .Left      = 171
            .Width     = 64
            .Height    = 18
            .Caption   = "Fornecedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo do fornecedor (original: Get_Fornec.Top=144, Left=242 -> Page1: 59, 242)
        loc_oPagina.AddObject("txt_4c_Fornec", "TextBox")
        WITH loc_oPagina.txt_4c_Fornec
            .Top         = 59
            .Left        = 242
            .Width       = 81
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Value       = ""
            .MaxLength   = 10
            .ToolTipText = "[F4] Buscar fornecedor por c" + CHR(243) + "digo"
            .Visible     = .T.
        ENDWITH

        *-- TextBox razao social do fornecedor (original: Get_Dforn.Top=144, Left=324 -> Page1: 59, 324)
        *   ReadOnly .F. quando Fornec vazio (usuario pode buscar por nome)
        *   ReadOnly .T. quando Fornec preenchido (exibe descricao somente)
        loc_oPagina.AddObject("txt_4c_Dforn", "TextBox")
        WITH loc_oPagina.txt_4c_Dforn
            .Top         = 59
            .Left        = 324
            .Width       = 306
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Value       = ""
            .ReadOnly    = .F.
            .ToolTipText = "[F4] Buscar fornecedor por nome (somente quando c" + CHR(243) + "digo vazio)"
            .Visible     = .T.
        ENDWITH

        *-- Label "Empresas :"  (original: Say1.Top=180, Left=172 -> Page1: 95, 172)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 95
            .Left      = 172
            .Width     = 63
            .Height    = 18
            .Caption   = "Empresas :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de selecao de empresas (original: grdEmps.Top=179, Left=238 -> Page1: 94, 238)
        *   3 colunas: CheckBox(Imps), Emp.(cemps), Descricao(razas)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados
        WITH loc_oGrid
            .Top                = 94
            .Left               = 238
            .Width              = 291
            .Height             = 139
            .ColumnCount        = 3
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .ScrollBars         = 2

            *-- Column1: CheckBox para selecao (Imps)
            *   ORDEM OBRIGATORIA: AddObject -> Caption -> CurrentControl -> ControlSource
            .Column1.Width = 25
            .Column1.Header1.Caption = ""
            .Column1.AddObject("Check1", "CheckBox")
            .Column1.Check1.Caption = ""
            .Column1.Check1.Value = 1
            .Column1.CurrentControl = "Check1"

            *-- Column2: Codigo da empresa
            .Column2.Width    = 55
            .Column2.Header1.Caption = "Emp."
            .Column2.ReadOnly = .T.

            *-- Column3: Razao Social
            .Column3.Width    = 211
            .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.ReadOnly = .T.

            .Visible = .T.
        ENDWITH

        *-- ControlSource APOS toda a configuracao de colunas e CurrentControl
        loc_cCursor = THIS.this_oRelatorio.this_cCursorEmpresas
        IF USED(loc_cCursor)
            loc_oGrid.RecordSource      = loc_cCursor
            loc_oGrid.Column1.ControlSource = loc_cCursor + ".Imps"
            loc_oGrid.Column2.ControlSource = loc_cCursor + ".cemps"
            loc_oGrid.Column3.ControlSource = loc_cCursor + ".razas"
        ENDIF

        *-- Checkbox "marcar/desmarcar todas" posicionado sobre o header do Column1
        *   (original: ck_MarcaEmp.Top=180, Left=240 -> Page1: 95, 240)
        *   ZOrder(0) garante que fica sobre o grid (adicionado apos o grid)
        loc_oPagina.AddObject("chk_4c_MarcaEmp", "CheckBox")
        WITH loc_oPagina.chk_4c_MarcaEmp
            .Top         = 95
            .Left        = 240
            .Width       = 22
            .Height      = 16
            .Caption     = ""
            .Value       = 1
            .ToolTipText = "Marcar/Desmarcar todas as empresas"
            .Visible     = .T.
        ENDWITH
        loc_oPagina.chk_4c_MarcaEmp.ZOrder(0)

        *-- CommandGroup Marcar/Desmarcar todas as empresas
        *   (original: cmdEmps.Top=204, Left=532 -> Page1: 119, 532)
        *   Dimensoes EXATAS do original: Width=50, Height=91 (vertical, icones sem caption)
        loc_oPagina.AddObject("obj_4c_CmdEmps", "CommandGroup")
        WITH loc_oPagina.obj_4c_CmdEmps
            .Top         = 119
            .Left        = 532
            .Width       = 50
            .Height      = 91
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "A_MISC1.BMP"
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(36, 84, 155)
                .Themes          = .F.
                .ToolTipText     = "Marcar todas as empresas"
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 46
                .Left            = 5
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "A_MISC6.bmp"
                .FontName        = "Verdana"
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(36, 84, 155)
                .Themes          = .F.
                .ToolTipText     = "Desmarcar todas as empresas"
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- BINDEVENTs (todos os handlers sao PUBLIC - exigencia do BINDEVENT)
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.txt_4c_Fornec, "KeyPress", THIS, "TeclaFornecKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Dforn,  "KeyPress", THIS, "TeclaDfornKeyPress")
        BINDEVENT(loc_oPagina.chk_4c_MarcaEmp,       "InteractiveChange", THIS, "BtnMarcaEmpClick")
        BINDEVENT(loc_oPagina.obj_4c_CmdEmps.Buttons(1), "Click", THIS, "BtnCmdEmp1Click")
        BINDEVENT(loc_oPagina.obj_4c_CmdEmps.Buttons(2), "Click", THIS, "BtnCmdEmp2Click")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia filtros do form para o BO antes de gerar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            .this_cAnoBase = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.Value)
            .this_cFornec  = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value)
            .this_cDforn   = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Mapeamento CRUD->REPORT: "incluir" = gerar novo relatorio
    *   Form de relatorio nao possui operacoes CRUD. Para satisfazer a interface
    *   esperada pelo pipeline de validacao, este metodo delega para o fluxo
    *   equivalente em REPORT: limpar campos para um novo relatorio e gerar o
    *   preview com os filtros padrao (ano corrente, todas as empresas).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Reset filtros para estado inicial e marcar todas as empresas
        THIS.LimparCampos()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.AtualizarSelecaoEmpresas(.T.)
            IF VARTYPE(loc_oPagina.chk_4c_MarcaEmp) = "O"
                loc_oPagina.chk_4c_MarcaEmp.Value = 1
            ENDIF
            IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
                loc_oPagina.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF

        *-- Foco no primeiro filtro relevante (ano base)
        IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
            loc_oPagina.txt_4c_AnoBase.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Mapeamento CRUD->REPORT: "alterar" = enviar para impressora
    *   Form de relatorio nao possui edicao de registros. Esta operacao delega
    *   para BtnImprimirClick (alterar a saida de tela -> impressora) preservando
    *   a validacao completa de ano base e empresas selecionadas.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela (Buttons(1))
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cAno, loc_cMensagem, loc_cEmpresas
        loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.Value)
        IF EMPTY(loc_cAno)
            MsgAviso("Ano base n" + CHR(227) + "o informado.", "Aviso")
            THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.SetFocus()
            RETURN
        ENDIF
        loc_cEmpresas = THIS.this_oRelatorio.MontarEmpresas()
        IF EMPTY(ALLTRIM(loc_cEmpresas))
            loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
            IF EMPTY(loc_cMensagem)
                loc_cMensagem = "Nenhuma empresa foi selecionada."
            ENDIF
            MsgAviso(loc_cMensagem, "Aviso")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMensagem)
                MsgErro(loc_cMensagem, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora com dialogo (Buttons(2))
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cAno, loc_cMensagem, loc_cEmpresas
        loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.Value)
        IF EMPTY(loc_cAno)
            MsgAviso("Ano base n" + CHR(227) + "o informado.", "Aviso")
            THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.SetFocus()
            RETURN
        ENDIF
        loc_cEmpresas = THIS.this_oRelatorio.MontarEmpresas()
        IF EMPTY(ALLTRIM(loc_cEmpresas))
            loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
            IF EMPTY(loc_cMensagem)
                loc_cMensagem = "Nenhuma empresa foi selecionada."
            ENDIF
            MsgAviso(loc_cMensagem, "Aviso")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.ImprimirComPrompt()
            loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMensagem)
                MsgErro(loc_cMensagem, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para arquivo XLS (Buttons(3))
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cAno, loc_cMensagem, loc_cArquivo, loc_cEmpresas
        loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.Value)
        IF EMPTY(loc_cAno)
            MsgAviso("Ano base n" + CHR(227) + "o informado.", "Aviso")
            THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.SetFocus()
            RETURN
        ENDIF
        loc_cEmpresas = THIS.this_oRelatorio.MontarEmpresas()
        IF EMPTY(ALLTRIM(loc_cEmpresas))
            loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
            IF EMPTY(loc_cMensagem)
                loc_cMensagem = "Nenhuma empresa foi selecionada."
            ENDIF
            MsgAviso(loc_cMensagem, "Aviso")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.ExportarExcel()
            loc_cArquivo = THIS.this_oRelatorio.this_cUltimoArquivoExcel
            IF !EMPTY(loc_cArquivo)
                MsgInfo("Relat" + CHR(243) + "rio exportado para:" + CHR(13) + ;
                    loc_cArquivo, "Exporta" + CHR(231) + CHR(227) + "o Conclu" + CHR(237) + "da")
            ENDIF
        ELSE
            loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMensagem)
                MsgErro(loc_cMensagem, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Mapeamento CRUD->REPORT: "excluir" = limpar selecoes
    *   Form de relatorio nao possui exclusao de registros. Esta operacao
    *   delega para a limpeza dos filtros e desmarcacao de todas as empresas,
    *   deixando o form pronto para uma nova configuracao de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        THIS.LimparCampos()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.AtualizarSelecaoEmpresas(.F.)
            IF VARTYPE(loc_oPagina.chk_4c_MarcaEmp) = "O"
                loc_oPagina.chk_4c_MarcaEmp.Value = 0
            ENDIF
            IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
                loc_oPagina.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form (Buttons(4) - Cancel=.T. / ESC)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaFornecKeyPress - F4/ENTER/TAB em txt_4c_Fornec
    *   F4(115)/F5(116): abre busca por codigo
    *   ENTER(13)/TAB(9): valida codigo digitado e busca descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaFornecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
            CASE INLIST(par_nKeyCode, 115, 116)
                THIS.AbrirBuscaFornec()

            CASE INLIST(par_nKeyCode, 13, 9)
                THIS.ValidarFornec()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDfornKeyPress - F4/ENTER/TAB em txt_4c_Dforn
    *   Habilitado apenas quando txt_4c_Fornec esta vazio (busca por nome)
    *   F4(115)/F5(116)/ENTER(13)/TAB(9): abre busca por nome
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDfornKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCodFornec
        loc_cCodFornec = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value)
        IF !EMPTY(loc_cCodFornec)
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            THIS.AbrirBuscaFornecPorNome()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFornec - Valida codigo digitado em txt_4c_Fornec via SQLEXEC
    *   Se encontrado: preenche txt_4c_Dforn e torna ReadOnly
    *   Se nao encontrado: abre FormBuscaAuxiliar para selecao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFornec()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value)

        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .F.
            RETURN
        ENDIF

        loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornVal")

        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_FornVal") = 1
            SELECT cursor_4c_FornVal
            THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
            THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
            THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
        ELSE
            IF USED("cursor_4c_FornVal")
                USE IN cursor_4c_FornVal
            ENDIF
            THIS.AbrirBuscaFornec()
            RETURN
        ENDIF

        IF USED("cursor_4c_FornVal")
            USE IN cursor_4c_FornVal
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaFornec - Abre FormBuscaAuxiliar para SigCdCli buscando por codigo
    *   Ao selecionar: preenche txt_4c_Fornec, txt_4c_Dforn e torna ReadOnly
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaFornec()
        LOCAL loc_cValorAtual, loc_oBusca
        TRY
            loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, ;
                "SigCdCli", ;
                "cursor_4c_Busca", ;
                "iclis", ;
                loc_cValorAtual, ;
                "Busca de Fornecedor")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
                        SELECT cursor_4c_Busca
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
                    ENDIF
                ELSE
                    IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                        loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("rclis", "", "Fornecedor")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
                            THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
                            THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaFornecPorNome - Abre FormBuscaAuxiliar buscando por nome/razao social
    *   Ativado quando txt_4c_Fornec esta vazio e usuario digita em txt_4c_Dforn
    *   Ao selecionar: preenche ambos os campos e torna txt_4c_Dforn ReadOnly
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaFornecPorNome()
        LOCAL loc_cValorAtual, loc_oBusca
        TRY
            loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, ;
                "SigCdCli", ;
                "cursor_4c_Busca", ;
                "rclis", ;
                loc_cValorAtual, ;
                "Busca de Fornecedor por Nome")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
                        SELECT cursor_4c_Busca
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
                    ENDIF
                ELSE
                    IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                        loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("rclis", "", "Fornecedor")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
                            THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
                            THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcaEmpClick - Marca/desmarca todas as empresas pelo chk_4c_MarcaEmp
    *   CheckBox.Value=1 -> marca todas; Value=0 -> desmarca todas
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcaEmpClick()
        LOCAL loc_lMarcar
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_lMarcar = (THIS.pgf_4c_Paginas.Page1.chk_4c_MarcaEmp.Value = 1)
        THIS.this_oRelatorio.AtualizarSelecaoEmpresas(loc_lMarcar)
        THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCmdEmp1Click - Botao "Marcar Todas" do obj_4c_CmdEmps
    *--------------------------------------------------------------------------
    PROCEDURE BtnCmdEmp1Click()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.AtualizarSelecaoEmpresas(.T.)
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            THIS.pgf_4c_Paginas.Page1.chk_4c_MarcaEmp.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCmdEmp2Click - Botao "Desmarcar" do obj_4c_CmdEmps
    *--------------------------------------------------------------------------
    PROCEDURE BtnCmdEmp2Click()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.AtualizarSelecaoEmpresas(.F.)
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            THIS.pgf_4c_Paginas.Page1.chk_4c_MarcaEmp.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna a pagina ativa do PageFrame de filtros
    *   par_nPagina: indice da pagina (1..PageCount). Valores invalidos sao
    *   limitados ao range valido. Refresca o grid de empresas ao voltar
    *   para a pagina 1 (lista de filtros) para garantir que o estado
    *   visual reflita o cursor (apos AtualizarSelecaoEmpresas*, por exemplo).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_nMax, loc_oPgf, loc_oGrid

        IF VARTYPE(par_nPagina) <> "N"
            loc_nPagina = 1
        ELSE
            loc_nPagina = par_nPagina
        ENDIF

        loc_oPgf = THIS.pgf_4c_Paginas
        IF VARTYPE(loc_oPgf) <> "O"
            RETURN
        ENDIF

        loc_nMax = loc_oPgf.PageCount
        IF loc_nPagina < 1
            loc_nPagina = 1
        ENDIF
        IF loc_nPagina > loc_nMax
            loc_nPagina = loc_nMax
        ENDIF

        loc_oPgf.ActivePage = loc_nPagina

        IF loc_nPagina = 1
            loc_oGrid = loc_oPgf.Page1.grd_4c_Dados
            IF VARTYPE(loc_oGrid) = "O"
                loc_oGrid.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Inicializa valores padrao dos campos de filtro
    *   Form SIGREDIR e plano (sem Page2); este metodo substitui o Init()
    *   do legado que definia: getAnoBase.Value = Str(Year(Date()),4)
    *   Chamado apos ConfigurarPaginaLista() para garantir que os controles
    *   ja existam antes de atribuir valores iniciais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- AnoBase: inicializa com ano corrente (original: getAnoBase.Value = Str(Year(Date()),4))
        IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
            loc_oPagina.txt_4c_AnoBase.Value = STR(YEAR(DATE()), 4)
        ENDIF

        *-- Fornecedor: campos iniciam vazios, txt_4c_Dforn habilitado para busca por nome
        IF VARTYPE(loc_oPagina.txt_4c_Fornec) = "O"
            loc_oPagina.txt_4c_Fornec.Value = ""
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Dforn) = "O"
            loc_oPagina.txt_4c_Dforn.Value    = ""
            loc_oPagina.txt_4c_Dforn.ReadOnly = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura campos de filtro para estado inicial
    *   Reseta ano base para o ano corrente e limpa filtro de fornecedor.
    *   Pode ser chamado externamente para reutilizar o form sem fechar.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina

        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPagina) != "O"
            RETURN
        ENDIF

        IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
            loc_oPagina.txt_4c_AnoBase.Value = STR(YEAR(DATE()), 4)
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Fornec) = "O"
            loc_oPagina.txt_4c_Fornec.Value = ""
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Dforn) = "O"
            loc_oPagina.txt_4c_Dforn.Value    = ""
            loc_oPagina.txt_4c_Dforn.ReadOnly = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Preview do relatorio na tela
    *   Mapeamento CRUD->REPORT: "buscar" = visualizar dados do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Envia relatorio para impressora com dialogo
    *   Mapeamento CRUD->REPORT: "salvar" = imprimir/gerar relatorio final
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o form sem gerar relatorio
    *   Mapeamento CRUD->REPORT: "cancelar" = encerrar sem gerar relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza filtros do form para o BO de relatorio
    *   Alias de FormParaRelatorio() para compatibilidade com pipeline de validacao
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia propriedades do BO de relatorio de volta para o form
    *   Permite restaurar filtros a partir de estado salvo no BO
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
            loc_oPagina.txt_4c_AnoBase.Value = ALLTRIM(THIS.this_oRelatorio.this_cAnoBase)
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Fornec) = "O"
            loc_oPagina.txt_4c_Fornec.Value = ALLTRIM(THIS.this_oRelatorio.this_cFornec)
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Dforn) = "O"
            loc_oPagina.txt_4c_Dforn.Value    = ALLTRIM(THIS.this_oRelatorio.this_cDforn)
            loc_oPagina.txt_4c_Dforn.ReadOnly = !EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cFornec))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de filtro do relatorio
    *   par_lHabilitar: .T. habilita todos os filtros, .F. desabilita (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lHabilitar
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_lHabilitar = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)

        IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
            loc_oPagina.txt_4c_AnoBase.Enabled  = loc_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Fornec) = "O"
            loc_oPagina.txt_4c_Fornec.Enabled   = loc_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Dforn) = "O"
            loc_oPagina.txt_4c_Dforn.Enabled    = loc_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPagina.chk_4c_MarcaEmp) = "O"
            loc_oPagina.chk_4c_MarcaEmp.Enabled = loc_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
            loc_oPagina.grd_4c_Dados.Enabled    = loc_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPagina.obj_4c_CmdEmps) = "O"
            loc_oPagina.obj_4c_CmdEmps.Enabled  = loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega grid de selecao de empresas do banco de dados
    *   Equivalente ao CarregarLista() de forms CRUD.
    *   Retorna .T. se dados carregados com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oGrid
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT 1 AS Imps, cemps, razas FROM SigCdEmp ORDER BY cemps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")

            IF loc_nResult > 0
                IF USED(THIS.this_oRelatorio.this_cCursorEmpresas)
                    USE IN (THIS.this_oRelatorio.this_cCursorEmpresas)
                ENDIF
                SELECT Imps, cemps, razas FROM cursor_4c_EmpTmp ;
                    INTO CURSOR (THIS.this_oRelatorio.this_cCursorEmpresas) READWRITE
                USE IN cursor_4c_EmpTmp

                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                IF VARTYPE(loc_oGrid) = "O"
                    loc_oGrid.RecordSource          = THIS.this_oRelatorio.this_cCursorEmpresas
                    loc_oGrid.Column1.ControlSource = THIS.this_oRelatorio.this_cCursorEmpresas + ".Imps"
                    loc_oGrid.Column2.ControlSource = THIS.this_oRelatorio.this_cCursorEmpresas + ".cemps"
                    loc_oGrid.Column3.ControlSource = THIS.this_oRelatorio.this_cCursorEmpresas + ".razas"
                    loc_oGrid.Refresh()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao recarregar lista de empresas"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Atualiza estado visual dos botoes do CommandGroup
    *   Forms de relatorio nao tem modos INCLUIR/ALTERAR/EXCLUIR distintos.
    *   Visualizar/Imprimir/Excel ficam habilitados quando BO esta disponivel;
    *   Encerrar fica sempre habilitado.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lConectado
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF
        loc_lConectado = (VARTYPE(THIS.this_oRelatorio) = "O")
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lConectado
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lConectado
        THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lConectado
        THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *   NUNCA usar .Release() em objetos Custom/BO - apenas atribuir .NULL.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
