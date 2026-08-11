*==============================================================================
* FormDsp.prg - Formulario de Cadastro de Disponibilidades (SigCdDis)
* Migrado de: SIGCDDSP.SCX (frmcadastro)
* Tabela: SigCdDis | BO: DspBO
*==============================================================================

DEFINE CLASS FormDsp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Disponibilidades"
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

    *==========================================================================
    * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Inicializa BO e estrutura do formulario
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DspBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar DspBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormDsp.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormDsp:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDsp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame com 2 paginas (Top=-29, Tabs=.F.)
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

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista - Grid + Botoes CRUD)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrd
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (fundo escuro com titulo)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
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
            .Width     = THIS.Width - 20
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

        *-- Container botoes CRUD (canonico: Left=542)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
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

        *-- Container saida (canonico: Left=917, Width=90)
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

        *-- Botao Encerrar (canonico)
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

        *-- Grid de lista
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrd             = loc_oPagina.grd_4c_Lista
        loc_oGrd.Top         = 117
        loc_oGrd.Left        = 26
        loc_oGrd.Width       = 890
        loc_oGrd.Height      = 455
        loc_oGrd.ColumnCount = 5

        WITH loc_oGrd
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

            .Column1.Width     = 80
            .Column1.Alignment = 0
            .Column2.Width     = 220
            .Column2.Alignment = 0
            .Column3.Width     = 100
            .Column3.Alignment = 0
            .Column4.Width     = 350
            .Column4.Alignment = 0
            .Column5.Width     = 60
            .Column5.Alignment = 2
        ENDWITH

        *-- BINDEVENTs dos botoes (PUBLIC handlers obrigatorio)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados - campos de edicao)
    * Fase 5: Botoes Salvar/Cancelar + secao Grupo (lbl + cd + ds)
    * Fase 6: Secao Conta + OptionGroup Tipo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva no legado: Left=842, Top=4+29=33)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (Salva no legado: Left=5, Top=5)
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar (Cancelar no legado: Left=80, Top=5)
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

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *======================================================================
        * SECAO GRUPO
        * Original: lbl_grupo.Top=172, get_cd_grupo.Top=168 -> comp +29
        *======================================================================

        *-- Label "Grupo :" (lbl_grupo no legado: Top=172, Left=148)
        loc_oPagina.AddObject("lbl_4c_lbl_grupo", "Label")
        WITH loc_oPagina.lbl_4c_lbl_grupo
            .Caption   = "Grupo :"
            .Top       = 201
            .Left      = 148
            .Width     = 38
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo do grupo (get_cd_grupo: Left=197, Width=79, MaxLength=10)
        loc_oPagina.AddObject("txt_4c_cd_grupo", "TextBox")
        WITH loc_oPagina.txt_4c_cd_grupo
            .Top       = 197
            .Left      = 197
            .Width     = 79
            .Height    = 23
            .MaxLength = 10
            .Format    = "!"
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox descricao do grupo (get_ds_grupo: Left=278, Width=150, MaxLength=20)
        *-- ReadOnly: descricao preenchida automaticamente pelo lookup/validacao
        loc_oPagina.AddObject("txt_4c_ds_grupo", "TextBox")
        WITH loc_oPagina.txt_4c_ds_grupo
            .Top       = 197
            .Left      = 278
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .ReadOnly  = .T.
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_cd_grupo, "KeyPress", THIS, "ValidarGrupoForm")
        BINDEVENT(loc_oPagina.txt_4c_cd_grupo, "KeyPress",  THIS, "TeclaGrupoKeyPress")

        *======================================================================
        * SECAO CONTA
        * Original: lbl_conta.Top=197, get_cd_conta.Top=193 -> comp +29
        *======================================================================

        *-- Label "Conta :" (lbl_conta no legado: Top=197, Left=148)
        loc_oPagina.AddObject("lbl_4c_lbl_conta", "Label")
        WITH loc_oPagina.lbl_4c_lbl_conta
            .Caption   = "Conta :"
            .Top       = 226
            .Left      = 148
            .Width     = 38
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo da conta (get_cd_conta: Left=197, Width=79, MaxLength=10)
        loc_oPagina.AddObject("txt_4c_cd_conta", "TextBox")
        WITH loc_oPagina.txt_4c_cd_conta
            .Top       = 222
            .Left      = 197
            .Width     = 79
            .Height    = 23
            .MaxLength = 10
            .Format    = "!"
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox descricao da conta (get_ds_conta: Left=278, Width=290, MaxLength=40)
        *-- ReadOnly: preenchida automaticamente pelo lookup/validacao
        loc_oPagina.AddObject("txt_4c_ds_conta", "TextBox")
        WITH loc_oPagina.txt_4c_ds_conta
            .Top       = 222
            .Left      = 278
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .ReadOnly  = .T.
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_cd_conta, "KeyPress", THIS, "ValidarContaForm")
        BINDEVENT(loc_oPagina.txt_4c_cd_conta, "KeyPress",  THIS, "TeclaContaKeyPress")

        *======================================================================
        * SECAO TIPO (OptionGroup)
        * Original: Say8.Top=230, ObjUniDop.Top=228 -> comp +29
        *======================================================================

        *-- Label "Tipo :" (Say8 no legado: Top=230, Left=157, Width=29, Height=15)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Tipo :"
            .Top       = 259
            .Left      = 157
            .Width     = 29
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup tipo (ObjUniDop: Top=228, Left=191, Width=308, Height=19, ButtonCount=3)
        loc_oPagina.AddObject("opt_4c_Tipos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Tipos
            .Top         = 257
            .Left        = 191
            .Width       = 308
            .Height      = 19
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.opt_4c_Tipos.Buttons(1)
            .Caption   = "Disponibilidade"
            .Left      = 5
            .Top       = 2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        WITH loc_oPagina.opt_4c_Tipos.Buttons(2)
            .Caption   = "Investimento"
            .Left      = 116
            .Top       = 2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        WITH loc_oPagina.opt_4c_Tipos.Buttons(3)
            .Caption   = "Empr" + CHR(233) + "stimo"
            .Left      = 216
            .Top       = 2
            .Width     = 73
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrd
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (Codigos C(20), Grupos C(10), DsGrupos C(30), Iclis C(10), DsConta C(100), Tipos N(1,0))
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrd.ColumnCount = 5
                    loc_oGrd.RecordSource          = "cursor_4c_Dados"
                    loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.Grupos"
                    loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.DsGrupos"
                    loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.Iclis"
                    loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.DsConta"
                    loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.Tipos"

                    loc_oGrd.Column1.Header1.Caption = "Grupo"
                    loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Grupo"
                    loc_oGrd.Column3.Header1.Caption = "Conta"
                    loc_oGrd.Column4.Header1.Caption = "Nome da Conta"
                    loc_oGrd.Column5.Header1.Caption = "Tipo"

                    THIS.FormatarGridLista(loc_oGrd)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
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

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados do Form para Business Object
    * Implementado na Fase 5 (apos criacao dos campos em Page2)
    *==========================================================================
    PROCEDURE FormParaBO()
        WITH THIS.pgf_4c_Paginas.Page2
            THIS.this_oBusinessObject.this_cGrupos  = ALLTRIM(.txt_4c_cd_grupo.Value)
            THIS.this_oBusinessObject.this_cIclis  = ALLTRIM(.txt_4c_cd_conta.Value)
            THIS.this_oBusinessObject.this_cDsGrupo = ALLTRIM(.txt_4c_ds_grupo.Value)
            THIS.this_oBusinessObject.this_cDsConta = ALLTRIM(.txt_4c_ds_conta.Value)
            THIS.this_oBusinessObject.this_nTipos   = .opt_4c_Tipos.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do Business Object para Form
    * Implementado na Fase 5 (apos criacao dos campos em Page2)
    *==========================================================================
    PROCEDURE BOParaForm()
        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_cd_grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
            .txt_4c_ds_grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDsGrupo)
            .txt_4c_cd_conta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cIclis)
            .txt_4c_ds_conta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDsConta)
            .opt_4c_Tipos.Value    = THIS.this_oBusinessObject.this_nTipos
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles do container visiveis (recursivo)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_i)

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
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do Grid apos carregar dados
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 para inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui o registro selecionado na lista
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_lConfirma
        loc_cChave    = ""
        loc_lConfirma = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.Codigos)

        loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do registro selecionado?", ;
            "Excluir Disponibilidade")

        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
                        "Exclus" + CHR(227) + "o")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega a lista completa
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e persiste o registro (Salva.Click no legado)
    * Valida Grupo e Conta antes de FormParaBO + Salvar()
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cGrupo, loc_cConta
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)
        loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_cd_conta.Value)

        *-- Validacoes obrigatorias fora do TRY (regra critica VFP9)
        IF THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
            IF EMPTY(loc_cGrupo)
                MsgAviso("Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!", "Validar")
                loc_oPagina.txt_4c_cd_grupo.SetFocus()
                RETURN
            ENDIF

            IF !THIS.this_oBusinessObject.ValidarGrupo(loc_cGrupo)
                MsgAviso("Grupo inv" + CHR(225) + "lido!", "Validar")
                loc_oPagina.txt_4c_cd_grupo.SetFocus()
                RETURN
            ENDIF

            IF EMPTY(loc_cConta)
                MsgAviso("Conta " + CHR(233) + " obrigat" + CHR(243) + "ria!", "Validar")
                loc_oPagina.txt_4c_cd_conta.SetFocus()
                RETURN
            ENDIF

            IF !THIS.this_oBusinessObject.ValidarConta(loc_cGrupo, loc_cConta)
                MsgAviso("Conta inv" + CHR(225) + "lida!", "Validar")
                loc_oPagina.txt_4c_cd_conta.SetFocus()
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Salvar")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_cd_grupo", 5)
            loc_oPagina.txt_4c_cd_grupo.Value = ""
            loc_oPagina.txt_4c_ds_grupo.Value = ""
        ENDIF

        *-- Campos adicionados na Fase 6
        IF PEMSTATUS(loc_oPagina, "txt_4c_cd_conta", 5)
            loc_oPagina.txt_4c_cd_conta.Value = ""
            loc_oPagina.txt_4c_ds_conta.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPagina, "opt_4c_Tipos", 5)
            loc_oPagina.opt_4c_Tipos.Value = 1
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao
    * par_lHabilitar: .T.=edicao, .F.=somente leitura (VISUALIZAR)
    * Regra legado: get_cd_grupo editavel apenas em INSERIR (nao em ALTERAR)
    *               get_cd_conta editavel em INSERIR e ALTERAR
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- cd_grupo: editavel apenas em INCLUIR (nao em ALTERAR)
        IF PEMSTATUS(loc_oPagina, "txt_4c_cd_grupo", 5)
            loc_oPagina.txt_4c_cd_grupo.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        *-- Campos adicionados na Fase 6
        IF PEMSTATUS(loc_oPagina, "txt_4c_cd_conta", 5)
            loc_oPagina.txt_4c_cd_conta.ReadOnly = !par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina, "opt_4c_Tipos", 5)
            loc_oPagina.opt_4c_Tipos.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita Salvar conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEdicao
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = THIS.this_cModoAtual $ "INCLUIR/ALTERAR"

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Salvar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled  = loc_lEdicao
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarGrupoForm - Handler LostFocus de txt_4c_cd_grupo
    * Valida codigo no banco (SigCdGcr) e preenche descricao em ds_grupo
    *==========================================================================
    PROCEDURE ValidarGrupoForm(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cGrupo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)

        IF !THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
            RETURN
        ENDIF

        IF EMPTY(loc_cGrupo)
            loc_oPagina.txt_4c_ds_grupo.Value = ""
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.ValidarGrupo(loc_cGrupo)
            loc_oPagina.txt_4c_ds_grupo.Value = THIS.this_oBusinessObject.this_cDsGrupo
        ELSE
            MsgAviso("Grupo inv" + CHR(225) + "lido!", "Grupo")
            loc_oPagina.txt_4c_cd_grupo.Value = ""
            loc_oPagina.txt_4c_ds_grupo.Value = ""
            loc_oPagina.txt_4c_cd_grupo.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaGrupoKeyPress - Handler KeyPress de txt_4c_cd_grupo (F4=lookup)
    *==========================================================================
    PROCEDURE TeclaGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupo()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupo - FormBuscaAuxiliar para SigCdGcr (Grupos Conta Corrente)
    * Replica fAcessoContab('C'): lookup por codigo, preenche descricao
    *==========================================================================
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oPagina, loc_oBusca, loc_cGrupo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)

        IF !THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", ;
                loc_cGrupo, "Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrupo")
                        SELECT cursor_4c_BuscaGrupo
                        loc_oPagina.txt_4c_cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                        loc_oPagina.txt_4c_ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        SELECT cursor_4c_BuscaGrupo
                        loc_oPagina.txt_4c_cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                        loc_oPagina.txt_4c_ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de grupo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarContaForm - Handler LostFocus de txt_4c_cd_conta
    * Valida codigo no banco (SigCdCli filtrado por grupo) e preenche descricao
    *==========================================================================
    PROCEDURE ValidarContaForm(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cGrupo, loc_cConta
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)
        loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_cd_conta.Value)

        IF !THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
            RETURN
        ENDIF

        IF EMPTY(loc_cConta)
            loc_oPagina.txt_4c_ds_conta.Value = ""
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.ValidarConta(loc_cGrupo, loc_cConta)
            loc_oPagina.txt_4c_ds_conta.Value = THIS.this_oBusinessObject.this_cDsConta
        ELSE
            MsgAviso("Conta inv" + CHR(225) + "lida!", "Conta")
            loc_oPagina.txt_4c_cd_conta.Value = ""
            loc_oPagina.txt_4c_ds_conta.Value = ""
            loc_oPagina.txt_4c_cd_conta.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaContaKeyPress - Handler KeyPress de txt_4c_cd_conta (F4=lookup)
    *==========================================================================
    PROCEDURE TeclaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - FormBuscaAuxiliar para SigCdCli filtrado por grupo
    * Replica fAcessoContas('C'): busca conta dentro do grupo selecionado
    *==========================================================================
    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oPagina, loc_oBusca, loc_cGrupo, loc_cConta
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)
        loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_cd_conta.Value)

        IF !THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
            RETURN
        ENDIF

        IF EMPTY(loc_cGrupo)
            MsgAviso("Informe o Grupo antes de buscar a Conta!", "Conta")
            loc_oPagina.txt_4c_cd_grupo.SetFocus()
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.BuscarContas(loc_cGrupo, loc_cConta)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
                    loc_oBusca.this_cTitulo        = "Conta"
                    loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Rclis", "", "Nome da Conta")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPagina.txt_4c_cd_conta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
                        loc_oPagina.txt_4c_ds_conta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de conta: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos do formulario
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao destruir FormDsp: " + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
