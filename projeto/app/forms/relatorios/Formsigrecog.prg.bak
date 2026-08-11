*==============================================================================
* FORMSIGRECOG.PRG
* Relatorio de Comissao por Grupo de Produto
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECOG.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo   (data inicial / data final)
*   - Empresa   (codigo + razao social - SigCdEmp.Cemps / Razas)
*   - Vendedor  (codigo + nome - SigCdCli)
*   - Moeda     (codigo + descricao - SigCdMoe.Cmoes / Dmoes)
*
* Acoes: Visualizar (preview) / Imprimir (com dialogo) / Documento (direto)
*==============================================================================

DEFINE CLASS Formsigrecog AS FormBase

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
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption e Picture (fundo claro do framework)
    *   2. Instancia sigrecogBO (BO ja inicializa filtros default em Init())
    *   3. Monta cabecalho escuro com titulo
    *   4. Cria CommandGroup cmg_4c_Botoes (4 botoes: Visualiza/Imprime/Doc/Sair)
    *   5. Cria PageFrame com 1 pagina (Filtros) - controles internos sao
    *      adicionados nas fases seguintes da migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                           "o por Grupo de Produto"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instancia BO do relatorio (Init() do BO ja seta filtros default)
            THIS.this_oRelatorio = CREATEOBJECT("sigrecogBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecogBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.this_oRelatorio.CarregarMoedas()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaFiltros()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

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
    *   BackColor=RGB(100,100,100) cinza medio do framework (NAO quase preto).
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
                .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                             "o por Grupo de Produto"
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
                .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                             "o por Grupo de Produto"
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
    *   Botoes: Visualiza(5), Imprime(71), Documento(137), Sair(203) - W=65 H=70
    *   PicturePosition=13 (icon-acima do texto). Bindings dos Click sao
    *   adicionados em fase posterior (eventos).
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
    *   mas no novo padrao os filtros sao agrupados em uma Page com fundo
    *   claro do framework (fundo_cad_1003.jpg). Controles de filtro sao
    *   adicionados em ConfigurarPaginaLista() nas fases seguintes.
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

        loc_oPgf.Page2.Caption   = "Resultado"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa referencia ao BO (Custom NAO tem .Release(), usar .NULL.)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos campos de filtro (Page1)
    *   Adiciona: Periodo (dt_inicial + dt_final) e Empresa (codigo + descricao)
    *   Compensacao de Top: original - 85 (PageFrame.Top = 85)
    *   BINDEVENTs dos campos desta metade tambem sao registrados aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oPag.lbl_4c_Lbl_periodo
            .Top       = 133
            .Left      = 206
            .Width     = 45
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH loc_oPag.txt_4c__dt_inicial
            .Top      = 44
            .Left     = 255
            .Width    = 80
            .Height   = 25
            .Value    = {}
            .FontName = "Courier New"
            .FontSize = 9
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oPag.lbl_4c_Lbl_periodo_a
            .Top       = 136
            .Left      = 338
            .Width     = 8
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__dt_final", "TextBox")
        WITH loc_oPag.txt_4c__dt_final
            .Top      = 44
            .Left     = 349
            .Width    = 80
            .Height   = 25
            .Value    = {}
            .FontName = "Courier New"
            .FontSize = 9
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH loc_oPag.lbl_4c_Lbl_empresa
            .Top       = 160
            .Left      = 201
            .Width     = 50
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__empresa", "TextBox")
        WITH loc_oPag.txt_4c__empresa
            .Top       = 71
            .Left      = 255
            .Width     = 31
            .Height    = 25
            .Value     = ""
            .MaxLength = 3
            .Format    = "K"
            .FontName  = "Courier New"
            .FontSize  = 9
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__empresa_desc", "TextBox")
        WITH loc_oPag.txt_4c__empresa_desc
            .Top       = 71
            .Left      = 288
            .Width     = 290
            .Height    = 25
            .Value     = ""
            .MaxLength = 40
            .Format    = "!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPag.txt_4c__dt_inicial,   "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPag.txt_4c__dt_final,     "KeyPress", THIS, "TeclaDataFinal")
        BINDEVENT(loc_oPag.txt_4c__empresa,      "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPag.txt_4c__empresa_desc, "KeyPress", THIS, "TeclaEmpresaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Segunda metade dos campos de filtro (Page1)
    *   Adiciona: Vendedor (codigo + descricao) e Moeda (codigo + descricao)
    *   Pre-requisito: ConfigurarPaginaDados() ja foi chamado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.AddObject("lbl_4c_Lbl_vendedor", "Label")
        WITH loc_oPag.lbl_4c_Lbl_vendedor
            .Top       = 187
            .Left      = 196
            .Width     = 55
            .AutoSize  = .T.
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__vendedor", "TextBox")
        WITH loc_oPag.txt_4c__vendedor
            .Top       = 98
            .Left      = 255
            .Width     = 80
            .Height    = 25
            .Value     = ""
            .MaxLength = 10
            .Format    = "!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__vendedor_desc", "TextBox")
        WITH loc_oPag.txt_4c__vendedor_desc
            .Top       = 98
            .Left      = 337
            .Width     = 290
            .Height    = 25
            .Value     = ""
            .MaxLength = 40
            .Format    = "!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag.lbl_4c_Label6
            .Top       = 214
            .Left      = 210
            .Width     = 41
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Cmoeda", "TextBox")
        WITH loc_oPag.txt_4c_Cmoeda
            .Top       = 125
            .Left      = 255
            .Width     = 31
            .Height    = 25
            .Value     = ""
            .MaxLength = 3
            .Format    = "K!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Dmoeda", "TextBox")
        WITH loc_oPag.txt_4c_Dmoeda
            .Top       = 125
            .Left      = 288
            .Width     = 115
            .Height    = 25
            .Value     = ""
            .MaxLength = 15
            .Format    = "K!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPag.txt_4c__vendedor,      "KeyPress", THIS, "TeclaVendedor")
        BINDEVENT(loc_oPag.txt_4c__vendedor_desc, "KeyPress", THIS, "TeclaVendedorDesc")
        BINDEVENT(loc_oPag.txt_4c_Cmoeda,         "KeyPress", THIS, "TeclaMoeda")
        BINDEVENT(loc_oPag.txt_4c_Dmoeda,         "KeyPress", THIS, "TeclaMoedaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para pagina indicada do PageFrame
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos campos de filtro para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial    = loc_oPag.txt_4c__dt_inicial.Value
            .this_dDtFinal      = loc_oPag.txt_4c__dt_final.Value
            .this_cEmpresa      = ALLTRIM(loc_oPag.txt_4c__empresa.Value)
            .this_cRazaEmpresa  = ALLTRIM(loc_oPag.txt_4c__empresa_desc.Value)
            .this_cVendedor     = ALLTRIM(loc_oPag.txt_4c__vendedor.Value)
            .this_cNomeVendedor = ALLTRIM(loc_oPag.txt_4c__vendedor_desc.Value)
            .this_cCmoeda       = ALLTRIM(loc_oPag.txt_4c_Cmoeda.Value)
            .this_cDmoeda       = ALLTRIM(loc_oPag.txt_4c_Dmoeda.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias canonico de FormParaRelatorio (CRUD-style contract)
    *   Copia TODOS os campos de filtro do form para o BO de relatorio.
    *   Form REPORT nao tem CRUD; mantido para uniformidade com forms CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial    = loc_oPag.txt_4c__dt_inicial.Value
            .this_dDtFinal      = loc_oPag.txt_4c__dt_final.Value
            .this_cEmpresa      = ALLTRIM(loc_oPag.txt_4c__empresa.Value)
            .this_cRazaEmpresa  = ALLTRIM(loc_oPag.txt_4c__empresa_desc.Value)
            .this_cVendedor     = ALLTRIM(loc_oPag.txt_4c__vendedor.Value)
            .this_cNomeVendedor = ALLTRIM(loc_oPag.txt_4c__vendedor_desc.Value)
            .this_cCmoeda       = ALLTRIM(loc_oPag.txt_4c_Cmoeda.Value)
            .this_cDmoeda       = ALLTRIM(loc_oPag.txt_4c_Dmoeda.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c__dt_inicial.Value    = DATE()
        loc_oPag.txt_4c__dt_final.Value      = DATE()
        loc_oPag.txt_4c__empresa.Value       = ""
        loc_oPag.txt_4c__empresa_desc.Value  = ""
        loc_oPag.txt_4c__vendedor.Value      = ""
        loc_oPag.txt_4c__vendedor_desc.Value = ""
        loc_oPag.txt_4c_Cmoeda.Value         = ""
        loc_oPag.txt_4c_Dmoeda.Value         = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera preview em video
    * Handler BINDEVENT: cmg_4c_Botoes.Buttons(1).Click
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Visualizar Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    * Handler BINDEVENT: cmg_4c_Botoes.Buttons(2).Click
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Imprimir Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Gera exportacao do relatorio
    * Handler BINDEVENT: cmg_4c_Botoes.Buttons(3).Click
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.GerarExcel()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    * Handler BINDEVENT: cmg_4c_Botoes.Buttons(4).Click (Cancel = .T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Form REPORT nao possui CRUD; acao equivalente eh gerar
    *   o relatorio em video (Visualizar). Mantido para compatibilidade com o
    *   contrato de eventos principais de formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(2)
        IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro ao Gerar Relat" + CHR(243) + "rio")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Form REPORT nao possui CRUD; acao equivalente eh enviar
    *   o relatorio para a impressora. Mantido para compatibilidade com o
    *   contrato de eventos principais de formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Imprimir Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Form REPORT nao possui CRUD; acao equivalente eh limpar
    *   os campos de filtro (reset para valores padrao). Mantido para
    *   compatibilidade com o contrato de eventos principais de formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja limpar os filtros do relat" + CHR(243) + "rio?", ;
                       "Limpar Filtros")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShift)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresa - F4=busca direta / ENTER ou TAB=valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresaDesc - F4=busca por nome / ENTER ou TAB=valida descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVendedor - F4=busca direta / ENTER ou TAB=valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedor(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVendedor()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarVendedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVendedorDesc - F4=busca por nome / ENTER ou TAB=valida nome
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedorDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVendedor()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarVendedorDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaMoeda - F4=busca direta / ENTER ou TAB=valida codigo de moeda
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaMoedaDesc - F4=busca por descricao / ENTER ou TAB=valida desc moeda
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoedaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Busca empresa por codigo em SigCdEmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmpresa()
        LOCAL loc_cCod, loc_cSQL, loc_nResult, loc_oPag, loc_oErro, loc_lEncontrado
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c__empresa.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c__empresa_desc.Value = ""
            RETURN
        ENDIF
        loc_lEncontrado = .F.
        TRY
            loc_cSQL = "SELECT cemps, razas FROM SigCdEmp " + ;
                       "WHERE cemps = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpVal
                IF !EOF()
                    loc_oPag.txt_4c__empresa_desc.Value = ALLTRIM(razas)
                    loc_lEncontrado = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
            IF !loc_lEncontrado
                MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
                loc_oPag.txt_4c__empresa.Value      = ""
                loc_oPag.txt_4c__empresa_desc.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Empresa")
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresaDesc - Desc preenchida sem codigo: abre busca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmpresaDesc()
        LOCAL loc_cDesc, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c__empresa_desc.Value)
        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c__empresa.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - FormBuscaAuxiliar para SigCdEmp (cemps / razas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oForm, loc_oPag, loc_cValor, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__empresa.Value)
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "cemps", loc_cValor, ;
                "Busca de Empresa")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("razas", "", "Empresa")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_oPag.txt_4c__empresa.Value      = ALLTRIM(cemps)
                    loc_oPag.txt_4c__empresa_desc.Value = ALLTRIM(razas)
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Empresa")
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedor - Busca vendedor por codigo em SigCdCli
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarVendedor()
        LOCAL loc_cCod, loc_cSQL, loc_nResult, loc_oPag, loc_oErro, loc_lEncontrado
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c__vendedor.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c__vendedor_desc.Value = ""
            RETURN
        ENDIF
        loc_lEncontrado = .F.
        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli " + ;
                       "WHERE iclis = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenVal")
            IF loc_nResult > 0
                SELECT cursor_4c_VenVal
                IF !EOF()
                    loc_oPag.txt_4c__vendedor_desc.Value = ALLTRIM(rclis)
                    loc_lEncontrado = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_VenVal")
                USE IN cursor_4c_VenVal
            ENDIF
            IF !loc_lEncontrado
                MsgAviso("Vendedor n" + CHR(227) + "o encontrado.", "Vendedor")
                loc_oPag.txt_4c__vendedor.Value      = ""
                loc_oPag.txt_4c__vendedor_desc.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Vendedor")
            IF USED("cursor_4c_VenVal")
                USE IN cursor_4c_VenVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedorDesc - Nome preenchido sem codigo: abre busca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarVendedorDesc()
        LOCAL loc_cDesc, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c__vendedor_desc.Value)
        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c__vendedor.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaVendedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVendedor - FormBuscaAuxiliar para SigCdCli (iclis / rclis)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaVendedor()
        LOCAL loc_oForm, loc_oPag, loc_cValor, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__vendedor.Value)
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaVen", "iclis", loc_cValor, ;
                "Busca de Vendedor")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("rclis", "", "Vendedor")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaVen")
                    SELECT cursor_4c_BuscaVen
                    loc_oPag.txt_4c__vendedor.Value      = ALLTRIM(iclis)
                    loc_oPag.txt_4c__vendedor_desc.Value = ALLTRIM(rclis)
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_BuscaVen")
                USE IN cursor_4c_BuscaVen
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Vendedor")
            IF USED("cursor_4c_BuscaVen")
                USE IN cursor_4c_BuscaVen
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeda - Valida codigo moeda via cursor_4c_Moedas (pre-carregado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarMoeda()
        LOCAL loc_cCod, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c_Cmoeda.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c_Dmoeda.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_Moedas")
            SELECT cursor_4c_Moedas
            LOCATE FOR ALLTRIM(cmoes) = loc_cCod
            IF FOUND()
                loc_oPag.txt_4c_Cmoeda.Value = ALLTRIM(cmoes)
                loc_oPag.txt_4c_Dmoeda.Value = ALLTRIM(dmoes)
            ELSE
                THIS.AbrirBuscaMoeda()
            ENDIF
        ELSE
            THIS.AbrirBuscaMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoedaDesc - Valida descricao moeda via cursor_4c_Moedas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarMoedaDesc()
        LOCAL loc_cDesc, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c_Dmoeda.Value)
        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c_Cmoeda.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_Moedas")
            SELECT cursor_4c_Moedas
            LOCATE FOR ALLTRIM(dmoes) = loc_cDesc
            IF FOUND()
                loc_oPag.txt_4c_Cmoeda.Value = ALLTRIM(cmoes)
                loc_oPag.txt_4c_Dmoeda.Value = ALLTRIM(dmoes)
            ELSE
                THIS.AbrirBuscaMoeda()
            ENDIF
        ELSE
            THIS.AbrirBuscaMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - FormBuscaAuxiliar para SigCdMoe (cmoes / dmoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oForm, loc_oPag, loc_cValor, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Cmoeda.Value)
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", loc_cValor, ;
                "Busca de Moeda")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    loc_oPag.txt_4c_Cmoeda.Value = ALLTRIM(cmoes)
                    loc_oPag.txt_4c_Dmoeda.Value = ALLTRIM(dmoes)
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Moeda")
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Acao "Buscar" no relatorio: equivale a Visualizar
    *   Form de relatorio nao tem grade de lista; "buscar" = gerar preview.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Visualizar Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Acao "Salvar" no relatorio: equivale a Imprimir
    *   Form de relatorio nao persiste dados; "salvar" = enviar para impressora.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Imprimir Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa os filtros e recarrega moedas
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.this_oRelatorio.CarregarMoedas()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia propriedades do BO para os campos de filtro do form
    *   Inverso de FormParaRelatorio(). Util quando o BO ja tem valores
    *   pre-configurados (ex: empresa logada, data de hoje).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            loc_oPag.txt_4c__dt_inicial.Value    = IIF(EMPTY(.this_dDtInicial),    DATE(), .this_dDtInicial)
            loc_oPag.txt_4c__dt_final.Value      = IIF(EMPTY(.this_dDtFinal),      DATE(), .this_dDtFinal)
            loc_oPag.txt_4c__empresa.Value       = ALLTRIM(.this_cEmpresa)
            loc_oPag.txt_4c__empresa_desc.Value  = ALLTRIM(.this_cRazaEmpresa)
            loc_oPag.txt_4c__vendedor.Value      = ALLTRIM(.this_cVendedor)
            loc_oPag.txt_4c__vendedor_desc.Value = ALLTRIM(.this_cNomeVendedor)
            loc_oPag.txt_4c_Cmoeda.Value         = ALLTRIM(.this_cCmoeda)
            loc_oPag.txt_4c_Dmoeda.Value         = ALLTRIM(.this_cDmoeda)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de filtro
    *   par_lHabilitar = .T. habilita todos, .F. desabilita todos.
    *   Form de relatorio normalmente mant?m todos habilitados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c__dt_inicial.ReadOnly    = !par_lHabilitar
        loc_oPag.txt_4c__dt_final.ReadOnly      = !par_lHabilitar
        loc_oPag.txt_4c__empresa.ReadOnly       = !par_lHabilitar
        loc_oPag.txt_4c__empresa_desc.ReadOnly  = !par_lHabilitar
        loc_oPag.txt_4c__vendedor.ReadOnly      = !par_lHabilitar
        loc_oPag.txt_4c__vendedor_desc.ReadOnly = !par_lHabilitar
        loc_oPag.txt_4c_Cmoeda.ReadOnly         = !par_lHabilitar
        loc_oPag.txt_4c_Dmoeda.ReadOnly         = !par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega cursor de moedas para uso nos lookups
    *   Form de relatorio nao tem grade de lista; "carregar lista" = recarregar
    *   dados de referencia (moedas) que alimentam o campo de filtro Moeda.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_lSucesso = THIS.this_oRelatorio.CarregarMoedas()
            IF !loc_lSucesso
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                         "Erro ao Carregar Moedas")
            ENDIF
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Garante que todos os 4 botoes do CommandGroup
    *   estejam habilitados. Form de relatorio nao tem modos CRUD; os botoes
    *   Visualizar/Imprimir/Documento/Encerrar ficam sempre ativos.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

ENDDEFINE
