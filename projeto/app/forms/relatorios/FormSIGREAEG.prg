*==============================================================================
* FORMSIGREAEG.PRG
* Relatorio: Analise de Estoque por Grande Grupo
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREAEG.SCX (frmrelatorio)
*
* Filtros (PageFrame 1 pagina - controles em Page1):
*   - Empresa       (codigo + descricao - SigCdEmp)
*   - Grande Grupo  (codigo + descricao - SigCdGpr)
*   - Grupo Estoque (codigo + descricao - SigCdGcr)
*   - Conta Estoque (codigo + descricao - SigCdCli)
*   - Periodo       (data inicial / data final)
*
* Relatorios FRX: SigReAe1.frx (principal), SigReAe2.frx (divergencias)
*==============================================================================

DEFINE CLASS FormSIGREAEG AS FormBase

    *-- Dimensoes e aparencia (original Width=800, Height=300; novo: +150 para header/PageFrame)
    Height      = 450
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
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo do form)
    *   2. Cria SIGREAEGBO e inicializa cursores de referencia
    *   3. Monta cabecalho escuro + botoes do relatorio
    *   4. Monta PageFrame com controles de filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "An" + CHR(225) + "lise de Estoque por Grande Grupo"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREAEGBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREAEGBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente ao cntSombra do frmrelatorio)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com 2 paginas (padrao do sistema - Page1=Filtros, Page2=Dados)
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- ConfigurarPaginaLista: sem grid de selecao neste relatorio
                THIS.ConfigurarPaginaLista()

                *-- Campos de filtro: Empresa, Grande Grupo, Grupo/Conta Estoque, Periodo
                THIS.ConfigurarPaginaDados()

                *-- Pre-preencher campos com valores iniciais do BO
                THIS.LimparCampos()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGREAEG:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do relatorio
    *   Equivalente ao cntSombra/lblSombra/lblTitulo do framework frmrelatorio
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

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "An" + CHR(225) + "lise de Estoque por Grande Grupo"
            .FontName  = "Tahoma"
            .FontSize  = 14
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
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "An" + CHR(225) + "lise de Estoque por Grande Grupo"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do original (btnReport): Left=487, Width=313, Height=80
    *   Botoes de 75px de largura: Left=5/81/157/233, Height=70, Top=5
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

        *-- Botao 1: Visualizar
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- Botao 2: Imprimir
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- Botao 3: Excel
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "\<Arquivos Email"
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- Botao 4: Encerrar (Cancel=.T. para ESC fechar)
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Cancel          = .T.
        ENDWITH

        *-- BINDEVENTs: ButtonsClick -> handlers de acao do relatorio
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 2 paginas (padrao do sistema)
    *   Filtros direto em Page1; Page2 como pagina de dados padrao
    *   Posicionamento: logo abaixo do cabecalho (85px) ate o fim do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
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

        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Carrega cursores de referencia em memoria
    *   Form de relatorio nao tem grid CRUD; esta fase carrega os cursores que
    *   o original carregava no Init via poDataMgr.SqlExecute:
    *     CrSigCdEmp (cemps/razas/ativas) -> indexado por cemps para SEEK em ValidarEmpresa
    *     CrSigCdGrp (cgrus/mercs/cestoqs) -> referencia de grupos de estoque
    *   Se a carga falhar, as validacoes fazem fallback para SQLEXEC direto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nResult
        TRY
            *-- Cursor de empresas: usado por ValidarEmpresa() via SEEK(cemps)
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, ativas FROM SigCdEmp ORDER BY cemps", ;
                "cursor_4c_SigCdEmp")
            IF loc_nResult > 0
                SELECT cursor_4c_SigCdEmp
                INDEX ON cemps TAG cemps ADDITIVE
                GO TOP
            ELSE
                MsgAviso("Falha ao carregar empresas." + CHR(13) + ;
                    "Valida" + CHR(231) + CHR(227) + "o de empresa usar" + ;
                    CHR(225) + " consulta direta.", "Aviso")
            ENDIF

            *-- Cursor de grupos de estoque: referencia carregada no Init original
            IF USED("cursor_4c_SigCdGrp")
                USE IN cursor_4c_SigCdGrp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cgrus, mercs, cestoqs FROM SigCdGrp ORDER BY cgrus", ;
                "cursor_4c_SigCdGrp")
            IF loc_nResult < 1
                MsgAviso("Falha ao carregar grupos de estoque." + CHR(13) + ;
                    "Valida" + CHR(231) + CHR(227) + "o usar" + CHR(225) + ;
                    " consulta direta.", "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Todos os campos de filtro do relatorio em Page1
    *   Ajuste de Top: Top_Page1 = Top_original - 85 (PageFrame inicia em Top=85)
    *   Empresa (top=120->35), GGrupo (top=145->60), GrEstoque (top=172->87),
    *   Estoque (top=199->114), Periodo (top=226->141)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- EMPRESA (original Say5 top=123->38, getEmpresa top=120->35, getDesEmpresa top=120->35)
        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 38
            .Left      = 224
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Top       = 35
            .Left      = 279
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_DesEmpresa
            .Top       = 35
            .Left      = 312
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GRANDE GRUPO (original lbl_codigo top=150->65, get_cd_ggrupo top=145->60, get_ds_ggrupo top=145->60)
        loc_oPagina.AddObject("lbl_4c_GGrupo", "Label")
        WITH loc_oPagina.lbl_4c_GGrupo
            .Top       = 65
            .Left      = 198
            .AutoSize  = .T.
            .Caption   = "Grande Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdGGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_CdGGrupo
            .Top       = 60
            .Left      = 279
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsGGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DsGGrupo
            .Top       = 60
            .Left      = 312
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GRUPO DE ESTOQUE (original Say2 top=177->92, get_Cd_GrEstoque top=172->87, get_Ds_GrEstoque top=172->87)
        loc_oPagina.AddObject("lbl_4c_GrEstoque", "Label")
        WITH loc_oPagina.lbl_4c_GrEstoque
            .Top       = 92
            .Left      = 179
            .AutoSize  = .T.
            .Caption   = "Grupo de Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdGrEstoque
            .Top       = 87
            .Left      = 279
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsGrEstoque
            .Top       = 87
            .Left      = 361
            .Width     = 290
            .Height    = 23
            .MaxLength = 20
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- CONTA DE ESTOQUE (original lbl_estoque top=204->119, get_cd_estoque top=199->114, get_ds_estoque top=199->114)
        loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
        WITH loc_oPagina.lbl_4c_Estoque
            .Top       = 119
            .Left      = 179
            .AutoSize  = .T.
            .Caption   = "Conta de Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdEstoque
            .Top       = 114
            .Left      = 279
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsEstoque
            .Top       = 114
            .Left      = 361
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- PERIODO (original lbl_periodo top=231->146, get_dt_inicial top=226->141, get_dt_final top=226->141)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 146
            .Left      = 229
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Top       = 141
            .Left      = 279
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Separador "a" entre datas (original lbl_periodo_a top=231->146, left=364)
        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 146
            .Left      = 364
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Top       = 141
            .Left      = 376
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs: DblClick e KeyPress para todos os campos de filtro
        BINDEVENT(loc_oPagina.txt_4c_Empresa,     "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_Empresa,     "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DesEmpresa,  "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DesEmpresa,  "KeyPress", THIS, "TeclaDesEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_CdGGrupo,   "DblClick", THIS, "AbrirBuscaGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_CdGGrupo,   "KeyPress", THIS, "TeclaCdGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DsGGrupo,   "DblClick", THIS, "AbrirBuscaGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DsGGrupo,   "KeyPress", THIS, "TeclaDsGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque,   "KeyPress", THIS, "TeclaCdEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque,   "KeyPress", THIS, "TeclaDsEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DtInicial,   "KeyPress", THIS, "TeclaDtInicial")
        BINDEVENT(loc_oPagina.txt_4c_DtFinal,     "KeyPress", THIS, "TeclaDtFinal")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padrao do BO
    *   Datas preenchidas com DATE() (conforme Init() do BO); demais em branco
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_oPagina.txt_4c_Empresa.Value     = ""
            loc_oPagina.txt_4c_DesEmpresa.Value  = ""
            loc_oPagina.txt_4c_CdGGrupo.Value    = ""
            loc_oPagina.txt_4c_DsGGrupo.Value    = ""
            loc_oPagina.txt_4c_CdGrEstoque.Value = ""
            loc_oPagina.txt_4c_DsGrEstoque.Value = ""
            loc_oPagina.txt_4c_CdEstoque.Value   = ""
            loc_oPagina.txt_4c_DsEstoque.Value   = ""

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPagina.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
                loc_oPagina.txt_4c_DtFinal.Value   = THIS.this_oRelatorio.this_dDtFinal
            ELSE
                loc_oPagina.txt_4c_DtInicial.Value = DATE()
                loc_oPagina.txt_4c_DtFinal.Value   = DATE()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para pagina solicitada no PageFrame
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
           VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Empresa
    *==========================================================================

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Grande Grupo
    *==========================================================================

    PROCEDURE TeclaCdGGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsGGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaGGrupo()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Grupo de Estoque
    *==========================================================================

    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaGrEstoque()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Conta de Estoque
    *==========================================================================

    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEstoque()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Datas (sem acao especial alem de tipagem normal)
    *==========================================================================

    PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShiftAltCtrl)
        *-- Sem acao especial para teclas em campo de data
    ENDPROC

    PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShiftAltCtrl)
        *-- Sem acao especial para teclas em campo de data
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Empresa
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Valida codigo de empresa usando cursor_4c_SigCdEmp (em memoria)
    *   Equivale ao fAcessoEmpresa(Usuar,'C',...) do original
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_cCodigo, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DesEmpresa.Value = ""
                RETURN
            ENDIF
            IF USED("cursor_4c_SigCdEmp") AND ;
               SEEK(loc_cCodigo, "cursor_4c_SigCdEmp", "cemps")
                loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_SigCdEmp.cemps)
                loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_SigCdEmp.razas)
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaEmpresa()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Lookup de empresa via SigCdEmp (cemps/razas)
    *   Equivale ao fAcessoEmpresa(Usuar,'D',...) do original (busca por descricao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreaEmpBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", loc_cCursor, "cemps", loc_cValor, ;
                "Selecionar Empresa", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cemps)
                    loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(razas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Grande Grupo (SigCdGpr)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCdGGrupo - Valida codigo de Grande Grupo via SigCdGpr (codigos/descs)
    *   Equivale ao fwBuscaExt com 'C' (codigo) do original get_cd_ggrupo.Valid
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdGGrupo()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsGGrupo.Value = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGpr WHERE codigos = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGGrpVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreaGGrpVal")
                SELECT cursor_4c_SigreaGGrpVal
                loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(cursor_4c_SigreaGGrpVal.codigos)
                loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(cursor_4c_SigreaGGrpVal.descs)
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaGGrupo()
            ENDIF
            IF USED("cursor_4c_SigreaGGrpVal")
                USE IN cursor_4c_SigreaGGrpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGGrupo - Lookup de Grande Grupo via SigCdGpr (codigos/descs)
    *   Equivale ao fwBuscaExt('SigCdGpr','TmpGGrupo','codigos',...) do original
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreaGGrpBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grande Grupo", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(descs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Grupo de Estoque (SigCdGcr)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCdGrEstoque - Valida codigo de Grupo de Estoque via SigCdGcr (codigos/descrs)
    *   Equivale ao fAcessoContab(Usuar,'C',...) do original get_Cd_GrEstoque.Valid
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsGrEstoque.Value = ""
                loc_oPagina.txt_4c_CdEstoque.Value   = ""
                loc_oPagina.txt_4c_DsEstoque.Value   = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGcrVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreaGcrVal")
                SELECT cursor_4c_SigreaGcrVal
                loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_SigreaGcrVal.codigos)
                loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_SigreaGcrVal.descrs)
            ELSE
                MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
                         "Grupo de Estoque")
                loc_oPagina.txt_4c_CdGrEstoque.Value = ""
                loc_oPagina.txt_4c_DsGrEstoque.Value = ""
                THIS.AbrirBuscaGrEstoque()
            ENDIF
            IF USED("cursor_4c_SigreaGcrVal")
                USE IN cursor_4c_SigreaGcrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrEstoque - Lookup de Grupo de Estoque via SigCdGcr (codigos/descrs)
    *   Equivale ao fAcessoContab(Usuar,'D',...) do original get_Ds_GrEstoque.Valid
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreaGcrBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grupo de Estoque", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(descrs)
                    *-- Limpar conta de estoque ao trocar grupo (comportamento do original)
                    loc_oPagina.txt_4c_CdEstoque.Value = ""
                    loc_oPagina.txt_4c_DsEstoque.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Conta de Estoque (SigCdCli)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCdEstoque - Valida codigo de Conta de Estoque via SigCdCli (iclis/rclis)
    *   Equivale ao fAcessoContas(Usuar,grupo,'C',...) do original get_cd_estoque.Valid
    *   Se houver GrEstoque selecionado, filtra SigCdCli pelo grupo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cCodigo, loc_cGrupo, loc_cSQL, loc_nResult, loc_oPagina, loc_cFiltro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsEstoque.Value = ""
                RETURN
            ENDIF
            loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = " AND iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
            ENDIF
            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                       EscaparSQL(loc_cCodigo) + loc_cFiltro
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaCliVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreaCliVal")
                SELECT cursor_4c_SigreaCliVal
                loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_SigreaCliVal.iclis)
                loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_SigreaCliVal.rclis)
            ELSE
                MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
                         "Conta de Estoque")
                loc_oPagina.txt_4c_CdEstoque.Value = ""
                loc_oPagina.txt_4c_DsEstoque.Value = ""
                THIS.AbrirBuscaEstoque()
            ENDIF
            IF USED("cursor_4c_SigreaCliVal")
                USE IN cursor_4c_SigreaCliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEstoque - Lookup de Conta de Estoque via SigCdCli (iclis/rclis)
    *   Equivale ao fAcessoContas(Usuar,grupo,'D',...) do original get_ds_estoque.Valid
    *   Se houver GrEstoque selecionado, filtra SigCdCli pelo grupo
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor, loc_cGrupo, loc_cFiltro
        loc_cCursor = "cursor_4c_SigreaCliBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
            loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
                "Selecionar Conta de Estoque", loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
                    loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  TRANSFERENCIA DE DADOS - Form -> BO
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles do form para o BO
    *   Equivale ao inicio do PROCEDURE processamento do legado (leitura dos campos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cEmpresa      = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
                .this_cDesEmpresa   = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
                .this_cCdGGrupo     = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
                .this_cDsGGrupo     = ALLTRIM(loc_oPagina.txt_4c_DsGGrupo.Value)
                .this_cCdGrEstoque  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
                .this_cDsGrEstoque  = ALLTRIM(loc_oPagina.txt_4c_DsGrEstoque.Value)
                .this_cCdEstoque    = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
                .this_cDsEstoque    = ALLTRIM(loc_oPagina.txt_4c_DsEstoque.Value)
                .this_dDtInicial    = loc_oPagina.txt_4c_DtInicial.Value
                .this_dDtFinal      = loc_oPagina.txt_4c_DtFinal.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  VALIDACAO DOS CAMPOS ANTES DE GERAR O RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCampos - Valida campos obrigatorios antes de gerar o relatorio
    *   Equivale ao bloco de validacao do btnReport.Click do original:
    *   1. GrEstoque valido em SigCdGcr (se informado)
    *   2. Estoque valido em SigCdCli (se informado)
    *   3. GGrupo valido em SigCdGpr (se informado)
    *   4. Data inicial nao vazia
    *   5. Data final nao vazia
    *   6. Data final >= data inicial
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCampos()
        LOCAL loc_lResultado, loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResult
        loc_lResultado = .T.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Valida Grupo de Estoque (se informado)
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            IF !EMPTY(loc_cCodigo)
                loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGcr WHERE codigos = " + ;
                              EscaparSQL(loc_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGcrChk")
                IF loc_nResult < 1 OR EOF("cursor_4c_SigreaGcrChk")
                    MsgErro("Grupo de Estoque Inv" + CHR(225) + "lido.", "")
                    IF USED("cursor_4c_SigreaGcrChk")
                        USE IN cursor_4c_SigreaGcrChk
                    ENDIF
                    loc_oPagina.txt_4c_CdGrEstoque.SetFocus()
                    loc_lResultado = .F.
                ENDIF
                IF USED("cursor_4c_SigreaGcrChk")
                    USE IN cursor_4c_SigreaGcrChk
                ENDIF
            ENDIF

            *-- Valida Conta de Estoque (se informado)
            IF loc_lResultado
                loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
                IF !EMPTY(loc_cCodigo)
                    loc_cSQL    = "SELECT TOP 1 iclis FROM SigCdCli WHERE iclis = " + ;
                                  EscaparSQL(loc_cCodigo)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaCliChk")
                    IF loc_nResult < 1 OR EOF("cursor_4c_SigreaCliChk")
                        MsgErro("Conta de Estoque Inv" + CHR(225) + "lida.", "")
                        IF USED("cursor_4c_SigreaCliChk")
                            USE IN cursor_4c_SigreaCliChk
                        ENDIF
                        loc_oPagina.txt_4c_CdEstoque.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                    IF USED("cursor_4c_SigreaCliChk")
                        USE IN cursor_4c_SigreaCliChk
                    ENDIF
                ENDIF
            ENDIF

            *-- Valida Grande Grupo (se informado)
            IF loc_lResultado
                loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
                IF !EMPTY(loc_cCodigo)
                    loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGpr WHERE codigos = " + ;
                                  EscaparSQL(loc_cCodigo)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGGrpChk")
                    IF loc_nResult < 1 OR EOF("cursor_4c_SigreaGGrpChk")
                        MsgErro("Grande Grupo Inv" + CHR(225) + "lido.", "")
                        IF USED("cursor_4c_SigreaGGrpChk")
                            USE IN cursor_4c_SigreaGGrpChk
                        ENDIF
                        loc_oPagina.txt_4c_CdGGrupo.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                    IF USED("cursor_4c_SigreaGGrpChk")
                        USE IN cursor_4c_SigreaGGrpChk
                    ENDIF
                ENDIF
            ENDIF

            *-- Valida data inicial
            IF loc_lResultado AND EMPTY(loc_oPagina.txt_4c_DtInicial.Value)
                MsgErro("Data inicial inv" + CHR(225) + "lida !", "")
                loc_oPagina.txt_4c_DtInicial.SetFocus()
                loc_lResultado = .F.
            ENDIF

            *-- Valida data final
            IF loc_lResultado AND EMPTY(loc_oPagina.txt_4c_DtFinal.Value)
                MsgErro("Data final inv" + CHR(225) + "lida !", "")
                loc_oPagina.txt_4c_DtFinal.SetFocus()
                loc_lResultado = .F.
            ENDIF

            *-- Valida consistencia das datas
            IF loc_lResultado AND ;
               loc_oPagina.txt_4c_DtFinal.Value < loc_oPagina.txt_4c_DtInicial.Value
                MsgErro("Data inicial maior que data final !", "")
                loc_oPagina.txt_4c_DtInicial.SetFocus()
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    *  ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre preview do relatorio na tela
    *   Equivale ao btnReport.Visualiza.Click do legado (PROCEDURE visualizacao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *   Equivale ao btnReport.Imprime.Click do legado (PROCEDURE impressao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exportacao para Excel (funcionalidade DocExcel do legado)
    *   Prepara dados e exporta CsRelatorio para XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados() ;
               AND !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ;
                        "Relat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !USED("CsRelatorio") OR RECCOUNT("CsRelatorio") = 0
                MsgAviso("Nenhum dado encontrado para os filtros selecionados.", "Excel")
                RETURN
            ENDIF
            SELECT CsRelatorio
            loc_cArquivo = PUTFILE("Salvar como...", "RelAnaliseEstoque", "xls")
            IF EMPTY(loc_cArquivo)
                RETURN
            ENDIF
            COPY TO (loc_cArquivo) TYPE XL5
            MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio
    *   Equivale ao btnReport.Sair (Cancel=.T. no framework, ESC tambem fecha)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    *  STUBS DE COMPATIBILIDADE COM O FRAMEWORK (FormBase)
    *   Metodos CRUD que FormBase pode chamar; form REPORT nao usa CRUD.
    *==========================================================================

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    PROCEDURE FormParaBO()
        RETURN
    ENDPROC

    PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(2)
    ENDPROC

    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *==========================================================================
    *  CICLO DE VIDA DO FORM
    *==========================================================================

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relatorio e recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_SigCdGrp")
            USE IN cursor_4c_SigCdGrp
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
