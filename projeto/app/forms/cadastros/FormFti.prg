*==============================================================================
* FormFti.prg - Cadastro de Feitios
* Tabela: SigPrFti (PK: cods) / Itens: SigPrFto
* Herda de: FormBase
* Gerado: Fase 8/8 - COMPLETO (todos os metodos, integracao menu/config)
*==============================================================================

DEFINE CLASS FormFti AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Feitios"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cUltCodigo      = ""
    this_cAntValue       = ""

    *==========================================================================
    * Init - Inicializacao delegada ao FormBase (que chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro em FormFti.Init:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("FtiBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.CriarCursoresGrade()
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.this_oBusinessObject.CarregarParametros()
                        MsgErro("Erro ao carregar par" + CHR(226) + "metros de feitios", "Erro")
                    ENDIF
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao criar FtiBO", "Erro")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormFti.InicializarForm:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + ;
                    CHR(13) + "Proc: " + loException.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarCursoresGrade - Cria cursores csGrade e csCusto (locais, sem SQL Server)
    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresGrade()
        IF USED("csGrade")
            USE IN csGrade
        ENDIF
        SET NULL ON
        CREATE CURSOR csGrade (Cgrus C(3), CPros C(14), Dgrus C(20), Coefs N(8,4), Ordem N(1,0))
        SET NULL OFF
        SELECT csGrade
        INDEX ON CPros TAG CPros

        IF USED("csCusto")
            USE IN csCusto
        ENDIF
        SET NULL ON
        CREATE CURSOR csCusto (Cpros C(14), Dpros C(40), Seqs N(5), Coefs N(8,4))
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(200, 200, 200)
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(200, 200, 200)

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Estrutura da Page1 (Lista)
    * Criados aqui: cntSombra, cnt_4c_Botoes(shell), cnt_4c_Saida, XML buttons
    * Grid e botoes CRUD: Fase 4
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (cntSombra: Top=1, Left=-1, Width=1008, H=80 -> comp +29)
        loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
        WITH loc_oPagina.cnt_4c_Sombra
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .AutoSize  = .F.
            .Caption   = "Cadastro de Feitios"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .AutoSize  = .F.
            .Caption   = "Cadastro de Feitios"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op: Left=543, Top=-1+29=28, W=385, H=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container Saida canonico (Left=917, Top=29, Width=90, Height=85)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botao Exporta XML (Top=83+29=112, Left=712, W=105, H=45)
        loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnExpXML
            .Caption         = "Exporta XML"
            .Top             = 112
            .Left            = 712
            .Width           = 105
            .Height          = 45
            .Picture         = gc_4c_CaminhoIcones + "exportar_48.png"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .ToolTipText     = "Exporta Opera" + CHR(231) + CHR(227) + "o Para Um Arquivo XML"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML, "Click", THIS, "BtnExpXMLClick")

        *-- Botao Importa XML (Top=83+29=112, Left=818, W=105, H=45)
        loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnImpXML
            .Caption         = "Importa XML"
            .Top             = 112
            .Left            = 818
            .Width           = 105
            .Height          = 45
            .Picture         = gc_4c_CaminhoIcones + "importar_48.png"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .ToolTipText     = "Importa Opera" + CHR(231) + CHR(227) + "o De Um Arquivo XML"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML, "Click", THIS, "BtnImpXMLClick")

        *-- Grid principal de lista (Grade: Top=133+29=162, Left=12, W=940, H=458)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 162
            .Left              = 12
            .Width             = 940
            .Height            = 458
            .ColumnCount       = 2
            .FontName          = "Verdana"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .GridLineColor     = RGB(90, 90, 90)
            .RowHeight         = 16
            .HeaderHeight      = 16
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .ReadOnly          = .T.
            .Visible           = .T.
        ENDWITH
        WITH loc_oPagina.grd_4c_Lista.Column1
            .ControlSource = "cursor_4c_Dados.cods"
            .Width         = 50
            .Movable       = .F.
            .Resizable     = .F.
        ENDWITH
        loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
        WITH loc_oPagina.grd_4c_Lista.Column2
            .ControlSource = "cursor_4c_Dados.descs"
            .Width         = 270
            .Movable       = .F.
            .Resizable     = .F.
        ENDWITH
        loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)

        *-- Botoes CRUD dentro de cnt_4c_Botoes (Left=5/80/155/230/305, Top=5, W=75, H=75)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Estrutura da Page2 (Dados)
    * Criados aqui: cnt_4c_Salva, cnt_4c_BotoesLinha, pgf_4c_Configuracao(shell)
    * TextBoxes e OptionGroups: Fases 5-6
    * Grids de configuracao: Fase 4
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (Grupo_Salva: Left=818, Top=10+29=39, W=160, H=85)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 39
            .Left        = 818
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Container botao Excluir Linha da grade (cmdBotoes: Top=361+29=390, Left=755, W=85)
        loc_oPagina.AddObject("cnt_4c_BotoesLinha", "Container")
        WITH loc_oPagina.cnt_4c_BotoesLinha
            .Top         = 390
            .Left        = 755
            .Width       = 85
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesLinha.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")

        *-- PageFrame Configuracao aninhado (Top=184+29=213, Left=-2, W=1003, H=420)
        loc_oPagina.AddObject("pgf_4c_Configuracao", "PageFrame")
        WITH loc_oPagina.pgf_4c_Configuracao
            .Top       = 213
            .Left      = -2
            .Width     = 1003
            .Height    = 420
            .PageCount = 2
            .Tabs      = .T.
            .Visible   = .T.
        ENDWITH
        loc_oPagina.pgf_4c_Configuracao.Page1.Caption = "Grupos de Produto"
        loc_oPagina.pgf_4c_Configuracao.Page2.Caption = "Custos Fixo"

        *-- =================================================================
        *-- CAMPOS PRINCIPAIS DA PAGE2 - PARTE 1 (Fase 5/8)
        *-- =================================================================

        *-- Label1: "Código : " (top=12+29=41, left=121, W=45, H=15)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo : "
            .Top       = 41
            .Left      = 121
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Codigo: (top=8+29=37, left=166, W=34, H=23)
        *-- When original: InList(ThisForm.pcEscolha,'INSERIR','PROCURAR') -> so editavel em INCLUIR
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 37
            .Left      = 166
            .Width     = 34
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .MaxLength = 4
            .Visible   = .T.
        ENDWITH

        *-- Label2: "Descrição : " (top=12+29=41, left=215, W=58, H=15)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 41
            .Left      = 215
            .Width     = 58
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Descricao: (top=8+29=37, left=278, W=290, H=23)
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value     = ""
            .Top       = 37
            .Left      = 278
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .MaxLength = 30
            .Visible   = .T.
        ENDWITH

        *-- Label3: "Valor do Feitio : " (top=37+29=66, left=86, W=80, H=15)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Valor do Feitio : "
            .Top       = 66
            .Left      = 86
            .Width     = 80
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Valor: (top=34+29=63, left=166, W=150, H=23)
        loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPagina.txt_4c_Valor
            .Value     = 0
            .Top       = 63
            .Left      = 166
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .InputMask = "999,999,999.99"
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_TpFtio: (top=33+29=62, left=316, W=283, H=27, 3 buttons)
        *-- InteractiveChange: Value=3 (Sem Feitio) zera Valor e Acrescimo
        loc_oPagina.AddObject("opt_4c_TpFtio", "OptionGroup")
        WITH loc_oPagina.opt_4c_TpFtio
            .ButtonCount = 3
            .Top         = 62
            .Left        = 316
            .Width       = 283
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_TpFtio.Buttons(1)
            .Caption   = "Por Peso"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 70
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_TpFtio.Buttons(2)
            .Caption   = "Valor Adicional"
            .BackStyle = 0
            .Left      = 80
            .Top       = 5
            .Width     = 65
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_TpFtio.Buttons(3)
            .Caption   = "Informativo"
            .BackStyle = 0
            .Left      = 160
            .Top       = 5
            .Width     = 75
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_TpFtio, "InteractiveChange", THIS, "TpFtioChanged")

        *-- Label4: "Moeda : " (top=64+29=93, left=122, W=44, H=15)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Moeda : "
            .Top       = 93
            .Left      = 122
            .Width     = 44
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CdMoeda: codigo moeda (top=60+29=89, left=166, W=32, H=23)
        *-- When original: INSERIR E moeda vazia  |  Valid: fwbuscaext SigCdMoe por cmoes
        loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_CdMoeda
            .Value     = ""
            .Top       = 89
            .Left      = 166
            .Width     = 32
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .MaxLength = 6
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "KeyPress", THIS, "ValidarCdMoeda")

        *-- txt_4c_DsMoeda: descricao moeda (top=60+29=89, left=201, W=115, H=23)
        *-- When original: INSERIR E moeda vazia  |  Valid: fwbuscaext SigCdMoe por dmoes
        loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_DsMoeda
            .Value     = ""
            .Top       = 89
            .Left      = 201
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .MaxLength = 20
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "ValidarDsMoeda")

        *-- Label5: "Multiplicador : " (top=64+29=93, left=401, W=71, H=15)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Multiplicador : "
            .Top       = 93
            .Left      = 401
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Acrescimo: Multiplicador (top=60+29=89, left=474, W=94, H=23)
        loc_oPagina.AddObject("txt_4c_Acrescimo", "TextBox")
        WITH loc_oPagina.txt_4c_Acrescimo
            .Value     = 0
            .Top       = 89
            .Left      = 474
            .Width     = 94
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .InputMask = "999.9999"
            .Visible   = .T.
        ENDWITH

        *-- Label12: "sem uso :" (top=14+29=43, left=586, W=59) - OCULTO (Visible=.F. no original)
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "sem uso :"
            .Top       = 43
            .Left      = 586
            .Width     = 59
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- txt_4c_Lucro: (top=10+29=39, left=647, W=50) - OCULTO (Visible=.F. no original)
        loc_oPagina.AddObject("txt_4c_Lucro", "TextBox")
        WITH loc_oPagina.txt_4c_Lucro
            .Value     = 0
            .Top       = 39
            .Left      = 647
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        *-- =================================================================
        *-- CAMPOS PRINCIPAIS DA PAGE2 - PARTE 2 (Fase 6/8)
        *-- =================================================================

        *-- lbl_4c_Label8: "Faixa de : " (top=90+29=119, left=113)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Faixa de : "
            .Top       = 119
            .Left      = 113
            .Width     = 53
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_FaixaI: (top=86+29=115, left=166, W=94)
        loc_oPagina.AddObject("txt_4c_FaixaI", "TextBox")
        WITH loc_oPagina.txt_4c_FaixaI
            .Value         = 0
            .Top           = 115
            .Left          = 166
            .Width         = 94
            .Height        = 23
            .InputMask     = "99999.999999"
            .Alignment     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label9: "até" (top=90+29=119, left=266)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "at" + CHR(233)
            .Top       = 119
            .Left      = 266
            .Width     = 18
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Faixaf: (top=86+29=115, left=290, W=94)
        loc_oPagina.AddObject("txt_4c_Faixaf", "TextBox")
        WITH loc_oPagina.txt_4c_Faixaf
            .Value         = 0
            .Top           = 115
            .Left          = 290
            .Width         = 94
            .Height        = 23
            .InputMask     = "99999.999999"
            .Alignment     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label11: "Perda do Metal : " (top=90+29=119, left=442)
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Perda do Metal : "
            .Top       = 119
            .Left      = 442
            .Width     = 84
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Perdas: (top=86+29=115, left=528, W=40)
        loc_oPagina.AddObject("txt_4c_Perdas", "TextBox")
        WITH loc_oPagina.txt_4c_Perdas
            .Value         = 0
            .Top           = 115
            .Left          = 528
            .Width         = 40
            .Height        = 23
            .InputMask     = "99.9"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label6: "Tipo : " (top=113+29=142, left=134)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Tipo : "
            .Top       = 142
            .Left      = 134
            .Width     = 32
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_CusVenda: Custo/Venda (top=112+29=141, left=161, W=158, H=17, Value=2)
        loc_oPagina.AddObject("opt_4c_CusVenda", "OptionGroup")
        WITH loc_oPagina.opt_4c_CusVenda
            .ButtonCount   = 2
            .Top           = 141
            .Left          = 161
            .Width         = 158
            .Height        = 17
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Value         = 2
            .Visible       = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_CusVenda.Buttons(1)
            .Caption   = "Custo"
            .BackStyle = 0
            .Left      = 5
            .Top       = 1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_CusVenda.Buttons(2)
            .Caption   = "Venda"
            .BackStyle = 0
            .Left      = 98
            .Top       = 1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- lbl_4c_Label13: "Utilizado na Etiqueta : " (top=114+29=143, left=359)
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Utilizado na Etiqueta : "
            .Top       = 143
            .Left      = 359
            .Width     = 110
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_Etiquetas: Sim/Sim-AU/Não (top=108+29=137, left=474, W=182, H=25, Value=3)
        loc_oPagina.AddObject("opt_4c_Etiquetas", "OptionGroup")
        WITH loc_oPagina.opt_4c_Etiquetas
            .ButtonCount   = 3
            .Top           = 137
            .Left          = 474
            .Width         = 182
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Value         = 3
            .Visible       = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Etiquetas.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Etiquetas.Buttons(2)
            .Caption   = "Sim - AU"
            .BackStyle = 0
            .Left      = 60
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Etiquetas.Buttons(3)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 140
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- lbl_4c_Label7: "Coeficiente Custo Fixo : " (top=133+29=162, left=46)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Coeficiente Custo Fixo : "
            .Top       = 162
            .Left      = 46
            .Width     = 120
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_Cfixo: Multiplicador/Divisor (top=132+29=161, left=161, W=162, H=17, Value=1)
        loc_oPagina.AddObject("opt_4c_Cfixo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Cfixo
            .ButtonCount   = 2
            .Top           = 161
            .Left          = 161
            .Width         = 162
            .Height        = 17
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Cfixo.Buttons(1)
            .Caption   = "Multiplicador"
            .BackStyle = 0
            .Left      = 5
            .Top       = 1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Cfixo.Buttons(2)
            .Caption   = "Divisor"
            .BackStyle = 0
            .Left      = 98
            .Top       = 1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- lbl_4c_Label10: "Aplicar Sobre Custo : " (top=153+29=182, left=60)
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Aplicar Sobre Custo : "
            .Top       = 182
            .Left      = 60
            .Width     = 106
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_Fwoption1: Sim/Não (top=151+29=180, left=161, W=144, H=19, Value=2)
        loc_oPagina.AddObject("opt_4c_Fwoption1", "OptionGroup")
        WITH loc_oPagina.opt_4c_Fwoption1
            .ButtonCount   = 2
            .Top           = 180
            .Left          = 161
            .Width         = 144
            .Height        = 19
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Value         = 2
            .Visible       = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Fwoption1.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Fwoption1.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 98
            .Top       = 2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        THIS.ConfigurarPgPage1()
        THIS.ConfigurarPgPage2()
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPgPage1 - Configura grd_4c_Grade (Grupos de Produto) do pgf_4c_Configuracao.Page1
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage1()
        LOCAL loc_oPgGrupos
        loc_oPgGrupos = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1

        *-- grd_4c_Grade (Grupos de Produto: Top=16, Left=234, W=521, H=371, RecordSource=csGrade)
        loc_oPgGrupos.AddObject("grd_4c_Grade", "Grid")
        WITH loc_oPgGrupos.grd_4c_Grade
            .Top               = 16
            .Left              = 234
            .Width             = 521
            .Height            = 371
            .ColumnCount       = 5
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 16
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .RecordSource      = "csGrade"
            .Visible           = .T.
        ENDWITH
        WITH loc_oPgGrupos.grd_4c_Grade.Column1
            .ColumnOrder   = 2
            .ControlSource = "csGrade.Cgrus"
            .Width         = 42
            .Movable       = .F.
            .Resizable     = .F.
        ENDWITH
        loc_oPgGrupos.grd_4c_Grade.Column1.Header1.Caption = "Grupo"
        WITH loc_oPgGrupos.grd_4c_Grade.Column2
            .ColumnOrder   = 4
            .ControlSource = "csGrade.Dgrus"
            .Width         = 224
            .Movable       = .F.
            .Resizable     = .F.
        ENDWITH
        loc_oPgGrupos.grd_4c_Grade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        WITH loc_oPgGrupos.grd_4c_Grade.Column3
            .ColumnOrder   = 5
            .ControlSource = "csGrade.Coefs"
            .Width         = 70
            .Movable       = .F.
            .Resizable     = .F.
            .Sparse        = .F.
        ENDWITH
        loc_oPgGrupos.grd_4c_Grade.Column3.Header1.Caption = "Coeficiente"
        loc_oPgGrupos.grd_4c_Grade.Column3.Text1.InputMask = "999.9999"
        WITH loc_oPgGrupos.grd_4c_Grade.Column4
            .ColumnOrder   = 3
            .ControlSource = "csGrade.CPros"
            .Width         = 108
            .Movable       = .F.
            .Resizable     = .F.
            .Sparse        = .F.
        ENDWITH
        loc_oPgGrupos.grd_4c_Grade.Column4.Header1.Caption = "Produto"
        WITH loc_oPgGrupos.grd_4c_Grade.Column5
            .ColumnOrder   = 1
            .ControlSource = "csGrade.Ordem"
            .Width         = 42
            .Movable       = .F.
            .Resizable     = .F.
        ENDWITH
        loc_oPgGrupos.grd_4c_Grade.Column5.Header1.Caption = "Ordem"
        loc_oPgGrupos.grd_4c_Grade.Column2.ReadOnly = .T.
        BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "When",      THIS, "GradeGrupoCol1When")
        BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "Valid",     THIS, "GradeGrupoCol1Valid")
        BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "When",      THIS, "GradeGrupoCol3When")
        BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "KeyPress", THIS, "GradeGrupoCol3LostFocus")
        BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "When",      THIS, "GradeGrupoCol4When")
        BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "Valid",     THIS, "GradeGrupoCol4Valid")
    ENDPROC

    *==========================================================================
    * ConfigurarPgPage2 - Configura grd_4c_Custo (Custos Fixo) do pgf_4c_Configuracao.Page2
    * Original: SIGCDFTI.Pagina.Dados.Configuracao.Page2 - 4 colunas: Cpros/Dpros/Coefs/Seqs
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage2()
        LOCAL loc_oPgCusto
        loc_oPgCusto = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2

        *-- grd_4c_Custo (Custo Fixo: Top=16, Left=278, W=478, H=371, RecordSource=csCusto)
        loc_oPgCusto.AddObject("grd_4c_Custo", "Grid")
        WITH loc_oPgCusto.grd_4c_Custo
            .Top               = 16
            .Left              = 278
            .Width             = 478
            .Height            = 371
            .ColumnCount       = 4
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 16
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .RecordSource      = "csCusto"
            .Visible           = .T.
        ENDWITH
        WITH loc_oPgCusto.grd_4c_Custo.Column1
            .ControlSource = "csCusto.Cpros"
            .Width         = 108
            .Movable       = .F.
            .Resizable     = .F.
        ENDWITH
        loc_oPgCusto.grd_4c_Custo.Column1.Header1.Caption = "C" + CHR(243) + "digo"
        WITH loc_oPgCusto.grd_4c_Custo.Column2
            .ControlSource = "csCusto.Dpros"
            .Width         = 190
            .Movable       = .F.
            .Resizable     = .F.
        ENDWITH
        loc_oPgCusto.grd_4c_Custo.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oPgCusto.grd_4c_Custo.Column2.ReadOnly = .T.
        WITH loc_oPgCusto.grd_4c_Custo.Column3
            .ColumnOrder   = 4
            .ControlSource = "csCusto.Coefs"
            .Width         = 70
            .Movable       = .F.
            .Resizable     = .F.
            .Sparse        = .F.
        ENDWITH
        loc_oPgCusto.grd_4c_Custo.Column3.Header1.Caption = "Coeficiente"
        loc_oPgCusto.grd_4c_Custo.Column3.Text1.InputMask = "999.9999"
        WITH loc_oPgCusto.grd_4c_Custo.Column4
            .ColumnOrder   = 3
            .ControlSource = "csCusto.Seqs"
            .Width         = 75
            .Movable       = .F.
            .Resizable     = .F.
            .Sparse        = .F.
        ENDWITH
        loc_oPgCusto.grd_4c_Custo.Column4.Header1.Caption = "Sequencia"
        loc_oPgCusto.grd_4c_Custo.Column4.Text1.InputMask = "99999"
        BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "When",      THIS, "GradeCustoCol1When")
        BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "Valid",     THIS, "GradeCustoCol1Valid")
        BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "When",      THIS, "GradeCustoCol3When")
        BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "KeyPress", THIS, "GradeCustoCol3LostFocus")
        BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column4.Text1, "When",      THIS, "GradeCustoCol4When")
        BINDEVENT(loc_oPgCusto, "Activate", THIS, "ConfigPage2Activate")
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no cursor da lista
    * Grid e ControlSource: adicionados na Fase 4
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Refresh()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormFti.CarregarLista:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre Page1 (1=Lista) e Page2 (2=Dados)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
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
        CATCH TO loException
            MsgErro("Erro em FormFti.AlternarPagina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnExpXMLClick - Exporta XML do feitio selecionado
    *==========================================================================
    PROCEDURE BtnExpXMLClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um feitio para exportar.", "Exportar XML")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um feitio para exportar.", "Exportar XML")
            RETURN .F.
        ENDIF

        TRY
            THIS.LockScreen = .T.
            DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "FEITIO", 2
            THIS.this_cUltCodigo = loc_cCodigo
            THIS.AlternarPagina(1)
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
            ENDIF
            THIS.LockScreen = .F.
            loc_lResultado = .T.
        CATCH TO loException
            THIS.LockScreen = .F.
            MsgErro("Erro em FormFti.BtnExpXMLClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnImpXMLClick - Importa XML de feitio
    *==========================================================================
    PROCEDURE BtnImpXMLClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        TRY
            THIS.LockScreen = .T.
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
            ELSE
                loc_cCodigo = ""
            ENDIF

            DO FORM SigOpXml WITH THIS, "", "I", "FEITIO", 2
            THIS.this_cUltCodigo = loc_cCodigo
            THIS.AlternarPagina(1)
            IF USED("cursor_4c_Dados") AND !EMPTY(THIS.this_cUltCodigo)
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
            ENDIF
            THIS.LockScreen = .F.
            loc_lResultado = .T.
        CATCH TO loException
            THIS.LockScreen = .F.
            MsgErro("Erro em FormFti.BtnImpXMLClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva registro + itens
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2, loc_cCodigo, loc_cDescricao
        LOCAL loc_cCdMoeda, loc_nValor
        loc_lResultado = .F.

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes obrigatorias fora do TRY (REGRA CRITICA: sem RETURN dentro TRY)
        loc_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
        loc_cCdMoeda   = ALLTRIM(loc_oPg2.txt_4c_CdMoeda.Value)
        loc_nValor     = loc_oPg2.txt_4c_Valor.Value

        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Codigo.SetFocus
            RETURN .F.
        ENDIF

        IF EMPTY(loc_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Descricao.SetFocus
            RETURN .F.
        ENDIF

        IF EMPTY(loc_cCdMoeda) AND loc_nValor <> 0
            MsgAviso("Obrigat" + CHR(243) + "rio informar moeda!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_CdMoeda.SetFocus
            RETURN .F.
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarCodigoExistente(loc_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Codigo.SetFocus
                RETURN .F.
            ENDIF
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarDuplicidade()
            RETURN .F.
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarFaixa()
            RETURN .F.
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarConflitoCampos()
            RETURN .F.
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                IF THIS.this_oBusinessObject.SalvarItens(THIS.this_oBusinessObject.this_cCodigo)
                    MsgInfo("Feitio salvo com sucesso!", "Salvo")
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao salvar itens do feitio.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormFti.BtnSalvarClick:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
    ENDPROC

    *==========================================================================
    * BtnExcluirLinhaClick - Exclui linha selecionada de csGrade ou csCusto
    *==========================================================================
    PROCEDURE BtnExcluirLinhaClick()
        LOCAL loc_oPgConf, loc_cCursor, loc_nPos, loc_nTotal
        LOCAL loc_lResultado
        loc_lResultado = .F.

        loc_oPgConf = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao
        loc_cCursor = IIF(loc_oPgConf.ActivePage = 1, "csGrade", "csCusto")

        IF !USED(loc_cCursor) OR EOF(loc_cCursor) OR BOF(loc_cCursor)
            RETURN
        ENDIF

        TRY
            SELECT (loc_cCursor)
            loc_nPos   = RECNO()
            COUNT TO loc_nTotal

            IF loc_nTotal > 1
                IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Excluir Linha")
                    SELECT (loc_cCursor)
                    GO (loc_nPos)
                    DELETE
                    PACK
                ENDIF
            ELSE
                MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir o " + ;
                         CHR(250) + "nico registro.", "Excluir Linha")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormFti.BtnExcluirLinhaClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo       = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao    = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nValor        = loc_oPg2.txt_4c_Valor.Value
        THIS.this_oBusinessObject.this_cMoeda        = ALLTRIM(loc_oPg2.txt_4c_CdMoeda.Value)
        THIS.this_oBusinessObject.this_cDescMoeda    = ALLTRIM(loc_oPg2.txt_4c_DsMoeda.Value)
        THIS.this_oBusinessObject.this_nAcrescimo    = loc_oPg2.txt_4c_Acrescimo.Value
        THIS.this_oBusinessObject.this_nTipoFeitio   = loc_oPg2.opt_4c_TpFtio.Value
        THIS.this_oBusinessObject.this_nFaixaInicial = loc_oPg2.txt_4c_FaixaI.Value
        THIS.this_oBusinessObject.this_nFaixaFinal   = loc_oPg2.txt_4c_Faixaf.Value
        THIS.this_oBusinessObject.this_nPerdas       = loc_oPg2.txt_4c_Perdas.Value
        THIS.this_oBusinessObject.this_nDivMult      = loc_oPg2.opt_4c_Cfixo.Value
        THIS.this_oBusinessObject.this_nTipo         = loc_oPg2.opt_4c_CusVenda.Value
        THIS.this_oBusinessObject.this_nAplscus      = loc_oPg2.opt_4c_Fwoption1.Value
        THIS.this_oBusinessObject.this_nEtiquetas    = loc_oPg2.opt_4c_Etiquetas.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o Form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value    = THIS.this_oBusinessObject.this_cCodigo
        loc_oPg2.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDescricao
        loc_oPg2.txt_4c_Valor.Value     = THIS.this_oBusinessObject.this_nValor
        loc_oPg2.txt_4c_CdMoeda.Value   = THIS.this_oBusinessObject.this_cMoeda
        loc_oPg2.txt_4c_DsMoeda.Value   = THIS.this_oBusinessObject.this_cDescMoeda
        loc_oPg2.txt_4c_Acrescimo.Value = THIS.this_oBusinessObject.this_nAcrescimo
        loc_oPg2.opt_4c_TpFtio.Value    = THIS.this_oBusinessObject.this_nTipoFeitio
        loc_oPg2.txt_4c_FaixaI.Value    = THIS.this_oBusinessObject.this_nFaixaInicial
        loc_oPg2.txt_4c_Faixaf.Value    = THIS.this_oBusinessObject.this_nFaixaFinal
        loc_oPg2.txt_4c_Perdas.Value    = THIS.this_oBusinessObject.this_nPerdas
        loc_oPg2.opt_4c_Cfixo.Value     = THIS.this_oBusinessObject.this_nDivMult
        loc_oPg2.opt_4c_CusVenda.Value  = THIS.this_oBusinessObject.this_nTipo
        loc_oPg2.opt_4c_Fwoption1.Value = THIS.this_oBusinessObject.this_nAplscus
        loc_oPg2.opt_4c_Etiquetas.Value = THIS.this_oBusinessObject.this_nEtiquetas
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value    = ""
        loc_oPg2.txt_4c_Descricao.Value = ""
        loc_oPg2.txt_4c_Valor.Value     = 0
        loc_oPg2.txt_4c_CdMoeda.Value   = ""
        loc_oPg2.txt_4c_DsMoeda.Value   = ""
        loc_oPg2.txt_4c_Acrescimo.Value = 0
        loc_oPg2.opt_4c_TpFtio.Value    = 1
        loc_oPg2.txt_4c_FaixaI.Value    = 0
        loc_oPg2.txt_4c_Faixaf.Value    = 0
        loc_oPg2.txt_4c_Perdas.Value    = 0
        loc_oPg2.opt_4c_Cfixo.Value     = 1
        loc_oPg2.opt_4c_CusVenda.Value  = 2
        loc_oPg2.opt_4c_Fwoption1.Value = 2
        loc_oPg2.opt_4c_Etiquetas.Value = 3

        IF USED("csGrade")
            SELECT csGrade
            ZAP
        ENDIF
        IF USED("csCusto")
            SELECT csCusto
            ZAP
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Enabled    = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
        loc_oPg2.txt_4c_Valor.Enabled     = par_lHabilitar
        loc_oPg2.txt_4c_CdMoeda.Enabled   = par_lHabilitar
        loc_oPg2.txt_4c_DsMoeda.Enabled   = par_lHabilitar
        loc_oPg2.txt_4c_Acrescimo.Enabled = par_lHabilitar
        loc_oPg2.opt_4c_TpFtio.Enabled    = par_lHabilitar
        loc_oPg2.txt_4c_FaixaI.Enabled    = par_lHabilitar
        loc_oPg2.txt_4c_Faixaf.Enabled    = par_lHabilitar
        loc_oPg2.txt_4c_Perdas.Enabled    = par_lHabilitar
        loc_oPg2.opt_4c_Cfixo.Enabled     = par_lHabilitar
        loc_oPg2.opt_4c_CusVenda.Enabled  = par_lHabilitar
        loc_oPg2.opt_4c_Fwoption1.Enabled = par_lHabilitar
        loc_oPg2.opt_4c_Etiquetas.Enabled = par_lHabilitar

        loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
        loc_oPg2.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha.Enabled = par_lHabilitar

        IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page1, "grd_4c_Grade", 5)
            loc_oPg2.pgf_4c_Configuracao.Page1.grd_4c_Grade.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
            loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.ReadOnly = !par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botoes CRUD conforme modo atual
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes, loc_lEditando, loc_lVisualizando
        loc_oBotoes      = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lEditando    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_lVisualizando = (THIS.this_cModoAtual = "VISUALIZAR")

        IF PEMSTATUS(loc_oBotoes, "cmd_4c_Incluir", 5)
            loc_oBotoes.cmd_4c_Incluir.Enabled    = !loc_lEditando AND !loc_lVisualizando
            loc_oBotoes.cmd_4c_Alterar.Enabled    = !loc_lEditando AND !loc_lVisualizando
            loc_oBotoes.cmd_4c_Excluir.Enabled    = !loc_lEditando AND !loc_lVisualizando
            loc_oBotoes.cmd_4c_Visualizar.Enabled = !loc_lEditando AND !loc_lVisualizando
            loc_oBotoes.cmd_4c_Buscar.Enabled     = !loc_lEditando AND !loc_lVisualizando
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarItensNaGrade - Carrega SigPrFto nos cursores csGrade e csCusto
    *==========================================================================
    PROTECTED PROCEDURE CarregarItensNaGrade(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("csGrade")
                SELECT csGrade
                ZAP
            ENDIF
            IF USED("csCusto")
                SELECT csCusto
                ZAP
            ENDIF

            IF THIS.this_oBusinessObject.CarregarItens(par_cCodigo) AND USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(cursor_4c_Itens.cgrus))
                        INSERT INTO csGrade (Cgrus, CPros, Dgrus, Coefs, Ordem) ;
                            VALUES (ALLTRIM(cursor_4c_Itens.cgrus), ;
                                    ALLTRIM(cursor_4c_Itens.cpros), ;
                                    "", ;
                                    cursor_4c_Itens.coefs, ;
                                    cursor_4c_Itens.ordem)
                        IF USED("CrSigCdGrp")
                            SELECT CrSigCdGrp
                            IF SEEK(ALLTRIM(cursor_4c_Itens.cgrus), "CrSigCdGrp", "Cgrus")
                                SELECT csGrade
                                GO BOTTOM
                                REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus)
                            ENDIF
                        ENDIF
                    ELSE
                        INSERT INTO csCusto (Cpros, Dpros, Seqs, Coefs) ;
                            VALUES (ALLTRIM(cursor_4c_Itens.cpros), ;
                                    "", ;
                                    cursor_4c_Itens.seqs, ;
                                    cursor_4c_Itens.coefs)
                        IF USED("CrSigCdPro")
                            SELECT CrSigCdPro
                            IF SEEK(ALLTRIM(cursor_4c_Itens.cpros), "CrSigCdPro", "Cpros")
                                SELECT csCusto
                                GO BOTTOM
                                REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            INSERT INTO csGrade (Cgrus) VALUES ("")
            INSERT INTO csCusto (Cpros) VALUES ("")

            SELECT csGrade
            GO TOP
            SELECT csCusto
            GO TOP

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1, "grd_4c_Grade", 5)
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1.grd_4c_Grade.Refresh()
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Refresh()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FormFti.CarregarItensNaGrade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lExcluido

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_lExcluido = INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_SOMBRA")

                IF !loc_lExcluido
                    IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                        loc_oObjeto.Visible = .T.
                    ENDIF

                    IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                        FOR loc_nP = 1 TO loc_oObjeto.PageCount
                            THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                        ENDFOR
                    ENDIF

                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
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
    * BtnIncluirClick - Abre Page2 para novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.CriarCursoresGrade()
        THIS.CarregarItensNaGrade("")
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 para visualizacao do registro selecionado
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro.", "Visualizar")
            RETURN
        ENDIF

        THIS.this_cUltCodigo = loc_cCodigo
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
        THIS.BOParaForm()
        THIS.CriarCursoresGrade()
        THIS.CarregarItensNaGrade(loc_cCodigo)
        THIS.HabilitarCampos(.F.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 para edicao do registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.", "Alterar")
            RETURN
        ENDIF

        THIS.this_cUltCodigo = loc_cCodigo
        THIS.this_cModoAtual = "ALTERAR"
        THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
        THIS.this_oBusinessObject.EditarRegistro()
        THIS.BOParaForm()
        THIS.CriarCursoresGrade()
        THIS.CarregarItensNaGrade(loc_cCodigo)
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_cCodigo    = ""
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.", "Excluir")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do feitio '" + loc_cCodigo + "'?", "Excluir")
            RETURN
        ENDIF

        TRY
            THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                THIS.this_cUltCodigo = ""
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormFti.BtnExcluirClick:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Filtra lista de feitios por codigo ou descricao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_cTexto, loc_oGrid
        loc_cFiltro = ""
        loc_cTexto  = INPUTBOX("Digite o c" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
                               "Buscar Feitios", "")

        IF EMPTY(ALLTRIM(loc_cTexto))
            THIS.CarregarLista()
            RETURN
        ENDIF

        loc_cFiltro = "cods LIKE " + EscaparSQL(ALLTRIM(loc_cTexto) + "%")

        TRY
            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Refresh()
                ENDIF
                IF RECCOUNT("cursor_4c_Dados") = 0
                    MsgAviso("Nenhum registro encontrado.", "Buscar")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormFti.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores(4), loc_i
        loc_aCursores(1) = "csGrade"
        loc_aCursores(2) = "csCusto"
        loc_aCursores(3) = "TmpBranco"
        loc_aCursores(4) = "CsDuplica"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * TpFtioChanged - InteractiveChange do opt_4c_TpFtio
    * Value=3 (Sem Feitio): zera txt_4c_Valor e txt_4c_Acrescimo
    *==========================================================================
    PROCEDURE TpFtioChanged()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "opt_4c_TpFtio", 5) AND loc_oPg2.opt_4c_TpFtio.Value = 3
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
                loc_oPg2.txt_4c_Valor.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Acrescimo", 5)
                loc_oPg2.txt_4c_Acrescimo.Value = 0
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCdMoeda - LostFocus de txt_4c_CdMoeda
    * Lookup em SigCdMoe por cmoes (codigo); preenche txt_4c_DsMoeda
    *==========================================================================
    PROCEDURE ValidarCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCd, loc_lResultado, loc_oBusca
        loc_lResultado = .F.
        loc_cCd        = ""

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
            loc_cCd = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value)
        ENDIF

        IF EMPTY(loc_cCd)
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "CrMoedas", "cmoes", loc_cCd, "Moedas")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("CrMoedas")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value = ALLTRIM(CrMoedas.cmoes)
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value = ALLTRIM(CrMoedas.dmoes)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormFti.ValidarCdMoeda:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("CrMoedas")
            USE IN CrMoedas
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDsMoeda - LostFocus de txt_4c_DsMoeda
    * Lookup em SigCdMoe por dmoes (descricao); preenche txt_4c_CdMoeda
    *==========================================================================
    PROCEDURE ValidarDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDs, loc_lResultado, loc_oBusca
        loc_lResultado = .F.
        loc_cDs        = ""

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
            loc_cDs = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value)
        ENDIF

        IF EMPTY(loc_cDs)
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "CrMoedas", "dmoes", loc_cDs, "Moedas")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("CrMoedas")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value = ALLTRIM(CrMoedas.dmoes)
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value = ALLTRIM(CrMoedas.cmoes)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormFti.ValidarDsMoeda:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("CrMoedas")
            USE IN CrMoedas
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigPage2Activate - Atualiza caption Column3 do grd_4c_Custo (Page2.Activate)
    *==========================================================================
    PROCEDURE ConfigPage2Activate()
        LOCAL loc_oPg2, loc_cCaption
        loc_cCaption = "Coeficiente"
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "opt_4c_Cfixo", 5)
            IF loc_oPg2.opt_4c_Cfixo.Value = 2
                loc_cCaption = "( % )"
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
            loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Column3.Header1.Caption = loc_cCaption
            loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Column3.Header1.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeGrupoCol1When - When do Col1 (Cgrus) do grd_4c_Grade: salva AntValue
    *==========================================================================
    PROCEDURE GradeGrupoCol1When()
        IF USED("csGrade") AND !EOF("csGrade") AND !BOF("csGrade")
            THIS.this_cAntValue = ALLTRIM(csGrade.Cgrus)
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * GradeGrupoCol1Valid - Valid do Col1 (Cgrus): valida grupo, preenche Dgrus+Coefs
    *==========================================================================
    PROCEDURE GradeGrupoCol1Valid()
        LOCAL loc_lResultado, loc_cCodigo, loc_cSelecionado, loc_oBusca
        loc_lResultado = .T.

        IF !USED("csGrade") OR EOF("csGrade") OR BOF("csGrade")
            RETURN loc_lResultado
        ENDIF

        loc_cCodigo = ALLTRIM(csGrade.Cgrus)

        IF EMPTY(loc_cCodigo) OR loc_cCodigo = THIS.this_cAntValue
            RETURN loc_lResultado
        ENDIF

        TRY
            IF SEEK(loc_cCodigo, "CrSigCdGrp", "Cgrus")
                SELECT csGrade
                REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
                        Coefs WITH CrSigCdGrp.Coefs
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGrp", "cursor_4c_BuscaGrp", "Cgrus", loc_cCodigo, ;
                    "Grupos de Produto")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        loc_cSelecionado = ALLTRIM(cursor_4c_BuscaGrp.Cgrus)
                        SELECT csGrade
                        REPLACE Cgrus WITH loc_cSelecionado
                        IF SEEK(loc_cSelecionado, "CrSigCdGrp", "Cgrus")
                            SELECT csGrade
                            REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
                                    Coefs WITH CrSigCdGrp.Coefs
                        ENDIF
                    ELSE
                        SELECT csGrade
                        REPLACE Cgrus WITH "", Dgrus WITH ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GradeGrupoCol1Valid:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GradeGrupoCol3When - When do Col3 (Coefs) do grd_4c_Grade
    *==========================================================================
    PROCEDURE GradeGrupoCol3When()
        SET CONFIRM ON
        RETURN (!EMPTY(csGrade.Cgrus) OR !EMPTY(csGrade.Ordem))
    ENDPROC

    *==========================================================================
    * GradeGrupoCol3LostFocus - LostFocus do Col3: auto-insere linha apos Enter
    *==========================================================================
    PROCEDURE GradeGrupoCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1.grd_4c_Grade

        TRY
            SELECT * FROM csGrade WHERE (EMPTY(Cgrus) AND Ordem <> 0) INTO CURSOR TmpBranco
            IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                SET CONFIRM OFF
                IF LASTKEY() = 13
                    SELECT csGrade
                    INSERT INTO csGrade (Cgrus) VALUES ("")
                    loc_oPag.Refresh()
                    loc_oPag.Column1.SetFocus()
                    KEYBOARD "{DnArrow}"
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GradeGrupoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("TmpBranco")
            USE IN TmpBranco
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeGrupoCol4When - When do Col4 (CPros) do grd_4c_Grade: salva AntValue
    *==========================================================================
    PROCEDURE GradeGrupoCol4When()
        IF USED("csGrade") AND !EOF("csGrade") AND !BOF("csGrade")
            THIS.this_cAntValue = ALLTRIM(csGrade.CPros)
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * GradeGrupoCol4Valid - Valid do Col4 (CPros): abre picker SigCdPro se nao encontrado
    *==========================================================================
    PROCEDURE GradeGrupoCol4Valid()
        LOCAL loc_lResultado, loc_cCodigo, loc_oBusca
        loc_lResultado = .T.

        IF !USED("csGrade") OR EOF("csGrade") OR BOF("csGrade")
            RETURN loc_lResultado
        ENDIF

        loc_cCodigo = ALLTRIM(csGrade.CPros)

        IF EMPTY(loc_cCodigo) OR loc_cCodigo = THIS.this_cAntValue
            RETURN loc_lResultado
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "crListaRemota", "CPros", loc_cCodigo, ;
                "Sele" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "Produto")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("crListaRemota")
                    SELECT csGrade
                    REPLACE CPros WITH ALLTRIM(crListaRemota.CPros)
                ELSE
                    IF LASTKEY() = 27
                        SELECT csGrade
                        REPLACE CPros WITH ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("crListaRemota")
                USE IN crListaRemota
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GradeGrupoCol4Valid:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GradeCustoCol1When - When do Col1 (Cpros) do grd_4c_Custo: salva AntValue
    *==========================================================================
    PROCEDURE GradeCustoCol1When()
        IF USED("csCusto") AND !EOF("csCusto") AND !BOF("csCusto")
            THIS.this_cAntValue = ALLTRIM(csCusto.Cpros)
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * GradeCustoCol1Valid - Valid do Col1 (Cpros): valida produto, preenche Dpros+Coefs+Seqs
    *==========================================================================
    PROCEDURE GradeCustoCol1Valid()
        LOCAL loc_lResultado, loc_cCodigo, loc_cSelecionado, loc_oBusca, loc_cFiltro
        loc_lResultado = .T.

        IF !USED("csCusto") OR EOF("csCusto") OR BOF("csCusto")
            RETURN loc_lResultado
        ENDIF

        loc_cCodigo = ALLTRIM(csCusto.Cpros)

        IF EMPTY(loc_cCodigo) OR loc_cCodigo = THIS.this_cAntValue
            RETURN loc_lResultado
        ENDIF

        TRY
            IF SEEK(loc_cCodigo, "CrSigCdPro", "Cpros")
                SELECT csCusto
                REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
                        Coefs WITH CrSigCdPro.pVens, ;
                        Seqs  WITH RECNO("csCusto")
            ELSE
                loc_cFiltro = ""
                IF USED("TmpParac") AND RECCOUNT("TmpParac") > 0
                    SELECT TmpParac
                    GO TOP
                    IF !EMPTY(ALLTRIM(TmpParac.CgruCfxs))
                        loc_cFiltro = "Cgrus = " + EscaparSQL(ALLTRIM(TmpParac.CgruCfxs))
                    ENDIF
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BuscaPro", "Cpros", loc_cCodigo, ;
                    "Custos Fixo", .F., .T., loc_cFiltro)
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                        loc_cSelecionado = ALLTRIM(cursor_4c_BuscaPro.Cpros)
                        SELECT csCusto
                        REPLACE Cpros WITH loc_cSelecionado
                        IF SEEK(loc_cSelecionado, "CrSigCdPro", "Cpros")
                            SELECT csCusto
                            REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
                                    Coefs WITH CrSigCdPro.pVens, ;
                                    Seqs  WITH RECNO("csCusto")
                        ELSE
                            SELECT csCusto
                            REPLACE Dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros), ;
                                    Coefs WITH cursor_4c_BuscaPro.pVens, ;
                                    Seqs  WITH RECNO("csCusto")
                        ENDIF
                    ELSE
                        SELECT csCusto
                        REPLACE Cpros WITH "", Dpros WITH ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaPro")
                    USE IN cursor_4c_BuscaPro
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GradeCustoCol1Valid:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GradeCustoCol3When - When do Col3 (Coefs) do grd_4c_Custo
    *==========================================================================
    PROCEDURE GradeCustoCol3When()
        RETURN (!EMPTY(csCusto.Cpros))
    ENDPROC

    *==========================================================================
    * GradeCustoCol3LostFocus - LostFocus do Col3: auto-insere linha apos Enter
    *==========================================================================
    PROCEDURE GradeCustoCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2.grd_4c_Custo

        TRY
            SELECT * FROM csCusto WHERE EMPTY(Cpros) INTO CURSOR TmpBranco
            IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                SELECT csCusto
                INSERT INTO csCusto (Cpros) VALUES ("")
                GO BOTTOM IN csCusto
            ENDIF
            IF LASTKEY() = 13
                SELECT csCusto
                loc_oPag.Refresh()
                loc_oPag.Column1.SetFocus()
                KEYBOARD "{DnArrow}"
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GradeCustoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("TmpBranco")
            USE IN TmpBranco
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeCustoCol4When - When do Col4 (Seqs) do grd_4c_Custo
    *==========================================================================
    PROCEDURE GradeCustoCol4When()
        RETURN (!EMPTY(csCusto.Cpros))
    ENDPROC

ENDDEFINE
