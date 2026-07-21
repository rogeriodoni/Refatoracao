*==============================================================================
* Formacg.prg - Formulario de Cadastro de Acesso de Grupos (SIGCDACG)
* Tabela: sigcdgra (PK: Grupos, NComps)
* Relacionados: sigcdacg, sigcdacu, sigcdacb, sigactel
* Legado: SIGCDACG.SCX (frmcadastro)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS Formacg AS FormBase

    *-- Propriedades visuais
    Caption      = "Acesso de Grupos"
    Height       = 600
    Width        = 1000
    DataSession  = 1
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    this_cTituloForm       = "Acesso de Grupos"
    this_oBusinessObject   = .NULL.
    this_cFiltroPrograma   = ""

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("acgBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O" OR ISNULL(THIS.this_oBusinessObject)
                MsgErro("Erro ao criar acgBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.AjustarBotoesPorModo()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar: " + loc_oErro.Message + ;
                " [" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = 1000
            .Height    = 629
            .Tabs      = .F.
        ENDWITH
        THIS.pgf_4c_Paginas.Page1.Caption  = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.Caption  = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: grid de grupos + botoes CRUD
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oP1
        loc_oP1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (sombra + titulo)
        loc_oP1.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oP1.cnt_4c_Cabecalho
            .Top       = 31
            .Left      = 0
            .Width     = 1000
            .Height    = 85
            .BackStyle = 1
            .BackColor = RGB(215,215,215)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH
        loc_oP1.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oP1.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = ""
            .Top       = 0
            .Left      = 0
            .Width     = 1000
            .Height    = 85
            .AutoSize  = .F.
            .BackStyle = 1
            .BackColor = RGB(215,215,215)
        ENDWITH
        loc_oP1.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oP1.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Acesso de Grupos"
            .Top       = 30
            .Left      = 10
            .Width     = 500
            .Height    = 25
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        *-- Container botoes CRUD (Incluir, Alterar, Excluir, Buscar, Copiar)
        loc_oP1.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oP1.cnt_4c_Botoes
            .Top       = 29
            .Left      =  542
            .Width     = 465
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Left            = 85
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Left            = 165
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Left            = 245
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_CopiarAcesso", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_CopiarAcesso
            .Caption         = "Copiar" + CHR(13) + "Acessos"
            .Left            = 325
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "geral_copiar_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_CopiarAcesso, "Click", THIS, "BtnCopiarAcessoClick")

        *-- Painel de copia (oculto por padrao - ativado por BtnCopiarAcessoClick)
        loc_oP1.AddObject("cnt_4c_PainelCopia", "Container")
        WITH loc_oP1.cnt_4c_PainelCopia
            .Top       = 29
            .Left      = 480
            .Width     = 430
            .Height    = 85
            .BackStyle = 1
            .BackColor = RGB(235,235,255)
            .BorderWidth = 1
            .Visible   = .F.
        ENDWITH
        loc_oP1.cnt_4c_PainelCopia.AddObject("lbl_4c_CopiarDe", "Label")
        WITH loc_oP1.cnt_4c_PainelCopia.lbl_4c_CopiarDe
            .Caption   = "Copiar do Grupo:"
            .Top       = 10
            .Left      = 10
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH
        loc_oP1.cnt_4c_PainelCopia.AddObject("txt_4c_GrupoOrigem", "TextBox")
        WITH loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem
            .Top           = 30
            .Left          = 10
            .Width         = 120
            .Height        = 23
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BackColor     = RGB(255,255,255)
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem, "KeyPress", THIS, "TxtGrupoOrigemValid")
        loc_oP1.cnt_4c_PainelCopia.AddObject("cmd_4c_CopiarOk", "CommandButton")
        WITH loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarOk
            .Caption = "Copiar"
            .Left    = 145
            .Top     = 18
            .Width   = 75
            .Height  = 50
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes  = .T.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarOk, "Click", THIS, "BtnCopiarOkClick")
        loc_oP1.cnt_4c_PainelCopia.AddObject("cmd_4c_CopiarCancelar", "CommandButton")
        WITH loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarCancelar
            .Caption = "Cancelar"
            .Left    = 235
            .Top     = 18
            .Width   = 75
            .Height  = 50
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes  = .T.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarCancelar, "Click", THIS, "BtnCopiarCancelarClick")

        *-- Container Saida canonico (Left=917, Width=90)
        loc_oP1.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oP1.cnt_4c_Saida
            .Top       = 29
            .Left      = 917
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH
        loc_oP1.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oP1.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid principal
        loc_oP1.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oP1.grd_4c_Lista
            .Top             = 121
            .Left            = 12
            .Width           = 976
            .Height          = 455
            .ColumnCount     = 2
            .RecordSourceType = 1
            .ReadOnly        = .T.
            .DeleteMark      = .F.
            .RecordMark      = .F.
            .ScrollBars      = 3
            .GridLines       = 3
            .AllowHeaderSizing = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .GridLineColor   = RGB(238,238,238)
            .Visible         = .T.
            .Column1.Width   = 120
            .Column1.Header1.Caption = ""
            .Column2.Width   = 500
            .Column2.Header1.Caption = ""
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oP1)
        loc_oP1.cnt_4c_PainelCopia.Visible = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos + 4 abas internas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oP2
        loc_oP2 = THIS.pgf_4c_Paginas.Page2

        *-- Cabecalho cinza
        loc_oP2.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oP2.cnt_4c_Cabecalho
            .Top       = 29
            .Left      = 0
            .Width     = 1000
            .Height    = 85
            .BackStyle = 1
            .BackColor = RGB(215,215,215)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH
        loc_oP2.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = ""
            .Top       = 0
            .Left      = 0
            .Width     = 1000
            .Height    = 85
            .AutoSize  = .F.
            .BackStyle = 1
            .BackColor = RGB(215,215,215)
        ENDWITH
        loc_oP2.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Acesso de Grupos - Dados"
            .Top       = 30
            .Left      = 10
            .Width     = 500
            .Height    = 25
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        *-- Botoes Salvar/Cancelar (sobrepostos ao cabecalho, lado direito)
        loc_oP2.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oP2.cnt_4c_BotoesDados
            .Top       = 29
            .Left      = 830
            .Width     = 170
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH
        loc_oP2.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oP2.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP2.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
        loc_oP2.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oP2.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Left            = 85
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP2.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Campo Grupo
        loc_oP2.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oP2.lbl_4c_Grupo
            .Caption   = "Grupo:"
            .Top       = 126
            .Left      = 401
            .Width     = 50
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
            .Alignment = 1
        ENDWITH
        loc_oP2.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oP2.txt_4c_Grupo
            .Top           = 122
            .Left          = 456
            .Width         = 100
            .Height        = 23
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BackColor     = RGB(255,255,255)
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Campo NomeCompleto
        loc_oP2.AddObject("lbl_4c_NomeCompleto", "Label")
        WITH loc_oP2.lbl_4c_NomeCompleto
            .Caption   = "Nome:"
            .Top       = 152
            .Left      = 401
            .Width     = 45
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
            .Alignment = 1
        ENDWITH
        loc_oP2.AddObject("txt_4c_NomeCompleto", "TextBox")
        WITH loc_oP2.txt_4c_NomeCompleto
            .Top           = 148
            .Left          = 456
            .Width         = 280
            .Height        = 23
            .MaxLength     = 30
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BackColor     = RGB(255,255,255)
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Inner PageFrame com 4 abas (COM tabs visiveis)
        loc_oP2.AddObject("pgf_4c_Abas", "PageFrame")
        WITH loc_oP2.pgf_4c_Abas
            .Top       = 180
            .Left      = 0
            .Width     = 1000
            .Height    = 436
            .PageCount = 4
            .Tabs      = .T.
            .Visible   = .T.
        ENDWITH
        loc_oP2.pgf_4c_Abas.Page1.Caption = "Usu" + CHR(225) + "rios"
        loc_oP2.pgf_4c_Abas.Page2.Caption = "Programas"
        loc_oP2.pgf_4c_Abas.Page3.Caption = "Barra de Ferramentas"
        loc_oP2.pgf_4c_Abas.Page4.Caption = "Acesso a Telas"

        THIS.ConfigurarAbaUsuarios()
        THIS.ConfigurarAbaProgramas()
        THIS.ConfigurarAbaBarra()
        THIS.ConfigurarPgPage1()

        THIS.TornarControlesVisiveis(loc_oP2)
    ENDPROC

    *==========================================================================
    * ConfigurarAbaUsuarios - Page1 interna: listboxes de usuarios
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaUsuarios()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1

        loc_oAba.AddObject("lbl_4c_Disponiveis", "Label")
        WITH loc_oAba.lbl_4c_Disponiveis
            .Caption  = "Usu" + CHR(225) + "rios Dispon" + CHR(237) + "veis"
            .Top      = 8
            .Left     = 80
            .Width    = 200
            .Height   = 17
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        loc_oAba.AddObject("lbx_4c_Disponiveis", "ListBox")
        WITH loc_oAba.lbx_4c_Disponiveis
            .Top           = 28
            .Left          = 80
            .Width         = 200
            .Height        = 350
            .MultiSelect   = .T.
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oAba.lbx_4c_Disponiveis, "Click", THIS, "LbxDisponiveisClick")

        loc_oAba.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oAba.lbl_4c_Label3
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 426
            .Left      = 327
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_StatusDisp", "Label")
        WITH loc_oAba.lbl_4c_StatusDisp
            .Caption   = ""
            .Top       = 382
            .Left      = 143
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0,128,0)
        ENDWITH

        *-- Botoes de transferencia
        loc_oAba.AddObject("cmd_4c_AddUsu", "CommandButton")
        WITH loc_oAba.cmd_4c_AddUsu
            .Caption     = CHR(187)
            .Top         = 75
            .Left        = 295
            .Width       = 45
            .Height      = 30
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .T.
            .Visible     = .T.
            .ToolTipText = "Adicionar selecionados"
        ENDWITH
        BINDEVENT(loc_oAba.cmd_4c_AddUsu, "Click", THIS, "BtnAddUsuClick")

        loc_oAba.AddObject("cmd_4c_AddAllUsu", "CommandButton")
        WITH loc_oAba.cmd_4c_AddAllUsu
            .Caption     = CHR(187) + CHR(187)
            .Top         = 120
            .Left        = 295
            .Width       = 45
            .Height      = 30
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .T.
            .Visible     = .T.
            .ToolTipText = "Adicionar todos"
        ENDWITH
        BINDEVENT(loc_oAba.cmd_4c_AddAllUsu, "Click", THIS, "BtnAddAllUsuClick")

        loc_oAba.AddObject("cmd_4c_RemUsu", "CommandButton")
        WITH loc_oAba.cmd_4c_RemUsu
            .Caption     = CHR(171)
            .Top         = 170
            .Left        = 295
            .Width       = 45
            .Height      = 30
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .T.
            .Visible     = .T.
            .ToolTipText = "Remover selecionados"
        ENDWITH
        BINDEVENT(loc_oAba.cmd_4c_RemUsu, "Click", THIS, "BtnRemUsuClick")

        loc_oAba.AddObject("cmd_4c_RemAllUsu", "CommandButton")
        WITH loc_oAba.cmd_4c_RemAllUsu
            .Caption     = CHR(171) + CHR(171)
            .Top         = 215
            .Left        = 295
            .Width       = 45
            .Height      = 30
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .T.
            .Visible     = .T.
            .ToolTipText = "Remover todos"
        ENDWITH
        BINDEVENT(loc_oAba.cmd_4c_RemAllUsu, "Click", THIS, "BtnRemAllUsuClick")

        loc_oAba.AddObject("lbl_4c_Selecionados", "Label")
        WITH loc_oAba.lbl_4c_Selecionados
            .Caption  = "Usu" + CHR(225) + "rios do Grupo"
            .Top      = 8
            .Left     = 356
            .Width    = 200
            .Height   = 17
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        loc_oAba.AddObject("lbx_4c_Selecionados", "ListBox")
        WITH loc_oAba.lbx_4c_Selecionados
            .Top           = 28
            .Left          = 356
            .Width         = 200
            .Height        = 350
            .MultiSelect   = .T.
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oAba.lbx_4c_Selecionados, "Click", THIS, "LbxSelecionadosClick")

        loc_oAba.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oAba.lbl_4c_Label5
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 426
            .Left      = 529
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_StatusSel", "Label")
        WITH loc_oAba.lbl_4c_StatusSel
            .Caption   = ""
            .Top       = 382
            .Left      = 419
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0,128,0)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaProgramas - Page2 interna: grid de programas com checkbox
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaProgramas()
        LOCAL loc_oAba, loc_oGrid
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2

        loc_oAba.AddObject("lbl_4c_FiltroAcesso", "Label")
        WITH loc_oAba.lbl_4c_FiltroAcesso
            .Caption   = "Filtro:"
            .Top       = 10
            .Left      = 10
            .Width     = 45
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH
        loc_oAba.AddObject("txt_4c_FiltroAcesso", "TextBox")
        WITH loc_oAba.txt_4c_FiltroAcesso
            .Top           = 7
            .Left          = 60
            .Width         = 300
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BackColor     = RGB(255,255,255)
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_FiltroAcesso, "LostFocus", THIS, "TxtFiltroAcessoValid")

        loc_oAba.AddObject("grd_4c_Programas", "Grid")
        loc_oGrid = loc_oAba.grd_4c_Programas
        WITH loc_oGrid
            .Top              = 35
            .Left             = 5
            .Width            = 990
            .Height           = 400
            .ColumnCount      = 4
            .RecordSourceType = 1
            .ReadOnly         = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ScrollBars       = 3
            .GridLines        = 3
            .AllowHeaderSizing = .T.
            .FontName         = "Tahoma"
            .FontSize         = 8
            .GridLineColor    = RGB(238,238,238)
            .Visible          = .T.
            .Column1.Width    = 380
            .Column1.ReadOnly = .T.
            .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width    = 120
            .Column2.ReadOnly = .T.
            .Column2.Header1.Caption = "Programa"
            .Column3.Width    = 65
            .Column3.ReadOnly = .F.
            .Column3.Sparse   = .F.
            .Column3.Header1.Caption = ""
            .Column4.Width    = 120
            .Column4.ReadOnly = .T.
            .Column4.Header1.Caption = "Parametro"
        ENDWITH
        WITH loc_oGrid.Column3
            .AddObject("chk_4c_Marcas", "CheckBox")
        ENDWITH
        WITH loc_oGrid.Column3.chk_4c_Marcas
            .Caption   = ""
            .Width     = 60
            .Height    = 17
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oGrid.Column3.chk_4c_Marcas, "When", THIS, "ChkMarcasWhen")
    ENDPROC

    *==========================================================================
    * ConfigurarAbaBarra - Page3 interna: grid barra de ferramentas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaBarra()
        LOCAL loc_oAba, loc_oGrid
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3

        loc_oAba.AddObject("grd_4c_Barra", "Grid")
        loc_oGrid = loc_oAba.grd_4c_Barra
        WITH loc_oGrid
            .Top              = 10
            .Left             = 5
            .Width            = 990
            .Height           = 430
            .ColumnCount      = 2
            .RecordSourceType = 1
            .ReadOnly         = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ScrollBars       = 3
            .GridLines        = 3
            .AllowHeaderSizing = .T.
            .FontName         = "Tahoma"
            .FontSize         = 8
            .GridLineColor    = RGB(238,238,238)
            .Visible          = .T.
            .Column1.Width    = 550
            .Column1.ReadOnly = .T.
            .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width    = 80
            .Column2.ReadOnly = .F.
            .Column2.Sparse   = .F.
            .Column2.Header1.Caption = ""
        ENDWITH
        WITH loc_oGrid.Column2
            .AddObject("chk_4c_SelBarras", "CheckBox")
        ENDWITH
        WITH loc_oGrid.Column2.chk_4c_SelBarras
            .Caption   = ""
            .Width     = 75
            .Height    = 17
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oGrid.Column2.chk_4c_SelBarras, "When", THIS, "ChkSelBarrasWhen")
    ENDPROC

    *==========================================================================
    * ConfigurarPgPage1 - Page4 interna: grid "Acesso Tela" com ComboBox Status
    * Corresponde a SIGCDACG.Pagina.Dados.Pagina.Page1 (caption "Acesso Tela")
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage1()
        LOCAL loc_oAba, loc_oGrid
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4

        loc_oAba.AddObject("grd_4c_Telas", "Grid")
        loc_oGrid = loc_oAba.grd_4c_Telas
        WITH loc_oGrid
            .Top               = 26
            .Left              = 13
            .Width             = 969
            .Height            = 414
            .ColumnCount       = 3
            .RecordSourceType  = 1
            .ReadOnly          = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .GridLineColor     = RGB(238,238,238)
            .RowHeight         = 16
            .Visible           = .T.
            .Column1.Width     = 360
            .Column1.ReadOnly  = .T.
            .Column1.Header1.Caption = "Tela"
            .Column2.Width     = 360
            .Column2.ReadOnly  = .T.
            .Column2.Header1.Caption = "Campo"
            .Column3.Width     = 168
            .Column3.ReadOnly  = .F.
            .Column3.Sparse    = .F.
            .Column3.Header1.Caption = "Status"
        ENDWITH
        WITH loc_oGrid.Column3
            .AddObject("cbo_4c_CmbStatus", "ComboBox")
        ENDWITH
        WITH loc_oGrid.Column3.cbo_4c_CmbStatus
            .RowSourceType = 1
            .RowSource     = "Padr" + CHR(227) + "o," + ;
                             "Invis" + CHR(237) + "vel," + ;
                             "N" + CHR(227) + "o Edit" + CHR(225) + "vel," + ;
                             "Obrigat" + CHR(243) + "rio"
            .BoundTo       = .T.
            .Style         = 2
            .Width         = 160
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
        BINDEVENT(loc_oGrid.Column3.cbo_4c_CmbStatus, "When", THIS, "ChkStatusWhen")
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor_4c_Dados e vincula ao grd_4c_Lista
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject.Buscar("")
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (Grupos C(10), NComps C(30))
            ENDIF
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_oGrid.ColumnCount = 2
            loc_oGrid.RecordSource = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Grupos"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.NComps"
            loc_oGrid.Column1.Header1.Caption = ""
            loc_oGrid.Column2.Header1.Caption = ""
            loc_oGrid.Column1.Width = 120
            loc_oGrid.Column2.Width = 500
            loc_oGrid.FontName = "Tahoma"
            loc_oGrid.FontSize = 8
            loc_oGrid.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDadosGrupo - Carrega todas as 4 abas para o grupo
    *==========================================================================
    PROCEDURE CarregarDadosGrupo(par_cGrupos)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                THIS.CarregarUsuariosAbas(par_cGrupos)
                THIS.CarregarProgramasAba(par_cGrupos)
                THIS.CarregarBarraAba(par_cGrupos)
                THIS.CarregarTelasAba(par_cGrupos)
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar dados do grupo: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarUsuariosAbas - Preenche as duas listboxes de usuarios
    *==========================================================================
    PROCEDURE CarregarUsuariosAbas(par_cGrupos)
        LOCAL loc_oAba, loc_lNovoGrupo, loc_cUsu, loc_lNaGrupo
        TRY
            loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
            loc_oAba.lbx_4c_Disponiveis.Clear()
            loc_oAba.lbx_4c_Selecionados.Clear()
            loc_oAba.lbl_4c_StatusDisp.Caption = ""
            loc_oAba.lbl_4c_StatusSel.Caption  = ""

            loc_lNovoGrupo = EMPTY(ALLTRIM(par_cGrupos))

            *-- Carregar usuarios do grupo (se grupo existente)
            IF !loc_lNovoGrupo
                THIS.this_oBusinessObject.CarregarUsuariosDoGrupo(par_cGrupos)
            ENDIF

            *-- Carregar todos os usuarios do sistema
            IF THIS.this_oBusinessObject.BuscarTodosUsuarios() AND USED("cursor_4c_TodosUsuarios")
                SELECT cursor_4c_TodosUsuarios
                GO TOP
                SCAN
                    loc_cUsu = ALLTRIM(Usuarios)
                    loc_lNaGrupo = .F.
                    IF !loc_lNovoGrupo AND USED("cursor_4c_UsuariosGrupo")
                        SELECT cursor_4c_UsuariosGrupo
                        LOCATE FOR ALLTRIM(Usuarios) == m.loc_cUsu
                        IF !EOF()
                            loc_lNaGrupo = .T.
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_TodosUsuarios
                    IF loc_lNaGrupo
                        loc_oAba.lbx_4c_Selecionados.AddItem(loc_cUsu)
                    ELSE
                        loc_oAba.lbx_4c_Disponiveis.AddItem(loc_cUsu)
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar usu" + CHR(225) + "rios: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarProgramasAba - Vincula cursor_4c_Programas ao grd_4c_Programas
    *==========================================================================
    PROCEDURE CarregarProgramasAba(par_cGrupos)
        LOCAL loc_oGrid
        TRY
            IF THIS.this_oBusinessObject.CarregarProgramas(par_cGrupos)
                THIS.this_cFiltroPrograma = ""
                IF USED("cursor_4c_Programas")
                    SELECT cursor_4c_Programas
                    SET FILTER TO
                ENDIF
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas
                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Programas"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Programas.Descricaos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Programas.Programas"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Programas.Marcas"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Programas.Parametros"
                loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Header1.Caption = "Programa"
                loc_oGrid.Column3.Header1.Caption = ""
                loc_oGrid.Column4.Header1.Caption = "Parametro"
                loc_oGrid.Column1.Width = 380
                loc_oGrid.Column2.Width = 120
                loc_oGrid.Column3.Width = 65
                loc_oGrid.Column4.Width = 120
                loc_oGrid.FontName = "Tahoma"
                loc_oGrid.FontSize = 8
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar programas: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarBarraAba - Vincula TmpBarra ao grd_4c_Barra
    *==========================================================================
    PROCEDURE CarregarBarraAba(par_cGrupos)
        LOCAL loc_oGrid
        TRY
            IF THIS.this_oBusinessObject.CarregarBarra(par_cGrupos)
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "TmpBarra"
                loc_oGrid.Column1.ControlSource = "TmpBarra.Descricaos"
                loc_oGrid.Column2.ControlSource = "TmpBarra.SelBarras"
                loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Header1.Caption = ""
                loc_oGrid.Column1.Width = 550
                loc_oGrid.Column2.Width = 80
                loc_oGrid.FontName = "Tahoma"
                loc_oGrid.FontSize = 8
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar barra: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarTelasAba - Vincula crSigAcTel ao grd_4c_Telas
    *==========================================================================
    PROCEDURE CarregarTelasAba(par_cGrupos)
        LOCAL loc_oGrid
        TRY
            IF THIS.this_oBusinessObject.CarregarAcessoTelas(par_cGrupos)
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Telas
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "crSigAcTel"
                loc_oGrid.Column1.ControlSource = "crSigAcTel.cDescTelas"
                loc_oGrid.Column2.ControlSource = "crSigAcTel.cDescCamps"
                loc_oGrid.Column3.ControlSource = "crSigAcTel.nStatus"
                loc_oGrid.Column1.Header1.Caption = "Tela"
                loc_oGrid.Column2.Header1.Caption = "Campo"
                loc_oGrid.Column3.Header1.Caption = "Status"
                loc_oGrid.Column1.Width = 360
                loc_oGrid.Column2.Width = 360
                loc_oGrid.Column3.Width = 168
                loc_oGrid.Column3.cbo_4c_CmbStatus.RowSourceType = 1
                loc_oGrid.Column3.cbo_4c_CmbStatus.RowSource = "Padr" + CHR(227) + "o," + ;
                    "Invis" + CHR(237) + "vel," + ;
                    "N" + CHR(227) + "o Edit" + CHR(225) + "vel," + ;
                    "Obrigat" + CHR(243) + "rio"
                loc_oGrid.FontName = "Tahoma"
                loc_oGrid.FontSize = 8
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso a telas: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
            .this_cNComps = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.Value)
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_Grupo.Value        = THIS.this_oBusinessObject.this_cGrupos
            .txt_4c_NomeCompleto.Value = THIS.this_oBusinessObject.this_cNComps
        ENDWITH
    ENDPROC

    *==========================================================================
    * LimparCampos
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oP2, loc_oAbas
        loc_oP2   = THIS.pgf_4c_Paginas.Page2
        loc_oAbas = loc_oP2.pgf_4c_Abas
        loc_oP2.txt_4c_Grupo.Value        = ""
        loc_oP2.txt_4c_NomeCompleto.Value = ""
        loc_oAbas.Page1.lbx_4c_Disponiveis.Clear()
        loc_oAbas.Page1.lbx_4c_Selecionados.Clear()
        loc_oAbas.Page1.lbl_4c_StatusDisp.Caption = ""
        loc_oAbas.Page1.lbl_4c_StatusSel.Caption  = ""
        loc_oAbas.Page2.txt_4c_FiltroAcesso.Value = ""
        loc_oAbas.Page2.grd_4c_Programas.RecordSource = ""
        loc_oAbas.Page3.grd_4c_Barra.RecordSource = ""
        loc_oAbas.Page4.grd_4c_Telas.RecordSource = ""
        THIS.this_cFiltroPrograma = ""
    ENDPROC

    *==========================================================================
    * HabilitarCampos
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oP2
        loc_oP2 = THIS.pgf_4c_Paginas.Page2
        *-- Grupo: so editavel no INCLUIR
        loc_oP2.txt_4c_Grupo.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        loc_oP2.txt_4c_NomeCompleto.Enabled = par_lHabilitar
        THIS.HabilitarAbaUsuarios(par_lHabilitar)
        THIS.HabilitarColunasGrid(par_lHabilitar)
    ENDPROC

    *==========================================================================
    * HabilitarAbaUsuarios
    *==========================================================================
    PROTECTED PROCEDURE HabilitarAbaUsuarios(par_lHabilitar)
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_oAba.cmd_4c_AddUsu.Enabled    = par_lHabilitar
        loc_oAba.cmd_4c_AddAllUsu.Enabled = par_lHabilitar
        loc_oAba.cmd_4c_RemUsu.Enabled    = par_lHabilitar
        loc_oAba.cmd_4c_RemAllUsu.Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    * HabilitarColunasGrid - Habilita/desabilita colunas de checkbox nos grids
    *==========================================================================
    PROTECTED PROCEDURE HabilitarColunasGrid(par_lHabilitar)
        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Column3.ReadOnly = !par_lHabilitar
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra.Column2.ReadOnly     = !par_lHabilitar
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Telas.Column3.ReadOnly     = !par_lHabilitar
        CATCH TO loc_oErro
            MsgErro("Erro ao habilitar grids: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lNaLista, loc_oBotoes
        TRY
            loc_lNaLista = (THIS.this_cModoAtual = "LISTA")
            loc_oBotoes  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_oBotoes.cmd_4c_Incluir.Enabled      = .T.
            loc_oBotoes.cmd_4c_Alterar.Enabled      = loc_lNaLista
            loc_oBotoes.cmd_4c_Excluir.Enabled      = loc_lNaLista
            loc_oBotoes.cmd_4c_Buscar.Enabled       = loc_lNaLista
            loc_oBotoes.cmd_4c_CopiarAcesso.Enabled = loc_lNaLista
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AtivaCopia - Mostra/oculta painel de copia de acessos na Page1
    *==========================================================================
    PROCEDURE AtivaCopia(par_lAtivo)
        LOCAL loc_oP1
        loc_oP1 = THIS.pgf_4c_Paginas.Page1
        loc_oP1.cnt_4c_PainelCopia.Visible = par_lAtivo
        loc_oP1.cnt_4c_Botoes.Visible      = !par_lAtivo
        loc_oP1.grd_4c_Lista.Enabled       = !par_lAtivo
        IF par_lAtivo
            loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.Value = ""
            loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * SalvarDadosRelacionados - Salva usuarios, programas, barra e telas
    *==========================================================================
    PROCEDURE SalvarDadosRelacionados(par_cGrupos)
        LOCAL loc_lSucesso, loc_oAba1, loc_nI, loc_cUsu
        loc_lSucesso = .T.
        TRY
            loc_oAba1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1

            *-- Cursor temporario com usuarios selecionados
            IF USED("cursor_4c_UsrSalvar")
                USE IN cursor_4c_UsrSalvar
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_UsrSalvar (Usuarios C(10))
            SET NULL OFF
            FOR loc_nI = 1 TO loc_oAba1.lbx_4c_Selecionados.ListCount
                loc_cUsu = ALLTRIM(loc_oAba1.lbx_4c_Selecionados.List(loc_nI))
                IF !EMPTY(loc_cUsu)
                    INSERT INTO cursor_4c_UsrSalvar VALUES (m.loc_cUsu)
                ENDIF
            ENDFOR

            IF !THIS.this_oBusinessObject.SalvarUsuarios(par_cGrupos, "cursor_4c_UsrSalvar")
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_UsrSalvar")
                USE IN cursor_4c_UsrSalvar
            ENDIF

            *-- Salvar programas (limpar filtro antes)
            IF USED("cursor_4c_Programas")
                SELECT cursor_4c_Programas
                SET FILTER TO
                GO TOP
                IF !THIS.this_oBusinessObject.SalvarProgramas(par_cGrupos, "cursor_4c_Programas")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Salvar barra
            IF USED("TmpBarra")
                IF !THIS.this_oBusinessObject.SalvarBarra(par_cGrupos, "TmpBarra")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Salvar acesso a telas
            IF USED("crSigAcTel")
                IF !THIS.this_oBusinessObject.SalvarAcessoTelas(par_cGrupos, "crSigAcTel")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar dados relacionados: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterStatusUsuario - Retorna "Ativo" ou "Inativo" para um usuario
    *==========================================================================
    PROCEDURE ObterStatusUsuario(par_cUsuarios)
        LOCAL loc_cStatus, loc_nResult
        loc_cStatus = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cAtivos FROM sigcdusu WHERE Usuarios = " + EscaparSQL(ALLTRIM(par_cUsuarios)), ;
                "cursor_4c_TmpUsu")
            IF loc_nResult >= 0 AND USED("cursor_4c_TmpUsu") AND RECCOUNT("cursor_4c_TmpUsu") > 0
                SELECT cursor_4c_TmpUsu
                IF ALLTRIM(cAtivos) = "N"
                    loc_cStatus = "Inativo"
                ELSE
                    loc_cStatus = "Ativo"
                ENDIF
            ENDIF
            IF USED("cursor_4c_TmpUsu")
                USE IN cursor_4c_TmpUsu
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao obter status do usu" + CHR(225) + "rio: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cStatus
    ENDPROC

    *==========================================================================
    * --- HANDLERS DE BOTOES ---
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.CarregarDadosGrupo("")
        THIS.AlternarPagina(2)
        IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cGrupos
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupos = ALLTRIM(Grupos)
        IF EMPTY(loc_cGrupos)
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.CarregarDadosGrupo(loc_cGrupos)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cGrupos
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupos = ALLTRIM(Grupos)
        IF EMPTY(loc_cGrupos)
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.CarregarDadosGrupo(loc_cGrupos)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cGrupos
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupos = ALLTRIM(Grupos)
        IF EMPTY(loc_cGrupos)
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo " + loc_cGrupos + "?")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Grupo exclu" + CHR(237) + "do com sucesso.")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cGrupoSel
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdgra", ;
                "cursor_4c_Busca", "Grupos", "", "Buscar Grupo")
            loc_oBusca.mAddColuna("Grupos", "", "Grupo")
            loc_oBusca.mAddColuna("NComps", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                SELECT cursor_4c_Busca
                loc_cGrupoSel = ALLTRIM(Grupos)
                USE IN cursor_4c_Busca
                THIS.this_oBusinessObject.Buscar(loc_cGrupoSel)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 2
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.Grupos"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.NComps"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = ""
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = ""
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ELSE
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSalvarClick()
        LOCAL loc_cGrupos, loc_cNome
        loc_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
        loc_cNome   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.Value)

        IF EMPTY(loc_cGrupos)
            MsgAviso("C" + CHR(243) + "digo do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cNome)
            MsgAviso("Nome do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
            THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.SetFocus()
            RETURN
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarDuplicidade(loc_cGrupos)
                MsgAviso("Grupo " + loc_cGrupos + " j" + CHR(225) + " cadastrado.")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            IF !THIS.SalvarDadosRelacionados(loc_cGrupos)
                MsgAviso("Grupo salvo, mas houve erro ao salvar dados relacionados.")
            ELSE
                MsgInfo("Grupo salvo com sucesso.")
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnCopiarAcessoClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo destino para copiar acessos.")
            RETURN
        ENDIF
        THIS.AtivaCopia(.T.)
    ENDPROC

    *==========================================================================
    * TxtGrupoOrigemValid - Lookup do grupo de origem no painel de copia
    *==========================================================================
    PROCEDURE TxtGrupoOrigemValid(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        LOCAL loc_oTxt, loc_oBusca, loc_cValor
        TRY
            loc_oTxt = THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem
            loc_cValor = ALLTRIM(loc_oTxt.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdgra", ;
                "cursor_4c_BuscaOrigem", "Grupos", loc_cValor, "Selecionar Grupo Origem")
            loc_oBusca.mAddColuna("Grupos", "", "Grupo")
            loc_oBusca.mAddColuna("NComps", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigem")
                SELECT cursor_4c_BuscaOrigem
                loc_oTxt.Value = ALLTRIM(Grupos)
                USE IN cursor_4c_BuscaOrigem
            ELSE
                IF USED("cursor_4c_BuscaOrigem")
                    USE IN cursor_4c_BuscaOrigem
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo de origem: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCopiarOkClick - Executa copia de acessos entre grupos
    *==========================================================================
    PROCEDURE BtnCopiarOkClick()
        LOCAL loc_cGrupoOrigem, loc_cGrupoDestino
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo destino na lista.")
            RETURN
        ENDIF
        loc_cGrupoOrigem = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.Value)
        IF EMPTY(loc_cGrupoOrigem)
            MsgAviso("Informe o grupo de origem.")
            THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.SetFocus()
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupoDestino = ALLTRIM(Grupos)
        IF UPPER(loc_cGrupoOrigem) = UPPER(loc_cGrupoDestino)
            MsgAviso("Grupo de origem e destino s" + CHR(227) + "o iguais.")
            RETURN
        ENDIF
        IF MsgConfirma("Copiar acessos de [" + loc_cGrupoOrigem + "] para [" + loc_cGrupoDestino + "]?")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupoDestino)
                IF THIS.this_oBusinessObject.CopiarAcessos(loc_cGrupoOrigem)
                    MsgInfo("Acessos copiados com sucesso.")
                    THIS.AtivaCopia(.F.)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnCopiarCancelarClick()
        THIS.AtivaCopia(.F.)
    ENDPROC

    *==========================================================================
    * --- HANDLERS DE LISTBOX ---
    *==========================================================================

    PROCEDURE LbxDisponiveisClick()
        LOCAL loc_oAba, loc_cUsu, loc_cStatus
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        IF loc_oAba.lbx_4c_Disponiveis.ListIndex > 0
            loc_cUsu    = ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_oAba.lbx_4c_Disponiveis.ListIndex))
            loc_cStatus = THIS.ObterStatusUsuario(loc_cUsu)
            loc_oAba.lbl_4c_StatusDisp.Caption  = loc_cStatus
            loc_oAba.lbl_4c_StatusDisp.ForeColor = IIF(loc_cStatus = "Inativo", RGB(200,0,0), RGB(0,128,0))
        ENDIF
    ENDPROC

    PROCEDURE LbxSelecionadosClick()
        LOCAL loc_oAba, loc_cUsu, loc_cStatus
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        IF loc_oAba.lbx_4c_Selecionados.ListIndex > 0
            loc_cUsu    = ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_oAba.lbx_4c_Selecionados.ListIndex))
            loc_cStatus = THIS.ObterStatusUsuario(loc_cUsu)
            loc_oAba.lbl_4c_StatusSel.Caption  = loc_cStatus
            loc_oAba.lbl_4c_StatusSel.ForeColor = IIF(loc_cStatus = "Inativo", RGB(200,0,0), RGB(0,128,0))
        ENDIF
    ENDPROC

    *==========================================================================
    * --- HANDLERS DE TRANSFERENCIA DE USUARIOS ---
    *==========================================================================

    PROCEDURE BtnAddUsuClick()
        LOCAL loc_oAba, loc_nI, loc_cUsu
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        FOR loc_nI = loc_oAba.lbx_4c_Disponiveis.ListCount TO 1 STEP -1
            IF loc_oAba.lbx_4c_Disponiveis.Selected(loc_nI)
                loc_cUsu = ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_nI))
                loc_oAba.lbx_4c_Selecionados.AddItem(loc_cUsu)
                loc_oAba.lbx_4c_Disponiveis.RemoveItem(loc_nI)
            ENDIF
        ENDFOR
    ENDPROC

    PROCEDURE BtnAddAllUsuClick()
        LOCAL loc_oAba, loc_nI
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        FOR loc_nI = 1 TO loc_oAba.lbx_4c_Disponiveis.ListCount
            loc_oAba.lbx_4c_Selecionados.AddItem(ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_nI)))
        ENDFOR
        loc_oAba.lbx_4c_Disponiveis.Clear()
    ENDPROC

    PROCEDURE BtnRemUsuClick()
        LOCAL loc_oAba, loc_nI, loc_cUsu
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        FOR loc_nI = loc_oAba.lbx_4c_Selecionados.ListCount TO 1 STEP -1
            IF loc_oAba.lbx_4c_Selecionados.Selected(loc_nI)
                loc_cUsu = ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_nI))
                loc_oAba.lbx_4c_Disponiveis.AddItem(loc_cUsu)
                loc_oAba.lbx_4c_Selecionados.RemoveItem(loc_nI)
            ENDIF
        ENDFOR
    ENDPROC

    PROCEDURE BtnRemAllUsuClick()
        LOCAL loc_oAba, loc_nI
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        FOR loc_nI = 1 TO loc_oAba.lbx_4c_Selecionados.ListCount
            loc_oAba.lbx_4c_Disponiveis.AddItem(ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_nI)))
        ENDFOR
        loc_oAba.lbx_4c_Selecionados.Clear()
    ENDPROC

    *==========================================================================
    * TxtFiltroAcessoValid - Aplica filtro na grid de programas
    *==========================================================================
    PROCEDURE TxtFiltroAcessoValid()
        THIS.this_cFiltroPrograma = UPPER(ALLTRIM( ;
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.txt_4c_FiltroAcesso.Value))
        IF USED("cursor_4c_Programas")
            SELECT cursor_4c_Programas
            IF EMPTY(THIS.this_cFiltroPrograma)
                SET FILTER TO
            ELSE
                SET FILTER TO THISFORM.this_cFiltroPrograma $ UPPER(ALLTRIM(Descricaos))
            ENDIF
            GO TOP
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkMarcasWhen - Permite editar checkbox Marcas somente em INCLUIR/ALTERAR
    *==========================================================================
    PROCEDURE ChkMarcasWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * ChkSelBarrasWhen - Permite editar checkbox SelBarras somente em INCLUIR/ALTERAR
    *==========================================================================
    PROCEDURE ChkSelBarrasWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * ChkStatusWhen - Permite editar checkbox nStatus somente em INCLUIR/ALTERAR
    *==========================================================================
    PROCEDURE ChkStatusWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oCtrl, loc_cNome
        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oCtrl) = "O"
                loc_cNome = UPPER(loc_oCtrl.Name)
                IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_SAIDA", "CNT_4C_PAINELCOPIA")
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Programas")
            USE IN cursor_4c_Programas
        ENDIF
        IF USED("TmpBarra")
            USE IN TmpBarra
        ENDIF
        IF USED("crSigAcTel")
            USE IN crSigAcTel
        ENDIF
        IF USED("cursor_4c_TodosUsuarios")
            USE IN cursor_4c_TodosUsuarios
        ENDIF
        IF USED("cursor_4c_UsuariosGrupo")
            USE IN cursor_4c_UsuariosGrupo
        ENDIF
        IF USED("cursor_4c_UsrSalvar")
            USE IN cursor_4c_UsrSalvar
        ENDIF
        IF USED("cursor_4c_BuscaOrigem")
            USE IN cursor_4c_BuscaOrigem
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
        IF USED("cursor_4c_TmpUsu")
            USE IN cursor_4c_TmpUsu
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
