*==============================================================================
* FormLGR.prg - Formulario de Dados Gerenciais Fiscais
* Migrado de: SIGCDLGR.SCX (frmcadastro)
* Herda de: FormBase
* BO: LGRBO
* Tabela: SigFiGfd (JOIN SigFiMpm para marca do modelo)
*==============================================================================

DEFINE CLASS FormLGR AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Dados Gerenciais Fiscais"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 2

    *-- Estado do formulario
    this_cModoAtual = "LISTA"

    *==========================================================================
    * Init - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, PageFrame e componentes da interface
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("LGRBO")

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
                IF !THIS.CarregarLista()
                    * Falha ao carregar nao impede a abertura do form
                ENDIF
            ENDIF

            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"
            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormLGR:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame principal (Top=-29 para ocultar abas)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(225, 225, 225)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(225, 225, 225)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
    * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza escuro com titulo (Top original=2, +29comp=31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (Grupo_Op canonico: Top=29, Left=542, Width=390)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botoes CRUD dentro de cnt_4c_Botoes
        WITH loc_oPagina.cnt_4c_Botoes
            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 305
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container Encerrar (canonico: Left=917, Width=90, BackStyle=0)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.cnt_4c_Saida
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container visual dos filtros (faixa de fundo, transparente)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 115
            .Left        = 0
            .Width       = 730
            .Height      = 70
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label Serie de Fabricacao (original Top=129, Left=36 -> +29=158)
        loc_oPagina.AddObject("lbl_4c_SerieFab", "Label")
        WITH loc_oPagina.lbl_4c_SerieFab
            .Caption   = "S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o :"
            .Top       = 158
            .Left      = 36
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Serie de Fabricacao (original Top=125 -> +29=154)
        loc_oPagina.AddObject("txt_4c_SerieFab", "TextBox")
        WITH loc_oPagina.txt_4c_SerieFab
            .Value     = ""
            .Top       = 154
            .Left      = 141
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .Visible   = .T.
        ENDWITH

        *-- Label Periodo (original Top=128 -> +29=157)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 158
            .Left      = 319
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Inicio (original Top=125 -> +29=154)
        loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
        WITH loc_oPagina.txt_4c_Dtini
            .Value   = DATE()
            .Top     = 154
            .Left    = 367
            .Width   = 80
            .Height  = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        *-- Label Ate (original Top=129 -> +29=158)
        loc_oPagina.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPagina.lbl_4c_Ate
            .Caption   = "At" + CHR(233)
            .Top       = 158
            .Left      = 455
            .Width     = 22
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Fim (original Top=125 -> +29=154)
        loc_oPagina.AddObject("txt_4c_Dtfim", "TextBox")
        WITH loc_oPagina.txt_4c_Dtfim
            .Value   = DATE()
            .Top     = 154
            .Left    = 483
            .Width   = 80
            .Height  = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        *-- Grid de lista (original Top=157 -> +29=186, Left=12)
        *-- Width=893 (form 1000 - left 12 - margem 5 = 983; deixa espaco para cnt_4c_Saida)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 186
            .Left              = 12
            .Width             = 893
            .Height            = 435
            .FontName          = "Verdana"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .GridLines         = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 3
            .ReadOnly          = .T.
            .Visible           = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes CRUD (PUBLIC methods - sem PROTECTED)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        *-- BINDEVENTs dos campos de filtro
        BINDEVENT(loc_oPagina.txt_4c_SerieFab, "KeyPress", THIS, "ValidarSerieFab")
        BINDEVENT(loc_oPagina.txt_4c_Dtini,    "KeyPress", THIS, "ValidarDtini")
        BINDEVENT(loc_oPagina.txt_4c_Dtfim,    "KeyPress", THIS, "ValidarDtfim")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos de edicao e botoes salvar/cancelar
    * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (grupo_salva canonico)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.cnt_4c_Salva
            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Label NFAB (Say1: original top=151 -> +29=180, left=167)
        loc_oPagina.AddObject("lbl_4c_Nfab", "Label")
        WITH loc_oPagina.lbl_4c_Nfab
            .Caption   = "No Fabrica" + CHR(231) + CHR(227) + "o - NFAB. :"
            .Top       = 180
            .Left      = 167
            .Width     = 140
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo/NFAB (Get_codigo: original top=148 -> +29=177; When=.F. = readOnly)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 177
            .Left      = 312
            .Width     = 157
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .MaxLength = 40
            .Visible   = .T.
        ENDWITH

        *-- Label Modelo (Say16: original top=178 -> +29=207, left=253)
        loc_oPagina.AddObject("lbl_4c_Modelo", "Label")
        WITH loc_oPagina.lbl_4c_Modelo
            .Caption   = "Modelo :"
            .Top       = 207
            .Left      = 253
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Modelo (GetModelo: original top=175 -> +29=204, left=312, width=150)
        loc_oPagina.AddObject("txt_4c_Modelo", "TextBox")
        WITH loc_oPagina.txt_4c_Modelo
            .Value     = ""
            .Top       = 204
            .Left      = 312
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .Visible   = .T.
        ENDWITH

        *-- Label COO (Say2: original top=205 -> +29=234, left=266)
        loc_oPagina.AddObject("lbl_4c_Coo", "Label")
        WITH loc_oPagina.lbl_4c_Coo
            .Caption   = "COO :"
            .Top       = 234
            .Left      = 266
            .Width     = 40
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox COO (Getcoo: original top=202 -> +29=231, left=312, width=50)
        loc_oPagina.AddObject("txt_4c_Coo", "TextBox")
        WITH loc_oPagina.txt_4c_Coo
            .Value     = "000000"
            .Top       = 231
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 6
            .Visible   = .T.
        ENDWITH

        *-- Label Cupom nao Fiscal (Say3: original top=232 -> +29=261, left=192)
        loc_oPagina.AddObject("lbl_4c_Cnf", "Label")
        WITH loc_oPagina.lbl_4c_Cnf
            .Caption   = "Cupom n" + CHR(227) + "o Fiscal :"
            .Top       = 261
            .Left      = 192
            .Width     = 115
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Cupom nao Fiscal (Getcnf: original top=229 -> +29=258, left=312, width=50)
        loc_oPagina.AddObject("txt_4c_Cnf", "TextBox")
        WITH loc_oPagina.txt_4c_Cnf
            .Value     = ""
            .Top       = 258
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 6
            .Visible   = .T.
        ENDWITH

        *-- Label Relatorios Gerenciais (Say4: original top=259 -> +29=288, left=171)
        loc_oPagina.AddObject("lbl_4c_Rg", "Label")
        WITH loc_oPagina.lbl_4c_Rg
            .Caption   = "Relat" + CHR(243) + "rios Gerenciais :"
            .Top       = 288
            .Left      = 171
            .Width     = 135
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Relatorios Gerenciais (Getrg: original top=256 -> +29=285, left=312, width=50)
        loc_oPagina.AddObject("txt_4c_Rg", "TextBox")
        WITH loc_oPagina.txt_4c_Rg
            .Value     = ""
            .Top       = 285
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 6
            .Visible   = .T.
        ENDWITH

        *-- Label Demonstrativo Credito/Debito (Say5: original top=286 -> +29=315, left=92)
        loc_oPagina.AddObject("lbl_4c_Dcd", "Label")
        WITH loc_oPagina.lbl_4c_Dcd
            .Caption   = "Demonstrativo de Cr" + CHR(233) + "dito e D" + CHR(233) + "bito :"
            .Top       = 315
            .Left      = 92
            .Width     = 215
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Demonstrativo (Getdcd: original top=283 -> +29=312, left=312, width=38)
        loc_oPagina.AddObject("txt_4c_Dcd", "TextBox")
        WITH loc_oPagina.txt_4c_Dcd
            .Value     = ""
            .Top       = 312
            .Left      = 312
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 4
            .Visible   = .T.
        ENDWITH

        *-- Label Reducao Z (Say6: original top=313 -> +29=342, left=231)
        loc_oPagina.AddObject("lbl_4c_Rz", "Label")
        WITH loc_oPagina.lbl_4c_Rz
            .Caption   = "Redu" + CHR(231) + CHR(227) + "o Z :"
            .Top       = 342
            .Left      = 231
            .Width     = 75
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Reducao Z (Getrz: original top=310 -> +29=339, left=312, width=50)
        loc_oPagina.AddObject("txt_4c_Rz", "TextBox")
        WITH loc_oPagina.txt_4c_Rz
            .Value     = ""
            .Top       = 339
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 6
            .Visible   = .T.
        ENDWITH

        *-- Label Tipo de Documento (Say7: original top=340 -> +29=369, left=181)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Caption   = "Tipo de Documento :"
            .Top       = 369
            .Left      = 181
            .Width     = 125
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Tipo de Documento (Gettipo: original top=337 -> +29=366, left=312, width=24)
        loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
        WITH loc_oPagina.txt_4c_Tipo
            .Value     = ""
            .Top       = 366
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 2
            .Visible   = .T.
        ENDWITH

        *-- Label Data do Movimento (Say23: original top=367 -> +29=396, left=181)
        loc_oPagina.AddObject("lbl_4c_Dtmov", "Label")
        WITH loc_oPagina.lbl_4c_Dtmov
            .Caption   = "Data do Movimento :"
            .Top       = 396
            .Left      = 181
            .Width     = 125
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data do Movimento (Getdtmov: original top=364 -> +29=393; cdatas=YYYYMMDD string)
        loc_oPagina.AddObject("txt_4c_Dtmov", "TextBox")
        WITH loc_oPagina.txt_4c_Dtmov
            .Value   = DATE()
            .Top     = 393
            .Left    = 312
            .Width   = 80
            .Height  = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        *-- Label Hora do Movimento (Say24: original top=394 -> +29=423, left=181)
        loc_oPagina.AddObject("lbl_4c_Hrmov", "Label")
        WITH loc_oPagina.lbl_4c_Hrmov
            .Caption   = "Hora do Movimento :"
            .Top       = 423
            .Left      = 181
            .Width     = 125
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Hora do Movimento (Gethrmov: original top=391 -> +29=420; choras=HHMMSS string)
        loc_oPagina.AddObject("txt_4c_Hrmov", "TextBox")
        WITH loc_oPagina.txt_4c_Hrmov
            .Value     = ""
            .Top       = 420
            .Left      = 312
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 8
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs botoes Page2 (PUBLIC methods)
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- BINDEVENTs formatadores e lookups de campos Page2
        BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ValidarModelo")
        BINDEVENT(loc_oPagina.txt_4c_Coo,    "LostFocus", THIS, "FormatarCoo")
        BINDEVENT(loc_oPagina.txt_4c_Cnf,    "LostFocus", THIS, "FormatarCnf")
        BINDEVENT(loc_oPagina.txt_4c_Rg,     "LostFocus", THIS, "FormatarRg")
        BINDEVENT(loc_oPagina.txt_4c_Dcd,    "LostFocus", THIS, "FormatarDcd")
        BINDEVENT(loc_oPagina.txt_4c_Rz,     "LostFocus", THIS, "FormatarRz")
        BINDEVENT(loc_oPagina.txt_4c_Tipo,   "KeyPress", THIS, "ValidarTipo")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca registros via BO e configura o grid
    * Le filtros de Page1, chama Buscar(), monta colunas do grid
    *==========================================================================
    FUNCTION CarregarLista()
        LOCAL loc_lResultado, loc_oPg1, loc_oGrid
        LOCAL loc_cSerifab, loc_dDtini, loc_dDtfim
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cserifab C(20), ;
                    cmarcas C(20), cmodelos C(20), ccoos C(6), cdatas C(8), ;
                    choras C(6), ctipos C(3), cincmans C(1))
                loc_lResultado = .T.
            ELSE
                loc_oPg1 = THIS.pgf_4c_Paginas.Page1
                loc_oGrid = loc_oPg1.grd_4c_Lista

                *-- Ler filtros atuais
                loc_cSerifab = ""
                loc_dDtini   = {}
                loc_dDtfim   = {}

                IF PEMSTATUS(loc_oPg1, "txt_4c_SerieFab", 5)
                    loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Dtini", 5)
                    IF VARTYPE(loc_oPg1.txt_4c_Dtini.Value) = "D"
                        loc_dDtini = loc_oPg1.txt_4c_Dtini.Value
                    ENDIF
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Dtfim", 5)
                    IF VARTYPE(loc_oPg1.txt_4c_Dtfim.Value) = "D"
                        loc_dDtfim = loc_oPg1.txt_4c_Dtfim.Value
                    ENDIF
                ENDIF

                IF THIS.this_oBusinessObject.Buscar(loc_cSerifab, loc_dDtini, loc_dDtfim)
                    *-- RecordSource e ColumnCount FORA do WITH para garantir criacao das colunas
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 8

                    WITH loc_oGrid
                        .Column1.ControlSource    = "cursor_4c_Dados.cserifab"
                        .Column1.Width            = 120
                        .Column1.Header1.Caption  = "S" + CHR(233) + "rie"
                        .Column1.ReadOnly         = .T.

                        .Column2.ControlSource    = "cursor_4c_Dados.cmarcas"
                        .Column2.Width            = 120
                        .Column2.Header1.Caption  = "Marca"
                        .Column2.ReadOnly         = .T.

                        .Column3.ControlSource    = "cursor_4c_Dados.cmodelos"
                        .Column3.Width            = 100
                        .Column3.Header1.Caption  = "Modelo"
                        .Column3.ReadOnly         = .T.

                        .Column4.ControlSource    = "cursor_4c_Dados.ccoos"
                        .Column4.Width            = 60
                        .Column4.Header1.Caption  = "COO"
                        .Column4.ReadOnly         = .T.

                        .Column5.ControlSource    = "cursor_4c_Dados.cdatas"
                        .Column5.Width            = 80
                        .Column5.Header1.Caption  = "Data"
                        .Column5.ReadOnly         = .T.

                        .Column6.ControlSource    = "cursor_4c_Dados.choras"
                        .Column6.Width            = 60
                        .Column6.Header1.Caption  = "Hora"
                        .Column6.ReadOnly         = .T.

                        .Column7.ControlSource    = "cursor_4c_Dados.ctipos"
                        .Column7.Width            = 60
                        .Column7.Header1.Caption  = "Tipo"
                        .Column7.ReadOnly         = .T.

                        .Column8.ControlSource    = "cursor_4c_Dados.cincmans"
                        .Column8.Width            = 60
                        .Column8.Header1.Caption  = "Inc.Man."
                        .Column8.ReadOnly         = .T.
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormLGR.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Modelo.SetFocus
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cIdChaves = ALLTRIM(cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    * Regra do legado: so permite alterar registros com cincmans='M' (manual)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cIdChaves, loc_cIncMans
        loc_cIdChaves = ""
        loc_cIncMans  = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cIdChaves = ALLTRIM(cidchaves)
        loc_cIncMans  = ALLTRIM(cincmans)

        IF loc_cIncMans <> "M"
            MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
                     "do manualmente, n" + CHR(227) + "o pode ser Alterado.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado (somente inclusao manual)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cIdChaves, loc_cIncMans
        loc_cIdChaves = ""
        loc_cIncMans  = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cIdChaves = ALLTRIM(cidchaves)
        loc_cIncMans  = ALLTRIM(cincmans)

        IF loc_cIncMans <> "M"
            MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
                     "do manualmente, n" + CHR(227) + "o pode ser Exclu" + CHR(237) + "do.", "Aviso")
            RETURN
        ENDIF

        IF MsgConfirma("Deseja excluir este registro?", "Confirma" + CHR(231) + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Executa busca com os filtros preenchidos em Page1
    * Valida que serie foi informada (conforme legado)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPg1, loc_cSerifab
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)

        IF EMPTY(loc_cSerifab)
            MsgAviso("Informe a S" + CHR(233) + "rie de Fabrica" + CHR(231) + ;
                     CHR(227) + "o e as datas para pesquisar.", "Aviso")
            loc_oPg1.txt_4c_SerieFab.SetFocus
            RETURN
        ENDIF

        IF EMPTY(loc_oPg1.txt_4c_Dtini.Value) OR EMPTY(loc_oPg1.txt_4c_Dtfim.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo de datas para pesquisar.", "Aviso")
            RETURN
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva registro (INSERT ou UPDATE via BO)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes de UI antes do TRY (nao usar RETURN dentro de TRY)
        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Modelo.Value))
            MsgAviso("Modelo n" + CHR(227) + "o pode estar em branco.", "Aviso")
            loc_oPg2.txt_4c_Modelo.SetFocus
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg1, loc_oPg2, loc_cHoras
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cModelos = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
            .this_cCoos    = ALLTRIM(loc_oPg2.txt_4c_Coo.Value)
            .this_cGnfs    = ALLTRIM(loc_oPg2.txt_4c_Cnf.Value)
            .this_cGrgs    = ALLTRIM(loc_oPg2.txt_4c_Rg.Value)
            .this_cCdcs    = ALLTRIM(loc_oPg2.txt_4c_Dcd.Value)
            .this_cCrzs    = ALLTRIM(loc_oPg2.txt_4c_Rz.Value)
            .this_cDoctos  = ALLTRIM(loc_oPg2.txt_4c_Tipo.Value)

            *-- Data: TextBox.Value eh Date -> converter para string YYYYMMDD
            IF VARTYPE(loc_oPg2.txt_4c_Dtmov.Value) = "D" AND !EMPTY(loc_oPg2.txt_4c_Dtmov.Value)
                .this_cDatas = DTOS(loc_oPg2.txt_4c_Dtmov.Value)
            ELSE
                .this_cDatas = ""
            ENDIF

            *-- Hora: string HH:MM:SS -> HHMMSS (strip colons)
            loc_cHoras   = STRTRAN(ALLTRIM(loc_oPg2.txt_4c_Hrmov.Value), ":", "")
            .this_cHoras = loc_cHoras

            *-- Inclusao manual flag
            IF THIS.this_cModoAtual = "INCLUIR"
                .this_cIncMans = "M"
                *-- Serie vem do filtro de Page1
                .this_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cDatas, loc_cHoras
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Codigo.Value = .this_cIdChaves
            loc_oPg2.txt_4c_Modelo.Value = .this_cModelos
            loc_oPg2.txt_4c_Coo.Value    = .this_cCoos
            loc_oPg2.txt_4c_Cnf.Value    = .this_cGnfs
            loc_oPg2.txt_4c_Rg.Value     = .this_cGrgs
            loc_oPg2.txt_4c_Dcd.Value    = .this_cCdcs
            loc_oPg2.txt_4c_Rz.Value     = .this_cCrzs
            loc_oPg2.txt_4c_Tipo.Value   = .this_cDoctos

            *-- Data: string YYYYMMDD -> Date (via STOD)
            loc_cDatas = ALLTRIM(.this_cDatas)
            IF LEN(loc_cDatas) = 8
                loc_oPg2.txt_4c_Dtmov.Value = STOD(loc_cDatas)
            ELSE
                loc_oPg2.txt_4c_Dtmov.Value = {}
            ENDIF

            *-- Hora: string HHMMSS -> HH:MM:SS
            loc_cHoras = ALLTRIM(.this_cHoras)
            IF LEN(loc_cHoras) = 6
                loc_oPg2.txt_4c_Hrmov.Value = LEFT(loc_cHoras, 2) + ":" + ;
                                               SUBSTR(loc_cHoras, 3, 2) + ":" + ;
                                               RIGHT(loc_cHoras, 2)
            ELSE
                loc_oPg2.txt_4c_Hrmov.Value = ""
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2 para edicao
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- txt_4c_Codigo (NFAB) sempre ReadOnly
        loc_oPg2.txt_4c_Modelo.ReadOnly = !par_lHabilitar
        loc_oPg2.txt_4c_Coo.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_Cnf.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_Rg.ReadOnly     = !par_lHabilitar
        loc_oPg2.txt_4c_Dcd.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_Rz.ReadOnly     = !par_lHabilitar
        loc_oPg2.txt_4c_Tipo.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_Dtmov.ReadOnly  = !par_lHabilitar
        loc_oPg2.txt_4c_Hrmov.ReadOnly  = !par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value = ""
        loc_oPg2.txt_4c_Modelo.Value = ""
        loc_oPg2.txt_4c_Coo.Value    = "000000"
        loc_oPg2.txt_4c_Cnf.Value    = ""
        loc_oPg2.txt_4c_Rg.Value     = ""
        loc_oPg2.txt_4c_Dcd.Value    = ""
        loc_oPg2.txt_4c_Rz.Value     = ""
        loc_oPg2.txt_4c_Tipo.Value   = ""
        loc_oPg2.txt_4c_Dtmov.Value  = DATE()
        loc_oPg2.txt_4c_Hrmov.Value  = ""
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditar
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditar
        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *==========================================================================
    * ValidarSerieFab - LostFocus do campo serie em Page1
    * Valida serie contra SigFiMpf e abre picker se nao encontrar exato
    *==========================================================================
    PROCEDURE ValidarSerieFab(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1, loc_cSerifab, loc_oBusca
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)

        IF EMPTY(loc_cSerifab)
            RETURN
        ENDIF

        *-- Buscar serie exata em SigFiMpf
        IF THIS.this_oBusinessObject.BuscarImpressoras("a.cimpfabs = " + EscaparSQL(loc_cSerifab))
            IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 1
                SELECT cursor_4c_Impressoras
                loc_oPg1.txt_4c_SerieFab.Value = ALLTRIM(cimpfabs)
                USE IN cursor_4c_Impressoras
                RETURN
            ENDIF
            IF USED("cursor_4c_Impressoras")
                USE IN cursor_4c_Impressoras
            ENDIF
        ENDIF

        *-- Nao encontrou exato: buscar por LIKE e exibir picker
        IF !THIS.this_oBusinessObject.BuscarImpressoras( ;
                "a.cimpfabs LIKE " + EscaparSQL(loc_cSerifab + "%"))
            THIS.this_oBusinessObject.BuscarImpressoras("")
        ELSE
            IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 0
                USE IN cursor_4c_Impressoras
                THIS.this_oBusinessObject.BuscarImpressoras("")
            ENDIF
        ENDIF

        IF USED("cursor_4c_Impressoras")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Impressoras"
                loc_oBusca.DefinirCursor("cursor_4c_Impressoras", "cimpfabs", "cmarcas", ;
                    "S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Mostrar()
                IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                    loc_oPg1.txt_4c_SerieFab.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Impressoras")
                USE IN cursor_4c_Impressoras
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDtini - LostFocus da data inicio (valida tipo Date)
    *==========================================================================
    PROCEDURE ValidarDtini(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg1.txt_4c_Dtini.Value) <> "D"
            loc_oPg1.txt_4c_Dtini.Value = DATE()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDtfim - LostFocus da data fim (valida tipo Date)
    *==========================================================================
    PROCEDURE ValidarDtfim(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg1.txt_4c_Dtfim.Value) <> "D"
            loc_oPg1.txt_4c_Dtfim.Value = DATE()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarModelo - LostFocus do campo modelo em Page2
    * Busca em SigFiMpm e abre picker se nao encontrar exato
    *==========================================================================
    PROCEDURE ValidarModelo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cModelo, loc_oBusca
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cModelo = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)

        IF EMPTY(loc_cModelo) OR !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        *-- Buscar modelo exato em SigFiMpm
        IF THIS.this_oBusinessObject.BuscarModelos("cModelos = " + EscaparSQL(loc_cModelo))
            IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 1
                SELECT cursor_4c_Modelos
                loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(cModelos)
                USE IN cursor_4c_Modelos
                RETURN
            ENDIF
            IF USED("cursor_4c_Modelos")
                USE IN cursor_4c_Modelos
            ENDIF
        ENDIF

        *-- Nao encontrou: buscar por LIKE e exibir picker
        IF !THIS.this_oBusinessObject.BuscarModelos( ;
                "cModelos LIKE " + EscaparSQL(loc_cModelo + "%"))
            THIS.this_oBusinessObject.BuscarModelos("")
        ELSE
            IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 0
                USE IN cursor_4c_Modelos
                THIS.this_oBusinessObject.BuscarModelos("")
            ENDIF
        ENDIF

        IF USED("cursor_4c_Modelos")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Modelos"
                loc_oBusca.DefinirCursor("cursor_4c_Modelos", "cModelos", "cMarcas", "Modelos")
                loc_oBusca.Mostrar()
                IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                    loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Modelos")
                USE IN cursor_4c_Modelos
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarTipo - LostFocus do campo tipo de documento em Page2
    *==========================================================================
    PROCEDURE ValidarTipo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF LEN(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value)) > 2
            loc_oPg2.txt_4c_Tipo.Value = LEFT(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value), 2)
        ENDIF
    ENDPROC

    *==========================================================================
    * FormatarCoo - LostFocus do COO: formata como string numerica 6 digitos
    * Replica comportamento do legado: Transform(VAL(Value), '@L 999999')
    *==========================================================================
    PROCEDURE FormatarCoo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Coo
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarCnf - LostFocus do Cupom nao Fiscal: mesma formatacao
    *==========================================================================
    PROCEDURE FormatarCnf()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Cnf
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarRg - LostFocus do Relatorio Gerencial: mesma formatacao
    *==========================================================================
    PROCEDURE FormatarRg()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Rg
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarDcd - LostFocus do DCD: formata como string numerica 4 digitos
    *==========================================================================
    PROCEDURE FormatarDcd()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Dcd
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 9999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarRz - LostFocus da Reducao Z: formata como string numerica 6 digitos
    *==========================================================================
    PROCEDURE FormatarRz()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Rz
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles do container visiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_nP

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata fonte do grid apos carregar dados
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) <> "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos do form
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
