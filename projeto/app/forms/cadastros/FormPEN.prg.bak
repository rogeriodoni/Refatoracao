*==============================================================================
* FormPEN.prg - Formulario de Penalidades de Comissao
* Migrado de: SIGCDPEN.SCX (frmcadastro)
* Tabela: SigCdPen (cidchaves, blqpags, grupos, contas, ddis, ddfs, penas)
*==============================================================================

DEFINE CLASS FormPEN AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1007
    Caption     = "Cadastro de Penalidades de Comiss" + CHR(227) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    MaxButton   = .F.
    Closable    = .F.
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2
    ShowTips    = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, cursor, PageFrame e controles
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("PENBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar PENBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormPEN.InicializarForm")
            ELSE
                *-- Cursor vazio para o grid (DataSession=2 isolado)
                CREATE CURSOR cursor_4c_Dados ;
                    (cidchaves C(20), grupos C(10), descgrupo C(40), ;
                     contas C(10), ddis N(4,0), ddfs N(4,0), penas N(5,2))

                THIS.ConfigurarPageFrame()

                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                    .lbl_4c_Sombra.Caption = THIS.Caption
                    .lbl_4c_Titulo.Caption = THIS.Caption
                    .Visible = .T.
                ENDWITH

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormPEN:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormPEN.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame com 2 paginas (Lista + Dados)
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
            .Visible   = .T.
            .Page1.Caption  = "Lista"
            .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page2.Caption  = "Dados"
            .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grade
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (Top=30 para compensar -29 do PageFrame)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top       = 30
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
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
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Top=29, sobrep-se ao cabecalho)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top       = 29
            .Left      = 542
            .Width     = 385
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
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

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left = 155
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

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left = 80
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

        *-- Container de Saida (Encerrar) - PADRAO CANONICO
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top       = 29
            .Left      = 917
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
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
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container de Filtros (abaixo do cabecalho)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top       = 114
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 44
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        *-- Label Grupo
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LGrupo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LGrupo
            .Caption   = "Grupo :"
            .Top       = 12
            .Left      = 71
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grupo (filtro)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FGrupo", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FGrupo
            .Value         = ""
            .Top           = 10
            .Left          = 120
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Filtro por Grupo"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FGrupo, "KeyPress", THIS, "FiltroKeyPress")

        *-- Label Conta
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LConta", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LConta
            .Caption   = "Conta :"
            .Top       = 12
            .Left      = 220
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conta (filtro)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FConta", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FConta
            .Value         = ""
            .Top           = 10
            .Left          = 265
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Filtro por Conta"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FConta, "KeyPress", THIS, "FiltroKeyPress")

        *-- Grid cursor_4c_Dados
        *-- Top=159 (30+80+29+20=159)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top             = 159
            .Left            = 23
            .Width           = THIS.Width - 46
            .Height          = 440
            .RecordSource    = "cursor_4c_Dados"
            .ReadOnly        = .T.
            .DeleteMark      = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .ColumnCount     = 6
            .Visible         = .T.
            .RecordMark      = .F.
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column1
            .ControlSource    = "cursor_4c_Dados.grupos"
            .Width            = 80
            .Header1.Caption  = "Grupo"
            .Header1.Alignment = 0
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column2
            .ControlSource    = "cursor_4c_Dados.descgrupo"
            .Width            = 200
            .Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o Grupo"
            .Header1.Alignment = 0
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column3
            .ControlSource    = "cursor_4c_Dados.contas"
            .Width            = 80
            .Header1.Caption  = "Conta"
            .Header1.Alignment = 0
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column4
            .ControlSource    = "cursor_4c_Dados.ddis"
            .Width            = 70
            .Header1.Caption  = "Dia De"
            .Header1.Alignment = 0
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column5
            .ControlSource    = "cursor_4c_Dados.ddfs"
            .Width            = 70
            .Header1.Caption  = "Dia At" + CHR(233)
            .Header1.Alignment = 0
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column6
            .ControlSource    = "cursor_4c_Dados.penas"
            .Width            = 461
            .Header1.Caption  = "% Penalidade"
            .Header1.Alignment = 0
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos de entrada de dados
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Label + TextBox Grupo
        *-- Legado: Say4 top=131, left=193 -> +29 = top=160, left=193 (label)
        *-- Legado: Get_Grupos top=128, left=241, width=80 -> top=157 (code)
        *-- Legado: Get_G top=128, left=323, width=150 -> top=157 (desc)
        loc_oPagina.AddObject("lbl_4c_LGrupos", "Label")
        WITH loc_oPagina.lbl_4c_LGrupos
            .Caption   = "Grupo :"
            .Top       = 160
            .Left      = 193
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupos", "TextBox")
        WITH loc_oPagina.txt_4c_Grupos
            .Top           = 157
            .Left          = 241
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "C" + CHR(243) + "digo do Grupo"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupos, "LostFocus", THIS, "ValidarGrupos")
        BINDEVENT(loc_oPagina.txt_4c_Grupos, "KeyPress", THIS, "GruposKeyPress")

        loc_oPagina.AddObject("txt_4c_DGrupos", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupos
            .Top           = 157
            .Left          = 323
            .Width         = 150
            .Height        = 23
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox Conta
        *-- Legado: Say5 top=160, left=194 -> +29 = top=189
        *-- Legado: Get_Contas top=157, left=241, width=80 -> top=186
        *-- Legado: Get_C top=157, left=323, width=252 -> top=186
        loc_oPagina.AddObject("lbl_4c_LContas", "Label")
        WITH loc_oPagina.lbl_4c_LContas
            .Caption   = "Conta :"
            .Top       = 189
            .Left      = 194
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Contas", "TextBox")
        WITH loc_oPagina.txt_4c_Contas
            .Top           = 186
            .Left          = 241
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "C" + CHR(243) + "digo da Conta"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Contas, "LostFocus", THIS, "ValidarContas")
        BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "ContasKeyPress")

        loc_oPagina.AddObject("txt_4c_DContas", "TextBox")
        WITH loc_oPagina.txt_4c_DContas
            .Top           = 186
            .Left          = 323
            .Width         = 252
            .Height        = 23
            .MaxLength     = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
            .Visible       = .T.
        ENDWITH

        *-- Label "Dias de Atraso de :" + TextBox DDi + Label "ate" + TextBox DDF
        *-- Legado: Say1 top=187, left=126 -> +29 = top=216
        *-- Legado: Get_DDi top=185, left=241, width=38 -> top=214
        *-- Legado: Say2 top=187, left=292 -> +29 = top=216
        *-- Legado: get_ddf top=185, left=323, width=38 -> top=214
        loc_oPagina.AddObject("lbl_4c_LDias", "Label")
        WITH loc_oPagina.lbl_4c_LDias
            .Caption   = "Dias de Atraso de :"
            .Top       = 216
            .Left      = 126
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ddis", "TextBox")
        WITH loc_oPagina.txt_4c_Ddis
            .Value         = 0
            .Top           = 214
            .Left          = 241
            .Width         = 38
            .Height        = 21
            .MaxLength     = 4
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Dias de Atraso - In" + CHR(237) + "cio"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Ddis, "LostFocus", THIS, "ValidarDdis")

        loc_oPagina.AddObject("lbl_4c_LAte", "Label")
        WITH loc_oPagina.lbl_4c_LAte
            .Caption   = "at" + CHR(233)
            .Top       = 216
            .Left      = 292
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ddfs", "TextBox")
        WITH loc_oPagina.txt_4c_Ddfs
            .Value         = 0
            .Top           = 214
            .Left          = 323
            .Width         = 38
            .Height        = 21
            .MaxLength     = 4
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Dias de Atraso - Fim"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Ddfs, "LostFocus", THIS, "ValidarDdfs")

        *-- Label "% Penalidade :" + TextBox Penas
        *-- Legado: Say3 top=214, left=149 -> +29 = top=243
        *-- Legado: Get_pena top=212, left=241, width=58 -> top=241
        loc_oPagina.AddObject("lbl_4c_LPenas", "Label")
        WITH loc_oPagina.lbl_4c_LPenas
            .Caption   = "% Penalidade :"
            .Top       = 243
            .Left      = 149
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Penas", "TextBox")
        WITH loc_oPagina.txt_4c_Penas
            .Value         = 0
            .Top           = 241
            .Left          = 241
            .Width         = 58
            .Height        = 21
            .MaxLength     = 7
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Percentual de Penalidade"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Penas, "LostFocus", THIS, "ValidarPenas")

        *-- Botoes Confirmar e Cancelar
        loc_oPagina.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Confirmar
            .Caption       = "Confirmar"
            .Top           = 290
            .Left          = 241
            .Width         = 90
            .Height        = 27
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        loc_oPagina.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cancelar
            .Caption       = "Encerrar"
            .Top           = 290
            .Left          = 341
            .Width         = 75
            .Height        = 75
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca dados com filtros da tela
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cFiltro, loc_cGrupo, loc_cConta
        LOCAL loc_oPg1
        loc_lSucesso = .F.

        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_cGrupo = ""
            loc_cConta = ""

            IF PEMSTATUS(loc_oPg1, "cnt_4c_Filtros", 5)
                WITH loc_oPg1.cnt_4c_Filtros
                    IF PEMSTATUS(.Self, "txt_4c_FGrupo", 5)
                        loc_cGrupo = ALLTRIM(.txt_4c_FGrupo.Value)
                    ENDIF
                    IF PEMSTATUS(.Self, "txt_4c_FConta", 5)
                        loc_cConta = ALLTRIM(.txt_4c_FConta.Value)
                    ENDIF
                    .Visible     = .T.
                ENDWITH
            ENDIF

            loc_cFiltro = ""

            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "a.grupos LIKE " + EscaparSQL(loc_cGrupo + "%")
            ENDIF

            IF !EMPTY(loc_cConta)
                IF !EMPTY(loc_cFiltro)
                    loc_cFiltro = loc_cFiltro + " AND "
                ENDIF
                loc_cFiltro = loc_cFiltro + "a.contas LIKE " + EscaparSQL(loc_cConta + "%")
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)

            IF PEMSTATUS(loc_oPg1, "grd_4c_Dados", 5)
                loc_oPg1.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormPEN.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * IrParaDados - Muda para pagina de dados e carrega registro
    *==========================================================================
    PROTECTED PROCEDURE IrParaDados(par_cModo)
        LOCAL loc_lSucesso, loc_oPg2, loc_lReadOnly, loc_lNovo, loc_lPodeNavegar
        loc_lSucesso = .F.

        TRY
            THIS.this_cModoAtual = par_cModo
            loc_oPg2     = THIS.pgf_4c_Paginas.Page2
            loc_lReadOnly = (par_cModo == "VISUALIZAR")
            loc_lNovo     = (par_cModo == "INCLUIR")
            loc_lPodeNavegar = .T.

            IF !loc_lNovo
                IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                    MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lPodeNavegar = .F.
                ELSE
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
                ENDIF
            ENDIF

            IF !loc_lPodeNavegar
                loc_lSucesso = .F.
            ELSE
                THIS.BOParaForm()

                WITH loc_oPg2
                    IF PEMSTATUS(.Self, "txt_4c_Grupos", 5)
                        .txt_4c_Grupos.ReadOnly  = loc_lReadOnly
                        .txt_4c_DGrupos.ReadOnly = .T.
                    ENDIF
                    IF PEMSTATUS(.Self, "txt_4c_Contas", 5)
                        .txt_4c_Contas.ReadOnly  = loc_lReadOnly
                        .txt_4c_DContas.ReadOnly = .T.
                    ENDIF
                    IF PEMSTATUS(.Self, "txt_4c_Ddis", 5)
                        .txt_4c_Ddis.ReadOnly = loc_lReadOnly
                    ENDIF
                    IF PEMSTATUS(.Self, "txt_4c_Ddfs", 5)
                        .txt_4c_Ddfs.ReadOnly = loc_lReadOnly
                    ENDIF
                    IF PEMSTATUS(.Self, "txt_4c_Penas", 5)
                        .txt_4c_Penas.ReadOnly = loc_lReadOnly
                    ENDIF
                    IF PEMSTATUS(.Self, "cmd_4c_Confirmar", 5)
                        .cmd_4c_Confirmar.Enabled = !loc_lReadOnly
                    ENDIF
                ENDWITH

                THIS.pgf_4c_Paginas.ActivePage = 2

                IF !loc_lReadOnly
                    IF PEMSTATUS(loc_oPg2, "txt_4c_Grupos", 5)
                        loc_oPg2.txt_4c_Grupos.SetFocus()
                    ENDIF
                ELSE
                    IF PEMSTATUS(loc_oPg2, "cmd_4c_Confirmar", 5)
                        loc_oPg2.cmd_4c_Confirmar.SetFocus()
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao ir para dados:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormPEN.IrParaDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * IrParaLista - Volta para a pagina de lista
    *==========================================================================
    PROTECTED PROCEDURE IrParaLista()
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
        THIS.pgf_4c_Paginas.ActivePage = 1
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Filtros", 5)
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "txt_4c_FGrupo", 5)
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FGrupo.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Escreve propriedades do BO nos controles
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            WITH loc_oPg2
                IF PEMSTATUS(.Self, "txt_4c_Grupos", 5)
                    .txt_4c_Grupos.Value  = loc_oBO.this_cGrupos
                    .txt_4c_DGrupos.Value = IIF(!EMPTY(loc_oBO.this_cGrupos), ;
                        loc_oBO.BuscarDescGrupo(loc_oBO.this_cGrupos), "")
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Contas", 5)
                    .txt_4c_Contas.Value  = loc_oBO.this_cContas
                    .txt_4c_DContas.Value = IIF(!EMPTY(loc_oBO.this_cContas), ;
                        loc_oBO.BuscarDescConta(loc_oBO.this_cContas), "")
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Ddis", 5)
                    .txt_4c_Ddis.Value = loc_oBO.this_nDdis
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Ddfs", 5)
                    .txt_4c_Ddfs.Value = loc_oBO.this_nDdfs
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Penas", 5)
                    .txt_4c_Penas.Value = loc_oBO.this_nPenas
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPEN.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Le controles e escreve no BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            WITH loc_oPg2
                IF PEMSTATUS(.Self, "txt_4c_Grupos", 5)
                    loc_oBO.this_cGrupos = ALLTRIM(.txt_4c_Grupos.Value)
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Contas", 5)
                    loc_oBO.this_cContas = ALLTRIM(.txt_4c_Contas.Value)
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Ddis", 5)
                    loc_oBO.this_nDdis = .txt_4c_Ddis.Value
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Ddfs", 5)
                    loc_oBO.this_nDdfs = .txt_4c_Ddfs.Value
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Penas", 5)
                    loc_oBO.this_nPenas = .txt_4c_Penas.Value
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPEN.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_oPg2
        loc_lValido = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Grupo obrigatorio
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupos", 5)
                IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupos.Value))
                    MsgAviso("Obrigat" + CHR(243) + "rio informar o Grupo.", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c_Grupos.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Ddfs >= Ddis
            IF loc_lValido AND PEMSTATUS(loc_oPg2, "txt_4c_Ddis", 5) AND PEMSTATUS(loc_oPg2, "txt_4c_Ddfs", 5)
                IF loc_oPg2.txt_4c_Ddfs.Value < loc_oPg2.txt_4c_Ddis.Value
                    MsgAviso("Dia At" + CHR(233) + " deve ser maior ou igual ao Dia De.", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c_Ddfs.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Penas obrigatorio > 0
            IF loc_lValido AND PEMSTATUS(loc_oPg2, "txt_4c_Penas", 5)
                IF loc_oPg2.txt_4c_Penas.Value <= 0
                    MsgAviso("% Penalidade deve ser maior que zero.", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c_Penas.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPEN.ValidarDados")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Handlers de botoes da pagina Lista
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject.this_cCidchaves = ""
            THIS.this_oBusinessObject.this_cGrupos    = ""
            THIS.this_oBusinessObject.this_cContas    = ""
            THIS.this_oBusinessObject.this_nDdis      = 0
            THIS.this_oBusinessObject.this_nDdfs      = 0
            THIS.this_oBusinessObject.this_nPenas     = 0

            loc_lSucesso = THIS.IrParaDados("INCLUIR")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPEN.BtnIncluirClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = THIS.IrParaDados("ALTERAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPEN.BtnAlterarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = THIS.IrParaDados("VISUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPEN.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ELSE
                THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")

                IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.this_oBusinessObject.Excluir()

                    IF loc_lSucesso
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                        THIS.IrParaLista()
                    ELSE
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Excluir")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPEN.BtnExcluirClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Handlers de botoes da pagina Dados
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ELSE
                THIS.FormParaBO()

                loc_lSucesso = THIS.this_oBusinessObject.Salvar()

                IF loc_lSucesso
                    THIS.IrParaLista()
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormPEN.BtnConfirmarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.IrParaLista()
    ENDPROC

    *==========================================================================
    * Handlers de validacao de campos (Page2)
    *==========================================================================
    PROCEDURE ValidarGrupos()
        LOCAL loc_cGrupos, loc_cDesc, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "txt_4c_Grupos", 5)
            RETURN
        ENDIF
        loc_cGrupos = ALLTRIM(loc_oPg2.txt_4c_Grupos.Value)
        IF EMPTY(loc_cGrupos)
            loc_oPg2.txt_4c_DGrupos.Value = ""
            RETURN
        ENDIF
        loc_cDesc = THIS.this_oBusinessObject.BuscarDescGrupo(loc_cGrupos)
        IF EMPTY(loc_cDesc)
            MsgAviso("Grupo " + CHR(34) + loc_cGrupos + CHR(34) + " n" + CHR(227) + "o encontrado.", "Grupo")
            loc_oPg2.txt_4c_Grupos.Value  = ""
            loc_oPg2.txt_4c_DGrupos.Value = ""
            loc_oPg2.txt_4c_Grupos.SetFocus()
        ELSE
            loc_oPg2.txt_4c_DGrupos.Value = loc_cDesc
        ENDIF
    ENDPROC

    PROCEDURE GruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            THIS.ValidarGrupos()
        ENDIF
    ENDPROC

    PROCEDURE ValidarContas()
        LOCAL loc_cContas, loc_cDesc, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
            RETURN
        ENDIF
        loc_cContas = ALLTRIM(loc_oPg2.txt_4c_Contas.Value)
        IF EMPTY(loc_cContas)
            loc_oPg2.txt_4c_DContas.Value = ""
            RETURN
        ENDIF
        loc_cDesc = THIS.this_oBusinessObject.BuscarDescConta(loc_cContas)
        IF EMPTY(loc_cDesc)
            loc_oPg2.txt_4c_DContas.Value = ""
        ELSE
            loc_oPg2.txt_4c_DContas.Value = loc_cDesc
        ENDIF
    ENDPROC

    PROCEDURE ContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            THIS.ValidarContas()
        ENDIF
    ENDPROC

    PROCEDURE ValidarDdis()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "txt_4c_Ddis", 5)
            RETURN
        ENDIF
        IF loc_oPg2.txt_4c_Ddis.Value < 0
            loc_oPg2.txt_4c_Ddis.Value = 0
        ENDIF
    ENDPROC

    PROCEDURE ValidarDdfs()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "txt_4c_Ddfs", 5)
            RETURN
        ENDIF
        IF loc_oPg2.txt_4c_Ddfs.Value < 0
            loc_oPg2.txt_4c_Ddfs.Value = 0
        ENDIF
    ENDPROC

    PROCEDURE ValidarPenas()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "txt_4c_Penas", 5)
            RETURN
        ENDIF
        IF loc_oPg2.txt_4c_Penas.Value < 0
            loc_oPg2.txt_4c_Penas.Value = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * Handlers de filtros (Page1)
    *==========================================================================
    PROCEDURE FiltroKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * Handler AfterRowColChange do grid
    *==========================================================================
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        *-- Nenhuma acao necessaria - selecao visual apenas
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_DadosTemp")
            USE IN cursor_4c_DadosTemp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
