*==============================================================================
* FormCargo.prg - Formulario de Cadastro de Cargos
* Data: 2026-03-22
* Tabela: SigCdCrg | PK: ccargs | Secundaria: SigCrRcc
* Legado: SIGCDCAR.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormCargo AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Cargos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    ForeColor   = RGB(90, 90, 90)

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""    && OBRIGATORIO - nao herdado de FormBase

    *-- Guard para LostFocus de lookups
    this_cUltimoValidarGrupoValidado       = ""
    this_cUltimoGradeCol1LostFocusValidado = ""
    this_cUltimoGradeCol2LostFocusValidado = ""
    this_cUltimoGradeCol4LostFocusValidado = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CargoBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object CargoBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                *-- Criar cursor placeholder para grade SigCrRcc (Page2)
                IF USED("cursor_4c_Rcc")
                    USE IN cursor_4c_Rcc
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Rcc (Grupos C(20), Contas C(20), Valors N(15,2), Moedas C(10), Cargos C(10), CidChaves C(36))
                APPEND BLANK
                SET NULL OFF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarGradeEventos()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Pula CarregarLista() em modo de validacao UI
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar FormCargo:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal
    * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption  = "Lista"
            .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption  = "Dados"
            .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao +29: Top original 0 -> 29
    * Grade: Left=30, Top=103 -> 132, Width=938, Height=470
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (cntSombra: Top=2 -> 31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Cargos"
            .Top       = 20
            .Left      = 20
            .Width     = 300
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op: Left=544, Top=0 -> 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Inserir: Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Consultar: Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Procurar: Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (Grupo_Saida: Left=919, Top=0 -> 29)
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
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container de filtros (cntFiltros - vazio)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 29
            .Left        = 5
            .Width       = 530
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Grade de lista (Grade: Left=30, Top=103 -> 132, Width=938, Height=470)
        *-- 2 colunas: cCargs(Cargo), dCargs(Descricao)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 132
            .Left              = 30
            .Width             = 938
            .Height            = 470
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .GridLineColor     = RGB(192, 192, 192)
            .ColumnCount       = 2
            .AllowHeaderSizing = .T.
            .FontName          = "Tahoma"
            .ForeColor         = RGB(90, 90, 90)
            .Visible           = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao +29 em TODOS os controles (Top_original + 29)
    * Legado: todos os controles em SIGCDCAR.Pagina.Dados.*
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *======================================================================
        *-- Container de botoes Salvar/Cancelar (Grupo_Salva: Left=838, Top=7 -> 36)
        *======================================================================
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 36
            .Left        = 838
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *======================================================================
        *-- LINHA 1 (Top original ~33/37)
        *-- Cargo: Say1 Left=168 Top=37->66 | txt_4c_Cargo Left=210 Top=33->62 Width=80
        *-- cmdGarqicone: Left=294 Top=32->61 Width=25 Height=25
        *-- Senha: Say5 Left=549 Top=37->66 | txt_4c_Senha Left=592 Top=33->62 Width=20
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Cargo :"
            .Left      = 168
            .Top       = 66
            .Width     = 41
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cargo", "TextBox")
        WITH loc_oPagina.txt_4c_Cargo
            .Value         = ""
            .Left          = 210
            .Top           = 62
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Cargo, "KeyPress", THIS, "txt_4c_Cargo_KeyPress")

        *-- Botao "..." para busca de cargo (cmdGarqicone: Left=294, Top=32->61)
        loc_oPagina.AddObject("obj_4c_CmdGarqicone", "CommandGroup")
        WITH loc_oPagina.obj_4c_CmdGarqicone
            .ButtonCount   = 1
            .AutoSize      = .F.
            .Height        = 25
            .Left          = 294
            .Top           = 61
            .Width         = 25
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
            WITH .Buttons(1)
                .Caption       = "..."
                .Top           = 0
                .Left          = 0
                .Height        = 25
                .Width         = 25
                .FontBold      = .T.
                .SpecialEffect = 1
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.obj_4c_CmdGarqicone, "Click", THIS, "BtnGarqiconeClick")

        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Senha :"
            .Left      = 549
            .Top       = 66
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Senha", "TextBox")
        WITH loc_oPagina.txt_4c_Senha
            .Value         = "N"
            .Left          = 592
            .Top           = 62
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 66
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 2 (Top original ~58/62)
        *-- Descricao: Say2 Left=151 Top=62->91 | txt_4c_Descr Left=210 Top=58->87 Width=155
        *-- Altera Cotacao: Say12 Left=507 Top=62->91 | txt_4c_Altcot Left=592 Top=58->87
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Left      = 151
            .Top       = 91
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value         = ""
            .Left          = 210
            .Top           = 87
            .Width         = 155
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Altera Cota" + CHR(231) + CHR(227) + "o :"
            .Left      = 507
            .Top       = 91
            .Width     = 84
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Altcot", "TextBox")
        WITH loc_oPagina.txt_4c_Altcot
            .Value         = "N"
            .Left          = 592
            .Top           = 87
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 91
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 3 (Top original ~83/87)
        *-- Limite Desconto: Say3 Left=122 Top=87->116 | txt_4c_Limdesc Left=210 Top=83->112 Width=108
        *--   txt_4c_Desc Left=320 Top=83->112 Width=45 | Say7 "%" Left=368 Top=87->116
        *-- Libera Limite: Say14 Left=520 Top=87->116 | txt_4c_Limite Left=592 Top=83->112
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Limite Desconto :"
            .Left      = 122
            .Top       = 116
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Limdesc", "TextBox")
        WITH loc_oPagina.txt_4c_Limdesc
            .Value         = 0
            .Left          = 210
            .Top           = 112
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPagina.txt_4c_Desc
            .Value         = 0
            .Left          = 320
            .Top           = 112
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999999"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "%"
            .Left      = 368
            .Top       = 116
            .Width     = 15
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "Libera Limite :"
            .Left      = 520
            .Top       = 116
            .Width     = 71
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Limite", "TextBox")
        WITH loc_oPagina.txt_4c_Limite
            .Value         = "N"
            .Left          = 592
            .Top           = 112
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 116
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 4 (Top original ~108/112)
        *-- Limite Acrescimo: Say4 Left=119 Top=112->141 | txt_4c_LimAcre Left=210 Top=108->137 Width=108
        *--   txt_4c_Acre Left=320 Top=108->137 Width=45 | Say10 "%" Left=368 Top=112->141
        *-- Cancela Item Cupom: Say21 Left=454 Top=112->141 | txt_4c_CancItem Left=592 Top=108->137
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Limite Acr" + CHR(233) + "scimo :"
            .Left      = 119
            .Top       = 141
            .Width     = 90
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_LimAcre", "TextBox")
        WITH loc_oPagina.txt_4c_LimAcre
            .Value         = 0
            .Left          = 210
            .Top           = 137
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Acre", "TextBox")
        WITH loc_oPagina.txt_4c_Acre
            .Value         = 0
            .Left          = 320
            .Top           = 137
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999999"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "%"
            .Left      = 368
            .Top       = 141
            .Width     = 15
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPagina.lbl_4c_Label21
            .Caption   = "Cancela Item Cupom Fiscal:"
            .Left      = 454
            .Top       = 141
            .Width     = 137
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CancItem", "TextBox")
        WITH loc_oPagina.txt_4c_CancItem
            .Value         = "N"
            .Left          = 592
            .Top           = 137
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPagina.lbl_4c_Label22
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 141
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 5 (Top original ~133/137)
        *-- Lib.Pagamentos: Say25 Left=83 Top=137->166 | txt_4c_VlPag Left=210 Top=133->162 Width=108
        *--   Say26 "(R$)" Left=323 Top=137->166
        *-- Excluir Cond.Pagto: Say23 Left=447 Top=137->166 | txt_4c_LibFpag Left=592 Top=133->162
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPagina.lbl_4c_Label25
            .Caption   = "Liberar Pagamentos at" + CHR(233) + " :"
            .Left      = 83
            .Top       = 166
            .Width     = 126
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_VlPag", "TextBox")
        WITH loc_oPagina.txt_4c_VlPag
            .Value         = 0
            .Left          = 210
            .Top           = 162
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPagina.lbl_4c_Label26
            .Caption   = "(R$)"
            .Left      = 323
            .Top       = 166
            .Width     = 30
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oPagina.lbl_4c_Label23
            .Caption   = "Excluir Condi" + CHR(231) + CHR(227) + "o Pagto (ecf):"
            .Left      = 447
            .Top       = 166
            .Width     = 144
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_LibFpag", "TextBox")
        WITH loc_oPagina.txt_4c_LibFpag
            .Value         = "N"
            .Left          = 592
            .Top           = 162
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPagina.lbl_4c_Label24
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 166
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 6 (Top original ~158/162)
        *-- Lib.Cotacoes: Say30 Left=97 Top=162->191 | txt_4c_VlLibCots Left=210 Top=158->187 Width=108
        *--   Say31 "(R$)" Left=323 Top=162->191
        *-- Lib.Saldo Insuf: Say28 Left=462 Top=162->191 | txt_4c_SdInsu Left=592 Top=158->187
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oPagina.lbl_4c_Label30
            .Caption   = "Liberar Cota" + CHR(231) + CHR(245) + "es at" + CHR(233) + " :"
            .Left      = 97
            .Top       = 191
            .Width     = 112
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_VlLibCots", "TextBox")
        WITH loc_oPagina.txt_4c_VlLibCots
            .Value         = 0
            .Left          = 210
            .Top           = 187
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oPagina.lbl_4c_Label31
            .Caption   = "(R$)"
            .Left      = 323
            .Top       = 191
            .Width     = 30
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPagina.lbl_4c_Label28
            .Caption   = "Libera Saldo Insuficiente :"
            .Left      = 462
            .Top       = 191
            .Width     = 129
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_SdInsu", "TextBox")
        WITH loc_oPagina.txt_4c_SdInsu
            .Value         = "N"
            .Left          = 592
            .Top           = 187
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oPagina.lbl_4c_Label29
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 191
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 7 (Top original ~183/187)
        *-- Lib.Movimentacoes: Say32 Left=68 Top=187->216 | txt_4c_VlLibOps Left=210 Top=183->212 Width=108
        *--   Say33 "(R$)" Left=323 Top=187->216
        *-- Lib.Cond.Pagto: Say16 Left=468 Top=187->216 | txt_4c_Libfpg Left=592 Top=183->212
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label32", "Label")
        WITH loc_oPagina.lbl_4c_Label32
            .Caption   = "Liberar Movimenta" + CHR(231) + CHR(245) + "es at" + CHR(233) + " :"
            .Left      = 68
            .Top       = 216
            .Width     = 141
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_VlLibOps", "TextBox")
        WITH loc_oPagina.txt_4c_VlLibOps
            .Value         = 0
            .Left          = 210
            .Top           = 212
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label33", "Label")
        WITH loc_oPagina.lbl_4c_Label33
            .Caption   = "(R$)"
            .Left      = 323
            .Top       = 216
            .Width     = 30
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPagina.lbl_4c_Label16
            .Caption   = "Liberar Condi" + CHR(231) + CHR(227) + "o Pagto :"
            .Left      = 468
            .Top       = 216
            .Width     = 123
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Libfpg", "TextBox")
        WITH loc_oPagina.txt_4c_Libfpg
            .Value         = "N"
            .Left          = 592
            .Top           = 212
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oPagina.lbl_4c_Label34
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 216
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 8 (Top original ~208/212)
        *-- Variacao Cotacao: Say11 Left=113 Top=212->241 | txt_4c_Valcot Left=210 Top=208->237 Width=52
        *--   Say20 "(%)" Left=267 Top=212->241
        *-- Lib.Multiplos Opers: Say48 Left=404 Top=212->241 | txt_4c_LibOpers Left=592 Top=208->237
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o Cota" + CHR(231) + CHR(227) + "o :"
            .Left      = 113
            .Top       = 241
            .Width     = 96
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valcot", "TextBox")
        WITH loc_oPagina.txt_4c_Valcot
            .Value         = 0
            .Left          = 210
            .Top           = 237
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPagina.lbl_4c_Label20
            .Caption   = "(%)"
            .Left      = 267
            .Top       = 241
            .Width     = 21
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label48", "Label")
        WITH loc_oPagina.lbl_4c_Label48
            .Caption   = "Liberar M" + CHR(250) + "ltiplos Opers no Rec./Pag. :"
            .Left      = 404
            .Top       = 241
            .Width     = 187
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_LibOpers", "TextBox")
        WITH loc_oPagina.txt_4c_LibOpers
            .Value         = "N"
            .Left          = 592
            .Top           = 237
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label49", "Label")
        WITH loc_oPagina.lbl_4c_Label49
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 241
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 9 (Top original ~233/237)
        *-- Grupo Financeiro: Say38 Left=116 Top=237->266 | txt_4c__Grupo Left=210 Top=233->262 Width=80
        *-- Lib.Mov.Estoque: Say35 Left=412 Top=237->266 | txt_4c_LibOpe Left=592 Top=233->262
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oPagina.lbl_4c_Label38
            .Caption   = "Grupo Financeiro :"
            .Left      = 116
            .Top       = 266
            .Width     = 93
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__Grupo", "TextBox")
        WITH loc_oPagina.txt_4c__Grupo
            .Value         = ""
            .Left          = 210
            .Top           = 262
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c__Grupo, "KeyPress", THIS, "ValidarGrupo")

        loc_oPagina.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oPagina.lbl_4c_Label35
            .Caption   = "Liberar Movimenta" + CHR(231) + CHR(245) + "es de Estoque :"
            .Left      = 412
            .Top       = 266
            .Width     = 179
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_LibOpe", "TextBox")
        WITH loc_oPagina.txt_4c_LibOpe
            .Value         = "N"
            .Left          = 592
            .Top           = 262
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label36", "Label")
        WITH loc_oPagina.lbl_4c_Label36
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 266
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 10 (Top original ~258/262/263)
        *-- Lib.Alt.Conta Senha: Say44 Left=395 Top=262->291 | txt_4c_LibAltCli Left=592 Top=258->287
        *-- Lib.Produtos Bloqueados: Say37 Left=64 Top=263->292 | opt_libleilao Left=206 Top=259->288
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label44", "Label")
        WITH loc_oPagina.lbl_4c_Label44
            .Caption   = "Liberar Altera" + CHR(231) + CHR(227) + "o de Conta com Senha :"
            .Left      = 395
            .Top       = 291
            .Width     = 196
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_LibAltCli", "TextBox")
        WITH loc_oPagina.txt_4c_LibAltCli
            .Value         = "N"
            .Left          = 592
            .Top           = 287
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label45", "Label")
        WITH loc_oPagina.lbl_4c_Label45
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 291
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label37", "Label")
        WITH loc_oPagina.lbl_4c_Label37
            .Caption   = "Libera Produtos Bloqueados :"
            .Left      = 64
            .Top       = 292
            .Width     = 141
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: opt_libleilao (libleilaos: Sim/Nao) Left=206, Top=259->288
        loc_oPagina.AddObject("obj_4c_OptLibleilao", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptLibleilao
            .ButtonCount   = 2
            .BackStyle     = 0
            .SpecialEffect = 0
            .Height        = 22
            .Left          = 206
            .Top           = 288
            .Width         = 89
            .Value         = 2
            .Visible       = .T.
            WITH .Buttons(1)
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Sim"
                .Left      = 4
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 47
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *======================================================================
        *-- LINHA 11 (Top original ~279/283/287)
        *-- Lib.Duplicidade: Say40 Left=111 Top=283->312 | Fwoption1 Left=206 Top=279->308
        *-- Lib.Excluir Mov.Producao: Say46 Left=381 Top=287->316 | txt_4c_LibExPrd Left=592 Top=283->312
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label40", "Label")
        WITH loc_oPagina.lbl_4c_Label40
            .Caption      = "Libera Duplicidade :"
            .Left         = 111
            .Top          = 312
            .Width        = 94
            .Height       = 17
            .FontName     = "Tahoma"
            .FontSize     = 8
            .BackStyle    = 0
            .ForeColor    = RGB(90, 90, 90)
            .ToolTipText  = "Este flag permite liberar endere" + CHR(231) + "os duplicados no cadastro de contas e endere" + CHR(231) + "o de entrega."
            .Visible      = .T.
        ENDWITH

        *-- OptionGroup: Fwoption1 (libDupEnds: Sim/Nao) Left=206, Top=279->308
        loc_oPagina.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPagina.obj_4c_Fwoption1
            .ButtonCount   = 2
            .BackStyle     = 0
            .SpecialEffect = 0
            .Height        = 22
            .Left          = 206
            .Top           = 308
            .Width         = 89
            .Value         = 2
            .Visible       = .T.
            WITH .Buttons(1)
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Sim"
                .Left      = 4
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 47
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label46", "Label")
        WITH loc_oPagina.lbl_4c_Label46
            .Caption   = "Libera Excluir Movimenta" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o :"
            .Left      = 381
            .Top       = 316
            .Width     = 210
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_LibExPrd", "TextBox")
        WITH loc_oPagina.txt_4c_LibExPrd
            .Value         = "N"
            .Left          = 592
            .Top           = 312
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label47", "Label")
        WITH loc_oPagina.lbl_4c_Label47
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 316
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 12 (Top original ~300/304/308/312)
        *-- Lib.Saldo Tanque: Say43 Left=25 Top=304->333 | Fwoption4 Left=206 Top=300->329
        *-- Lib.Var.Peso: Say50 Left=461 Top=312->341 | txt_4c_LibVarPeso Left=592 Top=308->337
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label43", "Label")
        WITH loc_oPagina.lbl_4c_Label43
            .Caption      = "Libera Saldo Insuficiente No Tanque :"
            .Left         = 25
            .Top          = 333
            .Width        = 180
            .Height       = 17
            .FontName     = "Tahoma"
            .FontSize     = 8
            .BackStyle    = 0
            .ForeColor    = RGB(90, 90, 90)
            .ToolTipText  = "Este flag permite liberar endere" + CHR(231) + "os duplicados no cadastro de contas e endere" + CHR(231) + "o de entrega."
            .Visible      = .T.
        ENDWITH

        *-- OptionGroup: Fwoption4 (libSldTqe: Sim/Nao) Left=206, Top=300->329
        loc_oPagina.AddObject("obj_4c_Fwoption4", "OptionGroup")
        WITH loc_oPagina.obj_4c_Fwoption4
            .ButtonCount   = 2
            .BackStyle     = 0
            .SpecialEffect = 0
            .Height        = 22
            .Left          = 206
            .Top           = 329
            .Width         = 89
            .Value         = 2
            .Visible       = .T.
            WITH .Buttons(1)
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Sim"
                .Left      = 4
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 47
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label50", "Label")
        WITH loc_oPagina.lbl_4c_Label50
            .Caption   = "Liberar Varia" + CHR(231) + CHR(227) + "o de Peso :"
            .Left      = 461
            .Top       = 341
            .Width     = 130
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_LibVarPeso", "TextBox")
        WITH loc_oPagina.txt_4c_LibVarPeso
            .Value         = "N"
            .Left          = 592
            .Top           = 337
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label51", "Label")
        WITH loc_oPagina.lbl_4c_Label51
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 341
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 13 (Top original ~327/333/337)
        *-- Say27 "Liberar Pagamentos por Centro de Custo" Left=48 Top=327->356 (BOLD)
        *-- (LibTroca removido - coluna nao existe no schema)
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPagina.lbl_4c_Label27
            .Caption   = "Liberar Pagamentos por Centro de Custo"
            .Left      = 48
            .Top       = 356
            .Width     = 231
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 2
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH


        *======================================================================
        *-- GRADE SigCrRcc (Grade: Left=48, Top=342->371, Width=310, Height=256)
        *-- 4 colunas: Grupo(80), Conta(80), Valor(80), Moeda(35)
        *======================================================================
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .DeleteMark    = .F.
            .GridLines     = 3
            .GridLineWidth = 1
            .GridLineColor = RGB(192, 192, 192)
            .HeaderHeight  = 20
            .Height        = 256
            .Left          = 48
            .ScrollBars    = 2
            .Top           = 371
            .Width         = 310
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
            .RecordMark   = .F.
        ENDWITH

        *-- ColumnCount e RecordSource FORA do WITH (evita "Unknown member COLUMN1")
        loc_oPagina.grd_4c_Dados.ColumnCount = 4
        loc_oPagina.grd_4c_Dados.RecordSource = "cursor_4c_Rcc"

        *-- Headers
        WITH loc_oPagina.grd_4c_Dados.Column1
            .Width = 80
            .Header1.Caption   = "Grupo"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPagina.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Rcc.Grupos"

        WITH loc_oPagina.grd_4c_Dados.Column2
            .Width = 80
            .Header1.Caption   = "Conta"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPagina.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Rcc.Contas"

        WITH loc_oPagina.grd_4c_Dados.Column3
            .Width = 80
            .Header1.Caption   = "Valor"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPagina.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Rcc.Valors"

        WITH loc_oPagina.grd_4c_Dados.Column4
            .Width = 35
            .Header1.Caption   = "Moeda"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPagina.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Rcc.Moedas"

        *-- Botao Inserir linha na grade (inserir: Left=366, Top=413->442, H=45, W=45)
        loc_oPagina.AddObject("cmd_4c_AdicionarLinha", "CommandButton")
        WITH loc_oPagina.cmd_4c_AdicionarLinha
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
            .Top           = 442
            .Left          = 366
            .Height        = 45
            .Width         = 45
            .FontBold      = .T.
            .FontName      = "Arial"
            .FontSize      = 9
            .ToolTipText   = "Inserir"
            .ForeColor     = RGB(0, 128, 0)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_AdicionarLinha, "Click", THIS, "BtnAdicionarLinhaClick")

        *-- Botao Excluir linha da grade (excluir: Left=366, Top=457->486, H=45, W=45)
        loc_oPagina.AddObject("cmd_4c_RemoverLinha", "CommandButton")
        WITH loc_oPagina.cmd_4c_RemoverLinha
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Top           = 486
            .Left          = 366
            .Height        = 45
            .Width         = 45
            .FontBold      = .T.
            .FontName      = "Arial"
            .FontSize      = 9
            .ToolTipText   = "Excluir"
            .ForeColor     = RGB(255, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_RemoverLinha, "Click", THIS, "BtnRemoverLinhaClick")

        *======================================================================
        *-- LINHA 15 (Top original ~358/362)
        *-- Fator Comissao: Say18 Left=490 Top=362->391 | txt_4c_FComis Left=592 Top=358->387
        *--   Say19 "(S/N)" Left=616 Top=362->391
        *--   txt_4c_AComis Left=653 Top=358->387 Width=52 | Say17 "(%)" Left=711 Top=362->391
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPagina.lbl_4c_Label18
            .Caption   = "Fator de Comiss" + CHR(227) + "o :"
            .Left      = 490
            .Top       = 391
            .Width     = 101
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_FComis", "TextBox")
        WITH loc_oPagina.txt_4c_FComis
            .Value         = "N"
            .Left          = 592
            .Top           = 387
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPagina.lbl_4c_Label19
            .Caption   = "(S/N)"
            .Left      = 616
            .Top       = 391
            .Width     = 35
            .Height    = 17
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_AComis", "TextBox")
        WITH loc_oPagina.txt_4c_AComis
            .Value         = 0
            .Left          = 653
            .Top           = 387
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999.99"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_AComis, "KeyPress", THIS, "ValidarAComis")

        loc_oPagina.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPagina.lbl_4c_Label17
            .Caption   = "(%)"
            .Left      = 711
            .Top       = 391
            .Width     = 21
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- LINHA 16 (Top original ~382/383/386)
        *-- Comissao: Say6 Left=534 Top=386->415 | txt_4c_Comi Left=592 Top=382->411 Width=52
        *--   Say9 "(%)" Left=649 Top=386->415
        *--   Say39 "Tipo : " Left=694 Top=386->415 | tp_Comis Left=722 Top=383->412 W=141 H=21
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Comiss" + CHR(227) + "o :"
            .Left      = 534
            .Top       = 415
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Comi", "TextBox")
        WITH loc_oPagina.txt_4c_Comi
            .Value         = 0
            .Left          = 592
            .Top           = 411
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999.99"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "(%)"
            .Left      = 649
            .Top       = 415
            .Width     = 21
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oPagina.lbl_4c_Label39
            .Caption   = "Tipo : "
            .Left      = 694
            .Top       = 415
            .Width     = 32
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: tp_Comis (Tpcomis: %/Tab.Desconto) Left=722, Top=383->412, W=141, H=21
        loc_oPagina.AddObject("obj_4c_TpComis", "OptionGroup")
        WITH loc_oPagina.obj_4c_TpComis
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Height        = 21
            .Left          = 722
            .Top           = 412
            .Width         = 141
            .Value         = 1
            .Visible       = .T.
            WITH .Buttons(1)
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "%"
                .Left      = 4
                .Top       = 2
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Tab.Desconto"
                .Left      = 36
                .Top       = 2
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *======================================================================
        *-- LINHA 17 (Top original ~405/409/426/430)
        *-- Lib.Titulos Iguais: Say41 Left=480 Top=409->438 | Fwoption2 Left=587 Top=405->434
        *-- Lib.Prazo Entrega: Say42 Left=464 Top=430->459 | Fwoption3 Left=587 Top=426->455
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Label41", "Label")
        WITH loc_oPagina.lbl_4c_Label41
            .Caption      = "Liberar T" + CHR(237) + "tulos Iguais :"
            .Left         = 480
            .Top          = 438
            .Width        = 106
            .Height       = 17
            .FontName     = "Tahoma"
            .FontSize     = 8
            .BackStyle    = 0
            .ForeColor    = RGB(90, 90, 90)
            .ToolTipText  = "Permite salvar t" + CHR(237) + "tulos com a mesma conta / vencimento  / valor."
            .Visible      = .T.
        ENDWITH

        *-- OptionGroup: Fwoption2 (libDupTits: Sim/Nao) Left=587, Top=405->434
        loc_oPagina.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH loc_oPagina.obj_4c_Fwoption2
            .ButtonCount   = 2
            .BackStyle     = 0
            .SpecialEffect = 0
            .Height        = 22
            .Left          = 587
            .Top           = 434
            .Width         = 89
            .Value         = 2
            .Visible       = .T.
            WITH .Buttons(1)
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Sim"
                .Left      = 4
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 47
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label42", "Label")
        WITH loc_oPagina.lbl_4c_Label42
            .Caption      = "Libera Prazo de Entrega :"
            .Left         = 464
            .Top          = 459
            .Width        = 122
            .Height       = 17
            .FontName     = "Tahoma"
            .FontSize     = 8
            .BackStyle    = 0
            .ForeColor    = RGB(90, 90, 90)
            .ToolTipText  = "Permite lan" + CHR(231) + "ar prazo de entrega fora do m" + CHR(237) + "nimo e m" + CHR(225) + "ximo configurado na movimenta" + CHR(231) + CHR(227) + "o"
            .Visible      = .T.
        ENDWITH

        *-- OptionGroup: Fwoption3 (libPrzes: Sim/Nao) Left=587, Top=426->455
        loc_oPagina.AddObject("obj_4c_Fwoption3", "OptionGroup")
        WITH loc_oPagina.obj_4c_Fwoption3
            .ButtonCount   = 2
            .BackStyle     = 0
            .SpecialEffect = 0
            .Height        = 22
            .Left          = 587
            .Top           = 455
            .Width         = 89
            .Value         = 2
            .Visible       = .T.
            WITH .Buttons(1)
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Sim"
                .Left      = 4
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 47
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis em uma pagina
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oPagina)
        LOCAL loc_nI
        FOR loc_nI = 1 TO par_oPagina.ControlCount
            par_oPagina.Controls(loc_nI).Visible = .T.
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeEventos - Configura BINDEVENTs LostFocus nas colunas da grade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeEventos()
        LOCAL loc_oGrade
        loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
        BINDEVENT(loc_oGrade.Column1.Text1, "KeyPress", THIS, "GradeCol1LostFocus")
        BINDEVENT(loc_oGrade.Column2.Text1, "KeyPress", THIS, "GradeCol2LostFocus")
        BINDEVENT(loc_oGrade.Column4.Text1, "KeyPress", THIS, "GradeCol4LostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos()
        LOCAL loc_oPag2, loc_lEditar, loc_lIncluir
        loc_oPag2    = THIS.pgf_4c_Paginas.Page2
        loc_lEditar  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
        loc_lIncluir = (THIS.this_cModoAtual = "INCLUIR")

        *-- Campo Cargo: editavel apenas em INCLUIR e BUSCAR
        loc_oPag2.txt_4c_Cargo.Enabled         = (INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))
        loc_oPag2.obj_4c_CmdGarqicone.Enabled  = (INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))

        *-- Demais campos de dados: editaveis em INCLUIR e ALTERAR
        loc_oPag2.txt_4c_Descr.Enabled         = loc_lEditar
        loc_oPag2.txt_4c_Senha.Enabled         = loc_lEditar
        loc_oPag2.txt_4c_Altcot.Enabled        = loc_lEditar
        loc_oPag2.txt_4c_Limdesc.Enabled       = loc_lEditar
        loc_oPag2.txt_4c_Desc.Enabled          = loc_lEditar
        loc_oPag2.txt_4c_Limite.Enabled        = loc_lEditar
        loc_oPag2.txt_4c_LimAcre.Enabled       = loc_lEditar
        loc_oPag2.txt_4c_Acre.Enabled          = loc_lEditar
        loc_oPag2.txt_4c_CancItem.Enabled      = loc_lEditar
        loc_oPag2.txt_4c_VlPag.Enabled         = loc_lEditar
        loc_oPag2.txt_4c_LibFpag.Enabled       = loc_lEditar
        loc_oPag2.txt_4c_VlLibCots.Enabled     = loc_lEditar
        loc_oPag2.txt_4c_SdInsu.Enabled        = loc_lEditar
        loc_oPag2.txt_4c_VlLibOps.Enabled      = loc_lEditar
        loc_oPag2.txt_4c_Libfpg.Enabled        = loc_lEditar
        loc_oPag2.txt_4c_Valcot.Enabled        = loc_lEditar
        loc_oPag2.txt_4c_LibOpers.Enabled      = loc_lEditar
        loc_oPag2.txt_4c__Grupo.Enabled        = loc_lEditar
        loc_oPag2.txt_4c_LibOpe.Enabled        = loc_lEditar
        loc_oPag2.txt_4c_LibAltCli.Enabled     = loc_lEditar
        loc_oPag2.obj_4c_OptLibleilao.Enabled  = loc_lEditar
        loc_oPag2.obj_4c_Fwoption1.Enabled     = loc_lEditar
        loc_oPag2.txt_4c_LibExPrd.Enabled      = loc_lEditar
        loc_oPag2.obj_4c_Fwoption4.Enabled     = loc_lEditar
        loc_oPag2.txt_4c_LibVarPeso.Enabled    = loc_lEditar

        loc_oPag2.txt_4c_FComis.Enabled        = loc_lEditar
        loc_oPag2.txt_4c_AComis.Enabled        = loc_lEditar
        loc_oPag2.txt_4c_Comi.Enabled          = loc_lEditar
        loc_oPag2.obj_4c_TpComis.Enabled       = loc_lEditar
        loc_oPag2.obj_4c_Fwoption2.Enabled     = loc_lEditar
        loc_oPag2.obj_4c_Fwoption3.Enabled     = loc_lEditar

        *-- Grade e botoes grade: habilitados em INCLUIR e ALTERAR (nao em BUSCAR)
        LOCAL loc_lGrade
        loc_lGrade = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_oPag2.grd_4c_Dados.ReadOnly           = !loc_lGrade
        loc_oPag2.cmd_4c_AdicionarLinha.Enabled   = loc_lGrade
        loc_oPag2.cmd_4c_RemoverLinha.Enabled     = loc_lGrade
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag2.txt_4c_Cargo.Value         = ""
        loc_oPag2.txt_4c_Descr.Value         = ""
        loc_oPag2.txt_4c_Senha.Value         = "N"
        loc_oPag2.txt_4c_Altcot.Value        = "N"
        loc_oPag2.txt_4c_Limdesc.Value       = 0
        loc_oPag2.txt_4c_Desc.Value          = 0
        loc_oPag2.txt_4c_Limite.Value        = "N"
        loc_oPag2.txt_4c_LimAcre.Value       = 0
        loc_oPag2.txt_4c_Acre.Value          = 0
        loc_oPag2.txt_4c_CancItem.Value      = "N"
        loc_oPag2.txt_4c_VlPag.Value         = 0
        loc_oPag2.txt_4c_LibFpag.Value       = "N"
        loc_oPag2.txt_4c_VlLibCots.Value     = 0
        loc_oPag2.txt_4c_SdInsu.Value        = "N"
        loc_oPag2.txt_4c_VlLibOps.Value      = 0
        loc_oPag2.txt_4c_Libfpg.Value        = "N"
        loc_oPag2.txt_4c_Valcot.Value        = 0
        loc_oPag2.txt_4c_LibOpers.Value      = "N"
        loc_oPag2.txt_4c__Grupo.Value        = ""
        loc_oPag2.txt_4c_LibOpe.Value        = "N"
        loc_oPag2.txt_4c_LibAltCli.Value     = "N"
        loc_oPag2.obj_4c_OptLibleilao.Value  = 2
        loc_oPag2.obj_4c_Fwoption1.Value     = 2
        loc_oPag2.txt_4c_LibExPrd.Value      = "N"
        loc_oPag2.obj_4c_Fwoption4.Value     = 2
        loc_oPag2.txt_4c_LibVarPeso.Value    = "N"

        loc_oPag2.txt_4c_FComis.Value        = "N"
        loc_oPag2.txt_4c_AComis.Value        = 0
        loc_oPag2.txt_4c_Comi.Value          = 0
        loc_oPag2.obj_4c_TpComis.Value       = 1
        loc_oPag2.obj_4c_Fwoption2.Value     = 2
        loc_oPag2.obj_4c_Fwoption3.Value     = 2

        *-- Limpar grade RCC
        IF USED("cursor_4c_Rcc")
            SELECT cursor_4c_Rcc
            ZAP
        ENDIF
        loc_oPag2.grd_4c_Dados.ColumnCount = 4
        loc_oPag2.grd_4c_Dados.RecordSource = "cursor_4c_Rcc"
        loc_oPag2.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Rcc.Grupos"
        loc_oPag2.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Rcc.Contas"
        loc_oPag2.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Rcc.Valors"
        loc_oPag2.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Rcc.Moedas"
        loc_oPag2.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do form para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag2, loc_oBO
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO   = THIS.this_oBusinessObject

        loc_oBO.this_cCargo      = UPPER(ALLTRIM(loc_oPag2.txt_4c_Cargo.Value))
        loc_oBO.this_cDescricao  = ALLTRIM(loc_oPag2.txt_4c_Descr.Value)
        loc_oBO.this_cSenha      = UPPER(ALLTRIM(loc_oPag2.txt_4c_Senha.Value))
        loc_oBO.this_cAltCots    = UPPER(ALLTRIM(loc_oPag2.txt_4c_Altcot.Value))
        loc_oBO.this_nLimDesc    = loc_oPag2.txt_4c_Limdesc.Value
        loc_oBO.this_nDescPor    = loc_oPag2.txt_4c_Desc.Value
        loc_oBO.this_cLimites    = UPPER(ALLTRIM(loc_oPag2.txt_4c_Limite.Value))
        loc_oBO.this_nLimAcre    = loc_oPag2.txt_4c_LimAcre.Value
        loc_oBO.this_nAcrePor    = loc_oPag2.txt_4c_Acre.Value
        loc_oBO.this_cCancItens  = UPPER(ALLTRIM(loc_oPag2.txt_4c_CancItem.Value))
        loc_oBO.this_nVlLibPgs   = loc_oPag2.txt_4c_VlPag.Value
        loc_oBO.this_cLibFpags   = UPPER(ALLTRIM(loc_oPag2.txt_4c_LibFpag.Value))
        loc_oBO.this_nVlLibCots  = loc_oPag2.txt_4c_VlLibCots.Value
        loc_oBO.this_cLibSdIns   = UPPER(ALLTRIM(loc_oPag2.txt_4c_SdInsu.Value))
        loc_oBO.this_nVlLibOpes  = loc_oPag2.txt_4c_VlLibOps.Value
        loc_oBO.this_cLibFpgs    = UPPER(ALLTRIM(loc_oPag2.txt_4c_Libfpg.Value))
        loc_oBO.this_nVarCots    = loc_oPag2.txt_4c_Valcot.Value
        loc_oBO.this_cLibOpers   = UPPER(ALLTRIM(loc_oPag2.txt_4c_LibOpers.Value))
        loc_oBO.this_cGrComis    = ALLTRIM(loc_oPag2.txt_4c__Grupo.Value)
        loc_oBO.this_cLibOpes    = UPPER(ALLTRIM(loc_oPag2.txt_4c_LibOpe.Value))
        loc_oBO.this_cLibAltCli  = UPPER(ALLTRIM(loc_oPag2.txt_4c_LibAltCli.Value))
        loc_oBO.this_nLibLeilao  = loc_oPag2.obj_4c_OptLibleilao.Value
        loc_oBO.this_nLibDupEnds = loc_oPag2.obj_4c_Fwoption1.Value
        loc_oBO.this_cLibExPrd   = UPPER(ALLTRIM(loc_oPag2.txt_4c_LibExPrd.Value))
        loc_oBO.this_nLibSldTqe  = loc_oPag2.obj_4c_Fwoption4.Value
        loc_oBO.this_cLibVarPeso = UPPER(ALLTRIM(loc_oPag2.txt_4c_LibVarPeso.Value))

        loc_oBO.this_cFComis     = UPPER(ALLTRIM(loc_oPag2.txt_4c_FComis.Value))
        loc_oBO.this_nAComis     = loc_oPag2.txt_4c_AComis.Value
        loc_oBO.this_nComis      = loc_oPag2.txt_4c_Comi.Value
        loc_oBO.this_nTpComis    = loc_oPag2.obj_4c_TpComis.Value
        loc_oBO.this_nLibDupTits = loc_oPag2.obj_4c_Fwoption2.Value
        loc_oBO.this_nLibPrzes   = loc_oPag2.obj_4c_Fwoption3.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag2, loc_oBO
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO   = THIS.this_oBusinessObject

        loc_oPag2.txt_4c_Cargo.Value         = ALLTRIM(loc_oBO.this_cCargo)
        loc_oPag2.txt_4c_Descr.Value         = ALLTRIM(loc_oBO.this_cDescricao)
        loc_oPag2.txt_4c_Senha.Value         = ALLTRIM(loc_oBO.this_cSenha)
        loc_oPag2.txt_4c_Altcot.Value        = ALLTRIM(loc_oBO.this_cAltCots)
        loc_oPag2.txt_4c_Limdesc.Value       = loc_oBO.this_nLimDesc
        loc_oPag2.txt_4c_Desc.Value          = loc_oBO.this_nDescPor
        loc_oPag2.txt_4c_Limite.Value        = ALLTRIM(loc_oBO.this_cLimites)
        loc_oPag2.txt_4c_LimAcre.Value       = loc_oBO.this_nLimAcre
        loc_oPag2.txt_4c_Acre.Value          = loc_oBO.this_nAcrePor
        loc_oPag2.txt_4c_CancItem.Value      = ALLTRIM(loc_oBO.this_cCancItens)
        loc_oPag2.txt_4c_VlPag.Value         = loc_oBO.this_nVlLibPgs
        loc_oPag2.txt_4c_LibFpag.Value       = ALLTRIM(loc_oBO.this_cLibFpags)
        loc_oPag2.txt_4c_VlLibCots.Value     = loc_oBO.this_nVlLibCots
        loc_oPag2.txt_4c_SdInsu.Value        = ALLTRIM(loc_oBO.this_cLibSdIns)
        loc_oPag2.txt_4c_VlLibOps.Value      = loc_oBO.this_nVlLibOpes
        loc_oPag2.txt_4c_Libfpg.Value        = ALLTRIM(loc_oBO.this_cLibFpgs)
        loc_oPag2.txt_4c_Valcot.Value        = loc_oBO.this_nVarCots
        loc_oPag2.txt_4c_LibOpers.Value      = ALLTRIM(loc_oBO.this_cLibOpers)
        loc_oPag2.txt_4c__Grupo.Value        = ALLTRIM(loc_oBO.this_cGrComis)
        loc_oPag2.txt_4c_LibOpe.Value        = ALLTRIM(loc_oBO.this_cLibOpes)
        loc_oPag2.txt_4c_LibAltCli.Value     = ALLTRIM(loc_oBO.this_cLibAltCli)
        loc_oPag2.obj_4c_OptLibleilao.Value  = loc_oBO.this_nLibLeilao
        loc_oPag2.obj_4c_Fwoption1.Value     = loc_oBO.this_nLibDupEnds
        loc_oPag2.txt_4c_LibExPrd.Value      = ALLTRIM(loc_oBO.this_cLibExPrd)
        loc_oPag2.obj_4c_Fwoption4.Value     = loc_oBO.this_nLibSldTqe
        loc_oPag2.txt_4c_LibVarPeso.Value    = ALLTRIM(loc_oBO.this_cLibVarPeso)

        loc_oPag2.txt_4c_FComis.Value        = ALLTRIM(loc_oBO.this_cFComis)
        loc_oPag2.txt_4c_AComis.Value        = loc_oBO.this_nAComis
        loc_oPag2.txt_4c_Comi.Value          = loc_oBO.this_nComis
        loc_oPag2.obj_4c_TpComis.Value       = loc_oBO.this_nTpComis
        loc_oPag2.obj_4c_Fwoption2.Value     = loc_oBO.this_nLibDupTits
        loc_oPag2.obj_4c_Fwoption3.Value     = loc_oBO.this_nLibPrzes
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da lista (Page1)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrade
        loc_lSucesso = .F.
        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrade.ColumnCount = 2
                loc_oGrade.RecordSource = "cursor_4c_Dados"
                loc_oGrade.Column1.ControlSource = "cursor_4c_Dados.ccargs"
                loc_oGrade.Column2.ControlSource = "cursor_4c_Dados.dcargs"
                loc_oGrade.Refresh()
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarRcc - Carrega registros SigCrRcc para o cargo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarRcc(par_cCargo)
        LOCAL loc_nRet, loc_cSQL, loc_oGrade
        TRY
            loc_cSQL = "SELECT Grupos, Contas, Valors, Moedas, Cargos, CidChaves " + ;
                       "FROM SigCrRcc WHERE Cargos = " + EscaparSQL(ALLTRIM(par_cCargo)) + ;
                       " ORDER BY Grupos, Contas"
            IF USED("cursor_4c_RccTemp")
                USE IN cursor_4c_RccTemp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RccTemp")
            IF loc_nRet > 0
                IF USED("cursor_4c_Rcc")
                    SELECT cursor_4c_Rcc
                    ZAP
                    APPEND FROM DBF("cursor_4c_RccTemp")
                ENDIF
                IF USED("cursor_4c_RccTemp")
                    USE IN cursor_4c_RccTemp
                ENDIF
            ELSE
                IF USED("cursor_4c_RccTemp")
                    USE IN cursor_4c_RccTemp
                ENDIF
            ENDIF

            *-- Garantir pelo menos uma linha em branco
            IF RECCOUNT("cursor_4c_Rcc") = 0
                SELECT cursor_4c_Rcc
                APPEND BLANK
            ENDIF

            loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
            loc_oGrade.ColumnCount = 4
            loc_oGrade.RecordSource = "cursor_4c_Rcc"
            loc_oGrade.Column1.ControlSource = "cursor_4c_Rcc.Grupos"
            loc_oGrade.Column1.Header1.Caption = "Grupo"
            loc_oGrade.Column2.ControlSource = "cursor_4c_Rcc.Contas"
            loc_oGrade.Column2.Header1.Caption = "Conta"
            loc_oGrade.Column3.ControlSource = "cursor_4c_Rcc.Valors"
            loc_oGrade.Column3.Header1.Caption = "Valor"
            loc_oGrade.Column4.ControlSource = "cursor_4c_Rcc.Moedas"
            loc_oGrade.Column4.Header1.Caption = "Moeda"
            loc_oGrade.Refresh()
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
            IF USED("cursor_4c_RccTemp")
                USE IN cursor_4c_RccTemp
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE BOTOES (LISTA)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.PrepararNovo()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Cargo.SetFocus()
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCargo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN
        ENDIF
        loc_cCargo = ALLTRIM(cursor_4c_Dados.ccargs)
        IF EMPTY(loc_cCargo)
            MsgAviso("Selecione um cargo na lista.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.CarregarRcc(loc_cCargo)
            THIS.HabilitarCampos()
            THIS.AlternarPagina(2)
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro)
        ENDIF
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCargo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN
        ENDIF
        loc_cCargo = ALLTRIM(cursor_4c_Dados.ccargs)
        IF EMPTY(loc_cCargo)
            MsgAviso("Selecione um cargo na lista.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargo)
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.CarregarRcc(loc_cCargo)
            THIS.HabilitarCampos()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descr.SetFocus()
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro)
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCargo, loc_nResp
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN
        ENDIF
        loc_cCargo = ALLTRIM(cursor_4c_Dados.ccargs)
        IF EMPTY(loc_cCargo)
            MsgAviso("Selecione um cargo na lista.")
            RETURN
        ENDIF
        loc_nResp = MsgConfirma("Confirma a exclus" + CHR(227) + "o do cargo " + loc_cCargo + "?")
        IF loc_nResp
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargo)
                IF THIS.this_oBusinessObject.ExecutarExclusao()
                    MsgInfo("Cargo exclu" + CHR(237) + "do com sucesso.")
                    THIS.CarregarLista()
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro)
                ENDIF
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro)
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.this_cModoAtual = "BUSCAR"
        THIS.LimparCampos()
        THIS.HabilitarCampos()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Cargo.SetFocus()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DE BOTOES (DADOS)
    *==========================================================================

    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPag2, loc_cCargo, loc_cFiltro
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Modo BUSCAR: apenas filtra lista
        IF THIS.this_cModoAtual = "BUSCAR"
            loc_cFiltro = ALLTRIM(loc_oPag2.txt_4c_Cargo.Value)
            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                LOCAL loc_oGrade
                loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrade.ColumnCount = 2
                loc_oGrade.RecordSource = "cursor_4c_Dados"
                loc_oGrade.Column1.ControlSource = "cursor_4c_Dados.ccargs"
                loc_oGrade.Column2.ControlSource = "cursor_4c_Dados.dcargs"
                loc_oGrade.Refresh()
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        *-- Modo VISUALIZAR: apenas volta
        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        *-- Modos INCLUIR / ALTERAR: validar e salvar
        loc_cCargo = UPPER(ALLTRIM(loc_oPag2.txt_4c_Cargo.Value))
        IF EMPTY(loc_cCargo)
            MsgAviso("C" + CHR(243) + "digo do Cargo obrigat" + CHR(243) + "rio.")
            loc_oPag2.txt_4c_Cargo.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(loc_oPag2.txt_4c_Descr.Value))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            loc_oPag2.txt_4c_Descr.SetFocus()
            RETURN
        ENDIF

        *-- Verificar duplicidade em INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            LOCAL loc_nRet, loc_cSQL
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCrg WHERE ccargs = " + EscaparSQL(loc_cCargo)
            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
            IF loc_nRet > 0 AND cursor_4c_DupCheck.qtd > 0
                IF USED("cursor_4c_DupCheck")
                    USE IN cursor_4c_DupCheck
                ENDIF
                MsgAviso("Cargo " + loc_cCargo + " j" + CHR(225) + " cadastrado.")
                loc_oPag2.txt_4c_Cargo.SetFocus()
                RETURN
            ENDIF
            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF
        ENDIF

        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Cargo salvo com sucesso.")
            THIS.CarregarLista()
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro)
        ENDIF
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *-- Botao "..." para lookup de cargo (busca por codigo semelhante)
    PROCEDURE BtnGarqiconeClick()
        LOCAL loc_oPag2, loc_cValorAtual, loc_oBusca
        loc_oPag2      = THIS.pgf_4c_Paginas.Page2
        loc_cValorAtual = ALLTRIM(loc_oPag2.txt_4c_Cargo.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCrg", "cursor_4c_Busca", "ccargs", loc_cValorAtual, ;
            "Busca de Cargos", .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
                    LOCAL loc_cCargoSel
                    loc_cCargoSel = ALLTRIM(cursor_4c_Busca.ccargs)
                    *-- Carregar o cargo selecionado
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargoSel)
                        THIS.BOParaForm()
                        THIS.CarregarRcc(loc_cCargoSel)
                        *-- Restaurar codigo no campo (BOParaForm ja faz isso)
                        loc_oPag2.txt_4c_Descr.SetFocus()
                    ENDIF
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("ccargs", "", "Cargo")
                    loc_oBusca.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                        LOCAL loc_cCargoSel2
                        loc_cCargoSel2 = ALLTRIM(cursor_4c_Busca.ccargs)
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargoSel2)
                            THIS.BOParaForm()
                            THIS.CarregarRcc(loc_cCargoSel2)
                            loc_oPag2.txt_4c_Descr.SetFocus()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *-- Tecla pressionada no campo Cargo (F4=keycode 28 no VFP)
    PROCEDURE txt_4c_Cargo_KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4 em VFP9
            THIS.AbrirLookupCargo()
        ENDIF
        IF INLIST(par_nKeyCode, 115, 116)  && F4=115, F5=116 (alternativos)
            THIS.AbrirLookupCargo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCargo - Abre FormBuscaAuxiliar para SigCdCrg
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupCargo()
        LOCAL loc_oPag2, loc_cValorAtual, loc_oBusca
        loc_oPag2       = THIS.pgf_4c_Paginas.Page2
        loc_cValorAtual = ALLTRIM(loc_oPag2.txt_4c_Cargo.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCrg", "cursor_4c_Busca", "ccargs", loc_cValorAtual, ;
            "Busca de Cargos", .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
                    loc_oPag2.txt_4c_Cargo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("ccargs", "", "Cargo")
                    loc_oBusca.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                        loc_oPag2.txt_4c_Cargo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DA GRADE SigCrRcc
    *==========================================================================

    PROCEDURE BtnAdicionarLinhaClick()
        SELECT cursor_4c_Rcc
        APPEND BLANK
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.ColumnCount = 4
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.RecordSource = "cursor_4c_Rcc"
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Rcc.Grupos"
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.Header1.Caption = "Grupo"
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Rcc.Contas"
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.Header1.Caption = "Conta"
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Rcc.Valors"
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column3.Header1.Caption = "Valor"
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Rcc.Moedas"
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column4.Header1.Caption = "Moeda"
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE BtnRemoverLinhaClick()
        SELECT cursor_4c_Rcc
        IF EOF() OR BOF()
            RETURN
        ENDIF
        DELETE
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * VALIDACOES LostFocus na GRADE
    *==========================================================================

    *-- LostFocus Coluna 1 (Grupo Financeiro): valida SigCdGcr
    PROCEDURE GradeCol1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nRet
        IF !USED("cursor_4c_Rcc")
            RETURN
        ENDIF
        SELECT cursor_4c_Rcc
        loc_cValor = ALLTRIM(NVL(Grupos, ""))
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        IF loc_cValor = THIS.this_cUltimoGradeCol1LostFocusValidado
            RETURN
        ENDIF
        THIS.this_cUltimoGradeCol1LostFocusValidado = loc_cValor

        *-- Verificar via fAcessoContab se disponivel, senao lookup direto
        IF TYPE("fAcessoContab") = "U"
            *-- Validar via SigCdGcr diretamente
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE CAST(codigos AS VARCHAR(30)) = " + EscaparSQL(loc_cValor)
            IF USED("cursor_4c_GrupoVal")
                USE IN cursor_4c_GrupoVal
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_GrupoVal") > 0
                REPLACE cursor_4c_Rcc.Grupos WITH ALLTRIM(cursor_4c_GrupoVal.codigos)
                IF USED("cursor_4c_GrupoVal")
                    USE IN cursor_4c_GrupoVal
                ENDIF
            ELSE
                IF USED("cursor_4c_GrupoVal")
                    USE IN cursor_4c_GrupoVal
                ENDIF
                *-- Abrir lookup
                LOCAL loc_oBusca
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrupo", "codigos", loc_cValor, ;
                    "Grupos Financeiros", .F.)
                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou
                        IF USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                            REPLACE cursor_4c_Rcc.Grupos WITH ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                            THIS.this_cUltimoGradeCol1LostFocusValidado = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
                            loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                                REPLACE cursor_4c_Rcc.Grupos WITH ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                                THIS.this_cUltimoGradeCol1LostFocusValidado = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
            ENDIF
        ELSE
            *-- fAcessoContab disponivel - chamar funcao legada
            fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, @cursor_4c_Rcc.Grupos, "")
        ENDIF

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        THIS.VerificarDuplicaGrade(1)
    ENDPROC

    *-- LostFocus Coluna 2 (Conta): valida via fAcessoContas ou lookup SigReCtb
    PROCEDURE GradeCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nRet
        IF !USED("cursor_4c_Rcc")
            RETURN
        ENDIF
        SELECT cursor_4c_Rcc
        loc_cValor = ALLTRIM(NVL(Contas, ""))
        loc_cGrupo = ALLTRIM(NVL(Grupos, ""))
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        IF loc_cValor = THIS.this_cUltimoGradeCol2LostFocusValidado
            RETURN
        ENDIF
        THIS.this_cUltimoGradeCol2LostFocusValidado = loc_cValor

        IF TYPE("fAcessoContas") = "U"
            *-- Sem fAcessoContas - validar via SigReCtb diretamente
            loc_cSQL = "SELECT contas, descs FROM SigReCtb WHERE CAST(contas AS VARCHAR(30)) = " + EscaparSQL(loc_cValor)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND GrpCon = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF USED("cursor_4c_ContaVal")
                USE IN cursor_4c_ContaVal
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ContaVal") > 0
                REPLACE cursor_4c_Rcc.Contas WITH ALLTRIM(cursor_4c_ContaVal.contas)
                IF USED("cursor_4c_ContaVal")
                    USE IN cursor_4c_ContaVal
                ENDIF
            ELSE
                IF USED("cursor_4c_ContaVal")
                    USE IN cursor_4c_ContaVal
                ENDIF
                LOCAL loc_oBuscaConta
                loc_oBuscaConta = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigReCtb", "cursor_4c_BuscaConta", "contas", loc_cValor, ;
                    "Contas Cont" + CHR(225) + "beis", .F.)
                IF VARTYPE(loc_oBuscaConta) = "O"
                    IF loc_oBuscaConta.this_lSelecionou
                        IF USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                            REPLACE cursor_4c_Rcc.Contas WITH ALLTRIM(cursor_4c_BuscaConta.contas)
                            THIS.this_cUltimoGradeCol2LostFocusValidado = ALLTRIM(cursor_4c_BuscaConta.contas)
                        ENDIF
                    ELSE
                        IF !loc_oBuscaConta.this_lAchouRegistro OR EMPTY(loc_cValor)
                            loc_oBuscaConta.mAddColuna("contas", "", "Conta")
                            loc_oBuscaConta.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBuscaConta.Show()
                            IF loc_oBuscaConta.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                                REPLACE cursor_4c_Rcc.Contas WITH ALLTRIM(cursor_4c_BuscaConta.contas)
                                THIS.this_cUltimoGradeCol2LostFocusValidado = ALLTRIM(cursor_4c_BuscaConta.contas)
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBuscaConta.Release()
                ENDIF
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
            ENDIF
        ELSE
            *-- fAcessoContas disponivel - chamar funcao legada
            fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, @cursor_4c_Rcc.Contas, "", gnConnHandle, DATE(), .NULL., "R")
        ENDIF

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        THIS.VerificarDuplicaGrade(2)
    ENDPROC

    *-- LostFocus Coluna 4 (Moeda): valida SigCdMoe
    PROCEDURE GradeCol4LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nRet
        IF !USED("cursor_4c_Rcc")
            RETURN
        ENDIF
        SELECT cursor_4c_Rcc
        loc_cValor = ALLTRIM(NVL(Moedas, ""))
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        IF loc_cValor = THIS.this_cUltimoGradeCol4LostFocusValidado
            RETURN
        ENDIF
        THIS.this_cUltimoGradeCol4LostFocusValidado = loc_cValor

        loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE CAST(cmoes AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
        IF USED("cursor_4c_MoedaVal")
            USE IN cursor_4c_MoedaVal
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaVal")
        IF loc_nRet > 0 AND RECCOUNT("cursor_4c_MoedaVal") > 0
            REPLACE cursor_4c_Rcc.Moedas WITH ALLTRIM(cursor_4c_MoedaVal.cmoes)
            THIS.this_cUltimoGradeCol4LostFocusValidado = ALLTRIM(cursor_4c_MoedaVal.cmoes)
            IF USED("cursor_4c_MoedaVal")
                USE IN cursor_4c_MoedaVal
            ENDIF
        ELSE
            IF USED("cursor_4c_MoedaVal")
                USE IN cursor_4c_MoedaVal
            ENDIF
            LOCAL loc_oBuscaMoeda
            loc_oBuscaMoeda = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
                "Moedas", .F.)
            IF VARTYPE(loc_oBuscaMoeda) = "O"
                IF loc_oBuscaMoeda.this_lSelecionou
                    IF USED("cursor_4c_BuscaMoeda") AND RECCOUNT("cursor_4c_BuscaMoeda") > 0
                        REPLACE cursor_4c_Rcc.Moedas WITH ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                        THIS.this_cUltimoGradeCol4LostFocusValidado = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    ENDIF
                ELSE
                    IF !loc_oBuscaMoeda.this_lAchouRegistro OR EMPTY(loc_cValor)
                        loc_oBuscaMoeda.mAddColuna("cmoes", "", "Moeda")
                        loc_oBuscaMoeda.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBuscaMoeda.Show()
                        IF loc_oBuscaMoeda.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                            REPLACE cursor_4c_Rcc.Moedas WITH ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                            THIS.this_cUltimoGradeCol4LostFocusValidado = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBuscaMoeda.Release()
            ENDIF
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
        ENDIF

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        THIS.VerificarDuplicaGrade(4)
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicaGrade - Verifica se ha linhas duplicadas (Grupo+Conta) no cursor_4c_Rcc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarDuplicaGrade(par_nColuna)
        LOCAL loc_nRet, loc_cSQL
        IF !USED("cursor_4c_Rcc")
            RETURN
        ENDIF
        TRY
            *-- Verificar duplicatas por Grupos+Contas usando cursor local
            IF USED("cursor_4c_DupGrade")
                USE IN cursor_4c_DupGrade
            ENDIF
            SELECT Grupos, Contas, COUNT(*) AS qtd ;
                FROM cursor_4c_Rcc ;
                WHERE !EMPTY(ALLTRIM(Grupos)) AND !EMPTY(ALLTRIM(Contas)) ;
                GROUP BY Grupos, Contas ;
                HAVING COUNT(*) > 1 ;
                INTO CURSOR cursor_4c_DupGrade

            IF RECCOUNT("cursor_4c_DupGrade") > 0
                MsgAviso("Existe combina" + CHR(231) + CHR(227) + "o de Grupo/Conta duplicada na grade.")
            ENDIF

            IF USED("cursor_4c_DupGrade")
                USE IN cursor_4c_DupGrade
            ENDIF
        CATCH TO loEx
            IF USED("cursor_4c_DupGrade")
                USE IN cursor_4c_DupGrade
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACOES (LostFocus) - campos fora da grade
    *==========================================================================

    *-- Validacao do campo Grupo Financeiro (get_Grupo) na linha principal
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cValor, loc_cSQL, loc_nRet
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2
        loc_cValor = UPPER(ALLTRIM(loc_oPag2.txt_4c__Grupo.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        IF loc_cValor == THIS.this_cUltimoValidarGrupoValidado
            RETURN
        ENDIF

        IF TYPE("fAcessoContab") = "U"
            *-- Sem fAcessoContab - validar diretamente
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE CAST(codigos AS VARCHAR(30)) = " + EscaparSQL(loc_cValor)
            IF USED("cursor_4c_GrupoMainVal")
                USE IN cursor_4c_GrupoMainVal
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoMainVal")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_GrupoMainVal") > 0
                loc_oPag2.txt_4c__Grupo.Value = ALLTRIM(cursor_4c_GrupoMainVal.codigos)
                THIS.this_cUltimoValidarGrupoValidado = ALLTRIM(cursor_4c_GrupoMainVal.codigos)
                IF USED("cursor_4c_GrupoMainVal")
                    USE IN cursor_4c_GrupoMainVal
                ENDIF
            ELSE
                IF USED("cursor_4c_GrupoMainVal")
                    USE IN cursor_4c_GrupoMainVal
                ENDIF
                *-- Abrir busca
                LOCAL loc_oBGrp
                loc_oBGrp = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrpMain", "codigos", loc_cValor, ;
                    "Grupos Financeiros", .F.)
                IF VARTYPE(loc_oBGrp) = "O"
                    IF loc_oBGrp.this_lSelecionou
                        IF USED("cursor_4c_BuscaGrpMain") AND RECCOUNT("cursor_4c_BuscaGrpMain") > 0
                            loc_oPag2.txt_4c__Grupo.Value = ALLTRIM(cursor_4c_BuscaGrpMain.codigos)
                            THIS.this_cUltimoValidarGrupoValidado = ALLTRIM(cursor_4c_BuscaGrpMain.codigos)
                        ENDIF
                    ELSE
                        IF !loc_oBGrp.this_lAchouRegistro OR EMPTY(loc_cValor)
                            loc_oBGrp.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                            loc_oBGrp.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBGrp.Show()
                            IF loc_oBGrp.this_lSelecionou AND USED("cursor_4c_BuscaGrpMain")
                                loc_oPag2.txt_4c__Grupo.Value = ALLTRIM(cursor_4c_BuscaGrpMain.codigos)
                                THIS.this_cUltimoValidarGrupoValidado = ALLTRIM(cursor_4c_BuscaGrpMain.codigos)
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBGrp.Release()
                ENDIF
                IF USED("cursor_4c_BuscaGrpMain")
                    USE IN cursor_4c_BuscaGrpMain
                ENDIF
            ENDIF
        ELSE
            *-- fAcessoContab disponivel
            LOCAL loc_cRetGrp
            loc_cRetGrp = fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, loc_oPag2.txt_4c__Grupo, "")
            IF !EMPTY(ALLTRIM(loc_cRetGrp))
                loc_oPag2.txt_4c__Grupo.Value = ALLTRIM(loc_cRetGrp)
                THIS.this_cUltimoValidarGrupoValidado = ALLTRIM(loc_cRetGrp)
            ENDIF
        ENDIF
    ENDPROC

    *-- Validacao do campo AComis (Get_AComis): valor nao pode ser negativo
    PROCEDURE ValidarAComis(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nVal
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_nVal    = loc_oPagina.txt_4c_AComis.Value
        IF loc_nVal < 0
            MsgAviso("Valor Inv" + CHR(225) + "lido.")
            loc_oPagina.txt_4c_AComis.Value = 0
            loc_oPagina.txt_4c_AComis.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Rcc")
            USE IN cursor_4c_Rcc
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
