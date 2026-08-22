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
        *-- titopes char(30) -> MaxLength=30
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 57
            .Left          = 73
            .Width         = 250
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 30
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Menu :" (menus char(10))
        loc_oPagina.AddObject("lbl_4c_LMenu", "Label")
        WITH loc_oPagina.lbl_4c_LMenu
            .Caption   = "Menu :"
            .Top       = 86
            .Left      = 37
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- ComboBox Menu (menus char(10))
        loc_oPagina.AddObject("cbo_4c_Menu", "ComboBox")
        WITH loc_oPagina.cbo_4c_Menu
            .Value         = ""
            .Top           = 82
            .Left          = 73
            .Width         = 150
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = ",SISTEMA,OPERACIONA,CAIXA"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
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

        *-- Fase C: Popular paginas internas com controles
        THIS.ConfigurarPagOperacao(loc_oPagina.pgf_4c_PagDados.Page1)
        THIS.ConfigurarPagItens(loc_oPagina.pgf_4c_PagDados.Page2)
        THIS.ConfigurarPagFinanceiro(loc_oPagina.pgf_4c_PagDados.Page3)
        THIS.ConfigurarPagFiscal(loc_oPagina.pgf_4c_PagDados.Page4)
        THIS.ConfigurarPagDocumento(loc_oPagina.pgf_4c_PagDados.Page5)
        THIS.ConfigurarPagPreco(loc_oPagina.pgf_4c_PagDados.Page6)
        THIS.ConfigurarPagDiv(loc_oPagina.pgf_4c_PagDados.Page7)
        THIS.ConfigurarPagDiversos(loc_oPagina.pgf_4c_PagDados.Page8)
        THIS.ConfigurarPagComissao(loc_oPagina.pgf_4c_PagDados.Page17)

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
            *-- Descricao em SigCdOpe: titopes char(30)
            DO CASE
            CASE loc_nFiltroSit = 2
                *-- Ativos: situas = 0
                loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
                           "FROM SigCdOpe a " + ;
                           "WHERE a.situas = 0 " + ;
                           "ORDER BY a.dopes"
            CASE loc_nFiltroSit = 3
                *-- Inativos: situas <> 0
                loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
                           "FROM SigCdOpe a " + ;
                           "WHERE a.situas <> 0 " + ;
                           "ORDER BY a.dopes"
            OTHERWISE
                *-- Todos
                loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
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
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.titopes"
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
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
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
        LOCAL loc_oPagDados, loc_oPg1, loc_oPg2, loc_oPg3, loc_oPg4, loc_oPg5, loc_oPg6, loc_oPg7, loc_oPg8, loc_oPg17
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            *-- Cabecalho (Pagina Dados)
            THIS.this_oBusinessObject.this_cDopes   = UPPER(ALLTRIM(loc_oPagDados.txt_4c_Codigo.Value))
            THIS.this_oBusinessObject.this_cTitopes = ALLTRIM(loc_oPagDados.txt_4c_Descricao.Value)
            THIS.this_oBusinessObject.this_nTipoops = VAL(ALLTRIM(loc_oPagDados.txt_4c_Tipo.Value))
            IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
                THIS.this_oBusinessObject.this_cMenus = ALLTRIM(loc_oPagDados.cbo_4c_Menu.Value)
            ENDIF

            *-- Referencias das paginas internas
            loc_oPg1  = loc_oPagDados.pgf_4c_PagDados.Page1
            loc_oPg2  = loc_oPagDados.pgf_4c_PagDados.Page2
            loc_oPg3  = loc_oPagDados.pgf_4c_PagDados.Page3
            loc_oPg4  = loc_oPagDados.pgf_4c_PagDados.Page4
            loc_oPg5  = loc_oPagDados.pgf_4c_PagDados.Page5
            loc_oPg6  = loc_oPagDados.pgf_4c_PagDados.Page6
            loc_oPg7  = loc_oPagDados.pgf_4c_PagDados.Page7
            loc_oPg8  = loc_oPagDados.pgf_4c_PagDados.Page8
            loc_oPg17 = loc_oPagDados.pgf_4c_PagDados.Page17

            *-- Pagina 1: Operacao
            IF PEMSTATUS(loc_oPg1, "opt_4c_Blqdt", 5)
                THIS.this_oBusinessObject.this_nBlqdatas = loc_oPg1.opt_4c_Blqdt.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "opt_4c_Conf", 5)
                THIS.this_oBusinessObject.this_nConfes = loc_oPg1.opt_4c_Conf.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "opt_4c_Bloqueio", 5)
                THIS.this_oBusinessObject.this_nAciosens = loc_oPg1.opt_4c_Bloqueio.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "txt_4c_DopeSTrfs", 5)
                THIS.this_oBusinessObject.this_cDopestrfs = ALLTRIM(loc_oPg1.txt_4c_DopeSTrfs.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "txt_4c_DopeETrfs", 5)
                THIS.this_oBusinessObject.this_cDopeetrfs = ALLTRIM(loc_oPg1.txt_4c_DopeETrfs.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "txt_4c_Central", 5)
                THIS.this_oBusinessObject.this_cCcentrals = ALLTRIM(loc_oPg1.txt_4c_Central.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "chk_4c_CarESubN", 5)
                THIS.this_oBusinessObject.this_nCempsubns = IIF(loc_oPg1.chk_4c_CarESubN.Value = 1, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "chk_4c_VincEstM", 5)
                THIS.this_oBusinessObject.this_nMestoqs = IIF(loc_oPg1.chk_4c_VincEstM.Value = 1, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "txt_4c_EmpPad", 5)
                THIS.this_oBusinessObject.this_cEmppads = ALLTRIM(loc_oPg1.txt_4c_EmpPad.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "opt_4c_Tipo", 5)
                THIS.this_oBusinessObject.this_nOpers = loc_oPg1.opt_4c_Tipo.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "opt_4c_Cai", 5)
                THIS.this_oBusinessObject.this_nCaixas = loc_oPg1.opt_4c_Cai.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "mem_4c_ObsOpe", 5)
                THIS.this_oBusinessObject.this_mObsopes = ALLTRIM(loc_oPg1.mem_4c_ObsOpe.Value)
            ENDIF

            *-- Pagina 2: Itens
            IF PEMSTATUS(loc_oPg2, "opt_4c_Cbar", 5)
                THIS.this_oBusinessObject.this_nCodbars = loc_oPg2.opt_4c_Cbar.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_Imagem", 5)
                THIS.this_oBusinessObject.this_nImagems = loc_oPg2.opt_4c_Imagem.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_ObsItems", 5)
                THIS.this_oBusinessObject.this_nObsitems = loc_oPg2.opt_4c_ObsItems.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_Desmemb", 5)
                THIS.this_oBusinessObject.this_nDesmembs = loc_oPg2.opt_4c_Desmemb.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_ChkQtds", 5)
                THIS.this_oBusinessObject.this_nChkqtds = loc_oPg2.opt_4c_ChkQtds.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_QtdIte", 5)
                THIS.this_oBusinessObject.this_nQtdites = VAL(ALLTRIM(loc_oPg2.txt_4c_QtdIte.Value))
            ENDIF

            *-- Pagina 3: Financeiro
            IF PEMSTATUS(loc_oPg3, "opt_4c_Che", 5)
                THIS.this_oBusinessObject.this_nCheqs = loc_oPg3.opt_4c_Che.Value
            ENDIF
            IF PEMSTATUS(loc_oPg3, "opt_4c_Contas", 5)
                THIS.this_oBusinessObject.this_nParcontas = loc_oPg3.opt_4c_Contas.Value
            ENDIF
            IF PEMSTATUS(loc_oPg3, "opt_4c_LimCre", 5)
                THIS.this_oBusinessObject.this_nLimcres = loc_oPg3.opt_4c_LimCre.Value
            ENDIF
            IF PEMSTATUS(loc_oPg3, "opt_4c_Troco", 5)
                THIS.this_oBusinessObject.this_nTrocoauts = loc_oPg3.opt_4c_Troco.Value
            ENDIF
            IF PEMSTATUS(loc_oPg3, "txt_4c_OpChqEnt", 5)
                THIS.this_oBusinessObject.this_cOperchqes = ALLTRIM(loc_oPg3.txt_4c_OpChqEnt.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg3, "txt_4c_OpChqSai", 5)
                THIS.this_oBusinessObject.this_cOperchqss = ALLTRIM(loc_oPg3.txt_4c_OpChqSai.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg3, "txt_4c_Conta", 5)
                THIS.this_oBusinessObject.this_cContas = ALLTRIM(loc_oPg3.txt_4c_Conta.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg3, "txt_4c_Grupo", 5)
                THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oPg3.txt_4c_Grupo.Value)
            ENDIF

            *-- Pagina 4: Fiscal
            IF PEMSTATUS(loc_oPg4, "txt_4c_Especies", 5)
                THIS.this_oBusinessObject.this_cEspecies = ALLTRIM(loc_oPg4.txt_4c_Especies.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg4, "txt_4c_Series", 5)
                THIS.this_oBusinessObject.this_cSeries = ALLTRIM(loc_oPg4.txt_4c_Series.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg4, "txt_4c_CfoPad", 5)
                THIS.this_oBusinessObject.this_cCfos = ALLTRIM(loc_oPg4.txt_4c_CfoPad.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg4, "opt_4c_TipoNF", 5)
                THIS.this_oBusinessObject.this_nTiponfs = loc_oPg4.opt_4c_TipoNF.Value
            ENDIF

            *-- Pagina 5: Documento
            IF PEMSTATUS(loc_oPg5, "opt_4c_DigDoc", 5)
                THIS.this_oBusinessObject.this_nDigdoc = loc_oPg5.opt_4c_DigDoc.Value
            ENDIF
            IF PEMSTATUS(loc_oPg5, "opt_4c_EditDocs", 5)
                THIS.this_oBusinessObject.this_nEditdocs = loc_oPg5.opt_4c_EditDocs.Value
            ENDIF

            *-- Pagina 6: Preco
            IF PEMSTATUS(loc_oPg6, "opt_4c_AltPreco", 5)
                THIS.this_oBusinessObject.this_nEprecos = loc_oPg6.opt_4c_AltPreco.Value
            ENDIF
            IF PEMSTATUS(loc_oPg6, "opt_4c_AltPeso", 5)
                THIS.this_oBusinessObject.this_nEpesos = loc_oPg6.opt_4c_AltPeso.Value
            ENDIF
            IF PEMSTATUS(loc_oPg6, "txt_4c_LPrecoPad", 5)
                THIS.this_oBusinessObject.this_cLprecopads = ALLTRIM(loc_oPg6.txt_4c_LPrecoPad.Value)
            ENDIF

            *-- Pagina 7: Div
            IF PEMSTATUS(loc_oPg7, "opt_4c_DivVar", 5)
                THIS.this_oBusinessObject.this_nVars = loc_oPg7.opt_4c_DivVar.Value
            ENDIF

            *-- Pagina 8: Diversos
            IF PEMSTATUS(loc_oPg8, "chk_4c_Digenves", 5)
                THIS.this_oBusinessObject.this_nDigenves = IIF(loc_oPg8.chk_4c_Digenves.Value = 1, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg8, "chk_4c_Digrecs", 5)
                THIS.this_oBusinessObject.this_nDigrecs = IIF(loc_oPg8.chk_4c_Digrecs.Value = 1, 1, 0)
            ENDIF

            *-- Pagina 17: Comissao
            IF PEMSTATUS(loc_oPg17, "chk_4c_Grupov", 5)
                THIS.this_oBusinessObject.this_lFixgvends = (loc_oPg17.chk_4c_Grupov.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg17, "txt_4c_Grupov", 5)
                THIS.this_oBusinessObject.this_cGrvends = ALLTRIM(loc_oPg17.txt_4c_Grupov.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg17, "txt_4c_MascVen", 5)
                THIS.this_oBusinessObject.this_cMascvens = ALLTRIM(loc_oPg17.txt_4c_MascVen.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg17, "opt_4c_Vende", 5)
                THIS.this_oBusinessObject.this_nVendes = loc_oPg17.opt_4c_Vende.Value
            ENDIF
            IF PEMSTATUS(loc_oPg17, "opt_4c_CadCli", 5)
                THIS.this_oBusinessObject.this_nCadclis = loc_oPg17.opt_4c_CadCli.Value
            ENDIF

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
        LOCAL loc_lResultado, loc_oPagDados, loc_cDopes
        LOCAL loc_oPg1, loc_oPg2, loc_oPg3, loc_oPg4, loc_oPg5, loc_oPg6, loc_oPg7, loc_oPg8, loc_oPg17
        LOCAL loc_oBO
        loc_lResultado = .F.
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                    loc_oBO = THIS.this_oBusinessObject

                    *-- Cabecalho
                    loc_oPagDados.txt_4c_Codigo.Value    = ALLTRIM(loc_oBO.this_cDopes)
                    loc_oPagDados.txt_4c_Descricao.Value = ALLTRIM(loc_oBO.this_cTitopes)
                    loc_oPagDados.txt_4c_Tipo.Value      = TRANSFORM(loc_oBO.this_nTipoops)
                    IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
                        loc_oPagDados.cbo_4c_Menu.Value  = ALLTRIM(loc_oBO.this_cMenus)
                    ENDIF

                    loc_oPg1  = loc_oPagDados.pgf_4c_PagDados.Page1
                    loc_oPg2  = loc_oPagDados.pgf_4c_PagDados.Page2
                    loc_oPg3  = loc_oPagDados.pgf_4c_PagDados.Page3
                    loc_oPg4  = loc_oPagDados.pgf_4c_PagDados.Page4
                    loc_oPg5  = loc_oPagDados.pgf_4c_PagDados.Page5
                    loc_oPg6  = loc_oPagDados.pgf_4c_PagDados.Page6
                    loc_oPg7  = loc_oPagDados.pgf_4c_PagDados.Page7
                    loc_oPg8  = loc_oPagDados.pgf_4c_PagDados.Page8
                    loc_oPg17 = loc_oPagDados.pgf_4c_PagDados.Page17

                    *-- Pagina 1: Operacao
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Blqdt", 5)
                        loc_oPg1.opt_4c_Blqdt.Value = IIF(loc_oBO.this_nBlqdatas > 0, loc_oBO.this_nBlqdatas, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Conf", 5)
                        loc_oPg1.opt_4c_Conf.Value = loc_oBO.this_nConfes
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Bloqueio", 5)
                        loc_oPg1.opt_4c_Bloqueio.Value = loc_oBO.this_nAciosens
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_DopeSTrfs", 5)
                        loc_oPg1.txt_4c_DopeSTrfs.Value = ALLTRIM(loc_oBO.this_cDopestrfs)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_DopeETrfs", 5)
                        loc_oPg1.txt_4c_DopeETrfs.Value = ALLTRIM(loc_oBO.this_cDopeetrfs)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_Central", 5)
                        loc_oPg1.txt_4c_Central.Value = ALLTRIM(loc_oBO.this_cCcentrals)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "chk_4c_CarESubN", 5)
                        loc_oPg1.chk_4c_CarESubN.Value = IIF(loc_oBO.this_nCempsubns = 1, 1, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "chk_4c_VincEstM", 5)
                        loc_oPg1.chk_4c_VincEstM.Value = IIF(loc_oBO.this_nMestoqs = 1, 1, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_EmpPad", 5)
                        loc_oPg1.txt_4c_EmpPad.Value = ALLTRIM(loc_oBO.this_cEmppads)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Tipo", 5)
                        loc_oPg1.opt_4c_Tipo.Value = IIF(loc_oBO.this_nOpers > 0, loc_oBO.this_nOpers, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Cai", 5)
                        loc_oPg1.opt_4c_Cai.Value = IIF(loc_oBO.this_nCaixas > 0, loc_oBO.this_nCaixas, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "mem_4c_ObsOpe", 5)
                        loc_oPg1.mem_4c_ObsOpe.Value = ALLTRIM(loc_oBO.this_mObsopes)
                    ENDIF

                    *-- Pagina 2: Itens
                    IF PEMSTATUS(loc_oPg2, "opt_4c_Cbar", 5)
                        loc_oPg2.opt_4c_Cbar.Value = IIF(loc_oBO.this_nCodbars > 0, loc_oBO.this_nCodbars, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "opt_4c_Imagem", 5)
                        loc_oPg2.opt_4c_Imagem.Value = IIF(loc_oBO.this_nImagems > 0, loc_oBO.this_nImagems, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "opt_4c_ObsItems", 5)
                        loc_oPg2.opt_4c_ObsItems.Value = IIF(loc_oBO.this_nObsitems > 0, loc_oBO.this_nObsitems, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "opt_4c_Desmemb", 5)
                        loc_oPg2.opt_4c_Desmemb.Value = IIF(loc_oBO.this_nDesmembs > 0, loc_oBO.this_nDesmembs, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "opt_4c_ChkQtds", 5)
                        loc_oPg2.opt_4c_ChkQtds.Value = IIF(loc_oBO.this_nChkqtds > 0, loc_oBO.this_nChkqtds, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "txt_4c_QtdIte", 5)
                        loc_oPg2.txt_4c_QtdIte.Value = TRANSFORM(loc_oBO.this_nQtdites)
                    ENDIF

                    *-- Pagina 3: Financeiro
                    IF PEMSTATUS(loc_oPg3, "opt_4c_Che", 5)
                        loc_oPg3.opt_4c_Che.Value = IIF(loc_oBO.this_nCheqs > 0, loc_oBO.this_nCheqs, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "opt_4c_Contas", 5)
                        loc_oPg3.opt_4c_Contas.Value = IIF(loc_oBO.this_nParcontas > 0, loc_oBO.this_nParcontas, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "opt_4c_LimCre", 5)
                        loc_oPg3.opt_4c_LimCre.Value = IIF(loc_oBO.this_nLimcres > 0, loc_oBO.this_nLimcres, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "opt_4c_Troco", 5)
                        loc_oPg3.opt_4c_Troco.Value = IIF(loc_oBO.this_nTrocoauts > 0, loc_oBO.this_nTrocoauts, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "txt_4c_OpChqEnt", 5)
                        loc_oPg3.txt_4c_OpChqEnt.Value = ALLTRIM(loc_oBO.this_cOperchqes)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "txt_4c_OpChqSai", 5)
                        loc_oPg3.txt_4c_OpChqSai.Value = ALLTRIM(loc_oBO.this_cOperchqss)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "txt_4c_Conta", 5)
                        loc_oPg3.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContas)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "txt_4c_Grupo", 5)
                        loc_oPg3.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupos)
                    ENDIF

                    *-- Pagina 4: Fiscal
                    IF PEMSTATUS(loc_oPg4, "txt_4c_Especies", 5)
                        loc_oPg4.txt_4c_Especies.Value = ALLTRIM(loc_oBO.this_cEspecies)
                    ENDIF
                    IF PEMSTATUS(loc_oPg4, "txt_4c_Series", 5)
                        loc_oPg4.txt_4c_Series.Value = ALLTRIM(loc_oBO.this_cSeries)
                    ENDIF
                    IF PEMSTATUS(loc_oPg4, "txt_4c_CfoPad", 5)
                        loc_oPg4.txt_4c_CfoPad.Value = ALLTRIM(loc_oBO.this_cCfos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg4, "opt_4c_TipoNF", 5)
                        loc_oPg4.opt_4c_TipoNF.Value = IIF(loc_oBO.this_nTiponfs > 0, loc_oBO.this_nTiponfs, 1)
                    ENDIF

                    *-- Pagina 5: Documento
                    IF PEMSTATUS(loc_oPg5, "opt_4c_DigDoc", 5)
                        loc_oPg5.opt_4c_DigDoc.Value = IIF(loc_oBO.this_nDigdoc > 0, loc_oBO.this_nDigdoc, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg5, "opt_4c_EditDocs", 5)
                        loc_oPg5.opt_4c_EditDocs.Value = IIF(loc_oBO.this_nEditdocs > 0, loc_oBO.this_nEditdocs, 1)
                    ENDIF

                    *-- Pagina 6: Preco
                    IF PEMSTATUS(loc_oPg6, "opt_4c_AltPreco", 5)
                        loc_oPg6.opt_4c_AltPreco.Value = IIF(loc_oBO.this_nEprecos > 0, loc_oBO.this_nEprecos, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg6, "opt_4c_AltPeso", 5)
                        loc_oPg6.opt_4c_AltPeso.Value = IIF(loc_oBO.this_nEpesos > 0, loc_oBO.this_nEpesos, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg6, "txt_4c_LPrecoPad", 5)
                        loc_oPg6.txt_4c_LPrecoPad.Value = ALLTRIM(loc_oBO.this_cLprecopads)
                    ENDIF

                    *-- Pagina 7: Div
                    IF PEMSTATUS(loc_oPg7, "opt_4c_DivVar", 5)
                        loc_oPg7.opt_4c_DivVar.Value = IIF(loc_oBO.this_nVars > 0, loc_oBO.this_nVars, 1)
                    ENDIF

                    *-- Pagina 8: Diversos
                    IF PEMSTATUS(loc_oPg8, "chk_4c_Digenves", 5)
                        loc_oPg8.chk_4c_Digenves.Value = IIF(loc_oBO.this_nDigenves = 1, 1, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oPg8, "chk_4c_Digrecs", 5)
                        loc_oPg8.chk_4c_Digrecs.Value = IIF(loc_oBO.this_nDigrecs = 1, 1, 0)
                    ENDIF

                    *-- Pagina 17: Comissao
                    IF PEMSTATUS(loc_oPg17, "chk_4c_Grupov", 5)
                        loc_oPg17.chk_4c_Grupov.Value = IIF(loc_oBO.this_lFixgvends, 1, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oPg17, "txt_4c_Grupov", 5)
                        loc_oPg17.txt_4c_Grupov.Value = ALLTRIM(loc_oBO.this_cGrvends)
                    ENDIF
                    IF PEMSTATUS(loc_oPg17, "txt_4c_MascVen", 5)
                        loc_oPg17.txt_4c_MascVen.Value = ALLTRIM(loc_oBO.this_cMascvens)
                    ENDIF
                    IF PEMSTATUS(loc_oPg17, "opt_4c_Vende", 5)
                        loc_oPg17.opt_4c_Vende.Value = IIF(loc_oBO.this_nVendes > 0, loc_oBO.this_nVendes, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg17, "opt_4c_CadCli", 5)
                        loc_oPg17.opt_4c_CadCli.Value = IIF(loc_oBO.this_nCadclis > 0, loc_oBO.this_nCadclis, 1)
                    ENDIF

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
        LOCAL loc_oPagDados
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPagDados.txt_4c_Codigo.ReadOnly    = !par_lHabilitar
            loc_oPagDados.txt_4c_Descricao.ReadOnly = !par_lHabilitar
            loc_oPagDados.txt_4c_Tipo.ReadOnly       = !par_lHabilitar
            IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
                loc_oPagDados.cbo_4c_Menu.Enabled = par_lHabilitar
            ENDIF
            *-- Habilitar recursivamente todos os controles das paginas internas
            IF PEMSTATUS(loc_oPagDados, "pgf_4c_PagDados", 5)
                THIS.HabilitarControlesRecursivo(loc_oPagDados.pgf_4c_PagDados, par_lHabilitar)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarControlesRecursivo - Percorre recursivamente e ajusta ReadOnly/Enabled
    *==========================================================================
    PROTECTED PROCEDURE HabilitarControlesRecursivo(par_oContainer, par_lHabilitar)
        LOCAL loc_nI, loc_oObj, loc_nP, loc_cCls
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObj = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObj) = "O"
                loc_cCls = UPPER(loc_oObj.BaseClass)
                DO CASE
                CASE loc_cCls = "TEXTBOX" OR loc_cCls = "EDITBOX"
                    IF PEMSTATUS(loc_oObj, "ReadOnly", 5)
                        loc_oObj.ReadOnly = !par_lHabilitar
                    ENDIF
                CASE loc_cCls = "CHECKBOX" OR loc_cCls = "OPTIONGROUP" OR loc_cCls = "COMBOBOX" OR loc_cCls = "SPINNER"
                    IF PEMSTATUS(loc_oObj, "Enabled", 5)
                        loc_oObj.Enabled = par_lHabilitar
                    ENDIF
                CASE loc_cCls = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObj.PageCount
                        THIS.HabilitarControlesRecursivo(loc_oObj.Pages(loc_nP), par_lHabilitar)
                    ENDFOR
                CASE loc_cCls = "CONTAINER"
                    THIS.HabilitarControlesRecursivo(loc_oObj, par_lHabilitar)
                ENDCASE
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de edicao
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagDados
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPagDados.txt_4c_Codigo.Value    = ""
            loc_oPagDados.txt_4c_Descricao.Value = ""
            loc_oPagDados.txt_4c_Tipo.Value      = "0"
            IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
                loc_oPagDados.cbo_4c_Menu.Value = ""
            ENDIF
            *-- Limpar todos os controles das paginas internas
            IF PEMSTATUS(loc_oPagDados, "pgf_4c_PagDados", 5)
                THIS.LimparControlesRecursivo(loc_oPagDados.pgf_4c_PagDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparControlesRecursivo - Reset de todos controles a defaults
    *==========================================================================
    PROTECTED PROCEDURE LimparControlesRecursivo(par_oContainer)
        LOCAL loc_nI, loc_oObj, loc_nP, loc_cCls
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObj = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObj) = "O"
                loc_cCls = UPPER(loc_oObj.BaseClass)
                DO CASE
                CASE loc_cCls = "TEXTBOX" OR loc_cCls = "EDITBOX"
                    IF PEMSTATUS(loc_oObj, "Value", 5)
                        IF VARTYPE(loc_oObj.Value) = "N"
                            loc_oObj.Value = 0
                        ELSE
                            loc_oObj.Value = ""
                        ENDIF
                    ENDIF
                CASE loc_cCls = "CHECKBOX"
                    loc_oObj.Value = 0
                CASE loc_cCls = "OPTIONGROUP"
                    loc_oObj.Value = 1
                CASE loc_cCls = "COMBOBOX"
                    loc_oObj.Value = ""
                CASE loc_cCls = "SPINNER"
                    loc_oObj.Value = 0
                CASE loc_cCls = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObj.PageCount
                        THIS.LimparControlesRecursivo(loc_oObj.Pages(loc_nP))
                    ENDFOR
                CASE loc_cCls = "CONTAINER"
                    THIS.LimparControlesRecursivo(loc_oObj)
                ENDCASE
            ENDIF
        ENDFOR
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

    *==========================================================================
    * Helpers de criacao rapida (reduzem verbosidade)
    *==========================================================================
    PROTECTED PROCEDURE AddLabel(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
        par_oPag.AddObject(par_cName, "Label")
        WITH EVALUATE("par_oPag." + par_cName)
            .Caption   = par_cCaption
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE AddTextBox(par_oPag, par_cName, par_nTop, par_nLeft, par_nWidth, par_nMaxLen)
        par_oPag.AddObject(par_cName, "TextBox")
        WITH EVALUATE("par_oPag." + par_cName)
            .Value         = ""
            .Top           = par_nTop
            .Left          = par_nLeft
            .Width         = par_nWidth
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = par_nMaxLen
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE AddCheckBox(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
        par_oPag.AddObject(par_cName, "CheckBox")
        WITH EVALUATE("par_oPag." + par_cName)
            .Caption   = par_cCaption
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Value     = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE AddOptGroupSN(par_oPag, par_cName, par_nTop, par_nLeft, par_nWidth)
        *-- Cria OptionGroup padrao "Sim / Nao" (2 botoes horizontais)
        par_oPag.AddObject(par_cName, "OptionGroup")
        WITH EVALUATE("par_oPag." + par_cName)
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Top           = par_nTop
            .Left          = par_nLeft
            .Width         = par_nWidth
            .Height        = 22
            .Value         = 1
            .Themes        = .F.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontName  = "Tahoma"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Top       = 3
            .Buttons(1).Left      = 5
            .Buttons(1).Width     = 45
            .Buttons(1).Height    = 17
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).AutoSize  = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontName  = "Tahoma"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Top       = 3
            .Buttons(2).Left      = 60
            .Buttons(2).Width     = 45
            .Buttons(2).Height    = 17
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).AutoSize  = .F.
            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPagOperacao - Popula Page1 (Operacao) do PageFrame interno
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagOperacao(par_oPagina)
        TRY
            *-- Numeracao label
            THIS.AddLabel(par_oPagina, "lbl_4c_Numeracao", "Numera" + CHR(231) + CHR(227) + "o :", 11, 78, 63)
            *-- Bloqueio de alterar data (OptionGroup 4 botoes)
            THIS.AddLabel(par_oPagina, "lbl_4c_BlqDt", "Bloq. Alterar Data :", 45, 46, 95)
            par_oPagina.AddObject("opt_4c_Blqdt", "OptionGroup")
            WITH par_oPagina.opt_4c_Blqdt
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 43
                .Left          = 145
                .Width         = 248
                .Height        = 32
                .Value         = 1
                .Themes        = .F.
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Value   = 1
                .Buttons(1).Top     = 2
                .Buttons(1).Left    = 5
                .Buttons(1).Width   = 40
                .Buttons(1).Height  = 17
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName  = "Tahoma"
                .Buttons(1).FontSize  = 8
                .Buttons(1).ForeColor = RGB(90, 90, 90)
                .Buttons(1).AutoSize  = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Top     = 15
                .Buttons(2).Left    = 5
                .Buttons(2).Width   = 40
                .Buttons(2).Height  = 17
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName  = "Tahoma"
                .Buttons(2).FontSize  = 8
                .Buttons(2).ForeColor = RGB(90, 90, 90)
                .Buttons(2).AutoSize  = .F.
                .Buttons(3).Caption = "Subn" + CHR(237) + "vel Sim"
                .Buttons(3).Top     = 2
                .Buttons(3).Left    = 110
                .Buttons(3).Width   = 100
                .Buttons(3).Height  = 15
                .Buttons(3).BackStyle = 0
                .Buttons(3).FontName  = "Tahoma"
                .Buttons(3).FontSize  = 8
                .Buttons(3).ForeColor = RGB(90, 90, 90)
                .Buttons(3).AutoSize  = .T.
                .Buttons(4).Caption = "Subn" + CHR(237) + "vel N" + CHR(227) + "o"
                .Buttons(4).Top     = 15
                .Buttons(4).Left    = 110
                .Buttons(4).Width   = 100
                .Buttons(4).Height  = 15
                .Buttons(4).BackStyle = 0
                .Buttons(4).FontName  = "Tahoma"
                .Buttons(4).FontSize  = 8
                .Buttons(4).ForeColor = RGB(90, 90, 90)
                .Buttons(4).AutoSize  = .T.
                .Visible = .T.
            ENDWITH

            *-- Conferencia (S/N)
            THIS.AddLabel(par_oPagina, "lbl_4c_Conf", "Confer" + CHR(234) + "ncia :", 181, 74, 67)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Conf", 179, 145, 248)

            *-- Verificar Bloqueio (Aciosens)
            THIS.AddLabel(par_oPagina, "lbl_4c_VerBlq", "Verificar Bloqueio :", 221, 516, 91)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Bloqueio", 219, 611, 175)

            *-- Transferencia de Saida
            THIS.AddLabel(par_oPagina, "lbl_4c_MovSai", "Movimenta" + CHR(231) + CHR(227) + "o de Sa" + CHR(237) + "da :", 309, 340, 145)
            THIS.AddTextBox(par_oPagina, "txt_4c_DopeSTrfs", 306, 486, 150, 20)

            *-- Movimentacao de Entrada
            THIS.AddLabel(par_oPagina, "lbl_4c_MovEnt", "Movimenta" + CHR(231) + CHR(227) + "o de Entrada :", 331, 340, 145)
            THIS.AddTextBox(par_oPagina, "txt_4c_DopeETrfs", 328, 486, 150, 20)

            *-- Central
            THIS.AddLabel(par_oPagina, "lbl_4c_Central", "Central :", 258, 90, 50)
            THIS.AddTextBox(par_oPagina, "txt_4c_Central", 255, 145, 50, 2)

            *-- Empresa Padrao
            THIS.AddLabel(par_oPagina, "lbl_4c_EmpPad", "Empresa Padr" + CHR(227) + "o :", 388, 60, 80)
            THIS.AddTextBox(par_oPagina, "txt_4c_EmpPad", 385, 145, 50, 3)

            *-- CheckBoxes
            THIS.AddCheckBox(par_oPagina, "chk_4c_CarESubN", "Carregar E-Subn" + CHR(237) + "vel", 415, 145, 180)
            THIS.AddCheckBox(par_oPagina, "chk_4c_VincEstM", "Vincular Est. Mestre", 435, 145, 180)

            *-- Tipo (Opers)
            THIS.AddLabel(par_oPagina, "lbl_4c_Tipo1", "Tipo :", 460, 100, 45)
            par_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
            WITH par_oPagina.opt_4c_Tipo
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 458
                .Left          = 145
                .Width         = 250
                .Height        = 22
                .Value         = 1
                .Themes        = .F.
                .Buttons(1).Caption = "Sa" + CHR(237) + "da"
                .Buttons(1).Value   = 1
                .Buttons(1).Top     = 3
                .Buttons(1).Left    = 5
                .Buttons(1).Width   = 60
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName  = "Tahoma"
                .Buttons(1).FontSize  = 8
                .Buttons(1).ForeColor = RGB(90, 90, 90)
                .Buttons(2).Caption = "Entrada"
                .Buttons(2).Top     = 3
                .Buttons(2).Left    = 70
                .Buttons(2).Width   = 60
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName  = "Tahoma"
                .Buttons(2).FontSize  = 8
                .Buttons(2).ForeColor = RGB(90, 90, 90)
                .Buttons(3).Caption = "Nenhum"
                .Buttons(3).Top     = 3
                .Buttons(3).Left    = 140
                .Buttons(3).Width   = 60
                .Buttons(3).BackStyle = 0
                .Buttons(3).FontName  = "Tahoma"
                .Buttons(3).FontSize  = 8
                .Buttons(3).ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            *-- Caixa
            THIS.AddLabel(par_oPagina, "lbl_4c_Cai", "Caixa :", 490, 100, 45)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Cai", 488, 145, 120)

            *-- Observacao (EditBox)
            THIS.AddLabel(par_oPagina, "lbl_4c_ObsOpe", "Observa" + CHR(231) + CHR(245) + "es :", 520, 60, 80)
            par_oPagina.AddObject("mem_4c_ObsOpe", "EditBox")
            WITH par_oPagina.mem_4c_ObsOpe
                .Value       = ""
                .Top         = 518
                .Left        = 145
                .Width       = 640
                .Height      = 60
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(0, 0, 0)
                .BorderStyle = 1
                .SpecialEffect = 1
                .Visible     = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagOperacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagItens - Popula Page2 (Itens)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagItens(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_CBar", "C" + CHR(243) + "d. Barras :", 20, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Cbar", 18, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_Imagem", "Imagem :", 50, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Imagem", 48, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_ObsItems", "Obs. Itens :", 80, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_ObsItems", 78, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_Desmemb", "Desmembra :", 110, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Desmemb", 108, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_ChkQtds", "Check Qtd :", 140, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_ChkQtds", 138, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_QtdIte", "Qtde. Itens :", 175, 30, 80)
            THIS.AddTextBox(par_oPagina, "txt_4c_QtdIte", 172, 120, 60, 4)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagItens")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagFinanceiro - Popula Page3 (Financeiro)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagFinanceiro(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_Che", "Cheque :", 20, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Che", 18, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_Contas", "Contas :", 50, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Contas", 48, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_LimCre", "Lim. Cr" + CHR(233) + "dito :", 80, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_LimCre", 78, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_Troco", "Troco Auto :", 110, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Troco", 108, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_OpChqEnt", "Op. Cheq. Entr. :", 145, 30, 100)
            THIS.AddTextBox(par_oPagina, "txt_4c_OpChqEnt", 142, 145, 150, 15)

            THIS.AddLabel(par_oPagina, "lbl_4c_OpChqSai", "Op. Cheq. Sa" + CHR(237) + "da :", 175, 30, 100)
            THIS.AddTextBox(par_oPagina, "txt_4c_OpChqSai", 172, 145, 150, 15)

            THIS.AddLabel(par_oPagina, "lbl_4c_Conta", "Conta :", 205, 30, 60)
            THIS.AddTextBox(par_oPagina, "txt_4c_Conta", 202, 145, 100, 10)

            THIS.AddLabel(par_oPagina, "lbl_4c_Grupo", "Grupo :", 235, 30, 60)
            THIS.AddTextBox(par_oPagina, "txt_4c_Grupo", 232, 145, 100, 10)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagFinanceiro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagFiscal - Popula Page4 (Fiscal)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagFiscal(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_Especies", "Esp" + CHR(233) + "cie :", 20, 30, 60)
            THIS.AddTextBox(par_oPagina, "txt_4c_Especies", 17, 120, 80, 6)

            THIS.AddLabel(par_oPagina, "lbl_4c_Series", "S" + CHR(233) + "rie :", 50, 30, 60)
            THIS.AddTextBox(par_oPagina, "txt_4c_Series", 47, 120, 80, 3)

            THIS.AddLabel(par_oPagina, "lbl_4c_CfoPad", "CFO Padr" + CHR(227) + "o :", 80, 30, 80)
            THIS.AddTextBox(par_oPagina, "txt_4c_CfoPad", 77, 120, 100, 10)

            THIS.AddLabel(par_oPagina, "lbl_4c_TipoNF", "Tipo NF :", 110, 30, 60)
            par_oPagina.AddObject("opt_4c_TipoNF", "OptionGroup")
            WITH par_oPagina.opt_4c_TipoNF
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 108
                .Left          = 120
                .Width         = 260
                .Height        = 22
                .Value         = 1
                .Themes        = .F.
                .Buttons(1).Caption = "Entrada"
                .Buttons(1).Top     = 3
                .Buttons(1).Left    = 5
                .Buttons(1).Width   = 70
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName  = "Tahoma"
                .Buttons(1).FontSize  = 8
                .Buttons(2).Caption = "Sa" + CHR(237) + "da"
                .Buttons(2).Top     = 3
                .Buttons(2).Left    = 80
                .Buttons(2).Width   = 70
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName  = "Tahoma"
                .Buttons(2).FontSize  = 8
                .Buttons(3).Caption = "Nenhum"
                .Buttons(3).Top     = 3
                .Buttons(3).Left    = 155
                .Buttons(3).Width   = 70
                .Buttons(3).BackStyle = 0
                .Buttons(3).FontName  = "Tahoma"
                .Buttons(3).FontSize  = 8
                .Visible = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagFiscal")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagDocumento - Popula Page5 (Documento)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagDocumento(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_DigDoc", "Digita Doc :", 20, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_DigDoc", 18, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_EditDocs", "Editar Docs :", 50, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_EditDocs", 48, 120, 120)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagDocumento")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagPreco - Popula Page6 (Preco)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagPreco(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_AltPreco", "Altera Pre" + CHR(231) + "o :", 20, 30, 100)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPreco", 18, 140, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_AltPeso", "Altera Peso :", 50, 30, 100)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPeso", 48, 140, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_LPrecoPad", "Lista Pre" + CHR(231) + "o Padr" + CHR(227) + "o :", 80, 30, 120)
            THIS.AddTextBox(par_oPagina, "txt_4c_LPrecoPad", 77, 155, 200, 30)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagPreco")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagDiv - Popula Page7 (Div)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagDiv(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_DivVar", "Var. Div. :", 20, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_DivVar", 18, 120, 120)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagDiv")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagDiversos - Popula Page8 (Diversos)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagDiversos(par_oPagina)
        TRY
            THIS.AddCheckBox(par_oPagina, "chk_4c_Digenves", "Digitar Envelope", 20, 30, 200)
            THIS.AddCheckBox(par_oPagina, "chk_4c_Digrecs", "Digitar Recebimento", 45, 30, 200)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagDiversos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagComissao - Popula Page17 (Comissao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagComissao(par_oPagina)
        TRY
            THIS.AddCheckBox(par_oPagina, "chk_4c_Grupov", "Fixar Grupo Vend.", 20, 30, 180)
            THIS.AddLabel(par_oPagina, "lbl_4c_Grupov", "Grupo Vend. :", 45, 30, 90)
            THIS.AddTextBox(par_oPagina, "txt_4c_Grupov", 42, 130, 120, 20)

            THIS.AddLabel(par_oPagina, "lbl_4c_MascVen", "M" + CHR(225) + "scara Vend. :", 75, 30, 90)
            THIS.AddTextBox(par_oPagina, "txt_4c_MascVen", 72, 130, 120, 20)

            THIS.AddLabel(par_oPagina, "lbl_4c_Vende", "Vendedor :", 105, 30, 80)
            par_oPagina.AddObject("opt_4c_Vende", "OptionGroup")
            WITH par_oPagina.opt_4c_Vende
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 103
                .Left          = 130
                .Width         = 260
                .Height        = 22
                .Value         = 1
                .Themes        = .F.
                .Buttons(1).Caption = "Obrigat" + CHR(243) + "rio"
                .Buttons(1).Top     = 3
                .Buttons(1).Left    = 5
                .Buttons(1).Width   = 80
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName  = "Tahoma"
                .Buttons(1).FontSize  = 8
                .Buttons(2).Caption = "Opcional"
                .Buttons(2).Top     = 3
                .Buttons(2).Left    = 90
                .Buttons(2).Width   = 70
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName  = "Tahoma"
                .Buttons(2).FontSize  = 8
                .Buttons(3).Caption = "N" + CHR(227) + "o"
                .Buttons(3).Top     = 3
                .Buttons(3).Left    = 165
                .Buttons(3).Width   = 50
                .Buttons(3).BackStyle = 0
                .Buttons(3).FontName  = "Tahoma"
                .Buttons(3).FontSize  = 8
                .Visible = .T.
            ENDWITH

            THIS.AddLabel(par_oPagina, "lbl_4c_CadCli", "Cad. Cliente :", 140, 30, 90)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_CadCli", 138, 130, 120)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagComissao")
        ENDTRY
    ENDPROC

ENDDEFINE
