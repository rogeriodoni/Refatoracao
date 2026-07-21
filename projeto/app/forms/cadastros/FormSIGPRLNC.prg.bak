*==============================================================================
* FormSIGPRLNC.prg - Formulario de Cadastro de Lancamentos de Conta Corrente
* Tabela: SigClLan (grupos, contas, cocos - lancamentos/ocorrencias por conta)
* Herdado de: FormBase (arquitetura em camadas - PILAR 3)
*==============================================================================
DEFINE CLASS FormSIGPRLNC AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity: Width=1000, Height=600 do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Lancamentos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Business Object e modo de operacao
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Estado do registro selecionado na Page1 para carregar em Page2
    this_cGrupoAtual     = ""
    this_cContaAtual     = ""
    this_cGruContasAtual = ""

    *--------------------------------------------------------------------------
    * Init - DODEFAULT() ja chama InicializarForm() via FormBase.Init()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao completa do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar cursor local para lista de ocorrencias (equivalente ao csSigClLan do legado)
            IF USED("cursor_4c_OcoLocal")
                USE IN cursor_4c_OcoLocal
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_OcoLocal (Grupos C(10), Contas C(10), Cocos C(2), descs C(30))
            SET NULL OFF
            INDEX ON Cocos TAG Cocos

            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRLNCBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SIGPRLNCBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.Caption = "Cadastro de Lan" + CHR(231) + "amentos"

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura do formulario
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormSIGPRLNC:" + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                        loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top        = -29
            .Left       = 0
            .Width      = 1003
            .Height     = 629
            .PageCount  = 2
            .Tabs       = .F.
            .Visible    = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de lancamentos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (cntSombra: Top=2+29=31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Left=542, Top=29 - 5 botoes: Incluir Visualizar Alterar Excluir Buscar)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle   = 0
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida canonico (Left=917, Width=90, cmd_4c_Encerrar 75x75)
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lancamentos: Grupos/Contas distintos de SigClLan
        *-- Top=117 (abaixo do cabecalho h=80 em top=31, com margem)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 2
            .Width              = 950
            .Height             = 452
            .ColumnCount        = 2
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

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: campos de identificacao (Grupo/Conta) e botoes
    * Fase 5/8: Container botoes + labels/textboxes de Grupo e Conta
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes de acao (Grupo_Salva: Left=844, Top=-3+29=26 -> canonico 38)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 38
            .Left        = 819
            .Width       = 165
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (Grupo_Salva.Salva: Left=5, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Salvar"
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Grupo_Salva.Cancelar: Left=80, Top=5)
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label "Grupo : " (Say2: Top=130+29=159, Left=257)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Grupo : "
            .Top       = 159
            .Left      = 257
            .Width     = 80
            .Height    = 18
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grupo (Get_Grupos: Top=127+29=156, Left=300, Width=80)
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Top           = 156
            .Left          = 300
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")

        *-- TextBox Descricao do Grupo (Get_Desc_Gru: Top=127+29=156, Left=382, Width=360)
        loc_oPagina.AddObject("txt_4c_Desc_Gru", "TextBox")
        WITH loc_oPagina.txt_4c_Desc_Gru
            .Value         = ""
            .Top           = 156
            .Left          = 382
            .Width         = 360
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Conta : " (Say3: Top=155+29=184, Left=257)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Conta : "
            .Top       = 184
            .Left      = 257
            .Width     = 80
            .Height    = 18
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conta (Get_Contas: Top=152+29=181, Left=300, Width=80)
        loc_oPagina.AddObject("txt_4c_Contas", "TextBox")
        WITH loc_oPagina.txt_4c_Contas
            .Value         = ""
            .Top           = 181
            .Left          = 300
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "ValidarContaLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "ContaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Contas, "DblClick", THIS, "ContaDblClick")

        *-- TextBox Descricao da Conta (Get_Desc_Con: Top=152+29=181, Left=382, Width=360)
        loc_oPagina.AddObject("txt_4c_Desc_Con", "TextBox")
        WITH loc_oPagina.txt_4c_Desc_Con
            .Value         = ""
            .Top           = 181
            .Left          = 382
            .Width         = 360
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Botao Inserir Ocorrencia (inserir: Top=335+29=364, Left=629, 40x40)
        loc_oPagina.AddObject("cmd_4c_InserirOco", "CommandButton")
        WITH loc_oPagina.cmd_4c_InserirOco
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
            .PicturePosition = 7
            .Top             = 364
            .Left            = 629
            .Width           = 40
            .Height          = 40
            .FontName        = "Arial"
            .FontSize        = 9
            .FontBold        = .T.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(0, 128, 0)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Inserir"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InserirOco, "Click", THIS, "BtnInserirOcoClick")

        *-- Botao Excluir Ocorrencia (excluir: Top=375+29=404, Left=629, 40x40)
        loc_oPagina.AddObject("cmd_4c_ExcluirOco", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirOco
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 7
            .Top             = 404
            .Left            = 629
            .Width           = 40
            .Height          = 40
            .FontName        = "Arial"
            .FontSize        = 9
            .FontBold        = .T.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(255, 0, 0)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Excluir"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirOco, "Click", THIS, "BtnExcluirOcoClick")

        *-- Grid de Ocorrencias (Gradeoco: Top=181+29=210, Left=300, Width=324, Height=403)
        LOCAL loc_oGrid
        loc_oPagina.AddObject("grd_4c_Ocorrencias", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Ocorrencias
        loc_oGrid.ColumnCount = 3
        loc_oGrid.RecordSource = "cursor_4c_OcoLocal"
        loc_oGrid.ColumnCount  = 2
        WITH loc_oGrid
            .Top                = 210
            .Left               = 300
            .Width              = 324
            .Height             = 403
            .FontName           = "Verdana"
            .FontSize           = 8
            .Panel              = 1
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .Visible            = .T.

            .Column1.ControlSource     = "cursor_4c_OcoLocal.Cocos"
            .Column1.Width             = 70
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.Visible           = .T.
            .Column1.Sparse            = .F.
            .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Text1.FontName    = "Verdana"
            .Column1.Text1.FontSize    = 8
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0

            .Column2.ControlSource     = "cursor_4c_OcoLocal.descs"
            .Column2.Width             = 220
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.Visible           = .T.
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Text1.FontName    = "Verdana"
            .Column2.Text1.FontSize    = 8
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.
        ENDWITH
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca lancamentos distintos e vincula ao grd_4c_Lista
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (grupos C(10), contas C(10), grucontas C(20))
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount ANTES do WITH (Problema 48/36)
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 2

                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.grupos"
                        .Column1.Width           = 200
                        .Column1.Header1.Caption = "Ocorr" + CHR(234) + "ncia"

                        .Column2.ControlSource   = "cursor_4c_Dados.contas"
                        .Column2.Width           = 200
                        .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    THIS.AjustarBotoesPorModo()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormSIGPRLNC.CarregarLista: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual uniforme ao grid da Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPaginaDados - Carrega campos de identificacao e ocorrencias na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarPaginaDados(par_cGruContas)
        LOCAL loc_lSucesso, loc_oPagina, loc_cGrupos, loc_cContas
        loc_lSucesso = .F.
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_cGrupos  = ALLTRIM(LEFT(par_cGruContas, 10))
        loc_cContas  = ALLTRIM(RIGHT(par_cGruContas, 10))

        TRY
            *-- Preencher campos de identificacao (criados na Fase 5)
            IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                loc_oPagina.txt_4c_Grupo.Value = loc_cGrupos
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
                loc_oPagina.txt_4c_Contas.Value = loc_cContas
            ENDIF

            *-- Carregar descricoes via SQL
            THIS.IniciarDescricoes()

            *-- Carregar ocorrencias no cursor local (grid vinculado na Fase 6)
            IF USED("cursor_4c_OcoLocal")
                ZAP IN cursor_4c_OcoLocal
            ENDIF

            IF THIS.this_oBusinessObject.BuscarOcorrencias(par_cGruContas)
                *-- Copiar ocorrencias do cursor SQL para cursor local (preserva grid)
                IF USED("cursor_4c_Ocorrencias") AND RECCOUNT("cursor_4c_Ocorrencias") > 0
                    SELECT cursor_4c_Ocorrencias
                    GO TOP
                    DO WHILE !EOF()
                        SELECT cursor_4c_OcoLocal
                        APPEND BLANK
                        REPLACE Grupos WITH ALLTRIM(cursor_4c_Ocorrencias.grupos)
                        REPLACE Contas WITH ALLTRIM(cursor_4c_Ocorrencias.contas)
                        REPLACE Cocos  WITH ALLTRIM(cursor_4c_Ocorrencias.cocos)
                        REPLACE descs  WITH ALLTRIM(cursor_4c_Ocorrencias.descs)
                        SELECT cursor_4c_Ocorrencias
                        SKIP
                    ENDDO
                ENDIF
                GO TOP IN cursor_4c_OcoLocal
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPaginaDados: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera propriedades do BO e campos da Page2 para modo de inclusao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cGrupos    = ""
        THIS.this_oBusinessObject.this_cContas    = ""
        THIS.this_oBusinessObject.this_cCocos     = ""
        THIS.this_oBusinessObject.this_cCidChaves = ""
        THIS.this_oBusinessObject.this_cGruContas = ""

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_oPagina.txt_4c_Grupo.Value    = ""
            loc_oPagina.txt_4c_Desc_Gru.Value = ""
            loc_oPagina.txt_4c_Contas.Value   = ""
            loc_oPagina.txt_4c_Desc_Con.Value = ""
        ENDIF

        IF USED("cursor_4c_OcoLocal")
            ZAP IN cursor_4c_OcoLocal
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Navega para Page2 em modo de inclusao de novo grupo+conta
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual      = "INSERIR"
        THIS.this_cGrupoAtual     = ""
        THIS.this_cContaAtual     = ""
        THIS.this_cGruContasAtual = ""
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Navega para Page2 em modo consulta (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
        loc_cGrupos    = ""
        loc_cContas    = ""
        loc_cGruContas = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cGrupos    = ALLTRIM(grupos)
            loc_cContas    = ALLTRIM(contas)
            loc_cGruContas = ALLTRIM(grucontas)
        ELSE
            MsgAviso("Selecione um registro na lista.", "Selecionar")
            RETURN
        ENDIF

        THIS.this_cModoAtual      = "PROCURAR"
        THIS.this_cGrupoAtual     = loc_cGrupos
        THIS.this_cContaAtual     = loc_cContas
        THIS.this_cGruContasAtual = loc_cGruContas
        THIS.HabilitarCampos(.T.)

        THIS.CarregarPaginaDados(loc_cGruContas)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Navega para Page2 em modo de alteracao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
        loc_cGrupos    = ""
        loc_cContas    = ""
        loc_cGruContas = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cGrupos    = ALLTRIM(grupos)
            loc_cContas    = ALLTRIM(contas)
            loc_cGruContas = ALLTRIM(grucontas)
        ELSE
            MsgAviso("Selecione um registro na lista.", "Selecionar")
            RETURN
        ENDIF

        THIS.this_cModoAtual      = "ALTERAR"
        THIS.this_cGrupoAtual     = loc_cGrupos
        THIS.this_cContaAtual     = loc_cContas
        THIS.this_cGruContasAtual = loc_cGruContas
        THIS.HabilitarCampos(.T.)

        THIS.CarregarPaginaDados(loc_cGruContas)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui todos os lancamentos do grupo+conta selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cGrupos, loc_cContas, loc_cGruContas, loc_lConfirmar
        loc_cGrupos    = ""
        loc_cContas    = ""
        loc_cGruContas = ""
        loc_lConfirmar = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cGrupos    = ALLTRIM(grupos)
            loc_cContas    = ALLTRIM(contas)
            loc_cGruContas = ALLTRIM(grucontas)
        ELSE
            MsgAviso("Selecione um registro na lista.", "Selecionar")
            RETURN
        ENDIF

        loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o de todos os lan" + CHR(231) + "amentos" + CHR(13) + ;
                                     "do grupo '" + loc_cGrupos + "' / conta '" + loc_cContas + "'?", ;
                                     "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirmar
            IF THIS.this_oBusinessObject.ExcluirPorGruContas(loc_cGruContas)
                MsgInfo("Lan" + CHR(231) + "amentos exclu" + CHR(237) + "dos com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega a lista aplicando filtro atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva ocorrencias do grupo+conta (modo INSERIR/ALTERAR)
    *                  ou habilita grid de pesquisa (modo PROCURAR)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cGrupos, loc_cContas, loc_cGruContas
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)

        IF THIS.this_cModoAtual = "PROCURAR"
            IF !EMPTY(loc_cGrupos) AND EMPTY(loc_cContas)
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o ! Para pesquisar " + CHR(233) + ;
                         " necess" + CHR(225) + "rio escolher tamb" + CHR(233) + "m a Conta.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Contas.SetFocus
                RETURN
            ENDIF
            *-- Recarregar ocorrencias para o grupo+conta informado
            loc_cGruContas = PADR(loc_cGrupos, 10) + PADR(loc_cContas, 10)
            THIS.this_cGruContasAtual = loc_cGruContas
            THIS.CarregarPaginaDados(loc_cGruContas)
            *-- Habilitar grid para visualizacao (criado na Fase 6)
            IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
                loc_oPagina.grd_4c_Ocorrencias.Enabled = .T.
            ENDIF
            RETURN
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            IF EMPTY(loc_cGrupos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Grupo.SetFocus
                RETURN
            ENDIF
            IF EMPTY(loc_cContas)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conta", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Contas.SetFocus
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.SalvarOcorrencias(loc_cGrupos, loc_cContas, "cursor_4c_OcoLocal")
                MsgInfo("Lan" + CHR(231) + "amentos salvos com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela a operacao e volta para a lista (Page1)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual      = "LISTA"
        THIS.this_cGrupoAtual     = ""
        THIS.this_cContaAtual     = ""
        THIS.this_cGruContasAtual = ""
        IF USED("cursor_4c_OcoLocal")
            ZAP IN cursor_4c_OcoLocal
        ENDIF
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarDescricoes - Carrega descricoes de Grupo (SigCdGcr) e Conta (SigCdCli)
    * Equivalente ao procedure inicdesc do legado
    *--------------------------------------------------------------------------
    PROCEDURE IniciarDescricoes()
        LOCAL loc_oPagina, loc_cGrupo, loc_cConta, loc_nRes, loc_cSQL
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)

        *-- Busca descricao do grupo em SigCdGcr (Codigos/Descrs com 'r')
        IF !EMPTY(loc_cGrupo)
            TRY
                loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
                IF USED("cursor_4c_TmpGrupo")
                    USE IN cursor_4c_TmpGrupo
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGrupo")
                IF loc_nRes >= 0 AND USED("cursor_4c_TmpGrupo") AND RECCOUNT("cursor_4c_TmpGrupo") > 0
                    SELECT cursor_4c_TmpGrupo
                    loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
                ELSE
                    loc_oPagina.txt_4c_Desc_Gru.Value = ""
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
            ENDTRY
            IF USED("cursor_4c_TmpGrupo")
                USE IN cursor_4c_TmpGrupo
            ENDIF
        ELSE
            loc_oPagina.txt_4c_Desc_Gru.Value = ""
        ENDIF

        *-- Busca descricao da conta em SigCdCli (Iclis/Rclis)
        IF !EMPTY(loc_cConta)
            TRY
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
                IF USED("cursor_4c_TmpConta")
                    USE IN cursor_4c_TmpConta
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpConta")
                IF loc_nRes >= 0 AND USED("cursor_4c_TmpConta") AND RECCOUNT("cursor_4c_TmpConta") > 0
                    SELECT cursor_4c_TmpConta
                    loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
                ELSE
                    loc_oPagina.txt_4c_Desc_Con.Value = ""
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
            ENDTRY
            IF USED("cursor_4c_TmpConta")
                USE IN cursor_4c_TmpConta
            ENDIF
        ELSE
            loc_oPagina.txt_4c_Desc_Con.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoLostFocus - Valida/lookup do codigo de Grupo ao sair do campo
    * Substitui fAcessoContab() do legado usando SQL + FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF
        LOCAL loc_oPagina, loc_cGrupo, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cGrupo)
            loc_oPagina.txt_4c_Desc_Gru.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                SELECT cursor_4c_BuscaGrupo
                loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
                loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
            ELSE
                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
                    "Grupo de Conta Corrente")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                        SELECT cursor_4c_BuscaGrupo
                        loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
                        loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
                    ELSE
                        loc_oPagina.txt_4c_Grupo.Value    = ""
                        loc_oPagina.txt_4c_Desc_Gru.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaLostFocus - Valida/lookup do codigo de Conta ao sair do campo
    * Substitui fAcessoContas() do legado usando SQL + FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF
        LOCAL loc_oPagina, loc_cConta, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)

        IF EMPTY(loc_cConta)
            loc_oPagina.txt_4c_Desc_Con.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
                loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
            ELSE
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
                    "Conta Corrente")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis",  "", "Conta")
                        loc_oBusca.mAddColuna("Rclis",  "", "Nome")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                        SELECT cursor_4c_BuscaConta
                        loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
                        loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
                    ELSE
                        loc_oPagina.txt_4c_Contas.Value   = ""
                        loc_oPagina.txt_4c_Desc_Con.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar conta: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos e botoes de acordo com o modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEditarIdentif, loc_lEditarOco
        loc_oPagina        = THIS.pgf_4c_Paginas.Page2
        loc_lEditarIdentif = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "PROCURAR")
        loc_lEditarOco     = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_oPagina.txt_4c_Grupo.Enabled = loc_lEditarIdentif
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
            loc_oPagina.txt_4c_Contas.Enabled = loc_lEditarIdentif
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Gru", 5)
            loc_oPagina.txt_4c_Desc_Gru.ReadOnly = .T.
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Con", 5)
            loc_oPagina.txt_4c_Desc_Con.ReadOnly = .T.
        ENDIF

        *-- Grid de ocorrencias: editavel apenas em INSERIR/ALTERAR
        IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
            IF loc_lEditarOco
                loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .F.
                loc_oPagina.grd_4c_Ocorrencias.Enabled  = .T.
            ELSE
                loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .T.
                loc_oPagina.grd_4c_Ocorrencias.Enabled  = .F.
            ENDIF
        ENDIF

        *-- Botoes inserir/excluir de ocorrencias: visiveis apenas em INSERIR/ALTERAR
        IF PEMSTATUS(loc_oPagina, "cmd_4c_InserirOco", 5)
            loc_oPagina.cmd_4c_InserirOco.Visible = loc_lEditarOco
        ENDIF
        IF PEMSTATUS(loc_oPagina, "cmd_4c_ExcluirOco", 5)
            loc_oPagina.cmd_4c_ExcluirOco.Visible = loc_lEditarOco
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Valida ocorrencia (Cocos) ao mover na grade
    * Lookup em SigCcCco; verifica duplicidade; preenche descs automaticamente
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_cCocos, loc_cDescs, loc_cSQL, loc_nRes
        LOCAL loc_cCocosOk, loc_cDescsOk, loc_oBusca
        LOCAL loc_nPonteiro, loc_lDuplicado

        *-- Processar lookup apenas quando o usuario editou Column1 (Cocos - campo editavel)
        IF par_nColIndex != 1
            RETURN
        ENDIF

        IF !USED("cursor_4c_OcoLocal") OR EOF("cursor_4c_OcoLocal")
            RETURN
        ENDIF

        SELECT cursor_4c_OcoLocal
        loc_cCocos = ALLTRIM(cursor_4c_OcoLocal.Cocos)
        loc_cDescs = ALLTRIM(cursor_4c_OcoLocal.descs)

        *-- Cocos vazio: limpar descs e sair
        IF EMPTY(loc_cCocos)
            IF !EMPTY(loc_cDescs)
                REPLACE descs WITH ""
            ENDIF
            RETURN
        ENDIF

        loc_cCocosOk = ""
        loc_cDescsOk = ""

        TRY
            loc_cSQL = "SELECT Cods, Descs FROM SigCcCco WHERE Cods = " + EscaparSQL(loc_cCocos)
            IF USED("cursor_4c_BuscaCoco")
                USE IN cursor_4c_BuscaCoco
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")

            IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
                SELECT cursor_4c_BuscaCoco
                loc_cCocosOk = ALLTRIM(Cods)
                loc_cDescsOk = ALLTRIM(Descs)
            ELSE
                IF USED("cursor_4c_BuscaCoco")
                    USE IN cursor_4c_BuscaCoco
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCcCco", "cursor_4c_BuscaCoco", "Cods", loc_cCocos, ;
                    "Sele" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
                        SELECT cursor_4c_BuscaCoco
                        loc_cCocosOk = ALLTRIM(Cods)
                        loc_cDescsOk = ALLTRIM(Descs)
                    ELSE
                        loc_cCocosOk = ""
                        loc_cDescsOk = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

            *-- Verificar duplicidade de cocos no cursor local
            SELECT cursor_4c_OcoLocal
            loc_nPonteiro  = RECNO()
            loc_lDuplicado = .F.

            IF !EMPTY(loc_cCocosOk)
                SET ORDER TO Cocos
                IF SEEK(PADR(loc_cCocosOk, 2))
                    IF RECNO() != loc_nPonteiro
                        loc_lDuplicado = .T.
                    ENDIF
                ENDIF
                SET ORDER TO
                GO loc_nPonteiro
            ENDIF

            IF loc_lDuplicado
                MsgAviso("J" + CHR(225) + " existe um registro com esta ocorr" + CHR(234) + "ncia!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                REPLACE Cocos WITH ""
                REPLACE descs WITH ""
            ELSE
                REPLACE Cocos WITH loc_cCocosOk
                REPLACE descs WITH loc_cDescsOk
            ENDIF

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Ocorrencias", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Ocorrencias.Refresh()
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao validar ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaCoco")
            USE IN cursor_4c_BuscaCoco
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirOcoClick - Insere linha em branco no cursor de ocorrencias
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirOcoClick()
        LOCAL loc_oPagina, loc_cGrupos, loc_cContas
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
            RETURN
        ENDIF

        loc_cGrupos = ""
        loc_cContas = ""
        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
        ENDIF

        TRY
            SELECT cursor_4c_OcoLocal
            APPEND BLANK
            REPLACE Grupos WITH loc_cGrupos
            REPLACE Contas WITH loc_cContas
            loc_oPagina.grd_4c_Ocorrencias.Refresh()
            loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
        CATCH TO loException
            MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirOcoClick - Exclui linha corrente do cursor de ocorrencias
    * Mantem ao menos uma linha em branco para nova entrada (padrao legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirOcoClick()
        LOCAL loc_oPagina, loc_cGrupos, loc_cContas
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
            RETURN
        ENDIF

        IF NOT USED("cursor_4c_OcoLocal") OR RECCOUNT("cursor_4c_OcoLocal") = 0
            RETURN
        ENDIF

        loc_cGrupos = ""
        loc_cContas = ""
        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
        ENDIF

        TRY
            SELECT cursor_4c_OcoLocal
            DELETE
            GO BOTTOM
            IF EOF()
                APPEND BLANK
                REPLACE Grupos WITH loc_cGrupos
                REPLACE Contas WITH loc_cContas
            ENDIF
            loc_oPagina.grd_4c_Ocorrencias.Refresh()
            loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
        CATCH TO loException
            MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: F4 abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoDblClick - Handler DblClick de txt_4c_Grupo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoDblClick()
        THIS.AbrirLookupGrupo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Abre FormBuscaAuxiliar para Grupo (SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            RETURN
        ENDIF
        IF NOT loc_oPagina.txt_4c_Grupo.Enabled
            RETURN
        ENDIF

        LOCAL loc_oBusca
        TRY
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", "", ;
                "Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                    SELECT cursor_4c_BuscaGrupo
                    loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
                    loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de Grupo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaKeyPress - Handler KeyPress de txt_4c_Contas: F4 abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaDblClick - Handler DblClick de txt_4c_Contas
    *--------------------------------------------------------------------------
    PROCEDURE ContaDblClick()
        THIS.AbrirLookupConta()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - Abre FormBuscaAuxiliar para Conta (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
            RETURN
        ENDIF
        IF NOT loc_oPagina.txt_4c_Contas.Enabled
            RETURN
        ENDIF

        LOCAL loc_oBusca
        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "Iclis", "", ;
                "Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Iclis",  "", "Conta")
                loc_oBusca.mAddColuna("Rclis",  "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                    SELECT cursor_4c_BuscaConta
                    loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
                    loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de Conta: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Percorre controles recursivamente definindo Visible=.T.
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
    * FormParaBO - Transfere valores dos campos da Page2 para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cContas    = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
        THIS.this_oBusinessObject.this_cGruContas = PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), 10) + ;
                                                    PADR(ALLTRIM(loc_oPagina.txt_4c_Contas.Value), 10)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            RETURN
        ENDIF

        loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
        loc_oPagina.txt_4c_Desc_Gru.Value = ""
        loc_oPagina.txt_4c_Desc_Con.Value = ""
        THIS.IniciarDescricoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes de Page1 conforme dados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lTemRegistro
        loc_oPagina      = THIS.pgf_4c_Paginas.Page1
        loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

        IF NOT PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = .T.
        ENDIF
        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
        ENDIF
        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
        ENDIF
        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
        ENDIF
        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o Business Object e chama destruicao da classe pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
