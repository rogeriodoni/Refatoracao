*------------------------------------------------------------------------------
* FormCol.prg - Formulario de Cadastro de Grupo de Venda
* Tabela: SigCdCol | Herda de: FormBase
* Fase 7/8 - Eventos principais CRUD - COMPLETO
*------------------------------------------------------------------------------

DEFINE CLASS FormCol AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Grupo de Venda"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 1

    *-- Propriedades de controle
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ColBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar ColBO", "FormCol.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormCol:" + CHR(13) + loc_oErro.Message, "FormCol.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o PageFrame principal com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            THIS.pgf_4c_Paginas.Top       = -29
            THIS.pgf_4c_Paginas.Left      = 0
            THIS.pgf_4c_Paginas.Width     = 1000
            THIS.pgf_4c_Paginas.Height    = 629
            THIS.pgf_4c_Paginas.PageCount = 2
            THIS.pgf_4c_Paginas.Tabs      = .F.
            THIS.pgf_4c_Paginas.Visible   = .T.

            WITH THIS.pgf_4c_Paginas
                .Page1.Caption  = "Lista"
                .Page1.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page2.Caption  = "Dados"
                .Page2.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar PageFrame:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (lista de registros)
    * Cabecalho, botoes CRUD, grid e saida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Cabecalho cinza (cntSombra legado: Top=1, Left=-1, Width=1008, Height=80)
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 30
                .Left        = 0
                .Width       = 1000
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption   = "Cadastro de Grupo de Venda"
                    .Top       = 15
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Caption   = "Cadastro de Grupo de Venda"
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- Container botoes CRUD (Grupo_op legado: Left=543, Top=-1, Width=385, Height=85)
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 28
                .Left        =  542
                .Width       = 385
                .Height      = 85
                .BackColor   = RGB(53, 53, 53)
                .BackStyle   = 1
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *-- Container saida - PADRAO CANONICO (prevalece sobre PILAR 1)
            *-- Legado: Grupo_Saida.Left=918, Top=-1; Canonico: Left=917, Width=90
            loc_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPagina.cnt_4c_Saida
                .Top         = 29
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Encerrar", "CommandButton")
                WITH .cmd_4c_Encerrar
                    .Caption         = "Encerrar"
                    .Top             = 5
                    .Left            = 917
                    .Width           = 90
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *-- Grid de listagem (colecoes=79, descs=290, codcols=75 - do legado Init)
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oPagina.grd_4c_Lista.Top              = 117
            loc_oPagina.grd_4c_Lista.Left             = 26
            loc_oPagina.grd_4c_Lista.Width            = 890
            loc_oPagina.grd_4c_Lista.Height           = 498
            loc_oPagina.grd_4c_Lista.ColumnCount      = 3
            WITH loc_oPagina.grd_4c_Lista
                .FontName             = "Verdana"
                .FontSize             = 8
                .ForeColor            = RGB(90, 90, 90)
                .BackColor            = RGB(255, 255, 255)
                .GridLineColor        = RGB(238, 238, 238)
                .GridLines            = 3
                .HighlightBackColor   = RGB(255, 255, 255)
                .HighlightForeColor   = RGB(15, 41, 104)
                .HighlightStyle       = 2
                .DeleteMark           = .F.
                .RecordMark           = .F.
                .RowHeight            = 16
                .ScrollBars           = 2
                .Visible              = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page Lista:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (campos de edicao)
    * Fase 3: container salvar/cancelar
    * Fase 5: campos principais (getColecoes, getDescs, getUsuars, getDtInicial)
    * Fase 6: OptionGroups (optConProds, optAltProds), getAgrupa - COMPLETO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container salvar/cancelar (Grupo_Salva legado: Left=820, Top=8, Width=160)
            loc_oPagina.AddObject("cnt_4c_Salva", "Container")
            WITH loc_oPagina.cnt_4c_Salva
                .Top         = 37
                .Left        = 820
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Confirmar", "CommandButton")
                WITH .cmd_4c_Confirmar
                    .Caption         = "Confirmar"
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
                    .Caption         = "Encerrar"
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            *-- Label "Grupo :" (Say1: Top=127, Left=324, compensacao +29 = 156)
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "Grupo :"
                .Top       = 156
                .Left      = 324
                .Width     = 38
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Colecoes (getColecoes: Top=123, Left=366, Width=79, compensacao +29 = 152)
            *-- Editavel apenas em INCLUIR (getColecoes.When = INSERIR no legado)
            loc_oPagina.AddObject("txt_4c_Colecoes", "TextBox")
            WITH loc_oPagina.txt_4c_Colecoes
                .Top           = 152
                .Left          = 366
                .Width         = 79
                .Height        = 25
                .InputMask     = "XXXXXXXXXX"
                .MaxLength     = 10
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label "Descricao :" (Say2: Top=155, Left=307, compensacao +29 = 184)
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 184
                .Left      = 307
                .Width     = 55
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Descricao (getDescs: Top=151, Left=366, Width=289, compensacao +29 = 180)
            loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
            WITH loc_oPagina.txt_4c_Descricao
                .Top           = 180
                .Left          = 366
                .Width         = 289
                .Height        = 25
                .InputMask     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
                .MaxLength     = 40
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label "Usuario :" (Say7: Top=183, Left=317, compensacao +29 = 212)
            loc_oPagina.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPagina.lbl_4c_Label7
                .Caption   = "Usu" + CHR(225) + "rio :"
                .Top       = 212
                .Left      = 317
                .Width     = 45
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Usuars (getUsuars: Top=179, Left=366, Width=80, compensacao +29 = 208)
            *-- Lookup para SigCdUsu via ValidarUsuars (equivalente ao Valid/fwBuscaExt do legado)
            loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
            WITH loc_oPagina.txt_4c_Usuars
                .Top           = 208
                .Left          = 366
                .Width         = 80
                .Height        = 25
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label "Data de Inicio :" (Say8: Top=211, Left=287, compensacao +29 = 240)
            loc_oPagina.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPagina.lbl_4c_Label8
                .Caption   = "Data de In" + CHR(237) + "cio :"
                .Top       = 240
                .Left      = 287
                .Width     = 75
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox DtInicial (getDtInicial: Top=207, Left=366, compensacao +29 = 236)
            *-- Tipo datetime; auto-setado pelo BO no INSERT
            loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
            WITH loc_oPagina.txt_4c_DtInicial
                .Top           = 236
                .Left          = 366
                .Width         = 100
                .Height        = 25
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "D"
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- Label "Consulta de Produtos :" (Say5: Top=238, Left=250, compensacao +29 = 267)
            loc_oPagina.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPagina.lbl_4c_Label5
                .Caption   = "Consulta de Produtos :"
                .Top       = 267
                .Left      = 250
                .Width     = 112
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup optConProds (Top=235, Left=362, Width=95, Height=25, comp +29 = 264)
            *-- S (Sim=1) / N (Nao=0) -> mapeado em this_nConprods; Value=1->S, Value=2->N
            loc_oPagina.AddObject("opt_4c_ConProds", "OptionGroup")
            WITH loc_oPagina.opt_4c_ConProds
                .ButtonCount = 2
                .Top         = 264
                .Left        = 362
                .Width       = 95
                .Height      = 25
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption   = "S"
                    .Left      = 5
                    .Top       = 5
                    .Width     = 40
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N"
                    .Left      = 48
                    .Top       = 5
                    .Width     = 40
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            *-- Label "Alertar ao Alterar Produtos :" (Say6: Top=260, Left=223, comp +29 = 289)
            loc_oPagina.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPagina.lbl_4c_Label6
                .Caption   = "Alertar ao Alterar Produtos :"
                .Top       = 289
                .Left      = 223
                .Width     = 139
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup optAltProds (Top=255, Left=362, Width=95, Height=25, comp +29 = 284)
            *-- S (Sim=1) / N (Nao=0) -> mapeado em this_nAltProds; Value=1->S, Value=2->N
            loc_oPagina.AddObject("opt_4c_AltProds", "OptionGroup")
            WITH loc_oPagina.opt_4c_AltProds
                .ButtonCount = 2
                .Top         = 284
                .Left        = 362
                .Width       = 95
                .Height      = 25
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption   = "S"
                    .Left      = 5
                    .Top       = 5
                    .Width     = 40
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N"
                    .Left      = 48
                    .Top       = 5
                    .Width     = 40
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            *-- Label "Agrupamento :" (Say9: Top=285, Left=288, comp +29 = 314)
            loc_oPagina.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPagina.lbl_4c_Label9
                .Caption   = "Agrupamento :"
                .Top       = 314
                .Left      = 288
                .Width     = 74
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Agrupa (getAgrupa: Top=281, Left=367, Width=79, comp +29 = 310)
            *-- Mapeado em this_cAgrupas (agrupas char(10))
            loc_oPagina.AddObject("txt_4c_Agrupa", "TextBox")
            WITH loc_oPagina.txt_4c_Agrupa
                .Top           = 310
                .Left          = 367
                .Width         = 79
                .Height        = 25
                .MaxLength     = 10
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress", THIS, "ValidarUsuars")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page Dados:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (colecoes C(10), descs C(40), codcols C(1))
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    IF THIS.this_oBusinessObject.Buscar("")
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount = 3
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.colecoes"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codcols"

                        loc_oGrid.Column1.Width = 79
                        loc_oGrid.Column2.Width = 290
                        loc_oGrid.Column3.Width = 75

                        *-- Reconfigurar cabecalhos APOS RecordSource (VFP reseta captions)
                        loc_oGrid.Column1.Header1.Caption = "Grupo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Cod. Coletor"

                        THIS.FormatarGridLista(loc_oGrid)
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormCol.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormCol.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lResultado = .F.
            ELSE
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2

                THIS.this_oBusinessObject.this_cColecoes = ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value)
                THIS.this_oBusinessObject.this_cDescs    = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
                THIS.this_oBusinessObject.this_cUsuars   = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)

                IF VARTYPE(loc_oPg2.txt_4c_DtInicial.Value) = "T" OR ;
                   VARTYPE(loc_oPg2.txt_4c_DtInicial.Value) = "D"
                    THIS.this_oBusinessObject.this_tDtIncs = loc_oPg2.txt_4c_DtInicial.Value
                ENDIF

                THIS.this_oBusinessObject.this_nConprods = IIF(loc_oPg2.opt_4c_ConProds.Value = 1, 1, 0)
                THIS.this_oBusinessObject.this_nAltProds = IIF(loc_oPg2.opt_4c_AltProds.Value = 1, 1, 0)
                THIS.this_oBusinessObject.this_cAgrupas  = ALLTRIM(loc_oPg2.txt_4c_Agrupa.Value)

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "FormCol.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos do Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lResultado = .F.
            ELSE
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2

                loc_oPg2.txt_4c_Colecoes.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cColecoes)
                loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
                loc_oPg2.txt_4c_Usuars.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cUsuars)

                IF !EMPTY(THIS.this_oBusinessObject.this_tDtIncs)
                    loc_oPg2.txt_4c_DtInicial.Value = THIS.this_oBusinessObject.this_tDtIncs
                ELSE
                    loc_oPg2.txt_4c_DtInicial.Value = {}
                ENDIF

                loc_oPg2.opt_4c_ConProds.Value = IIF(THIS.this_oBusinessObject.this_nConprods = 1, 1, 2)
                loc_oPg2.opt_4c_AltProds.Value = IIF(THIS.this_oBusinessObject.this_nAltProds = 1, 1, 2)
                loc_oPg2.txt_4c_Agrupa.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cAgrupas)

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "FormCol.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de edicao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
                loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF

            *-- Colecoes: editavel apenas em INCLUIR (getColecoes.When = INSERIR no legado)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Colecoes", 5)
                loc_oPg2.txt_4c_Colecoes.ReadOnly = ;
                    !par_lHabilitar OR THIS.this_cModoAtual = "ALTERAR"
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.ReadOnly = !par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Usuars", 5)
                loc_oPg2.txt_4c_Usuars.ReadOnly = !par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_DtInicial", 5)
                loc_oPg2.txt_4c_DtInicial.ReadOnly = !par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "opt_4c_ConProds", 5)
                loc_oPg2.opt_4c_ConProds.Enabled = par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "opt_4c_AltProds", 5)
                loc_oPg2.opt_4c_AltProds.Enabled = par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Agrupa", 5)
                loc_oPg2.txt_4c_Agrupa.ReadOnly = !par_lHabilitar
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "FormCol.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.NovoRegistro()
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Colecoes", 5)
                loc_oPg2.txt_4c_Colecoes.Value  = ""
                loc_oPg2.txt_4c_Descricao.Value = ""
                loc_oPg2.txt_4c_Usuars.Value    = ""
                loc_oPg2.txt_4c_DtInicial.Value = {}
            ENDIF

            IF PEMSTATUS(loc_oPg2, "opt_4c_ConProds", 5)
                loc_oPg2.opt_4c_ConProds.Value = 2
                loc_oPg2.opt_4c_AltProds.Value = 2
                loc_oPg2.txt_4c_Agrupa.Value   = ""
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "FormCol.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
                    INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "FormCol.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Eventos dos botoes CRUD da Page1
    *--------------------------------------------------------------------------

    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_nResultado, loc_lPodeExcluir
        loc_cCodigo      = ""
        loc_lPodeExcluir = .T.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.")
            RETURN
        ENDIF

        *-- Verificar se existem Produtos usando este Grupo (legado: ChkRegister SigCdPro/Colecoes)
        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT COUNT(*) AS Contador FROM SigCdPro WHERE Colecoes = " + ;
            EscaparSQL(loc_cCodigo), "cursor_4c_ChkPro")
        IF loc_nResultado > 0 AND USED("cursor_4c_ChkPro")
            SELECT cursor_4c_ChkPro
            IF cursor_4c_ChkPro.Contador > 0
                MsgAviso("Existem Produtos Utilizando Esse Grupo de Venda.", ;
                    "Imposs" + CHR(237) + "vel Exclus" + CHR(227) + "o")
                loc_lPodeExcluir = .F.
            ENDIF
            USE IN cursor_4c_ChkPro
        ENDIF

        IF !loc_lPodeExcluir
            RETURN
        ENDIF

        IF MsgConfirma("Deseja excluir este Grupo de Venda?", "Confirmar Exclus" + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Grupo de Venda exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaCol", "colecoes", "", ;
                "Buscar Grupo de Venda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("colecoes", "", "Grupo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("codcols", "", "Cod. Coletor")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
                    SELECT cursor_4c_BuscaCol
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCol.colecoes)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF

            IF !EMPTY(loc_cCodigo)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "FormCol.BtnBuscarClick")
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Evento do botao Confirmar (Salvar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Grupo de Venda salvo com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "FormCol.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Pages de PageFrames e Controls de Containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuars - Valida e busca usuario em SigCdUsu
    * Equivalente ao Valid do getUsuars no legado (fwBuscaExt -> FormBuscaAuxiliar)
    * Disparado via BINDEVENT LostFocus em txt_4c_Usuars
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUsuars(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cUsuars, loc_oPg2, loc_oBusca, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cUsuars = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)

        IF EMPTY(loc_cUsuars)
            RETURN loc_lResultado
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cUsuars, ;
                "Sele" + CHR(231) + CHR(227) + "o", .T., .F., "Not cAtivos='N'")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    *-- Usuario encontrado exatamente
                    IF USED("cursor_4c_BuscaUsu")
                        SELECT cursor_4c_BuscaUsu
                        loc_oPg2.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    *-- Nao encontrado exatamente, mostrar grid de selecao
                    loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        SELECT cursor_4c_BuscaUsu
                        loc_oPg2.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    ELSE
                        loc_oPg2.txt_4c_Usuars.Value = ""
                    ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF

            *-- Auto-setar DtInicial se Usuars foi definido e DtInicial esta vazio (legado: Valid getUsuars)
            loc_cUsuars = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)
            IF !EMPTY(loc_cUsuars) AND EMPTY(loc_oPg2.txt_4c_DtInicial.Value)
                loc_oPg2.txt_4c_DtInicial.Value = DATE()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
            MostrarErro("Erro ao validar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "FormCol.ValidarUsuars")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loc_oErro
            *-- Erros no Destroy sao ignorados para nao bloquear fechamento
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
