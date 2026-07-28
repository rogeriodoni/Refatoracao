*==============================================================================
* FormCco.prg - Formulario de Cadastro de Classificacao de Contas
* Herda de   : FormBase
* Tabela     : SigCdClc (principal) + SigCdCmt (motivos/detalhes)
* Legado     : SigCdCco.SCX (frmcadastro)
* Fase 7/8   : Eventos principais adicionados (BtnIncluir/Alterar/Visualizar/Excluir)
*==============================================================================
DEFINE CLASS FormCco AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity - legado Height=629)
    Height      = 629
    Width       = 1000
    Caption     = "Cadastro de Classificacao de Contas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_lClientesFiltro = .F.    && Parametro pCli do legado (filtrar por grupo)

    *==========================================================================
    * Init - Corrige Caption com acentos e delega ao FormBase
    *==========================================================================
    PROCEDURE Init()
        THIS.Caption = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar BO
            THIS.this_oBusinessObject = CREATEOBJECT("CcoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar CcoBO", "FormCco.InicializarForm")
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor crMotivos ANTES de ConfigurarPageFrame (grd_4c_Motivos.RecordSource="crMotivos")
            IF USED("crMotivos")
                USE IN crMotivos
            ENDIF
            SET NULL ON
            CREATE CURSOR crMotivos (Codigos C(10), Descrs C(40), Tipos N(1))
            INDEX ON Codigos TAG Codigos
            SET NULL OFF

            *-- Montar estrutura visual
            THIS.ConfigurarPageFrame()
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Carregar dados iniciais (pula em modo ValidandoUI)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oBusinessObject.BuscarParametros()
                THIS.CarregarLista()
            ENDIF

            *-- Iniciar na pagina de Lista
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em FormCco.InicializarForm: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Legado: Pagina.Top=-28 -> compensacao +28 em todos os controles
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPg1, loc_oPg2

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -28
            .Left      = -1
            .Width     = THIS.Width + 2
            .Height    = THIS.Height + 30
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page2.BackColor = RGB(100, 100, 100)
        ENDWITH

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPg2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.ConfigurarPaginaLista(loc_oPg1)
        THIS.ConfigurarPaginaDados(loc_oPg2)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Fase 4: Grid + Botoes CRUD completos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista(par_oPagina)

        *-- Cabecalho cinza (cntSombra do legado, Top=0 -> +28 = 28)
        par_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH par_oPagina.cnt_4c_Cabecalho
            .Top         = 28
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op: Left=544, Top=-2 -> +28 = 26)
        par_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH par_oPagina.cnt_4c_Botoes
            .Top         = 26
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *-- Container Saida - padrao canonico (prevalece sobre SCX legado)
        par_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH par_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *-- Grid da lista (Top = 28+85+2 = 115, abaixo dos containers de cabecalho/botoes)
        par_oPagina.AddObject("grd_4c_Lista", "Grid")
        par_oPagina.grd_4c_Lista.RecordSource = ""
        par_oPagina.grd_4c_Lista.ColumnCount  = 8
        WITH par_oPagina.grd_4c_Lista
            .Top                = 115
            .Left               = 5
            .Width              = 990
            .Height             = 510
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .Visible            = .T.
        ENDWITH
        WITH par_oPagina.grd_4c_Lista.Column1
            .Header1.Caption = "Emp"
            .Width           = 50
            .Alignment       = 2
        ENDWITH
        WITH par_oPagina.grd_4c_Lista.Column2
            .Header1.Caption = "Grupo"
            .Width           = 90
            .Alignment       = 0
        ENDWITH
        WITH par_oPagina.grd_4c_Lista.Column3
            .Header1.Caption = "C" + CHR(243) + "digo"
            .Width           = 180
            .Alignment       = 0
        ENDWITH
        WITH par_oPagina.grd_4c_Lista.Column4
            .Header1.Caption = "Descri" + CHR(231) + CHR(245) + "es"
            .Width           = 290
            .Alignment       = 0
        ENDWITH
        WITH par_oPagina.grd_4c_Lista.Column5
            .Header1.Caption = "P"
            .Width           = 50
            .Alignment       = 2
        ENDWITH
        WITH par_oPagina.grd_4c_Lista.Column6
            .Header1.Caption = "Faixa Inicial"
            .Width           = 100
            .Alignment       = 1
        ENDWITH
        WITH par_oPagina.grd_4c_Lista.Column7
            .Header1.Caption = "Faixa Final"
            .Width           = 100
            .Alignment       = 1
        ENDWITH
        WITH par_oPagina.grd_4c_Lista.Column8
            .Header1.Caption = "Selecionavel"
            .Width           = 120
            .Alignment       = 0
        ENDWITH

        *-- BINDEVENTs dos botoes CRUD (metodos PUBLIC - sem PROTECTED)
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Fase 5: Container Salvar/Cancelar + primeiros 50% dos campos
    *         (Codigo, Descricao, ClcStatus, Grupo, Priori)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPagina)

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva: Left=841, Top=-3 -> +28=25)
        par_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH par_oPagina.cnt_4c_Salva
            .Top         = 25
            .Left        = 841
            .Width       = 165
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH par_oPagina.cnt_4c_Salva.cmd_4c_Salvar
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 1: Codigo + Descricao + Selecionavel
        *-- Top original 49-53 -> +28 = 77-81
        *----------------------------------------------------------------------

        *-- lbl_4c_Codigo (Say2: Left=95, Top=53 -> +28=81)
        par_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH par_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Left      = 95
            .Top       = 81
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Codigo (Get_codigo: Left=139, Top=49 -> +28=77, Width=80, codigos C80)
        par_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH par_oPagina.txt_4c_Codigo
            .Value         = ""
            .Left          = 139
            .Top           = 77
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .MaxLength     = 80
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Descricao (Say3: Left=270, Top=53 -> +28=81)
        par_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH par_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Left      = 270
            .Top       = 81
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Descricao (Get_descricao: Left=327, Top=49 -> +28=77, Width=220, descs C220)
        par_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH par_oPagina.txt_4c_Descricao
            .Value         = ""
            .Left          = 327
            .Top           = 77
            .Width         = 220
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .MaxLength     = 220
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_ClcStatus (Say8: Left=573, Top=52 -> +28=80)
        par_oPagina.AddObject("lbl_4c_ClcStatus", "Label")
        WITH par_oPagina.lbl_4c_ClcStatus
            .Caption   = "Selecionavel nos Cadastros :"
            .Left      = 573
            .Top       = 80
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_ClcStatus (Fwoption1: Left=711, Top=47 -> +28=75)
        *-- Value=1 (Sim, ClcStatus=1) / Value=2 (Nao, ClcStatus=2)
        par_oPagina.AddObject("opt_4c_ClcStatus", "OptionGroup")
        WITH par_oPagina.opt_4c_ClcStatus
            .ButtonCount = 2
            .Left        = 711
            .Top         = 75
            .Width       = 105
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.opt_4c_ClcStatus.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH par_oPagina.opt_4c_ClcStatus.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .Width     = 44
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 2: Grupo + Prioridade
        *-- Top original 74-78 -> +28 = 102-106
        *----------------------------------------------------------------------

        *-- lbl_4c_Grupo (Say1: Left=99, Top=78 -> +28=106)
        par_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH par_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo :"
            .Left      = 99
            .Top       = 106
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Grupo (Get_Grupo: Left=139, Top=74 -> +28=102, Width=80, grupos C10)
        *-- Lookup: SigCdGcr (Codigos/Descrs) via F3 (KeyPress) e LostFocus
        par_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH par_oPagina.txt_4c_Grupo
            .Value         = ""
            .Left          = 139
            .Top           = 102
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "TxtGrupoKeyPress")
        BINDEVENT(par_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")

        *-- lbl_4c_Priori (Say7: Left=268, Top=78 -> +28=106)
        par_oPagina.AddObject("lbl_4c_Priori", "Label")
        WITH par_oPagina.lbl_4c_Priori
            .Caption   = "Prioridade :"
            .Left      = 268
            .Top       = 106
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Priori (GetPriori: Left=327, Top=74 -> +28=102, Width=26, InputMask="99")
        par_oPagina.AddObject("txt_4c_Priori", "TextBox")
        WITH par_oPagina.txt_4c_Priori
            .Value         = 0
            .Left          = 327
            .Top           = 102
            .Width         = 26
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .InputMask     = "99"
            .MaxLength     = 2
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 3: Empresa + Faixa de + Faixa Ate
        *-- Top original 99-103 -> +28 = 127-131
        *----------------------------------------------------------------------

        *-- lbl_4c_Empresa (Say6: Left=87, Top=103 -> +28=131)
        par_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH par_oPagina.lbl_4c_Empresa
            .Caption   = "Empresa :"
            .Left      = 87
            .Top       = 131
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Emps (GetEmps: Left=139, Top=99 -> +28=127, Width=34, H=23, C(3))
        par_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH par_oPagina.txt_4c_Emps
            .Value         = ""
            .Left          = 139
            .Top           = 127
            .Width         = 34
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Emps, "KeyPress",  THIS, "TxtEmpsKeyPress")
        BINDEVENT(par_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")

        *-- lbl_4c_FaixaDe (Say4: Left=275, Top=103 -> +28=131)
        par_oPagina.AddObject("lbl_4c_FaixaDe", "Label")
        WITH par_oPagina.lbl_4c_FaixaDe
            .Caption   = "Faixa de :"
            .Left      = 275
            .Top       = 131
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_FaixaI (Get_faixai: Left=327, Top=99 -> +28=127, Width=108, H=23)
        par_oPagina.AddObject("txt_4c_FaixaI", "TextBox")
        WITH par_oPagina.txt_4c_FaixaI
            .Value         = 0
            .Left          = 327
            .Top           = 127
            .Width         = 108
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .InputMask     = "9999999999.99"
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_FaixaAte (Say5: Left=439, Top=103 -> +28=131)
        par_oPagina.AddObject("lbl_4c_FaixaAte", "Label")
        WITH par_oPagina.lbl_4c_FaixaAte
            .Caption   = "at" + CHR(233) + " :"
            .Left      = 439
            .Top       = 131
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_FaixaF (Get_faixaf: Left=461, Top=99 -> +28=127, Width=115, H=23)
        par_oPagina.AddObject("txt_4c_FaixaF", "TextBox")
        WITH par_oPagina.txt_4c_FaixaF
            .Value         = 0
            .Left          = 461
            .Top           = 127
            .Width         = 115
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .InputMask     = "9999999999.99"
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grid de Motivos (grdMotivos: Left=98, Top=132 -> +28=160, W=706, H=464)
        *-- RecordSource=crMotivos, 3 colunas: Codigos/Descrs/Tipos
        *----------------------------------------------------------------------
        par_oPagina.AddObject("grd_4c_Motivos", "Grid")
        WITH par_oPagina.grd_4c_Motivos
            .RecordSource      = "crMotivos"
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Left              = 98
            .Top               = 160
            .Width             = 706
            .Height            = 464
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 20
            .RowHeight         = 20
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .T.
            .Panel             = 1
            .Visible           = .T.

            *-- Coluna 1: Codigos (Motivo)
            WITH .Column1
                .ControlSource = "crMotivos.Codigos"
                .Width         = 94
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                WITH .Header1
                    .Caption   = "Motivo"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontBold    = .F.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Alignment   = 3
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Coluna 2: Descrs (Descricao)
            WITH .Column2
                .ControlSource = "crMotivos.Descrs"
                .Width         = 379
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                WITH .Header1
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Alignment   = 3
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Coluna 3: Tipos (OptionGroup: Inserir/Excluir/Nenhum)
            *-- Sparse=.F.: OptionGroup sempre visivel em todas as linhas
            WITH .Column3
                .ControlSource = "crMotivos.Tipos"
                .Width         = 210
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .F.
                .Sparse        = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                WITH .Header1
                    .Caption   = "Tipo"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
            ENDWITH
        ENDWITH

        *-- OptionGroup da coluna 3 adicionado fora do WITH (Pattern: AddObject filho via path explicito)
        par_oPagina.grd_4c_Motivos.Column3.AddObject("opt_4c_Tipos", "OptionGroup")
        WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos
            .ButtonCount = 3
            .BorderStyle = 0
            .AutoSize    = .F.
            .Value       = 1
            .Left        = 2
            .Top         = 2
            .Width       = 191
            .Height      = 16
            .BackStyle   = 0
        ENDWITH
        WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(1)
            .Caption  = "Inserir"
            .BackStyle = 0
            .Value    = 1
            .Left     = 5
            .Top      = 2
            .Width    = 48
            .Height   = 14
            .AutoSize = .T.
            .FontSize = 8
        ENDWITH
        WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(2)
            .Caption  = "Excluir"
            .BackStyle = 0
            .Left     = 60
            .Top      = 2
            .Width    = 50
            .Height   = 14
            .AutoSize = .T.
            .FontSize = 8
        ENDWITH
        WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(3)
            .Caption  = "Nenhum"
            .BackStyle = 0
            .Left     = 120
            .Top      = 2
            .Width    = 61
            .Height   = 15
            .FontSize = 8
        ENDWITH

        *-- BINDEVENTs dos botoes Confirmar/Cancelar
        BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
        BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    * Vincula cursor_4c_Dados ao grd_4c_Lista apos chamar Buscar no BO
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (cIdChaves C(36), Emps C(3), ;
                        grupos C(10), codigos C(80), descs C(220), ;
                        Prioridades N(2,0), faixais N(12,2), faixafs N(12,2), ClcStatus N(1,0))
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    loc_lResultado = THIS.this_oBusinessObject.Buscar("")
                ENDIF

                IF loc_lResultado AND USED("cursor_4c_Dados")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    IF VARTYPE(loc_oGrid) = "O"
                        loc_oGrid.ColumnCount = 8
                        loc_oGrid.RecordSource              = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.Emps"
                        loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.grupos"
                        loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.descs"
                        loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.Prioridades"
                        loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
                        loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
                        loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
                        *-- Redefinir headers apos RecordSource (VFP reseta automaticamente)
                        loc_oGrid.Column1.Header1.Caption   = "Emp"
                        loc_oGrid.Column2.Header1.Caption   = "Grupo"
                        loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
                        loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(245) + "es"
                        loc_oGrid.Column5.Header1.Caption   = "P"
                        loc_oGrid.Column6.Header1.Caption   = "Faixa Inicial"
                        loc_oGrid.Column7.Header1.Caption   = "Faixa Final"
                        loc_oGrid.Column8.Header1.Caption   = "Selecionavel"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCco.CarregarLista: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lSucesso = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCco.AlternarPagina: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
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
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()

        *-- Popular crMotivos com todos os motivos de SigCdFs (Tipos=3/Nenhum por default)
        IF USED("crMotivos")
            ZAP IN crMotivos
            THIS.this_oBusinessObject.CompletarMotivosFS()
        ENDIF

        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cIdChaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()

            *-- Carregar motivos para grd_4c_Motivos (fase 6)
            IF USED("crMotivos")
                ZAP IN crMotivos
                THIS.this_oBusinessObject.CarregarMotivosClassif(loc_cIdChaves)
            ENDIF

            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cIdChaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()

            *-- Carregar motivos e completar com SigCdFs ausentes (fase 6)
            IF USED("crMotivos")
                ZAP IN crMotivos
                THIS.this_oBusinessObject.CarregarMotivosClassif(loc_cIdChaves)
                THIS.this_oBusinessObject.CompletarMotivosFS()
            ENDIF

            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cIdChaves, loc_cDescricao
        loc_cIdChaves  = ""
        loc_cDescricao = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves  = ALLTRIM(cursor_4c_Dados.cIdChaves)
            loc_cDescricao = ALLTRIM(cursor_4c_Dados.descs)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.VerificarVinculoCli( ;
                THIS.this_oBusinessObject.this_cGrupos, ;
                THIS.this_oBusinessObject.this_cCodigos)
            MsgAviso("Classifica" + CHR(231) + CHR(227) + "o em uso por clientes." + ;
                CHR(13) + "N" + CHR(227) + "o pode ser exclu" + CHR(237) + "da!", "Excluir")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma exclus" + CHR(227) + "o de:" + CHR(13) + ;
                loc_cDescricao + "?", "Excluir")
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Buscar/filtrar registros por codigo ou descricao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_cFiltro, loc_lSucesso, loc_oGrid
        loc_cBusca = INPUTBOX("Buscar por c" + CHR(243) + "digo ou descri" + ;
                              CHR(231) + CHR(227) + "o:", ;
                              "Buscar Classifica" + CHR(231) + CHR(227) + "o", "")

        IF LASTKEY() = 27
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_cBusca))
            THIS.CarregarLista()
            RETURN
        ENDIF

        loc_cFiltro = "codigos LIKE " + EscaparSQL("%" + ALLTRIM(loc_cBusca) + "%")

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
            IF loc_lSucesso AND USED("cursor_4c_Dados")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                IF VARTYPE(loc_oGrid) = "O"
                    loc_oGrid.ColumnCount = 8
                    loc_oGrid.RecordSource              = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.Emps"
                    loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.grupos"
                    loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.descs"
                    loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.Prioridades"
                    loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
                    loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
                    loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
                    loc_oGrid.Column1.Header1.Caption   = "Emp"
                    loc_oGrid.Column2.Header1.Caption   = "Grupo"
                    loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
                    loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(245) + "es"
                    loc_oGrid.Column5.Header1.Caption   = "P"
                    loc_oGrid.Column6.Header1.Caption   = "Faixa Inicial"
                    loc_oGrid.Column7.Header1.Caption   = "Faixa Final"
                    loc_oGrid.Column8.Header1.Caption   = "Selecionavel"
                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fechar o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirmar: valida, transfere form->BO e chama BO.Salvar
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cEmps, loc_cGrupos, loc_cCodigos, loc_cFaixaMsg
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes FORA do TRY (critico: RETURN dentro de TRY nao funciona)
        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value))
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
            loc_oPg2.txt_4c_Grupo.SetFocus
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
            loc_oPg2.txt_4c_Codigo.SetFocus
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                "o pode ficar em branco!", "Confirmar")
            loc_oPg2.txt_4c_Descricao.SetFocus
            RETURN
        ENDIF

        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        *-- Verificar duplicidade e sobreposicao de faixa apenas no INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            loc_cGrupos  = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
            loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)

            IF THIS.this_oBusinessObject.VerificarDuplicidade( ;
                    loc_cEmps, loc_cGrupos, loc_cCodigos, "")
                MsgAviso("J" + CHR(225) + " existe um registro com este c" + CHR(243) + ;
                    "digo neste grupo!", "Confirmar")
                loc_oPg2.txt_4c_Codigo.SetFocus
                RETURN
            ENDIF

            loc_cFaixaMsg = THIS.this_oBusinessObject.VerificarFaixaSobreposta( ;
                loc_cEmps, loc_cGrupos, ;
                THIS.this_oBusinessObject.this_nFaixaIs, ;
                THIS.this_oBusinessObject.this_nFaixaFs, "")
            IF !EMPTY(loc_cFaixaMsg)
                MsgAviso(loc_cFaixaMsg, "Confirmar")
                RETURN
            ENDIF
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            *-- Salvar motivos se cursor disponivel (grd_4c_Motivos - fase 6)
            IF USED("crMotivos")
                THIS.this_oBusinessObject.SalvarMotivos( ;
                    THIS.this_oBusinessObject.this_cIdChaves, "crMotivos")
            ENDIF
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar edicao e retornar a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * TxtGrupoKeyPress - Abre lookup de grupo via F3
    *==========================================================================
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 114
            THIS.AbrirBuscaGrupo()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Verifica grupo ao sair do campo (LostFocus)
    *==========================================================================
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oPg2
        loc_cGrupo = ""

        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

            IF EMPTY(loc_cGrupo)
                RETURN
            ENDIF

            THIS.AbrirBuscaGrupo()
        CATCH TO loException
            MsgErro("Erro em FormCco.ValidarGrupo: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupo - Lookup em SigCdGcr (Codigos/Descrs)
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oBusca, loc_cGrupo, loc_oPg2
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
                "Grupos de Classifica" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrupo")
                        loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCco.AbrirBuscaGrupo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtEmpsKeyPress - Abre lookup de empresa via F3
    *==========================================================================
    PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 114
            THIS.AbrirBuscaEmps()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarEmps - Verifica empresa ao sair do campo (LostFocus)
    *==========================================================================
    PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cEmps, loc_oPg2
        loc_cEmps = ""

        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)

            IF EMPTY(loc_cEmps)
                RETURN
            ENDIF

            THIS.AbrirBuscaEmps()
        CATCH TO loException
            MsgErro("Erro em FormCco.ValidarEmps: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmps - Lookup em SigCdEmp (Cemps/Razas)
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaEmps()
        LOCAL loc_oBusca, loc_cEmps, loc_oPg2
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmps", "Cemps", loc_cEmps, ;
                "Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaEmps")
                        loc_oPg2.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmps.Cemps)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "@!", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "!",  "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmps")
                        loc_oPg2.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmps.Cemps)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCco.AbrirBuscaEmps: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmps")
            USE IN cursor_4c_BuscaEmps
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa propriedades do BO (campos de Page2 na Fase 5)
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cIdChaves    = ""
                THIS.this_oBusinessObject.this_cEmps        = ""
                THIS.this_oBusinessObject.this_cGrupos      = ""
                THIS.this_oBusinessObject.this_cCodigos     = ""
                THIS.this_oBusinessObject.this_cDescs       = ""
                THIS.this_oBusinessObject.this_nPrioridades = 0
                THIS.this_oBusinessObject.this_nFaixaIs     = 0
                THIS.this_oBusinessObject.this_nFaixaFs     = 0
                THIS.this_oBusinessObject.this_nClcStatus   = 1
            ENDIF

            *-- Limpar campos da Page2 (Fase 5)
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF VARTYPE(loc_oPg2) = "O"
                IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                    loc_oPg2.txt_4c_Codigo.Value    = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                    loc_oPg2.txt_4c_Descricao.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2, "opt_4c_ClcStatus", 5)
                    loc_oPg2.opt_4c_ClcStatus.Value = 1
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                    loc_oPg2.txt_4c_Grupo.Value     = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_Priori", 5)
                    loc_oPg2.txt_4c_Priori.Value    = 0
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                    loc_oPg2.txt_4c_Emps.Value      = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_FaixaI", 5)
                    loc_oPg2.txt_4c_FaixaI.Value    = 0
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_FaixaF", 5)
                    loc_oPg2.txt_4c_FaixaF.Value    = 0
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCco.LimparCampos: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao
    * Campos de Page2 serao adicionados na Fase 5
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_oPg2
        loc_lHabilitar = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF VARTYPE(loc_oPg2) != "O"
                RETURN
            ENDIF

            *-- Codigo: apenas editavel no modo INCLUIR (Get_codigo.When = pcEscolha=INSERIR)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Enabled = (loc_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
            ENDIF

            *-- Descricao: editavel em INCLUIR e ALTERAR
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.Enabled = loc_lHabilitar
            ENDIF

            *-- ClcStatus: editavel em INCLUIR e ALTERAR
            IF PEMSTATUS(loc_oPg2, "opt_4c_ClcStatus", 5)
                loc_oPg2.opt_4c_ClcStatus.Enabled = loc_lHabilitar
            ENDIF

            *-- Grupo: editavel somente em INCLUIR (e quando nao filtrado por Clientes)
            *-- Get_Grupo.When = InList(pcEscolha, INSERIR, PROCURAR) AND NOT Clientes
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                loc_oPg2.txt_4c_Grupo.Enabled = (loc_lHabilitar AND ;
                    THIS.this_cModoAtual = "INCLUIR" AND ;
                    !THIS.this_lClientesFiltro)
            ENDIF

            *-- Priori: editavel em INCLUIR e ALTERAR (GetPriori.When = InList(INSERIR, ALTERAR))
            IF PEMSTATUS(loc_oPg2, "txt_4c_Priori", 5)
                loc_oPg2.txt_4c_Priori.Enabled = loc_lHabilitar
            ENDIF

            *-- Emps: editavel apenas em INCLUIR (faz parte da chave composta)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                loc_oPg2.txt_4c_Emps.Enabled = (loc_lHabilitar AND ;
                    THIS.this_cModoAtual = "INCLUIR")
            ENDIF

            *-- FaixaI / FaixaF: editaveis em INCLUIR e ALTERAR
            IF PEMSTATUS(loc_oPg2, "txt_4c_FaixaI", 5)
                loc_oPg2.txt_4c_FaixaI.Enabled = loc_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_FaixaF", 5)
                loc_oPg2.txt_4c_FaixaF.Enabled = loc_lHabilitar
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCco.HabilitarCampos: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para campos do form (Page2 na Fase 5)
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oPg2
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Fase 5: Codigo, Descricao, ClcStatus, Grupo, Priori
            loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
            loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
            loc_oPg2.opt_4c_ClcStatus.Value = IIF(THIS.this_oBusinessObject.this_nClcStatus = 2, 2, 1)
            loc_oPg2.txt_4c_Grupo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
            loc_oPg2.txt_4c_Priori.Value    = THIS.this_oBusinessObject.this_nPrioridades
            loc_oPg2.txt_4c_Emps.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            loc_oPg2.txt_4c_FaixaI.Value    = THIS.this_oBusinessObject.this_nFaixaIs
            loc_oPg2.txt_4c_FaixaF.Value    = THIS.this_oBusinessObject.this_nFaixaFs

            *-- Grupo fixo se this_lClientesFiltro = .T. (legado: Enabled=.F. no Alterar)
            IF THIS.this_lClientesFiltro AND !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
                loc_oPg2.txt_4c_Grupo.Enabled = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em FormCco.BOParaForm: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados dos campos do form para o BO (Page2 na Fase 5)
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oPg2
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Fase 5: Codigo, Descricao, ClcStatus, Grupo, Priori
            THIS.this_oBusinessObject.this_cCodigos     = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            THIS.this_oBusinessObject.this_cDescs       = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
            THIS.this_oBusinessObject.this_nClcStatus   = loc_oPg2.opt_4c_ClcStatus.Value
            THIS.this_oBusinessObject.this_cGrupos      = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            THIS.this_oBusinessObject.this_nPrioridades = loc_oPg2.txt_4c_Priori.Value
            THIS.this_oBusinessObject.this_cEmps        = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
            THIS.this_oBusinessObject.this_nFaixaIs     = loc_oPg2.txt_4c_FaixaI.Value
            THIS.this_oBusinessObject.this_nFaixaFs     = loc_oPg2.txt_4c_FaixaF.Value

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em FormCco.FormParaBO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes Confirmar/Cancelar
    * Confirmar: desabilitado em VISUALIZAR, habilitado em INCLUIR/ALTERAR
    * Cancelar: sempre habilitado em Page2
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lConfirmar
        loc_lConfirmar = !INLIST(THIS.this_cModoAtual, "VISUALIZAR", "LISTA")

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF VARTYPE(loc_oPg2) = "O"
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Salvar", 5)
                        loc_oPg2.cnt_4c_Salva.cmd_4c_Salvar.Enabled  = loc_lConfirmar
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
                        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCco.AjustarBotoesPorModo: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("crMotivos")
            USE IN crMotivos
        ENDIF

        IF USED("crSigCdGcr")
            USE IN crSigCdGcr
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
