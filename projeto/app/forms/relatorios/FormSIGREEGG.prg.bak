*==============================================================================
* FORMSIGREEGG.PRG
* Relatorio: Posicao de Estoque por Grande Grupo
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREEGG.SCX (frmrelatorio)
*
* Filtros (Page1 do PageFrame):
*   - Empresa       (codigo + descricao - SigCdEmp)
*   - Grupo Estoque (codigo + descricao - SigCdGcr)
*   - Conta Estoque (codigo + descricao - SigCdCli)
*   - Grande Grupo  (codigo + descricao - SigCdGpr)
*   - Data Posicao  (data unica)
*   - Opcao Custo   (OptionGroup: Sim=1 / Nao=2, default=2)
*   - Moeda         (codigo + descricao - SigCdMoe)
*
* Relatorio FRX: SigReEgg.frx
*==============================================================================

DEFINE CLASS FormSIGREEGG AS FormBase

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

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura do formulario de relatorio:
    *   1. Instancia SIGREEGGBO e carrega cursor de empresas
    *   2. Monta cabecalho escuro + CommandGroup de botoes
    *   3. PageFrame com Page1 (filtros) e Page2 (placeholder)
    *   4. Adiciona campos de filtro na Page1
    *   5. Pre-preenche campos com valores iniciais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Posi" + CHR(231) + CHR(227) + ;
                "o de Estoque por Grande Grupo"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SIGREEGGBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREEGGBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGREEGG:" + CHR(13) + ;
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
            .Caption   = "Posi" + CHR(231) + CHR(227) + ;
                "o de Estoque por Grande Grupo"
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
            .Caption   = "Posi" + CHR(231) + CHR(227) + ;
                "o de Estoque por Grande Grupo"
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
    *   Geometria EXATA do framework frmrelatorio (btnReport):
    *   Left=526->529, Top=4->0, ButtonCount=4
    *   Buttons: Visualizar/Imprimir/Excel/Encerrar
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
        ENDWITH

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
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "\<Arquivos Email"
            .WordWrap        = .T.
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
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .WordWrap        = .T.
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
            .Cancel          = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 2 paginas
    *   Page1 = filtros do relatorio
    *   Page2 = placeholder (padrao do sistema)
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
    * ConfigurarPaginaLista - Carrega cursor de empresas em memoria
    *   Equivalente ao Init() do original que carregava CrSigCdEmp via poDataMgr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nResult
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        TRY
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
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Campos de filtro em Page1
    *   Tops ajustados: Top_page = Top_original - 85 (PageFrame.Top=85)
    *   Empresa(23), GrEstoque(48), Estoque(75), GGrupo(102),
    *   DataPos(129), OptCusto(155), Moeda(158)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- EMPRESA (original Say5.top=111->26, getEmpresa.top=108->23, getDesEmpresa.top=108->23)
        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 26
            .Left      = 214
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
            .Top       = 23
            .Left      = 267
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
            .Top       = 23
            .Left      = 300
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

        *-- GRUPO DE ESTOQUE (Say2.top=138->53, get_Cd_GrEstoque.top=133->48, get_Ds_GrEstoque.top=133->48)
        loc_oPagina.AddObject("lbl_4c_GrEstoque", "Label")
        WITH loc_oPagina.lbl_4c_GrEstoque
            .Top       = 53
            .Left      = 169
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
            .Top       = 48
            .Left      = 267
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
            .Top       = 48
            .Left      = 349
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- CONTA DE ESTOQUE (lbl_estoque.top=165->80, get_cd_estoque.top=160->75, get_ds_estoque.top=160->75)
        loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
        WITH loc_oPagina.lbl_4c_Estoque
            .Top       = 80
            .Left      = 216
            .AutoSize  = .T.
            .Caption   = "Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdEstoque
            .Top       = 75
            .Left      = 267
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
            .Top       = 75
            .Left      = 349
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

        *-- GRANDE GRUPO (lbl_codigo.top=192->107, get_cd_ggrupo.top=187->102, get_ds_ggrupo.top=187->102)
        loc_oPagina.AddObject("lbl_4c_GGrupo", "Label")
        WITH loc_oPagina.lbl_4c_GGrupo
            .Top       = 107
            .Left      = 188
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
            .Top       = 102
            .Left      = 267
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

        loc_oPagina.AddObject("txt_4c_DsGGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DsGGrupo
            .Top       = 102
            .Left      = 349
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

        *-- DATA DE POSICAO (lbl_periodo.top=219->134, get_datapos.top=214->129)
        loc_oPagina.AddObject("lbl_4c_DataPos", "Label")
        WITH loc_oPagina.lbl_4c_DataPos
            .Top       = 134
            .Left      = 232
            .AutoSize  = .T.
            .Caption   = "Data :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DataPos", "TextBox")
        WITH loc_oPagina.txt_4c_DataPos
            .Top       = 129
            .Left      = 267
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- CUSTO label (Say1.top=246->161)
        loc_oPagina.AddObject("lbl_4c_Custo", "Label")
        WITH loc_oPagina.lbl_4c_Custo
            .Top       = 161
            .Left      = 227
            .AutoSize  = .T.
            .Caption   = "Custo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OPT CUSTO (opt_custo.top=240->155; Value=2 = Nao por padrao)
        loc_oPagina.AddObject("obj_4c_OptCusto", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptCusto
            .Top           = 155
            .Left          = 268
            .Width         = 103
            .Height        = 27
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .SpecialEffect = 0
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptCusto.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptCusto.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 57
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- MOEDA (lbl_moeda.top=246->161, get_cd_moeda.top=243->158, get_ds_moeda.top=243->158)
        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Top       = 161
            .Left      = 394
            .AutoSize  = .T.
            .Caption   = "Moeda : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_CdMoeda
            .Top       = 158
            .Left      = 441
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

        loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_DsMoeda
            .Top       = 158
            .Left      = 474
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs: DblClick e KeyPress para campos de filtro com lookup
        BINDEVENT(loc_oPagina.txt_4c_Empresa,     "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_Empresa,     "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DesEmpresa,  "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DesEmpresa,  "KeyPress", THIS, "TeclaDesEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque,   "KeyPress", THIS, "TeclaCdEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque,   "KeyPress", THIS, "TeclaDsEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdGGrupo,    "DblClick", THIS, "AbrirBuscaGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_CdGGrupo,    "KeyPress", THIS, "TeclaCdGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DsGGrupo,    "DblClick", THIS, "AbrirBuscaGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DsGGrupo,    "KeyPress", THIS, "TeclaDsGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DataPos,     "KeyPress", THIS, "TeclaDataPos")
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda,     "DblClick", THIS, "AbrirBuscaMoeda")
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda,     "KeyPress", THIS, "TeclaCdMoeda")
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda,     "DblClick", THIS, "AbrirBuscaMoeda")
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda,     "KeyPress", THIS, "TeclaDsMoeda")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com valores padrao
    *   DataPos = DATA() (conforme Init() do BO); opt_custo = 2 (Nao)
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
            loc_oPagina.txt_4c_CdGrEstoque.Value = ""
            loc_oPagina.txt_4c_DsGrEstoque.Value = ""
            loc_oPagina.txt_4c_CdEstoque.Value   = ""
            loc_oPagina.txt_4c_DsEstoque.Value   = ""
            loc_oPagina.txt_4c_CdGGrupo.Value    = ""
            loc_oPagina.txt_4c_DsGGrupo.Value    = ""
            loc_oPagina.txt_4c_CdMoeda.Value     = ""
            loc_oPagina.txt_4c_DsMoeda.Value     = ""
            loc_oPagina.obj_4c_OptCusto.Value    = 2

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPagina.txt_4c_DataPos.Value = THIS.this_oRelatorio.this_dDataPos
            ELSE
                loc_oPagina.txt_4c_DataPos.Value = DATE()
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
    * HANDLERS DE TECLADO - Empresa
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
    * HANDLERS DE TECLADO - Grupo de Estoque
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
    * HANDLERS DE TECLADO - Conta de Estoque
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
    * HANDLERS DE TECLADO - Grande Grupo
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
    * HANDLERS DE TECLADO - Data de Posicao e Moeda
    *==========================================================================

    PROCEDURE TeclaDataPos(par_nKeyCode, par_nShiftAltCtrl)
        *-- Campo de data: sem acao especial de tecla
    ENDPROC

    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACAO + LOOKUP - Empresa (SigCdEmp)
    *   Equivale ao fAcessoEmpresa(Usuar,'C',...) do original getEmpresa.Valid
    *==========================================================================

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

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreEggEmpBusca"
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
    * VALIDACAO + LOOKUP - Grupo de Estoque (SigCdGcr)
    *   Equivale ao fAcessoContab(Usuar,'C',...) do original get_Cd_GrEstoque.Valid
    *==========================================================================

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
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGcrVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggGcrVal")
                SELECT cursor_4c_SigreEggGcrVal
                loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_SigreEggGcrVal.codigos)
                loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_SigreEggGcrVal.descrs)
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaGrEstoque()
            ENDIF
            IF USED("cursor_4c_SigreEggGcrVal")
                USE IN cursor_4c_SigreEggGcrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaGrEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreEggGcrBusca"
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
                    loc_oPagina.txt_4c_CdEstoque.Value   = ""
                    loc_oPagina.txt_4c_DsEstoque.Value   = ""
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
    * VALIDACAO + LOOKUP - Conta de Estoque (SigCdCli)
    *   Equivale ao fAcessoContas(Usuar,grupo,'C',...) do original get_cd_estoque.Valid
    *   Se houver GrEstoque selecionado, filtra SigCdCli pelo grupo (iclis LIKE grupo%)
    *==========================================================================

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
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggCliVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggCliVal")
                SELECT cursor_4c_SigreEggCliVal
                loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_SigreEggCliVal.iclis)
                loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_SigreEggCliVal.rclis)
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaEstoque()
            ENDIF
            IF USED("cursor_4c_SigreEggCliVal")
                USE IN cursor_4c_SigreEggCliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor, loc_cGrupo, loc_cFiltro
        loc_cCursor = "cursor_4c_SigreEggCliBusca"
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
    * VALIDACAO + LOOKUP - Grande Grupo (SigCdGpr)
    *   Equivale ao fwBuscaExt('SigCdGpr','TmpGGrupo','codigos',...) do original
    *==========================================================================

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
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGprVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggGprVal")
                SELECT cursor_4c_SigreEggGprVal
                loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(cursor_4c_SigreEggGprVal.codigos)
                loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(cursor_4c_SigreEggGprVal.descs)
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaGGrupo()
            ENDIF
            IF USED("cursor_4c_SigreEggGprVal")
                USE IN cursor_4c_SigreEggGprVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaGGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreEggGprBusca"
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
    * VALIDACAO + LOOKUP - Moeda (SigCdMoe)
    *   Equivale ao fwBuscaExt('SigCdMoe','crListaRemota','CMoes',...) do original
    *==========================================================================

    PROCEDURE ValidarCdMoeda()
        LOCAL loc_cCodigo, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsMoeda.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreEggMoeBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", loc_cCursor, "CMoes", loc_cValor, ;
                "Selecionar Moeda", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdMoeda.Value = ALLTRIM(CMoes)
                    loc_oPagina.txt_4c_DsMoeda.Value = ALLTRIM(DMoes)
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
    * TRANSFERENCIA FORM -> BO
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para as propriedades do BO
    *   Equivale ao PROCEDURE processamento do original (leitura dos campos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cEmpresa     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
                .this_cDesEmpresa  = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
                .this_cCdGrEstoque = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
                .this_cDsGrEstoque = ALLTRIM(loc_oPagina.txt_4c_DsGrEstoque.Value)
                .this_cCdEstoque   = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
                .this_cDsEstoque   = ALLTRIM(loc_oPagina.txt_4c_DsEstoque.Value)
                .this_cCdGGrupo    = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
                .this_cDsGGrupo    = ALLTRIM(loc_oPagina.txt_4c_DsGGrupo.Value)
                .this_dDataPos     = loc_oPagina.txt_4c_DataPos.Value
                .this_nOptCusto    = loc_oPagina.obj_4c_OptCusto.Value
                .this_cCdMoeda     = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)
                .this_cDsMoeda     = ALLTRIM(loc_oPagina.txt_4c_DsMoeda.Value)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO ANTES DE GERAR O RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCampos - Valida filtros antes de gerar o relatorio
    *   Equivale ao bloco If !(This.Value = 3) em btnReport.Click do original:
    *   1. GrEstoque valido em SigCdGcr (se informado)
    *   2. Estoque valido em SigCdCli (se informado)
    *   3. GGrupo valido em SigCdGpr (se informado)
    *   4. Data de posicao nao vazia
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
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGcrChk")
                IF loc_nResult < 1 OR EOF("cursor_4c_SigreEggGcrChk")
                    MsgErro("Grupo de Estoque Inv" + CHR(225) + "lido.", "")
                    IF USED("cursor_4c_SigreEggGcrChk")
                        USE IN cursor_4c_SigreEggGcrChk
                    ENDIF
                    loc_oPagina.txt_4c_CdGrEstoque.SetFocus()
                    loc_lResultado = .F.
                ENDIF
                IF USED("cursor_4c_SigreEggGcrChk")
                    USE IN cursor_4c_SigreEggGcrChk
                ENDIF
            ENDIF

            *-- Valida Conta de Estoque (se informada)
            IF loc_lResultado
                loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
                IF !EMPTY(loc_cCodigo)
                    loc_cSQL    = "SELECT TOP 1 iclis FROM SigCdCli WHERE iclis = " + ;
                                  EscaparSQL(loc_cCodigo)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggCliChk")
                    IF loc_nResult < 1 OR EOF("cursor_4c_SigreEggCliChk")
                        MsgErro("Conta de Estoque Inv" + CHR(225) + "lida.", "")
                        IF USED("cursor_4c_SigreEggCliChk")
                            USE IN cursor_4c_SigreEggCliChk
                        ENDIF
                        loc_oPagina.txt_4c_CdEstoque.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                    IF USED("cursor_4c_SigreEggCliChk")
                        USE IN cursor_4c_SigreEggCliChk
                    ENDIF
                ENDIF
            ENDIF

            *-- Valida Grande Grupo (se informado)
            IF loc_lResultado
                loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
                IF !EMPTY(loc_cCodigo)
                    loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGpr WHERE codigos = " + ;
                                  EscaparSQL(loc_cCodigo)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGprChk")
                    IF loc_nResult < 1 OR EOF("cursor_4c_SigreEggGprChk")
                        MsgErro("Grande Grupo Inv" + CHR(225) + "lido.", "")
                        IF USED("cursor_4c_SigreEggGprChk")
                            USE IN cursor_4c_SigreEggGprChk
                        ENDIF
                        loc_oPagina.txt_4c_CdGGrupo.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                    IF USED("cursor_4c_SigreEggGprChk")
                        USE IN cursor_4c_SigreEggGprChk
                    ENDIF
                ENDIF
            ENDIF

            *-- Valida data de posicao (obrigatoria)
            IF loc_lResultado AND EMPTY(loc_oPagina.txt_4c_DataPos.Value)
                MsgErro("Data inv" + CHR(225) + "lida !", "")
                loc_oPagina.txt_4c_DataPos.SetFocus()
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview na tela
    *   Equivale ao btnReport.Visualiza.Click -> PROCEDURE visualizacao do original
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
    * BtnImprimirClick - Envia para impressora com prompt
    *   Equivale ao btnReport.Imprime.Click -> PROCEDURE impressao do original
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
    * BtnExcelClick - Exporta cursor_4c_Relatorio para XLS
    *   Equivale ao btnReport.DocExcel (Button 3) do original
    *   Nota: original Button 3 pulava validacoes; aqui mantenho validacao
    *   pois sem dados validos nao ha relatorio a exportar
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
            IF !USED("cursor_4c_Relatorio") OR RECCOUNT("cursor_4c_Relatorio") = 0
                MsgAviso("Nenhum dado encontrado para os filtros selecionados.", "Excel")
                RETURN
            ENDIF
            SELECT cursor_4c_Relatorio
            loc_cArquivo = PUTFILE("Salvar como...", "RelPosicaoEstoqueGGrupo", "xls")
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
    * BtnEncerrarClick - Fecha o formulario
    *   Equivale ao btnReport.Sair (Cancel=.T., ESC tambem fecha) do original
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * STUBS DE COMPATIBILIDADE COM FormBase (form REPORT nao usa CRUD)
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
    * CICLO DE VIDA DO FORM
    *==========================================================================

    *--------------------------------------------------------------------------
    * Destroy - Libera cursor de empresas e BO de relatorio
    *   Equivale ao PROCEDURE Release do original
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
