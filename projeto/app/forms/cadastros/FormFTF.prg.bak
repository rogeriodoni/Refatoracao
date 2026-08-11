*==============================================================================
* FormFTF.prg - Cadastro de Finalizadoras (Tef)
* Migrado de: SIGCDFTF.SCX
* Tabela: SigFiNz
*==============================================================================

DEFINE CLASS FormFTF AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Finalizadoras (Tef)"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *==========================================================================
    * Init - Apenas delega para FormBase (que chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("FTFBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao criar FTFBO", "Erro")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inicializar FormFTF:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(100, 100, 100)
            .Visible   = .T.
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 2 + 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 15
            .Left      = 12
            .Width     = 769
            .Height    = 40
            .Caption   = THIS.Caption
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
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_Op no legado)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 0 + 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container Saida - padrao canonico (prevalece sobre PILAR 1)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid de lista (nordems=Ordem 80px, cdescrs=Descricao 337px)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 88 + 29
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .Visible            = .T.
        ENDWITH

        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.ColumnCount = 2

        WITH loc_oGrid
            .Column1.Width           = 80
            .Column1.Alignment       = 0
            .Column1.Header1.Caption = "Ordem"
            .Column2.Width           = 337
            .Column2.Alignment       = 0
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- BINDEVENTs para botoes (metodos PUBLIC para funcionar com BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar e campos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 4 + 29
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Label e TextBox: Ordem (Say1 / Get_ordem - nordems numeric 2,0)
        *-- Posicoes do original compensadas +29 (PageFrame.Top=-29)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Ordem : "
            .Top       = 147 + 29
            .Left      = 200
            .Width     = 50
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
        WITH loc_oPagina.txt_4c_Ordem
            .Value     = 0
            .Top       = 144 + 29
            .Left      = 251
            .Width     = 24
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99"
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label e TextBox: Descricao (Say2 / Get_descr - cdescrs char 20)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 172 + 29
            .Left      = 183
            .Width     = 67
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value     = ""
            .Top       = 169 + 29
            .Left      = 252
            .Width     = 149
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs botoes Page2 (metodos PUBLIC para BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 via FTFBO.Buscar()
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Lista")
                CREATE CURSOR cursor_4c_Lista (nordems N(2,0), cdescrs C(20))
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.RecordSource        = "crSigFiNz"
                loc_oGrid.Column1.ControlSource = "crSigFiNz.nordems"
                loc_oGrid.Column2.ControlSource = "crSigFiNz.cdescrs"

                WITH loc_oGrid
                    .Column1.Width           = 80
                    .Column1.Alignment       = 0
                    .Column1.Header1.Caption = "Ordem"
                    .Column2.Width           = 337
                    .Column2.Alignment       = 0
                    .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarLista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os campos do Form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            loc_oPg2.txt_4c_Ordem.Value = THIS.this_oBusinessObject.this_nOrdem
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            loc_oPg2.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDescricao
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do Form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            THIS.this_oBusinessObject.this_nOrdem = loc_oPg2.txt_4c_Ordem.Value
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao na Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- txt_4c_Ordem: habilitado apenas no modo INCLUIR (PK nao editavel em ALTERAR)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            loc_oPg2.txt_4c_Ordem.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            loc_oPg2.txt_4c_Descr.Enabled = par_lHabilitar
        ENDIF

        *-- Botao Confirmar: desabilitado em modo VISUALIZAR
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos na Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            loc_oPg2.txt_4c_Ordem.Value = 0
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            loc_oPg2.txt_4c_Descr.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lTemRegistro
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Page1: habilitar botoes de acao apenas quando ha registro selecionado
        loc_lTemRegistro = USED("crSigFiNz") AND !EOF("crSigFiNz") AND RECCOUNT("crSigFiNz") > 0

        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            WITH loc_oPg1.cnt_4c_Botoes
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                    .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                    .cmd_4c_Alterar.Enabled = loc_lTemRegistro
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                    .cmd_4c_Excluir.Enabled = loc_lTemRegistro
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF

        *-- Page2: ajustar Confirmar conforme modo (desabilitado em VISUALIZAR)
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                    (THIS.this_cModoAtual != "VISUALIZAR")
            ENDIF
        ENDIF

        *-- Posicionar foco conforme modo (replica logica do legado)
        DO CASE
            CASE THIS.this_cModoAtual = "INCLUIR"
                IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5) AND loc_oPg2.txt_4c_Ordem.Enabled
                    loc_oPg2.txt_4c_Ordem.SetFocus()
                ENDIF
            CASE THIS.this_cModoAtual = "ALTERAR"
                IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
                    loc_oPg2.txt_4c_Descr.SetFocus()
                ENDIF
            CASE INLIST(THIS.this_cModoAtual, "VISUALIZAR")
                IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
                    ENDIF
                ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado para consulta
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nOrdem
        loc_nOrdem = 0

        IF !USED("crSigFiNz") OR EOF("crSigFiNz")
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        SELECT crSigFiNz
        loc_nOrdem = crSigFiNz.nordems

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nOrdem)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nOrdem
        loc_nOrdem = 0

        IF !USED("crSigFiNz") OR EOF("crSigFiNz")
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        SELECT crSigFiNz
        loc_nOrdem = crSigFiNz.nordems

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nOrdem)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nOrdem
        loc_nOrdem = 0

        IF !USED("crSigFiNz") OR EOF("crSigFiNz")
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        SELECT crSigFiNz
        loc_nOrdem = crSigFiNz.nordems

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Finalizadora ordem " + ;
                        TRANSFORM(loc_nOrdem) + "?", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nOrdem)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar e posiciona cursor no registro
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_nOrdemSel, loc_oGrid
        loc_nOrdemSel = 0

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigFiNz", "cursor_4c_BuscaFTF", "nordems", 0, ;
                "Buscar Finalizadora (Tef)")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("nordems", "", "Ordem")
                loc_oBusca.mAddColuna("cdescrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFTF")
                    SELECT cursor_4c_BuscaFTF
                    loc_nOrdemSel = cursor_4c_BuscaFTF.nordems
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaFTF")
                USE IN cursor_4c_BuscaFTF
            ENDIF

            IF loc_nOrdemSel > 0 AND USED("crSigFiNz")
                SELECT crSigFiNz
                LOCATE FOR nordems = loc_nOrdemSel
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva o registro (Confirmar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_nOrdem, loc_oPg2
        loc_lSucesso = .F.
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_nOrdem   = loc_oPg2.txt_4c_Ordem.Value

        *-- Validacao: ordem invalida em INCLUIR (antes do TRY - RETURN permitido)
        IF THIS.this_cModoAtual = "INCLUIR" AND loc_nOrdem <= 0
            MsgAviso("Ordem inv" + CHR(225) + "lida!", "Validar")
            loc_oPg2.txt_4c_Ordem.SetFocus()
            RETURN .F.
        ENDIF

        *-- Validacao: ordem duplicada em INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarOrdemExistente(loc_nOrdem)
                MsgAviso("Ordem j" + CHR(225) + " cadastrada!", "Validar")
                loc_oPg2.txt_4c_Ordem.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        *-- Validacao: descricao obrigatoria em INCLUIR e ALTERAR
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descr.Value))
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Validar")
                loc_oPg2.txt_4c_Descr.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Salvar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
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

    *==========================================================================
    * Destroy - Limpa recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
