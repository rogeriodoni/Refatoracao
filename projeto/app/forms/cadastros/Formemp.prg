*==============================================================================
* Formemp.prg - Formulario de Cadastro de Empresas
* Migrado de: SIGCDEMP.SCX (frmcadastro)
* Estrutura especial: Page2 (Dados) contem 4 sub-containers controlados por
* opt_4c_Guia (OptionGroup como seletor visual de sub-paginas)
*==============================================================================

DEFINE CLASS Formemp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Empresas"
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
    this_nSubPagina      = 1

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
            THIS.this_oBusinessObject = CREATEOBJECT("empBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar empBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formemp.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formemp:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formemp.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1 com cabecalho, containers e saida
    * Grid e botoes CRUD adicionados na Fase 4
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original Top=1; com compensacao +29: Top=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
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

        *-- Container Botoes CRUD
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 895
            .Height      = 85
            .BackStyle   = 0
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
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

        *-- Grid de lista de empresas
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 127
            .Left              = 20
            .Width             = 939
            .Height            = 484
            .ColumnCount       = 6
            .RecordSourceType  = 1
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .AllowHeaderSizing = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: opt_4c_Guia + 4 sub-containers
    * Arquitetura especial: optGuia (OptionGroup 4 botoes) seleciona qual
    * sub-container (cnt_4c_Page1..4) fica visivel
    * Botoes CRUD de edicao e campos de dados adicionados nas Fases 4-6
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- opt_4c_Guia - OptionGroup como seletor visual de sub-paginas
        *-- Original: optGuia.Top=-4, Left=24, Width=712, Height=85 (class=fwselpagina)
        *-- Com compensacao +29: Top=25
        loc_oPagina.AddObject("opt_4c_Guia", "OptionGroup")
        loc_oPagina.opt_4c_Guia.ButtonCount = 4
        WITH loc_oPagina.opt_4c_Guia
            .Top         = 25
            .Left        = 24
            .Width       = 712
            .Height      = 85
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption       = "Dados"
                .Left          = 0
                .Top           = 0
                .Width         = 178
                .Height        = 85
                .Themes        = .F.
                .SpecialEffect = 0
                .FontBold      = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption       = "Operacional"
                .Left          = 178
                .Top           = 0
                .Width         = 178
                .Height        = 85
                .Themes        = .F.
                .SpecialEffect = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
            ENDWITH
            WITH .Buttons(3)
                .Caption       = "Fiscal"
                .Left          = 356
                .Top           = 0
                .Width         = 178
                .Height        = 85
                .Themes        = .F.
                .SpecialEffect = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
            ENDWITH
            WITH .Buttons(4)
                .Caption       = "NFC-e"
                .Left          = 534
                .Top           = 0
                .Width         = 178
                .Height        = 85
                .Themes        = .F.
                .SpecialEffect = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Guia, "Click", THIS, "GuiaClick")

        *-- Container BotoesAcao (Confirmar/Cancelar)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 29
            .Left        = 737
            .Width       = 178
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 90
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
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

        *-- Sub-containers mapeiam PgDados.Page1-4 do legado
        *-- opt_4c_Guia ocupa Top=25 a Top+Height=110
        *-- Containers comecam em Top=110 (Page2 interna tem 629px total)
        *-- Height=519 cobre Top=110 ate o final da Page2 (110+519=629)

        loc_oPagina.AddObject("cnt_4c_Page1", "Container")
        WITH loc_oPagina.cnt_4c_Page1
            .Top         = 110
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 519
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Preencher cnt_4c_Page1 com campos da primeira metade (Fase 5)
        THIS.ConfigurarSubPage1(loc_oPagina)

        loc_oPagina.AddObject("cnt_4c_Page2", "Container")
        WITH loc_oPagina.cnt_4c_Page2
            .Top         = 110
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 519
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH
        THIS.ConfigurarSubPage2(loc_oPagina)

        loc_oPagina.AddObject("cnt_4c_Page3", "Container")
        WITH loc_oPagina.cnt_4c_Page3
            .Top         = 110
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 519
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH
        THIS.ConfigurarSubPage3(loc_oPagina)

        loc_oPagina.AddObject("cnt_4c_Page4", "Container")
        WITH loc_oPagina.cnt_4c_Page4
            .Top         = 110
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 519
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH
        THIS.ConfigurarSubPage4(loc_oPagina)

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Garantir que apenas cnt_4c_Page1 fica visivel apos TornarControlesVisiveis
        *-- (TCV seta tudo Visible=.T.; restaurar estado correto dos sub-containers)
        THIS.AlternarSubPagina(1)
        IF PEMSTATUS(loc_oPagina, "opt_4c_Guia", 5)
            loc_oPagina.opt_4c_Guia.Value = 1
        ENDIF
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MostrarErro("Par" + CHR(226) + "metro inv" + CHR(225) + "lido para AlternarPagina: " + ;
                    TRANSFORM(par_nPagina), "Formemp.AlternarPagina")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "Formemp.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarSubPagina - Mostra sub-container N (1-4) em Page2, esconde os demais
    * Chamado por GuiaClick e programaticamente na validacao
    *===========================================================================
    PROCEDURE AlternarSubPagina(par_nSubPagina)
        LOCAL loc_oPagina, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nSubPagina) != "N" OR par_nSubPagina < 1 OR par_nSubPagina > 4
                MostrarErro("Sub-p" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
                    TRANSFORM(par_nSubPagina), "Formemp.AlternarSubPagina")
            ELSE
                loc_oPagina = THIS.pgf_4c_Paginas.Page2

                IF PEMSTATUS(loc_oPagina, "cnt_4c_Page1", 5)
                    loc_oPagina.cnt_4c_Page1.Visible = (par_nSubPagina = 1)
                ENDIF
                IF PEMSTATUS(loc_oPagina, "cnt_4c_Page2", 5)
                    loc_oPagina.cnt_4c_Page2.Visible = (par_nSubPagina = 2)
                ENDIF
                IF PEMSTATUS(loc_oPagina, "cnt_4c_Page3", 5)
                    loc_oPagina.cnt_4c_Page3.Visible = (par_nSubPagina = 3)
                ENDIF
                IF PEMSTATUS(loc_oPagina, "cnt_4c_Page4", 5)
                    loc_oPagina.cnt_4c_Page4.Visible = (par_nSubPagina = 4)
                ENDIF

                THIS.this_nSubPagina = par_nSubPagina
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alternar sub-p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "Formemp.AlternarSubPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * GuiaClick - Handler do Click em opt_4c_Guia
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE GuiaClick()
        LOCAL loc_oPagina, loc_nSub
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_nSub    = 1

        TRY
            IF PEMSTATUS(loc_oPagina, "opt_4c_Guia", 5)
                loc_nSub = loc_oPagina.opt_4c_Guia.Value
                IF VARTYPE(loc_nSub) != "N" OR loc_nSub < 1 OR loc_nSub > 4
                    loc_nSub = 1
                ENDIF
                THIS.AlternarSubPagina(loc_nSub)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao selecionar guia:" + CHR(13) + loException.Message, ;
                "Formemp.GuiaClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CarregarLista - Executa query e vincula grid
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (cemps C(3), nemps N(4,0), razsocs C(50), razas C(40), cgcs C(20), ativas N(1,0))
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                MsgErro("Erro ao carregar lista de empresas.", "Formemp")
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount  = 6
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cemps"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.nemps"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.razsocs"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.razas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cgcs"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.ativas"

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "N" + CHR(250) + "mero"
                loc_oGrid.Column3.Header1.Caption = "Raz. Social"
                loc_oGrid.Column4.Header1.Caption = "Nome Fantasia"
                loc_oGrid.Column5.Header1.Caption = "CNPJ"
                loc_oGrid.Column6.Header1.Caption = "Ativo"

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "Formemp.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF

                IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_PAGE3", "CNT_4C_PAGE4")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName     = "Tahoma"
                .FontSize     = 8
                .HeaderHeight = 22
                .RowHeight    = 18
            ENDWITH

            WITH par_oGrid.Column1
                .Width     = 50
                .Alignment = 0
            ENDWITH
            WITH par_oGrid.Column2
                .Width     = 60
                .Alignment = 0
            ENDWITH
            WITH par_oGrid.Column3
                .Width     = 150
                .Alignment = 0
            ENDWITH
            WITH par_oGrid.Column4
                .Width     = 340
                .Alignment = 0
            ENDWITH
            WITH par_oGrid.Column5
                .Width     = 130
                .Alignment = 0
            ENDWITH
            WITH par_oGrid.Column6
                .Width     = 60
                .Alignment = 0
            ENDWITH

        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "Formemp.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CRUD Handlers - PUBLIC (BINDEVENT requer metodo publico, CLAUDE.md regra #3)
    *===========================================================================

    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.BtnIncluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cemps)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cemps)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.BtnAlterarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao, loc_lConfirma
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cemps)
                loc_cDescricao = ALLTRIM(cursor_4c_Dados.razas)

                IF loc_cCodigo == ALLTRIM(go_4c_Sistema.cCodEmpresa)
                    MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir" + CHR(13) + ;
                        "a empresa corrente.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da empresa" + CHR(13) + ;
                        loc_cCodigo + " - " + loc_cDescricao + "?", ;
                        "Confirmar Exclus" + CHR(227) + "o")

                    IF loc_lConfirma
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                            IF THIS.this_oBusinessObject.Excluir()
                                MsgInfo("Empresa exclu" + CHR(237) + "da com sucesso!", "Sucesso")
                                THIS.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.BtnExcluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFiltro, loc_oGrid
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", "", "Buscar Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_cFiltro = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cemps) = loc_cFiltro
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loc_oErro
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
            MsgErro(loc_oErro.Message, "Formemp.BtnBuscarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                IF THIS.this_cModoAtual = "INCLUIR"
                    MsgInfo("Empresa inclu" + CHR(237) + "da com sucesso!", "Sucesso")
                ELSE
                    MsgInfo("Empresa atualizada com sucesso!", "Sucesso")
                ENDIF
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao salvar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.BtnConfirmarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.BtnCancelarClick")
        ENDTRY
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEmLista
        TRY
            loc_lEmLista = (THIS.this_cModoAtual = "LISTA")
            loc_oPg1     = THIS.pgf_4c_Paginas.Page1
            loc_oPg2     = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                        INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oP1, loc_oP2, loc_oP3, loc_oP4, loc_oBO
        TRY
            loc_oBO = THIS.this_oBusinessObject
            loc_oP1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
            loc_oP2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
            loc_oP3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
            loc_oP4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page4

            *-- Page1: Identificacao
            loc_oBO.this_cCodigo           = ALLTRIM(loc_oP1.txt_4c_Codigo.Value)
            loc_oBO.this_nNumero           = ALLTRIM(loc_oP1.txt_4c_Numero.Value)
            loc_oBO.this_nTipoCgc          = loc_oP1.obj_4c_OpcaoCPFCGC.Value
            loc_oBO.this_cCgc              = ALLTRIM(loc_oP1.txt_4c_Cgc.Value)
            loc_oBO.this_cIe               = ALLTRIM(loc_oP1.txt_4c_IES.Value)
            loc_oBO.this_nSituacao         = loc_oP1.cbo_4c_FWCOMBO1.ListIndex
            loc_oBO.this_cRazaoSocial      = ALLTRIM(loc_oP1.txt_4c_Razsoc.Value)
            loc_oBO.this_cNomeReduzido     = ALLTRIM(loc_oP1.txt_4c_Empr.Value)
            loc_oBO.this_cNomeFantasia     = ALLTRIM(loc_oP1.txt_4c_Nome.Value)
            loc_oBO.this_cIm               = ALLTRIM(loc_oP1.txt_4c_IMS.Value)
            loc_oBO.this_cCnae             = ALLTRIM(loc_oP1.txt_4c_CNAE.Value)
            loc_oBO.this_cResponsavel      = ALLTRIM(loc_oP1.txt_4c_Resp.Value)
            loc_oBO.this_cCargo            = ALLTRIM(loc_oP1.txt_4c_Cargo.Value)
            loc_oBO.this_cPostoFiscal      = ALLTRIM(loc_oP1.txt_4c_Postofiscal.Value)
            loc_oBO.this_cEan13            = ALLTRIM(loc_oP1.txt_4c_EAN13.Value)
            loc_oBO.this_cCEstoque         = ALLTRIM(loc_oP1.txt_4c_CEstoque.Value)
            loc_oBO.this_cGrupoCC          = ALLTRIM(loc_oP1.txt_4c__GRUPOC.Value)
            loc_oBO.this_cContaC           = ALLTRIM(loc_oP1.txt_4c__CONTAC.Value)
            loc_oBO.this_cContaArls        = ALLTRIM(loc_oP1.txt_4c_CONTARLS.Value)
            loc_oBO.this_cCodEmpresa       = ALLTRIM(loc_oP1.txt_4c_CodEmpresa.Value)
            loc_oBO.this_lAnaVends         = (loc_oP3.chk_4c_ChkAnaVends.Value = 1)
            loc_oBO.this_cCodRepres        = ALLTRIM(loc_oP1.txt_4c_CodRepres.Value)
            loc_oBO.this_cGrupoEmpresarial = ALLTRIM(loc_oP1.txt_4c_Grupo.Value)
            loc_oBO.this_cClassificacaoEmp = ALLTRIM(loc_oP1.txt_4c_Class.Value)
            loc_oBO.this_lEscritorio       = (loc_oP1.chk_4c_ChkEsc.Value = 1)

            *-- Page1: Endereco
            loc_oBO.this_cCep              = ALLTRIM(loc_oP1.txt_4c_Cep.Value)
            loc_oBO.this_cPais             = ALLTRIM(loc_oP1.txt_4c_Pais.Value)
            loc_oBO.this_nFusoHorario      = ALLTRIM(loc_oP1.txt_4c_4.Value)
            loc_oBO.this_cEndereco         = ALLTRIM(loc_oP1.txt_4c_End.Value)
            loc_oBO.this_cNumEndereco      = ALLTRIM(loc_oP1.txt_4c_3.Value)
            loc_oBO.this_cComplemento      = ALLTRIM(loc_oP1.txt_4c_Comp.Value)
            loc_oBO.this_cBairro           = ALLTRIM(loc_oP1.txt_4c_Bairro.Value)
            loc_oBO.this_cCidade           = ALLTRIM(loc_oP1.txt_4c_Cid.Value)
            loc_oBO.this_cEstado           = ALLTRIM(loc_oP1.txt_4c_Est.Value)
            loc_oBO.this_cRegiao           = ALLTRIM(loc_oP1.txt_4c_REGIAOS.Value)

            *-- Page1: Contatos
            loc_oBO.this_cTelefone1        = ALLTRIM(loc_oP1.txt_4c_Tel1.Value)
            loc_oBO.this_cTelefone2        = ALLTRIM(loc_oP1.txt_4c_Tel2.Value)
            loc_oBO.this_cFax              = ALLTRIM(loc_oP1.txt_4c_Fax.Value)
            loc_oBO.this_cEmail            = ALLTRIM(loc_oP1.txt_4c__emails.Value)

            *-- Page1: Datas
            loc_oBO.this_dDtCadastro       = loc_oP1.txt_4c_DTCADAS.Value
            loc_oBO.this_cNumProtBx        = ALLTRIM(loc_oP1.txt_4c_NUMPROTBX.Value)
            loc_oBO.this_dDtProtBx         = loc_oP1.txt_4c_DTPROTBX.Value
            loc_oBO.this_dDtEncerramento   = loc_oP1.txt_4c_DTENCERRAS.Value
            loc_oBO.this_nRegimeTrib       = loc_oP1.cbo_4c_CmbRegime.ListIndex
            loc_oBO.this_dDtInicioOperacao = loc_oP1.txt_4c_DTINIOPS.Value
            loc_oBO.this_nAliqSimples      = ALLTRIM(loc_oP1.txt_4c_Fwget1.Value)

            *-- Page1: Aliquotas
            loc_oBO.this_nMercIR           = ALLTRIM(loc_oP1.txt_4c_MIR.Value)
            loc_oBO.this_nMercCSLL         = ALLTRIM(loc_oP1.txt_4c_MCSLL.Value)
            loc_oBO.this_nMercPIS          = ALLTRIM(loc_oP1.txt_4c_MPIS.Value)
            loc_oBO.this_nMercCofins       = ALLTRIM(loc_oP1.txt_4c_MCOFINS.Value)
            loc_oBO.this_nServIR           = ALLTRIM(loc_oP1.txt_4c_SIR.Value)
            loc_oBO.this_nServCSLL         = ALLTRIM(loc_oP1.txt_4c_SCSLL.Value)
            loc_oBO.this_nServPIS          = ALLTRIM(loc_oP1.txt_4c_SPIS.Value)
            loc_oBO.this_nServCofins       = ALLTRIM(loc_oP1.txt_4c_SCOFINS.Value)
            loc_oBO.this_nAliqIR           = ALLTRIM(loc_oP1.txt_4c_AIR.Value)
            loc_oBO.this_nAliqCSLL         = ALLTRIM(loc_oP1.txt_4c_ACSLL.Value)

            *-- Page1: Email Alerta
            loc_oBO.this_cSmtpAlerta       = ALLTRIM(loc_oP1.cnt_4c_Alerta.txt_4c_Servs.Value)
            loc_oBO.this_nPortaAlerta      = ALLTRIM(loc_oP1.cnt_4c_Alerta.txt_4c_Porta.Value)
            loc_oBO.this_cEmailAlerta      = ALLTRIM(loc_oP1.cnt_4c_Alerta.txt_4c_Emailnfe.Value)
            loc_oBO.this_cSenhaAlerta      = ALLTRIM(loc_oP1.cnt_4c_Alerta.txt_4c_Senhas.Value)

            *-- Page2: Impressao e Saida
            loc_oBO.this_cImpressora       = ALLTRIM(loc_oP2.txt_4c_Impc.Value)
            loc_oBO.this_cCarrAutomatico   = ALLTRIM(loc_oP2.txt_4c_Caraut.Value)
            loc_oBO.this_cEtiqProd         = ALLTRIM(loc_oP2.txt_4c_Etiqprod.Value)
            loc_oBO.this_cMemoBoleto       = ALLTRIM(loc_oP2.obj_4c_Memo_boleto.Value)
            loc_oBO.this_cTipoOf           = ALLTRIM(loc_oP2.txt_4c_Tipoof.Value)
            loc_oBO.this_cPinPadLinha1     = ALLTRIM(loc_oP2.obj_4c_GetPPLinha1s.Value)
            loc_oBO.this_cPinPadLinha2     = ALLTRIM(loc_oP2.obj_4c_GetPPlinha2s.Value)
            loc_oBO.this_cCodServSaida     = ALLTRIM(loc_oP2.txt_4c__CodServs.Value)
            loc_oBO.this_cDescServSaida    = ALLTRIM(loc_oP2.txt_4c_Dservs.Value)
            loc_oBO.this_cEstoqueCtrl      = ALLTRIM(loc_oP2.txt_4c_Estoque.Value)
            loc_oBO.this_nDifPeso          = ALLTRIM(loc_oP2.txt_4c_Difpes.Value)
            loc_oBO.this_nAdicional        = ALLTRIM(loc_oP2.txt_4c_Adicional.Value)

            *-- Page2: Sitef / Bonus / Transporte
            loc_oBO.this_cEmpSitef         = ALLTRIM(loc_oP2.txt_4c_EmpSitef.Value)
            loc_oBO.this_nTpTrans          = ALLTRIM(loc_oP2.txt_4c__TpTrans.Value)
            loc_oBO.this_nPercCreds        = ALLTRIM(loc_oP2.txt_4c_PercCreds.Value)
            loc_oBO.this_nPerComis         = ALLTRIM(loc_oP2.txt_4c_PerComis.Value)
            loc_oBO.this_nOpcComis         = loc_oP2.obj_4c_Opc_comis.Value
            loc_oBO.this_nCalcCustos       = loc_oP2.obj_4c_OPTCALCCUSTOS.Value
            loc_oBO.this_nAltTrans         = loc_oP2.obj_4c_OPT_ALTTRANS.Value
            loc_oBO.this_lBlqDt            = (loc_oP2.obj_4c_Op_blqdt.Value = 1)
            loc_oBO.this_nBriefing         = loc_oP2.obj_4c_Optiongroup1.Value
            loc_oBO.this_nEcommerce        = loc_oP2.obj_4c_Optiongroup2.Value

            *-- Page2: Empresa OS / SEDEX / Sub
            loc_oBO.this_cEmpBal           = ALLTRIM(loc_oP2.txt_4c_EmpBal.Value)
            loc_oBO.this_nTempoSub         = ALLTRIM(loc_oP2.txt_4c_TempoSubn.Value)
            loc_oBO.this_cDopInt           = ALLTRIM(loc_oP2.txt_4c_Dope_int.Value)
            loc_oBO.this_cDac              = ALLTRIM(loc_oP2.txt_4c_DAC.Value)
            loc_oBO.this_cBanco            = ALLTRIM(loc_oP2.txt_4c_Banco.Value)
            loc_oBO.this_cAgencia          = ALLTRIM(loc_oP2.txt_4c_Agenc.Value)
            loc_oBO.this_cConta            = ALLTRIM(loc_oP2.txt_4c_Conta.Value)
            loc_oBO.this_cContratoDef      = ALLTRIM(loc_oP2.txt_4c_Contrato.Value)
            loc_oBO.this_cAgenciaSedex     = ALLTRIM(loc_oP2.txt_4c_Agencia.Value)
            loc_oBO.this_cCartaoSedex      = ALLTRIM(loc_oP2.txt_4c_Cartao.Value)

            *-- Page2: Email Padrao
            loc_oBO.this_cSmtpEmail        = ALLTRIM(loc_oP2.cnt_4c_EmailPad.txt_4c_Servs.Value)
            loc_oBO.this_nPortaEmail       = ALLTRIM(loc_oP2.cnt_4c_EmailPad.txt_4c_Porta.Value)
            loc_oBO.this_cEmailPad         = ALLTRIM(loc_oP2.cnt_4c_EmailPad.txt_4c_Email.Value)
            loc_oBO.this_cSenhaEmail       = ALLTRIM(loc_oP2.cnt_4c_EmailPad.txt_4c_Senhas.Value)

            *-- Page2: Distribuicao / CDL
            loc_oBO.this_cSaiCol           = ALLTRIM(loc_oP2.txt_4c_Saicol.Value)
            loc_oBO.this_cCdlSenha         = ALLTRIM(loc_oP2.txt_4c_Cdlsenhas.Value)

            *-- Page3: CFOP / Moeda / Mrcf
            loc_oBO.this_cMcTotal          = ALLTRIM(loc_oP3.txt_4c_Mctotal.Value)
            loc_oBO.this_cCfoInt           = ALLTRIM(loc_oP3.txt_4c_Cfo_Int.Value)
            loc_oBO.this_nMrcf             = ALLTRIM(loc_oP3.txt_4c_Mrcf.Value)

            *-- Page3: Grupos e Contas Contabeis (Orig)
            loc_oBO.this_cGrupoIcmsOrig    = ALLTRIM(loc_oP3.txt_4c__GRUPOO.Value)
            loc_oBO.this_cContaIcmsOrig    = ALLTRIM(loc_oP3.txt_4c__CONTAO.Value)
            loc_oBO.this_cGrupoIcmsDeb     = ALLTRIM(loc_oP3.txt_4c__GRUICMO.Value)
            loc_oBO.this_cContaIcmsDeb     = ALLTRIM(loc_oP3.txt_4c__CONICMO.Value)
            loc_oBO.this_cGrupoIpi         = ALLTRIM(loc_oP3.txt_4c__GRUIPIO.Value)
            loc_oBO.this_cContaIpi         = ALLTRIM(loc_oP3.txt_4c__CONIPIO.Value)
            loc_oBO.this_cGrupoPis         = ALLTRIM(loc_oP3.txt_4c__GRUPISO.Value)
            loc_oBO.this_cContaPis         = ALLTRIM(loc_oP3.txt_4c__CONPISO.Value)
            loc_oBO.this_cGrupoCofins      = ALLTRIM(loc_oP3.txt_4c__GRUCONO.Value)
            loc_oBO.this_cContaCofins      = ALLTRIM(loc_oP3.txt_4c__CONCONO.Value)

            *-- Page3: Grupos e Contas Contabeis (Dev)
            loc_oBO.this_cGrupoIcmsDevOrig = ALLTRIM(loc_oP3.txt_4c__GRUPOD.Value)
            loc_oBO.this_cContaIcmsDevOrig = ALLTRIM(loc_oP3.txt_4c__CONTAD.Value)
            loc_oBO.this_cGrupoIcmsDevDeb  = ALLTRIM(loc_oP3.txt_4c__GRUICMD.Value)
            loc_oBO.this_cContaIcmsDevDeb  = ALLTRIM(loc_oP3.txt_4c__CONICMD.Value)
            loc_oBO.this_cGrupoIpiDev      = ALLTRIM(loc_oP3.txt_4c__GRUIPID.Value)
            loc_oBO.this_cContaIpiDev      = ALLTRIM(loc_oP3.txt_4c__CONIPID.Value)
            loc_oBO.this_cGrupoPisDev      = ALLTRIM(loc_oP3.txt_4c__GRUPISD.Value)
            loc_oBO.this_cContaPisDev      = ALLTRIM(loc_oP3.txt_4c__CONPISD.Value)
            loc_oBO.this_cGrupoCofDev      = ALLTRIM(loc_oP3.txt_4c__GRUCOND.Value)
            loc_oBO.this_cContaCofDev      = ALLTRIM(loc_oP3.txt_4c__CONCOND.Value)

            *-- Page3: Config Fiscais
            loc_oBO.this_nPorcPis          = ALLTRIM(loc_oP3.txt_4c__PORCPIS.Value)
            loc_oBO.this_nPorcCons         = ALLTRIM(loc_oP3.txt_4c__PORCCONS.Value)
            loc_oBO.this_cPerfil           = ALLTRIM(loc_oP3.txt_4c_Perfil.Value)
            loc_oBO.this_nIndica           = ALLTRIM(loc_oP3.txt_4c__indicas.Value)
            loc_oBO.this_nRegTribCat44     = ALLTRIM(loc_oP3.txt_4c_REGTRIB.Value)
            loc_oBO.this_cCcustos          = ALLTRIM(loc_oP3.txt_4c_Ccustos.Value)
            loc_oBO.this_cTipoEfd          = ALLTRIM(loc_oP3.cbo_4c_CB_TIPOEFD.DisplayValue)
            loc_oBO.this_cRegEsp           = ALLTRIM(loc_oP3.txt_4c_RegEsps.Value)
            loc_oBO.this_cCodOper          = ALLTRIM(loc_oP3.txt_4c__CodOper.Value)
            loc_oBO.this_cCodSMun          = ALLTRIM(loc_oP3.txt_4c_Codigo.Value)
            loc_oBO.this_nMrcf             = ALLTRIM(loc_oP3.txt_4c_Mrcf.Value)

            *-- Page3: Email NF-e
            loc_oBO.this_cSmtpNfe          = ALLTRIM(loc_oP3.txt_4c_Servs.Value)
            loc_oBO.this_nPortaNfe         = ALLTRIM(loc_oP3.txt_4c_Porta.Value)
            loc_oBO.this_cEmailNfe         = ALLTRIM(loc_oP3.txt_4c_Emailnfe.Value)
            loc_oBO.this_cSenhaNfe         = ALLTRIM(loc_oP3.txt_4c_Senhas.Value)
            loc_oBO.this_cPastaEmail       = ALLTRIM(loc_oP3.txt_4c_Pastas.Value)
            loc_oBO.this_cTextoNfe         = ALLTRIM(loc_oP3.obj_4c_Get_textonfe.Value)
            loc_oBO.this_cTextoPaf         = ALLTRIM(loc_oP3.obj_4c_Get_textopaf.Value)
            loc_oBO.this_cLogo             = ALLTRIM(loc_oP3.txt_4c_Logo.Value)
            loc_oBO.this_cPastaFci         = ALLTRIM(loc_oP3.txt_4c_PastaFci.Value)

            *-- Page4: NFC-e
            loc_oBO.this_cChaveParceiro    = ALLTRIM(loc_oP4.txt_4c__chavep.Value)
            loc_oBO.this_cChaveContrib     = ALLTRIM(loc_oP4.txt_4c__chavec.Value)
            loc_oBO.this_cCsc              = ALLTRIM(loc_oP4.txt_4c__csc.Value)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.FormParaBO")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oP1, loc_oP2, loc_oP3, loc_oP4, loc_oBO
        TRY
            loc_oBO = THIS.this_oBusinessObject
            loc_oP1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
            loc_oP2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
            loc_oP3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
            loc_oP4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page4

            *-- Page1: Identificacao
            loc_oP1.txt_4c_Codigo.Value          = loc_oBO.this_cCodigo
            loc_oP1.txt_4c_Numero.Value          = TRANSFORM(loc_oBO.this_nNumero)
            loc_oP1.obj_4c_OpcaoCPFCGC.Value     = IIF(loc_oBO.this_nTipoCgc = 0, 2, loc_oBO.this_nTipoCgc)
            loc_oP1.txt_4c_Cgc.Value             = loc_oBO.this_cCgc
            loc_oP1.txt_4c_IES.Value             = loc_oBO.this_cIe
            loc_oP1.cbo_4c_FWCOMBO1.ListIndex    = loc_oBO.this_nSituacao
            loc_oP1.txt_4c_Razsoc.Value          = loc_oBO.this_cRazaoSocial
            loc_oP1.txt_4c_Empr.Value            = loc_oBO.this_cNomeReduzido
            loc_oP1.txt_4c_Nome.Value            = loc_oBO.this_cNomeFantasia
            loc_oP1.txt_4c_IMS.Value             = loc_oBO.this_cIm
            loc_oP1.txt_4c_CNAE.Value            = loc_oBO.this_cCnae
            loc_oP1.txt_4c_Resp.Value            = loc_oBO.this_cResponsavel
            loc_oP1.txt_4c_Cargo.Value           = loc_oBO.this_cCargo
            loc_oP1.txt_4c_Postofiscal.Value     = loc_oBO.this_cPostoFiscal
            loc_oP1.txt_4c_EAN13.Value           = loc_oBO.this_cEan13
            loc_oP1.txt_4c_CEstoque.Value        = loc_oBO.this_cCEstoque
            loc_oP1.txt_4c__GRUPOC.Value         = loc_oBO.this_cGrupoCC
            loc_oP1.txt_4c__CONTAC.Value         = loc_oBO.this_cContaC
            loc_oP1.txt_4c_CONTARLS.Value        = loc_oBO.this_cContaArls
            loc_oP1.txt_4c_CodEmpresa.Value      = loc_oBO.this_cCodEmpresa
            loc_oP3.chk_4c_ChkAnaVends.Value     = IIF(loc_oBO.this_lAnaVends, 1, 0)
            loc_oP1.txt_4c_CodRepres.Value       = loc_oBO.this_cCodRepres
            loc_oP1.txt_4c_Grupo.Value           = loc_oBO.this_cGrupoEmpresarial
            loc_oP1.txt_4c_Class.Value           = loc_oBO.this_cClassificacaoEmp
            loc_oP1.chk_4c_ChkEsc.Value          = IIF(loc_oBO.this_lEscritorio, 1, 0)

            *-- Page1: Endereco
            loc_oP1.txt_4c_Cep.Value             = loc_oBO.this_cCep
            loc_oP1.txt_4c_Pais.Value            = loc_oBO.this_cPais
            loc_oP1.txt_4c_4.Value               = TRANSFORM(loc_oBO.this_nFusoHorario)
            loc_oP1.txt_4c_End.Value             = loc_oBO.this_cEndereco
            loc_oP1.txt_4c_3.Value               = loc_oBO.this_cNumEndereco
            loc_oP1.txt_4c_Comp.Value            = loc_oBO.this_cComplemento
            loc_oP1.txt_4c_Bairro.Value          = loc_oBO.this_cBairro
            loc_oP1.txt_4c_Cid.Value             = loc_oBO.this_cCidade
            loc_oP1.txt_4c_Est.Value             = loc_oBO.this_cEstado
            loc_oP1.txt_4c_REGIAOS.Value         = loc_oBO.this_cRegiao

            *-- Page1: Contatos
            loc_oP1.txt_4c_Tel1.Value            = loc_oBO.this_cTelefone1
            loc_oP1.txt_4c_Tel2.Value            = loc_oBO.this_cTelefone2
            loc_oP1.txt_4c_Fax.Value             = loc_oBO.this_cFax
            loc_oP1.txt_4c__emails.Value         = loc_oBO.this_cEmail

            *-- Page1: Datas
            loc_oP1.txt_4c_DTCADAS.Value         = loc_oBO.this_dDtCadastro
            loc_oP1.txt_4c_NUMPROTBX.Value       = loc_oBO.this_cNumProtBx
            loc_oP1.txt_4c_DTPROTBX.Value        = loc_oBO.this_dDtProtBx
            loc_oP1.txt_4c_DTENCERRAS.Value      = loc_oBO.this_dDtEncerramento
            loc_oP1.cbo_4c_CmbRegime.ListIndex   = loc_oBO.this_nRegimeTrib
            loc_oP1.txt_4c_DTINIOPS.Value        = loc_oBO.this_dDtInicioOperacao
            loc_oP1.txt_4c_Fwget1.Value          = TRANSFORM(loc_oBO.this_nAliqSimples)

            *-- Page1: Aliquotas
            loc_oP1.txt_4c_MIR.Value             = TRANSFORM(loc_oBO.this_nMercIR)
            loc_oP1.txt_4c_MCSLL.Value           = TRANSFORM(loc_oBO.this_nMercCSLL)
            loc_oP1.txt_4c_MPIS.Value            = TRANSFORM(loc_oBO.this_nMercPIS)
            loc_oP1.txt_4c_MCOFINS.Value         = TRANSFORM(loc_oBO.this_nMercCofins)
            loc_oP1.txt_4c_SIR.Value             = TRANSFORM(loc_oBO.this_nServIR)
            loc_oP1.txt_4c_SCSLL.Value           = TRANSFORM(loc_oBO.this_nServCSLL)
            loc_oP1.txt_4c_SPIS.Value            = TRANSFORM(loc_oBO.this_nServPIS)
            loc_oP1.txt_4c_SCOFINS.Value         = TRANSFORM(loc_oBO.this_nServCofins)
            loc_oP1.txt_4c_AIR.Value             = TRANSFORM(loc_oBO.this_nAliqIR)
            loc_oP1.txt_4c_ACSLL.Value           = TRANSFORM(loc_oBO.this_nAliqCSLL)

            *-- Page1: Email Alerta
            loc_oP1.cnt_4c_Alerta.txt_4c_Servs.Value    = loc_oBO.this_cSmtpAlerta
            loc_oP1.cnt_4c_Alerta.txt_4c_Porta.Value    = TRANSFORM(loc_oBO.this_nPortaAlerta)
            loc_oP1.cnt_4c_Alerta.txt_4c_Emailnfe.Value = loc_oBO.this_cEmailAlerta
            loc_oP1.cnt_4c_Alerta.txt_4c_Senhas.Value   = loc_oBO.this_cSenhaAlerta

            *-- Page2: Impressao e Saida
            loc_oP2.txt_4c_Impc.Value            = loc_oBO.this_cImpressora
            loc_oP2.txt_4c_Caraut.Value          = loc_oBO.this_cCarrAutomatico
            loc_oP2.txt_4c_Etiqprod.Value        = loc_oBO.this_cEtiqProd
            loc_oP2.obj_4c_Memo_boleto.Value     = loc_oBO.this_cMemoBoleto
            loc_oP2.txt_4c_Tipoof.Value          = loc_oBO.this_cTipoOf
            loc_oP2.obj_4c_GetPPLinha1s.Value    = loc_oBO.this_cPinPadLinha1
            loc_oP2.obj_4c_GetPPlinha2s.Value    = loc_oBO.this_cPinPadLinha2
            loc_oP2.txt_4c__CodServs.Value       = loc_oBO.this_cCodServSaida
            loc_oP2.txt_4c_Dservs.Value          = loc_oBO.this_cDescServSaida
            loc_oP2.txt_4c_Estoque.Value         = loc_oBO.this_cEstoqueCtrl
            loc_oP2.txt_4c_Difpes.Value          = TRANSFORM(loc_oBO.this_nDifPeso)
            loc_oP2.txt_4c_Adicional.Value       = TRANSFORM(loc_oBO.this_nAdicional)

            *-- Page2: Sitef / Bonus / Transporte
            loc_oP2.txt_4c_EmpSitef.Value        = loc_oBO.this_cEmpSitef
            loc_oP2.txt_4c__TpTrans.Value        = TRANSFORM(loc_oBO.this_nTpTrans)
            loc_oP2.txt_4c_PercCreds.Value       = TRANSFORM(loc_oBO.this_nPercCreds)
            loc_oP2.txt_4c_PerComis.Value        = TRANSFORM(loc_oBO.this_nPerComis)
            loc_oP2.obj_4c_Opc_comis.Value       = loc_oBO.this_nOpcComis
            loc_oP2.obj_4c_OPTCALCCUSTOS.Value   = loc_oBO.this_nCalcCustos
            loc_oP2.obj_4c_OPT_ALTTRANS.Value    = loc_oBO.this_nAltTrans
            loc_oP2.obj_4c_Op_blqdt.Value        = IIF(loc_oBO.this_lBlqDt, 1, 2)
            loc_oP2.obj_4c_Optiongroup1.Value    = loc_oBO.this_nBriefing
            loc_oP2.obj_4c_Optiongroup2.Value    = loc_oBO.this_nEcommerce

            *-- Page2: Empresa OS / SEDEX / Sub
            loc_oP2.txt_4c_EmpBal.Value          = loc_oBO.this_cEmpBal
            loc_oP2.txt_4c_TempoSubn.Value       = TRANSFORM(loc_oBO.this_nTempoSub)
            loc_oP2.txt_4c_Dope_int.Value        = loc_oBO.this_cDopInt
            loc_oP2.txt_4c_DAC.Value             = loc_oBO.this_cDac
            loc_oP2.txt_4c_Banco.Value           = loc_oBO.this_cBanco
            loc_oP2.txt_4c_Agenc.Value           = loc_oBO.this_cAgencia
            loc_oP2.txt_4c_Conta.Value           = loc_oBO.this_cConta
            loc_oP2.txt_4c_Contrato.Value        = loc_oBO.this_cContratoDef
            loc_oP2.txt_4c_Agencia.Value         = loc_oBO.this_cAgenciaSedex
            loc_oP2.txt_4c_Cartao.Value          = loc_oBO.this_cCartaoSedex

            *-- Page2: Email Padrao
            loc_oP2.cnt_4c_EmailPad.txt_4c_Servs.Value  = loc_oBO.this_cSmtpEmail
            loc_oP2.cnt_4c_EmailPad.txt_4c_Porta.Value  = TRANSFORM(loc_oBO.this_nPortaEmail)
            loc_oP2.cnt_4c_EmailPad.txt_4c_Email.Value  = loc_oBO.this_cEmailPad
            loc_oP2.cnt_4c_EmailPad.txt_4c_Senhas.Value = loc_oBO.this_cSenhaEmail

            *-- Page2: Distribuicao / CDL
            loc_oP2.txt_4c_Saicol.Value          = loc_oBO.this_cSaiCol
            loc_oP2.txt_4c_Cdlsenhas.Value       = loc_oBO.this_cCdlSenha

            *-- Page3: CFOP / Moeda / Mrcf
            loc_oP3.txt_4c_Mctotal.Value         = loc_oBO.this_cMcTotal
            loc_oP3.txt_4c_Cfo_Int.Value         = loc_oBO.this_cCfoInt
            loc_oP3.txt_4c_Mrcf.Value            = TRANSFORM(loc_oBO.this_nMrcf)

            *-- Page3: Grupos e Contas (Orig)
            loc_oP3.txt_4c__GRUPOO.Value         = loc_oBO.this_cGrupoIcmsOrig
            loc_oP3.txt_4c__CONTAO.Value         = loc_oBO.this_cContaIcmsOrig
            loc_oP3.txt_4c__GRUICMO.Value        = loc_oBO.this_cGrupoIcmsDeb
            loc_oP3.txt_4c__CONICMO.Value        = loc_oBO.this_cContaIcmsDeb
            loc_oP3.txt_4c__GRUIPIO.Value        = loc_oBO.this_cGrupoIpi
            loc_oP3.txt_4c__CONIPIO.Value        = loc_oBO.this_cContaIpi
            loc_oP3.txt_4c__GRUPISO.Value        = loc_oBO.this_cGrupoPis
            loc_oP3.txt_4c__CONPISO.Value        = loc_oBO.this_cContaPis
            loc_oP3.txt_4c__GRUCONO.Value        = loc_oBO.this_cGrupoCofins
            loc_oP3.txt_4c__CONCONO.Value        = loc_oBO.this_cContaCofins

            *-- Page3: Grupos e Contas (Dev)
            loc_oP3.txt_4c__GRUPOD.Value         = loc_oBO.this_cGrupoIcmsDevOrig
            loc_oP3.txt_4c__CONTAD.Value         = loc_oBO.this_cContaIcmsDevOrig
            loc_oP3.txt_4c__GRUICMD.Value        = loc_oBO.this_cGrupoIcmsDevDeb
            loc_oP3.txt_4c__CONICMD.Value        = loc_oBO.this_cContaIcmsDevDeb
            loc_oP3.txt_4c__GRUIPID.Value        = loc_oBO.this_cGrupoIpiDev
            loc_oP3.txt_4c__CONIPID.Value        = loc_oBO.this_cContaIpiDev
            loc_oP3.txt_4c__GRUPISD.Value        = loc_oBO.this_cGrupoPisDev
            loc_oP3.txt_4c__CONPISD.Value        = loc_oBO.this_cContaPisDev
            loc_oP3.txt_4c__GRUCOND.Value        = loc_oBO.this_cGrupoCofDev
            loc_oP3.txt_4c__CONCOND.Value        = loc_oBO.this_cContaCofDev

            *-- Page3: Config Fiscais
            loc_oP3.txt_4c__PORCPIS.Value        = TRANSFORM(loc_oBO.this_nPorcPis)
            loc_oP3.txt_4c__PORCCONS.Value       = TRANSFORM(loc_oBO.this_nPorcCons)
            loc_oP3.txt_4c_Perfil.Value          = loc_oBO.this_cPerfil
            loc_oP3.txt_4c__indicas.Value        = TRANSFORM(loc_oBO.this_nIndica)
            loc_oP3.txt_4c_REGTRIB.Value         = TRANSFORM(loc_oBO.this_nRegTribCat44)
            loc_oP3.txt_4c_Ccustos.Value         = loc_oBO.this_cCcustos
            loc_oP3.txt_4c_RegEsps.Value         = loc_oBO.this_cRegEsp
            loc_oP3.txt_4c__CodOper.Value        = loc_oBO.this_cCodOper
            loc_oP3.txt_4c_Codigo.Value          = loc_oBO.this_cCodSMun

            *-- Page3: Email NF-e
            loc_oP3.txt_4c_Servs.Value           = loc_oBO.this_cSmtpNfe
            loc_oP3.txt_4c_Porta.Value           = TRANSFORM(loc_oBO.this_nPortaNfe)
            loc_oP3.txt_4c_Emailnfe.Value        = loc_oBO.this_cEmailNfe
            loc_oP3.txt_4c_Senhas.Value          = loc_oBO.this_cSenhaNfe
            loc_oP3.txt_4c_Pastas.Value          = loc_oBO.this_cPastaEmail
            loc_oP3.obj_4c_Get_textonfe.Value    = loc_oBO.this_cTextoNfe
            loc_oP3.obj_4c_Get_textopaf.Value    = loc_oBO.this_cTextoPaf
            loc_oP3.txt_4c_Logo.Value            = loc_oBO.this_cLogo
            loc_oP3.txt_4c_PastaFci.Value        = loc_oBO.this_cPastaFci

            *-- Page4: NFC-e
            loc_oP4.txt_4c__chavep.Value         = loc_oBO.this_cChaveParceiro
            loc_oP4.txt_4c__chavec.Value         = loc_oBO.this_cChaveContrib
            loc_oP4.txt_4c__csc.Value            = loc_oBO.this_cCsc

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.BOParaForm")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oP1, loc_oP2, loc_oP3, loc_oP4
        TRY
            loc_oP1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
            loc_oP2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
            loc_oP3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
            loc_oP4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page4

            *-- Page1
            loc_oP1.txt_4c_Codigo.Value          = ""
            loc_oP1.txt_4c_Numero.Value          = ""
            loc_oP1.obj_4c_OpcaoCPFCGC.Value     = 2
            loc_oP1.txt_4c_Cgc.Value             = ""
            loc_oP1.txt_4c_IES.Value             = ""
            loc_oP1.cbo_4c_FWCOMBO1.ListIndex    = 0
            loc_oP1.txt_4c_Razsoc.Value          = ""
            loc_oP1.txt_4c_Empr.Value            = ""
            loc_oP1.txt_4c_Nome.Value            = ""
            loc_oP1.txt_4c_IMS.Value             = ""
            loc_oP1.txt_4c_CNAE.Value            = ""
            loc_oP1.txt_4c_Resp.Value            = ""
            loc_oP1.txt_4c_Cargo.Value           = ""
            loc_oP1.txt_4c_Postofiscal.Value     = ""
            loc_oP1.txt_4c_EAN13.Value           = ""
            loc_oP1.txt_4c_CEstoque.Value        = ""
            loc_oP1.txt_4c__GRUPOC.Value         = ""
            loc_oP1.txt_4c__CONTAC.Value         = ""
            loc_oP1.txt_4c_CONTARLS.Value        = ""
            loc_oP1.txt_4c_CodEmpresa.Value      = ""
            loc_oP3.chk_4c_ChkAnaVends.Value     = 0
            loc_oP1.txt_4c_CodRepres.Value       = ""
            loc_oP1.txt_4c_Grupo.Value           = ""
            loc_oP1.txt_4c_Class.Value           = ""
            loc_oP1.chk_4c_ChkEsc.Value          = 0
            loc_oP1.txt_4c_Cep.Value             = ""
            loc_oP1.txt_4c_Pais.Value            = ""
            loc_oP1.txt_4c_4.Value               = ""
            loc_oP1.txt_4c_End.Value             = ""
            loc_oP1.txt_4c_3.Value               = ""
            loc_oP1.txt_4c_Comp.Value            = ""
            loc_oP1.txt_4c_Bairro.Value          = ""
            loc_oP1.txt_4c_Cid.Value             = ""
            loc_oP1.txt_4c_Est.Value             = ""
            loc_oP1.txt_4c_REGIAOS.Value         = ""
            loc_oP1.txt_4c_Tel1.Value            = ""
            loc_oP1.txt_4c_Tel2.Value            = ""
            loc_oP1.txt_4c_Fax.Value             = ""
            loc_oP1.txt_4c__emails.Value         = ""
            loc_oP1.txt_4c_DTCADAS.Value         = {}
            loc_oP1.txt_4c_NUMPROTBX.Value       = ""
            loc_oP1.txt_4c_DTPROTBX.Value        = {}
            loc_oP1.txt_4c_DTENCERRAS.Value      = {}
            loc_oP1.cbo_4c_CmbRegime.ListIndex   = 0
            loc_oP1.txt_4c_DTINIOPS.Value        = {}
            loc_oP1.txt_4c_Fwget1.Value          = ""
            loc_oP1.txt_4c_MIR.Value             = ""
            loc_oP1.txt_4c_MCSLL.Value           = ""
            loc_oP1.txt_4c_MPIS.Value            = ""
            loc_oP1.txt_4c_MCOFINS.Value         = ""
            loc_oP1.txt_4c_SIR.Value             = ""
            loc_oP1.txt_4c_SCSLL.Value           = ""
            loc_oP1.txt_4c_SPIS.Value            = ""
            loc_oP1.txt_4c_SCOFINS.Value         = ""
            loc_oP1.txt_4c_AIR.Value             = ""
            loc_oP1.txt_4c_ACSLL.Value           = ""
            loc_oP1.cnt_4c_Alerta.txt_4c_Servs.Value    = ""
            loc_oP1.cnt_4c_Alerta.txt_4c_Porta.Value    = ""
            loc_oP1.cnt_4c_Alerta.txt_4c_Emailnfe.Value = ""
            loc_oP1.cnt_4c_Alerta.txt_4c_Senhas.Value   = ""

            *-- Page2
            loc_oP2.txt_4c_Impc.Value            = ""
            loc_oP2.txt_4c_Caraut.Value          = ""
            loc_oP2.txt_4c_Etiqprod.Value        = ""
            loc_oP2.obj_4c_Memo_boleto.Value     = ""
            loc_oP2.txt_4c_Tipoof.Value          = ""
            loc_oP2.obj_4c_GetPPLinha1s.Value    = ""
            loc_oP2.obj_4c_GetPPlinha2s.Value    = ""
            loc_oP2.txt_4c__CodServs.Value       = ""
            loc_oP2.txt_4c_Dservs.Value          = ""
            loc_oP2.txt_4c_Estoque.Value         = ""
            loc_oP2.txt_4c_Difpes.Value          = ""
            loc_oP2.txt_4c_Adicional.Value       = ""
            loc_oP2.txt_4c_EmpSitef.Value        = ""
            loc_oP2.txt_4c__TpTrans.Value        = ""
            loc_oP2.txt_4c_PercCreds.Value       = ""
            loc_oP2.txt_4c_PerComis.Value        = ""
            loc_oP2.txt_4c_EmpBal.Value          = ""
            loc_oP2.txt_4c_TempoSubn.Value       = ""
            loc_oP2.txt_4c_Dope_int.Value        = ""
            loc_oP2.txt_4c_DAC.Value             = ""
            loc_oP2.txt_4c_Banco.Value           = ""
            loc_oP2.txt_4c_Agenc.Value           = ""
            loc_oP2.txt_4c_Conta.Value           = ""
            loc_oP2.txt_4c_Contrato.Value        = ""
            loc_oP2.txt_4c_Agencia.Value         = ""
            loc_oP2.txt_4c_Cartao.Value          = ""
            loc_oP2.cnt_4c_EmailPad.txt_4c_Servs.Value  = ""
            loc_oP2.cnt_4c_EmailPad.txt_4c_Porta.Value  = ""
            loc_oP2.cnt_4c_EmailPad.txt_4c_Email.Value  = ""
            loc_oP2.cnt_4c_EmailPad.txt_4c_Senhas.Value = ""
            loc_oP2.txt_4c_Saicol.Value          = ""
            loc_oP2.txt_4c_Cdlsenhas.Value       = ""

            *-- Page3
            loc_oP3.txt_4c_Mctotal.Value         = ""
            loc_oP3.txt_4c_Cfo_Int.Value         = ""
            loc_oP3.txt_4c_Mrcf.Value            = ""
            loc_oP3.txt_4c__GRUPOO.Value         = ""
            loc_oP3.txt_4c__CONTAO.Value         = ""
            loc_oP3.txt_4c__GRUICMO.Value        = ""
            loc_oP3.txt_4c__CONICMO.Value        = ""
            loc_oP3.txt_4c__GRUIPIO.Value        = ""
            loc_oP3.txt_4c__CONIPIO.Value        = ""
            loc_oP3.txt_4c__GRUPISO.Value        = ""
            loc_oP3.txt_4c__CONPISO.Value        = ""
            loc_oP3.txt_4c__GRUCONO.Value        = ""
            loc_oP3.txt_4c__CONCONO.Value        = ""
            loc_oP3.txt_4c__GRUPOD.Value         = ""
            loc_oP3.txt_4c__CONTAD.Value         = ""
            loc_oP3.txt_4c__GRUICMD.Value        = ""
            loc_oP3.txt_4c__CONICMD.Value        = ""
            loc_oP3.txt_4c__GRUIPID.Value        = ""
            loc_oP3.txt_4c__CONIPID.Value        = ""
            loc_oP3.txt_4c__GRUPISD.Value        = ""
            loc_oP3.txt_4c__CONPISD.Value        = ""
            loc_oP3.txt_4c__GRUCOND.Value        = ""
            loc_oP3.txt_4c__CONCOND.Value        = ""
            loc_oP3.txt_4c__PORCPIS.Value        = ""
            loc_oP3.txt_4c__PORCCONS.Value       = ""
            loc_oP3.txt_4c_Perfil.Value          = ""
            loc_oP3.txt_4c__indicas.Value        = ""
            loc_oP3.txt_4c_REGTRIB.Value         = ""
            loc_oP3.txt_4c_Ccustos.Value         = ""
            loc_oP3.txt_4c_RegEsps.Value         = ""
            loc_oP3.txt_4c__CodOper.Value        = ""
            loc_oP3.txt_4c_Codigo.Value          = ""
            loc_oP3.txt_4c_Servs.Value           = ""
            loc_oP3.txt_4c_Porta.Value           = ""
            loc_oP3.txt_4c_Emailnfe.Value        = ""
            loc_oP3.txt_4c_Senhas.Value          = ""
            loc_oP3.txt_4c_Pastas.Value          = ""
            loc_oP3.obj_4c_Get_textonfe.Value    = ""
            loc_oP3.obj_4c_Get_textopaf.Value    = ""
            loc_oP3.txt_4c_Logo.Value            = ""
            loc_oP3.txt_4c_PastaFci.Value        = ""

            *-- Page4
            loc_oP4.txt_4c__chavep.Value         = ""
            loc_oP4.txt_4c__chavec.Value         = ""
            loc_oP4.txt_4c__csc.Value            = ""

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.LimparCampos")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oP1, loc_oP2, loc_oP3, loc_oP4
        TRY
            loc_oP1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
            loc_oP2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
            loc_oP3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
            loc_oP4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page4

            *-- Page1
            loc_oP1.txt_4c_Codigo.ReadOnly       = !par_lHabilitar
            loc_oP1.txt_4c_Numero.ReadOnly       = !par_lHabilitar
            loc_oP1.txt_4c_Cgc.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_IES.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_Razsoc.ReadOnly       = !par_lHabilitar
            loc_oP1.txt_4c_Empr.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_Nome.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_IMS.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_CNAE.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_Resp.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_Cargo.ReadOnly        = !par_lHabilitar
            loc_oP1.txt_4c_Postofiscal.ReadOnly  = !par_lHabilitar
            loc_oP1.txt_4c_EAN13.ReadOnly        = !par_lHabilitar
            loc_oP1.txt_4c_CEstoque.ReadOnly     = !par_lHabilitar
            loc_oP1.txt_4c__GRUPOC.ReadOnly      = !par_lHabilitar
            loc_oP1.txt_4c__CONTAC.ReadOnly      = !par_lHabilitar
            loc_oP1.txt_4c_CONTARLS.ReadOnly     = !par_lHabilitar
            loc_oP1.txt_4c_CodEmpresa.ReadOnly   = !par_lHabilitar
            loc_oP1.txt_4c_CodRepres.ReadOnly    = !par_lHabilitar
            loc_oP1.txt_4c_Grupo.ReadOnly        = !par_lHabilitar
            loc_oP1.txt_4c_Class.ReadOnly        = !par_lHabilitar
            loc_oP1.txt_4c_Cep.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_Pais.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_4.ReadOnly            = !par_lHabilitar
            loc_oP1.txt_4c_End.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_3.ReadOnly            = !par_lHabilitar
            loc_oP1.txt_4c_Comp.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_Bairro.ReadOnly       = !par_lHabilitar
            loc_oP1.txt_4c_Cid.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_Est.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_REGIAOS.ReadOnly      = !par_lHabilitar
            loc_oP1.txt_4c_Tel1.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_Tel2.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_Fax.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c__emails.ReadOnly      = !par_lHabilitar
            loc_oP1.txt_4c_DTCADAS.ReadOnly      = !par_lHabilitar
            loc_oP1.txt_4c_NUMPROTBX.ReadOnly    = !par_lHabilitar
            loc_oP1.txt_4c_DTPROTBX.ReadOnly     = !par_lHabilitar
            loc_oP1.txt_4c_DTENCERRAS.ReadOnly   = !par_lHabilitar
            loc_oP1.txt_4c_DTINIOPS.ReadOnly     = !par_lHabilitar
            loc_oP1.txt_4c_Fwget1.ReadOnly       = !par_lHabilitar
            loc_oP1.txt_4c_MIR.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_MCSLL.ReadOnly        = !par_lHabilitar
            loc_oP1.txt_4c_MPIS.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_MCOFINS.ReadOnly      = !par_lHabilitar
            loc_oP1.txt_4c_SIR.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_SCSLL.ReadOnly        = !par_lHabilitar
            loc_oP1.txt_4c_SPIS.ReadOnly         = !par_lHabilitar
            loc_oP1.txt_4c_SCOFINS.ReadOnly      = !par_lHabilitar
            loc_oP1.txt_4c_AIR.ReadOnly          = !par_lHabilitar
            loc_oP1.txt_4c_ACSLL.ReadOnly        = !par_lHabilitar
            loc_oP1.cnt_4c_Alerta.txt_4c_Servs.ReadOnly    = !par_lHabilitar
            loc_oP1.cnt_4c_Alerta.txt_4c_Porta.ReadOnly    = !par_lHabilitar
            loc_oP1.cnt_4c_Alerta.txt_4c_Emailnfe.ReadOnly = !par_lHabilitar
            loc_oP1.cnt_4c_Alerta.txt_4c_Senhas.ReadOnly   = !par_lHabilitar

            *-- Page2
            loc_oP2.txt_4c_Impc.ReadOnly         = !par_lHabilitar
            loc_oP2.txt_4c_Caraut.ReadOnly       = !par_lHabilitar
            loc_oP2.txt_4c_Etiqprod.ReadOnly     = !par_lHabilitar
            loc_oP2.txt_4c_Tipoof.ReadOnly       = !par_lHabilitar
            loc_oP2.txt_4c__CodServs.ReadOnly    = !par_lHabilitar
            loc_oP2.txt_4c_Dservs.ReadOnly       = !par_lHabilitar
            loc_oP2.txt_4c_Estoque.ReadOnly      = !par_lHabilitar
            loc_oP2.txt_4c_Difpes.ReadOnly       = !par_lHabilitar
            loc_oP2.txt_4c_Adicional.ReadOnly    = !par_lHabilitar
            loc_oP2.txt_4c_EmpSitef.ReadOnly     = !par_lHabilitar
            loc_oP2.txt_4c__TpTrans.ReadOnly     = !par_lHabilitar
            loc_oP2.txt_4c_PercCreds.ReadOnly    = !par_lHabilitar
            loc_oP2.txt_4c_PerComis.ReadOnly     = !par_lHabilitar
            loc_oP2.txt_4c_EmpBal.ReadOnly       = !par_lHabilitar
            loc_oP2.txt_4c_TempoSubn.ReadOnly    = !par_lHabilitar
            loc_oP2.txt_4c_Dope_int.ReadOnly     = !par_lHabilitar
            loc_oP2.txt_4c_DAC.ReadOnly          = !par_lHabilitar
            loc_oP2.txt_4c_Banco.ReadOnly        = !par_lHabilitar
            loc_oP2.txt_4c_Agenc.ReadOnly        = !par_lHabilitar
            loc_oP2.txt_4c_Conta.ReadOnly        = !par_lHabilitar
            loc_oP2.txt_4c_Contrato.ReadOnly     = !par_lHabilitar
            loc_oP2.txt_4c_Agencia.ReadOnly      = !par_lHabilitar
            loc_oP2.txt_4c_Cartao.ReadOnly       = !par_lHabilitar
            loc_oP2.cnt_4c_EmailPad.txt_4c_Servs.ReadOnly  = !par_lHabilitar
            loc_oP2.cnt_4c_EmailPad.txt_4c_Porta.ReadOnly  = !par_lHabilitar
            loc_oP2.cnt_4c_EmailPad.txt_4c_Email.ReadOnly  = !par_lHabilitar
            loc_oP2.cnt_4c_EmailPad.txt_4c_Senhas.ReadOnly = !par_lHabilitar
            loc_oP2.txt_4c_Saicol.ReadOnly       = !par_lHabilitar
            loc_oP2.txt_4c_Cdlsenhas.ReadOnly    = !par_lHabilitar

            *-- Page3
            loc_oP3.txt_4c_Mctotal.ReadOnly      = !par_lHabilitar
            loc_oP3.txt_4c_Cfo_Int.ReadOnly      = !par_lHabilitar
            loc_oP3.txt_4c_Mrcf.ReadOnly         = !par_lHabilitar
            loc_oP3.txt_4c__GRUPOO.ReadOnly      = !par_lHabilitar
            loc_oP3.txt_4c__CONTAO.ReadOnly      = !par_lHabilitar
            loc_oP3.txt_4c__GRUICMO.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__CONICMO.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__GRUIPIO.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__CONIPIO.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__GRUPISO.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__CONPISO.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__GRUCONO.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__CONCONO.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__GRUPOD.ReadOnly      = !par_lHabilitar
            loc_oP3.txt_4c__CONTAD.ReadOnly      = !par_lHabilitar
            loc_oP3.txt_4c__GRUICMD.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__CONICMD.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__GRUIPID.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__CONIPID.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__GRUPISD.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__CONPISD.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__GRUCOND.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__CONCOND.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__PORCPIS.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c__PORCCONS.ReadOnly    = !par_lHabilitar
            loc_oP3.txt_4c_Perfil.ReadOnly       = !par_lHabilitar
            loc_oP3.txt_4c__indicas.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c_REGTRIB.ReadOnly      = !par_lHabilitar
            loc_oP3.txt_4c_Ccustos.ReadOnly      = !par_lHabilitar
            loc_oP3.txt_4c_RegEsps.ReadOnly      = !par_lHabilitar
            loc_oP3.txt_4c__CodOper.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c_Codigo.ReadOnly       = !par_lHabilitar
            loc_oP3.txt_4c_Servs.ReadOnly        = !par_lHabilitar
            loc_oP3.txt_4c_Porta.ReadOnly        = !par_lHabilitar
            loc_oP3.txt_4c_Emailnfe.ReadOnly     = !par_lHabilitar
            loc_oP3.txt_4c_Senhas.ReadOnly       = !par_lHabilitar
            loc_oP3.txt_4c_Pastas.ReadOnly       = !par_lHabilitar
            loc_oP3.txt_4c_Logo.ReadOnly         = !par_lHabilitar
            loc_oP3.txt_4c_PastaFci.ReadOnly     = !par_lHabilitar

            *-- Page4
            loc_oP4.txt_4c__chavep.ReadOnly      = !par_lHabilitar
            loc_oP4.txt_4c__chavec.ReadOnly      = !par_lHabilitar
            loc_oP4.txt_4c__csc.ReadOnly         = !par_lHabilitar

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarSubPage1 - Adiciona campos da Page1: identificacao ate separador
    * Cobre: chkEsc, Codigo, Numero, CPF/CNPJ, CGC, IE, Situacao,
    *        RazaoSocial, IM, NomeReduzido, NomeFantasia, CNAE, GrupoEmp,
    *        Responsavel, PostoFiscal, ClassificacaoEmp, Cargo, EAN13, CEstoque,
    *        GrupoCOTEP, ContaCOTEP, ContaXEmp, CodInterno, AnaVends, CodRegional
    *===========================================================================
    PROCEDURE ConfigurarSubPage1(par_oPagina)
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Page1

        *-- CheckBox Escritorio
        loc_oCnt.AddObject("chk_4c_ChkEsc", "CheckBox")
        WITH loc_oCnt.chk_4c_ChkEsc
            .Top      = 118
            .Left     = 911
            .Width    = 65
            .Height   = 15
            .Caption  = "Escrit" + CHR(243) + "rio"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Linha 1: Codigo / Numero / CPF-CNPJ / CGC / IE / Situacao
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top      = 139
            .Left     = 95
            .Width    = 42
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "C" + CHR(243) + "digo :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oCnt.txt_4c_Codigo
            .Top      = 135
            .Left     = 139
            .Width    = 31
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oCnt.lbl_4c_Label24
            .Top      = 139
            .Left     = 176
            .Width    = 46
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "N" + CHR(250) + "mero :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Numero", "TextBox")
        WITH loc_oCnt.txt_4c_Numero
            .Top      = 135
            .Left     = 232
            .Width    = 31
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_OpcaoCPFCGC", "OptionGroup")
        WITH loc_oCnt.obj_4c_OpcaoCPFCGC
            .Top         = 137
            .Left        = 269
            .Width       = 99
            .Height      = 20
            .ButtonCount = 2
            .Value       = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption  = "CPF"
                .Value    = 0
                .Top      = 0
                .Left     = 0
                .Width    = 47
                .Height   = 20
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "CNPJ"
                .Value    = 0
                .Top      = 0
                .Left     = 49
                .Width    = 50
                .Height   = 20
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cgc", "TextBox")
        WITH loc_oCnt.txt_4c_Cgc
            .Top      = 135
            .Left     = 367
            .Width    = 132
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oCnt.lbl_4c_Label23
            .Top      = 141
            .Left     = 567
            .Width    = 19
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "IE :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_IES", "TextBox")
        WITH loc_oCnt.txt_4c_IES
            .Top      = 137
            .Left     = 588
            .Width    = 115
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oCnt.lbl_4c_Label26
            .Top      = 141
            .Left     = 809
            .Width    = 75
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Situa" + CHR(231) + CHR(227) + "o :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("cbo_4c_FWCOMBO1", "ComboBox")
        WITH loc_oCnt.cbo_4c_FWCOMBO1
            .Top           = 137
            .Left          = 861
            .Width         = 115
            .Height        = 22
            .RowSourceType = 1
            .RowSource     = "A,I"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 2: Razao Social / IM / Nome Reduzido
        loc_oCnt.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oCnt.lbl_4c_Label16
            .Top      = 164
            .Left     = 68
            .Width    = 100
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Raz" + CHR(227) + "o Social :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Razsoc", "TextBox")
        WITH loc_oCnt.txt_4c_Razsoc
            .Top      = 160
            .Left     = 139
            .Width    = 360
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oCnt.lbl_4c_Label34
            .Top      = 166
            .Left     = 565
            .Width    = 21
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "IM :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_IMS", "TextBox")
        WITH loc_oCnt.txt_4c_IMS
            .Top      = 162
            .Left     = 588
            .Width    = 115
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oCnt.lbl_4c_Label15
            .Top      = 166
            .Left     = 776
            .Width    = 110
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Nome Reduzido :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Empr", "TextBox")
        WITH loc_oCnt.txt_4c_Empr
            .Top      = 162
            .Left     = 861
            .Width    = 115
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Linha 3: Nome Fantasia / CNAE / Grupo Empresarial
        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top      = 189
            .Left     = 57
            .Width    = 110
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Nome Fantasia :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Nome", "TextBox")
        WITH loc_oCnt.txt_4c_Nome
            .Top      = 185
            .Left     = 139
            .Width    = 360
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .Top      = 191
            .Left     = 550
            .Width    = 36
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "CNAE :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CNAE", "TextBox")
        WITH loc_oCnt.txt_4c_CNAE
            .Top      = 187
            .Left     = 588
            .Width    = 115
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oCnt.lbl_4c_Label29
            .Top      = 191
            .Left     = 763
            .Width    = 130
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Grupo Empresarial :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Top      = 187
            .Left     = 861
            .Width    = 115
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Grupo, "KeyPress", THIS, "KeyPressGrupoEmp")

        *-- Linha 4: Responsavel / Posto Fiscal / Classificacao Empresarial
        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Top      = 213
            .Left     = 67
            .Width    = 70
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Respons" + CHR(225) + "vel :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Resp", "TextBox")
        WITH loc_oCnt.txt_4c_Resp
            .Top      = 210
            .Left     = 139
            .Width    = 360
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oCnt.lbl_4c_Label25
            .Top      = 216
            .Left     = 521
            .Width    = 65
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Posto Fiscal :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Postofiscal", "TextBox")
        WITH loc_oCnt.txt_4c_Postofiscal
            .Top      = 212
            .Left     = 588
            .Width    = 115
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oCnt.lbl_4c_Label30
            .Top      = 216
            .Left     = 731
            .Width    = 180
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Classifica" + CHR(231) + CHR(227) + "o Empresarial :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Class", "TextBox")
        WITH loc_oCnt.txt_4c_Class
            .Top      = 212
            .Left     = 861
            .Width    = 115
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Class, "KeyPress", THIS, "KeyPressClassEmp")

        *-- Linha 5: Cargo Responsavel / EAN13 / Conta Estoque / CmdCtaCtg
        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Top      = 239
            .Left     = 35
            .Width    = 102
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Cargo Respons" + CHR(225) + "vel :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cargo", "TextBox")
        WITH loc_oCnt.txt_4c_Cargo
            .Top      = 235
            .Left     = 139
            .Width    = 360
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oCnt.lbl_4c_Label27
            .Top      = 241
            .Left     = 545
            .Width    = 41
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "EAN13 :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_EAN13", "TextBox")
        WITH loc_oCnt.txt_4c_EAN13
            .Top      = 237
            .Left     = 588
            .Width    = 115
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label52", "Label")
        WITH loc_oCnt.lbl_4c_Label52
            .Top      = 241
            .Left     = 764
            .Width    = 95
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Conta de Estoque :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CEstoque", "TextBox")
        WITH loc_oCnt.txt_4c_CEstoque
            .Top      = 237
            .Left     = 861
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_CmdCtaCtg", "CommandButton")
        WITH loc_oCnt.cmd_4c_CmdCtaCtg
            .Top          = 237
            .Left         = 943
            .Width        = 46
            .Height       = 46
            .Caption      = "Contas"
            .FontName     = "Tahoma"
            .FontSize     = 8
            .Themes       = .T.
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_CmdCtaCtg, "Click", THIS, "CmdCtaCtgClick")

        *-- Linha 6: Grupo/Conta COTEP / Conta x Emp / Cod Interno / Regional
        loc_oCnt.AddObject("lbl_4c_Label32", "Label")
        WITH loc_oCnt.lbl_4c_Label32
            .Top      = 264
            .Left     = 30
            .Width    = 107
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Grupo/Conta COTEP :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__GRUPOC", "TextBox")
        WITH loc_oCnt.txt_4c__GRUPOC
            .Top      = 260
            .Left     = 139
            .Width    = 87
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUPOC, "KeyPress", THIS, "KeyPressGrupoCC")

        loc_oCnt.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oCnt.lbl_4c_Label21
            .Top      = 264
            .Left     = 228
            .Width    = 8
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "/"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__CONTAC", "TextBox")
        WITH loc_oCnt.txt_4c__CONTAC
            .Top      = 260
            .Left     = 236
            .Width    = 87
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONTAC, "KeyPress", THIS, "KeyPressContaC")

        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .Top      = 264
            .Left     = 328
            .Width    = 70
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Conta x Emp :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CONTARLS", "TextBox")
        WITH loc_oCnt.txt_4c_CONTARLS
            .Top      = 260
            .Left     = 412
            .Width    = 87
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_CONTARLS, "KeyPress", THIS, "KeyPressContarls")

        loc_oCnt.AddObject("lbl_4c_Label46", "Label")
        WITH loc_oCnt.lbl_4c_Label46
            .Top      = 266
            .Left     = 521
            .Width    = 65
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Cod Interno :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CodEmpresa", "TextBox")
        WITH loc_oCnt.txt_4c_CodEmpresa
            .Top      = 262
            .Left     = 588
            .Width    = 53
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label53", "Label")
        WITH loc_oCnt.lbl_4c_Label53
            .Top      = 266
            .Left     = 787
            .Width    = 72
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Cod Regional :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CodRepres", "TextBox")
        WITH loc_oCnt.txt_4c_CodRepres
            .Top      = 262
            .Left     = 862
            .Width    = 48
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Linha 7: CEP / Pais / No Horas Fuso (top=292)
        loc_oCnt.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oCnt.lbl_4c_Label11
            .Top      = 296
            .Left     = 109
            .Width    = 28
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "CEP :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cep", "TextBox")
        WITH loc_oCnt.txt_4c_Cep
            .Top      = 292
            .Left     = 139
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oCnt.lbl_4c_Label19
            .Top      = 296
            .Left     = 231
            .Width    = 28
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Pa" + CHR(237) + "s :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Pais", "TextBox")
        WITH loc_oCnt.txt_4c_Pais
            .Top      = 292
            .Left     = 261
            .Width    = 204
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oCnt.lbl_4c_Label7
            .Top      = 296
            .Left     = 523
            .Width    = 86
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "N" + CHR(186) + " Horas (Fuso) :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_4", "TextBox")
        WITH loc_oCnt.txt_4c_4
            .Top      = 292
            .Left     = 611
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Linha 8: Endereco / Numero
        loc_oCnt.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCnt.lbl_4c_Label8
            .Top      = 319
            .Left     = 83
            .Width    = 54
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Endere" + CHR(231) + "o :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_End", "TextBox")
        WITH loc_oCnt.txt_4c_End
            .Top      = 316
            .Left     = 139
            .Width    = 407
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oCnt.lbl_4c_Label17
            .Top      = 319
            .Left     = 563
            .Width    = 46
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "N" + CHR(250) + "mero :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_3", "TextBox")
        WITH loc_oCnt.txt_4c_3
            .Top      = 316
            .Left     = 611
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Linha 9: Complemento / Bairro
        loc_oCnt.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oCnt.lbl_4c_Label20
            .Top      = 343
            .Left     = 63
            .Width    = 74
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Complemento :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Comp", "TextBox")
        WITH loc_oCnt.txt_4c_Comp
            .Top      = 340
            .Left     = 139
            .Width    = 240
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oCnt.lbl_4c_Label9
            .Top      = 344
            .Left     = 572
            .Width    = 37
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Bairro :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Bairro", "TextBox")
        WITH loc_oCnt.txt_4c_Bairro
            .Top      = 340
            .Left     = 611
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Linha 10: Cidade / UF / Regiao
        loc_oCnt.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oCnt.lbl_4c_Label10
            .Top      = 368
            .Left     = 95
            .Width    = 42
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Cidade :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cid", "TextBox")
        WITH loc_oCnt.txt_4c_Cid
            .Top      = 364
            .Left     = 139
            .Width    = 240
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oCnt.lbl_4c_Label12
            .Top      = 368
            .Left     = 409
            .Width    = 22
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "UF :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Est", "TextBox")
        WITH loc_oCnt.txt_4c_Est
            .Top       = 364
            .Left      = 433
            .Width     = 25
            .Height    = 22
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Est, "KeyPress", THIS, "KeyPressUF")

        loc_oCnt.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oCnt.lbl_4c_Label38
            .Top      = 368
            .Left     = 567
            .Width    = 42
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Regi" + CHR(227) + "o :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_REGIAOS", "TextBox")
        WITH loc_oCnt.txt_4c_REGIAOS
            .Top      = 364
            .Left     = 611
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_REGIAOS, "KeyPress", THIS, "KeyPressRegiao")

        *-- Linha 11: Telefones
        loc_oCnt.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oCnt.lbl_4c_Label13
            .Top      = 391
            .Left     = 81
            .Width    = 56
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Telefones :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Tel1", "TextBox")
        WITH loc_oCnt.txt_4c_Tel1
            .Top      = 388
            .Left     = 139
            .Width    = 183
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Tel2", "TextBox")
        WITH loc_oCnt.txt_4c_Tel2
            .Top      = 388
            .Left     = 324
            .Width    = 182
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Fax", "TextBox")
        WITH loc_oCnt.txt_4c_Fax
            .Top      = 388
            .Left     = 508
            .Width    = 183
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Linha 12: Email
        loc_oCnt.AddObject("lbl_4c_Label36", "Label")
        WITH loc_oCnt.lbl_4c_Label36
            .Top      = 415
            .Left     = 100
            .Width    = 37
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "e-mail :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__emails", "TextBox")
        WITH loc_oCnt.txt_4c__emails
            .Top      = 412
            .Left     = 139
            .Width    = 552
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Datas
        loc_oCnt.AddObject("lbl_4c_Label45", "Label")
        WITH loc_oCnt.lbl_4c_Label45
            .Top      = 449
            .Left     = 54
            .Width    = 83
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Cadastramento :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DTCADAS", "TextBox")
        WITH loc_oCnt.txt_4c_DTCADAS
            .Top      = 445
            .Left     = 139
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label49", "Label")
        WITH loc_oCnt.lbl_4c_Label49
            .Top      = 449
            .Left     = 254
            .Width    = 139
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Protocolo Baixa Fazend" + CHR(225) + "ria :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_NUMPROTBX", "TextBox")
        WITH loc_oCnt.txt_4c_NUMPROTBX
            .Top      = 445
            .Left     = 395
            .Width    = 66
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label50", "Label")
        WITH loc_oCnt.lbl_4c_Label50
            .Top      = 449
            .Left     = 488
            .Width    = 80
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Data Protocolo :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DTPROTBX", "TextBox")
        WITH loc_oCnt.txt_4c_DTPROTBX
            .Top      = 445
            .Left     = 570
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label48", "Label")
        WITH loc_oCnt.lbl_4c_Label48
            .Top      = 473
            .Left     = 61
            .Width    = 76
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Encerramento :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DTENCERRAS", "TextBox")
        WITH loc_oCnt.txt_4c_DTENCERRAS
            .Top      = 469
            .Left     = 139
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label5b", "Label")
        WITH loc_oCnt.lbl_4c_Label5b
            .Top      = 295
            .Left     = 508
            .Width    = 93
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Regime Tribut" + CHR(225) + "rio :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("cbo_4c_CmbRegime", "ComboBox")
        WITH loc_oCnt.cbo_4c_CmbRegime
            .Top           = 469
            .Left          = 395
            .Width         = 140
            .Height        = 22
            .RowSourceType = 1
            .RowSource     = "Simples Nacional,Lucro Presumido,Lucro Real,MEI"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label47", "Label")
        WITH loc_oCnt.lbl_4c_Label47
            .Top      = 498
            .Left     = 38
            .Width    = 99
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "In" + CHR(237) + "cio de Opera" + CHR(231) + CHR(227) + "o :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DTINIOPS", "TextBox")
        WITH loc_oCnt.txt_4c_DTINIOPS
            .Top      = 494
            .Left     = 139
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label51", "Label")
        WITH loc_oCnt.lbl_4c_Label51
            .Top      = 498
            .Left     = 264
            .Width    = 128
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Al" + CHR(237) + "quota Simples Nacional :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Fwget1", "TextBox")
        WITH loc_oCnt.txt_4c_Fwget1
            .Top      = 495
            .Left     = 395
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Bloco de aliquotas (Mercadorias / Servicos / Aliquotas)
        loc_oCnt.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oCnt.lbl_4c_Label22
            .Top      = 472
            .Left     = 695
            .Width    = 70
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Mercadorias"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label40", "Label")
        WITH loc_oCnt.lbl_4c_Label40
            .Top      = 472
            .Left     = 813
            .Width    = 50
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Servi" + CHR(231) + "os"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label41", "Label")
        WITH loc_oCnt.lbl_4c_Label41
            .Top      = 472
            .Left     = 914
            .Width    = 60
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Al" + CHR(237) + "quotas"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oCnt.lbl_4c_Label28
            .Top      = 495
            .Left     = 720
            .Width    = 15
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "IR"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oCnt.lbl_4c_Label31
            .Top      = 518
            .Left     = 708
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "CSLL"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oCnt.lbl_4c_Label14
            .Top      = 541
            .Left     = 715
            .Width    = 20
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "PIS"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oCnt.lbl_4c_Label18
            .Top      = 564
            .Left     = 693
            .Width    = 42
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "COFINS"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label37", "Label")
        WITH loc_oCnt.lbl_4c_Label37
            .Top      = 495
            .Left     = 827
            .Width    = 15
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "IR"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oCnt.lbl_4c_Label39
            .Top      = 518
            .Left     = 815
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "CSLL"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label33", "Label")
        WITH loc_oCnt.lbl_4c_Label33
            .Top      = 541
            .Left     = 822
            .Width    = 20
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "PIS"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oCnt.lbl_4c_Label35
            .Top      = 564
            .Left     = 800
            .Width    = 42
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "COFINS"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label42", "Label")
        WITH loc_oCnt.lbl_4c_Label42
            .Top      = 497
            .Left     = 920
            .Width    = 15
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "IR"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label43", "Label")
        WITH loc_oCnt.lbl_4c_Label43
            .Top      = 520
            .Left     = 908
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "CSLL"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Mercadorias
        loc_oCnt.AddObject("txt_4c_MIR", "TextBox")
        WITH loc_oCnt.txt_4c_MIR
            .Top      = 493
            .Left     = 735
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_MCSLL", "TextBox")
        WITH loc_oCnt.txt_4c_MCSLL
            .Top      = 516
            .Left     = 735
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_MPIS", "TextBox")
        WITH loc_oCnt.txt_4c_MPIS
            .Top      = 539
            .Left     = 735
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_MCOFINS", "TextBox")
        WITH loc_oCnt.txt_4c_MCOFINS
            .Top      = 562
            .Left     = 735
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Servicos
        loc_oCnt.AddObject("txt_4c_SIR", "TextBox")
        WITH loc_oCnt.txt_4c_SIR
            .Top      = 493
            .Left     = 842
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_SCSLL", "TextBox")
        WITH loc_oCnt.txt_4c_SCSLL
            .Top      = 516
            .Left     = 842
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_SPIS", "TextBox")
        WITH loc_oCnt.txt_4c_SPIS
            .Top      = 539
            .Left     = 842
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_SCOFINS", "TextBox")
        WITH loc_oCnt.txt_4c_SCOFINS
            .Top      = 562
            .Left     = 842
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Aliquotas (colunas)
        loc_oCnt.AddObject("txt_4c_AIR", "TextBox")
        WITH loc_oCnt.txt_4c_AIR
            .Top      = 493
            .Left     = 935
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_ACSLL", "TextBox")
        WITH loc_oCnt.txt_4c_ACSLL
            .Top      = 516
            .Left     = 935
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Container cntAlerta (Dados email Alerta)
        loc_oCnt.AddObject("cnt_4c_Alerta", "Container")
        WITH loc_oCnt.cnt_4c_Alerta
            .Top         = 291
            .Left        = 693
            .Width       = 303
            .Height      = 143
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Alerta.AddObject("lbl_4c_Label46", "Label")
        WITH loc_oCnt.cnt_4c_Alerta.lbl_4c_Label46
            .Top      = 2
            .Left     = 3
            .Width    = 120
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Dados email Alerta"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Alerta.AddObject("lbl_4c_Label54", "Label")
        WITH loc_oCnt.cnt_4c_Alerta.lbl_4c_Label54
            .Top      = 20
            .Left     = 3
            .Width    = 71
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Servidor SMTP"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Alerta.AddObject("txt_4c_Servs", "TextBox")
        WITH loc_oCnt.cnt_4c_Alerta.txt_4c_Servs
            .Top      = 35
            .Left     = 3
            .Width    = 187
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Alerta.AddObject("lbl_4c_Label55", "Label")
        WITH loc_oCnt.cnt_4c_Alerta.lbl_4c_Label55
            .Top      = 19
            .Left     = 209
            .Width    = 57
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Porta SMTP"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Alerta.AddObject("txt_4c_Porta", "TextBox")
        WITH loc_oCnt.cnt_4c_Alerta.txt_4c_Porta
            .Top      = 34
            .Left     = 209
            .Width    = 28
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Alerta.AddObject("lbl_4c_Label52", "Label")
        WITH loc_oCnt.cnt_4c_Alerta.lbl_4c_Label52
            .Top      = 61
            .Left     = 3
            .Width    = 80
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Email para envio"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Alerta.AddObject("txt_4c_Emailnfe", "TextBox")
        WITH loc_oCnt.cnt_4c_Alerta.txt_4c_Emailnfe
            .Top      = 75
            .Left     = 3
            .Width    = 298
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Alerta.AddObject("lbl_4c_Label53", "Label")
        WITH loc_oCnt.cnt_4c_Alerta.lbl_4c_Label53
            .Top      = 103
            .Left     = 3
            .Width    = 80
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Senha do e_mail"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Alerta.AddObject("txt_4c_Senhas", "TextBox")
        WITH loc_oCnt.cnt_4c_Alerta.txt_4c_Senhas
            .Top      = 117
            .Left     = 3
            .Width    = 298
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * KeyPressGrupoEmp - F4/F5: lookup Grupo Empresarial (SigCdGre.grupo)
    *===========================================================================
    PROCEDURE KeyPressGrupoEmp(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdGre", "grupo", "gruclass", ;
                    "Grupo Empresarial", "", ;
                    ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressGrupoEmp")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressClassEmp - F4/F5: lookup Classificacao Empresarial (SigCdGre.class)
    *===========================================================================
    PROCEDURE KeyPressClassEmp(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdGre", "class", "gruclass", ;
                    "Classifica" + CHR(231) + CHR(227) + "o Empresarial", "", ;
                    ALLTRIM(loc_oCnt.txt_4c_Class.Value))
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        loc_oCnt.txt_4c_Class.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressClassEmp")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressGrupoCC - F4/F5: lookup Grupo COTEP (SigCdGcr.Codigos)
    *===========================================================================
    PROCEDURE KeyPressGrupoCC(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdGcr", "Codigos", "descrs", ;
                    "Grupo COTEP", "", ;
                    ALLTRIM(loc_oCnt.txt_4c__GRUPOC.Value))
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        loc_oCnt.txt_4c__GRUPOC.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressGrupoCC")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressContaC - F4/F5: lookup Conta COTEP (SIGSYACC.cdcontas)
    *===========================================================================
    PROCEDURE KeyPressContaC(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SIGSYACC", "cdcontas", "grcontas", ;
                    "Conta COTEP", "", ;
                    ALLTRIM(loc_oCnt.txt_4c__CONTAC.Value))
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        loc_oCnt.txt_4c__CONTAC.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressContaC")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressContarls - F4/F5: lookup Conta x Emp (SIGSYACC.cdcontas)
    *===========================================================================
    PROCEDURE KeyPressContarls(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SIGSYACC", "cdcontas", "grcontas", ;
                    "Conta x Emp", "", ;
                    ALLTRIM(loc_oCnt.txt_4c_CONTARLS.Value))
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        loc_oCnt.txt_4c_CONTARLS.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressContarls")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * CmdCtaCtgClick - Abre cadastro de contas contabeis (SigCtCtg)
    *===========================================================================
    PROCEDURE CmdCtaCtgClick
        LOCAL loc_oCnt, loc_cCodEmp
        TRY
            loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
            loc_cCodEmp = ALLTRIM(loc_oCnt.txt_4c_Codigo.Value)
            IF EMPTY(loc_cCodEmp)
                MsgAviso("Selecione uma empresa antes de abrir Contas Cont" + CHR(225) + "beis.")
            ELSE
                MsgAviso("Cadastro de Contas Cont" + CHR(225) + "beis n" + CHR(227) + "o migrado ainda." + CHR(13) + ;
                    "Empresa: " + loc_cCodEmp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formemp.CmdCtaCtgClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarSubPage2 - Aba Operacional: impressora, boleto, PinPad, etc.
    *===========================================================================
    PROCEDURE ConfigurarSubPage2(par_oPagina)
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Page2

        *-- Imprime Carne / Numeracao Automatica
        loc_oCnt.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oCnt.lbl_4c_Label17
            .Top      = 95
            .Left     = 116
            .Width    = 79
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Imprime Carn" + CHR(233) + " :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Impc", "TextBox")
        WITH loc_oCnt.txt_4c_Impc
            .Top       = 91
            .Left      = 197
            .Width     = 15
            .Height    = 24
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oCnt.lbl_4c_Label18
            .Top      = 96
            .Left     = 216
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "[S/N]"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oCnt.lbl_4c_Label16
            .Top      = 121
            .Left     = 43
            .Width    = 152
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Carne Numera" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Caraut", "TextBox")
        WITH loc_oCnt.txt_4c_Caraut
            .Top       = 117
            .Left      = 197
            .Width     = 15
            .Height    = 24
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oCnt.lbl_4c_Label19
            .Top      = 122
            .Left     = 216
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "[S/N]"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Obs. Etiquetas de Produto
        loc_oCnt.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oCnt.lbl_4c_Label22
            .Top      = 147
            .Left     = 59
            .Width    = 136
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Obs. Etiquetas de Produto :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Etiqprod", "TextBox")
        WITH loc_oCnt.txt_4c_Etiqprod
            .Top       = 143
            .Left      = 197
            .Width     = 15
            .Height    = 24
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oCnt.lbl_4c_Label23
            .Top      = 148
            .Left     = 216
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "[S/N]"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Tipo Of
        loc_oCnt.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oCnt.lbl_4c_Label13
            .Top      = 173
            .Left     = 147
            .Width    = 48
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Tipo Of. :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Tipoof", "TextBox")
        WITH loc_oCnt.txt_4c_Tipoof
            .Top       = 169
            .Left      = 197
            .Width     = 15
            .Height    = 24
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oCnt.lbl_4c_Label21
            .Top      = 174
            .Left     = 216
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "[A/B]"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Observacao do Boleto
        loc_oCnt.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oCnt.lbl_4c_Label24
            .Top      = 96
            .Left     = 314
            .Width    = 115
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Observa" + CHR(231) + CHR(227) + "o do Boleto :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Memo_boleto", "EditBox")
        WITH loc_oCnt.obj_4c_Memo_boleto
            .Top      = 91
            .Left     = 430
            .Width    = 493
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- PinPad Msg 1 / 2
        loc_oCnt.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oCnt.lbl_4c_Label30
            .Top      = 122
            .Left     = 350
            .Width    = 79
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "PinPad - Msg 1 :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_GetPPLinha1s", "EditBox")
        WITH loc_oCnt.obj_4c_GetPPLinha1s
            .Top      = 117
            .Left     = 430
            .Width    = 493
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oCnt.lbl_4c_Label15
            .Top      = 148
            .Left     = 350
            .Width    = 79
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "PinPad - Msg 2 :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_GetPPlinha2s", "EditBox")
        WITH loc_oCnt.obj_4c_GetPPlinha2s
            .Top      = 143
            .Left     = 430
            .Width    = 493
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Cod. Servico de Saida / Desc
        loc_oCnt.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oCnt.lbl_4c_Label9
            .Top      = 174
            .Left     = 315
            .Width    = 114
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "C" + CHR(243) + "d. Servi" + CHR(231) + "o de Sa" + CHR(237) + "da :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__CodServs", "TextBox")
        WITH loc_oCnt.txt_4c__CodServs
            .Top      = 169
            .Left     = 430
            .Width    = 80
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CodServs, "KeyPress", THIS, "KeyPressCodServs")

        loc_oCnt.AddObject("txt_4c_Dservs", "TextBox")
        WITH loc_oCnt.txt_4c_Dservs
            .Top      = 169
            .Left     = 512
            .Width    = 411
            .Height   = 24
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Estoque / Diferenca Pesagem / Adicional
        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .Top      = 199
            .Left     = 147
            .Width    = 48
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Estoque :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Estoque", "TextBox")
        WITH loc_oCnt.txt_4c_Estoque
            .Top       = 196
            .Left      = 197
            .Width     = 15
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oCnt.lbl_4c_Label20
            .Top      = 200
            .Left     = 216
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "[S/N]"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label36", "Label")
        WITH loc_oCnt.lbl_4c_Label36
            .Top      = 224
            .Left     = 42
            .Width    = 153
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Analisa Diferen" + CHR(231) + "a de Pesagem :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Difpes", "TextBox")
        WITH loc_oCnt.txt_4c_Difpes
            .Top       = 221
            .Left      = 197
            .Width     = 15
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label37", "Label")
        WITH loc_oCnt.lbl_4c_Label37
            .Top      = 225
            .Left     = 217
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "[S/N]"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top      = 249
            .Left     = 60
            .Width    = 136
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Adicional Entrega Servi" + CHR(231) + "os :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Adicional", "TextBox")
        WITH loc_oCnt.txt_4c_Adicional
            .Top      = 246
            .Left     = 197
            .Width    = 24
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Top      = 249
            .Left     = 225
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Dias."
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Empresa OS
        loc_oCnt.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oCnt.lbl_4c_Label14
            .Top      = 274
            .Left     = 108
            .Width    = 87
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Empresa de OSs :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_EmpBal", "TextBox")
        WITH loc_oCnt.txt_4c_EmpBal
            .Top       = 271
            .Left      = 197
            .Width     = 36
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Qtde Minutos Subnivel
        loc_oCnt.AddObject("lbl_4c_Label41", "Label")
        WITH loc_oCnt.lbl_4c_Label41
            .Top      = 296
            .Left     = 49
            .Width    = 146
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Qtde de Minutos do Subn" + CHR(237) + "vel :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TempoSubn", "TextBox")
        WITH loc_oCnt.txt_4c_TempoSubn
            .Top      = 296
            .Left     = 197
            .Width    = 55
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Empresa Sitef
        loc_oCnt.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oCnt.lbl_4c_Label25
            .Top      = 200
            .Left     = 354
            .Width    = 75
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Empresa Sitef :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_EmpSitef", "TextBox")
        WITH loc_oCnt.txt_4c_EmpSitef
            .Top      = 195
            .Left     = 430
            .Width    = 36
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Tipo Transporte
        loc_oCnt.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCnt.lbl_4c_Label8
            .Top      = 225
            .Left     = 344
            .Width    = 85
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Tipo Transporte :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__TpTrans", "TextBox")
        WITH loc_oCnt.txt_4c__TpTrans
            .Top      = 221
            .Left     = 430
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__TpTrans, "KeyPress", THIS, "KeyPressTpTrans")

        *-- Credito de Bonus
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top      = 250
            .Left     = 338
            .Width    = 90
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Cr" + CHR(233) + "dito de B" + CHR(244) + "nus :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PercCreds", "TextBox")
        WITH loc_oCnt.txt_4c_PercCreds
            .Top      = 246
            .Left     = 430
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oCnt.lbl_4c_Label35
            .Top      = 250
            .Left     = 485
            .Width    = 15
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "%"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Comissao de Vendedores / %
        loc_oCnt.AddObject("lbl_4c_Label42", "Label")
        WITH loc_oCnt.lbl_4c_Label42
            .Top      = 274
            .Left     = 300
            .Width    = 129
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Comiss" + CHR(227) + "o de Vendedores :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PerComis", "TextBox")
        WITH loc_oCnt.txt_4c_PerComis
            .Top      = 270
            .Left     = 430
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label44", "Label")
        WITH loc_oCnt.lbl_4c_Label44
            .Top      = 274
            .Left     = 485
            .Width    = 15
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "%"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Calculo de Custo (OptionGroup)
        loc_oCnt.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oCnt.lbl_4c_Label11
            .Top      = 239
            .Left     = 610
            .Width    = 89
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "C" + CHR(225) + "lculo de Custo :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_OPTCALCCUSTOS", "OptionGroup")
        WITH loc_oCnt.obj_4c_OPTCALCCUSTOS
            .Top         = 235
            .Left        = 699
            .Width       = 214
            .Height      = 23
            .ButtonCount = 2
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption  = "Tabela"
                .Value    = 0
                .Top      = 0
                .Left     = 0
                .Width    = 107
                .Height   = 23
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "M" + CHR(233) + "dia"
                .Value    = 0
                .Top      = 0
                .Left     = 107
                .Width    = 107
                .Height   = 23
                .AutoSize = .F.
            ENDWITH
        ENDWITH

        *-- Comissao por (OptionGroup)
        loc_oCnt.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oCnt.lbl_4c_Label27
            .Top      = 220
            .Left     = 626
            .Width    = 73
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Comiss" + CHR(227) + "o por :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Opc_comis", "OptionGroup")
        WITH loc_oCnt.obj_4c_Opc_comis
            .Top         = 215
            .Left        = 698
            .Width       = 222
            .Height      = 25
            .ButtonCount = 2
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption  = "Venda"
                .Value    = 0
                .Top      = 0
                .Left     = 0
                .Width    = 111
                .Height   = 25
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Recebimento"
                .Value    = 0
                .Top      = 0
                .Left     = 111
                .Width    = 111
                .Height   = 25
                .AutoSize = .F.
            ENDWITH
        ENDWITH

        *-- Agrupar MRCF (OptionGroup)
        loc_oCnt.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oCnt.lbl_4c_Label28
            .Top      = 257
            .Left     = 620
            .Width    = 79
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Agrupar MRCF :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_OPT_ALTTRANS", "OptionGroup")
        WITH loc_oCnt.obj_4c_OPT_ALTTRANS
            .Top         = 256
            .Left        = 698
            .Width       = 120
            .Height      = 15
            .ButtonCount = 2
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption  = "Sim"
                .Value    = 0
                .Top      = 0
                .Left     = 0
                .Width    = 60
                .Height   = 15
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(227) + "o"
                .Value    = 0
                .Top      = 0
                .Left     = 60
                .Width    = 60
                .Height   = 15
                .AutoSize = .F.
            ENDWITH
        ENDWITH

        *-- Empresa na Tela de Briefing (OptionGroup 5 botoes)
        loc_oCnt.AddObject("lbl_4c_Label40", "Label")
        WITH loc_oCnt.lbl_4c_Label40
            .Top      = 275
            .Left     = 557
            .Width    = 142
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Empresa na Tela de Briefing :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Optiongroup1", "OptionGroup")
        WITH loc_oCnt.obj_4c_Optiongroup1
            .Top         = 270
            .Left        = 698
            .Width       = 313
            .Height      = 23
            .ButtonCount = 5
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption  = "N" + CHR(227) + "o"
                .Value    = 0
                .Top      = 0
                .Left     = 0
                .Width    = 62
                .Height   = 23
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "1"
                .Value    = 0
                .Top      = 0
                .Left     = 62
                .Width    = 62
                .Height   = 23
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "2"
                .Value    = 0
                .Top      = 0
                .Left     = 124
                .Width    = 63
                .Height   = 23
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(4)
                .Caption  = "3"
                .Value    = 0
                .Top      = 0
                .Left     = 187
                .Width    = 63
                .Height   = 23
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(5)
                .Caption  = "4"
                .Value    = 0
                .Top      = 0
                .Left     = 250
                .Width    = 63
                .Height   = 23
                .AutoSize = .F.
            ENDWITH
        ENDWITH

        *-- Ignorar no E-Commerce (OptionGroup)
        loc_oCnt.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oCnt.lbl_4c_Label39
            .Top      = 202
            .Left     = 576
            .Width    = 123
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Ignorar no E-Commerce :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Optiongroup2", "OptionGroup")
        WITH loc_oCnt.obj_4c_Optiongroup2
            .Top         = 201
            .Left        = 698
            .Width       = 120
            .Height      = 15
            .ButtonCount = 2
            .Value       = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption  = "Sim"
                .Value    = 0
                .Top      = 0
                .Left     = 0
                .Width    = 60
                .Height   = 15
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(227) + "o"
                .Value    = 0
                .Top      = 0
                .Left     = 60
                .Width    = 60
                .Height   = 15
                .AutoSize = .F.
            ENDWITH
        ENDWITH

        *-- Permite Alterar Data da Movimentacao (OptionGroup)
        loc_oCnt.AddObject("lbl_4c_label52", "Label")
        WITH loc_oCnt.lbl_4c_label52
            .Top      = 295
            .Left     = 508
            .Width    = 191
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Permite Alterar Data da Movimenta" + CHR(231) + CHR(227) + "o:"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Op_blqdt", "OptionGroup")
        WITH loc_oCnt.obj_4c_Op_blqdt
            .Top         = 291
            .Left        = 698
            .Width       = 209
            .Height      = 21
            .ButtonCount = 2
            .Value       = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption  = "Sim"
                .Value    = 0
                .Top      = 0
                .Left     = 0
                .Width    = 104
                .Height   = 21
                .AutoSize = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(227) + "o"
                .Value    = 0
                .Top      = 0
                .Left     = 104
                .Width    = 105
                .Height   = 21
                .AutoSize = .F.
            ENDWITH
        ENDWITH

        *-- Invoice CBD / SISPAG (Banco/Agencia/Conta/DAC)
        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Top      = 346
            .Left     = 353
            .Width    = 113
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Invoice CBD / SISPAG :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .Top      = 328
            .Left     = 468
            .Width    = 31
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Banco"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Banco", "TextBox")
        WITH loc_oCnt.txt_4c_Banco
            .Top      = 342
            .Left     = 468
            .Width    = 38
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oCnt.lbl_4c_Label7
            .Top      = 328
            .Left     = 511
            .Width    = 40
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Agencia"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Agenc", "TextBox")
        WITH loc_oCnt.txt_4c_Agenc
            .Top      = 342
            .Left     = 511
            .Width    = 45
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oCnt.lbl_4c_Label10
            .Top      = 328
            .Left     = 561
            .Width    = 31
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Conta"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Top      = 342
            .Left     = 562
            .Width    = 73
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label43", "Label")
        WITH loc_oCnt.lbl_4c_Label43
            .Top      = 328
            .Left     = 635
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "DAC"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DAC", "TextBox")
        WITH loc_oCnt.txt_4c_DAC
            .Top      = 342
            .Left     = 640
            .Width    = 17
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Operacao Atual Cupom Fiscal / Dope_int
        loc_oCnt.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oCnt.lbl_4c_Label12
            .Top      = 328
            .Left     = 697
            .Width    = 142
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Opera" + CHR(231) + CHR(227) + "o Atual Cupom Fiscal"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Dope_int", "TextBox")
        WITH loc_oCnt.txt_4c_Dope_int
            .Top      = 342
            .Left     = 697
            .Width    = 150
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Dope_int, "KeyPress", THIS, "KeyPressDopEInt")

        *-- SEDEX
        loc_oCnt.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oCnt.lbl_4c_Label29
            .Top      = 328
            .Left     = 17
            .Width    = 36
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "SEDEX"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oCnt.lbl_4c_Label31
            .Top      = 341
            .Left     = 76
            .Width    = 67
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "N" + CHR(186) + " Contrato :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Contrato", "TextBox")
        WITH loc_oCnt.txt_4c_Contrato
            .Top      = 338
            .Left     = 145
            .Width    = 157
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label32", "Label")
        WITH loc_oCnt.lbl_4c_Label32
            .Top      = 367
            .Left     = 81
            .Width    = 62
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "N" + CHR(186) + " Ag" + CHR(234) + "ncia :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Agencia", "TextBox")
        WITH loc_oCnt.txt_4c_Agencia
            .Top      = 364
            .Left     = 145
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oCnt.lbl_4c_Label34
            .Top      = 394
            .Left     = 36
            .Width    = 107
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Cart" + CHR(227) + "o de Postagem :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cartao", "TextBox")
        WITH loc_oCnt.txt_4c_Cartao
            .Top      = 391
            .Left     = 145
            .Width    = 80
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Container Email Padrao
        loc_oCnt.AddObject("cnt_4c_EmailPad", "Container")
        WITH loc_oCnt.cnt_4c_EmailPad
            .Top         = 421
            .Left        = 8
            .Width       = 303
            .Height      = 143
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        loc_oCnt.cnt_4c_EmailPad.AddObject("lbl_4c_Label46", "Label")
        WITH loc_oCnt.cnt_4c_EmailPad.lbl_4c_Label46
            .Top      = 2
            .Left     = 3
            .Width    = 120
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Dados email padr" + CHR(227) + "o"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_EmailPad.AddObject("lbl_4c_Label54", "Label")
        WITH loc_oCnt.cnt_4c_EmailPad.lbl_4c_Label54
            .Top      = 20
            .Left     = 3
            .Width    = 71
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Servidor SMTP"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_EmailPad.AddObject("txt_4c_Servs", "TextBox")
        WITH loc_oCnt.cnt_4c_EmailPad.txt_4c_Servs
            .Top      = 35
            .Left     = 3
            .Width    = 187
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_EmailPad.AddObject("lbl_4c_Label55", "Label")
        WITH loc_oCnt.cnt_4c_EmailPad.lbl_4c_Label55
            .Top      = 19
            .Left     = 209
            .Width    = 57
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Porta SMTP"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_EmailPad.AddObject("txt_4c_Porta", "TextBox")
        WITH loc_oCnt.cnt_4c_EmailPad.txt_4c_Porta
            .Top      = 34
            .Left     = 209
            .Width    = 28
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_EmailPad.AddObject("lbl_4c_Label52", "Label")
        WITH loc_oCnt.cnt_4c_EmailPad.lbl_4c_Label52
            .Top      = 61
            .Left     = 3
            .Width    = 80
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Email para envio"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_EmailPad.AddObject("txt_4c_Email", "TextBox")
        WITH loc_oCnt.cnt_4c_EmailPad.txt_4c_Email
            .Top      = 75
            .Left     = 3
            .Width    = 298
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_EmailPad.AddObject("lbl_4c_Label53", "Label")
        WITH loc_oCnt.cnt_4c_EmailPad.lbl_4c_Label53
            .Top      = 103
            .Left     = 3
            .Width    = 80
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Senha do e_mail"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.cnt_4c_EmailPad.AddObject("txt_4c_Senhas", "TextBox")
        WITH loc_oCnt.cnt_4c_EmailPad.txt_4c_Senhas
            .Top      = 117
            .Left     = 3
            .Width    = 298
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Distribuicao de Estoque / CDL
        loc_oCnt.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oCnt.lbl_4c_Label38
            .Top      = 522
            .Left     = 322
            .Width    = 120
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Distribui" + CHR(231) + CHR(227) + "o de estoque"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Saicol", "TextBox")
        WITH loc_oCnt.txt_4c_Saicol
            .Top      = 538
            .Left     = 322
            .Width    = 150
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Saicol, "KeyPress", THIS, "KeyPressSaicol")

        loc_oCnt.AddObject("lbl_4c_Label53", "Label")
        WITH loc_oCnt.lbl_4c_Label53
            .Top      = 522
            .Left     = 488
            .Width    = 87
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Senha do CDL Rio"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cdlsenhas", "TextBox")
        WITH loc_oCnt.txt_4c_Cdlsenhas
            .Top      = 538
            .Left     = 488
            .Width    = 120
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarSubPage3 - Aba Fiscal: grupos/contas contabeis, NFe, config fiscal
    *===========================================================================
    PROCEDURE ConfigurarSubPage3(par_oPagina)
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Page3

        *-- Header: Lancamentos Fiscais
        loc_oCnt.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oCnt.lbl_4c_Label20
            .Top      = 130
            .Left     = 18
            .Width    = 130
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Lan" + CHR(231) + "amentos Fiscais"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH

        *-- Moeda / CFOP
        loc_oCnt.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oCnt.lbl_4c_Label12
            .Top      = 130
            .Left     = 178
            .Width    = 46
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Moeda :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Mctotal", "TextBox")
        WITH loc_oCnt.txt_4c_Mctotal
            .Top      = 126
            .Left     = 226
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Mctotal, "KeyPress", THIS, "KeyPressMctotal")

        loc_oCnt.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oCnt.lbl_4c_Label25
            .Top      = 130
            .Left     = 297
            .Width    = 41
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "CFOP :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cfo_Int", "TextBox")
        WITH loc_oCnt.txt_4c_Cfo_Int
            .Top      = 126
            .Left     = 340
            .Width    = 91
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Cfo_Int, "KeyPress", THIS, "KeyPressCfoInt")

        *-- Cabecalhos da tabela contabil
        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .Top      = 155
            .Left     = 16
            .Width    = 40
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Valor"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oCnt.lbl_4c_Label11
            .Top      = 156
            .Left     = 67
            .Width    = 40
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "D" + CHR(233) + "bito"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oCnt.lbl_4c_Label10
            .Top      = 156
            .Left     = 370
            .Width    = 40
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Cr" + CHR(233) + "dito"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top      = 175
            .Left     = 66
            .Width    = 35
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Grupo"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oCnt.lbl_4c_Label22
            .Top      = 175
            .Left     = 152
            .Width    = 35
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Conta"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Top      = 175
            .Left     = 370
            .Width    = 35
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Grupo"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oCnt.lbl_4c_Label21
            .Top      = 175
            .Left     = 452
            .Width    = 35
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Conta"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .Top      = 195
            .Left     = 17
            .Width    = 40
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Cont" + CHR(225) + "bil"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oCnt.lbl_4c_Label7
            .Top      = 219
            .Left     = 31
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "ICMS"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oCnt.lbl_4c_Label17
            .Top      = 242
            .Left     = 42
            .Width    = 18
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "IPI"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oCnt.lbl_4c_Label13
            .Top      = 265
            .Left     = 40
            .Width    = 20
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "PIS"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oCnt.lbl_4c_Label14
            .Top      = 288
            .Left     = 18
            .Width    = 42
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "COFINS"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Grupo/Conta Contabil Orig (Contabil / ICMS / IPI / PIS / COFINS)
        loc_oCnt.AddObject("txt_4c__GRUPOO", "TextBox")
        WITH loc_oCnt.txt_4c__GRUPOO
            .Top      = 193
            .Left     = 64
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUPOO, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONTAO", "TextBox")
        WITH loc_oCnt.txt_4c__CONTAO
            .Top      = 193
            .Left     = 147
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONTAO, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_Dcontao", "TextBox")
        WITH loc_oCnt.txt_4c_Dcontao
            .Top      = 193
            .Left     = 227
            .Width    = 134
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__GRUICMO", "TextBox")
        WITH loc_oCnt.txt_4c__GRUICMO
            .Top      = 216
            .Left     = 64
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUICMO, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONICMO", "TextBox")
        WITH loc_oCnt.txt_4c__CONICMO
            .Top      = 216
            .Left     = 147
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONICMO, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_DconIcmo", "TextBox")
        WITH loc_oCnt.txt_4c_DconIcmo
            .Top      = 216
            .Left     = 227
            .Width    = 134
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__GRUIPIO", "TextBox")
        WITH loc_oCnt.txt_4c__GRUIPIO
            .Top      = 239
            .Left     = 64
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUIPIO, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONIPIO", "TextBox")
        WITH loc_oCnt.txt_4c__CONIPIO
            .Top      = 239
            .Left     = 147
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONIPIO, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_DconIpio", "TextBox")
        WITH loc_oCnt.txt_4c_DconIpio
            .Top      = 239
            .Left     = 227
            .Width    = 134
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__GRUPISO", "TextBox")
        WITH loc_oCnt.txt_4c__GRUPISO
            .Top      = 262
            .Left     = 64
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUPISO, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONPISO", "TextBox")
        WITH loc_oCnt.txt_4c__CONPISO
            .Top      = 262
            .Left     = 147
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONPISO, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_DconPiso", "TextBox")
        WITH loc_oCnt.txt_4c_DconPiso
            .Top      = 262
            .Left     = 227
            .Width    = 134
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__GRUCONO", "TextBox")
        WITH loc_oCnt.txt_4c__GRUCONO
            .Top      = 285
            .Left     = 64
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUCONO, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONCONO", "TextBox")
        WITH loc_oCnt.txt_4c__CONCONO
            .Top      = 285
            .Left     = 147
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONCONO, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_DconCono", "TextBox")
        WITH loc_oCnt.txt_4c_DconCono
            .Top      = 285
            .Left     = 227
            .Width    = 134
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Grupo/Conta Contabil Dev (Contabil / ICMS / IPI / PIS / COFINS)
        loc_oCnt.AddObject("txt_4c__GRUPOD", "TextBox")
        WITH loc_oCnt.txt_4c__GRUPOD
            .Top      = 193
            .Left     = 366
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUPOD, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONTAD", "TextBox")
        WITH loc_oCnt.txt_4c__CONTAD
            .Top      = 193
            .Left     = 449
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONTAD, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_Dcontad", "TextBox")
        WITH loc_oCnt.txt_4c_Dcontad
            .Top      = 193
            .Left     = 530
            .Width    = 149
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__GRUICMD", "TextBox")
        WITH loc_oCnt.txt_4c__GRUICMD
            .Top      = 216
            .Left     = 366
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUICMD, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONICMD", "TextBox")
        WITH loc_oCnt.txt_4c__CONICMD
            .Top      = 216
            .Left     = 450
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONICMD, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_DconIcmd", "TextBox")
        WITH loc_oCnt.txt_4c_DconIcmd
            .Top      = 216
            .Left     = 530
            .Width    = 149
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__GRUIPID", "TextBox")
        WITH loc_oCnt.txt_4c__GRUIPID
            .Top      = 239
            .Left     = 366
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUIPID, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONIPID", "TextBox")
        WITH loc_oCnt.txt_4c__CONIPID
            .Top      = 239
            .Left     = 450
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONIPID, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_Dconipid", "TextBox")
        WITH loc_oCnt.txt_4c_Dconipid
            .Top      = 239
            .Left     = 530
            .Width    = 149
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__GRUPISD", "TextBox")
        WITH loc_oCnt.txt_4c__GRUPISD
            .Top      = 262
            .Left     = 366
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUPISD, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONPISD", "TextBox")
        WITH loc_oCnt.txt_4c__CONPISD
            .Top      = 262
            .Left     = 450
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONPISD, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_DconPisd", "TextBox")
        WITH loc_oCnt.txt_4c_DconPisd
            .Top      = 262
            .Left     = 530
            .Width    = 149
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__GRUCOND", "TextBox")
        WITH loc_oCnt.txt_4c__GRUCOND
            .Top      = 285
            .Left     = 366
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__GRUCOND, "KeyPress", THIS, "KeyPressGrupoContabil")

        loc_oCnt.AddObject("txt_4c__CONCOND", "TextBox")
        WITH loc_oCnt.txt_4c__CONCOND
            .Top      = 285
            .Left     = 450
            .Width    = 78
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__CONCOND, "KeyPress", THIS, "KeyPressContaContabil")

        loc_oCnt.AddObject("txt_4c_DconCond", "TextBox")
        WITH loc_oCnt.txt_4c_DconCond
            .Top      = 285
            .Left     = 530
            .Width    = 149
            .Height   = 21
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Aliq (PORCPIS / PORCCONS)
        loc_oCnt.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oCnt.lbl_4c_Label16
            .Top      = 155
            .Left     = 696
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Aliq"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__PORCPIS", "TextBox")
        WITH loc_oCnt.txt_4c__PORCPIS
            .Top      = 262
            .Left     = 684
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__PORCCONS", "TextBox")
        WITH loc_oCnt.txt_4c__PORCCONS
            .Top      = 285
            .Left     = 684
            .Width    = 42
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Proximo Mapa Res. / Perfil / Indicador / Centro de Custo / Reg.Trib. / Tipo EFD
        loc_oCnt.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oCnt.lbl_4c_Label15
            .Top      = 319
            .Left     = 79
            .Width    = 101
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Pr" + CHR(243) + "ximo Mapa Res. :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Mrcf", "TextBox")
        WITH loc_oCnt.txt_4c_Mrcf
            .Top      = 315
            .Left     = 182
            .Width    = 59
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oCnt.lbl_4c_Label24
            .Top      = 319
            .Left     = 297
            .Width    = 33
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Perfil :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Perfil", "TextBox")
        WITH loc_oCnt.txt_4c_Perfil
            .Top       = 315
            .Left      = 332
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oCnt.lbl_4c_Label26
            .Top      = 319
            .Left     = 355
            .Width    = 50
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "(A/B/C)"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oCnt.lbl_4c_Label27
            .Top      = 319
            .Left     = 487
            .Width    = 51
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Indicador:"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__indicas", "TextBox")
        WITH loc_oCnt.txt_4c__indicas
            .Top       = 315
            .Left      = 540
            .Width     = 15
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oCnt.lbl_4c_Label28
            .Top      = 319
            .Left     = 561
            .Width    = 30
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "(0/1)"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oCnt.lbl_4c_Label39
            .Top      = 319
            .Left     = 657
            .Width    = 134
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Regime Especial Tribut" + CHR(225) + "rio :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_RegEsps", "TextBox")
        WITH loc_oCnt.txt_4c_RegEsps
            .Top       = 315
            .Left      = 793
            .Width     = 24
            .Height    = 22
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oCnt.lbl_4c_Label23
            .Top      = 344
            .Left     = 92
            .Width    = 88
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Centro de Custo :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Ccustos", "TextBox")
        WITH loc_oCnt.txt_4c_Ccustos
            .Top      = 340
            .Left     = 182
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oCnt.lbl_4c_Label29
            .Top      = 344
            .Left     = 279
            .Width    = 51
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Tipo EFD :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("cbo_4c_CB_TIPOEFD", "ComboBox")
        WITH loc_oCnt.cbo_4c_CB_TIPOEFD
            .Top           = 340
            .Left          = 332
            .Width         = 227
            .Height        = 22
            .RowSourceType = 1
            .RowSource     = "A - Industrial,B - Comercial,C - Servico"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oCnt.lbl_4c_Label19
            .Top      = 369
            .Left     = 44
            .Width    = 136
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Regime Tribut" + CHR(225) + "rio (CAT44) :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_REGTRIB", "TextBox")
        WITH loc_oCnt.txt_4c_REGTRIB
            .Top       = 365
            .Left      = 182
            .Width     = 25
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oCnt.lbl_4c_Label34
            .Top      = 344
            .Left     = 682
            .Width    = 109
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "C" + CHR(243) + "d. Servi" + CHR(231) + "o Federal :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__CodOper", "TextBox")
        WITH loc_oCnt.txt_4c__CodOper
            .Top      = 340
            .Left     = 793
            .Width    = 38
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label42", "Label")
        WITH loc_oCnt.lbl_4c_Label42
            .Top      = 369
            .Left     = 677
            .Width    = 114
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "C" + CHR(243) + "d. Servi" + CHR(231) + "o Municipal :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oCnt.txt_4c_Codigo
            .Top      = 365
            .Left     = 793
            .Width    = 66
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Header: Dados Para NF-e
        loc_oCnt.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oCnt.lbl_4c_Label31
            .Top      = 401
            .Left     = 18
            .Width    = 100
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Dados Para NF-e"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH

        *-- Servidor SMTP / Porta / Email NF-e / Senha / Pasta
        loc_oCnt.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oCnt.lbl_4c_Label9
            .Top      = 418
            .Left     = 84
            .Width    = 78
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Servidor SMTP :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Servs", "TextBox")
        WITH loc_oCnt.txt_4c_Servs
            .Top      = 415
            .Left     = 164
            .Width    = 187
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label45", "Label")
        WITH loc_oCnt.lbl_4c_Label45
            .Top      = 418
            .Left     = 368
            .Width    = 64
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Porta SMTP :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Porta", "TextBox")
        WITH loc_oCnt.txt_4c_Porta
            .Top      = 415
            .Left     = 434
            .Width    = 28
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top      = 442
            .Left     = 38
            .Width    = 124
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Email para envio de NFe :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Emailnfe", "TextBox")
        WITH loc_oCnt.txt_4c_Emailnfe
            .Top      = 439
            .Left     = 164
            .Width    = 298
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Top      = 466
            .Left     = 75
            .Width    = 87
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Senha do e_mail :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Senhas", "TextBox")
        WITH loc_oCnt.txt_4c_Senhas
            .Top      = 463
            .Left     = 164
            .Width    = 298
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCnt.lbl_4c_Label8
            .Top      = 490
            .Left     = 63
            .Width    = 99
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Pasta base da NFe :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Pastas", "TextBox")
        WITH loc_oCnt.txt_4c_Pastas
            .Top      = 487
            .Left     = 164
            .Width    = 298
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oCnt.lbl_4c_Label30
            .Top      = 514
            .Left     = 53
            .Width    = 109
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Logotipo da Empresa :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Logo", "TextBox")
        WITH loc_oCnt.txt_4c_Logo
            .Top      = 511
            .Left     = 164
            .Width    = 298
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label33", "Label")
        WITH loc_oCnt.lbl_4c_Label33
            .Top      = 539
            .Left     = 43
            .Width    = 119
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Pasta grava" + CHR(231) + CHR(227) + "o do FCI :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PastaFci", "TextBox")
        WITH loc_oCnt.txt_4c_PastaFci
            .Top      = 536
            .Left     = 164
            .Width    = 298
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Texto email NFe autorizada (EditBox)
        loc_oCnt.AddObject("lbl_4c_Label36", "Label")
        WITH loc_oCnt.lbl_4c_Label36
            .Top      = 419
            .Left     = 503
            .Width    = 226
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Texto do e-mail para envio da NFe autorizada :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Get_textonfe", "EditBox")
        WITH loc_oCnt.obj_4c_Get_textonfe
            .Top      = 434
            .Left     = 502
            .Width    = 488
            .Height   = 50
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Mensagem ECF/Sat (EditBox)
        loc_oCnt.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oCnt.lbl_4c_Label38
            .Top      = 497
            .Left     = 503
            .Width    = 224
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Mensages promocionais ECF/Assinatura do Sat"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Get_textopaf", "EditBox")
        WITH loc_oCnt.obj_4c_Get_textopaf
            .Top      = 512
            .Left     = 502
            .Width    = 488
            .Height   = 45
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- CheckBox Entra no Oficial1 (AnaVends)
        loc_oCnt.AddObject("chk_4c_ChkAnaVends", "CheckBox")
        WITH loc_oCnt.chk_4c_ChkAnaVends
            .Top      = 577
            .Left     = 56
            .Width    = 97
            .Height   = 15
            .Caption  = "Entra no Oficial1"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarSubPage4 - Aba NFC-e: chaves parceiro/contribuinte e CSC
    *===========================================================================
    PROCEDURE ConfigurarSubPage4(par_oPagina)
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Page4

        loc_oCnt.AddObject("cmd_4c_ConfGne", "CommandButton")
        WITH loc_oCnt.cmd_4c_ConfGne
            .Top      = 132
            .Left     = 358
            .Width    = 115
            .Height   = 24
            .Caption  = "Configura GNE"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top      = 161
            .Left     = 91
            .Width    = 97
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Chave do parceiro :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__chavep", "TextBox")
        WITH loc_oCnt.txt_4c__chavep
            .Top      = 157
            .Left     = 190
            .Width    = 283
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top      = 186
            .Left     = 49
            .Width    = 139
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Chave Acesso Contribuinte :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__chavec", "TextBox")
        WITH loc_oCnt.txt_4c__chavec
            .Top      = 181
            .Left     = 190
            .Width    = 283
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Top      = 208
            .Left     = 159
            .Width    = 29
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "CSC :"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__csc", "TextBox")
        WITH loc_oCnt.txt_4c__csc
            .Top      = 205
            .Left     = 190
            .Width    = 283
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * KeyPressUF - F4/F5: limita a 2 letras e converte para maiusculo
    *===========================================================================
    PROCEDURE KeyPressUF(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
                IF PEMSTATUS(loc_oCnt, "txt_4c_Est", 5)
                    loc_oCnt.txt_4c_Est.Value = UPPER(ALLTRIM(loc_oCnt.txt_4c_Est.Value))
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressUF")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressRegiao - F4/F5: lookup Regiao (SigCdReg.Regiaos)
    *===========================================================================
    PROCEDURE KeyPressRegiao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdReg", "cursor_4c_BuscaReg", "Regiaos", ;
                    ALLTRIM(loc_oCnt.txt_4c_REGIAOS.Value), ;
                    "Regi" + CHR(227) + "o")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.mAddColuna("Regiaos", "!!!!!!!!", "C" + CHR(243) + "d.")
                    loc_oForm.mAddColuna("descs", "@!!!!!!!!!!!!!!!!!!!!!!!!!!", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaReg")
                        SELECT cursor_4c_BuscaReg
                        loc_oCnt.txt_4c_REGIAOS.Value = ALLTRIM(cursor_4c_BuscaReg.Regiaos)
                    ENDIF
                    IF USED("cursor_4c_BuscaReg")
                        USE IN cursor_4c_BuscaReg
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressRegiao")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressCodServs - F4/F5: lookup Cod. Servico Saida (SigCdOpe.Dopes)
    *===========================================================================
    PROCEDURE KeyPressCodServs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
                    ALLTRIM(loc_oCnt.txt_4c__CodServs.Value), ;
                    "C" + CHR(243) + "d. Servi" + CHR(231) + "o Sa" + CHR(237) + "da")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.mAddColuna("Dopes", "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                        SELECT cursor_4c_BuscaOpe
                        loc_oCnt.txt_4c__CodServs.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                        loc_oCnt.txt_4c_Dservs.Value    = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ENDIF
                    IF USED("cursor_4c_BuscaOpe")
                        USE IN cursor_4c_BuscaOpe
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressCodServs")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressTpTrans - F4/F5: lookup Tipo Transporte (SigPrTrn.Codigos)
    *===========================================================================
    PROCEDURE KeyPressTpTrans(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigPrTrn", "cursor_4c_BuscaTtp", "Codigos", ;
                    ALLTRIM(loc_oCnt.txt_4c__TpTrans.Value), ;
                    "Tipo Transporte")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.mAddColuna("Codigos",  "XXXXXX", "C" + CHR(243) + "d.")
                    loc_oForm.mAddColuna("Descrs",   "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaTtp")
                        SELECT cursor_4c_BuscaTtp
                        loc_oCnt.txt_4c__TpTrans.Value = ALLTRIM(cursor_4c_BuscaTtp.Codigos)
                    ENDIF
                    IF USED("cursor_4c_BuscaTtp")
                        USE IN cursor_4c_BuscaTtp
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressTpTrans")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressDopEInt - F4/F5: lookup Operacao Cupom Fiscal (SigCdOpe.Dopes)
    *===========================================================================
    PROCEDURE KeyPressDopEInt(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdOpe", "cursor_4c_BuscaDop", "Dopes", ;
                    ALLTRIM(loc_oCnt.txt_4c_Dope_int.Value), ;
                    "Opera" + CHR(231) + CHR(227) + "o Cupom Fiscal")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.mAddColuna("Dopes", "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDop")
                        SELECT cursor_4c_BuscaDop
                        loc_oCnt.txt_4c_Dope_int.Value = ALLTRIM(cursor_4c_BuscaDop.Dopes)
                    ENDIF
                    IF USED("cursor_4c_BuscaDop")
                        USE IN cursor_4c_BuscaDop
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressDopEInt")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressSaicol - F4/F5: lookup Distribuicao de Estoque (SigCdEmp.Cemps)
    *===========================================================================
    PROCEDURE KeyPressSaicol(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdEmp", "cursor_4c_BuscaSai", "Cemps", ;
                    ALLTRIM(loc_oCnt.txt_4c_Saicol.Value), ;
                    "Distribui" + CHR(231) + CHR(227) + "o de Estoque")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.mAddColuna("Cemps",    "!!!", "C" + CHR(243) + "d.")
                    loc_oForm.mAddColuna("razsocs",  "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Raz" + CHR(227) + "o Social")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaSai")
                        SELECT cursor_4c_BuscaSai
                        loc_oCnt.txt_4c_Saicol.Value = ALLTRIM(cursor_4c_BuscaSai.Cemps)
                    ENDIF
                    IF USED("cursor_4c_BuscaSai")
                        USE IN cursor_4c_BuscaSai
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressSaicol")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressMctotal - F4/F5: lookup Moeda (SigCdMoe.Cmoes)
    *===========================================================================
    PROCEDURE KeyPressMctotal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "cursor_4c_BuscaMoe", "Cmoes", ;
                    ALLTRIM(loc_oCnt.txt_4c_Mctotal.Value), ;
                    "Moeda")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.mAddColuna("CMoes",  "!!", "C" + CHR(243) + "d.")
                    loc_oForm.mAddColuna("DMoes",  "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        SELECT cursor_4c_BuscaMoe
                        loc_oCnt.txt_4c_Mctotal.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    ENDIF
                    IF USED("cursor_4c_BuscaMoe")
                        USE IN cursor_4c_BuscaMoe
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressMctotal")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressCfoInt - F4/F5: lookup CFOP (SigCdCfo.Codigos)
    *===========================================================================
    PROCEDURE KeyPressCfoInt(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCfo", "cursor_4c_BuscaCfo", "Codigos", ;
                    ALLTRIM(loc_oCnt.txt_4c_Cfo_Int.Value), ;
                    "CFOP")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.mAddColuna("Codigos",    "XXXXXXXXX", "CFOP")
                    loc_oForm.mAddColuna("descricaos", "@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
                        SELECT cursor_4c_BuscaCfo
                        loc_oCnt.txt_4c_Cfo_Int.Value = ALLTRIM(cursor_4c_BuscaCfo.Codigos)
                    ENDIF
                    IF USED("cursor_4c_BuscaCfo")
                        USE IN cursor_4c_BuscaCfo
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressCfoInt")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressGrupoContabil - F4/F5: lookup Grupo Contabil (SIGSYACC.grcontas)
    * Handler generico para todos os campos GRUxxx na Page3
    *===========================================================================
    PROCEDURE KeyPressGrupoContabil(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm, loc_oCtrl
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
                loc_oCtrl = THIS.ActiveControl
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SIGSYACC", "cursor_4c_BuscaGrp", "grcontas", ;
                        ALLTRIM(loc_oCtrl.Value), ;
                        "Grupo Cont" + CHR(225) + "bil")
                    IF VARTYPE(loc_oForm) = "O"
                        loc_oForm.mAddColuna("grcontas",  "!!!!!!!!!!", "Grupo Cont" + CHR(225) + "bil")
                        loc_oForm.mAddColuna("cdcontas",  "!!!!!!!!!!!", "Conta")
                        loc_oForm.Show()
                        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                            SELECT cursor_4c_BuscaGrp
                            loc_oCtrl.Value = ALLTRIM(cursor_4c_BuscaGrp.grcontas)
                        ENDIF
                        IF USED("cursor_4c_BuscaGrp")
                            USE IN cursor_4c_BuscaGrp
                        ENDIF
                        loc_oForm.Release()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressGrupoContabil")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPressContaContabil - F4/F5: lookup Conta Contabil (SIGSYACC.cdcontas)
    * Handler generico para todos os campos CONxxx na Page3
    *===========================================================================
    PROCEDURE KeyPressContaContabil(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_oForm, loc_oCtrl
        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
                loc_oCtrl = THIS.ActiveControl
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SIGSYACC", "cursor_4c_BuscaCon", "cdcontas", ;
                        ALLTRIM(loc_oCtrl.Value), ;
                        "Conta Cont" + CHR(225) + "bil")
                    IF VARTYPE(loc_oForm) = "O"
                        loc_oForm.mAddColuna("cdcontas",  "!!!!!!!!!!!!!", "Conta")
                        loc_oForm.mAddColuna("grcontas",  "!!!!!!!!!!!", "Grupo")
                        loc_oForm.Show()
                        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCon")
                            SELECT cursor_4c_BuscaCon
                            loc_oCtrl.Value = ALLTRIM(cursor_4c_BuscaCon.cdcontas)
                        ENDIF
                        IF USED("cursor_4c_BuscaCon")
                            USE IN cursor_4c_BuscaCon
                        ENDIF
                        loc_oForm.Release()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formemp.KeyPressContaContabil")
            ENDTRY
            par_nKeyCode = 0
        ENDIF
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
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

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
