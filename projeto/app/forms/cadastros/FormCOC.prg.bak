*==============================================================================
* FormCOC.prg - Cadastro de Ocorrencias de Titulos
* Migrado de: SIGCDCOC.SCX (frmcadastro)
* Tabela: SigOpOco | PK: Codigos
* Migrado completamente (todas as 8 fases concluidas)
*==============================================================================

DEFINE CLASS FormCOC AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    *-- SIGCDCOC original: Width=1000, Height=600
    Height = 600
    Width = 1000
    Caption = ""
    AutoCenter = .T.
    ShowWindow = 1
    WindowType = 1
    ControlBox = .F.
    TitleBar = 0
    Themes = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cFiltroAtual    = ""
    this_cUltimoContas   = ""
    this_cUltimoDContas  = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro FormCOC.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura do formulario (chamado pelo FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Caption com acentos via CHR()
            THIS.Caption = "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos"

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("COCBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object COCBO.", "Erro")
            ELSE
                *-- Carregar parametros de SigCdPac (captions do OpcaoSNA)
                THIS.this_oBusinessObject.CarregarParametros()

                *-- Configurar estrutura visual (PageFrame + Pages + Containers)
                THIS.ConfigurarPageFrame()

                *-- Propagar Caption para labels do cabecalho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar dados iniciais (pula se estiver validando UI sem conexao SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top = -29
            .Left = 0
            .Width = THIS.Width
            .Height = THIS.Height + 29
            .Tabs = .F.
            .Page1.Caption = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Visible = .T.
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista) com cabecalho, botoes e grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho cinza (cntSombra no legado)
        *-- Top = 2 (original) + 29 (compensacao PageFrame.Top=-29) = 31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top = 31
            .Left = 0
            .Width = THIS.Width
            .Height = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top = 15
            .Left = 10
            .Width = 769
            .Height = 40
            .Caption = "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos"
            .FontName = "Tahoma"
            .FontSize = 16
            .FontBold = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top = 18
            .Left = 10
            .Width = 769
            .Height = 46
            .Caption = "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos"
            .FontName = "Tahoma"
            .FontSize = 16
            .FontBold = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH

        *-- Container botoes CRUD - lado direito (Grupo_Op no legado, Top=0+29=29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top = 29
            .Left = 542
            .Width = 390
            .Height = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .T.
        ENDWITH

        *-- Botao Incluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida/encerrar - padrao canonico (CLAUDE.md regra #10)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top = 29
            .Left = 917
            .Width = 90
            .Height = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .T.
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid da lista: Codigos(80), Descrs(600), Opers(80)
        *-- Top = 121 (original) + 29 (compensacao PageFrame) = 150
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 150
            .Left               = 12
            .Width              = 900
            .Height             = 474
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
            .Column1.Width            = 80
            .Column2.Width            = 600
            .Column3.Width            = 80
            .Column1.Header1.FontBold = .T.
            .Column2.Header1.FontBold = .T.
            .Column3.Header1.FontBold = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 com botoes e campos (primeira metade)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao Confirmar/Cancelar (Grupo_Salva no legado)
        *-- Top = 9 (original) + 29 (compensacao) = 38; Left = 817 (original)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 38
            .Left        = 817
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva no legado)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label Codigo
        *-- sayCodigo original: Top=109+29=138, Left=246
        loc_oPagina.AddObject("lbl_4c_SayCodigo", "Label")
        WITH loc_oPagina.lbl_4c_SayCodigo
            .Caption    = "C" + CHR(243) + "digo :"
            .Top        = 138
            .Left       = 246
            .Width      = 50
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Alignment  = 1
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- TextBox Codigo
        *-- getCodigo original: Top=106+29=135, Left=293, Width=80
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top               = 135
            .Left              = 293
            .Width             = 80
            .Height            = 20
            .InputMask         = "XXXXXXXXXX"
            .Format            = "!"
            .BorderStyle       = 1
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Label Descricao
        *-- sayDescricao original: Top=134+29=163, Left=233
        loc_oPagina.AddObject("lbl_4c_SayDescricao", "Label")
        WITH loc_oPagina.lbl_4c_SayDescricao
            .Caption    = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top        = 163
            .Left       = 233
            .Width      = 58
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Alignment  = 1
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- TextBox Descricao
        *-- getDescricao original: Top=131+29=160, Left=293, Width=220, Height=23
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Top           = 160
            .Left          = 293
            .Width         = 220
            .Height        = 23
            .InputMask     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
            .Format        = "!"
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Label Grupo
        *-- sayGrupo original: Top=159+29=188, Left=250
        loc_oPagina.AddObject("lbl_4c_SayGrupo", "Label")
        WITH loc_oPagina.lbl_4c_SayGrupo
            .Caption    = "Grupo :"
            .Top        = 188
            .Left       = 250
            .Width      = 41
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Alignment  = 1
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- TextBox Grupo - lookup F4 em SigCdGcr (fwBuscaExt no legado)
        *-- Get_grupo original: Top=156+29=185, Left=293, Width=80
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Top           = 185
            .Left          = 293
            .Width         = 80
            .Height        = 20
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "TeclaGrupo")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")

        *-- Label Conta
        *-- sayConta original: Top=184+29=213, Left=250
        loc_oPagina.AddObject("lbl_4c_SayConta", "Label")
        WITH loc_oPagina.lbl_4c_SayConta
            .Caption    = "Conta :"
            .Top        = 213
            .Left       = 250
            .Width      = 41
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Alignment  = 1
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- TextBox Conta - conta credito (F4 abre lookup SigCdCli)
        *-- Get_conta original: Top=181+29=210, Left=293, Width=80
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Top               = 210
            .Left              = 293
            .Width             = 80
            .Height            = 20
            .BorderStyle       = 1
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Value             = ""
            .Visible           = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "TeclaContaC")
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarContaC")

        *-- TextBox DConta - conta debito (sem label proprio, na mesma linha de Conta)
        *-- Get_dconta original: Top=181+29=210, Left=375, Width=250
        *-- Habilitado apenas quando Conta estiver vazio (replicando When do legado)
        loc_oPagina.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.txt_4c_Dconta
            .Top               = 210
            .Left              = 375
            .Width             = 250
            .Height            = 20
            .BorderStyle       = 1
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Value             = ""
            .Enabled           = .T.
            .Visible           = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dconta, "KeyPress", THIS, "TeclaDconta")
        BINDEVENT(loc_oPagina.txt_4c_Dconta, "KeyPress", THIS, "ValidarDconta")

        *-- Label Movimento (Say1)
        *-- Say1 original: Top=212+29=241, Left=227
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption    = "Movimento :"
            .Top        = 241
            .Left       = 227
            .Width      = 63
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Alignment  = 1
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- OptionGroup OpcaoOcorrencia (Debito=1/Credito=2)
        *-- OpcaoOcorrencia original: Top=207+29=236, Left=288 (buttons: Option1.Left=5, Option2.Left=72)
        loc_oPagina.AddObject("opt_4c_OpcaoOcorrencia", "OptionGroup")
        WITH loc_oPagina.opt_4c_OpcaoOcorrencia
            .ButtonCount = 2
            .Top         = 236
            .Left        = 288
            .Width       = 142
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_OpcaoOcorrencia.Buttons(1)
            .Caption   = "D" + CHR(233) + "bito"
            .Left      = 5
            .Top       = 5
            .Width     = 60
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_OpcaoOcorrencia.Buttons(2)
            .Caption   = "Cr" + CHR(233) + "dito"
            .Left      = 72
            .Top       = 5
            .Width     = 60
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Lanca Contabilidade (Say2)
        *-- Say2 original: Top=239+29=268, Left=183
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption    = "Lan" + CHR(231) + "a Contabilidade :"
            .Top        = 268
            .Left       = 183
            .Width      = 103
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Alignment  = 1
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- OptionGroup Opcaocontab (Sim=1 / Nao=2, padrao=2)
        *-- Opcaocontab original: Top=234+29=263, Left=288 (buttons: Option1.Left=5, Option2.Left=72)
        loc_oPagina.AddObject("opt_4c_Opcaocontab", "OptionGroup")
        WITH loc_oPagina.opt_4c_Opcaocontab
            .ButtonCount = 2
            .Top         = 263
            .Left        = 288
            .Width       = 122
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opcaocontab.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opcaocontab.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 72
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Opcao (Say3)
        *-- Say3 original: Top=264+29=293, Left=248
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption    = "Op" + CHR(231) + CHR(227) + "o :"
            .Top        = 293
            .Left       = 248
            .Width      = 41
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Alignment  = 1
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- OptionGroup OpcaoSNA (3 opcoes com captions de SigCdPac)
        *-- OpcaoSNA original: Top=260+29=289, Left=288, Width=197, Height=25
        *-- Buttons: Option1.Left=5, Option2.Left=73, Option3.Left=142
        loc_oPagina.AddObject("opt_4c_OpcaoSNA", "OptionGroup")
        WITH loc_oPagina.opt_4c_OpcaoSNA
            .ButtonCount = 3
            .Top         = 289
            .Left        = 288
            .Width       = 202
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_OpcaoSNA.Buttons(1)
            .Caption   = THIS.this_oBusinessObject.this_cTitOpcS
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_OpcaoSNA.Buttons(2)
            .Caption   = THIS.this_oBusinessObject.this_cTitOpcN
            .Left      = 73
            .Top       = 5
            .Width     = 37
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_OpcaoSNA.Buttons(3)
            .Caption   = THIS.this_oBusinessObject.this_cTitOpcA
            .Left      = 142
            .Top       = 5
            .Width     = 50
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca registros no BO e configura grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            CREATE CURSOR cursor_4c_Dados (Codigos C(10), Descrs C(30), Grupos C(10))
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroAtual)
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 3
                WITH loc_oGrid
                    .Column1.ControlSource    = "cursor_4c_Dados.Codigos"
                    .Column2.ControlSource    = "cursor_4c_Dados.Descrs"
                    .Column3.ControlSource    = "cursor_4c_Dados.Grupos"
                    .Column1.Width            = 80
                    .Column2.Width            = 600
                    .Column3.Width            = 80
                    .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
                    .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                    .Column3.Header1.Caption  = "Grupo"
                    .Column1.Header1.FontBold = .T.
                    .Column2.Header1.FontBold = .T.
                    .Column3.Header1.FontBold = .T.
                ENDWITH
                THIS.FormatarGridLista(loc_oGrid)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Alterar")
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

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirmou
        loc_cCodigo    = ""
        loc_lConfirmou = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + ;
                ALLTRIM(THIS.this_oBusinessObject.this_cCodigos) + " - " + ;
                ALLTRIM(THIS.this_oBusinessObject.this_cDescrs) + "'?", ;
                "Confirmar Exclus" + CHR(227) + "o")

            IF loc_lConfirmou
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra registros por codigo ou descricao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca
        loc_cBusca = ""

        loc_cBusca = INPUTBOX("C" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
            "Buscar Ocorr" + CHR(234) + "ncia", "")

        IF VARTYPE(loc_cBusca) = "C"
            loc_cBusca = ALLTRIM(loc_cBusca)
            IF !EMPTY(loc_cBusca)
                THIS.this_cFiltroAtual = "Codigos LIKE " + EscaparSQL("%" + loc_cBusca + "%")
            ELSE
                THIS.this_cFiltroAtual = ""
            ENDIF
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva o registro atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validar Codigo (obrigatorio apenas no modo INCLUIR)
        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
                MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!", "Validar")
                loc_oPg2.txt_4c_Codigo.SetFocus
                RETURN
            ENDIF
            IF THIS.this_oBusinessObject.VerificarCodigoExiste(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Validar")
                loc_oPg2.txt_4c_Codigo.SetFocus
                RETURN
            ENDIF
        ENDIF

        *-- Validar Grupo (obrigatorio em INCLUIR e ALTERAR)
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value))
                MsgAviso("Grupo Inv" + CHR(225) + "lido!", "Validar")
                loc_oPg2.txt_4c_Grupo.SetFocus
                RETURN
            ENDIF
        ENDIF

        *-- Validar Conta (obrigatorio em INCLUIR e ALTERAR, per legado)
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
                MsgAviso("Conta Inv" + CHR(225) + "lida!", "Validar")
                loc_oPg2.txt_4c_Conta.SetFocus
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupo - Trata F4 no campo Grupo para abrir lookup SigCdGcr
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida codigo do Grupo contra SigCdGcr ao sair do campo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo
        loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)

        IF EMPTY(loc_cGrupo)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.BuscarGrupo(loc_cGrupo)
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
        ELSE
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            THIS.AbrirBuscaGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - Abre picker FormBuscaAuxiliar para SigCdGcr
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oBusca, loc_cGrupo
        loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
            "Grupo de Conta Corrente")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                SELECT cursor_4c_BuscaGrupo
                THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ;
                    ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaContaC - Trata F4 no campo Conta para abrir lookup
    *--------------------------------------------------------------------------
    PROCEDURE TeclaContaC(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaContaC()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaC - Valida conta ao perder foco; habilita/desabilita dconta
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaC(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta
        loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)

        IF loc_cConta == THIS.this_cUltimoContas
            THIS.AtualizarHabilitacaoDconta()
            RETURN
        ENDIF
        THIS.this_cUltimoContas = loc_cConta

        IF EMPTY(loc_cConta)
            THIS.AtualizarHabilitacaoDconta()
            RETURN
        ENDIF

        LOCAL loc_cSQL, loc_nResult
        loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
                   " WHERE Iclis = " + EscaparSQL(loc_cConta)

        IF USED("cursor_4c_ChkConta")
            USE IN cursor_4c_ChkConta
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkConta") = 0
            THIS.AbrirBuscaContaC()
        ENDIF

        IF USED("cursor_4c_ChkConta")
            USE IN cursor_4c_ChkConta
        ENDIF

        THIS.AtualizarHabilitacaoDconta()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaContaC - Abre picker FormBuscaAuxiliar para conta credito (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaContaC()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPg2.txt_4c_Conta.Enabled
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cConta
        loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaContaC", "Iclis", loc_cConta, ;
            "Buscar Conta")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Iclis",  "", "Conta")
                loc_oBusca.mAddColuna("Rclis",  "", "Nome")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaC")
                SELECT cursor_4c_BuscaContaC
                loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaContaC.Iclis)
                THIS.this_cUltimoContas     = ALLTRIM(cursor_4c_BuscaContaC.Iclis)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaContaC")
            USE IN cursor_4c_BuscaContaC
        ENDIF

        THIS.AtualizarHabilitacaoDconta()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDconta - Trata F4 no campo DConta para abrir lookup
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDconta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaDconta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDconta - Valida dconta ao perder foco
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDconta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDConta
        loc_cDConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dconta.Value)

        IF loc_cDConta == THIS.this_cUltimoDContas
            RETURN
        ENDIF
        THIS.this_cUltimoDContas = loc_cDConta

        IF EMPTY(loc_cDConta)
            RETURN
        ENDIF

        LOCAL loc_cSQL, loc_nResult
        loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
                   " WHERE Iclis = " + EscaparSQL(loc_cDConta)

        IF USED("cursor_4c_ChkDConta")
            USE IN cursor_4c_ChkDConta
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDConta")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkDConta") = 0
            THIS.AbrirBuscaDconta()
        ENDIF

        IF USED("cursor_4c_ChkDConta")
            USE IN cursor_4c_ChkDConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDconta - Abre picker FormBuscaAuxiliar para conta debito (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDconta()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPg2.txt_4c_Dconta.Enabled
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cDConta
        loc_cDConta = ALLTRIM(loc_oPg2.txt_4c_Dconta.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaDConta", "Iclis", loc_cDConta, ;
            "Buscar Conta D" + CHR(233) + "bito")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Iclis",  "", "Conta")
                loc_oBusca.mAddColuna("Rclis",  "", "Nome")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDConta")
                SELECT cursor_4c_BuscaDConta
                loc_oPg2.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaDConta.Iclis)
                THIS.this_cUltimoDContas     = ALLTRIM(cursor_4c_BuscaDConta.Iclis)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaDConta")
            USE IN cursor_4c_BuscaDConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarHabilitacaoDconta - Habilita DConta apenas quando Conta esta vazio
    * Replica logica When do campo Get_dconta no legado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarHabilitacaoDconta()
        LOCAL loc_oPg2, loc_lContaVazia
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lContaVazia = EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value))

        *-- DConta so fica acessivel quando Conta estiver vazio (legado: When=EMPTY(get_conta))
        *-- Respeitar tambem o modo atual: se VISUALIZAR, ambos desabilitados
        IF THIS.this_cModoAtual = "VISUALIZAR"
            loc_oPg2.txt_4c_Dconta.Enabled = .F.
        ELSE
            loc_oPg2.txt_4c_Dconta.Enabled = loc_lContaVazia
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_nOpers, loc_nContabs, loc_nNotas
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(NVL(.this_cCodigos, ""))
            loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(NVL(.this_cDescrs,  ""))
            loc_oPg2.txt_4c_Grupo.Value     = ALLTRIM(NVL(.this_cGrupos,  ""))
            loc_oPg2.txt_4c_Conta.Value     = ALLTRIM(NVL(.this_cContas,  ""))
            loc_oPg2.txt_4c_Dconta.Value    = ALLTRIM(NVL(.this_cDContas, ""))

            *-- OpcaoOcorrencia: "DB"=1 (Debito), "CR"=2 (Credito)
            IF ALLTRIM(NVL(.this_cOpers, "")) = "DB"
                loc_oPg2.opt_4c_OpcaoOcorrencia.Value = 1
            ELSE
                loc_oPg2.opt_4c_OpcaoOcorrencia.Value = 2
            ENDIF

            *-- Opcaocontab: 1=Sim, 2=Nao (default 2 para novos registros)
            loc_nContabs = NVL(.this_nContabs, 0)
            loc_oPg2.opt_4c_Opcaocontab.Value = IIF(loc_nContabs = 1, 1, 2)

            *-- OpcaoSNA: 1=Sim, 2=Nao, 3=Ambos (0=nenhum)
            loc_nNotas = NVL(.this_nNotas, 0)
            loc_oPg2.opt_4c_OpcaoSNA.Value = IIF(INLIST(loc_nNotas, 1, 2, 3), loc_nNotas, 0)
        ENDWITH

        THIS.this_cUltimoContas  = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
        THIS.this_cUltimoDContas = ALLTRIM(loc_oPg2.txt_4c_Dconta.Value)
        THIS.AtualizarHabilitacaoDconta()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados dos campos para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            .this_cDescrs  = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
            .this_cGrupos  = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            .this_cContas  = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
            .this_cDContas = ALLTRIM(loc_oPg2.txt_4c_Dconta.Value)

            *-- OpcaoOcorrencia: Value=1 -> "DB" (Debito), Value=2 -> "CR" (Credito)
            IF loc_oPg2.opt_4c_OpcaoOcorrencia.Value = 1
                .this_cOpers = "DB"
            ELSE
                .this_cOpers = "CR"
            ENDIF

            *-- Opcaocontab: Value diretamente (1=Sim, 2=Nao)
            .this_nContabs = loc_oPg2.opt_4c_Opcaocontab.Value

            *-- OpcaoSNA: Value diretamente (1=Sim, 2=Nao, 3=Ambos)
            .this_nNotas   = loc_oPg2.opt_4c_OpcaoSNA.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: editavel apenas em INCLUIR (PK nao muda em ALTERAR)
        loc_oPg2.txt_4c_Codigo.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        loc_oPg2.txt_4c_Descricao.Enabled              = par_lHabilitar
        loc_oPg2.txt_4c_Grupo.Enabled                  = par_lHabilitar
        loc_oPg2.txt_4c_Conta.Enabled                  = par_lHabilitar
        loc_oPg2.opt_4c_OpcaoOcorrencia.Enabled        = par_lHabilitar
        loc_oPg2.opt_4c_Opcaocontab.Enabled            = par_lHabilitar
        loc_oPg2.opt_4c_OpcaoSNA.Enabled               = par_lHabilitar

        *-- DConta: respeitando logica When (acessivel apenas quando Conta esta vazio)
        *-- Se par_lHabilitar=.F. (VISUALIZAR), dconta fica desabilitado
        *-- Se par_lHabilitar=.T., delegar para AtualizarHabilitacaoDconta
        IF !par_lHabilitar
            loc_oPg2.txt_4c_Dconta.Enabled = .F.
        ELSE
            THIS.AtualizarHabilitacaoDconta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value   = ""
        loc_oPg2.txt_4c_Descricao.Value = ""
        loc_oPg2.txt_4c_Grupo.Value     = ""
        loc_oPg2.txt_4c_Conta.Value     = ""
        loc_oPg2.txt_4c_Dconta.Value    = ""

        *-- OpcaoOcorrencia: sem selecao inicial para novo registro
        loc_oPg2.opt_4c_OpcaoOcorrencia.Value = 1

        *-- Opcaocontab: padrao = 2 (Nao) para novo registro (legado: .value=2 no INSERIR)
        loc_oPg2.opt_4c_Opcaocontab.Value = 2

        *-- OpcaoSNA: sem selecao inicial
        loc_oPg2.opt_4c_OpcaoSNA.Value = 0

        THIS.this_cUltimoContas  = ""
        THIS.this_cUltimoDContas = ""

        *-- DConta habilitado porque Conta estara vazio (reproduz logica When do legado)
        loc_oPg2.txt_4c_Dconta.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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
    * FormatarGridLista - Formata visual do grid da lista (Tahoma 8)
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
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
