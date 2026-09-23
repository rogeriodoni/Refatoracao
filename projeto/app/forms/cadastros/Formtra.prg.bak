*==============================================================================
* Formtra.prg - Formulario de Cadastro de Transportadoras
* Migrado de: sigcdtra.SCX (frmcadastro)
* Tabelas: SigPrTrp (cabecalho) / SigPrTrv (fretes por estado - detalhe)
*==============================================================================

DEFINE CLASS Formtra AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    *-- Height ampliada de 600 para 700 (CLAUDE.md regra #11: faixa do cabecalho nas
    *-- duas paginas exige re-layout; a Pagina Dados deste form tem ~40 controles e
    *-- nao cabe nos 600px originais apos o deslocamento +88 para abrir espaco a faixa)
    Height      = 700
    Width       = 1000
    Caption     = "Cadastro de Transportadoras"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

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
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("traBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar traBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formtra.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formtra:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formtra.InicializarForm")
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
    * ConfigurarPaginaLista - Page1 (Lista de Transportadoras)
    * Grid: cursor_4c_Dados (itras, razaos, tel1s) - traBO.Buscar()
    * Botoes CRUD: Incluir, Visualizar, Alterar, Excluir, Buscar, Encerrar
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho (faixa cinza) - PRIMEIRO AddObject da pagina (CLAUDE.md regra #11)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
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

        *-- Container de botoes CRUD (Grupo_op no legado)
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

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
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

        *-- Grid de listagem de transportadoras
        *-- Colunas: itras (Codigo), razaos (Razao Social), tel1s (Telefone) - fiel ao
        *-- legado (SIGCDTRA.Init: AddCursor+pColuna em Pagina.Lista.Grade)
        *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
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
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
    * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
                loc_oGrid.ColumnCount  = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.itras"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.razaos"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tel1s"

                *-- Larguras proporcionais ao legado (pColuna: 85/322/120 de 971) sobre Width=880
                loc_oGrid.Column1.Width = 140
                loc_oGrid.Column2.Width = 535
                loc_oGrid.Column3.Width = 200

                *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Raz" + CHR(227) + "o Social"
                loc_oGrid.Column3.Header1.Caption = "Telefone"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formtra.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
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
                "Formtra.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2 (Dados da Transportadora + Grade de Fretes)
    * NESTA FASE: apenas estrutura base (cabecalho + container de acao vazio).
    * Campos, grid de fretes (GradEstado) e lookups sao implementados
    * nas Fases 5/6.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho (faixa cinza) tambem na pagina Dados - CLAUDE.md regra #11
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
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

        *-- Container de botoes de acao (Grupo_Salva no legado) - populado na Fase 6
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *======================================================================
        * FASE 5/8: Campos principais (PARTE 1) - dados gerais da transportadora
        * Shift uniforme de +88 sobre o Top original do SCX (getItra Top=27 -> 115)
        * para que o primeiro controle de dados fique em Top >= 115 (CLAUDE.md #11:
        * cnt_4c_Cabecalho ocupa Top=29..109)
        *======================================================================

        *-- Codigo (itras)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 118
            .Left      = 76
            .Width     = 42
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Itra", "TextBox")
        WITH loc_oPagina.txt_4c_Itra
            .Value         = ""
            .Top           = 115
            .Left          = 123
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .Format        = "!"
            .InputMask     = "A999999999"
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- ID E-Commerce (idtransp)
        loc_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPagina.lbl_4c_Label25
            .Caption   = "ID E-Commerce :"
            .Top       = 119
            .Left      = 246
            .Width     = 83
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Idtransp", "TextBox")
        WITH loc_oPagina.txt_4c_Idtransp
            .Value         = ""
            .Top           = 115
            .Left          = 333
            .Width         = 80
            .Height        = 25
            .MaxLength     = 15
            .Format        = "!"
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Razao Social
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Razao Social :"
            .Top       = 148
            .Left      = 49
            .Width     = 69
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Razao", "TextBox")
        WITH loc_oPagina.txt_4c_Razao
            .Value         = ""
            .Top           = 143
            .Left          = 123
            .Width         = 290
            .Height        = 25
            .MaxLength     = 40
            .Format        = "!"
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Endereco
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Endere" + CHR(231) + "o :"
            .Top       = 176
            .Left      = 64
            .Width     = 54
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Endereco", "TextBox")
        WITH loc_oPagina.txt_4c_Endereco
            .Value         = ""
            .Top           = 171
            .Left          = 123
            .Width         = 290
            .Height        = 25
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Bairro
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Bairro :"
            .Top       = 204
            .Left      = 81
            .Width     = 37
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Bairro", "TextBox")
        WITH loc_oPagina.txt_4c_Bairro
            .Value         = ""
            .Top           = 199
            .Left          = 123
            .Width         = 150
            .Height        = 25
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- CEP
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "CEP :"
            .Top       = 232
            .Left      = 90
            .Width     = 28
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cep", "TextBox")
        WITH loc_oPagina.txt_4c_Cep
            .Value         = ""
            .Top           = 227
            .Left          = 123
            .Width         = 73
            .Height        = 25
            .MaxLength     = 9
            .Format        = "R"
            .InputMask     = "99999-999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Cidade
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Cidade :"
            .Top       = 259
            .Left      = 76
            .Width     = 42
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cidade", "TextBox")
        WITH loc_oPagina.txt_4c_Cidade
            .Value         = ""
            .Top           = 254
            .Left          = 123
            .Width         = 220
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- U.F.
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "U.F. :"
            .Top       = 286
            .Left      = 299
            .Width     = 30
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Uf", "TextBox")
        WITH loc_oPagina.txt_4c_Uf
            .Value         = ""
            .Top           = 282
            .Left          = 332
            .Width         = 24
            .Height        = 25
            .MaxLength     = 2
            .Format        = "A"
            .InputMask     = "!!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Telefone (1)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Telefone (1) :"
            .Top       = 287
            .Left      = 50
            .Width     = 68
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tel1", "TextBox")
        WITH loc_oPagina.txt_4c_Tel1
            .Value         = ""
            .Top           = 282
            .Left          = 123
            .Width         = 150
            .Height        = 25
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Telefone (2)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Telefone (2) :"
            .Top       = 315
            .Left      = 50
            .Width     = 68
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tel2", "TextBox")
        WITH loc_oPagina.txt_4c_Tel2
            .Value         = ""
            .Top           = 310
            .Left          = 123
            .Width         = 150
            .Height        = 25
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- C.G.C.
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "C.G.C. :"
            .Top       = 314
            .Left      = 287
            .Width     = 42
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cgc", "TextBox")
        WITH loc_oPagina.txt_4c_Cgc
            .Value         = ""
            .Top           = 310
            .Left          = 332
            .Width         = 136
            .Height        = 25
            .MaxLength     = 18
            .InputMask     = "99.999.999/9999-99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- I.E.
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "I.E. :"
            .Top       = 342
            .Left      = 302
            .Width     = 27
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ies", "TextBox")
        WITH loc_oPagina.txt_4c_Ies
            .Value         = ""
            .Top           = 338
            .Left          = 332
            .Width         = 150
            .Height        = 25
            .MaxLength     = 20
            .Format        = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * FASE 6/8: Campos restantes (PARTE 2) - area de FTP/transmissao,
        * grade de fretes por estado (GradEstado no legado) e lookups
        *======================================================================

        *-- Fax (getFax) - sem Say proprio no legado; pareia com Say8 "Servico :"
        *-- (alinhamento vertical Top+5 confirmado: getFax.Top=447 -> Say8.Top=452)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Servi" + CHR(231) + "o :"
            .Top       = 540
            .Left      = 347
            .Width     = 44
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fax", "TextBox")
        WITH loc_oPagina.txt_4c_Fax
            .Value         = ""
            .Top           = 535
            .Left          = 395
            .Width         = 87
            .Height        = 25
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Titulo de secao "Configuracao da Area do FTP" (Say14)
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = " Configura" + CHR(231) + CHR(227) + "o da " + CHR(193) + "rea do FTP "
            .Top       = 368
            .Left      = 8
            .Width     = 194
            .Height    = 18
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Geracao (Get_drivets)
        loc_oPagina.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPagina.lbl_4c_Label17
            .Caption   = "Gera" + CHR(231) + CHR(227) + "o :"
            .Top       = 389
            .Left      = 69
            .Width     = 49
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DriveGeracao", "TextBox")
        WITH loc_oPagina.txt_4c_DriveGeracao
            .Value         = ""
            .Top           = 385
            .Left          = 123
            .Width         = 359
            .Height        = 23
            .MaxLength     = 60
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Leitura (Get_drivels)
        loc_oPagina.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPagina.lbl_4c_Label21
            .Caption   = "Leitura :"
            .Top       = 414
            .Left      = 76
            .Width     = 42
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DriveLeitura", "TextBox")
        WITH loc_oPagina.txt_4c_DriveLeitura
            .Value         = ""
            .Top           = 410
            .Left          = 123
            .Width         = 359
            .Height        = 23
            .MaxLength     = 60
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Tipo de Conexao (Get_tpconexao) - D/B
        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "Tipo de Conex" + CHR(227) + "o :"
            .Top       = 439
            .Left      = 28
            .Width     = 90
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_TpConexao", "TextBox")
        WITH loc_oPagina.txt_4c_TpConexao
            .Value         = ""
            .Top           = 435
            .Left          = 123
            .Width         = 28
            .Height        = 23
            .MaxLength     = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPagina.lbl_4c_Label19
            .Caption   = "(D/B) Dial-Up / Banda Larga"
            .Top       = 439
            .Left      = 156
            .Width     = 159
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Endereco FTP (Get_ftpend)
        loc_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPagina.lbl_4c_Label16
            .Caption   = "Endere" + CHR(231) + "o FTP :"
            .Top       = 464
            .Left      = 43
            .Width     = 75
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_FtpEndereco", "TextBox")
        WITH loc_oPagina.txt_4c_FtpEndereco
            .Value         = ""
            .Top           = 460
            .Left          = 123
            .Width         = 359
            .Height        = 23
            .MaxLength     = 50
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Pasta p/ Envio (Get_dirftpts)
        loc_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPagina.lbl_4c_Label18
            .Caption   = "Pasta p/ Envio :"
            .Top       = 489
            .Left      = 40
            .Width     = 78
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DirFtpEnvio", "TextBox")
        WITH loc_oPagina.txt_4c_DirFtpEnvio
            .Value         = ""
            .Top           = 485
            .Left          = 123
            .Width         = 359
            .Height        = 23
            .MaxLength     = 60
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Pasta p/Recepcao (Get_dirftpls)
        loc_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPagina.lbl_4c_Label20
            .Caption   = "Pasta p/Recep" + CHR(231) + CHR(227) + "o :"
            .Top       = 514
            .Left      = 22
            .Width     = 96
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DirFtpRecepcao", "TextBox")
        WITH loc_oPagina.txt_4c_DirFtpRecepcao
            .Value         = ""
            .Top           = 510
            .Left          = 123
            .Width         = 359
            .Height        = 23
            .MaxLength     = 60
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Usuario FTP (Get_ftpusuario)
        loc_oPagina.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oPagina.lbl_4c_Label23
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 539
            .Left      = 73
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_FtpUsuario", "TextBox")
        WITH loc_oPagina.txt_4c_FtpUsuario
            .Value         = ""
            .Top           = 535
            .Left          = 123
            .Width         = 160
            .Height        = 25
            .MaxLength     = 50
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Modelo (Say27) / OptionGroup Tipo de Transporte (Optiongroup1)
        loc_oPagina.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPagina.lbl_4c_Label27
            .Caption   = "Modelo :"
            .Top       = 561
            .Left      = 347
            .Width     = 43
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_TipoTransporte", "OptionGroup")
        WITH loc_oPagina.opt_4c_TipoTransporte
            .Top         = 558
            .Left        = 390
            .Width       = 137
            .Height      = 53
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(1)
            .Caption   = "Comum"
            .Left      = 5
            .Top       = 5
            .Width     = 61
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(2)
            .Caption   = "Sedex"
            .Left      = 63
            .Top       = 5
            .Width     = 61
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(3)
            .Caption   = "PAC"
            .Left      = 5
            .Top       = 19
            .Width     = 61
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(4)
            .Caption   = "Sedex Hoje"
            .Left      = 5
            .Top       = 34
            .Width     = 73
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Senha FTP (Get_ftpsenha) - Valid comentado no legado (TrocaSenha desativado)
        loc_oPagina.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPagina.lbl_4c_Label24
            .Caption   = "Senha :"
            .Top       = 566
            .Left      = 79
            .Width     = 39
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_FtpSenha", "TextBox")
        WITH loc_oPagina.txt_4c_FtpSenha
            .Value         = ""
            .Top           = 562
            .Left          = 123
            .Width         = 130
            .Height        = 23
            .PasswordChar  = "*"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Redigita Senha (Get_senha2) - apenas conferencia visual, Valid comentado
        *-- no legado (nao persiste, nao mapeado no FormParaBO/BOParaForm)
        loc_oPagina.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPagina.lbl_4c_Label22
            .Caption   = "Redigita :"
            .Top       = 591
            .Left      = 70
            .Width     = 48
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Senha2", "TextBox")
        WITH loc_oPagina.txt_4c_Senha2
            .Value         = ""
            .Top           = 587
            .Left          = 123
            .Width         = 130
            .Height        = 23
            .PasswordChar  = "*"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Checkboxes de limpeza de diretorio (chkftpdel / chklocdel)
        loc_oPagina.AddObject("chk_4c_LimpaDiretorioFtp", "CheckBox")
        WITH loc_oPagina.chk_4c_LimpaDiretorioFtp
            .Caption   = "Limpa diret" + CHR(243) + "rio do FTP"
            .Top       = 611
            .Left      = 123
            .Width     = 160
            .Height    = 17
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_LimpaDiretorioLocal", "CheckBox")
        WITH loc_oPagina.chk_4c_LimpaDiretorioLocal
            .Caption   = "Limpa diret" + CHR(243) + "rio de envio"
            .Top       = 611
            .Left      = 279
            .Width     = 160
            .Height    = 17
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Url Tracking (getUrlTransp - editbox)
        loc_oPagina.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPagina.lbl_4c_Label26
            .Caption   = "Url Tracking :"
            .Top       = 628
            .Left      = 53
            .Width     = 65
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_UrlTransp", "EditBox")
        WITH loc_oPagina.txt_4c_UrlTransp
            .Value         = ""
            .Top           = 628
            .Left          = 122
            .Width         = 359
            .Height        = 53
            .SpecialEffect = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * Grade de fretes por estado (GradEstado no legado) + lookups UF/Municipio
        *======================================================================

        *-- Titulo da grade (Say13)
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Valor por estado e varia" + CHR(231) + CHR(227) + "o de peso (Gr) :"
            .Top       = 194
            .Left      = 503
            .Width     = 204
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de fretes por estado - estrutura criada aqui; RecordSource,
        *-- ControlSource e Headers sao definidos em CarregarGradeEstados()
        *-- (Problema 2/48: reconfigurar SOMENTE apos RecordSource)
        loc_oPagina.AddObject("grd_4c_Estados", "Grid")
        loc_oPagina.grd_4c_Estados.ColumnCount = 5
        WITH loc_oPagina.grd_4c_Estados
            .Top           = 211
            .Left          = 500
            .Width         = 490
            .Height        = 419
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .GridLineColor = RGB(238, 238, 238)
            .GridLineWidth = 1
            .HeaderHeight  = 20
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 2
            .GridLines     = 3
            .Panel         = 1
            .Visible       = .T.
        ENDWITH

        *-- Coluna UF (Column1) - controle customizado com lookup no LostFocus
        *-- (CLAUDE.md regra #18: precisa de CurrentControl + Sparse=.F.)
        loc_oPagina.grd_4c_Estados.Column1.AddObject("txt_4c_ColUf", "TextBox")
        WITH loc_oPagina.grd_4c_Estados.Column1.txt_4c_ColUf
            .FontName    = "Arial"
            .FontSize    = 8
            .Alignment   = 2
            .BorderStyle = 0
            .Format      = "!"
            .Margin      = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.grd_4c_Estados.Column1.CurrentControl = "txt_4c_ColUf"
        loc_oPagina.grd_4c_Estados.Column1.Sparse         = .F.
        BINDEVENT(loc_oPagina.grd_4c_Estados.Column1.txt_4c_ColUf, "KeyPress", THIS, "ValidarUfEstado")

        *-- Coluna Municipio (Column5) - controle customizado com lookup no LostFocus
        loc_oPagina.grd_4c_Estados.Column5.AddObject("txt_4c_ColMunicipio", "TextBox")
        WITH loc_oPagina.grd_4c_Estados.Column5.txt_4c_ColMunicipio
            .FontName    = "Arial"
            .FontSize    = 8
            .Alignment   = 0
            .BorderStyle = 0
            .Margin      = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.grd_4c_Estados.Column5.CurrentControl = "txt_4c_ColMunicipio"
        loc_oPagina.grd_4c_Estados.Column5.Sparse         = .F.
        BINDEVENT(loc_oPagina.grd_4c_Estados.Column5.txt_4c_ColMunicipio, "KeyPress", THIS, "ValidarMunicipioEstado")

        *-- Grid.ReadOnly ANTES de Column.ReadOnly (regra #18 - senao o Grid sobrescreve)
        loc_oPagina.grd_4c_Estados.ReadOnly  = .F.
        loc_oPagina.grd_4c_Estados.Column1.ReadOnly = .F.
        loc_oPagina.grd_4c_Estados.Column2.ReadOnly = .F.
        loc_oPagina.grd_4c_Estados.Column3.ReadOnly = .F.
        loc_oPagina.grd_4c_Estados.Column4.ReadOnly = .F.
        loc_oPagina.grd_4c_Estados.Column5.ReadOnly = .F.

        *-- Botao Incluir linha de estado (inserir no legado)
        loc_oPagina.AddObject("cmd_4c_IncluirEstado", "CommandButton")
        WITH loc_oPagina.cmd_4c_IncluirEstado
            .Top           = 633
            .Left          = 502
            .Width         = 45
            .Height        = 45
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText   = "Inserir"
            .FontBold      = .T.
            .FontName      = "Verdana"
            .FontSize      = 8
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_IncluirEstado, "Click", THIS, "BtnIncluirEstadoClick")

        *-- Botao Excluir linha de estado (excluir no legado)
        loc_oPagina.AddObject("cmd_4c_ExcluirEstado", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirEstado
            .Top           = 633
            .Left          = 548
            .Width         = 45
            .Height        = 45
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText   = "Excluir"
            .FontBold      = .T.
            .FontName      = "Verdana"
            .FontSize      = 8
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirEstado, "Click", THIS, "BtnExcluirEstadoClick")

        *-- Inicializa a estrutura do cursor da grade (RecordSource/Headers definidos aqui)
        THIS.CarregarGradeEstados("")

        *======================================================================
        * Botoes de acao da Pagina Dados (Grupo_Salva no legado)
        *======================================================================
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

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarGradeEstados - Carrega/atualiza a grade de fretes por estado
    * (GradEstado/crSigPrTrv no legado). SigPrTrv NAO tem colunas "uf"/"munici" -
    * sao alias de JOIN com SigCdUfs/SigCdMun (ver docs/schema.sql).
    * REGRA: RecordSource/ControlSource/Headers configurados so na 1a chamada
    * (Problema 48); recargas seguintes usam cursor temporario + ZAP + APPEND
    * (Problema 34/35) para nao destruir as colunas do Grid.
    *===========================================================================
    PROCEDURE CarregarGradeEstados(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_oGrid, loc_lPrimeiraVez
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Estados
            loc_lPrimeiraVez = EMPTY(loc_oGrid.RecordSource)

            IF !USED("cursor_4c_Estados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Estados (cidchaves C(20), codibges C(7), ;
                    pesomaxs N(8,2), pesomins N(8,2), ufibges N(5,0), valfretes N(9,2), ;
                    uf C(2), munici C(40))
                SET NULL OFF
            ELSE
                SELECT cursor_4c_Estados
                ZAP
            ENDIF

            IF VARTYPE(par_cCodigo) = "C" AND !EMPTY(par_cCodigo) ;
                    AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SELECT a.cidchaves, a.codibges, a.pesomaxs, a.pesomins, a.ufibges,
                        a.valfretes, d.estados AS uf, c.descs AS munici
                    FROM SigPrTrv a
                    INNER JOIN SigCdUfs d ON d.ufibges = a.ufibges
                    LEFT JOIN SigCdMun c ON c.codigos = a.codibges
                    WHERE a.itras = <<EscaparSQL(par_cCodigo)>>
                    ORDER BY d.estados
                ENDTEXT

                IF USED("cursor_4c_EstadosTemp")
                    USE IN cursor_4c_EstadosTemp
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstadosTemp")

                IF loc_nResultado >= 0 AND USED("cursor_4c_EstadosTemp")
                    SELECT cursor_4c_Estados
                    APPEND FROM DBF("cursor_4c_EstadosTemp")
                    USE IN cursor_4c_EstadosTemp
                ELSE
                    MostrarErro("Erro ao carregar fretes por estado:" + CHR(13) + CapturarErroSQL(), ;
                        "Formtra.CarregarGradeEstados")
                ENDIF
            ENDIF

            SELECT cursor_4c_Estados
            GO TOP

            IF loc_lPrimeiraVez
                loc_oGrid.RecordSource = "cursor_4c_Estados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Estados.uf"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Estados.valfretes"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Estados.pesomins"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Estados.pesomaxs"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Estados.munici"

                loc_oGrid.Column1.txt_4c_ColUf.ControlSource        = "cursor_4c_Estados.uf"
                loc_oGrid.Column5.txt_4c_ColMunicipio.ControlSource = "cursor_4c_Estados.munici"

                loc_oGrid.Column1.Width = 50
                loc_oGrid.Column2.Width = 90
                loc_oGrid.Column3.Width = 90
                loc_oGrid.Column4.Width = 90
                loc_oGrid.Column5.Width = 165

                loc_oGrid.Column2.Text1.Alignment = 3
                loc_oGrid.Column3.Text1.Alignment = 3
                loc_oGrid.Column4.Text1.Alignment = 3

                loc_oGrid.Column1.Header1.Caption = "UF"
                loc_oGrid.Column2.Header1.Caption = "Valor"
                loc_oGrid.Column3.Header1.Caption = "Peso M" + CHR(237) + "nimo"
                loc_oGrid.Column4.Header1.Caption = "Peso M" + CHR(225) + "ximo"
                loc_oGrid.Column5.Header1.Caption = "Munic" + CHR(237) + "pio"
            ENDIF

            loc_oGrid.Refresh()
            loc_lResultado = .T.

        CATCH TO loException
            MostrarErro("Erro ao carregar grade de estados:" + CHR(13) + loException.Message, ;
                "Formtra.CarregarGradeEstados")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * SalvarGradeEstados - Grava os fretes por estado da grade (cursor_4c_Estados)
    * na tabela SigPrTrv. Estrategia: apaga tudo do codigo e regrava (mais simples
    * e seguro que diff linha-a-linha; equivalente ao msv_inserir/msv_alterar
    * do legado que tambem regravam o cursor inteiro via poDataMgr.Update).
    *===========================================================================
    PROCEDURE SalvarGradeEstados(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCidChaves
        loc_lResultado = .T.

        TRY
            loc_cSQL = "DELETE FROM SigPrTrv WHERE itras = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Erro ao atualizar fretes por estado:" + CHR(13) + CapturarErroSQL(), ;
                    "Formtra.SalvarGradeEstados")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Estados")
                    SELECT cursor_4c_Estados
                    SCAN FOR !DELETED() AND !EMPTY(ALLTRIM(uf))
                        loc_cCidChaves = ALLTRIM(cursor_4c_Estados.cidchaves)
                        IF EMPTY(loc_cCidChaves)
                            loc_cCidChaves = fUniqueIds("")
                        ENDIF

                        TEXT TO loc_cSQL TEXTMERGE NOSHOW
                            INSERT INTO SigPrTrv (cidchaves, codibges, itras, pesomaxs, pesomins, ufibges, valfretes)
                            VALUES (
                                <<EscaparSQL(loc_cCidChaves)>>,
                                <<EscaparSQL(cursor_4c_Estados.codibges)>>,
                                <<EscaparSQL(par_cCodigo)>>,
                                <<FormatarNumeroSQL(cursor_4c_Estados.pesomaxs, 2)>>,
                                <<FormatarNumeroSQL(cursor_4c_Estados.pesomins, 2)>>,
                                <<FormatarNumeroSQL(cursor_4c_Estados.ufibges, 0)>>,
                                <<FormatarNumeroSQL(cursor_4c_Estados.valfretes, 2)>>
                            )
                        ENDTEXT

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MostrarErro("Erro ao gravar frete do estado " + ALLTRIM(cursor_4c_Estados.uf) + ":" + ;
                                CHR(13) + CapturarErroSQL(), "Formtra.SalvarGradeEstados")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao salvar fretes por estado:" + CHR(13) + loException.Message, ;
                "Formtra.SalvarGradeEstados")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirEstadoClick - Adiciona linha em branco na grade de estados
    * (inserir.Click no legado)
    *===========================================================================
    PROCEDURE BtnIncluirEstadoClick()
        IF !USED("cursor_4c_Estados")
            RETURN
        ENDIF

        SELECT cursor_4c_Estados
        APPEND BLANK
        REPLACE cidchaves WITH fUniqueIds(""), uf WITH "", ufibges WITH 0, ;
            munici WITH "", codibges WITH "", valfretes WITH 0, ;
            pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados

        WITH THIS.pgf_4c_Paginas.Page2.grd_4c_Estados
            .Refresh()
            .SetFocus()
            .Column1.SetFocus()
        ENDWITH
    ENDPROC

    *===========================================================================
    * BtnExcluirEstadoClick - Remove a linha atual da grade de estados
    * (excluir.Click no legado)
    *===========================================================================
    PROCEDURE BtnExcluirEstadoClick()
        IF !USED("cursor_4c_Estados")
            RETURN
        ENDIF

        SELECT cursor_4c_Estados
        IF EOF() OR BOF()
            RETURN
        ENDIF

        DELETE IN cursor_4c_Estados
        GO TOP IN cursor_4c_Estados

        THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
    ENDPROC

    *===========================================================================
    * ValidarUfEstado - Lookup do campo UF da grade de estados (Column1)
    * Legado: Column1.Text1.Valid - CreateObject('fwbuscaext', ..., 'SigCdUfs', ...)
    *===========================================================================
    PROCEDURE ValidarUfEstado(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cUf

        IF !USED("cursor_4c_Estados")
            RETURN
        ENDIF

        SELECT cursor_4c_Estados
        loc_cUf = UPPER(ALLTRIM(cursor_4c_Estados.uf))

        IF EMPTY(loc_cUf)
            REPLACE uf WITH "", ufibges WITH 0, munici WITH "", codibges WITH "", ;
                valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
            THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUfs", ;
            "cursor_4c_BuscaUf", "Estados", PADR(loc_cUf, 2), "Selecionar Estado")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Estados", "", "UF")
                loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("UFIBGEs", "", "IBGE")
                loc_oBusca.Show()
            ENDIF

            SELECT cursor_4c_Estados
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
                REPLACE uf WITH ALLTRIM(cursor_4c_BuscaUf.Estados), ;
                    ufibges WITH cursor_4c_BuscaUf.UFIBGEs, ;
                    munici WITH "", codibges WITH "", ;
                    valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 ;
                    IN cursor_4c_Estados
            ELSE
                REPLACE uf WITH "", ufibges WITH 0, munici WITH "", codibges WITH "", ;
                    valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
            ENDIF

            IF USED("cursor_4c_BuscaUf")
                USE IN cursor_4c_BuscaUf
            ENDIF
            loc_oBusca.Release()
        ENDIF

        THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
    ENDPROC

    *===========================================================================
    * ValidarMunicipioEstado - Lookup do Municipio da grade de estados (Column5)
    * Legado: Column5.Text1.Valid - join SigCdMun+SigCdUfs filtrado pela UF da
    * linha atual, seek exato ou fwbuscaint (grid) se nao achar
    *===========================================================================
    PROCEDURE ValidarMunicipioEstado(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cUf, loc_cMunicipio, loc_cSQL, loc_nResultado, loc_oBusca

        IF !USED("cursor_4c_Estados")
            RETURN
        ENDIF

        SELECT cursor_4c_Estados
        loc_cUf        = UPPER(ALLTRIM(cursor_4c_Estados.uf))
        loc_cMunicipio = ALLTRIM(cursor_4c_Estados.munici)

        IF EMPTY(loc_cUf) OR EMPTY(loc_cMunicipio)
            RETURN
        ENDIF

        IF USED("cursor_4c_BuscaMunicipio")
            USE IN cursor_4c_BuscaMunicipio
        ENDIF

        TEXT TO loc_cSQL TEXTMERGE NOSHOW
            SELECT b.estados AS uf, a.descs AS munici, a.codigos AS codibges
            FROM SigCdMun a
            INNER JOIN SigCdUfs b ON a.ufibges = b.ufibges
            WHERE b.estados = <<EscaparSQL(loc_cUf)>>
            ORDER BY a.descs
        ENDTEXT

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMunicipio")

        IF loc_nResultado < 0 OR !USED("cursor_4c_BuscaMunicipio")
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                "Falha na Conex" + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_BuscaMunicipio
        LOCATE FOR UPPER(ALLTRIM(munici)) == UPPER(loc_cMunicipio)

        IF FOUND()
            SELECT cursor_4c_Estados
            REPLACE munici WITH ALLTRIM(cursor_4c_BuscaMunicipio.munici), ;
                codibges WITH ALLTRIM(cursor_4c_BuscaMunicipio.codibges) IN cursor_4c_Estados
        ELSE
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMunicipio"
            loc_oBusca.this_cTitulo        = "Selecionar Munic" + CHR(237) + "pio"
            loc_oBusca.mAddColuna("munici", "", "Munic" + CHR(237) + "pio")
            loc_oBusca.mAddColuna("uf", "", "UF")
            loc_oBusca.Show()

            SELECT cursor_4c_Estados
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMunicipio")
                REPLACE munici WITH ALLTRIM(cursor_4c_BuscaMunicipio.munici), ;
                    codibges WITH ALLTRIM(cursor_4c_BuscaMunicipio.codibges) IN cursor_4c_Estados
            ELSE
                REPLACE munici WITH "", codibges WITH "" IN cursor_4c_Estados
            ENDIF
            loc_oBusca.Release()
        ENDIF

        REPLACE valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados

        IF USED("cursor_4c_BuscaMunicipio")
            USE IN cursor_4c_BuscaMunicipio
        ENDIF

        THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do Form para o Business Object
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg, loc_oBo
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oBo = THIS.this_oBusinessObject

        loc_oBo.this_cCodigo             = ALLTRIM(loc_oPg.txt_4c_Itra.Value)
        loc_oBo.this_cIdTransportadora   = ALLTRIM(loc_oPg.txt_4c_Idtransp.Value)
        loc_oBo.this_cRazaoSocial        = ALLTRIM(loc_oPg.txt_4c_Razao.Value)
        loc_oBo.this_cEndereco           = ALLTRIM(loc_oPg.txt_4c_Endereco.Value)
        loc_oBo.this_cBairro             = ALLTRIM(loc_oPg.txt_4c_Bairro.Value)
        loc_oBo.this_cCep                = ALLTRIM(loc_oPg.txt_4c_Cep.Value)
        loc_oBo.this_cCidade             = ALLTRIM(loc_oPg.txt_4c_Cidade.Value)
        loc_oBo.this_cUf                 = ALLTRIM(loc_oPg.txt_4c_Uf.Value)
        loc_oBo.this_cTelefone1          = ALLTRIM(loc_oPg.txt_4c_Tel1.Value)
        loc_oBo.this_cTelefone2          = ALLTRIM(loc_oPg.txt_4c_Tel2.Value)
        loc_oBo.this_cCgc                = ALLTRIM(loc_oPg.txt_4c_Cgc.Value)
        loc_oBo.this_cInscricaoEstadual  = ALLTRIM(loc_oPg.txt_4c_Ies.Value)
        loc_oBo.this_cFax                = ALLTRIM(loc_oPg.txt_4c_Fax.Value)
        loc_oBo.this_cTipoConexao        = ALLTRIM(loc_oPg.txt_4c_TpConexao.Value)
        loc_oBo.this_cFtpEndereco        = ALLTRIM(loc_oPg.txt_4c_FtpEndereco.Value)
        loc_oBo.this_cFtpUsuario         = ALLTRIM(loc_oPg.txt_4c_FtpUsuario.Value)
        loc_oBo.this_cFtpSenha           = ALLTRIM(loc_oPg.txt_4c_FtpSenha.Value)
        loc_oBo.this_cDirFtpEnvio        = ALLTRIM(loc_oPg.txt_4c_DirFtpEnvio.Value)
        loc_oBo.this_cDirFtpRecepcao     = ALLTRIM(loc_oPg.txt_4c_DirFtpRecepcao.Value)
        loc_oBo.this_cDriveGeracao       = ALLTRIM(loc_oPg.txt_4c_DriveGeracao.Value)
        loc_oBo.this_cDriveLeitura       = ALLTRIM(loc_oPg.txt_4c_DriveLeitura.Value)
        loc_oBo.this_lLimpaDiretorioFtp   = (loc_oPg.chk_4c_LimpaDiretorioFtp.Value = 1)
        loc_oBo.this_lLimpaDiretorioLocal = (loc_oPg.chk_4c_LimpaDiretorioLocal.Value = 1)
        loc_oBo.this_cUrlTransp          = ALLTRIM(loc_oPg.txt_4c_UrlTransp.Value)
        loc_oBo.this_nTipoTransporte     = loc_oPg.opt_4c_TipoTransporte.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do Business Object para os campos do Form
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oBo
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oBo = THIS.this_oBusinessObject

        loc_oPg.txt_4c_Itra.Value                = loc_oBo.this_cCodigo
        loc_oPg.txt_4c_Idtransp.Value            = loc_oBo.this_cIdTransportadora
        loc_oPg.txt_4c_Razao.Value                = loc_oBo.this_cRazaoSocial
        loc_oPg.txt_4c_Endereco.Value             = loc_oBo.this_cEndereco
        loc_oPg.txt_4c_Bairro.Value                = loc_oBo.this_cBairro
        loc_oPg.txt_4c_Cep.Value                   = loc_oBo.this_cCep
        loc_oPg.txt_4c_Cidade.Value                = loc_oBo.this_cCidade
        loc_oPg.txt_4c_Uf.Value                    = loc_oBo.this_cUf
        loc_oPg.txt_4c_Tel1.Value                  = loc_oBo.this_cTelefone1
        loc_oPg.txt_4c_Tel2.Value                  = loc_oBo.this_cTelefone2
        loc_oPg.txt_4c_Cgc.Value                   = loc_oBo.this_cCgc
        loc_oPg.txt_4c_Ies.Value                   = loc_oBo.this_cInscricaoEstadual
        loc_oPg.txt_4c_Fax.Value                   = loc_oBo.this_cFax
        loc_oPg.txt_4c_TpConexao.Value             = loc_oBo.this_cTipoConexao
        loc_oPg.txt_4c_FtpEndereco.Value           = loc_oBo.this_cFtpEndereco
        loc_oPg.txt_4c_FtpUsuario.Value            = loc_oBo.this_cFtpUsuario
        loc_oPg.txt_4c_FtpSenha.Value              = loc_oBo.this_cFtpSenha
        loc_oPg.txt_4c_DirFtpEnvio.Value           = loc_oBo.this_cDirFtpEnvio
        loc_oPg.txt_4c_DirFtpRecepcao.Value        = loc_oBo.this_cDirFtpRecepcao
        loc_oPg.txt_4c_DriveGeracao.Value          = loc_oBo.this_cDriveGeracao
        loc_oPg.txt_4c_DriveLeitura.Value          = loc_oBo.this_cDriveLeitura
        loc_oPg.chk_4c_LimpaDiretorioFtp.Value     = loc_oBo.this_lLimpaDiretorioFtp
        loc_oPg.chk_4c_LimpaDiretorioLocal.Value   = loc_oBo.this_lLimpaDiretorioLocal
        loc_oPg.txt_4c_UrlTransp.Value             = loc_oBo.this_cUrlTransp
        loc_oPg.opt_4c_TipoTransporte.Value        = IIF(loc_oBo.this_nTipoTransporte >= 1 ;
            AND loc_oBo.this_nTipoTransporte <= 4, loc_oBo.this_nTipoTransporte, 1)
        loc_oPg.txt_4c_Senha2.Value                 = ""

        THIS.CarregarGradeEstados(loc_oBo.this_cCodigo)
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Grava cabecalho + fretes por estado
    * (Grupo_Salva.Salva.Click no legado)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lFreteInvalido

        THIS.FormParaBO()

        *-- Legado: frete/peso nao pode ficar totalmente zerado (regra de negocio)
        loc_lFreteInvalido = .F.
        IF USED("cursor_4c_Estados")
            SELECT cursor_4c_Estados
            LOCATE FOR !DELETED() AND !EMPTY(ALLTRIM(uf)) AND ;
                (valfretes = 0 OR (pesomins = 0 AND pesomaxs = 0))
            loc_lFreteInvalido = FOUND()
        ENDIF

        IF loc_lFreteInvalido
            MsgAviso("Valor do frete, peso m" + CHR(237) + "nimo ou peso m" + CHR(225) + ;
                "ximo n" + CHR(227) + "o podem ficar zerados.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            IF THIS.SalvarGradeEstados(THIS.this_oBusinessObject.this_cCodigo)
                MsgInfo("Registro salvo com sucesso!", "Confirmar")
                THIS.AlternarPagina(1)
            ELSE
                MsgErro("Transportadora salva, mas houve falha ao gravar os fretes por estado.", "Confirmar")
            ENDIF
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Descarta alteracoes e volta para a lista
    * (Grupo_Salva.Cancelar.Click no legado)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara BO e Form para inclusao de novo registro
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    * Codigo (itras) e gerado automaticamente pelo BO (fGerUniqueKey no legado,
    * InicializarValoresPadrao() aqui) - permanece SEMPRE readonly na tela.
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.pgf_4c_Paginas.Page2.txt_4c_Itra.Value = THIS.this_oBusinessObject.this_cCodigo
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
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
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
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
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
    * (BusinessBase.Excluir() chama traBO.ExecutarExclusao() internamente,
    * que ja remove os fretes por estado associados em SigPrTrv - regra #57)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da transportadora [" + loc_cCodigo + "]?", ;
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
    * Apos selecao, posiciona o cursor no registro encontrado
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrTrp", "cursor_4c_BuscaTra", "itras", "", ;
                "Buscar Transportadora")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("itras",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razaos", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTra")
                    SELECT cursor_4c_BuscaTra
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaTra.itras)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTra")
                USE IN cursor_4c_BuscaTra
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(itras) == loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Formtra.BtnBuscarClick")
            IF USED("cursor_4c_BuscaTra")
                USE IN cursor_4c_BuscaTra
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
    * HabilitarCampos - Habilita/desabilita os campos da Page2 conforme o modo
    * txt_4c_Itra permanece SEMPRE desabilitado (codigo gerado automaticamente
    * pelo BO - equivalente ao When() do legado que so libera em modo PROCURAR,
    * inexistente na nova arquitetura List+Buscar)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Itra.Enabled                = .F.
        loc_oPg.txt_4c_Idtransp.Enabled            = par_lHabilitar
        loc_oPg.txt_4c_Razao.Enabled               = par_lHabilitar
        loc_oPg.txt_4c_Endereco.Enabled            = par_lHabilitar
        loc_oPg.txt_4c_Bairro.Enabled              = par_lHabilitar
        loc_oPg.txt_4c_Cep.Enabled                 = par_lHabilitar
        loc_oPg.txt_4c_Cidade.Enabled              = par_lHabilitar
        loc_oPg.txt_4c_Uf.Enabled                  = par_lHabilitar
        loc_oPg.txt_4c_Tel1.Enabled                = par_lHabilitar
        loc_oPg.txt_4c_Tel2.Enabled                = par_lHabilitar
        loc_oPg.txt_4c_Cgc.Enabled                 = par_lHabilitar
        loc_oPg.txt_4c_Ies.Enabled                 = par_lHabilitar
        loc_oPg.txt_4c_Fax.Enabled                 = par_lHabilitar
        loc_oPg.txt_4c_TpConexao.Enabled           = par_lHabilitar
        loc_oPg.txt_4c_FtpEndereco.Enabled         = par_lHabilitar
        loc_oPg.txt_4c_FtpUsuario.Enabled          = par_lHabilitar
        loc_oPg.txt_4c_FtpSenha.Enabled            = par_lHabilitar
        loc_oPg.txt_4c_DirFtpEnvio.Enabled         = par_lHabilitar
        loc_oPg.txt_4c_DirFtpRecepcao.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_DriveGeracao.Enabled        = par_lHabilitar
        loc_oPg.txt_4c_DriveLeitura.Enabled        = par_lHabilitar
        loc_oPg.chk_4c_LimpaDiretorioFtp.Enabled   = par_lHabilitar
        loc_oPg.chk_4c_LimpaDiretorioLocal.Enabled = par_lHabilitar
        loc_oPg.txt_4c_UrlTransp.Enabled           = par_lHabilitar
        loc_oPg.opt_4c_TipoTransporte.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_Senha2.Enabled              = par_lHabilitar

        *-- Grid.ReadOnly ANTES de Column.ReadOnly (regra #18 - senao o Grid sobrescreve)
        loc_oPg.grd_4c_Estados.ReadOnly            = !par_lHabilitar
        loc_oPg.grd_4c_Estados.Column1.ReadOnly    = !par_lHabilitar
        loc_oPg.grd_4c_Estados.Column2.ReadOnly    = !par_lHabilitar
        loc_oPg.grd_4c_Estados.Column3.ReadOnly    = !par_lHabilitar
        loc_oPg.grd_4c_Estados.Column4.ReadOnly    = !par_lHabilitar
        loc_oPg.grd_4c_Estados.Column5.ReadOnly    = !par_lHabilitar
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 e a grade de fretes,
    * preparando o formulario para inclusao de novo registro
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Itra.Value                = ""
        loc_oPg.txt_4c_Idtransp.Value            = ""
        loc_oPg.txt_4c_Razao.Value                = ""
        loc_oPg.txt_4c_Endereco.Value             = ""
        loc_oPg.txt_4c_Bairro.Value                = ""
        loc_oPg.txt_4c_Cep.Value                   = ""
        loc_oPg.txt_4c_Cidade.Value                = ""
        loc_oPg.txt_4c_Uf.Value                    = ""
        loc_oPg.txt_4c_Tel1.Value                  = ""
        loc_oPg.txt_4c_Tel2.Value                  = ""
        loc_oPg.txt_4c_Cgc.Value                   = ""
        loc_oPg.txt_4c_Ies.Value                   = ""
        loc_oPg.txt_4c_Fax.Value                   = ""
        loc_oPg.txt_4c_TpConexao.Value             = ""
        loc_oPg.txt_4c_FtpEndereco.Value           = ""
        loc_oPg.txt_4c_FtpUsuario.Value            = ""
        loc_oPg.txt_4c_FtpSenha.Value              = ""
        loc_oPg.txt_4c_DirFtpEnvio.Value           = ""
        loc_oPg.txt_4c_DirFtpRecepcao.Value        = ""
        loc_oPg.txt_4c_DriveGeracao.Value          = ""
        loc_oPg.txt_4c_DriveLeitura.Value          = ""
        loc_oPg.chk_4c_LimpaDiretorioFtp.Value     = 0
        loc_oPg.chk_4c_LimpaDiretorioLocal.Value   = 0
        loc_oPg.txt_4c_UrlTransp.Value             = ""
        loc_oPg.opt_4c_TipoTransporte.Value        = 1
        loc_oPg.txt_4c_Senha2.Value                 = ""

        IF USED("cursor_4c_Estados")
            SELECT cursor_4c_Estados
            ZAP
        ENDIF
        loc_oPg.grd_4c_Estados.Refresh()
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
    * PUBLIC: harness TesteAutomatico.prg chama direto de fora da classe (regra #3)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames aninhados
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
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

        IF USED("cursor_4c_Estados")
            USE IN cursor_4c_Estados
        ENDIF

        IF USED("cursor_4c_EstadosTemp")
            USE IN cursor_4c_EstadosTemp
        ENDIF

        IF USED("cursor_4c_BuscaUf")
            USE IN cursor_4c_BuscaUf
        ENDIF

        IF USED("cursor_4c_BuscaMunicipio")
            USE IN cursor_4c_BuscaMunicipio
        ENDIF

        IF USED("cursor_4c_BuscaTra")
            USE IN cursor_4c_BuscaTra
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
