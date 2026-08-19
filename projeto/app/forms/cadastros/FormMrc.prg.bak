*==============================================================================
* FormMrc.prg - Formulario de Cadastro de Demonstrativos
* Migrado de: SigCdMrc.SCX (frmcadastro)
* Tabela principal: SigCdMrr (Demonstrativos)
* Tabela relacionada: SigCdMri (Itens do Demonstrativo)
*==============================================================================
DEFINE CLASS FormMrc AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Demonstrativos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de controle
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cCursorDados    = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * Init - FormBase.Init() chama InicializarForm() automaticamente
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormMrc:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("MrcBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar MrcBO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra") = "O"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF
                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF THIS.DataSession = 2
                    SET DATE TO BRITISH
                    SET CENTURY ON
                ENDIF

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formulario:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o PageFrame com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height
            .Tabs      = .F.

            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 com cabecalho, botoes CRUD e grade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza escuro (cntSombra no legado)
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

        *-- Container botoes CRUD (Grupo_op no legado: Left=343, Top=-1 -> canonico Left=542, Top=29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir (Inserir no legado: Left=5, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar (Consultar no legado: Left=80, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar (Left=155, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir (Left=230, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar (Procurar no legado: Left=305, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - padrao canonico (Grupo_Saida no legado: Left=718, Top=-1)
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botao Itens (Legado: Top=86, Left=347, Width=105, Height=45 -> Top compensado +29)
        loc_oPagina.AddObject("cmd_4c_Itens", "CommandButton")
        WITH loc_oPagina.cmd_4c_Itens
            .Caption         = "Itens"
            .Picture         = gc_4c_CaminhoIcones + "folder31.ico"
            .PicturePosition = 13
            .Top             = 115
            .Left            = 347
            .Width           = 105
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .F.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Itens"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Itens, "Click", THIS, "BtnItensClick")

        *-- Grade (Legado: Grade.Top=133, Left=32, Width=736, Height=433 -> Top +29=162)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 162
            .Left               = 32
            .Width              = 736
            .Height             = 433
            .FontName           = "Tahoma"
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH
        *-- ColumnCount FORA de WITH para criar colunas imediatamente (Problema 36)
        loc_oPagina.grd_4c_Lista.ColumnCount = 3

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: botoes Confirmar/Cancelar,
    * labels e campos (txt_4c_Balanco, txt_4c_Titulo, opt_4c_Impressao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label: Demonstrativo (Say1: Top=195, Left=210, Height=15 -> Top +29=224)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Demonstrativo : "
            .Top       = 224
            .Left      = 210
            .Height    = 15
            .Width     = 87
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Titulo (Say2: Top=220, Left=254 -> Top +29=249)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "T" + CHR(237) + "tulo : "
            .Top       = 249
            .Left      = 254
            .Height    = 15
            .Width     = 43
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Impressao (Say3: Top=247, Left=230 -> Top +29=276)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Impress" + CHR(227) + "o : "
            .Top       = 276
            .Left      = 230
            .Height    = 15
            .Width     = 67
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Campo Demonstrativo (Get_balanco: Top=192, Left=299, Width=150 -> Top +29=221)
        *-- Format="!K" = uppercase + clear-on-focus; chave primaria char(20)
        loc_oPagina.AddObject("txt_4c_Balanco", "TextBox")
        WITH loc_oPagina.txt_4c_Balanco
            .Value     = ""
            .Top       = 221
            .Left      = 299
            .Width     = 150
            .Height    = 20
            .MaxLength = 20
            .Format    = "!K"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- Campo Titulo (Get_titulo: Top=217, Left=299, Width=290 -> Top +29=246)
        *-- char(40)
        loc_oPagina.AddObject("txt_4c_Titulo", "TextBox")
        WITH loc_oPagina.txt_4c_Titulo
            .Value     = ""
            .Top       = 246
            .Left      = 299
            .Width     = 290
            .Height    = 20
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Impressao (fwoption1: Top=242, Left=299, Width=239, Height=27 -> Top +29=271)
        *-- Option1="Plano de Contas" (Value=1), Option2="Mapa de Contas" (Value=2)
        *-- ATENCAO: NAO setar .Value em Buttons(N) - causa todos radios marcados
        loc_oPagina.AddObject("opt_4c_Impressao", "OptionGroup")
        loc_oPagina.opt_4c_Impressao.ButtonCount = 2
        WITH loc_oPagina.opt_4c_Impressao
            .Value       = 1
            .Top         = 271
            .Left        = 299
            .Width       = 246
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .TabIndex    = 3
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.opt_4c_Impressao.Buttons(1)
            .Caption   = "Plano de Contas"
            .Top       = 5
            .Left      = 5
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        WITH loc_oPagina.opt_4c_Impressao.Buttons(2)
            .Caption   = "Mapa de Contas"
            .Top       = 5
            .Left      = 126
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Executa Buscar() e configura RecordSource/Colunas/Headers
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (Balancos C(20), Titulos C(40), Mapas N(1,0))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lSucesso = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
                    loc_oGrid.RecordSource = THIS.this_cCursorDados
                    loc_oGrid.ColumnCount  = 3

                    *-- ControlSources APOS RecordSource (Problema 48: auto-bind reseta)
                    loc_oGrid.Column1.ControlSource = THIS.this_cCursorDados + ".Balancos"
                    loc_oGrid.Column2.ControlSource = THIS.this_cCursorDados + ".Titulos"
                    loc_oGrid.Column3.ControlSource = ;
                        "IIF(cursor_4c_Dados.Mapas=2,'MAPA','PLANO')"

                    *-- Headers APOS RecordSource (Problema 6/32: VFP reseta headers)
                    loc_oGrid.Column1.Header1.Caption = "Demonstrativo"
                    loc_oGrid.Column2.Header1.Caption = "T" + CHR(237) + "tulo"
                    loc_oGrid.Column3.Header1.Caption = "Impress" + CHR(227) + "o"

                    *-- Larguras conforme legado
                    loc_oGrid.Column1.Width = 150
                    loc_oGrid.Column2.Width = 290
                    loc_oGrid.Column3.Width = 75

                    *-- DynamicForeColor: Mapa de Contas em azul, Plano em preto (legado)
                    loc_oGrid.SetAll("DynamicForeColor", ;
                        "IIF(cursor_4c_Dados.Mapas=2,RGB(0,0,255),RGB(0,0,0))", ;
                        "Column")

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            loc_lSucesso = .F.
        ELSE
            TRY
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                MsgErro("Erro ao alternar pagina:" + CHR(13) + loc_oErro.Message, "Erro")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO para INSERT e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
            THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
           RECCOUNT(THIS.this_cCursorDados) = 0
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        LOCAL loc_cBalanco
        SELECT cursor_4c_Dados
        loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar") = "O"
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro para edicao e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
           RECCOUNT(THIS.this_cCursorDados) = 0
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        LOCAL loc_cBalanco
        SELECT cursor_4c_Dados
        loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Titulo") = "O"
                THIS.pgf_4c_Paginas.Page2.txt_4c_Titulo.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Carrega registro para confirmacao de exclusao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
           RECCOUNT(THIS.this_cCursorDados) = 0
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        LOCAL loc_cBalanco
        SELECT cursor_4c_Dados
        loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
            THIS.this_cModoAtual = "EXCLUIR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre picker e posiciona grade no registro selecionado
    * Pattern A canonico: SQL no caller + DefinirCursor + Mostrar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_nSQL, loc_cBalanco, loc_oBusca
        loc_cBalanco = ""

        TRY
            loc_nSQL = SQLEXEC(gnConnHandle, ;
                "SELECT Balancos, Titulos FROM SigCdMrr ORDER BY Balancos", ;
                "cursor_4c_BuscaMrc")

            IF loc_nSQL >= 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaMrc", "Balancos", "Titulos", ;
                        "Buscar Demonstrativo")
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMrc"
                    IF loc_oBusca.Mostrar()
                        loc_cBalanco = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao buscar demonstrativos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaMrc")
            USE IN cursor_4c_BuscaMrc
        ENDIF

        IF !EMPTY(loc_cBalanco) AND USED(THIS.this_cCursorDados)
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(Balancos) == loc_cBalanco
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnItensClick - Abre formulario de Itens do Demonstrativo (SigCdCmr)
    * Legado: do form SigCdCmr with Thisform,thisform.datasessionid
    *--------------------------------------------------------------------------
    PROCEDURE BtnItensClick()
        IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
           RECCOUNT(THIS.this_cCursorDados) = 0
            MsgAviso("Selecione um demonstrativo para visualizar seus itens.", "Itens")
            RETURN
        ENDIF

        LOCAL loc_cBalanco, loc_oItens
        SELECT cursor_4c_Dados
        loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)

        TRY
            loc_oItens = CREATEOBJECT("FormCmr", loc_cBalanco)
            IF VARTYPE(loc_oItens) = "O"
                loc_oItens.Show()
            ELSE
                MsgErro("Erro ao criar formul" + CHR(225) + "rio de Itens." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oItens), "Erro")
            ENDIF
        CATCH TO loc_oErro
            LOCAL loc_cMsg
            loc_cMsg = "Erro ao abrir Itens do Demonstrativo:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loc_oErro.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                       "Procedure: " + loc_oErro.Procedure
            MsgErro(loc_cMsg, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirmar na Page2: salva em INCLUIR/ALTERAR, exclui em EXCLUIR
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        *-- VISUALIZAR: apenas voltar para lista
        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        *-- EXCLUIR: confirmar e executar exclusao cascade (SigCdMri + SigCdMrr)
        IF THIS.this_cModoAtual = "EXCLUIR"
            IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do demonstrativo?" + CHR(13) + ;
                "Todos os itens associados tamb" + CHR(233) + "m ser" + CHR(227) + "o exclu" + ;
                CHR(237) + "dos.", "Excluir")
                RETURN
            ENDIF
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
            RETURN
        ENDIF

        *-- INCLUIR / ALTERAR: validar campo obrigatorio Balancos
        IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
            IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.Value))
                MsgAviso("Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF !THIS.this_oBusinessObject.ValidarDados()
            IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
                THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
            ENDIF
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso.")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do Form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
            THIS.this_oBusinessObject.this_cBalanco = ALLTRIM(loc_oPagina.txt_4c_Balanco.Value)
            THIS.this_oBusinessObject.this_cTitulo  = ALLTRIM(loc_oPagina.txt_4c_Titulo.Value)
            THIS.this_oBusinessObject.this_nMapa    = loc_oPagina.opt_4c_Impressao.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os campos do Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
            loc_oPagina.txt_4c_Balanco.Value   = THIS.this_oBusinessObject.this_cBalanco
            loc_oPagina.txt_4c_Titulo.Value    = THIS.this_oBusinessObject.this_cTitulo
            loc_oPagina.opt_4c_Impressao.Value = THIS.this_oBusinessObject.this_nMapa
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
            loc_oPagina.txt_4c_Balanco.Value   = ""
            loc_oPagina.txt_4c_Titulo.Value    = ""
            loc_oPagina.opt_4c_Impressao.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
            *-- Balanco editavel apenas em INCLUIR (chave primaria nao pode ser alterada)
            loc_oPagina.txt_4c_Balanco.Enabled   = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
            loc_oPagina.txt_4c_Titulo.Enabled    = par_lHabilitar
            loc_oPagina.opt_4c_Impressao.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita Confirmar apenas em modos que permitem acao
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "EXCLUIR")
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDIF
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual da grade (Tahoma 8 conforme legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
