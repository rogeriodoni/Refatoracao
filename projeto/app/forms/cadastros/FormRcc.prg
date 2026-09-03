*==============================================================================
* FormRcc.prg - Formulario de Cadastro de Rateio de Centros de Custo
* Migrado de: SIGCDRCC.SCX (frmcadastro)
* Tabelas: SigCdRcc (cabecalho) + SigCdRci (itens de rateio)
*==============================================================================

DEFINE CLASS FormRcc AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Rateio de Centros de Custos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Estado interno
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
    *===========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro("Erro em FormRcc.Init: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("RccBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar RccBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormRcc.InicializarForm")
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
            MostrarErro("Erro ao inicializar FormRcc:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRcc.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1: cabecalho, containers base
    * Grid e botoes CRUD adicionados na Fase 4
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Top=2 do original + 29 compensacao = 31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 16
                .Left      = 11
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 19
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
        ENDWITH

        *-- Container Botoes CRUD (Grupo_Op no legado) - Top=0+29=29, Left=542
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 80
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
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 155
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
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 230
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
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 305
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
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container Saida (canonico: Left=917, Width=90, cmd_4c_Encerrar)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid de lista de rateios (Grade no legado)
        *-- Top=88+29=117, Left=26, Width=890, Height=450
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 450
            .ReadOnly           = .T.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .GridLines          = 3
            .RowHeight          = 16
            .ScrollBars         = 2
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .BackColor          = RGB(255, 255, 255)
            .ForeColor          = RGB(90, 90, 90)
            .Visible            = .T.
            .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column1.Width           = 350
            .Column2.Header1.Caption = "Emp."
            .Column2.Width           = 60
            .Column3.Header1.Caption = ""
            .Column3.Width           = 430
        ENDWITH

        *-- Botao Duplicar (legado: cmdDuplicar top=82 left=604)
        *-- Reposicionado para left=2 para nao conflitar com cnt_4c_Botoes
        loc_oPagina.AddObject("cmd_4c_Duplicar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Duplicar
            .Caption       = "Duplicar rateio"
            .Top           = 111
            .Left          = 2
            .Width         = 120
            .Height        = 45
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .F.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH

        *-- Vincular eventos dos botoes CRUD
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Duplicar,                  "Click", THIS, "BtnDuplicarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes, labels e campos principais
    * Grid de rateio adicionado na Fase 6
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (Grupo_Salva no legado: Top=4+29=33, Left=842)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
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
                .SpecialEffect   = 0
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label "Descricao :" (lbl_grupo no legado: top=111+29=140, left=86)
        loc_oPagina.AddObject("lbl_4c_LblDesc", "Label")
        WITH loc_oPagina.lbl_4c_LblDesc
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 140
            .Left      = 86
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDesc no legado: top=107+29=136, left=146, width=150, height=23)
        loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPagina.txt_4c_Desc
            .Value         = ""
            .Top           = 136
            .Left          = 146
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
            .Visible       = .T.
        ENDWITH

        *-- Label "Empresa :" (Say6 no legado: top=137+29=166, left=91)
        loc_oPagina.AddObject("lbl_4c_Say6", "Label")
        WITH loc_oPagina.lbl_4c_Say6
            .Caption   = "Empresa :"
            .Top       = 166
            .Left      = 91
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Empresa - codigo (GetEmpresa no legado: top=134+29=163, left=146, width=31, height=21)
        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Value         = ""
            .Top           = 163
            .Left          = 146
            .Width         = 31
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        *-- TextBox DEmpresa - nome da empresa (GetDempresa no legado: top=134+29=163, left=179, width=351, height=21)
        *-- ReadOnly quando Empresa tem codigo; habilitado quando Empresa esta vazio (busca por nome)
        loc_oPagina.AddObject("txt_4c_DEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_DEmpresa
            .Value         = ""
            .Top           = 163
            .Left          = 179
            .Width         = 351
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_Empresa,  "LostFocus", THIS, "ValidarEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DEmpresa, "LostFocus", THIS, "ValidarDEmpresa")

        *-- txt_4c_PTotal (getPTotal no legado: top=546+29=575, left=499, width=80, height=21)
        loc_oPagina.AddObject("txt_4c_PTotal", "TextBox")
        WITH loc_oPagina.txt_4c_PTotal
            .Value         = 0
            .Top           = 575
            .Left          = 499
            .Width         = 80
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- grd_4c_Dados (grdRateio no legado: top=159+29=188, left=128, width=471, height=387)
        *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.RecordSource = ""
        loc_oPagina.grd_4c_Dados.ColumnCount  = 6

        WITH loc_oPagina.grd_4c_Dados
            .Top                = 188
            .Left               = 128
            .Width              = 471
            .Height             = 387
            .FontName           = "Tahoma"
            .FontSize           = 8
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .RowHeight          = 16
            .GridLineColor      = RGB(238, 238, 238)
            .BackColor          = RGB(255, 255, 255)
            .ForeColor          = RGB(0, 0, 0)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .Visible            = .T.

            *-- Column1: Emp. (ColumnOrder=2, width=31) - editavel quando Marcas=1
            .Column1.Header1.Caption     = "Emp."
            .Column1.Header1.Alignment   = 2
            .Column1.Width               = 31
            .Column1.ColumnOrder         = 2
            .Column1.Movable             = .F.
            .Column1.Resizable           = .F.
            .Column1.Text1.BorderStyle   = 0
            .Column1.Text1.Margin        = 0
            .Column1.Text1.ForeColor     = RGB(0, 0, 0)
            .Column1.Text1.BackColor     = RGB(255, 255, 255)

            *-- Column2: Grupo (ColumnOrder=3, width=80, ReadOnly)
            .Column2.Header1.Caption     = "Grupo"
            .Column2.Header1.Alignment   = 2
            .Column2.Width               = 80
            .Column2.ColumnOrder         = 3
            .Column2.ReadOnly            = .T.
            .Column2.Movable             = .F.
            .Column2.Resizable           = .F.
            .Column2.Text1.BorderStyle   = 0
            .Column2.Text1.Margin        = 0
            .Column2.Text1.ForeColor     = RGB(0, 0, 0)
            .Column2.Text1.BackColor     = RGB(255, 255, 255)

            *-- Column3: Centro de Custo (ColumnOrder=4, width=95, ReadOnly)
            .Column3.Header1.Caption     = "Centro de Custo"
            .Column3.Header1.Alignment   = 2
            .Column3.Width               = 95
            .Column3.ColumnOrder         = 4
            .Column3.ReadOnly            = .T.
            .Column3.Movable             = .F.
            .Column3.Resizable           = .F.
            .Column3.Text1.BorderStyle   = 0
            .Column3.Text1.Margin        = 0
            .Column3.Text1.ForeColor     = RGB(0, 0, 0)
            .Column3.Text1.BackColor     = RGB(255, 255, 255)

            *-- Column4: Descricao (ColumnOrder=5, width=141, ReadOnly)
            .Column4.Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
            .Column4.Header1.Alignment   = 2
            .Column4.Width               = 141
            .Column4.ColumnOrder         = 5
            .Column4.ReadOnly            = .T.
            .Column4.Movable             = .F.
            .Column4.Resizable           = .F.
            .Column4.Text1.BorderStyle   = 0
            .Column4.Text1.Margin        = 0
            .Column4.Text1.ForeColor     = RGB(0, 0, 0)
            .Column4.Text1.BackColor     = RGB(255, 255, 255)

            *-- Column5: % Rateio (ColumnOrder=6, width=80) - editavel quando Marcas=1
            .Column5.Header1.Caption     = "% Rateio"
            .Column5.Header1.Alignment   = 2
            .Column5.Width               = 80
            .Column5.ColumnOrder         = 6
            .Column5.Movable             = .F.
            .Column5.Resizable           = .F.
            .Column5.Text1.InputMask     = "999.99"
            .Column5.Text1.BorderStyle   = 0
            .Column5.Text1.Margin        = 0
            .Column5.Text1.ForeColor     = RGB(0, 0, 0)
            .Column5.Text1.BackColor     = RGB(255, 255, 255)

            *-- Column6: Marcas checkbox (ColumnOrder=1 = primeira coluna visual, width=17)
            .Column6.Header1.Caption = ""
            .Column6.Width           = 17
            .Column6.ColumnOrder     = 1
            .Column6.Sparse          = .F.
            .Column6.Movable         = .F.
            .Column6.Resizable       = .F.
        ENDWITH

        *-- CheckBox na coluna 6 (Problema 146: 7 props obrigatorias alem de Sparse=.F.)
        loc_oPagina.grd_4c_Dados.Column6.AddObject("Check1", "CheckBox")
        WITH loc_oPagina.grd_4c_Dados.Column6.Check1
            .Alignment = 0
            .Caption   = ""
            .ReadOnly  = .F.
            .Visible   = .T.
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
        ENDWITH

        *-- cmd_4c_SelTudo (SelTudo no legado: top=305+29=334, left=599, width=45, height=40)
        loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oPagina.cmd_4c_SelTudo
            .Caption         = ""
            .ToolTipText     = "Selecionar"
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .PicturePosition = 4
            .Top             = 334
            .Left            = 599
            .Width           = 45
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH

        *-- cmd_4c_Apaga (apaga no legado: top=346+29=375, left=599, width=45, height=40)
        loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH loc_oPagina.cmd_4c_Apaga
            .Caption         = ""
            .ToolTipText     = "Desmarcar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 4
            .Top             = 375
            .Left            = 599
            .Width           = 45
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENTs para grid e botoes de selecao
        BINDEVENT(loc_oPagina.grd_4c_Dados.Column6.Check1, "Click",             THIS, "GridCheckClick")
        BINDEVENT(loc_oPagina.grd_4c_Dados,                "AfterRowColChange", THIS, "GridRateioAfterRowColChange")
        BINDEVENT(loc_oPagina.cmd_4c_SelTudo,               "Click",            THIS, "BtnSelTudoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Apaga,                 "Click",            THIS, "BtnApagaClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (DescRats C(20), EmpOs C(3), DEmpresa C(80))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.DescRats"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.EmpOs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DEmpresa"

                    loc_oGrid.Column1.Width = 350
                    loc_oGrid.Column2.Width = 60
                    loc_oGrid.Column3.Width = 430

                    loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column2.Header1.Caption = "Emp."
                    loc_oGrid.Column3.Header1.Caption = ""

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar lista de rateios.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormRcc.CarregarLista: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles do container visiveis
    * Itera recursivamente Pages e Controls
    *===========================================================================
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

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (lista=1) e Page2 (dados=2)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em FormRcc.AlternarPagina: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Inclui novo rateio
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_oBusinessObject.CarregarClientesPorGrupoColetora("")
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.CarregarGridRateio("cursor_4c_RateioEdit")
            THIS.AlternarPagina(2)
        CATCH TO loException
            MsgErro("Erro em BtnIncluirClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Visualiza rateio selecionado (somente leitura)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDescRats
        loc_cDescRats = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um rateio para visualizar.", "Aviso")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cDescRats = ALLTRIM(cursor_4c_Dados.DescRats)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDescRats)
                THIS.this_oBusinessObject.CarregarItensPorRateio(loc_cDescRats)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.CarregarGridRateio("cursor_4c_Itens")
                THIS.AlternarPagina(2)
            ELSE
                MsgErro("Erro ao carregar rateio para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnVisualizarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Altera rateio selecionado
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cDescRats
        loc_cDescRats = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um rateio para alterar.", "Aviso")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cDescRats = ALLTRIM(cursor_4c_Dados.DescRats)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDescRats)
                THIS.this_oBusinessObject.CarregarClientesPorGrupoColetora(loc_cDescRats)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.CarregarGridRateio("cursor_4c_RateioEdit")
                THIS.AlternarPagina(2)
            ELSE
                MsgErro("Erro ao carregar rateio para altera" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnAlterarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui rateio selecionado
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cDescRats
        loc_cDescRats = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um rateio para excluir.", "Aviso")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cDescRats = ALLTRIM(cursor_4c_Dados.DescRats)

            IF MsgConfirma("Confirma exclus" + CHR(227) + "o do rateio:" + CHR(13) + ;
                    loc_cDescRats, "Confirmar Exclus" + CHR(227) + "o")

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDescRats)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Rateio exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                        THIS.CarregarLista()
                    ELSE
                        MsgErro("Erro ao excluir rateio.", "Erro")
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar rateio para exclus" + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnExcluirClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Filtra rateios por descricao
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_oGrid
        loc_cFiltro = ""

        TRY
            loc_cFiltro = ALLTRIM(INPUTBOX("Descri" + CHR(231) + CHR(227) + "o (parcial):", ;
                "Buscar Rateio", ""))

            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource              = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.DescRats"
                loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.EmpOs"
                loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.DEmpresa"
                loc_oGrid.Column1.Width             = 350
                loc_oGrid.Column2.Width             = 60
                loc_oGrid.Column3.Width             = 430
                loc_oGrid.Column1.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Header1.Caption   = "Emp."
                loc_oGrid.Column3.Header1.Caption   = ""
                THIS.FormatarGridLista(loc_oGrid)
            ELSE
                MsgErro("Erro na busca de rateios.", "Erro")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnBuscarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnDuplicarClick - Duplica rateio selecionado (modo INCLUIR com itens copiados)
    * Legado: cmdDuplicar.Click chama grupo_Op.Click(6) que faz DoDefault(6)
    *===========================================================================
    PROCEDURE BtnDuplicarClick()
        LOCAL loc_cDescRats
        loc_cDescRats = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um rateio para duplicar.", "Aviso")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cDescRats = ALLTRIM(cursor_4c_Dados.DescRats)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDescRats)
                THIS.this_oBusinessObject.CarregarClientesPorGrupoColetora(loc_cDescRats)
                THIS.this_oBusinessObject.NovoRegistro()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.BOParaForm()
                THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.Value = ""
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ELSE
                MsgErro("Erro ao carregar rateio para duplicar.", "Erro")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnDuplicarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma e salva os dados de Page2
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cDescRats
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_cDescRats = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
            loc_cDescRats = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
        ENDIF

        IF EMPTY(loc_cDescRats)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o de rateio obrigat" + CHR(243) + "rio.", "Aviso")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
                loc_oPg2.txt_4c_Desc.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarDescricaoExistente(loc_cDescRats)
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o de rateio j" + CHR(225) + " cadastrada.", "Aviso")
                IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
                    loc_oPg2.txt_4c_Desc.SetFocus()
                ENDIF
                RETURN
            ENDIF
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarTotalRateio()
            RETURN
        ENDIF

        THIS.FormParaBO()

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Rateio salvo com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
            ELSE
                MsgErro("Erro ao salvar rateio.", "Erro")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnSalvarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela e volta para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * ValidarEmpresa - Valida codigo de empresa e preenche nome automaticamente
    * LostFocus do txt_4c_Empresa (equivale a GetEmpresa.Valid com fAcessoEmpresa 'C')
    *===========================================================================
    PROCEDURE ValidarEmpresa()
        LOCAL loc_oPg2, loc_cEmpresa, loc_cSQL
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_cEmpresa = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
            loc_cEmpresa = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)
        ENDIF

        IF EMPTY(loc_cEmpresa)
            IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
                loc_oPg2.txt_4c_DEmpresa.Value    = ""
                loc_oPg2.txt_4c_DEmpresa.ReadOnly = .F.
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE CEmps = " + EscaparSQL(loc_cEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValida") >= 0 AND ;
               RECCOUNT("cursor_4c_EmpValida") > 0
                SELECT cursor_4c_EmpValida
                IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
                    loc_oPg2.txt_4c_DEmpresa.Value    = ALLTRIM(cursor_4c_EmpValida.Razas)
                    loc_oPg2.txt_4c_DEmpresa.ReadOnly = .T.
                ENDIF
            ELSE
                MsgAviso("Empresa '" + loc_cEmpresa + "' n" + CHR(227) + "o encontrada.", "Aviso")
                IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
                    loc_oPg2.txt_4c_Empresa.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
                    loc_oPg2.txt_4c_DEmpresa.Value    = ""
                    loc_oPg2.txt_4c_DEmpresa.ReadOnly = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_EmpValida")
                USE IN cursor_4c_EmpValida
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarEmpresa: " + loException.Message, "Erro")
            IF USED("cursor_4c_EmpValida")
                USE IN cursor_4c_EmpValida
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarDEmpresa - Busca empresa por nome quando codigo esta vazio
    * LostFocus do txt_4c_DEmpresa (equivale a GetDempresa.Valid com fAcessoEmpresa 'D')
    *===========================================================================
    PROCEDURE ValidarDEmpresa()
        LOCAL loc_oPg2, loc_cEmpresa, loc_cNome, loc_cSQL, loc_nResult
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_cEmpresa = ""
        loc_cNome    = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
            loc_cEmpresa = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
            loc_cNome = ALLTRIM(loc_oPg2.txt_4c_DEmpresa.Value)
        ENDIF

        IF !EMPTY(loc_cEmpresa) OR EMPTY(loc_cNome)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
                       EscaparSQL(loc_cNome + "%") + " ORDER BY Razas"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpNome")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_EmpNome") = 1
                SELECT cursor_4c_EmpNome
                IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
                    loc_oPg2.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_EmpNome.CEmps)
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
                    loc_oPg2.txt_4c_DEmpresa.Value    = ALLTRIM(cursor_4c_EmpNome.Razas)
                    loc_oPg2.txt_4c_DEmpresa.ReadOnly = .T.
                ENDIF
            ELSE
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_EmpNome") > 1
                IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
                    loc_oPg2.txt_4c_DEmpresa.Value = ""
                ENDIF
                MsgAviso("Mais de uma empresa encontrada. Digite o c" + CHR(243) + "digo.", "Aviso")
            ELSE
                MsgAviso("Empresa '" + loc_cNome + "' n" + CHR(227) + "o encontrada.", "Aviso")
                IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
                    loc_oPg2.txt_4c_DEmpresa.Value = ""
                ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_EmpNome")
                USE IN cursor_4c_EmpNome
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarDEmpresa: " + loException.Message, "Erro")
            IF USED("cursor_4c_EmpNome")
                USE IN cursor_4c_EmpNome
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa campos de Page2 (completado na Fase 5)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
            loc_oPg2.txt_4c_Desc.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
            loc_oPg2.txt_4c_Empresa.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
            loc_oPg2.txt_4c_DEmpresa.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_PTotal", 5)
            loc_oPg2.txt_4c_PTotal.Value = 0
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos de Page2
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
            loc_oPg2.txt_4c_Desc.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
            loc_oPg2.txt_4c_Empresa.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
            loc_oPg2.grd_4c_Dados.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cmd_4c_Apaga", 5)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cmd_4c_SelTudo", 5)
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            RETURN
        ENDIF

        WITH loc_oPg2.cnt_4c_BotoesAcao
            IF PEMSTATUS(.cmd_4c_Confirmar, "Enabled", 5)
                .cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual $ "INCLUIR,ALTERAR")
            ENDIF
            IF PEMSTATUS(.cmd_4c_Cancelar, "Enabled", 5)
                .cmd_4c_Cancelar.Enabled = .T.
            ENDIF
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para os campos de Page2
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cSQL
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
            loc_oPg2.txt_4c_Desc.Value = THIS.this_oBusinessObject.this_cDescRats
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
            loc_oPg2.txt_4c_Empresa.Value = THIS.this_oBusinessObject.this_cEmpOs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
            loc_oPg2.txt_4c_DEmpresa.Value    = ""
            loc_oPg2.txt_4c_DEmpresa.ReadOnly = .T.

            IF !EMPTY(THIS.this_oBusinessObject.this_cEmpOs)
                TRY
                    loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE CEmps = " + ;
                               EscaparSQL(THIS.this_oBusinessObject.this_cEmpOs)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpNomeBO") >= 0 AND ;
                       RECCOUNT("cursor_4c_EmpNomeBO") > 0
                        SELECT cursor_4c_EmpNomeBO
                        loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_EmpNomeBO.Razas)
                    ENDIF
                    IF USED("cursor_4c_EmpNomeBO")
                        USE IN cursor_4c_EmpNomeBO
                    ENDIF
                CATCH TO loException
                    MsgErro("Erro ao carregar nome empresa: " + loException.Message, "Erro")
                    IF USED("cursor_4c_EmpNomeBO")
                        USE IN cursor_4c_EmpNomeBO
                    ENDIF
                ENDTRY
            ELSE
                loc_oPg2.txt_4c_DEmpresa.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados dos campos de Page2 para o BO
    * Completado na Fase 6
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
            THIS.this_oBusinessObject.this_cDescRats = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
            THIS.this_oBusinessObject.this_cEmpOs = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)
        ENDIF
    ENDPROC

    *===========================================================================
    * CarregarGridRateio - Vincula cursor ao grd_4c_Dados e reconfigura colunas
    * Chamado por BtnIncluirClick/BtnAlterarClick (cursor_4c_RateioEdit)
    *        e por BtnVisualizarClick (cursor_4c_Itens)
    *===========================================================================
    PROCEDURE CarregarGridRateio(par_cCursor)
        LOCAL loc_oGrd
        loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        IF !USED(par_cCursor)
            RETURN
        ENDIF

        TRY
            *-- RecordSource FORA do WITH para garantir criacao de colunas (Problema 36)
            loc_oGrd.RecordSource = par_cCursor
            loc_oGrd.ColumnCount  = 6

            WITH loc_oGrd
                .Column1.ControlSource = par_cCursor + ".Emps"
                .Column2.ControlSource = par_cCursor + ".Grupos"
                .Column3.ControlSource = par_cCursor + ".Contas"
                .Column4.ControlSource = par_cCursor + ".Descs"
                .Column5.ControlSource = par_cCursor + ".PercRats"
                .Column6.ControlSource = par_cCursor + ".Marcas"

                *-- Reconfigurar Headers apos RecordSource (Problema 32)
                .Column1.Header1.Caption = "Emp."
                .Column2.Header1.Caption = "Grupo"
                .Column3.Header1.Caption = "Centro de Custo"
                .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                .Column5.Header1.Caption = "% Rateio"
                .Column6.Header1.Caption = ""

                .Refresh()
            ENDWITH

            THIS.AtualizarPTotal()
        CATCH TO loException
            MsgErro("Erro em CarregarGridRateio: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AtualizarPTotal - Recalcula e exibe a soma de PercRats dos itens marcados
    *===========================================================================
    PROCEDURE AtualizarPTotal()
        LOCAL loc_oPg2, loc_nTotal
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_nTotal = 0

        IF USED("cursor_4c_RateioEdit")
            SELECT cursor_4c_RateioEdit
            SUM PercRats FOR Marcas = 1 TO loc_nTotal
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_PTotal", 5)
            loc_oPg2.txt_4c_PTotal.Value = loc_nTotal
            loc_oPg2.txt_4c_PTotal.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * GridCheckClick - Processa click no CheckBox da coluna Marcas do grid
    * Quando Marcas vira 0, zera PercRats; depois recalcula rateio automatico
    *===========================================================================
    PROCEDURE GridCheckClick()
        IF !USED("cursor_4c_RateioEdit")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            IF Marcas = 0
                REPLACE PercRats WITH 0 IN cursor_4c_RateioEdit
            ENDIF

            THIS.this_oBusinessObject.CalcularRateioAuto()
            THIS.AtualizarPTotal()
            THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        CATCH TO loException
            MsgErro("Erro em GridCheckClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GridRateioAfterRowColChange - Atualiza PTotal quando usuario edita % Rateio
    * LPARAMETERS obrigatorio para BINDEVENT AfterRowColChange (Problema 38)
    *===========================================================================
    PROCEDURE GridRateioAfterRowColChange(par_nColIndex)
        THIS.AtualizarPTotal()
    ENDPROC

    *===========================================================================
    * BtnSelTudoClick - Marca todos os itens do grid de rateio
    * Equivale ao botao SelTudo do legado: marca Marcas=1 + CalcularRateioAuto
    *===========================================================================
    PROCEDURE BtnSelTudoClick()
        IF !USED("cursor_4c_RateioEdit")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            REPLACE ALL Marcas WITH 1
            GO TOP

            THIS.this_oBusinessObject.CalcularRateioAuto()
            THIS.AtualizarPTotal()
            THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        CATCH TO loException
            MsgErro("Erro em BtnSelTudoClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnApagaClick - Desmarca todos os itens do grid de rateio
    * Equivale ao botao apaga do legado: zera Marcas=0 e PercRats=0
    *===========================================================================
    PROCEDURE BtnApagaClick()
        IF !USED("cursor_4c_RateioEdit")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            REPLACE ALL Marcas WITH 0, PercRats WITH 0
            GO TOP

            THIS.AtualizarPTotal()
            THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        CATCH TO loException
            MsgErro("Erro em BtnApagaClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos
    *===========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_RateioEdit")
            USE IN cursor_4c_RateioEdit
        ENDIF
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
