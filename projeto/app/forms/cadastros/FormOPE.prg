*==============================================================================
* FormOPE.prg - Formulario de Cadastro de Tipos de Operacao
* Migrado de: SIGCDOPE.SCX (frmcadastro)
* Fase A: Layout base com logica stub (sem controles de dados nas abas internas)
*==============================================================================

DEFINE CLASS FormOPE AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 650
    Width       = 1000
    Caption     = "Cadastro de Tipos de Opera" + CHR(231) + CHR(227) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    MaxButton   = .F.
    Closable    = .F.
    Themes      = .F.
    BorderStyle = 2
    ClipControls = .F.
    DataSession = 2
    ShowTips    = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("OPEBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar OPEBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormOPE.InicializarForm")
            ELSE
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
            MostrarErro("Erro ao inicializar FormOPE:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormOPE.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas
    * Top=-29 para esconder abas; controles compensam +29 no Top
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
    * ConfigurarPaginaLista - Configura Page1: cabecalho, filtro, botoes CRUD,
    *   grid cursor_4c_Dados, botoes de acao auxiliares
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (compensacao +29: Top=30)
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

        *-- Container Botoes CRUD (Left=542, Top=29, Width=385, Height=85)
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
            .Left            = 80
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
            .Left            = 155
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

        *-- Container Saida (Encerrar) - PADRAO CANONICO (CLAUDE.md regra #10)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Left      = 917
            .Top       = 29
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
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

        *-- Filtro optFilSituas (legado: optFilSituas Top=93, Left=11, Width=181, Height=25)
        *-- Compensacao +29: Top=122
        loc_oPagina.AddObject("opt_4c_FilSituas", "OptionGroup")
        WITH loc_oPagina.opt_4c_FilSituas
            .Top         = 122
            .Left        = 11
            .Width       = 181
            .Height      = 25
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_FilSituas
            .Buttons(1).Caption = "Todos"
            .Buttons(1).Left    = 0
            .Buttons(1).Top     = 0
            .Buttons(1).Width   = 60
            .Buttons(1).Height  = 25
            .Buttons(1).Themes  = .F.
            .Buttons(2).Caption = "Ativos"
            .Buttons(2).Left    = 60
            .Buttons(2).Top     = 0
            .Buttons(2).Width   = 60
            .Buttons(2).Height  = 25
            .Buttons(2).Themes  = .F.
            .Buttons(3).Caption = "Inativos"
            .Buttons(3).Left    = 120
            .Buttons(3).Top     = 0
            .Buttons(3).Width   = 61
            .Buttons(3).Height  = 25
            .Buttons(3).Themes  = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_FilSituas, "InteractiveChange", THIS, "FiltroSituaClick")

        *-- Grid principal cursor_4c_Dados
        *-- Legado: Grade Top=127 (compensado +29 = 156), Left=5, Width=997, Height=441
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top         = 156
            .Left        = 5
            .Width       = 992
            .Height      = 410
            .ColumnCount = 4
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .FontName    = "Courier New"
            .FontSize    = 9
            .Visible     = .T.
            .Column1.Width     = 100
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Width     = 400
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column3.Width     = 80
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column4.Width     = 80
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")

        *-- Botoes de acao no topo (legado top=82, compensado +29 = 111)
        *-- btnExpXML (Exportar): left=519
        loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnExpXML
            .Caption         = "Exportar"
            .Top             = 111
            .Left            = 519
            .Width           = 120
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML, "Click", THIS, "BtnExpXMLClick")

        *-- btnImpXML (Importar): left=639
        loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnImpXML
            .Caption         = "Importar"
            .Top             = 111
            .Left            = 639
            .Width           = 120
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML, "Click", THIS, "BtnImpXMLClick")

        *-- CmdCopia (Copiar): left=759
        loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
        WITH loc_oPagina.cmd_4c_Copia
            .Caption         = "Copiar"
            .Top             = 111
            .Left            = 759
            .Width           = 120
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiaClick")

        *-- btnMapa (Mapa): left=879
        loc_oPagina.AddObject("cmd_4c_Mapa", "CommandButton")
        WITH loc_oPagina.cmd_4c_Mapa
            .Caption         = "Mapa"
            .Top             = 111
            .Left            = 879
            .Width           = 120
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Mapa, "Click", THIS, "BtnMapaClick")

        *-- Botoes de acao inferiores (legado top=574, compensado +29 = 603)
        *-- Credito (Ger. Creditos): left=4
        loc_oPagina.AddObject("cmd_4c_Credito", "CommandButton")
        WITH loc_oPagina.cmd_4c_Credito
            .Caption     = "Ger. Cr" + CHR(233) + "ditos"
            .Top         = 603
            .Left        = 4
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Credito, "Click", THIS, "BtnCreditoClick")

        *-- Deprecia (Depreciacao): left=66
        loc_oPagina.AddObject("cmd_4c_Deprecia", "CommandButton")
        WITH loc_oPagina.cmd_4c_Deprecia
            .Caption     = "Deprecia" + CHR(231) + CHR(227) + "o"
            .Top         = 603
            .Left        = 66
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Deprecia, "Click", THIS, "BtnDepreciaClick")

        *-- cmdEtiquetas (Etiquetas): left=128
        loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
        WITH loc_oPagina.cmd_4c_Etiquetas
            .Caption     = "Etiquetas"
            .Top         = 603
            .Left        = 128
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Etiquetas, "Click", THIS, "BtnEtiquetasClick")

        *-- Transporte (Transportes): left=190
        loc_oPagina.AddObject("cmd_4c_Transporte", "CommandButton")
        WITH loc_oPagina.cmd_4c_Transporte
            .Caption     = "Transportes"
            .Top         = 603
            .Left        = 190
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Transporte, "Click", THIS, "BtnTransporteClick")

        *-- Frete (Fretes): left=252
        loc_oPagina.AddObject("cmd_4c_Frete", "CommandButton")
        WITH loc_oPagina.cmd_4c_Frete
            .Caption     = "Fretes"
            .Top         = 603
            .Left        = 252
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Frete, "Click", THIS, "BtnFreteClick")

        *-- Caixa (Sequencia Cx): left=314
        loc_oPagina.AddObject("cmd_4c_Caixa", "CommandButton")
        WITH loc_oPagina.cmd_4c_Caixa
            .Caption     = "Sequ" + CHR(234) + "ncia Cx"
            .Top         = 603
            .Left        = 314
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Caixa, "Click", THIS, "BtnCaixaClick")

        *-- TabDesconto (Tabelas): left=438
        loc_oPagina.AddObject("cmd_4c_TabDesconto", "CommandButton")
        WITH loc_oPagina.cmd_4c_TabDesconto
            .Caption     = "Tabelas"
            .Top         = 603
            .Left        = 438
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_TabDesconto, "Click", THIS, "BtnTabDescontoClick")

        *-- MontaLista (Monta Grade): left=500
        loc_oPagina.AddObject("cmd_4c_MontaLista", "CommandButton")
        WITH loc_oPagina.cmd_4c_MontaLista
            .Caption     = "Monta Grade"
            .Top         = 603
            .Left        = 500
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_MontaLista, "Click", THIS, "BtnMontaListaClick")

        *-- CmdTrf (Automaticas): left=562
        loc_oPagina.AddObject("cmd_4c_Trf", "CommandButton")
        WITH loc_oPagina.cmd_4c_Trf
            .Caption     = "Autom" + CHR(225) + "ticas"
            .Top         = 603
            .Left        = 562
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Trf, "Click", THIS, "BtnTrfClick")

        *-- cmdMultiSubN (Multiplos): left=624
        loc_oPagina.AddObject("cmd_4c_MultiSubN", "CommandButton")
        WITH loc_oPagina.cmd_4c_MultiSubN
            .Caption     = "M" + CHR(250) + "ltiplos"
            .Top         = 603
            .Left        = 624
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_MultiSubN, "Click", THIS, "BtnMultiSubNClick")

        *-- SubNivel2 (Subnivel +): left=686
        loc_oPagina.AddObject("cmd_4c_SubNivel2", "CommandButton")
        WITH loc_oPagina.cmd_4c_SubNivel2
            .Caption     = "Subn" + CHR(237) + "vel (+)"
            .Top         = 603
            .Left        = 686
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_SubNivel2, "Click", THIS, "BtnSubNivel2Click")

        *-- Multiplas (Subnivel -): left=748
        loc_oPagina.AddObject("cmd_4c_Multiplas", "CommandButton")
        WITH loc_oPagina.cmd_4c_Multiplas
            .Caption     = "Subn" + CHR(237) + "vel (-)"
            .Top         = 603
            .Left        = 748
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Multiplas, "Click", THIS, "BtnMultiplasClick")

        *-- Ccusto (C.C.): left=810
        loc_oPagina.AddObject("cmd_4c_Ccusto", "CommandButton")
        WITH loc_oPagina.cmd_4c_Ccusto
            .Caption     = "C.C."
            .Top         = 603
            .Left        = 810
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Ccusto, "Click", THIS, "BtnCcustoClick")

        *-- GrupoConta (Grupo/Conta): left=872
        loc_oPagina.AddObject("cmd_4c_GrupoConta", "CommandButton")
        WITH loc_oPagina.cmd_4c_GrupoConta
            .Caption     = "Grupo/Conta"
            .Top         = 603
            .Left        = 872
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_GrupoConta, "Click", THIS, "BtnGrupoContaClick")

        *-- Status: left=934
        loc_oPagina.AddObject("cmd_4c_Status", "CommandButton")
        WITH loc_oPagina.cmd_4c_Status
            .Caption     = "Status"
            .Top         = 603
            .Left        = 934
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Status, "Click", THIS, "BtnStatusClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: cabecalho de identificacao,
    *   botoes Salvar/Cancelar, PageFrame interno PagDados com 18 abas stub
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (legado: Grupo_Salva Top=-2, Left=840; canonico Top=27)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top       = 27
            .Left      = 840
            .Width     = 160
            .Height    = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Cabecalho de identificacao da operacao (acima do PagDados)
        *-- Legado: campos no topo da Page2 (top < 130) sem container explicito
        *-- Compensacao +29: tops originais + 29

        *-- Label "Codigo :" (Say1 legado: top=7)
        loc_oPagina.AddObject("lbl_4c_LCodigo", "Label")
        WITH loc_oPagina.lbl_4c_LCodigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 36
            .Left      = 30
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_desc legado: top=3, left=73, width=179, height=23)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 32
            .Left          = 73
            .Width         = 179
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 20
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Descricao :" (Say28 legado: top=32)
        loc_oPagina.AddObject("lbl_4c_LDescricao", "Label")
        WITH loc_oPagina.lbl_4c_LDescricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 61
            .Left      = 17
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (Get1 legado: top=28, left=73, width=179, height=23)
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 57
            .Left          = 73
            .Width         = 250
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 100
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Tipo :" (Say4 legado: top=32, left=295)
        loc_oPagina.AddObject("lbl_4c_LTipo", "Label")
        WITH loc_oPagina.lbl_4c_LTipo
            .Caption   = "Tipo :"
            .Top       = 61
            .Left      = 295
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Tipo (cmbTOpers legado: top=28, left=325, width=227, height=23)
        loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
        WITH loc_oPagina.txt_4c_Tipo
            .Value         = ""
            .Top           = 57
            .Left          = 325
            .Width         = 100
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Nested PageFrame PagDados (legado: top=130, left=0, width=1002, height=677)
        *-- Compensacao +29: top=159
        loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
        WITH loc_oPagina.pgf_4c_PagDados
            .Top       = 159
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29 - 159
            .PageCount = 18
            .Tabs      = .T.
            .Visible   = .T.
            *-- Captions das 18 abas (Fase A: stubs)
            .Page1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
            .Page2.Caption  = "Itens"
            .Page3.Caption  = "Financeiro"
            .Page4.Caption  = "Fiscal"
            .Page5.Caption  = "Documento"
            .Page6.Caption  = "Pre" + CHR(231) + "o"
            .Page7.Caption  = "Div"
            .Page8.Caption  = "Diversos"
            .Page9.Caption  = "Subn" + CHR(237) + "vel"
            .Page10.Caption = "Estoque"
            .Page11.Caption = "Boleto"
            .Page12.Caption = "Config. Fin."
            .Page13.Caption = "Invoices"
            .Page14.Caption = "Div2"
            .Page15.Caption = "Itens2"
            .Page16.Caption = "Jobs"
            .Page17.Caption = "Comiss" + CHR(227) + "o"
            .Page18.Caption = "T" + CHR(237) + "tulos"
        ENDWITH

        *-- Z-ORDER: Trazer botoes Salvar/Cancelar para frente do PageFrame interno
        loc_oPagina.cnt_4c_Salva.ZOrder(0)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor_4c_Dados com tipos de operacao
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nFiltroSit
        loc_lResultado = .F.
        loc_nFiltroSit = 1

        TRY
            *-- Ler filtro de situacao se disponivel
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "opt_4c_FilSituas", 5)
                loc_nFiltroSit = THIS.pgf_4c_Paginas.Page1.opt_4c_FilSituas.Value
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN SELECT("cursor_4c_Dados")
            ENDIF

            *-- SigCdOpe nao tem coluna emps - tabela global de configuracao
            DO CASE
            CASE loc_nFiltroSit = 2
                *-- Ativos: situas = 0
                loc_cSQL = "SELECT a.dopes, a.descrs, a.tipoops, a.situas, a.opers " + ;
                           "FROM SigCdOpe a " + ;
                           "WHERE a.situas = 0 " + ;
                           "ORDER BY a.dopes"
            CASE loc_nFiltroSit = 3
                *-- Inativos: situas <> 0
                loc_cSQL = "SELECT a.dopes, a.descrs, a.tipoops, a.situas, a.opers " + ;
                           "FROM SigCdOpe a " + ;
                           "WHERE a.situas <> 0 " + ;
                           "ORDER BY a.dopes"
            OTHERWISE
                *-- Todos
                loc_cSQL = "SELECT a.dopes, a.descrs, a.tipoops, a.situas, a.opers " + ;
                           "FROM SigCdOpe a " + ;
                           "ORDER BY a.dopes"
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar tipos de opera" + CHR(231) + CHR(227) + "o.", ;
                    "Erro em CarregarLista")
            ELSE
                IF USED("cursor_4c_Dados")
                    *-- Configurar grid
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
                        LOCAL loc_oGrid
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                        loc_oGrid.ColumnCount = 4
                        loc_oGrid.RecordSource          = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopes"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipoops"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.situas"
                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Tipo"
                        loc_oGrid.Column4.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    SELECT cursor_4c_Dados
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_cPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF par_cPagina = "LISTA"
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em AlternarPagina")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CRUD - Handlers de clique dos botoes principais
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        *-- Fase B: implementar ValidarPreAcao + logica de inclusao
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_cModoAtual = "INCLUSAO"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina("DADOS")
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnIncluirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnAlterarClick()
        *-- Fase B: implementar ValidarPreAcao + logica de alteracao
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para alterar.", "Alterar")
            ELSE
                THIS.this_cModoAtual = "ALTERACAO"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina("DADOS")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnAlterarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        *-- Fase B: implementar ValidarPreAcao + logica de visualizacao
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            ELSE
                THIS.this_cModoAtual = "VISUALIZACAO"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina("DADOS")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnVisualizarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnExcluirClick()
        *-- Fase B: implementar ValidarPreAcao + logica de exclusao
        LOCAL loc_lResultado, loc_lConfirma
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para excluir.", "Excluir")
            ELSE
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", "Excluir")
                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.Excluir()
                        THIS.CarregarLista()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnExcluirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnBuscarClick()
        *-- Fase B: implementar busca
        THIS.CarregarLista()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        *-- Fase B: implementar FormParaBO + Inserir/Atualizar
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.FormParaBO()
            DO CASE
            CASE THIS.this_cModoAtual = "INCLUSAO"
                loc_lResultado = THIS.this_oBusinessObject.Inserir()
            CASE THIS.this_cModoAtual = "ALTERACAO"
                loc_lResultado = THIS.this_oBusinessObject.Atualizar()
            ENDCASE
            IF loc_lResultado
                THIS.CarregarLista()
                THIS.AlternarPagina("LISTA")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnSalvarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnCancelarClick()
        *-- Fase B: implementar cancelamento
        THIS.AlternarPagina("LISTA")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Handlers de eventos de grid e filtro
    *==========================================================================
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        *-- Fase B: implementar selecao de registro no grid
    ENDPROC

    PROCEDURE FiltroSituaClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * Botoes de acao auxiliares (stubs - Fase B)
    *==========================================================================
    PROCEDURE BtnExpXMLClick()
        *-- Fase B: implementar exportar XML
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Exportar XML (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnImpXMLClick()
        *-- Fase B: implementar importar XML
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Importar XML (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnCopiaClick()
        *-- Fase B: implementar copiar operacao
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Copiar (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnMapaClick()
        *-- Fase B: implementar mapa
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Mapa (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnCreditoClick()
        *-- Fase B: implementar gerar creditos
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Ger. Cr" + CHR(233) + "ditos (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnDepreciaClick()
        *-- Fase B: implementar depreciacao
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Deprecia" + CHR(231) + CHR(227) + "o (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnEtiquetasClick()
        *-- Fase B: implementar etiquetas
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Etiquetas (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnTransporteClick()
        *-- Fase B: implementar transportes
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Transportes (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnFreteClick()
        *-- Fase B: implementar fretes
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Fretes (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnCaixaClick()
        *-- Fase B: implementar sequencia caixa
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Sequ" + CHR(234) + "ncia Cx (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnTabDescontoClick()
        *-- Fase B: implementar tabelas de desconto
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Tabelas (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnMontaListaClick()
        *-- Fase B: implementar monta grade
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Monta Grade (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnTrfClick()
        *-- Fase B: implementar automaticas
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Autom" + CHR(225) + "ticas (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnMultiSubNClick()
        *-- Fase B: implementar multiplos
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: M" + CHR(250) + "ltiplos (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnSubNivel2Click()
        *-- Fase B: implementar subnivel +
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Subn" + CHR(237) + "vel (+) (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnMultiplasClick()
        *-- Fase B: implementar subnivel -
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Subn" + CHR(237) + "vel (-) (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnCcustoClick()
        *-- Fase B: implementar centro de custo
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: C.C. (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnGrupoContaClick()
        *-- Fase B: implementar grupo/conta
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Grupo/Conta (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnStatusClick()
        *-- Fase B: implementar status
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Status (Fase B)", "Em desenvolvimento")
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados dos campos visuais para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        *-- Fase B: implementar mapeamento completo de todos os campos
        LOCAL loc_oPagDados
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2

        TRY
            THIS.this_oBusinessObject.this_cDopes = ;
                ALLTRIM(loc_oPagDados.txt_4c_Codigo.Value)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os campos visuais
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        *-- Fase B: implementar mapeamento completo de todos os campos
        LOCAL loc_lResultado, loc_oPagDados
        loc_lResultado = .F.
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Carregar registro do banco para o BO
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                LOCAL loc_cDopes
                loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
                IF THIS.this_oBusinessObject.Buscar("a.dopes = " + EscaparSQL(loc_cDopes))
                    *-- Preencher campos basicos
                    loc_oPagDados.txt_4c_Codigo.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BOParaForm")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita edicao dos campos
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- Fase B: habilitar/desabilitar todos os campos das 18 abas
        LOCAL loc_oPagDados
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPagDados.txt_4c_Codigo.ReadOnly   = !par_lHabilitar
            loc_oPagDados.txt_4c_Descricao.ReadOnly = !par_lHabilitar
            loc_oPagDados.txt_4c_Tipo.ReadOnly      = !par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de edicao
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        *-- Fase B: limpar todos os campos das 18 abas
        LOCAL loc_oPagDados
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPagDados.txt_4c_Codigo.Value   = ""
            loc_oPagDados.txt_4c_Descricao.Value = ""
            loc_oPagDados.txt_4c_Tipo.Value      = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        *-- Fase B: implementar ajuste de botoes conforme INCLUSAO/ALTERACAO/VISUALIZACAO/LISTA
    ENDPROC

    *==========================================================================
    * Destroy - Liberacao de recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN SELECT("cursor_4c_Dados")
        ENDIF
        DODEFAULT()
    ENDPROC


    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
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
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

ENDDEFINE
