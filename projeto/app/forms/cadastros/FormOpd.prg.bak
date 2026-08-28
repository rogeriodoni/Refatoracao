*==============================================================================
* FormOpd.prg - Formulario de Cadastro de Operacoes de Pedido
* Migrado de: SigCdOpd.SCX (frmcadastro)
* Tabela: SigOpPed | BO: OpdBO
*==============================================================================

DEFINE CLASS FormOpd AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = ""
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Cadastro de Opera" + CHR(231) + CHR(245) + "es de Pedido"

            THIS.this_oBusinessObject = CREATEOBJECT("OpdBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar OpdBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormOpd.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormOpd:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormOpd.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; todos os controles compensam +29 no Top
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
    * ConfigurarPaginaLista - Configura Page1 com Grid + botoes CRUD
    * Grid: legado Top=121/Left=12/Width=940; compensacao +29 -> Top=150
    * Botoes canonicos: cnt_4c_Botoes Left=542; cnt_4c_Saida Left=917
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado: Top=1; +29 -> Top=30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
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

        *-- Container Botoes CRUD canonico: Left=542, Top=28 (-1+29), Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container Saida canonico: Left=917, Top=29, Width=90, Height=85
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid da Lista (legado: Top=121, Left=12, Width=940; +29 -> Top=150)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 150
            .Left               = 12
            .Width              = 940
            .Height             = 470
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- ColumnCount fora do WITH para garantir criacao imediata das colunas
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.ColumnCount = 4

        WITH loc_oGrid.Column1
            .Width     = 31
            .ReadOnly  = .T.
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column2
            .Width     = 150
            .ReadOnly  = .T.
            .Alignment = 0
        ENDWITH
        WITH loc_oGrid.Column3
            .Width     = 80
            .ReadOnly  = .T.
            .Alignment = 0
        ENDWITH
        WITH loc_oGrid.Column4
            .Width     = 108
            .ReadOnly  = .T.
            .Alignment = 0
        ENDWITH

        *-- BINDEVENTs para botoes (handlers devem ser PUBLIC)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 com todos os campos e botoes
    * Campos: lbl_4c_OperacaoLabel, txt_4c_Nopes, txt_4c_Dopes,
    *         opt_4c_Pagos (3 buttons), opt_4c_Utils (3 buttons)
    * Botoes: cnt_4c_BotoesAcao -> cmd_4c_Confirmar, cmd_4c_Cancelar
    * Compensacao PageFrame +29 aplicada a todos os Tops
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (grupo_salva: Left=618, Top=11+29=40, Width=160, Height=85)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 40
            .Left        = 618
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (salva: Left=5, Top=5, Width=75, Height=75)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar (cancelar: Left=80, Top=5, Width=75, Height=75)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label Opera??o: (Label3: Top=121+29=150, Left=135, Width=53, Height=15)
        loc_oPagina.AddObject("lbl_4c_OperacaoLabel", "Label")
        WITH loc_oPagina.lbl_4c_OperacaoLabel
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o:"
            .Top       = 150
            .Left      = 135
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Operacao (getnopes: Top=117+29=146, Left=203, Width=37)
        *-- Value=0 (numeric: this_nNdopes); lookup abre em SigCdOpe
        loc_oPagina.AddObject("txt_4c_Nopes", "TextBox")
        WITH loc_oPagina.txt_4c_Nopes
            .Value     = 0
            .Top       = 146
            .Left      = 203
            .Width     = 37
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 1
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Nopes, "KeyPress", THIS, "ValidarNopes")
        BINDEVENT(loc_oPagina.txt_4c_Nopes, "KeyPress", THIS, "NopesKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Nopes, "DblClick", THIS, "NopesDblClick")

        *-- TextBox Descricao Operacao (GetDopes: Top=117+29=146, Left=243, Width=150)
        *-- Value="" (char: this_cDopes = PK de SigOpPed); somente em INCLUIR
        loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPagina.txt_4c_Dopes
            .Value     = ""
            .Top       = 146
            .Left      = 243
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 2
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dopes, "KeyPress", THIS, "ValidarDopes")
        BINDEVENT(loc_oPagina.txt_4c_Dopes, "KeyPress", THIS, "DopesKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Dopes, "DblClick", THIS, "DopesDblClick")

        *-- OptionGroup Pagamentos (OptPagos: Top=143+29=172, Left=198, Width=268, Height=27)
        *-- 1=Pagos, 2=Nao Pagos, 3=Todos
        loc_oPagina.AddObject("opt_4c_Pagos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Pagos
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 172
            .Left        = 198
            .Width       = 268
            .Height      = 27
            .Value       = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Pagos.Buttons(1)
            .Caption   = "Pagos"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Pagos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o Pagos"
            .Left      = 87
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Pagos.Buttons(3)
            .Caption   = "Todos"
            .Left      = 200
            .Top       = 5
            .Height    = 15
            .Width     = 47
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- OptionGroup Utilizacao (OptUtils: Top=164+29=193, Left=198, Width=268, Height=27)
        *-- 1=Utilizados, 2=Nao Utilizados, 3=Todos; default=1 (Utilizados) conforme legado
        loc_oPagina.AddObject("opt_4c_Utils", "OptionGroup")
        WITH loc_oPagina.opt_4c_Utils
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 193
            .Left        = 198
            .Width       = 268
            .Height      = 27
            .Value       = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Utils.Buttons(1)
            .Caption   = "Utilizados"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Utils.Buttons(2)
            .Caption   = "N" + CHR(227) + "o Utilizados"
            .Left      = 87
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Utils.Buttons(3)
            .Caption   = "Todos"
            .Left      = 200
            .Top       = 5
            .Height    = 15
            .Width     = 47
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Busca registros de SigOpPed e vincula ao grid
    * CRITICO: RecordSource, ControlSource e Headers sempre re-definidos apos Buscar
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.this_oBusinessObject.Buscar("")

            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF VARTYPE(loc_oGrid) = "O"
                    *-- RecordSource fora de WITH para garantir auto-bind imediato
                    loc_oGrid.ColumnCount = 4
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    *-- ControlSource re-definido APOS RecordSource (auto-bind sobrescreve)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ndopes"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dopes"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.desc_pagos"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.desc_utils"

                    *-- Larguras re-confirmadas
                    loc_oGrid.Column1.Width = 31
                    loc_oGrid.Column2.Width = 150
                    loc_oGrid.Column3.Width = 80
                    loc_oGrid.Column4.Width = 108

                    *-- Headers re-definidos APOS RecordSource (reset para nome do campo)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Pagamentos"
                    loc_oGrid.Column4.Header1.Caption = "Utilizados"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "FormOpd.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    * Grid sera adicionado na Fase 4
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Iterar Pages E Controls para PageFrames; passar container como param
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
                   UPPER(loc_oObjeto.BaseClass) != "PAGEFRAME"
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    * Quando volta para Page1 recarrega a lista para refletir mudancas
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, ;
                "FormOpd.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Novo registro: limpa BO, vai para Page2 em modo INCLUIR
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        CATCH TO loException
            MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDopes, loc_lPode
        loc_cDopes = ""
        loc_lPode  = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                loc_lPode = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnVisualizarClick")
        ENDTRY

        IF loc_lPode
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
    * CarregarPorCodigo ja seta this_lNovoRegistro = .F.
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cDopes, loc_lPode
        loc_cDopes = ""
        loc_lPode  = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                loc_lPode = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnAlterarClick")
        ENDTRY

        IF loc_lPode
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cDopes, loc_lConfirmado, loc_lExcluido
        loc_cDopes      = ""
        loc_lConfirmado = .F.
        loc_lExcluido   = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)

        loc_lConfirmado = MsgConfirma("Confirma exclus" + CHR(227) + "o da opera" + ;
            CHR(231) + CHR(227) + "o '" + loc_cDopes + "'?", "Excluir")

        IF !loc_lConfirmado
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                loc_lExcluido = THIS.this_oBusinessObject.Excluir()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnExcluirClick")
        ENDTRY

        IF loc_lExcluido
            MsgInfo("Opera" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!")
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega lista (filtro de texto sera adicionado em fase posterior)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Delega validacao ao BO e salva o registro
    * Validacoes completas estao em OpdBO.ValidarDados():
    *   - Dopes nao vazio, tpagos >= 1, tutils >= 1, duplicata em INCLUIR
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.FormParaBO()

        TRY
            loc_lResultado = THIS.this_oBusinessObject.Salvar()
        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnSalvarClick")
        ENDTRY

        IF loc_lResultado
            MsgInfo("Registro salvo com sucesso!")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Descarta alteracoes e volta para Page1 (lista)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores do formulario para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            .this_nNdopes = loc_oPagina2.txt_4c_Nopes.Value
            .this_cDopes  = ALLTRIM(loc_oPagina2.txt_4c_Dopes.Value)
            .this_nTpagos = loc_oPagina2.opt_4c_Pagos.Value
            .this_nTutils = loc_oPagina2.opt_4c_Utils.Value
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Preenche campos do formulario a partir do BO
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            loc_oPagina2.txt_4c_Nopes.Value = .this_nNdopes
            loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(.this_cDopes)
            loc_oPagina2.opt_4c_Pagos.Value = .this_nTpagos
            loc_oPagina2.opt_4c_Utils.Value = .this_nTutils
        ENDWITH
    ENDPROC

    *===========================================================================
    * LimparCampos - Zera todos os campos da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        loc_oPagina2.txt_4c_Nopes.Value = 0
        loc_oPagina2.txt_4c_Dopes.Value = ""
        loc_oPagina2.opt_4c_Pagos.Value = 0
        loc_oPagina2.opt_4c_Utils.Value = 0
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
    * Dopes (PK) somente editavel em INCLUIR; OptionGroups somente em INCLUIR/ALTERAR
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina2, loc_lModoEdicao
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        loc_lModoEdicao = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Nopes: habilitado sempre em INCLUIR/ALTERAR (codigo pode mudar)
        loc_oPagina2.txt_4c_Nopes.ReadOnly = !loc_lModoEdicao

        *-- Dopes (PK): somente editavel em INCLUIR (nao altera PK)
        loc_oPagina2.txt_4c_Dopes.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")

        *-- OptionGroups: somente em INCLUIR/ALTERAR
        loc_oPagina2.opt_4c_Pagos.Enabled = loc_lModoEdicao
        loc_oPagina2.opt_4c_Utils.Enabled = loc_lModoEdicao

        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita Confirmar somente em INCLUIR/ALTERAR
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF
        IF VARTYPE(loc_oPagina2.cnt_4c_BotoesAcao) != "O"
            RETURN
        ENDIF

        LOCAL loc_lSalvar
        loc_lSalvar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lSalvar
        loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * ValidarNopes - Handler de LostFocus do txt_4c_Nopes
    * Busca SigCdOpe por Dopes; se nao achar abre picker
    *===========================================================================
    PROCEDURE ValidarNopes(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina2, loc_cDopes, loc_cSQL, loc_nRes
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(loc_oPagina2.txt_4c_Dopes.Value)

        IF EMPTY(loc_cDopes)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe WHERE Dopes = " + ;
                EscaparSQL(loc_cDopes)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaOpe")

            IF loc_nRes > 0 AND USED("cursor_4c_ValidaOpe") AND RECCOUNT("cursor_4c_ValidaOpe") > 0
                SELECT cursor_4c_ValidaOpe
                loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_ValidaOpe.Ndopes
                loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ValidaOpe.Dopes)
                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
            ELSE
                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
                THIS.AbrirBuscaNopes()
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_ValidaOpe")
                USE IN cursor_4c_ValidaOpe
            ENDIF
            MostrarErro("Erro ao validar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormOpd.ValidarNopes")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaNopes - Abre picker de operacoes por codigo (SigCdOpe)
    *===========================================================================
    PROTECTED PROCEDURE AbrirBuscaNopes()
        LOCAL loc_oPagina2, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe ORDER BY Ndopes"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")

            IF loc_nRes >= 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
                    loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
                    loc_oBusca.mAddColuna("Ndopes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Dopes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                        SELECT cursor_4c_BuscaOpe
                        loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
                        loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                    CapturarErroSQL(), "FormOpd.AbrirBuscaNopes")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
                "FormOpd.AbrirBuscaNopes")
        ENDTRY

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarDopes - Handler de LostFocus do txt_4c_Dopes
    * Busca SigCdOpe por Dopes (LIKE); match unico preenche auto; multiplos abre picker
    *===========================================================================
    PROCEDURE ValidarDopes(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina2, loc_cDopes, loc_cSQL, loc_nRes
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(loc_oPagina2.txt_4c_Dopes.Value)

        IF EMPTY(loc_cDopes)
            loc_oPagina2.txt_4c_Nopes.Value = 0
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe WHERE Dopes LIKE " + ;
                EscaparSQL(loc_cDopes + "%") + " ORDER BY Dopes"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")

            IF loc_nRes > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
                SELECT cursor_4c_BuscaOpe
                GO TOP
                IF RECCOUNT("cursor_4c_BuscaOpe") = 1
                    loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
                    loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    IF USED("cursor_4c_BuscaOpe")
                        USE IN cursor_4c_BuscaOpe
                    ENDIF
                ELSE
                    THIS.AbrirBuscaDopes()
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaOpe")
                    USE IN cursor_4c_BuscaOpe
                ENDIF
                THIS.AbrirBuscaDopes()
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF
            MostrarErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormOpd.ValidarDopes")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaDopes - Abre picker de operacoes por descricao (SigCdOpe)
    * Reutiliza cursor_4c_BuscaOpe se ja existir (criado em ValidarDopes)
    *===========================================================================
    PROTECTED PROCEDURE AbrirBuscaDopes()
        LOCAL loc_oPagina2, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !USED("cursor_4c_BuscaOpe")
                loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe ORDER BY Dopes"
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
                IF loc_nRes < 0
                    MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "FormOpd.AbrirBuscaDopes")
                    RETURN
                ENDIF
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
                loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
                loc_oBusca.mAddColuna("Ndopes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Dopes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                    SELECT cursor_4c_BuscaOpe
                    loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
                    loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                ENDIF
                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
                "FormOpd.AbrirBuscaDopes")
        ENDTRY

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    *===========================================================================
    * NopesKeyPress - Handler de KeyPress do txt_4c_Nopes (F4 abre picker)
    * CRITICO: handler de BINDEVENT DEVE declarar parametros do evento
    *===========================================================================
    PROCEDURE NopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Nopes.ReadOnly
                THIS.AbrirBuscaNopes()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * NopesDblClick - Handler de DblClick do txt_4c_Nopes (abre picker)
    *===========================================================================
    PROCEDURE NopesDblClick()
        IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Nopes.ReadOnly
            THIS.AbrirBuscaNopes()
        ENDIF
    ENDPROC

    *===========================================================================
    * DopesKeyPress - Handler de KeyPress do txt_4c_Dopes (F4 abre picker)
    * CRITICO: handler de BINDEVENT DEVE declarar parametros do evento
    *===========================================================================
    PROCEDURE DopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Dopes.ReadOnly
                THIS.AbrirBuscaDopes()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * DopesDblClick - Handler de DblClick do txt_4c_Dopes (abre picker)
    *===========================================================================
    PROCEDURE DopesDblClick()
        IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Dopes.ReadOnly
            THIS.AbrirBuscaDopes()
        ENDIF
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_DadosTmp")
            USE IN cursor_4c_DadosTmp
        ENDIF

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
