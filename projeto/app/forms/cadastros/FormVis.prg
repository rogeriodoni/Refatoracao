*==============================================================================
* FormVis.prg - Formulario de Cadastro de Visitas de Representantes
* Migrado de: SigCdVis.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormVis AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Visitas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("VisBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar VisBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormVis.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormVis:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormVis.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Estrutura completa de Page1 (Lista)
    * Cabecalho + botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar) +
    * cnt_4c_Saida (Encerrar) + Grid de listagem
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: Top=1. Com compensacao +29: Top=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op legado)
        *-- Canonico: Left=542, Top=29, Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado - CLAUDE.md regra #10)
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

        *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem de visitas
        *-- Original: Grade.Top=145, Left=28, Width=940, Height=447. Compensacao PageFrame +29: Top=174
        *-- Width=880 (canonico): nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 6
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 174
            .Left               = 26
            .Width              = 880
            .Height             = 447
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
    * Cabecalho + container de botoes de acao vazio (campos/lookups nas proximas fases)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

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

        *-- Label "Data :" (Label7 legado) - Top original 137 + compensacao PageFrame(+29) = 166
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Data :"
            .Top       = 166
            .Left      = 284
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data (getData legado) - Top original 133 + 29 = 162
        loc_oPagina.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPagina.txt_4c_Data
            .Top             = 162
            .Left            = 318
            .Width           = 80
            .Height          = 23
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(0, 0, 0)
            .BorderColor     = RGB(100, 100, 100)
            .SpecialEffect   = 1
            .Value           = {}
            .Visible         = .T.
        ENDWITH

        *-- Label "Grupo :" (Label1 legado) - Top original 165 + 29 = 194
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Grupo :"
            .Top       = 194
            .Left      = 278
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grupo (getGrupo legado) - somente leitura (When retorna .F. sempre)
        *-- Top original 161 + 29 = 190
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Top               = 190
            .Left              = 318
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .SpecialEffect     = 1
            .Value             = ""
            .Enabled           = .F.
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .T.
        ENDWITH

        *-- Label "Representante :" (Label3 legado) - Top original 193 + 29 = 222
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Representante :"
            .Top       = 222
            .Left      = 235
            .Width     = 81
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Representante (getCodCli legado) - Enabled=.F. no dump (fChecaAcesso controla)
        *-- Top original 189 + 29 = 218
        loc_oPagina.AddObject("txt_4c_CodCli", "TextBox")
        WITH loc_oPagina.txt_4c_CodCli
            .Top                = 218
            .Left               = 318
            .Width              = 80
            .Height             = 23
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(0, 0, 0)
            .BorderColor        = RGB(100, 100, 100)
            .SpecialEffect      = 1
            .Value              = ""
            .Enabled            = .F.
            .DisabledBackColor  = RGB(255, 255, 255)
            .Visible            = .T.
        ENDWITH

        *-- TextBox Descricao Representante (getDesCli legado) - somente leitura (preenchido via lookup)
        *-- Top original 189 + 29 = 218
        loc_oPagina.AddObject("txt_4c_DesCli", "TextBox")
        WITH loc_oPagina.txt_4c_DesCli
            .Top                = 218
            .Left               = 402
            .Width              = 360
            .Height             = 23
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(0, 0, 0)
            .BorderColor        = RGB(100, 100, 100)
            .SpecialEffect      = 1
            .Alignment          = 0
            .Value              = ""
            .Enabled            = .F.
            .DisabledBackColor  = RGB(255, 255, 255)
            .Visible            = .T.
        ENDWITH

        *-- Label "Conta :" (Label2 legado) - Top original 221 + 29 = 250
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Conta :"
            .Top       = 250
            .Left      = 278
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Conta (getCodCta legado) - Top original 217 + 29 = 246
        loc_oPagina.AddObject("txt_4c_CodCta", "TextBox")
        WITH loc_oPagina.txt_4c_CodCta
            .Top             = 246
            .Left            = 318
            .Width           = 80
            .Height          = 23
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(0, 0, 0)
            .BorderColor     = RGB(100, 100, 100)
            .SpecialEffect   = 1
            .Value           = ""
            .Visible         = .T.
        ENDWITH

        *-- TextBox Descricao Conta (getDesCta legado) - preenchido via lookup
        *-- Top original 217 + 29 = 246
        loc_oPagina.AddObject("txt_4c_DesCta", "TextBox")
        WITH loc_oPagina.txt_4c_DesCta
            .Top             = 246
            .Left            = 402
            .Width           = 360
            .Height          = 23
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(0, 0, 0)
            .BorderColor     = RGB(100, 100, 100)
            .SpecialEffect   = 1
            .Value           = ""
            .Visible         = .T.
        ENDWITH

        *-- Label "Vendas :" (Label4 legado) - Top original 249 + 29 = 278
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Vendas :"
            .Top       = 278
            .Left      = 272
            .Width     = 44
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Vendas (optVenda legado) - Sim/Nao, Value=2 (Nao) por padrao
        *-- Top original 243 + 29 = 272
        loc_oPagina.AddObject("opt_4c_Vendas", "OptionGroup")
        WITH loc_oPagina.opt_4c_Vendas
            .ButtonCount = 2
            .Top         = 272
            .Left        = 314
            .Width       = 92
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 47
                .Top       = 5
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Label "Pedidos :" (Label5 legado) - Top original 275 + 29 = 304
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Pedidos :"
            .Top       = 304
            .Left      = 270
            .Width     = 46
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Pedidos (optPedido legado) - Sim/Nao, Value=2 (Nao) por padrao
        *-- Top original 269 + 29 = 298
        loc_oPagina.AddObject("opt_4c_Pedidos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Pedidos
            .ButtonCount = 2
            .Top         = 298
            .Left        = 314
            .Width       = 92
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 47
                .Top       = 5
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Label "Observacao :" (Label6 legado) - Top original 302 + 29 = 331
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 331
            .Left      = 249
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- EditBox Observacao (edtObs legado) - Top original 302 + 29 = 331
        loc_oPagina.AddObject("edt_4c_Obs", "EditBox")
        WITH loc_oPagina.edt_4c_Obs
            .Top           = 331
            .Left          = 317
            .Width         = 446
            .Height        = 109
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Container BotoesAcao (Grupo_Salva legado)
        *-- Canonico: Top=33, Left=842, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva legado)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Lookups (F4/DblClick) - Representante (Codigo/Nome) e Conta (Codigo/Nome)
        *-- Original: getCodCli.Valid / getDesCli.Valid / getCodCta.Valid / getDesCta.Valid (fwBuscaExt em SigCdCli)
        BINDEVENT(loc_oPagina.txt_4c_CodCli, "KeyPress", THIS, "CodCliKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CodCli, "DblClick", THIS, "CodCliDblClick")
        BINDEVENT(loc_oPagina.txt_4c_DesCli, "KeyPress", THIS, "DesCliKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DesCli, "DblClick", THIS, "DesCliDblClick")
        BINDEVENT(loc_oPagina.txt_4c_CodCta, "KeyPress", THIS, "CodCtaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CodCta, "DblClick", THIS, "CodCtaDblClick")
        BINDEVENT(loc_oPagina.txt_4c_DesCta, "KeyPress", THIS, "DesCtaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DesCta, "DblClick", THIS, "DesCtaDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 (cursor_4c_Dados)
    * Colunas espelham EXATAMENTE o AddCursor/pColuna do legado (SigCdVis.Init):
    * Datas, Repr, Iclis, Descri, DescVendas, DescPedidos
    * PUBLIC: chamado direto por TesteAutomatico.prg (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH - Problema 36)
                loc_oGrid.ColumnCount = 6
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Repr"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Iclis"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Descri"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DescVendas"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.DescPedidos"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 150
                loc_oGrid.Column3.Width = 80
                loc_oGrid.Column4.Width = 150
                loc_oGrid.Column5.Width = 31
                loc_oGrid.Column6.Width = 31

                *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption = "Data"
                loc_oGrid.Column2.Header1.Caption = "Representante"
                loc_oGrid.Column3.Header1.Caption = "Conta"
                loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column5.Header1.Caption = "Venda"
                loc_oGrid.Column6.Header1.Caption = "Pedido"

                *-- Problema (a): popular cursor NAO repinta a grade sozinho
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormVis.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    * PUBLIC: chamado direto por TesteAutomatico.prg (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
                "FormVis.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Abre Page2 para incluir novo registro
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17 / regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkidchave)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar registro selecionado
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkidchave)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkidchave)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da visita selecionada?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre picker para localizar registro na lista
    * Apos selecao, posiciona o cursor no registro encontrado (LOCATE)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdVis", "cursor_4c_BuscaVis", "pkidchave", "", ;
                "Buscar Visita")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("datas", "", "Data")
                loc_oBusca.mAddColuna("iclis", "", "Conta")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVis")
                    SELECT cursor_4c_BuscaVis
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaVis.pkidchave)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaVis")
                USE IN cursor_4c_BuscaVis
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(pkidchave) == loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormVis.BtnBuscarClick")
            IF USED("cursor_4c_BuscaVis")
                USE IN cursor_4c_BuscaVis
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados do Form (Page2) para o Business Object
    * OptionGroup Vendas/Pedidos: Value=1 (Sim) -> coluna 1; Value=2 (Nao) -> coluna 0
    * (CLAUDE.md - OptionGroup.Value SEMPRE numerico, nao confundir com o flag da coluna)
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_dData       = loc_oPagina.txt_4c_Data.Value
            .this_cGrupo      = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            .this_cContas     = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)
            .this_cConta      = ALLTRIM(loc_oPagina.txt_4c_CodCta.Value)
            .this_nVendas     = IIF(loc_oPagina.opt_4c_Vendas.Value = 1, 1, 0)
            .this_nPedidos    = IIF(loc_oPagina.opt_4c_Pedidos.Value = 1, 1, 0)
            .this_cObservacao = ALLTRIM(loc_oPagina.edt_4c_Obs.Value)
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do Business Object para o Form (Page2)
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPagina.txt_4c_Data.Value    = .this_dData
            loc_oPagina.txt_4c_Grupo.Value   = .this_cGrupo
            loc_oPagina.txt_4c_CodCli.Value  = .this_cContas
            loc_oPagina.txt_4c_CodCta.Value  = .this_cConta
            loc_oPagina.opt_4c_Vendas.Value  = IIF(.this_nVendas = 1, 1, 2)
            loc_oPagina.opt_4c_Pedidos.Value = IIF(.this_nPedidos = 1, 1, 2)
            loc_oPagina.edt_4c_Obs.Value     = .this_cObservacao
        ENDWITH

        *-- Descricoes (Nome do Representante/Conta) nao vem do BO (SELECT so em SigCdVis)
        *-- Recarrega via lookup exato pelo codigo, espelhando SIGCDVIS.Pagina.Lista.Grupo_Op.Click
        THIS.AtualizarDescricaoRepresentante()
        THIS.AtualizarDescricaoConta()
    ENDPROC

    *===========================================================================
    * AtualizarDescricaoRepresentante - Busca o nome (rclis) do Representante
    * atual (txt_4c_CodCli) em SigCdCli, espelhando o SELECT feito pelo legado
    * em Grupo_Op.Click nos modos ALTERAR/VISUALIZAR/EXCLUIR
    *===========================================================================
    PROTECTED PROCEDURE AtualizarDescricaoRepresentante()
        LOCAL loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResultado
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_DesCli.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescRepr")

            IF loc_nResultado >= 0 AND USED("cursor_4c_DescRepr") AND !EOF("cursor_4c_DescRepr")
                loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(TratarNulo(cursor_4c_DescRepr.rclis, "C"))
            ELSE
                loc_oPagina.txt_4c_DesCli.Value = ""
            ENDIF

            IF USED("cursor_4c_DescRepr")
                USE IN cursor_4c_DescRepr
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do representante:" + CHR(13) + ;
                loException.Message, "FormVis.AtualizarDescricaoRepresentante")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AtualizarDescricaoConta - Busca o nome (rclis) da Conta atual (txt_4c_CodCta)
    * em SigCdCli, espelhando o SELECT feito pelo legado em Grupo_Op.Click
    *===========================================================================
    PROTECTED PROCEDURE AtualizarDescricaoConta()
        LOCAL loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResultado
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CodCta.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_DesCta.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescConta")

            IF loc_nResultado >= 0 AND USED("cursor_4c_DescConta") AND !EOF("cursor_4c_DescConta")
                loc_oPagina.txt_4c_DesCta.Value = ALLTRIM(TratarNulo(cursor_4c_DescConta.rclis, "C"))
            ELSE
                loc_oPagina.txt_4c_DesCta.Value = ""
            ENDIF

            IF USED("cursor_4c_DescConta")
                USE IN cursor_4c_DescConta
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o da conta:" + CHR(13) + ;
                loException.Message, "FormVis.AtualizarDescricaoConta")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma a inclusao/alteracao (Grupo_Salva.Salva legado)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela a inclusao/alteracao e volta para a lista
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * Lookups Page2 - Representante (Codigo/Nome) via SigCdCli.iclis/rclis
    * Original: getCodCli.Valid / getDesCli.Valid (fwBuscaExt), filtrado por
    * Grupos = antgru quando o Grupo atual do form estiver preenchido
    *===========================================================================
    PROCEDURE CodCliKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupRepresentantePorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE CodCliDblClick()
        THIS.AbrirLookupRepresentantePorCodigo()
    ENDPROC

    PROCEDURE DesCliKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupRepresentantePorNome()
        ENDIF
    ENDPROC

    PROCEDURE DesCliDblClick()
        THIS.AbrirLookupRepresentantePorNome()
    ENDPROC

    PROCEDURE AbrirLookupRepresentantePorCodigo()
        LOCAL loc_oPagina, loc_oBusca, loc_cGrupo, loc_cFiltro, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_CodCli.Enabled
            RETURN
        ENDIF

        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "Grupos = " + EscaparSQL(loc_cGrupo), "")
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaRepr", "iclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Representante", .T., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
                    SELECT cursor_4c_BuscaRepr
                    loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
                    loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaRepr")
                USE IN cursor_4c_BuscaRepr
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar representante:" + CHR(13) + loException.Message, ;
                "FormVis.AbrirLookupRepresentantePorCodigo")
            IF USED("cursor_4c_BuscaRepr")
                USE IN cursor_4c_BuscaRepr
            ENDIF
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupRepresentantePorNome()
        LOCAL loc_oPagina, loc_oBusca, loc_cGrupo, loc_cFiltro, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_CodCli.Enabled
            RETURN
        ENDIF

        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "Grupos = " + EscaparSQL(loc_cGrupo), "")
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaRepr", "rclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Representante", .T., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
                    SELECT cursor_4c_BuscaRepr
                    loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
                    loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaRepr")
                USE IN cursor_4c_BuscaRepr
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar representante:" + CHR(13) + loException.Message, ;
                "FormVis.AbrirLookupRepresentantePorNome")
            IF USED("cursor_4c_BuscaRepr")
                USE IN cursor_4c_BuscaRepr
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * Lookups Page2 - Conta (Codigo/Nome) via SigCdCli.iclis/rclis (sem filtro)
    * Original: getCodCta.Valid / getDesCta.Valid (fwBuscaExt)
    *===========================================================================
    PROCEDURE CodCtaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupContaPorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE CodCtaDblClick()
        THIS.AbrirLookupContaPorCodigo()
    ENDPROC

    PROCEDURE DesCtaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupContaPorNome()
        ENDIF
    ENDPROC

    PROCEDURE DesCtaDblClick()
        THIS.AbrirLookupContaPorNome()
    ENDPROC

    PROCEDURE AbrirLookupContaPorCodigo()
        LOCAL loc_oPagina, loc_oBusca, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_CodCta.Enabled
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CodCta.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "iclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Contas", .T.)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    loc_oPagina.txt_4c_CodCta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                    loc_oPagina.txt_4c_DesCta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar conta:" + CHR(13) + loException.Message, ;
                "FormVis.AbrirLookupContaPorCodigo")
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupContaPorNome()
        LOCAL loc_oPagina, loc_oBusca, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_CodCta.Enabled
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oPagina.txt_4c_DesCta.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "rclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Contas", .T.)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    loc_oPagina.txt_4c_DesCta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
                    loc_oPagina.txt_4c_CodCta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar conta:" + CHR(13) + loException.Message, ;
                "FormVis.AbrirLookupContaPorNome")
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa valores de Page2 para novo registro (BtnIncluirClick)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        WITH loc_oPagina
            .txt_4c_Data.Value     = {}
            .txt_4c_Grupo.Value    = ""
            .txt_4c_CodCli.Value   = ""
            .txt_4c_DesCli.Value   = ""
            .txt_4c_CodCta.Value   = ""
            .txt_4c_DesCta.Value   = ""
            .opt_4c_Vendas.Value   = 2
            .opt_4c_Pedidos.Value  = 2
            .edt_4c_Obs.Value      = ""
        ENDWITH
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos de Page2 conforme o modo
    * Espelha os eventos When do legado (comportamento.json):
    *   - getGrupo: sempre desabilitado (When = Return .f.)
    *   - getCodCli/getDesCli: apenas em INCLUIR (When restringe a INSERIR/PROCURAR)
    *   - getCodCta/getDesCta, optVenda, optPedido, edtObs: INCLUIR ou ALTERAR
    *     (When = Inlist(pcEscolha, "INSERIR", "ALTERAR")/"...PROCURAR")
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lCodCliHabilitado
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lCodCliHabilitado = par_lHabilitar AND THIS.this_cModoAtual == "INCLUIR"

        WITH loc_oPagina
            .txt_4c_Data.Enabled      = par_lHabilitar
            .txt_4c_Grupo.Enabled     = .F.
            .txt_4c_CodCli.Enabled    = loc_lCodCliHabilitado
            .txt_4c_DesCli.Enabled    = loc_lCodCliHabilitado
            .txt_4c_CodCta.Enabled    = par_lHabilitar
            .txt_4c_DesCta.Enabled    = par_lHabilitar
            .opt_4c_Vendas.Enabled    = par_lHabilitar
            .opt_4c_Pedidos.Enabled   = par_lHabilitar
            .edt_4c_Obs.Enabled       = par_lHabilitar
        ENDWITH
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta cnt_4c_BotoesAcao conforme o modo atual
    * Confirmar: habilitado em INCLUIR/ALTERAR, desabilitado em VISUALIZAR
    * Cancelar: sempre habilitado (permite voltar para a lista)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lPodeConfirmar
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
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

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormVis.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Destroy - Libera Business Object e cursores abertos pelo form
    *===========================================================================
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
