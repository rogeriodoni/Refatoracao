*==============================================================================
* Formcfo.prg - Formulario de Cadastro de CFOP
* Tabela: SigCdCfo
* Tipo: CRUD (frmcadastro)
* Fase 8/8: COMPLETO (todos os metodos, FormParaBO, BOParaForm, AjustarBotoesPorModo)
*==============================================================================

DEFINE CLASS Formcfo AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY - Height=700 do legado)
    Height      = 700
    Width       = 1000
    Caption     = "Cadastro de CFOP"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades internas
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar Formcfo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("cfoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar cfoBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .Visible    = .T.
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(224, 223, 227)
            .Page2.BackColor = RGB(224, 223, 227)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho cinza superior (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .SpecialEffect = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = "Cadastro de CFOP"
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = "Cadastro de CFOP"
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (Grupo_Op no legado)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

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

        *-- Container saida - padrao canonico (Grupo_Saida no legado)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .SpecialEffect = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 917
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Botoes Exporta/Importa XML (legado: btnExpXML/btnImpXML top=82+29=111)
        loc_oPagina.AddObject("cmd_4c_ExpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExpXML
            .Caption       = "Exporta XML"
            .Top           = 111
            .Left          = 681
            .Width         = 120
            .Height        = 40
            .FontName      = "Tahoma"
            .FontBold      = .F.
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_ImpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_ImpXML
            .Caption       = "Importa XML"
            .Top           = 111
            .Left          = 801
            .Width         = 120
            .Height        = 40
            .FontName      = "Tahoma"
            .FontBold      = .F.
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Grid de lista (Grade no legado) - top=127+29=156 com compensacao PageFrame
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 156
            .Left               = 11
            .Width              = 972
            .Height             = 520
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH
        loc_oPagina.grd_4c_Lista.ColumnCount = 2

        *-- BINDEVENTs para botoes CRUD e auxiliares
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
        BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da Page1 Lista)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = "Cadastro de CFOP"
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = "Cadastro de CFOP"
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container salvar/cancelar (botoes adicionados na Fase 6)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top           = 33
            .Left          = 842
            .Width         = 160
            .Height        = 85
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Botao Salvar
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Salvar
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar / Encerrar edicao
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 83
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- PageFrame interno (PagDados no legado) - top=120+29=149
        loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
        WITH loc_oPagina.pgf_4c_PagDados
            .PageCount       = 2
            .Top             = 149
            .Left            = -1
            .Width           = 998
            .Height          = 730
            .Tabs            = .T.
            .Visible         = .T.
            .Page1.Caption   = "Dados CFOP"
            .Page2.Caption   = "Contabilidade"
            .Page1.BackColor = RGB(224, 223, 227)
            .Page2.BackColor = RGB(224, 223, 227)
        ENDWITH

        THIS.ConfigurarPgPage1()
        THIS.ConfigurarPgPage2()


        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPgPage1 - Configura controles da Page1 (Dados CFOP)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage1()
        LOCAL loc_oPage1
        loc_oPage1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1


        *-- Separadores horizontais
        loc_oPage1.AddObject("shp_4c_Shp01", "Shape")
        WITH loc_oPage1.shp_4c_Shp01
            .Top         = 92
            .Left        = 3
            .Width       = 984
            .Height      = 1
            .BackColor   = RGB(128, 128, 128)
            .BorderColor = RGB(128, 128, 128)
            .Visible     = .T.
        ENDWITH

        loc_oPage1.AddObject("shp_4c_Shp03", "Shape")
        WITH loc_oPage1.shp_4c_Shp03
            .Top         = 236
            .Left        = 3
            .Width       = 984
            .Height      = 1
            .BackColor   = RGB(128, 128, 128)
            .BorderColor = RGB(128, 128, 128)
            .Visible     = .T.
        ENDWITH

        *-- Separador vertical NF-e
        loc_oPage1.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPage1.shp_4c_Shape1
            .Top         = 243
            .Left        = 488
            .Width       = 1
            .Height      = 206
            .BackColor   = RGB(128, 128, 128)
            .BorderColor = RGB(128, 128, 128)
            .Visible     = .T.
        ENDWITH

        *-- Label: Codigo
        loc_oPage1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPage1.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 11
            .Left      = 90
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Codigo (getCodigo) - codigos char(10)
        loc_oPage1.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPage1.txt_4c_Codigo
            .Top       = 7
            .Left      = 136
            .Width     = 91
            .Height    = 24
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- opc_situacao - situas (0=Ativo 1=Inativo)
        loc_oPage1.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH loc_oPage1.obj_4c_Opc_situacao
            .ButtonCount = 2
            .Top         = 11
            .Left        = 243
            .Width       = 137
            .Height      = 17
            .BackStyle   = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Ativo"
                .Width     = 65
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Inativo"
                .Width     = 65
                .Height    = 17
                .Left      = 67
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Operacao
        loc_oPage1.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPage1.lbl_4c_Label3
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 11
            .Left      = 393
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- cmbOperacao - operacaos char(1) E/S
        loc_oPage1.AddObject("cbo_4c_CmbOperacao", "ComboBox")
        WITH loc_oPage1.cbo_4c_CmbOperacao
            .Top           = 7
            .Left          = 459
            .Width         = 107
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "E,S"
            .Style         = 2
            .Value         = "E"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Tipo
        loc_oPage1.AddObject("lbl_4c_Label37", "Label")
        WITH loc_oPage1.lbl_4c_Label37
            .Caption   = "Tipo :"
            .Top       = 11
            .Left      = 620
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- cmbtipo - tipos numeric(1,0)
        loc_oPage1.AddObject("cbo_4c_Cmbtipo", "ComboBox")
        WITH loc_oPage1.cbo_4c_Cmbtipo
            .Top           = 7
            .Left          = 653
            .Width         = 151
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "0,1,2,3,4,5,6,7,8,9"
            .Style         = 2
            .Value         = "0"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Digitos Para NF
        loc_oPage1.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPage1.lbl_4c_Label24
            .Caption   = "D" + CHR(237) + "gitos Para NF :"
            .Top       = 12
            .Left      = 861
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- spn_4c_Ndigito - ndigitos numeric(2,0)
        loc_oPage1.AddObject("spn_4c_Ndigito", "Spinner")
        WITH loc_oPage1.spn_4c_Ndigito
            .Top              = 7
            .Left             = 947
            .Width            = 40
            .Height           = 24
            .SpinnerLowValue  = 0
            .SpinnerHighValue = 99
            .Value            = 0
            .FontName         = "Tahoma"
            .FontSize         = 8
            .Visible          = .T.
        ENDWITH

        *-- Label: Descricao Nota Fiscal
        loc_oPage1.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPage1.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Nota Fiscal :"
            .Top       = 38
            .Left      = 22
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Descricao - descricaos char(60)
        loc_oPage1.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPage1.txt_4c_Descricao
            .Top       = 34
            .Left      = 136
            .Width     = 430
            .Height    = 24
            .MaxLength = 60
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Descricao Consulta
        loc_oPage1.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oPage1.lbl_4c_Label29
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Consulta :"
            .Top       = 65
            .Left      = 32
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Desc2s - desc2s char(60)
        loc_oPage1.AddObject("txt_4c_Desc2s", "TextBox")
        WITH loc_oPage1.txt_4c_Desc2s
            .Top       = 61
            .Left      = 136
            .Width     = 430
            .Height    = 24
            .MaxLength = 60
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- === SECAO ICMS ===

        *-- Label: ICMS
        loc_oPage1.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPage1.lbl_4c_Label4
            .Caption   = "I C M S :"
            .Top       = 105
            .Left      = 88
            .Width     = 43
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- cmbIcms - icms char(1) T/I/O/N
        loc_oPage1.AddObject("cbo_4c_CmbIcms", "ComboBox")
        WITH loc_oPage1.cbo_4c_CmbIcms
            .Top           = 101
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "T,I,O,N"
            .Style         = 2
            .Value         = "T"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Sobre Desconto (icmsincs)
        loc_oPage1.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oPage1.lbl_4c_Label31
            .Caption   = "Sobre Desconto :"
            .Top       = 131
            .Left      = 46
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo6 - icmsincs numeric(1,0)
        loc_oPage1.AddObject("cbo_4c_Combo6", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo6
            .Top           = 127
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "0,1"
            .Style         = 2
            .Value         = "0"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Incluir ICMS
        loc_oPage1.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPage1.lbl_4c_Label26
            .Caption   = "Incluir ICMS :"
            .Top       = 105
            .Left      = 309
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo3 - inclicms numeric(1,0)
        loc_oPage1.AddObject("cbo_4c_Combo3", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo3
            .Top           = 101
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "0,1"
            .Style         = 2
            .Value         = "0"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Inclui IPI na Base
        loc_oPage1.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPage1.lbl_4c_Label25
            .Caption   = "Inclui IPI na Base :"
            .Top       = 131
            .Left      = 283
            .Width     = 92
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo4 - inclipis numeric(1,0)
        loc_oPage1.AddObject("cbo_4c_Combo4", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo4
            .Top           = 127
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "0,1"
            .Style         = 2
            .Value         = "0"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: ICMS Sobre
        loc_oPage1.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPage1.lbl_4c_Label14
            .Caption   = "ICMS Sobre :"
            .Top       = 104
            .Left      = 481
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_4c_ObjFreteICM - frticms numeric(1,0)
        loc_oPage1.AddObject("chk_4c_ObjFreteICM", "CheckBox")
        WITH loc_oPage1.chk_4c_ObjFreteICM
            .Caption   = "Frete"
            .Top       = 102
            .Left      = 549
            .Width     = 44
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_4c_ObjSegIcm - segicms numeric(1,0)
        loc_oPage1.AddObject("chk_4c_ObjSegIcm", "CheckBox")
        WITH loc_oPage1.chk_4c_ObjSegIcm
            .Caption   = "Seguro"
            .Top       = 117
            .Left      = 549
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_4c_ObjDespIcm - desicms numeric(1,0)
        loc_oPage1.AddObject("chk_4c_ObjDespIcm", "CheckBox")
        WITH loc_oPage1.chk_4c_ObjDespIcm
            .Caption   = "Despesas Acess" + CHR(243) + "rias"
            .Top       = 132
            .Left      = 549
            .Width     = 118
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_4c_Fwcheckbox1 - incicmnfs numeric(1,0)
        loc_oPage1.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
        WITH loc_oPage1.chk_4c_Fwcheckbox1
            .Caption   = "Incluir ICMS no Total da N.F."
            .Top       = 147
            .Left      = 549
            .Width     = 156
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: CFOP ST60
        loc_oPage1.AddObject("lbl_4c_Label49", "Label")
        WITH loc_oPage1.lbl_4c_Label49
            .Caption   = "CFOP ST60:"
            .Top       = 104
            .Left      = 627
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CfoST60 - cfost60s char(10)
        loc_oPage1.AddObject("txt_4c_CfoST60", "TextBox")
        WITH loc_oPage1.txt_4c_CfoST60
            .Top       = 101
            .Left      = 690
            .Width     = 82
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: CFOP Subst.Trib.
        loc_oPage1.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPage1.lbl_4c_Label11
            .Caption   = "CFOP Subst.Trib.:"
            .Top       = 103
            .Left      = 794
            .Width     = 89
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CfoST - cfosts char(10)
        loc_oPage1.AddObject("txt_4c_CfoST", "TextBox")
        WITH loc_oPage1.txt_4c_CfoST
            .Top       = 101
            .Left      = 887
            .Width     = 82
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Substituicao Tributaria
        loc_oPage1.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPage1.lbl_4c_Label10
            .Caption   = "Substitui" + CHR(231) + CHR(227) + "o Tribut.:"
            .Top       = 157
            .Left      = 32
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- CmbSTRIB - subtribs char(1) S/N
        loc_oPage1.AddObject("cbo_4c_CmbSTRIB", "ComboBox")
        WITH loc_oPage1.cbo_4c_CmbSTRIB
            .Top           = 153
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "S,N"
            .Style         = 2
            .Value         = "N"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Base Substituicao
        loc_oPage1.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPage1.lbl_4c_Label12
            .Caption   = "Base Substitui" + CHR(231) + CHR(227) + "o :"
            .Top       = 157
            .Left      = 282
            .Width     = 93
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Bcst - pbcsts numeric(5,2)
        loc_oPage1.AddObject("txt_4c_Bcst", "TextBox")
        WITH loc_oPage1.txt_4c_Bcst
            .Top       = 153
            .Left      = 380
            .Width     = 82
            .Height    = 23
            .Value     = 0
            .Format    = "N"
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: CFOP Transporte
        loc_oPage1.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPage1.lbl_4c_Label28
            .Caption   = "CFOP Transporte :"
            .Top       = 158
            .Left      = 791
            .Width     = 92
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo5 - transps numeric(1,0)
        loc_oPage1.AddObject("cbo_4c_Combo5", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo5
            .Top           = 153
            .Left          = 887
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "0,1"
            .Style         = 2
            .Value         = "0"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Situacao Tributaria
        loc_oPage1.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPage1.lbl_4c_Label22
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut.:"
            .Top       = 183
            .Left      = 49
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Sittricm - sittribs char(3)
        loc_oPage1.AddObject("txt_4c_Sittricm", "TextBox")
        WITH loc_oPage1.txt_4c_Sittricm
            .Top       = 179
            .Left      = 136
            .Width     = 31
            .Height    = 22
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: ICMS Incluso no Preco
        loc_oPage1.AddObject("lbl_4c_Label36", "Label")
        WITH loc_oPage1.lbl_4c_Label36
            .Caption   = "ICMS Incluso no Pre" + CHR(231) + "o:"
            .Top       = 182
            .Left      = 262
            .Width     = 113
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo10 - icmsdscs numeric(1,0)
        loc_oPage1.AddObject("cbo_4c_Combo10", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo10
            .Top           = 178
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "0,1"
            .Style         = 2
            .Value         = "0"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Contribuinte
        loc_oPage1.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPage1.lbl_4c_Label6
            .Caption   = "Contribuinte :"
            .Top       = 184
            .Left      = 815
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- cmbContribuinte - contribs char(1) S/N/O
        loc_oPage1.AddObject("cbo_4c_CmbContribuinte", "ComboBox")
        WITH loc_oPage1.cbo_4c_CmbContribuinte
            .Top           = 179
            .Left          = 887
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "S,N,O"
            .Style         = 2
            .Value         = "N"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Venda Consumidor
        loc_oPage1.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oPage1.lbl_4c_Label23
            .Caption   = "Venda Consumidor :"
            .Top       = 207
            .Left      = 33
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_AliqIVCs - aliqivcs numeric(4,2)
        loc_oPage1.AddObject("txt_4c_AliqIVCs", "TextBox")
        WITH loc_oPage1.txt_4c_AliqIVCs
            .Top       = 203
            .Left      = 136
            .Width     = 82
            .Height    = 23
            .Value     = 0
            .Format    = "N"
            .InputMask = "99.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: % (aliqivcs)
        loc_oPage1.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPage1.lbl_4c_Label13
            .Caption   = "%"
            .Top       = 207
            .Left      = 219
            .Width     = 13
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: CFOP Destino
        loc_oPage1.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPage1.lbl_4c_Label19
            .Caption   = "CFOP Destino :"
            .Top       = 132
            .Left      = 808
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Cfdest - coddests char(10)
        loc_oPage1.AddObject("txt_4c_Cfdest", "TextBox")
        WITH loc_oPage1.txt_4c_Cfdest
            .Top       = 127
            .Left      = 887
            .Width     = 82
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Inibe Valor Unitario NF Importacao
        loc_oPage1.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPage1.lbl_4c_Label21
            .Caption   = "Inibe Valor Unit" + CHR(225) + "rio na NF Importa" + CHR(231) + CHR(227) + "o :"
            .Top       = 211
            .Left      = 694
            .Width     = 189
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo9 - unitimps char(1) S/N
        loc_oPage1.AddObject("cbo_4c_Combo9", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo9
            .Top           = 206
            .Left          = 887
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "S,N"
            .Style         = 2
            .Value         = "N"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Especificacoes Para NF-e
        loc_oPage1.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oPage1.lbl_4c_Label38
            .Caption   = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
            .Top       = 246
            .Left      = 498
            .Width     = 140
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Destaca ICMS na Nota Fiscal (S/N)
        loc_oPage1.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPage1.lbl_4c_Label27
            .Caption   = "Destaca ICMS na Nota Fiscal (S/N) :"
            .Top       = 270
            .Left      = 771
            .Width     = 174
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Gergia1 - cgergia1s char(1)
        loc_oPage1.AddObject("txt_4c_Gergia1", "TextBox")
        WITH loc_oPage1.txt_4c_Gergia1
            .Top       = 265
            .Left      = 948
            .Width     = 20
            .Height    = 23
            .MaxLength = 1
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- === SECAO IPI ===

        *-- Label: IPI
        loc_oPage1.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPage1.lbl_4c_Label8
            .Caption   = "I P I :"
            .Top       = 267
            .Left      = 103
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- cmbIpi - ipis char(1) T/I/O
        loc_oPage1.AddObject("cbo_4c_CmbIpi", "ComboBox")
        WITH loc_oPage1.cbo_4c_CmbIpi
            .Top           = 263
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "T,I,O"
            .Style         = 2
            .Value         = "T"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: IPI Importacao
        loc_oPage1.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPage1.lbl_4c_Label7
            .Caption   = "IPI Importa" + CHR(231) + CHR(227) + "o :"
            .Top       = 267
            .Left      = 296
            .Width     = 81
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- cmbIpiI - ipiimpors char(1) S/N
        loc_oPage1.AddObject("cbo_4c_CmbIpiI", "ComboBox")
        WITH loc_oPage1.cbo_4c_CmbIpiI
            .Top           = 263
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "S,N"
            .Style         = 2
            .Value         = "N"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Codigo IPI Sit. Trib.
        loc_oPage1.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oPage1.lbl_4c_Label30
            .Caption   = "C" + CHR(243) + "digo IPI Sit. Trib.:"
            .Top       = 269
            .Left      = 583
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_IPICST - ipicst char(2)
        loc_oPage1.AddObject("txt_4c_IPICST", "TextBox")
        WITH loc_oPage1.txt_4c_IPICST
            .Top       = 266
            .Left      = 691
            .Width     = 26
            .Height    = 23
            .MaxLength = 2
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Aliquota IPI
        loc_oPage1.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPage1.lbl_4c_Label15
            .Caption   = "Al" + CHR(237) + "quota :"
            .Top       = 293
            .Left      = 84
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Aliqs - aliqipis numeric(4,2)
        loc_oPage1.AddObject("txt_4c_Aliqs", "TextBox")
        WITH loc_oPage1.txt_4c_Aliqs
            .Top       = 289
            .Left      = 136
            .Width     = 82
            .Height    = 23
            .Value     = 0
            .Format    = "N"
            .InputMask = "99.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Retira IPI do Valor
        loc_oPage1.AddObject("lbl_4c_Label32", "Label")
        WITH loc_oPage1.lbl_4c_Label32
            .Caption   = "Retira IPI do $ :"
            .Top       = 293
            .Left      = 298
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo7 - pontedescs numeric(1,0)
        loc_oPage1.AddObject("cbo_4c_Combo7", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo7
            .Top           = 289
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "0,1"
            .Style         = 2
            .Value         = "0"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Nao Creditado
        loc_oPage1.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPage1.lbl_4c_Label20
            .Caption   = "N" + CHR(227) + "o Creditado :"
            .Top       = 319
            .Left      = 54
            .Width     = 78
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo1 - ipincreds numeric(1,0)
        loc_oPage1.AddObject("cbo_4c_Combo1", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo1
            .Top           = 315
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "0,1"
            .Style         = 2
            .Value         = "0"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Acresc. na Base
        loc_oPage1.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPage1.lbl_4c_Label17
            .Caption   = "Acr" + CHR(233) + "sc. na Base :"
            .Top       = 319
            .Left      = 291
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo2 - acresipis char(1) S/N
        loc_oPage1.AddObject("cbo_4c_Combo2", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo2
            .Top           = 315
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "S,N"
            .Style         = 2
            .Value         = "N"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Base de Calculo IPI
        loc_oPage1.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPage1.lbl_4c_Label5
            .Caption   = "Base de C" + CHR(225) + "lculo :"
            .Top       = 345
            .Left      = 48
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- CmbBIPI - bcipis char(1) (base calculo IPI)
        loc_oPage1.AddObject("cbo_4c_CmbBIPI", "ComboBox")
        WITH loc_oPage1.cbo_4c_CmbBIPI
            .Top           = 341
            .Left          = 136
            .Width         = 196
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "F,P,T,O"
            .Style         = 2
            .Value         = "P"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: % (pbcipis)
        loc_oPage1.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPage1.lbl_4c_Label9
            .Caption   = "%"
            .Top       = 322
            .Left      = 463
            .Width     = 13
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_BcIPI - pbcipis numeric(5,2)
        loc_oPage1.AddObject("txt_4c_BcIPI", "TextBox")
        WITH loc_oPage1.txt_4c_BcIPI
            .Top       = 341
            .Left      = 380
            .Width     = 82
            .Height    = 23
            .Value     = 0
            .Format    = "N"
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: IPI Sobre (frete/seguro/despesas)
        loc_oPage1.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPage1.lbl_4c_Label16
            .Caption   = "IPI Sobre :"
            .Top       = 395
            .Left      = 75
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_4c_ObjFreteIPI - frtipis numeric(1,0)
        loc_oPage1.AddObject("chk_4c_ObjFreteIPI", "CheckBox")
        WITH loc_oPage1.chk_4c_ObjFreteIPI
            .Caption   = "Frete"
            .Top       = 395
            .Left      = 137
            .Width     = 44
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_4c_ObjSegIPI - segipis numeric(1,0)
        loc_oPage1.AddObject("chk_4c_ObjSegIPI", "CheckBox")
        WITH loc_oPage1.chk_4c_ObjSegIPI
            .Caption   = "Seguro"
            .Top       = 395
            .Left      = 188
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_4c_ObjDespIPI - desipis numeric(1,0)
        loc_oPage1.AddObject("chk_4c_ObjDespIPI", "CheckBox")
        WITH loc_oPage1.chk_4c_ObjDespIPI
            .Caption   = "Despesas Acess" + CHR(243) + "rias"
            .Top       = 395
            .Left      = 255
            .Width     = 118
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Calcula IPI Importacao Origem=2
        loc_oPage1.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPage1.lbl_4c_Label18
            .Caption   = "Calcula IPI Importa" + CHR(231) + CHR(227) + "o Para Origem Mercadoria=2 :"
            .Top       = 371
            .Left      = 125
            .Width     = 250
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Combo8 - ipiom2s char(1) S/N
        loc_oPage1.AddObject("cbo_4c_Combo8", "ComboBox")
        WITH loc_oPage1.cbo_4c_Combo8
            .Top           = 367
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "S,N"
            .Style         = 2
            .Value         = "N"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- === SECAO NF-e: PIS / COFINS / ISSQN / II ===

        *-- Label: Codigo PIS Sit. Trib.
        loc_oPage1.AddObject("lbl_4c_Label33", "Label")
        WITH loc_oPage1.lbl_4c_Label33
            .Caption   = "C" + CHR(243) + "digo PIS Sit. Trib.:"
            .Top       = 295
            .Left      = 581
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_PISCST - piscst char(2)
        loc_oPage1.AddObject("txt_4c_PISCST", "TextBox")
        WITH loc_oPage1.txt_4c_PISCST
            .Top       = 291
            .Left      = 691
            .Width     = 26
            .Height    = 23
            .MaxLength = 2
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Aliquota do PIS
        loc_oPage1.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oPage1.lbl_4c_Label39
            .Caption   = "Al" + CHR(237) + "quota do PIS :"
            .Top       = 295
            .Left      = 829
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_AliqPIS - aliqpis numeric(5,2)
        loc_oPage1.AddObject("txt_4c_AliqPIS", "TextBox")
        WITH loc_oPage1.txt_4c_AliqPIS
            .Top       = 291
            .Left      = 916
            .Width     = 52
            .Height    = 23
            .Value     = 0
            .Format    = "N"
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: % (PIS)
        loc_oPage1.AddObject("lbl_4c_Label40", "Label")
        WITH loc_oPage1.lbl_4c_Label40
            .Caption   = "%"
            .Top       = 295
            .Left      = 971
            .Width     = 14
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Codigo COFINS Sit. Trib.
        loc_oPage1.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oPage1.lbl_4c_Label34
            .Caption   = "C" + CHR(243) + "digo COFINS Sit. Trib.:"
            .Top       = 319
            .Left      = 559
            .Width     = 124
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_COFCST - cofcst char(2)
        loc_oPage1.AddObject("txt_4c_COFCST", "TextBox")
        WITH loc_oPage1.txt_4c_COFCST
            .Top       = 315
            .Left      = 691
            .Width     = 26
            .Height    = 23
            .MaxLength = 2
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Aliquota do COFINS
        loc_oPage1.AddObject("lbl_4c_Label41", "Label")
        WITH loc_oPage1.lbl_4c_Label41
            .Caption   = "Al" + CHR(237) + "quota do COFINS :"
            .Top       = 319
            .Left      = 807
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_AliqCofins - aliqcofins numeric(5,2)
        loc_oPage1.AddObject("txt_4c_AliqCofins", "TextBox")
        WITH loc_oPage1.txt_4c_AliqCofins
            .Top       = 315
            .Left      = 916
            .Width     = 52
            .Height    = 23
            .Value     = 0
            .Format    = "N"
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: % (COFINS)
        loc_oPage1.AddObject("lbl_4c_Label42", "Label")
        WITH loc_oPage1.lbl_4c_Label42
            .Caption   = "%"
            .Top       = 319
            .Left      = 971
            .Width     = 14
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Codigo ISSQN Lista Serv.
        loc_oPage1.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oPage1.lbl_4c_Label35
            .Caption   = "C" + CHR(243) + "digo ISSQN Lista Serv.:"
            .Top       = 343
            .Left      = 556
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_ISSQNL - issqnl char(5)
        loc_oPage1.AddObject("txt_4c_ISSQNL", "TextBox")
        WITH loc_oPage1.txt_4c_ISSQNL
            .Top       = 339
            .Left      = 691
            .Width     = 40
            .Height    = 23
            .MaxLength = 5
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Aliquota do ISSQN
        loc_oPage1.AddObject("lbl_4c_Label44", "Label")
        WITH loc_oPage1.lbl_4c_Label44
            .Caption   = "Al" + CHR(237) + "quota do ISSQN :"
            .Top       = 343
            .Left      = 814
            .Width     = 97
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_AliqISSQN - aliqissqn numeric(5,2)
        loc_oPage1.AddObject("txt_4c_AliqISSQN", "TextBox")
        WITH loc_oPage1.txt_4c_AliqISSQN
            .Top       = 339
            .Left      = 916
            .Width     = 52
            .Height    = 23
            .Value     = 0
            .Format    = "N"
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: % (ISSQN)
        loc_oPage1.AddObject("lbl_4c_Label45", "Label")
        WITH loc_oPage1.lbl_4c_Label45
            .Caption   = "%"
            .Top       = 343
            .Left      = 971
            .Width     = 14
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Codigo de Trib. do ISSQN
        loc_oPage1.AddObject("lbl_4c_Label43", "Label")
        WITH loc_oPage1.lbl_4c_Label43
            .Caption   = "C" + CHR(243) + "digo de Trib. do ISSQN:"
            .Top       = 369
            .Left      = 555
            .Width     = 128
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Fwoption1 - ctissqn numeric(1,0), 5 buttons (0-4)
        loc_oPage1.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPage1.obj_4c_Fwoption1
            .ButtonCount = 5
            .Top         = 368
            .Left        = 686
            .Width       = 297
            .Height      = 34
            .BackStyle   = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "0"
                .Width     = 55
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "1"
                .Width     = 55
                .Height    = 17
                .Left      = 57
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "2"
                .Width     = 55
                .Height    = 17
                .Left      = 114
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "3"
                .Width     = 55
                .Height    = 17
                .Left      = 171
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(5)
                .Caption   = "4"
                .Width     = 55
                .Height    = 17
                .Left      = 228
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Informa Retencao de Trib.
        loc_oPage1.AddObject("lbl_4c_Label46", "Label")
        WITH loc_oPage1.lbl_4c_Label46
            .Caption   = "Informa Reten" + CHR(231) + CHR(227) + "o de Trib.:"
            .Top       = 404
            .Left      = 550
            .Width     = 133
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Fwoption2 - rettribs numeric(1,0), 2 buttons Sim/Nao
        loc_oPage1.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH loc_oPage1.obj_4c_Fwoption2
            .ButtonCount = 2
            .Top         = 399
            .Left        = 686
            .Width       = 95
            .Height      = 25
            .BackStyle   = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Width     = 44
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Width     = 44
                .Height    = 17
                .Left      = 46
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Aliquota do II
        loc_oPage1.AddObject("lbl_4c_Label47", "Label")
        WITH loc_oPage1.lbl_4c_Label47
            .Caption   = "Al" + CHR(237) + "quota do II :"
            .Top       = 404
            .Left      = 839
            .Width     = 74
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_AliqII - aliqii numeric(5,2)
        loc_oPage1.AddObject("txt_4c_AliqII", "TextBox")
        WITH loc_oPage1.txt_4c_AliqII
            .Top       = 400
            .Left      = 916
            .Width     = 52
            .Height    = 23
            .Value     = 0
            .Format    = "N"
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: % (II)
        loc_oPage1.AddObject("lbl_4c_Label48", "Label")
        WITH loc_oPage1.lbl_4c_Label48
            .Caption   = "%"
            .Top       = 404
            .Left      = 971
            .Width     = 13
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Enquadramento IPI
        loc_oPage1.AddObject("lbl_4c_Label50", "Label")
        WITH loc_oPage1.lbl_4c_Label50
            .Caption   = "Enquadramento IPI:"
            .Top       = 427
            .Left      = 583
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Enqipi - ipienq char(3)
        loc_oPage1.AddObject("txt_4c_Enqipi", "TextBox")
        WITH loc_oPage1.txt_4c_Enqipi
            .Top       = 424
            .Left      = 691
            .Width     = 26
            .Height    = 23
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs para campos com lookup (F4/F5 + DblClick)
        BINDEVENT(loc_oPage1.txt_4c_CfoST60,  "KeyPress", THIS, "CfoST60LookupKeyPress")
        BINDEVENT(loc_oPage1.txt_4c_CfoST60,  "DblClick", THIS, "CfoST60LookupDblClick")
        BINDEVENT(loc_oPage1.txt_4c_CfoST,    "KeyPress", THIS, "CfoSTLookupKeyPress")
        BINDEVENT(loc_oPage1.txt_4c_CfoST,    "DblClick", THIS, "CfoSTLookupDblClick")
        BINDEVENT(loc_oPage1.txt_4c_Cfdest,   "KeyPress", THIS, "CfdestLookupKeyPress")
        BINDEVENT(loc_oPage1.txt_4c_Cfdest,   "DblClick", THIS, "CfdestLookupDblClick")
        BINDEVENT(loc_oPage1.txt_4c_Sittricm, "KeyPress", THIS, "SittricmLookupKeyPress")
        BINDEVENT(loc_oPage1.txt_4c_Sittricm, "DblClick", THIS, "SittricmLookupDblClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPgPage2 - Configura controles da Page2 (Integracao Contabil/Fiscal)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage2()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

        *-- Separador secoes
        loc_oPg2.AddObject("shp_4c_Shp03", "Shape")
        WITH loc_oPg2.shp_4c_Shp03
            .Top         = 211
            .Left        = 5
            .Width       = 984
            .Height      = 1
            .BackColor   = RGB(128, 128, 128)
            .BorderColor = RGB(128, 128, 128)
            .Visible     = .T.
        ENDWITH

        *-- Label: Integracao Contabil (titulo secao)
        loc_oPg2.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg2.lbl_4c_Label7
            .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
            .Top       = 6
            .Left      = 15
            .Width     = 114
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Valor Contabil
        loc_oPg2.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPg2.lbl_4c_Label10
            .Caption   = "Valor Cont" + CHR(225) + "bil :"
            .Top       = 34
            .Left      = 82
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: DB / CR (Valor Contabil)
        loc_oPg2.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg2.lbl_4c_Label13
            .Caption   = "DB"
            .Top       = 34
            .Left      = 243
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPg2.lbl_4c_Label14
            .Caption   = "CR"
            .Top       = 34
            .Left      = 344
            .Width     = 16
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Vrcds - contvcds char(9)
        loc_oPg2.AddObject("txt_4c_Vrcds", "TextBox")
        WITH loc_oPg2.txt_4c_Vrcds
            .Top       = 30
            .Left      = 162
            .Width     = 73
            .Height    = 24
            .MaxLength = 9
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Vrccs - contvccs char(9)
        loc_oPg2.AddObject("txt_4c_Vrccs", "TextBox")
        WITH loc_oPg2.txt_4c_Vrccs
            .Top       = 30
            .Left      = 265
            .Width     = 73
            .Height    = 24
            .MaxLength = 9
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: IPI
        loc_oPg2.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPg2.lbl_4c_Label11
            .Caption   = "IPI :"
            .Top       = 60
            .Left      = 134
            .Width     = 23
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: DB / CR (IPI)
        loc_oPg2.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPg2.lbl_4c_Label15
            .Caption   = "DB"
            .Top       = 60
            .Left      = 243
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPg2.lbl_4c_Label16
            .Caption   = "CR"
            .Top       = 60
            .Left      = 344
            .Width     = 16
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Ipids - contipds char(9)
        loc_oPg2.AddObject("txt_4c_Ipids", "TextBox")
        WITH loc_oPg2.txt_4c_Ipids
            .Top       = 56
            .Left      = 162
            .Width     = 73
            .Height    = 24
            .MaxLength = 9
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Ipics - contipcs char(9)
        loc_oPg2.AddObject("txt_4c_Ipics", "TextBox")
        WITH loc_oPg2.txt_4c_Ipics
            .Top       = 56
            .Left      = 265
            .Width     = 73
            .Height    = 24
            .MaxLength = 9
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: ICMS
        loc_oPg2.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPg2.lbl_4c_Label12
            .Caption   = "ICMS :"
            .Top       = 86
            .Left      = 123
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: DB / CR (ICMS)
        loc_oPg2.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPg2.lbl_4c_Label17
            .Caption   = "DB"
            .Top       = 86
            .Left      = 243
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPg2.lbl_4c_Label18
            .Caption   = "CR"
            .Top       = 86
            .Left      = 344
            .Width     = 16
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Icmds - conticds char(9)
        loc_oPg2.AddObject("txt_4c_Icmds", "TextBox")
        WITH loc_oPg2.txt_4c_Icmds
            .Top       = 82
            .Left      = 162
            .Width     = 73
            .Height    = 24
            .MaxLength = 9
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Icmcs - conticcs char(9)
        loc_oPg2.AddObject("txt_4c_Icmcs", "TextBox")
        WITH loc_oPg2.txt_4c_Icmcs
            .Top       = 82
            .Left      = 265
            .Width     = 73
            .Height    = 24
            .MaxLength = 9
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Conta de Frete
        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .Caption   = "Conta de Frete :"
            .Top       = 112
            .Left      = 75
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_ContFrt - contfrt char(9)
        loc_oPg2.AddObject("txt_4c_ContFrt", "TextBox")
        WITH loc_oPg2.txt_4c_ContFrt
            .Top       = 108
            .Left      = 162
            .Width     = 73
            .Height    = 24
            .MaxLength = 9
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Conta de Seguro
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .Caption   = "Conta de Seguro :"
            .Top       = 138
            .Left      = 67
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_ContSeg - contseg char(9)
        loc_oPg2.AddObject("txt_4c_ContSeg", "TextBox")
        WITH loc_oPg2.txt_4c_ContSeg
            .Top       = 134
            .Left      = 162
            .Width     = 73
            .Height    = 24
            .MaxLength = 9
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Conta de Despesas
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .Caption   = "Conta de Despesas :"
            .Top       = 164
            .Left      = 55
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_ContDa - contda char(9)
        loc_oPg2.AddObject("txt_4c_ContDa", "TextBox")
        WITH loc_oPg2.txt_4c_ContDa
            .Top       = 160
            .Left      = 162
            .Width     = 73
            .Height    = 24
            .MaxLength = 9
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Descricao na Integracao
        loc_oPg2.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPg2.lbl_4c_Label21
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o :"
            .Top       = 31
            .Left      = 511
            .Width     = 126
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- cbo_4c_Combo2 - pontedescs numeric(1,0): ListIndex 1=Sim-Descricao, 2=Nao-Nenhuma, 3=Sim-Obs.
        loc_oPg2.AddObject("cbo_4c_CmbPonted", "ComboBox")
        WITH loc_oPg2.cbo_4c_CmbPonted
            .Top           = 27
            .Left          = 642
            .Width         = 199
            .Height        = 25
            .RowSourceType = 1
            .RowSource     = "Sim-Descri" + CHR(231) + CHR(227) + "o CFOP,N" + CHR(227) + "o-Nenhuma,Sim-Obs. Opera" + CHR(231) + CHR(227) + "o"
            .Style         = 2
            .Value         = "N" + CHR(227) + "o-Nenhuma"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Pega Conta Contabil da NF
        loc_oPg2.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg2.lbl_4c_Label8
            .Caption   = "Pega Conta Cont" + CHR(225) + "bil da NF :"
            .Top       = 57
            .Left      = 499
            .Width     = 138
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- cbo_4c_CmbFixa - contconts char(1): S=Sim(NF), N=Nao(CFOP), C=C.C.
        loc_oPg2.AddObject("cbo_4c_CmbFixa", "ComboBox")
        WITH loc_oPg2.cbo_4c_CmbFixa
            .Top           = 53
            .Left          = 642
            .Width         = 132
            .Height        = 25
            .RowSourceType = 1
            .RowSource     = "Sim (NF),N" + CHR(227) + "o (CFOP),C.C."
            .Style         = 2
            .Value         = "N" + CHR(227) + "o (CFOP)"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label: Agrupa CFO na Integracao
        loc_oPg2.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oPg2.lbl_4c_Label29
            .Caption   = "Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o :"
            .Top       = 84
            .Left      = 498
            .Width     = 139
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_OptAgrupas - agrupas numeric(1,0), 2 buttons Sim/Nao
        loc_oPg2.AddObject("obj_4c_OptAgrupas", "OptionGroup")
        WITH loc_oPg2.obj_4c_OptAgrupas
            .ButtonCount = 2
            .Top         = 79
            .Left        = 638
            .Width       = 94
            .Height      = 27
            .BackStyle   = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Width     = 43
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Width     = 43
                .Height    = 17
                .Left      = 45
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Integracao Zerada
        loc_oPg2.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oPg2.lbl_4c_Label30
            .Caption   = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
            .Top       = 108
            .Left      = 538
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_OptZeradas - zeradas numeric(1,0), 2 buttons Sim/Nao
        loc_oPg2.AddObject("obj_4c_OptZeradas", "OptionGroup")
        WITH loc_oPg2.obj_4c_OptZeradas
            .ButtonCount = 2
            .Top         = 103
            .Left        = 638
            .Width       = 94
            .Height      = 27
            .BackStyle   = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Width     = 43
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Width     = 43
                .Height    = 17
                .Left      = 45
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Data Lancamento Contabil
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .Caption   = "Data Lan" + CHR(231) + "amento Contabil :"
            .Top       = 132
            .Left      = 502
            .Width     = 135
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_Fwoption1 - dtintfis numeric(1,0): 1=Data Integracao, 2=Data N.F.
        loc_oPg2.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPg2.obj_4c_Fwoption1
            .ButtonCount = 2
            .Top         = 127
            .Left        = 638
            .Width       = 192
            .Height      = 25
            .BackStyle   = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Data Integra" + CHR(231) + CHR(227) + "o"
                .Width     = 97
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Data N.F."
                .Width     = 65
                .Height    = 17
                .Left      = 122
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Utilizar variacao de CFOP na Integracao
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .Caption   = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
            .Top       = 156
            .Left      = 427
            .Width     = 210
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_Optutilvars - utilvars numeric(1,0), 2 buttons Sim/Nao
        loc_oPg2.AddObject("obj_4c_Optutilvars", "OptionGroup")
        WITH loc_oPg2.obj_4c_Optutilvars
            .ButtonCount = 2
            .Top         = 150
            .Left        = 638
            .Width       = 94
            .Height      = 27
            .BackStyle   = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Width     = 43
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Width     = 43
                .Height    = 17
                .Left      = 45
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Integracao Fiscal (titulo secao)
        loc_oPg2.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oPg2.lbl_4c_Label35
            .Caption   = "Integra" + CHR(231) + CHR(227) + "o Fiscal"
            .Top       = 217
            .Left      = 18
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Integrar Valor Contabil
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .Caption   = "Integrar Valor Cont" + CHR(225) + "bil :"
            .Top       = 239
            .Left      = 114
            .Width     = 118
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_Fwoption2 - intvlrcont numeric(1,0), 2 buttons Sim/Nao
        loc_oPg2.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH loc_oPg2.obj_4c_Fwoption2
            .ButtonCount = 2
            .Top         = 233
            .Left        = 231
            .Width       = 94
            .Height      = 27
            .BackStyle   = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Width     = 43
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Width     = 43
                .Height    = 17
                .Left      = 45
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Integrar Valores Icms
        loc_oPg2.AddObject("lbl_4c_Label33", "Label")
        WITH loc_oPg2.lbl_4c_Label33
            .Caption   = "Integrar Valores Icms :"
            .Top       = 259
            .Left      = 120
            .Width     = 112
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_Fwoption3 - intvlricms numeric(1,0), 2 buttons Sim/Nao
        loc_oPg2.AddObject("obj_4c_Fwoption3", "OptionGroup")
        WITH loc_oPg2.obj_4c_Fwoption3
            .ButtonCount = 2
            .Top         = 253
            .Left        = 231
            .Width       = 94
            .Height      = 27
            .BackStyle   = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Width     = 43
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Width     = 43
                .Height    = 17
                .Left      = 45
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Integrar Valores Ipi
        loc_oPg2.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oPg2.lbl_4c_Label34
            .Caption   = "Integrar Valores Ipi :"
            .Top       = 278
            .Left      = 130
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_Fwoption4 - intvlripi numeric(1,0), 2 buttons Sim/Nao
        loc_oPg2.AddObject("obj_4c_Fwoption4", "OptionGroup")
        WITH loc_oPg2.obj_4c_Fwoption4
            .ButtonCount = 2
            .Top         = 272
            .Left        = 231
            .Width       = 94
            .Height      = 27
            .BackStyle   = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Width     = 43
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Width     = 43
                .Height    = 17
                .Left      = 45
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Movimentacao Fisica de Estoque
        loc_oPg2.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oPg2.lbl_4c_Label38
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
            .Top       = 298
            .Left      = 68
            .Width     = 164
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_Fwoption5 - indmov numeric(1,0), 2 buttons Sim/Nao
        loc_oPg2.AddObject("obj_4c_Fwoption5", "OptionGroup")
        WITH loc_oPg2.obj_4c_Fwoption5
            .ButtonCount = 2
            .Top         = 292
            .Left        = 231
            .Width       = 94
            .Height      = 27
            .BackStyle   = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Width     = 43
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Width     = 43
                .Height    = 17
                .Left      = 45
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Label: Indicacao de Pagamento
        loc_oPg2.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oPg2.lbl_4c_Label39
            .Caption   = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
            .Top       = 318
            .Left      = 105
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_Fwoption6 - indpagto numeric(1,0), 2 buttons Sim/Nao
        loc_oPg2.AddObject("obj_4c_Fwoption6", "OptionGroup")
        WITH loc_oPg2.obj_4c_Fwoption6
            .ButtonCount = 2
            .Top         = 312
            .Left        = 231
            .Width       = 94
            .Height      = 27
            .BackStyle   = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Width     = 43
                .Height    = 17
                .Left      = 0
                .Top       = 0
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Width     = 43
                .Height    = 17
                .Left      = 45
                .Top       = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- BINDEVENTs para validacao de contas contabeis (LostFocus)
        BINDEVENT(loc_oPg2.txt_4c_ContFrt, "KeyPress", THIS, "ContFrtLostFocus")
        BINDEVENT(loc_oPg2.txt_4c_ContSeg, "KeyPress", THIS, "ContSegLostFocus")
        BINDEVENT(loc_oPg2.txt_4c_ContDa,  "KeyPress", THIS, "ContDaLostFocus")
    ENDPROC


    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), ;
                        desc2s C(60), operacaos C(1), situas N(1,0))
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 3

                    *-- Configurar colunas ANTES de definir RecordSource (evita reset por auto-bind)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.situas"

                    loc_oGrid.Column1.Width = 80
                    loc_oGrid.Column2.Width = 400

                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = ""

                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    *-- situas=1 Ativo (preto), situas!=1 Inativo (vermelho)
                    loc_oGrid.SetAll("DynamicForeColor", ;
                        "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(255,0,0))", "Column")

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir novo registro (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar registro selecionado (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar registro.", "Erro")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar registro selecionado (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar CFOP para altera" + CHR(231) + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir registro selecionado (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirmado
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF
        loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do CFOP " + ;
            loc_cCodigo + "?", "Confirmar Exclus" + CHR(227) + CHR(227) + "o")
        IF loc_lConfirmado
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("CFOP exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ELSE
                    MsgErro("Erro ao excluir CFOP.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao carregar CFOP para exclus" + CHR(227) + "o.", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Posiciona na lista pelo codigo/descricao (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfo", "codigos", "", ;
                "Buscar CFOP")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
                    SELECT cursor_4c_BuscaCfo
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCfo.codigos)
                    IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaCfo")
            USE IN cursor_4c_BuscaCfo
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExpXMLClick - Exporta XML do CFOP selecionado (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnExpXMLClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um CFOP na lista.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um CFOP na lista.", "")
            RETURN
        ENDIF
        TRY
            DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
            THIS.CarregarLista()
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao exportar XML:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImpXMLClick - Importa XML de CFOP (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnImpXMLClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF
        TRY
            DO FORM SigOpXml WITH THIS, "", "I", "CFOP", 10
            THIS.CarregarLista()
            IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodigo)
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao importar XML:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos da Page2 para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oPage1, loc_oPage2
        TRY
            loc_oBO    = THIS.this_oBusinessObject
            loc_oPage1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            *-- Identificacao
            loc_oBO.this_cCodigos    = ALLTRIM(loc_oPage1.txt_4c_Codigo.Value)
            loc_oBO.this_cDescricaos = ALLTRIM(loc_oPage1.txt_4c_Descricao.Value)
            loc_oBO.this_cDesc2s     = ALLTRIM(loc_oPage1.txt_4c_Desc2s.Value)
            loc_oBO.this_cOperacaos  = ALLTRIM(loc_oPage1.cbo_4c_CmbOperacao.Value)
            loc_oBO.this_nTipos      = ALLTRIM(loc_oPage1.cbo_4c_Cmbtipo.Value)
            loc_oBO.this_nNdigitos   = loc_oPage1.spn_4c_Ndigito.Value

            *-- Situacao (Ativo=Button1?Value=1?situas=0; Inativo=Button2?Value=2?situas=1)
            loc_oBO.this_nSituas = IIF(loc_oPage1.obj_4c_Opc_situacao.Value = 1, 0, 1)

            *-- ICMS
            loc_oBO.this_cIcms       = ALLTRIM(loc_oPage1.cbo_4c_CmbIcms.Value)
            loc_oBO.this_cSittribs   = ALLTRIM(loc_oPage1.txt_4c_Sittricm.Value)
            loc_oBO.this_nAliqivcs   = loc_oPage1.txt_4c_AliqIVCs.Value
            loc_oBO.this_nInclicms   = ALLTRIM(loc_oPage1.cbo_4c_Combo3.Value)
            loc_oBO.this_nIcmsdscs   = ALLTRIM(loc_oPage1.cbo_4c_Combo10.Value)
            loc_oBO.this_nIcmsincs   = ALLTRIM(loc_oPage1.cbo_4c_Combo6.Value)
            loc_oBO.this_nIncicmnfs  = IIF(loc_oPage1.chk_4c_Fwcheckbox1.Value, 1, 0)
            loc_oBO.this_cCgergia1s  = ALLTRIM(loc_oPage1.txt_4c_Gergia1.Value)
            loc_oBO.this_nFrticms    = IIF(loc_oPage1.chk_4c_ObjFreteICM.Value, 1, 0)
            loc_oBO.this_nSegicms    = IIF(loc_oPage1.chk_4c_ObjSegIcm.Value, 1, 0)
            loc_oBO.this_nDesicms    = IIF(loc_oPage1.chk_4c_ObjDespIcm.Value, 1, 0)

            *-- Substituicao Tributaria ICMS
            loc_oBO.this_cSubtribs   = ALLTRIM(loc_oPage1.cbo_4c_CmbSTRIB.Value)
            loc_oBO.this_nPbcsts     = loc_oPage1.txt_4c_Bcst.Value
            loc_oBO.this_cCfosts     = ALLTRIM(loc_oPage1.txt_4c_CfoST.Value)
            loc_oBO.this_cCfost60s   = ALLTRIM(loc_oPage1.txt_4c_CfoST60.Value)
            loc_oBO.this_cCoddests   = ALLTRIM(loc_oPage1.txt_4c_Cfdest.Value)
            loc_oBO.this_nTransps    = ALLTRIM(loc_oPage1.cbo_4c_Combo5.Value)

            *-- IPI
            loc_oBO.this_cIpis       = ALLTRIM(loc_oPage1.cbo_4c_CmbIpi.Value)
            loc_oBO.this_cIpiimpors  = ALLTRIM(loc_oPage1.cbo_4c_CmbIpiI.Value)
            loc_oBO.this_nInclipis   = ALLTRIM(loc_oPage1.cbo_4c_Combo4.Value)
            loc_oBO.this_nPbcipis    = loc_oPage1.txt_4c_BcIPI.Value
            loc_oBO.this_cBcipis     = ALLTRIM(loc_oPage1.cbo_4c_CmbBIPI.Value)
            loc_oBO.this_nAliqipis   = loc_oPage1.txt_4c_Aliqs.Value
            loc_oBO.this_cAcresipis  = ALLTRIM(loc_oPage1.cbo_4c_Combo2.Value)
            loc_oBO.this_cIpiom2s    = ALLTRIM(loc_oPage1.cbo_4c_Combo8.Value)
            loc_oBO.this_nFrtipis    = IIF(loc_oPage1.chk_4c_ObjFreteIPI.Value, 1, 0)
            loc_oBO.this_nSegipis    = IIF(loc_oPage1.chk_4c_ObjSegIPI.Value, 1, 0)
            loc_oBO.this_nDesipis    = IIF(loc_oPage1.chk_4c_ObjDespIPI.Value, 1, 0)
            loc_oBO.this_nIpincreds  = ALLTRIM(loc_oPage1.cbo_4c_Combo1.Value)
            loc_oBO.this_nPontedescs = ALLTRIM(loc_oPage1.cbo_4c_Combo7.Value)
            loc_oBO.this_cIpicst     = ALLTRIM(loc_oPage1.txt_4c_IPICST.Value)
            loc_oBO.this_cIpienq     = ALLTRIM(loc_oPage1.txt_4c_Enqipi.Value)
            loc_oBO.this_cUnitimps   = ALLTRIM(loc_oPage1.cbo_4c_Combo9.Value)

            *-- PIS / COFINS / ISSQN / II
            loc_oBO.this_cPiscst     = ALLTRIM(loc_oPage1.txt_4c_PISCST.Value)
            loc_oBO.this_cCofcst     = ALLTRIM(loc_oPage1.txt_4c_COFCST.Value)
            loc_oBO.this_cIssqnl     = ALLTRIM(loc_oPage1.txt_4c_ISSQNL.Value)
            loc_oBO.this_nAliqpis    = loc_oPage1.txt_4c_AliqPIS.Value
            loc_oBO.this_nAliqcofins = loc_oPage1.txt_4c_AliqCofins.Value
            loc_oBO.this_nAliqissqn  = loc_oPage1.txt_4c_AliqISSQN.Value
            loc_oBO.this_nAliqii     = loc_oPage1.txt_4c_AliqII.Value
            *-- ctissqn: OptionGroup 5 botoes (0-4), Value=1 ? ctissqn=0
            loc_oBO.this_nCtissqn    = loc_oPage1.obj_4c_Fwoption1.Value - 1
            *-- rettribs: Sim=Button1?Value=1?1, Nao=Button2?Value=2?0
            loc_oBO.this_nRettribs   = IIF(loc_oPage1.obj_4c_Fwoption2.Value = 1, 1, 0)

            *-- Contribuinte
            loc_oBO.this_cContribs   = ALLTRIM(loc_oPage1.cbo_4c_CmbContribuinte.Value)

            *-- Contabilidade - contas DB/CR (Page2)
            loc_oBO.this_nPontedescs = loc_oPage2.cbo_4c_CmbPonted.ListIndex
            loc_oBO.this_cContconts  = LEFT(UPPER(ALLTRIM(loc_oPage2.cbo_4c_CmbFixa.Value)), 1)
            loc_oBO.this_cContvcds   = ALLTRIM(loc_oPage2.txt_4c_Vrcds.Value)
            loc_oBO.this_cContvccs   = ALLTRIM(loc_oPage2.txt_4c_Vrccs.Value)
            loc_oBO.this_cContipds   = ALLTRIM(loc_oPage2.txt_4c_Ipids.Value)
            loc_oBO.this_cContipcs   = ALLTRIM(loc_oPage2.txt_4c_Ipics.Value)
            loc_oBO.this_cConticds   = ALLTRIM(loc_oPage2.txt_4c_Icmds.Value)
            loc_oBO.this_cConticcs   = ALLTRIM(loc_oPage2.txt_4c_Icmcs.Value)
            loc_oBO.this_cContfrt    = ALLTRIM(loc_oPage2.txt_4c_ContFrt.Value)
            loc_oBO.this_cContseg    = ALLTRIM(loc_oPage2.txt_4c_ContSeg.Value)
            loc_oBO.this_cContda     = ALLTRIM(loc_oPage2.txt_4c_ContDa.Value)

            *-- Contabilidade - opcoes (Page2)
            *-- agrupas/zeradas/utilvars: Sim=Value=1?1, Nao=Value=2?0
            loc_oBO.this_nAgrupas    = IIF(loc_oPage2.obj_4c_OptAgrupas.Value = 1, 1, 0)
            loc_oBO.this_nZeradas    = IIF(loc_oPage2.obj_4c_OptZeradas.Value = 1, 1, 0)
            loc_oBO.this_nUtilvars   = IIF(loc_oPage2.obj_4c_Optutilvars.Value = 1, 1, 0)
            *-- dtintfis: 2 botoes, Value=1=Data Integracao, Value=2=Data N.F.
            loc_oBO.this_nDtintfis   = loc_oPage2.obj_4c_Fwoption1.Value
            *-- intvlrcont/ricms/ripi/indmov/indpagto: Sim=1/Nao=2
            loc_oBO.this_nIntvlrcont = IIF(loc_oPage2.obj_4c_Fwoption2.Value = 1, 1, 0)
            loc_oBO.this_nIntvlricms = IIF(loc_oPage2.obj_4c_Fwoption3.Value = 1, 1, 0)
            loc_oBO.this_nIntvlripi  = IIF(loc_oPage2.obj_4c_Fwoption4.Value = 1, 1, 0)
            loc_oBO.this_nIndmov     = IIF(loc_oPage2.obj_4c_Fwoption5.Value = 1, 1, 0)
            loc_oBO.this_nIndpagto   = IIF(loc_oPage2.obj_4c_Fwoption6.Value = 1, 1, 0)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPage1, loc_oPage2
        TRY
            loc_oBO    = THIS.this_oBusinessObject
            loc_oPage1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            *-- Identificacao
            loc_oPage1.txt_4c_Codigo.Value       = loc_oBO.this_cCodigos
            loc_oPage1.txt_4c_Descricao.Value    = loc_oBO.this_cDescricaos
            loc_oPage1.txt_4c_Desc2s.Value       = loc_oBO.this_cDesc2s
            loc_oPage1.cbo_4c_CmbOperacao.Value  = loc_oBO.this_cOperacaos
            loc_oPage1.cbo_4c_Cmbtipo.Value      = LTRIM(STR(loc_oBO.this_nTipos, 1))
            loc_oPage1.spn_4c_Ndigito.Value      = loc_oBO.this_nNdigitos

            *-- Situacao (situas=0?Ativo=Button1?Value=1; situas=1?Inativo=Button2?Value=2)
            loc_oPage1.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 0, 1, 2)

            *-- ICMS
            loc_oPage1.cbo_4c_CmbIcms.Value      = loc_oBO.this_cIcms
            loc_oPage1.txt_4c_Sittricm.Value     = loc_oBO.this_cSittribs
            loc_oPage1.txt_4c_AliqIVCs.Value     = loc_oBO.this_nAliqivcs
            loc_oPage1.cbo_4c_Combo3.Value       = LTRIM(STR(loc_oBO.this_nInclicms, 1))
            loc_oPage1.cbo_4c_Combo10.Value      = LTRIM(STR(loc_oBO.this_nIcmsdscs, 1))
            loc_oPage1.cbo_4c_Combo6.Value       = LTRIM(STR(loc_oBO.this_nIcmsincs, 1))
            loc_oPage1.chk_4c_Fwcheckbox1.Value  = IIF(loc_oBO.this_nIncicmnfs = 1, 1, 0)
            loc_oPage1.txt_4c_Gergia1.Value      = loc_oBO.this_cCgergia1s
            loc_oPage1.chk_4c_ObjFreteICM.Value  = IIF(loc_oBO.this_nFrticms = 1, 1, 0)
            loc_oPage1.chk_4c_ObjSegIcm.Value    = IIF(loc_oBO.this_nSegicms = 1, 1, 0)
            loc_oPage1.chk_4c_ObjDespIcm.Value   = IIF(loc_oBO.this_nDesicms = 1, 1, 0)

            *-- Substituicao Tributaria ICMS
            loc_oPage1.cbo_4c_CmbSTRIB.Value     = loc_oBO.this_cSubtribs
            loc_oPage1.txt_4c_Bcst.Value         = loc_oBO.this_nPbcsts
            loc_oPage1.txt_4c_CfoST.Value        = loc_oBO.this_cCfosts
            loc_oPage1.txt_4c_CfoST60.Value      = loc_oBO.this_cCfost60s
            loc_oPage1.txt_4c_Cfdest.Value       = loc_oBO.this_cCoddests
            loc_oPage1.cbo_4c_Combo5.Value       = LTRIM(STR(loc_oBO.this_nTransps, 1))

            *-- IPI
            loc_oPage1.cbo_4c_CmbIpi.Value       = loc_oBO.this_cIpis
            loc_oPage1.cbo_4c_CmbIpiI.Value      = loc_oBO.this_cIpiimpors
            loc_oPage1.cbo_4c_Combo4.Value       = LTRIM(STR(loc_oBO.this_nInclipis, 1))
            loc_oPage1.txt_4c_BcIPI.Value        = loc_oBO.this_nPbcipis
            loc_oPage1.cbo_4c_CmbBIPI.Value      = loc_oBO.this_cBcipis
            loc_oPage1.txt_4c_Aliqs.Value        = loc_oBO.this_nAliqipis
            loc_oPage1.cbo_4c_Combo2.Value       = loc_oBO.this_cAcresipis
            loc_oPage1.cbo_4c_Combo8.Value       = loc_oBO.this_cIpiom2s
            loc_oPage1.chk_4c_ObjFreteIPI.Value  = IIF(loc_oBO.this_nFrtipis = 1, 1, 0)
            loc_oPage1.chk_4c_ObjSegIPI.Value    = IIF(loc_oBO.this_nSegipis = 1, 1, 0)
            loc_oPage1.chk_4c_ObjDespIPI.Value   = IIF(loc_oBO.this_nDesipis = 1, 1, 0)
            loc_oPage1.cbo_4c_Combo1.Value       = LTRIM(STR(loc_oBO.this_nIpincreds, 1))
            loc_oPage1.cbo_4c_Combo7.Value       = LTRIM(STR(loc_oBO.this_nPontedescs, 1))
            loc_oPage1.txt_4c_IPICST.Value       = loc_oBO.this_cIpicst
            loc_oPage1.txt_4c_Enqipi.Value       = loc_oBO.this_cIpienq
            loc_oPage1.cbo_4c_Combo9.Value       = loc_oBO.this_cUnitimps

            *-- PIS / COFINS / ISSQN / II
            loc_oPage1.txt_4c_PISCST.Value       = loc_oBO.this_cPiscst
            loc_oPage1.txt_4c_COFCST.Value       = loc_oBO.this_cCofcst
            loc_oPage1.txt_4c_ISSQNL.Value       = loc_oBO.this_cIssqnl
            loc_oPage1.txt_4c_AliqPIS.Value      = loc_oBO.this_nAliqpis
            loc_oPage1.txt_4c_AliqCofins.Value   = loc_oBO.this_nAliqcofins
            loc_oPage1.txt_4c_AliqISSQN.Value    = loc_oBO.this_nAliqissqn
            loc_oPage1.txt_4c_AliqII.Value       = loc_oBO.this_nAliqii
            *-- ctissqn: OptionGroup Value = ctissqn + 1
            loc_oPage1.obj_4c_Fwoption1.Value    = loc_oBO.this_nCtissqn + 1
            *-- rettribs: Sim=1?Value=1, Nao=0?Value=2
            loc_oPage1.obj_4c_Fwoption2.Value    = IIF(loc_oBO.this_nRettribs = 1, 1, 2)

            *-- Contribuinte
            loc_oPage1.cbo_4c_CmbContribuinte.Value = loc_oBO.this_cContribs

            *-- Contabilidade - contas DB/CR (Page2)
            loc_oPage2.cbo_4c_CmbPonted.ListIndex   = IIF(loc_oBO.this_nPontedescs >= 1 AND loc_oBO.this_nPontedescs <= 3, loc_oBO.this_nPontedescs, 1)
            loc_oPage2.cbo_4c_CmbFixa.ListIndex  = MAX(1, AT(loc_oBO.this_cContconts, "SNC"))
            loc_oPage2.txt_4c_Vrcds.Value        = loc_oBO.this_cContvcds
            loc_oPage2.txt_4c_Vrccs.Value        = loc_oBO.this_cContvccs
            loc_oPage2.txt_4c_Ipids.Value        = loc_oBO.this_cContipds
            loc_oPage2.txt_4c_Ipics.Value        = loc_oBO.this_cContipcs
            loc_oPage2.txt_4c_Icmds.Value        = loc_oBO.this_cConticds
            loc_oPage2.txt_4c_Icmcs.Value        = loc_oBO.this_cConticcs
            loc_oPage2.txt_4c_ContFrt.Value      = loc_oBO.this_cContfrt
            loc_oPage2.txt_4c_ContSeg.Value      = loc_oBO.this_cContseg
            loc_oPage2.txt_4c_ContDa.Value       = loc_oBO.this_cContda

            *-- Contabilidade - opcoes (Page2)
            *-- agrupas/zeradas/utilvars: 1?Value=1 (Sim), 0?Value=2 (Nao)
            loc_oPage2.obj_4c_OptAgrupas.Value   = IIF(loc_oBO.this_nAgrupas = 1, 1, 2)
            loc_oPage2.obj_4c_OptZeradas.Value   = IIF(loc_oBO.this_nZeradas = 1, 1, 2)
            loc_oPage2.obj_4c_Optutilvars.Value  = IIF(loc_oBO.this_nUtilvars = 1, 1, 2)
            *-- dtintfis: 1=Data Integracao, 2=Data N.F.
            loc_oPage2.obj_4c_Fwoption1.Value    = IIF(loc_oBO.this_nDtintfis = 2, 2, 1)
            *-- intvlrcont/ricms/ripi/indmov/indpagto: 1?Value=1, 0?Value=2
            loc_oPage2.obj_4c_Fwoption2.Value    = IIF(loc_oBO.this_nIntvlrcont = 1, 1, 2)
            loc_oPage2.obj_4c_Fwoption3.Value    = IIF(loc_oBO.this_nIntvlricms = 1, 1, 2)
            loc_oPage2.obj_4c_Fwoption4.Value    = IIF(loc_oBO.this_nIntvlripi = 1, 1, 2)
            loc_oPage2.obj_4c_Fwoption5.Value    = IIF(loc_oBO.this_nIndmov = 1, 1, 2)
            loc_oPage2.obj_4c_Fwoption6.Value    = IIF(loc_oBO.this_nIndpagto = 1, 1, 2)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salvar registro (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lProsseguir, loc_cCodigo, loc_cSQL, loc_nRet
        loc_lProsseguir = .T.

        *-- Validacao: codigo obrigatorio
        loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.Value)
        IF EMPTY(STRTRAN(loc_cCodigo, ".", ""))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "")
            THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.SetFocus()
            loc_lProsseguir = .F.
        ENDIF

        *-- Validacao: codigo duplicado (apenas no modo INCLUIR)
        IF loc_lProsseguir AND THIS.this_cModoAtual = "INCLUIR"
            TRY
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCfo WHERE codigos = " + ;
                    EscaparSQL(loc_cCodigo)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCfo")
                IF loc_nRet >= 0 AND NVL(cursor_4c_DupCfo.nExiste, 0) > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "")
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.SetFocus()
                    loc_lProsseguir = .F.
                ENDIF
                IF USED("cursor_4c_DupCfo")
                    USE IN cursor_4c_DupCfo
                ENDIF
            CATCH TO loc_oErro
                IF USED("cursor_4c_DupCfo")
                    USE IN cursor_4c_DupCfo
                ENDIF
                MsgErro(loc_oErro.Message, "Erro ao verificar duplicidade")
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        IF loc_lProsseguir
            THIS.FormParaBO()
            TRY
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso!", "Sucesso")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em BtnSalvarClick")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar edicao e voltar para lista (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagDados, loc_nI
        TRY
            loc_oPagDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados
            FOR loc_nI = 1 TO loc_oPagDados.PageCount
                THIS.LimparControles(loc_oPagDados.Pages(loc_nI))
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LimparControles(par_oContainer)
        LOCAL loc_nI, loc_oCtrl
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oCtrl) = "O" AND PEMSTATUS(loc_oCtrl, "Value", 5)
                DO CASE
                CASE VARTYPE(loc_oCtrl.Value) = "C"
                    loc_oCtrl.Value = ""
                CASE VARTYPE(loc_oCtrl.Value) = "N"
                    loc_oCtrl.Value = 0
                CASE VARTYPE(loc_oCtrl.Value) = "L"
                    loc_oCtrl.Value = .F.
                CASE VARTYPE(loc_oCtrl.Value) = "D"
                    loc_oCtrl.Value = {}
                ENDCASE
            ENDIF
            IF VARTYPE(loc_oCtrl) = "O" AND PEMSTATUS(loc_oCtrl, "ControlCount", 5)
                IF loc_oCtrl.ControlCount > 0
                    THIS.LimparControles(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos da Page2 por modo
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagDados, loc_nI
        TRY
            loc_oPagDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados
            FOR loc_nI = 1 TO loc_oPagDados.PageCount
                THIS.HabilitarControles(loc_oPagDados.Pages(loc_nI), par_lHabilitar)
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE HabilitarControles(par_oContainer, par_lHabilitar)
        LOCAL loc_nI, loc_oCtrl, loc_cBase
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oCtrl) = "O"
                loc_cBase = UPPER(loc_oCtrl.BaseClass)
                IF INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", ;
                        "SPINNER", "OPTIONGROUP")
                    IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
                        loc_oCtrl.Enabled = par_lHabilitar
                    ENDIF
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
                    IF loc_oCtrl.ControlCount > 0
                        THIS.HabilitarControles(loc_oCtrl, par_lHabilitar)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
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

    *==========================================================================
    * CfoST60LookupKeyPress - F4/F5 abre lookup para txt_4c_CfoST60 (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE CfoST60LookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupCfoST60()
        ENDIF
    ENDPROC

    *==========================================================================
    * CfoST60LookupDblClick - DblClick abre lookup para txt_4c_CfoST60 (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE CfoST60LookupDblClick()
        THIS.AbrirLookupCfoST60()
    ENDPROC

    *==========================================================================
    * AbrirLookupCfoST60 - Lookup SigCdCfo para cfost60s (CFOP ST Tributada)
    *==========================================================================
    PROCEDURE AbrirLookupCfoST60()
        LOCAL loc_oLookup, loc_oPagDados1
        loc_oPagDados1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfoST60", "codigos", ;
                ALLTRIM(loc_oPagDados1.txt_4c_CfoST60.Value), "CFOP - ST Trib.")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
                    SELECT cursor_4c_BuscaCfoST60
                    loc_oPagDados1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.codigos)
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Lookup CfoST60")
        ENDTRY
        IF USED("cursor_4c_BuscaCfoST60")
            USE IN cursor_4c_BuscaCfoST60
        ENDIF
    ENDPROC

    *==========================================================================
    * CfoSTLookupKeyPress - F4/F5 abre lookup para txt_4c_CfoST (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE CfoSTLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupCfoST()
        ENDIF
    ENDPROC

    *==========================================================================
    * CfoSTLookupDblClick - DblClick abre lookup para txt_4c_CfoST (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE CfoSTLookupDblClick()
        THIS.AbrirLookupCfoST()
    ENDPROC

    *==========================================================================
    * AbrirLookupCfoST - Lookup SigCdCfo para cfosts (CFOP Substitui" + CHR(231) + CHR(227) + "o Trib.)
    *==========================================================================
    PROCEDURE AbrirLookupCfoST()
        LOCAL loc_oLookup, loc_oPagDados1
        loc_oPagDados1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfoST", "codigos", ;
                ALLTRIM(loc_oPagDados1.txt_4c_CfoST.Value), ;
                "CFOP - Substitui" + CHR(231) + CHR(227) + "o Trib.")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
                    SELECT cursor_4c_BuscaCfoST
                    loc_oPagDados1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.codigos)
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Lookup CfoST")
        ENDTRY
        IF USED("cursor_4c_BuscaCfoST")
            USE IN cursor_4c_BuscaCfoST
        ENDIF
    ENDPROC

    *==========================================================================
    * CfdestLookupKeyPress - F4/F5 abre lookup para txt_4c_Cfdest (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE CfdestLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupCfdest()
        ENDIF
    ENDPROC

    *==========================================================================
    * CfdestLookupDblClick - DblClick abre lookup para txt_4c_Cfdest (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE CfdestLookupDblClick()
        THIS.AbrirLookupCfdest()
    ENDPROC

    *==========================================================================
    * AbrirLookupCfdest - Lookup SigCdCfo para coddests (CFOP Destino)
    *==========================================================================
    PROCEDURE AbrirLookupCfdest()
        LOCAL loc_oLookup, loc_oPagDados1
        loc_oPagDados1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfdest", "codigos", ;
                ALLTRIM(loc_oPagDados1.txt_4c_Cfdest.Value), "CFOP - Destino")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfdest")
                    SELECT cursor_4c_BuscaCfdest
                    loc_oPagDados1.txt_4c_Cfdest.Value = ALLTRIM(cursor_4c_BuscaCfdest.codigos)
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Lookup Cfdest")
        ENDTRY
        IF USED("cursor_4c_BuscaCfdest")
            USE IN cursor_4c_BuscaCfdest
        ENDIF
    ENDPROC

    *==========================================================================
    * SittricmLookupKeyPress - F4/F5 abre lookup para txt_4c_Sittricm (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE SittricmLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupSittricm()
        ENDIF
    ENDPROC

    *==========================================================================
    * SittricmLookupDblClick - DblClick abre lookup para txt_4c_Sittricm (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE SittricmLookupDblClick()
        THIS.AbrirLookupSittricm()
    ENDPROC

    *==========================================================================
    * AbrirLookupSittricm - Lookup SigCdIcm para sittribs (Sit. Tributaria ICMS)
    *==========================================================================
    PROCEDURE AbrirLookupSittricm()
        LOCAL loc_oLookup, loc_oPagDados1
        loc_oPagDados1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIcm", "cursor_4c_BuscaSittricm", "Codigos", ;
                ALLTRIM(loc_oPagDados1.txt_4c_Sittricm.Value), ;
                "Situa" + CHR(231) + CHR(227) + "o Trib. ICMS")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaSittricm")
                    SELECT cursor_4c_BuscaSittricm
                    loc_oPagDados1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Lookup Sittricm")
        ENDTRY
        IF USED("cursor_4c_BuscaSittricm")
            USE IN cursor_4c_BuscaSittricm
        ENDIF
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do Grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botao Salvar conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCntSalva, loc_lEditavel
        TRY
            loc_oCntSalva  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
            loc_lEditavel  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF VARTYPE(loc_oCntSalva) = "O"
                loc_oCntSalva.cmd_4c_Salvar.Enabled = loc_lEditavel
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ContFrtLostFocus - Valida conta contabil de Frete ao sair do campo (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE ContFrtLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_cSQL, loc_nRet, loc_oPg2
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
        loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContFrt.Value)
        IF !EMPTY(loc_cConta)
            TRY
                loc_cSQL = "SELECT TOP 1 codigos FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContFrtVal")
                IF loc_nRet < 0 OR !USED("cursor_4c_ContFrtVal") OR EOF("cursor_4c_ContFrtVal")
                    MsgAviso("Conta n" + CHR(227) + "o cadastrada.", "")
                    loc_oPg2.txt_4c_ContFrt.Value = ""
                ENDIF
                IF USED("cursor_4c_ContFrtVal")
                    USE IN cursor_4c_ContFrtVal
                ENDIF
            CATCH TO loc_oErro
                IF USED("cursor_4c_ContFrtVal")
                    USE IN cursor_4c_ContFrtVal
                ENDIF
                MsgErro(loc_oErro.Message, "Erro ao validar Conta Frete")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ContSegLostFocus - Valida conta contabil de Seguro ao sair do campo (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE ContSegLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_cSQL, loc_nRet, loc_oPg2
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
        loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContSeg.Value)
        IF !EMPTY(loc_cConta)
            TRY
                loc_cSQL = "SELECT TOP 1 codigos FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContSegVal")
                IF loc_nRet < 0 OR !USED("cursor_4c_ContSegVal") OR EOF("cursor_4c_ContSegVal")
                    MsgAviso("Conta n" + CHR(227) + "o cadastrada.", "")
                    loc_oPg2.txt_4c_ContSeg.Value = ""
                ENDIF
                IF USED("cursor_4c_ContSegVal")
                    USE IN cursor_4c_ContSegVal
                ENDIF
            CATCH TO loc_oErro
                IF USED("cursor_4c_ContSegVal")
                    USE IN cursor_4c_ContSegVal
                ENDIF
                MsgErro(loc_oErro.Message, "Erro ao validar Conta Seguro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ContDaLostFocus - Valida conta contabil de Despesas ao sair do campo (PUBLIC BINDEVENT)
    *==========================================================================
    PROCEDURE ContDaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_cSQL, loc_nRet, loc_oPg2
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
        loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContDa.Value)
        IF !EMPTY(loc_cConta)
            TRY
                loc_cSQL = "SELECT TOP 1 codigos FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContDaVal")
                IF loc_nRet < 0 OR !USED("cursor_4c_ContDaVal") OR EOF("cursor_4c_ContDaVal")
                    MsgAviso("Conta n" + CHR(227) + "o cadastrada.", "")
                    loc_oPg2.txt_4c_ContDa.Value = ""
                ENDIF
                IF USED("cursor_4c_ContDaVal")
                    USE IN cursor_4c_ContDaVal
                ENDIF
            CATCH TO loc_oErro
                IF USED("cursor_4c_ContDaVal")
                    USE IN cursor_4c_ContDaVal
                ENDIF
                MsgErro(loc_oErro.Message, "Erro ao validar Conta Despesas")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE