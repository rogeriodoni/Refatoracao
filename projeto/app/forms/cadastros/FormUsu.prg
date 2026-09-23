*==============================================================================
* FormUsu.prg
* Formulario de Cadastro de Usuarios (SIGCDUSU)
*
* Tabela principal: SigCdUsu (usuarios PK)
* Tipo: CRUD (frmcadastro)
* BO: UsuBO
*==============================================================================

DEFINE CLASS FormUsu AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Usu" + CHR(225) + "rios"
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

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria Business Object e configura estrutura do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("UsuBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar UsuBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho + container de botoes CRUD
    * (Grid e botoes propriamente ditos entram na Fase 4)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Faixa do cabecalho (PRIMEIRO AddObject da pagina - regra #11)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container dos botoes CRUD (lado direito, canonico)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPg1.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5, ;
            "Incluir", "cadastro_inserir_26.jpg")
        THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 80, ;
            "Visualizar", "cadastro_vizualizar_60.jpg")
        THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 155, ;
            "Alterar", "cadastro_alterar_60.jpg")
        THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 230, ;
            "Excluir", "cadastro_excluir_60.jpg")
        THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 305, ;
            "Buscar", "cadastro_procurar_60.jpg")

        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (canonico - PREVALECE sobre PILAR 1, regra #10)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPg1.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg1.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
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
        BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botao "Limpa Senha" (cmdGLimSenha no legado) - standalone, area do Grid
        loc_oPg1.AddObject("cmd_4c_LimparSenha", "CommandButton")
        WITH loc_oPg1.cmd_4c_LimparSenha
            .Top             = 33
            .Left            = 472
            .Width           = 75
            .Height          = 75
            .Caption         = "Limpa Senha"
            .ToolTipText     = "Limpar Senha"
            .Picture         = gc_4c_CaminhoIcones + "geral_cores_60.jpg"
            .PicturePosition = 13
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
        BINDEVENT(loc_oPg1.cmd_4c_LimparSenha, "Click", THIS, "BtnLimparSenhaClick")

        *-- Grid de listagem (Grade no legado)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPg1.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .ColumnCount        = 5
            .FontName           = "Tahoma"
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarBotaoCrud - Cria botao padrao da barra CRUD (canonico, regra #10)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarBotaoCrud(par_oContainer, par_cNome, par_nLeft, par_cCaption, par_cIcone)
        LOCAL loc_oBtn
        par_oContainer.AddObject(par_cNome, "CommandButton")
        loc_oBtn = EVALUATE("par_oContainer." + par_cNome)
        WITH loc_oBtn
            .Top             = 5
            .Left            = par_nLeft
            .Width           = 75
            .Height          = 75
            .Caption         = par_cCaption
            .Picture         = gc_4c_CaminhoIcones + par_cIcone
            .PicturePosition = 13
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
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: faixa de cabecalho + botoes de acao +
    * campos principais. Faixa nas DUAS paginas (regra #11 CLAUDE.md); campos
    * da Parte 2 (Departamento/Setor/Contas/Obriga Senha) entram na Fase 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oCab
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Faixa do cabecalho (PRIMEIRO AddObject da pagina - regra #11)
        loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg2.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container dos botoes de acao (Confirmar/Cancelar) - criado DEPOIS
        *-- da faixa para desenhar por cima (regra #11); botoes populados
        *-- em fase posterior
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPg2.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.CriarBotaoCrud(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5, ;
            "Confirmar", "cadastro_salvar_60.jpg")
        THIS.CriarBotaoCrud(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 80, ;
            "Cancelar", "cadastro_cancelar_60.jpg")

        BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *======================================================================
        * CAMPOS PRINCIPAIS - PARTE 1 (Fase 5/8)
        * Tops compensados +29 (PageFrame.Top=-29). Todos >= 190, portanto
        * sem conflito com a faixa do cabecalho (29..109, regra #11).
        *======================================================================

        *-- Usuario: Label1.Top=165+29=194, getUsuarios.Top=161+29=190
        loc_oPg2.AddObject("lbl_4c_Usuario", "Label")
        WITH loc_oPg2.lbl_4c_Usuario
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 194
            .Left      = 329
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Usuarios", "TextBox")
        WITH loc_oPg2.txt_4c_Usuarios
            .Value         = ""
            .Top           = 190
            .Left          = 376
            .Width         = 81
            .Height        = 24
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Ativo: Say5.Top=166+29=195, optativo.Top=165+29=194 (OptionGroup)
        loc_oPg2.AddObject("lbl_4c_Ativo", "Label")
        WITH loc_oPg2.lbl_4c_Ativo
            .Caption   = "Ativo :"
            .Top       = 195
            .Left      = 472
            .Width     = 38
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("obj_4c_Ativo", "OptionGroup")
        WITH loc_oPg2.obj_4c_Ativo
            .ButtonCount = 2
            .Top         = 194
            .Left        = 510
            .Width       = 103
            .Height      = 17
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.obj_4c_Ativo.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 1
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .Style     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPg2.obj_4c_Ativo.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 56
            .Top       = 1
            .Width     = 37
            .Height    = 15
            .AutoSize  = .T.
            .Style     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Nome: Label2.Top=191+29=220, getNComps.Top=187+29=216
        loc_oPg2.AddObject("lbl_4c_Nome", "Label")
        WITH loc_oPg2.lbl_4c_Nome
            .Caption   = "Nome :"
            .Top       = 220
            .Left      = 338
            .Width     = 36
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_NComps", "TextBox")
        WITH loc_oPg2.txt_4c_NComps
            .Value         = ""
            .Top           = 216
            .Left          = 376
            .Width         = 220
            .Height        = 24
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Cargo: Say6.Top=216+29=245, getCCargs.Top=213+29=242
        loc_oPg2.AddObject("lbl_4c_Cargo", "Label")
        WITH loc_oPg2.lbl_4c_Cargo
            .Caption   = "Cargo :"
            .Top       = 245
            .Left      = 336
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_CCargs", "TextBox")
        WITH loc_oPg2.txt_4c_CCargs
            .Value         = ""
            .Top           = 242
            .Left          = 376
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * CAMPOS PRINCIPAIS - PARTE 2 (Fase 6/8)
        * Tops compensados +29 (PageFrame.Top=-29).
        *======================================================================

        *-- Setor: Say2.Top=266+29=295, getSetores.Top=263+29=292
        loc_oPg2.AddObject("lbl_4c_Setores", "Label")
        WITH loc_oPg2.lbl_4c_Setores
            .Caption   = "Setor :"
            .Top       = 295
            .Left      = 339
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Setores", "TextBox")
        WITH loc_oPg2.txt_4c_Setores
            .Value         = ""
            .Top           = 292
            .Left          = 376
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Departamento: Say1.Top=241+29=270, getDeptos.Top=238+29=267,
        *-- getNDeptos.Top=238+29=267 (nome do depto - nao persiste, campo
        *-- espelho preenchido pelo lookup)
        loc_oPg2.AddObject("lbl_4c_Deptos", "Label")
        WITH loc_oPg2.lbl_4c_Deptos
            .Caption   = "Departamento :"
            .Top       = 270
            .Left      = 296
            .Width     = 78
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Deptos", "TextBox")
        WITH loc_oPg2.txt_4c_Deptos
            .Value         = ""
            .Top           = 267
            .Left          = 376
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_NDeptos", "TextBox")
        WITH loc_oPg2.txt_4c_NDeptos
            .Value         = ""
            .Top           = 267
            .Left          = 459
            .Width         = 290
            .Height        = 23
            .MaxLength     = 40
            .Format        = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Cadastro de Contas: Say3.Top=291+29=320, getIClis.Top=288+29=317,
        *-- getRClis.Top=288+29=317 (razao social - nao persiste, campo
        *-- espelho preenchido pelo lookup)
        loc_oPg2.AddObject("lbl_4c_IClis", "Label")
        WITH loc_oPg2.lbl_4c_IClis
            .Caption   = "Cadastro de Contas :"
            .Top       = 320
            .Left      = 269
            .Width     = 105
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_IClis", "TextBox")
        WITH loc_oPg2.txt_4c_IClis
            .Value         = ""
            .Top           = 317
            .Left          = 376
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_RClis", "TextBox")
        WITH loc_oPg2.txt_4c_RClis
            .Value         = ""
            .Top           = 317
            .Left          = 459
            .Width         = 290
            .Height        = 23
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Obriga Cadastrar Senha: Say4.Top=318+29=347, Optiongroup1.Top=317+29=346
        *-- Option1Value=0 / Option2Value=1 - transcrito do SCX
        *-- (nao eh indice 1-based, o legado sobrescreve o valor de cada botao)
        loc_oPg2.AddObject("lbl_4c_ObrigaSenha", "Label")
        WITH loc_oPg2.lbl_4c_ObrigaSenha
            .Caption   = "Obriga Cadastrar Senha :"
            .Top       = 347
            .Left      = 249
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("obj_4c_ObrigaSenha", "OptionGroup")
        WITH loc_oPg2.obj_4c_ObrigaSenha
            .ButtonCount = 2
            .Top         = 346
            .Left        = 371
            .Width       = 103
            .Height      = 17
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.obj_4c_ObrigaSenha.Buttons(1)
            .Caption   = "Sim"
            .Value     = 0
            .Left      = 5
            .Top       = 1
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .Style     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPg2.obj_4c_ObrigaSenha.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Value     = 1
            .Left      = 56
            .Top       = 1
            .Width     = 37
            .Height    = 15
            .AutoSize  = .T.
            .Style     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *======================================================================
        * LOOKUPS (F4 / DblClick) - regra: campos com lookup no legado
        * (fwBuscaExt) devem ter lookup completo no novo sistema
        *======================================================================
        BINDEVENT(loc_oPg2.txt_4c_CCargs, "KeyPress", THIS, "TeclaLookupCargo")
        BINDEVENT(loc_oPg2.txt_4c_CCargs, "DblClick", THIS, "AbrirLookupCargo")

        BINDEVENT(loc_oPg2.txt_4c_Setores, "KeyPress", THIS, "TeclaLookupSetor")
        BINDEVENT(loc_oPg2.txt_4c_Setores, "DblClick", THIS, "AbrirLookupSetor")

        BINDEVENT(loc_oPg2.txt_4c_Deptos, "KeyPress", THIS, "TeclaLookupDeptoPorCodigo")
        BINDEVENT(loc_oPg2.txt_4c_Deptos, "DblClick", THIS, "AbrirLookupDeptoPorCodigo")

        BINDEVENT(loc_oPg2.txt_4c_NDeptos, "KeyPress", THIS, "TeclaLookupDeptoPorDescricao")
        BINDEVENT(loc_oPg2.txt_4c_NDeptos, "DblClick", THIS, "AbrirLookupDeptoPorDescricao")

        BINDEVENT(loc_oPg2.txt_4c_IClis, "KeyPress", THIS, "TeclaLookupClientePorCodigo")
        BINDEVENT(loc_oPg2.txt_4c_IClis, "DblClick", THIS, "AbrirLookupClientePorCodigo")

        BINDEVENT(loc_oPg2.txt_4c_RClis, "KeyPress", THIS, "TeclaLookupClientePorNome")
        BINDEVENT(loc_oPg2.txt_4c_RClis, "DblClick", THIS, "AbrirLookupClientePorNome")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaLookupCargo / AbrirLookupCargo - Lookup de Cargo (SigCdCrg)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaLookupCargo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCargo()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupCargo()
        LOCAL loc_cValorAtual, loc_oBusca
        loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CCargs.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCrg", "cursor_4c_BuscaCargo", "CCargs", loc_cValorAtual, ;
            "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaCargo")
                    THIS.pgf_4c_Paginas.Page2.txt_4c_CCargs.Value = ALLTRIM(cursor_4c_BuscaCargo.CCargs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CCargs", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DCargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCargo")
                        THIS.pgf_4c_Paginas.Page2.txt_4c_CCargs.Value = ALLTRIM(cursor_4c_BuscaCargo.CCargs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaCargo")
            USE IN cursor_4c_BuscaCargo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaLookupSetor / AbrirLookupSetor - Lookup de Setor (SigCdSet)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaLookupSetor(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSetor()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupSetor()
        LOCAL loc_cValorAtual, loc_oBusca
        loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Setores.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdSet", "cursor_4c_BuscaSetor", "Setores", loc_cValorAtual, ;
            "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaSetor")
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Setores.Value = ALLTRIM(cursor_4c_BuscaSetor.Setores)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Setores", "", "Setor")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSetor")
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Setores.Value = ALLTRIM(cursor_4c_BuscaSetor.Setores)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaSetor")
            USE IN cursor_4c_BuscaSetor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaLookupDeptoPorCodigo/PorDescricao + AbrirLookupDeptoPorCodigo/
    * PorDescricao - Lookup bidirecional de Departamento (SigCdDpt), igual ao
    * legado: buscar por codigo OU por descricao preenche AMBOS os campos.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaLookupDeptoPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDeptoPorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaLookupDeptoPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDeptoPorDescricao()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupDeptoPorCodigo()
        THIS.AbrirLookupDepto("codigos", ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Deptos.Value))
    ENDPROC

    PROCEDURE AbrirLookupDeptoPorDescricao()
        THIS.AbrirLookupDepto("Descricaos", ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_NDeptos.Value))
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupDepto(par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oBusca

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdDpt", "cursor_4c_BuscaDepto", par_cCampoBusca, par_cValorBusca, ;
            "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaDepto")
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Deptos.Value  = ALLTRIM(cursor_4c_BuscaDepto.codigos)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_NDeptos.Value = ALLTRIM(cursor_4c_BuscaDepto.Descricaos)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDepto")
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Deptos.Value  = ALLTRIM(cursor_4c_BuscaDepto.codigos)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_NDeptos.Value = ALLTRIM(cursor_4c_BuscaDepto.Descricaos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaDepto")
            USE IN cursor_4c_BuscaDepto
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaLookupClientePorCodigo/PorNome + AbrirLookupClientePorCodigo/PorNome
    * - Lookup bidirecional de Cliente/Fornecedor (SigCdCli), igual ao legado:
    * buscar por codigo OU por nome preenche AMBOS os campos.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaLookupClientePorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupClientePorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaLookupClientePorNome(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupClientePorNome()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupClientePorCodigo()
        THIS.AbrirLookupCliente("IClis", ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_IClis.Value))
    ENDPROC

    PROCEDURE AbrirLookupClientePorNome()
        THIS.AbrirLookupCliente("RClis", ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_RClis.Value))
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupCliente(par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oBusca

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaCliente", par_cCampoBusca, par_cValorBusca, ;
            "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaCliente")
                    THIS.pgf_4c_Paginas.Page2.txt_4c_IClis.Value = ALLTRIM(cursor_4c_BuscaCliente.IClis)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_RClis.Value = ALLTRIM(cursor_4c_BuscaCliente.RClis)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCliente")
                        THIS.pgf_4c_Paginas.Page2.txt_4c_IClis.Value = ALLTRIM(cursor_4c_BuscaCliente.IClis)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_RClis.Value = ALLTRIM(cursor_4c_BuscaCliente.RClis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaCliente")
            USE IN cursor_4c_BuscaCliente
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis recursivamente os controles
    * do container informado (Pages de PageFrames aninhados inclusive)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

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
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega TODOS os usuarios no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarListaFiltrada("")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarListaFiltrada - Busca usuarios (filtro exato por codigo, igual ao
    * legado msv_procurar) e (re)configura RecordSource/ControlSource/Headers
    * do grid (regra: SEMPRE reconfigurar headers apos RecordSource)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarListaFiltrada(par_cFiltro)
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar(par_cFiltro)
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.RecordSource = ""
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.usuarios"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ncomps"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.ccargs"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.deptos"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.setores"

                    loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
                    loc_oGrid.Column2.Header1.Caption = "Nome"
                    loc_oGrid.Column3.Header1.Caption = "Cargo"
                    loc_oGrid.Column4.Header1.Caption = "Depto."
                    loc_oGrid.Column5.Header1.Caption = "Setor"

                    loc_oGrid.Column1.Width = 80
                    loc_oGrid.Column2.Width = 310
                    loc_oGrid.Column3.Width = 80
                    loc_oGrid.Column4.Width = 80
                    loc_oGrid.Column5.Width = 80

                    IF USED("cursor_4c_Dados")
                        GO TOP IN cursor_4c_Dados
                    ENDIF

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.CarregarListaFiltrada")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    * DynamicForeColor reproduz o legado: SetAll('DynamicForeColor',
    * Iif(cAtivos=='N', Rgb(255,0,0), Rgb(0,0,255)), 'Column') no Init do SCX
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
            .SetAll("DynamicForeColor", ;
                "IIF(cursor_4c_Dados.cativos = 'N', RGB(255,0,0), RGB(0,0,255))", "Column")
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND INLIST(par_nPagina, 1, 2)
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do Form para o BO (chamado
    * antes de Salvar). NDeptos/RClis sao campos espelho (nao persistem).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        loc_oBO.this_cUsuarios    = ALLTRIM(loc_oPg2.txt_4c_Usuarios.Value)
        loc_oBO.this_cNComps      = ALLTRIM(loc_oPg2.txt_4c_NComps.Value)
        loc_oBO.this_cCCargs      = ALLTRIM(loc_oPg2.txt_4c_CCargs.Value)
        loc_oBO.this_cSetores     = ALLTRIM(loc_oPg2.txt_4c_Setores.Value)
        loc_oBO.this_cDeptos      = ALLTRIM(loc_oPg2.txt_4c_Deptos.Value)
        loc_oBO.this_cIClis       = ALLTRIM(loc_oPg2.txt_4c_IClis.Value)
        loc_oBO.this_cCAtivos     = IIF(loc_oPg2.obj_4c_Ativo.Value = 1, "S", "N")
        loc_oBO.this_nObrigSenhas = loc_oPg2.obj_4c_ObrigaSenha.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos do Form (chamado
    * apos CarregarPorCodigo, em Visualizar/Alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        loc_oPg2.txt_4c_Usuarios.Value = loc_oBO.this_cUsuarios
        loc_oPg2.txt_4c_NComps.Value   = loc_oBO.this_cNComps
        loc_oPg2.txt_4c_CCargs.Value   = loc_oBO.this_cCCargs
        loc_oPg2.txt_4c_Setores.Value  = loc_oBO.this_cSetores
        loc_oPg2.txt_4c_Deptos.Value   = loc_oBO.this_cDeptos
        loc_oPg2.txt_4c_IClis.Value    = loc_oBO.this_cIClis
        loc_oPg2.obj_4c_Ativo.Value       = IIF(UPPER(ALLTRIM(loc_oBO.this_cCAtivos)) == "N", 2, 1)
        loc_oPg2.obj_4c_ObrigaSenha.Value = loc_oBO.this_nObrigSenhas

        THIS.AtualizarCamposEspelho()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCamposEspelho - Resolve descricao/razao social dos campos
    * espelho (NDeptos/RClis) a partir do codigo carregado (Deptos/IClis).
    * Esses campos nao persistem no BO - sao apenas exibicao (preenchidos
    * pelo lookup no INCLUIR/ALTERAR, e reconstituidos aqui no VISUALIZAR).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCamposEspelho()
        LOCAL loc_oPg2, loc_cSQL, loc_nResultado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_NDeptos.Value = ""
        IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Deptos.Value))
            loc_cSQL = "SELECT Descricaos FROM SigCdDpt WHERE RTRIM(codigos) = " + ;
                EscaparSQL(ALLTRIM(loc_oPg2.txt_4c_Deptos.Value))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspelhoDpt")
            IF loc_nResultado >= 0 AND USED("cursor_4c_EspelhoDpt") AND RECCOUNT("cursor_4c_EspelhoDpt") > 0
                loc_oPg2.txt_4c_NDeptos.Value = ALLTRIM(cursor_4c_EspelhoDpt.Descricaos)
            ENDIF
            IF USED("cursor_4c_EspelhoDpt")
                USE IN cursor_4c_EspelhoDpt
            ENDIF
        ENDIF

        loc_oPg2.txt_4c_RClis.Value = ""
        IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_IClis.Value))
            loc_cSQL = "SELECT RClis FROM SigCdCli WHERE RTRIM(IClis) = " + ;
                EscaparSQL(ALLTRIM(loc_oPg2.txt_4c_IClis.Value))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspelhoCli")
            IF loc_nResultado >= 0 AND USED("cursor_4c_EspelhoCli") AND RECCOUNT("cursor_4c_EspelhoCli") > 0
                loc_oPg2.txt_4c_RClis.Value = ALLTRIM(cursor_4c_EspelhoCli.RClis)
            ENDIF
            IF USED("cursor_4c_EspelhoCli")
                USE IN cursor_4c_EspelhoCli
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2 (usado no INCLUIR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Usuarios.Value = ""
        loc_oPg2.txt_4c_NComps.Value   = ""
        loc_oPg2.txt_4c_CCargs.Value   = ""
        loc_oPg2.txt_4c_Setores.Value  = ""
        loc_oPg2.txt_4c_Deptos.Value   = ""
        loc_oPg2.txt_4c_NDeptos.Value  = ""
        loc_oPg2.txt_4c_IClis.Value    = ""
        loc_oPg2.txt_4c_RClis.Value    = ""
        loc_oPg2.obj_4c_Ativo.Value       = 1
        loc_oPg2.obj_4c_ObrigaSenha.Value = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos editaveis da Page2.
    * txt_4c_Usuarios (PK) so fica editavel em modo INCLUIR (When do legado:
    * getUsuarios so habilitado em INSERIR/PROCURAR). NDeptos/RClis (campos
    * espelho) so ficam editaveis quando o campo codigo correspondente esta
    * vazio, igual ao When do legado (getNDeptos/getRClis).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Usuarios.Enabled = par_lHabilitar AND THIS.this_cModoAtual == "INCLUIR"
        loc_oPg2.txt_4c_NComps.Enabled   = par_lHabilitar
        loc_oPg2.txt_4c_CCargs.Enabled   = par_lHabilitar
        loc_oPg2.txt_4c_Setores.Enabled  = par_lHabilitar
        loc_oPg2.txt_4c_Deptos.Enabled   = par_lHabilitar
        loc_oPg2.txt_4c_NDeptos.Enabled  = par_lHabilitar AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Deptos.Value))
        loc_oPg2.txt_4c_IClis.Enabled    = par_lHabilitar
        loc_oPg2.txt_4c_RClis.Enabled    = par_lHabilitar AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_IClis.Value))
        loc_oPg2.obj_4c_Ativo.Enabled       = par_lHabilitar
        loc_oPg2.obj_4c_ObrigaSenha.Enabled = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Confirmar fica desabilitado em VISUALIZAR
    * (somente leitura); Cancelar sempre habilitado para voltar a lista.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO/Form para INCLUIR e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"

            IF PEMSTATUS(THIS, "LimparCampos", 5)
                THIS.LimparCampos()
            ENDIF
            IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                THIS.HabilitarCampos(.T.)
            ENDIF
            IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
                THIS.AjustarBotoesPorModo()
            ENDIF

            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado no grid (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um usu" + CHR(225) + "rio na lista!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.usuarios)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"

                    IF PEMSTATUS(THIS, "BOParaForm", 5)
                        THIS.BOParaForm()
                    ENDIF
                    IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                        THIS.HabilitarCampos(.F.)
                    ENDIF
                    IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
                        THIS.AjustarBotoesPorModo()
                    ENDIF

                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado no grid para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um usu" + CHR(225) + "rio na lista!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.usuarios)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"

                    IF PEMSTATUS(THIS, "BOParaForm", 5)
                        THIS.BOParaForm()
                    ENDIF
                    IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                        THIS.HabilitarCampos(.T.)
                    ENDIF
                    IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
                        THIS.AjustarBotoesPorModo()
                    ENDIF

                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Grava o registro (INSERIR ou ALTERAR) via BO. O BO
    * (BusinessBase.Salvar) ja reporta qualquer falha de validacao/gravacao -
    * o form so precisa exibir a mensagem quando ela NAO foi exibida ainda.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        TRY
            IF PEMSTATUS(THIS, "FormParaBO", 5)
                THIS.FormParaBO()
            ENDIF

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Confirmar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Descarta a edicao e volta para a lista (recarregada)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui o usuario selecionado no grid, com confirmacao
    * (checagens de dependencia SigCdAcG/SigCdAcU/SigCdAcB do legado sao
    * responsabilidade do BO/relacoes de acesso - nao existem no acervo migrado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um usu" + CHR(225) + "rio na lista!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.usuarios)

                IF MsgConfirma("Deseja realmente excluir o usu" + CHR(225) + "rio " + loc_cCodigo + "?", "Confirma")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
                            THIS.CarregarLista()
                        ELSE
                            IF !THIS.this_oBusinessObject.this_lErroExibido
                                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca usuario por codigo exato (equivalente ao
    * msv_procurar do legado: Locate For Usuarios = valor digitado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro
        TRY
            loc_cFiltro = ALLTRIM(INPUTBOX("Informe o c" + CHR(243) + "digo do usu" + CHR(225) + "rio (em branco lista todos):", "Buscar", ""))

            IF LASTKEY() != 27
                THIS.CarregarListaFiltrada(loc_cFiltro)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnLimparSenhaClick - Limpa a senha do usuario selecionado (cmdLimSenha
    * do legado). Bloqueado para o usuario 4CONTROL, igual ao original.
    *--------------------------------------------------------------------------
    PROCEDURE BtnLimparSenhaClick()
        LOCAL loc_cCodigo, loc_cNome, loc_cSQL, loc_nResultado
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um usu" + CHR(225) + "rio na lista!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.usuarios)
                loc_cNome   = ALLTRIM(cursor_4c_Dados.ncomps)

                IF UPPER(loc_cCodigo) == "4CONTROL"
                    MsgAviso("Senha do Usuario n" + CHR(227) + "o pode ser Limpa !!!", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF MsgConfirma("Deseja Limpar a Senha do Usuario " + loc_cCodigo + ;
                            IIF(!EMPTY(loc_cNome), " - " + loc_cNome, "") + "?", "Confirma")

                        loc_cSQL = "UPDATE SigCdUsu SET senhas = " + EscaparSQL(SPACE(10)) + ;
                                   " WHERE RTRIM(usuarios) = " + EscaparSQL(loc_cCodigo)

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado >= 0
                            =fGravarLog("A", "SIGCDACU", "LIMPA SENHA", loc_cCodigo, gc_4c_UsuarioLogado)
                            MsgInfo("Senha limpa com sucesso!", "Confirmar")
                        ELSE
                            MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o dos dados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.BtnLimparSenhaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUsu.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
