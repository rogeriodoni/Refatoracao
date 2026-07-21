*==============================================================================
* FORMSIGREVTO.PRG
* Relatorio Total Por Operacao
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREVTO.SCX (frmrelatorio)
*
* Filtros:
*   - Operacao  (codigo - SigCdOpe.Dopes)
*   - Periodo   (data inicial / data final)
*   - Moeda     (codigo + descricao - SigCdMoe.CMoes / DMoes)
*   - Empresa   (codigo + descricao - SigCdEmp.Cemps / Razas, opcional)
*
* Acoes: Visualizar (preview) / Imprimir (com dialogo) / Documento (direto)
*==============================================================================

DEFINE CLASS Formsigrevto AS FormBase

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
    * InicializarForm - Cria estrutura completa do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigrevtoBO e carrega filtros iniciais (pula em modo UI)
    *   3. Monta cabecalho escuro + botoes + PageFrame com campos de filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio Total Por Opera" + ;
                           CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigrevtoBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrevtoBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar filtros padrao (moeda do sistema, datas = hoje).
            *   Pulado em modo de validacao de UI (sem conexao SQL).
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.InicializarFiltros()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Valores iniciais dos campos de filtro
                THIS.LimparCampos()

                THIS.Visible   = .T.
                loc_lSucesso   = .T.
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
                .Caption   = "Relat" + CHR(243) + "rio Total Por Opera" + ;
                             CHR(231) + CHR(227) + "o"
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
                .Caption   = "Relat" + CHR(243) + "rio Total Por Opera" + ;
                             CHR(231) + CHR(227) + "o"
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
    * ConfigurarBotoes - CommandGroup btnReport (framework.vcx frmrelatorio)
    *   Original: btnReport CommandGroup com ButtonCount=4
    *   Geometria: Top=0, Left=529, Width=273, Height=80 (cabe em form 800px)
    *   Botoes: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 H=70
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
                .Caption         = "Documento"
                .WordWrap        = .T.
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
                .ToolTipText     = "Gerar Documento do Relat" + CHR(243) + "rio"
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
    * ConfigurarPageFrame - PageFrame com 1 pagina de filtros
    *   Posicionado abaixo do cabecalho (85px). O form legado era FLAT,
    *   mas no novo padrao os filtros sao agrupados em um PageFrame.
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
    * ConfigurarPaginaLista - Filtros principais da Page1 (Operacao + Periodo)
    *   Posicoes convertidas de coordenadas do form legado (subtraindo 85px
    *   do offset do PageFrame): ex. get_dopes.Top=129 -> Page1.Top=44.
    *
    *   Controles: Operacao (get_dopes), Periodo (dt_inicial/dt_final).
    *   BINDEVENTs: KeyPress (F4=lookup, ENTER/TAB=validar) + DblClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Operacao :"
        loc_oPg.AddObject("lbl_4c_LblOperacao", "Label")
        WITH loc_oPg.lbl_4c_LblOperacao
            .Top       = 49
            .Left      = 208
            .Width     = 56
            .Height    = 15
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da operacao (get_dopes: MaxLength=20, Format="K!")
        loc_oPg.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPg.txt_4c_Dopes
            .Top           = 44
            .Left          = 267
            .Width         = 150
            .Height        = 23
            .Value         = ""
            .MaxLength     = 20
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .Alignment     = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Periodo :"
        loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg.lbl_4c_LblPeriodo
            .Top       = 74
            .Left      = 219
            .Width     = 45
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Data inicial (get_dt_inicial: MaxLength=10, Format="K")
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top         = 69
            .Left        = 267
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Separador "a" entre datas (preposicao portuguesa: CHR(224) = a-grave = a com acento grave)
        loc_oPg.AddObject("lbl_4c_A", "Label")
        WITH loc_oPg.lbl_4c_A
            .Top       = 74
            .Left      = 350
            .Width     = 10
            .Height    = 15
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data final (get_dt_final: MaxLength=10, Format="K")
        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top         = 69
            .Left        = 361
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Handlers de teclado para filtros principais (Operacao + Datas)
        BINDEVENT(loc_oPg.txt_4c_Dopes,     "KeyPress", THIS, "TeclaOperacao")
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_Dopes,     "DblClick", THIS, "AbrirBuscaOperacao")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Filtros secundarios da Page1 (Moeda + Empresa)
    *   Controles de lookup com par codigo+descricao. Cada par tem When
    *   logic herdada do legado: descricao fica ReadOnly quando codigo
    *   esta preenchido (busca direta) e editavel quando codigo vazio
    *   (busca reversa por nome).
    *
    *   Controles: Moeda (cod+desc - SigCdMoe), Empresa (cod+desc - SigCdEmp).
    *   BINDEVENTs: KeyPress (F4=lookup, ENTER/TAB=validar) + DblClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Moeda :"
        loc_oPg.AddObject("lbl_4c_LblMoeda", "Label")
        WITH loc_oPg.lbl_4c_LblMoeda
            .Top       = 99
            .Left      = 223
            .Width     = 40
            .Height    = 15
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da moeda (get_moeda: MaxLength=3, Format="!")
        loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg.txt_4c_Moeda
            .Top           = 94
            .Left          = 267
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .Format        = "!"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .Alignment     = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Descricao da moeda (get_moeda_desc: MaxLength=15, Format="!")
        *   ReadOnly quando codigo da moeda esta preenchido (When original)
        loc_oPg.AddObject("txt_4c_MoedaDesc", "TextBox")
        WITH loc_oPg.txt_4c_MoedaDesc
            .Top           = 94
            .Left          = 300
            .Width         = 115
            .Height        = 23
            .Value         = ""
            .MaxLength     = 15
            .Format        = "!"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .Alignment     = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Empresa :"
        loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg.lbl_4c_LblEmpresa
            .Top       = 122
            .Left      = 214
            .Width     = 50
            .Height    = 15
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da empresa (getEmpresa: MaxLength=3)
        loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPg.txt_4c_Empresa
            .Top         = 119
            .Left        = 267
            .Width       = 31
            .Height      = 23
            .Value       = ""
            .MaxLength   = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Descricao da empresa (getDesEmpresa: Width=290)
        *   ReadOnly quando codigo da empresa esta preenchido (When original)
        loc_oPg.AddObject("txt_4c_DesEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DesEmpresa
            .Top         = 119
            .Left        = 300
            .Width       = 290
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Handlers de teclado para filtros secundarios (Moeda + Empresa)
        BINDEVENT(loc_oPg.txt_4c_Moeda,      "KeyPress", THIS, "TeclaMoeda")
        BINDEVENT(loc_oPg.txt_4c_MoedaDesc,  "KeyPress", THIS, "TeclaMoedaDesc")
        BINDEVENT(loc_oPg.txt_4c_Empresa,    "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DesEmpresa, "KeyPress", THIS, "TeclaDesEmpresa")

        *-- DblClick tambem abre lookup (equivalente ao F4)
        BINDEVENT(loc_oPg.txt_4c_Moeda,      "DblClick", THIS, "AbrirBuscaMoeda")
        BINDEVENT(loc_oPg.txt_4c_MoedaDesc,  "DblClick", THIS, "AbrirBuscaMoedaDesc")
        BINDEVENT(loc_oPg.txt_4c_Empresa,    "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DesEmpresa, "DblClick", THIS, "AbrirBuscaDesEmpresa")

        *-- Estado inicial dos campos de descricao (ReadOnly/editable)
        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao.
    *   Operacao=branco, Datas=hoje, Moeda=padrao do BO, Empresa=branca.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Dopes.Value      = ""
            loc_oPg.txt_4c_DtInicial.Value  = DATE()
            loc_oPg.txt_4c_DtFinal.Value    = DATE()
            loc_oPg.txt_4c_Moeda.Value      = ""
            loc_oPg.txt_4c_MoedaDesc.Value  = ""
            loc_oPg.txt_4c_Empresa.Value    = ""
            loc_oPg.txt_4c_DesEmpresa.Value = ""

            *-- Preenche moeda padrao carregada em InicializarFiltros()
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF !EMPTY(THIS.this_oRelatorio.this_cMoeda)
                    loc_oPg.txt_4c_Moeda.Value = THIS.this_oRelatorio.this_cMoeda
                ENDIF
                IF !EMPTY(THIS.this_oRelatorio.this_cMoedaDesc)
                    loc_oPg.txt_4c_MoedaDesc.Value = THIS.this_oRelatorio.this_cMoedaDesc
                ENDIF
            ENDIF

            THIS.AtualizarEstadoMoedaDesc()
            THIS.AtualizarEstadoDesEmpresa()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO.
    *   Equivalente ao bloco 'processamento' do form legado SIGREVTO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cDopes      = ALLTRIM(loc_oPg.txt_4c_Dopes.Value)
            .this_dDtInicial  = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal    = loc_oPg.txt_4c_DtFinal.Value
            .this_cMoeda      = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
            .this_cMoedaDesc  = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
            .this_cEmpresa    = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            .this_cDesEmpresa = ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Verifica data final >= data inicial.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarPeriodo()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c_DtInicial.Value
        loc_dFim = loc_oPg.txt_4c_DtFinal.Value
        IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
            MsgAviso("Data Final Menor Que a Inicial!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica preenchimento dos campos obrigatorios.
    *   Operacao e Moeda sao obrigatorios; Periodo e Empresa sao opcionais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Dopes.Value))
            MsgAviso("Informe o c" + CHR(243) + "digo da opera" + CHR(231) + ;
                CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Dopes.SetFocus()
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Moeda.Value))
            MsgAviso("Informe o c" + CHR(243) + "digo da moeda.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Moeda.SetFocus()
            RETURN .F.
        ENDIF
        IF !THIS.ValidarPeriodo()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *   Equivalente ao PROCEDURE visualizacao do legado.
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
        LOCAL loc_cFrxPath
        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    THIS.ExecutarReportForm("SigReVto", "PREVIEW", THIS.this_oRelatorio.this_cCursorDados)
                ELSE
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de selecao de impressora
    *   Equivalente ao PROCEDURE impressao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cFrxPath
        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    THIS.ExecutarReportForm("SigReVto", "PRINTER_PROMPT", THIS.this_oRelatorio.this_cCursorDados)
                ELSE
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Envia relatorio direto para impressora sem dialogo
    *   Equivalente ao PROCEDURE documento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_cFrxPath
        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    THIS.ExecutarReportForm("SigReVto", "PRINTER", THIS.this_oRelatorio.this_cCursorDados)
                ELSE
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
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
    * MAPEAMENTO CRUD -> REPORT
    * Aliases para compatibilidade com pipeline que espera metodos CRUD.
    *==========================================================================

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
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
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Dopes", 5)
                loc_oPg.txt_4c_Dopes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - BINDEVENT KeyPress
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaOperacao(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperacao()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOperacao()
        ENDIF
    ENDPROC

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

    PROCEDURE TeclaMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TeclaMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaDesc()
        ENDIF
    ENDPROC

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDesEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDesEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoMoedaDesc - Simula getDesEmpresa.When do legado.
    *   get_moeda_desc.When: Return Empty(ThisForm.get_moeda.Value)
    *   Campo de descricao so e editavel quando codigo da moeda esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoMoedaDesc()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_MoedaDesc.ReadOnly = ;
                !EMPTY(ALLTRIM(loc_oPg.txt_4c_Moeda.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoDesEmpresa - Simula getDesEmpresa.When do legado.
    *   getDesEmpresa.When: Return Empty(ThisForm.getEmpresa.Value)
    *   Campo de descricao so e editavel quando codigo da empresa esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoDesEmpresa()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DesEmpresa.ReadOnly = ;
                !EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUP - OPERACAO (SigCdOpe.Dopes)
    * Equivalente ao get_dopes.Valid: fAcessoMovmto do legado
    *==========================================================================

    PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dopes.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                        loc_oPg.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarOperacao()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dopes.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_OpeVal
            IF EOF()
                loc_oPg.txt_4c_Dopes.Value = ""
                THIS.AbrirBuscaOperacao()
            ENDIF
        ELSE
            loc_oPg.txt_4c_Dopes.Value = ""
            THIS.AbrirBuscaOperacao()
        ENDIF
        IF USED("cursor_4c_OpeVal")
            USE IN cursor_4c_OpeVal
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pelo codigo (SigCdMoe.CMoes)
    * Equivalente ao get_moeda.Valid: fwbuscaext -> SigCdMoe / CMoes
    *==========================================================================

    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoeda()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_MoedaDesc.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
                   EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeVal
            IF !EOF()
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(DMoes)
            ELSE
                loc_oPg.txt_4c_MoedaDesc.Value = ""
                THIS.AbrirBuscaMoeda()
            ENDIF
        ELSE
            loc_oPg.txt_4c_MoedaDesc.Value = ""
            THIS.AbrirBuscaMoeda()
        ENDIF
        IF USED("cursor_4c_MoeVal")
            USE IN cursor_4c_MoeVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pela descricao (SigCdMoe.DMoes)
    * Equivalente ao get_moeda_desc.Valid: fwbuscaext -> SigCdMoe / DMoes
    *==========================================================================

    PROCEDURE AbrirBuscaMoedaDesc()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeD")
                        loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoeD")
            USE IN cursor_4c_BuscaMoeD
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoedaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_Moeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + ;
                   EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeDescVal
            IF !EOF()
                loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(CMoes)
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(DMoes)
            ELSE
                THIS.AbrirBuscaMoedaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF USED("cursor_4c_MoeDescVal")
            USE IN cursor_4c_MoeDescVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pelo codigo (SigCdEmp.Cemps)
    * Equivalente ao getEmpresa.Valid: fAcessoEmpresa('C', ...) do legado
    *==========================================================================

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DesEmpresa.Value = ""
            THIS.AtualizarEstadoDesEmpresa()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                   EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(Razas)
            ELSE
                loc_oPg.txt_4c_DesEmpresa.Value = ""
                THIS.AbrirBuscaEmpresa()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DesEmpresa.Value = ""
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pela descricao (SigCdEmp.Razas)
    * Equivalente ao getDesEmpresa.Valid: fAcessoEmpresa('D', ...) do legado
    *==========================================================================

    PROCEDURE AbrirBuscaDesEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
                        loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                        loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmpD")
            USE IN cursor_4c_BuscaEmpD
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarDesEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_Empresa.Value = ""
            THIS.AtualizarEstadoDesEmpresa()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
                   EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpDescVal
            IF !EOF()
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(Cemps)
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(Razas)
            ELSE
                THIS.AbrirBuscaDesEmpresa()
            ENDIF
        ELSE
            THIS.AbrirBuscaDesEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpDescVal")
            USE IN cursor_4c_EmpDescVal
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *==========================================================================
    * METODOS PADRAO FormBase (sem aplicacao em relatorios)
    *==========================================================================

    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Dopes", 5)
                loc_oPg.txt_4c_Dopes.SetFocus()
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
                loc_oPg.txt_4c_Dopes.Value      = .this_cDopes
                loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
                loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
                loc_oPg.txt_4c_Moeda.Value      = .this_cMoeda
                loc_oPg.txt_4c_MoedaDesc.Value  = .this_cMoedaDesc
                loc_oPg.txt_4c_Empresa.Value    = .this_cEmpresa
                loc_oPg.txt_4c_DesEmpresa.Value = .this_cDesEmpresa
            ENDWITH
            THIS.AtualizarEstadoMoedaDesc()
            THIS.AtualizarEstadoDesEmpresa()
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
            loc_oPg.txt_4c_Dopes.Enabled     = loc_lHab
            loc_oPg.txt_4c_DtInicial.Enabled = loc_lHab
            loc_oPg.txt_4c_DtFinal.Enabled   = loc_lHab
            loc_oPg.txt_4c_Moeda.Enabled     = loc_lHab
            loc_oPg.txt_4c_Empresa.Enabled   = loc_lHab
            IF loc_lHab
                THIS.AtualizarEstadoMoedaDesc()
                THIS.AtualizarEstadoDesEmpresa()
            ELSE
                loc_oPg.txt_4c_MoedaDesc.Enabled  = .F.
                loc_oPg.txt_4c_DesEmpresa.Enabled = .F.
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
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Dopes", 5)
                loc_oPg.txt_4c_Dopes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
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
