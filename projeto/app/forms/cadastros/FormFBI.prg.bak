*====================================================================
* FormFBI.prg
*
* Formulario de Cadastro de Fabricacao (SigFiMpf)
* Herda de: FormBase
*
* Arquitetura em camadas:
*   FormFBI (UI) -> FBIBO (BO) -> DataAccess (SQL Server)
*
* Legado: SIGCDFBI (frmcadastro)
* Tabela: SigFiMpf
*====================================================================

DEFINE CLASS FormFBI AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Fabrica" + CHR(231) + CHR(227) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do form
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *====================================================================
    * Init - Inicializa o formulario
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar o Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("FBIBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar FBIBO", "FormFBI.InicializarForm")
                loc_lSucesso = .F.
            ENDIF

            *-- Configurar estrutura do PageFrame
            THIS.ConfigurarPageFrame()

            *-- Configurar Page1 (Lista com Grid e Botoes CRUD)
            THIS.ConfigurarPaginaLista()

            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Configurar Page2 (Dados com Campos e Botoes Salvar/Cancelar)
            THIS.ConfigurarPaginaDados()

            *-- Carregar lista inicial (pula se estiver validando UI)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarLista()
            ENDIF

            *-- Exibir Page1 (Lista) como pagina inicial
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfigurarPageFrame - Cria o PageFrame com 2 paginas
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Adicionar PageFrame principal
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .Visible    = .T.

            *-- Cor de fundo das paginas
            .Page1.BackColor = RGB(100, 100, 100)
            .Page2.BackColor = RGB(100, 100, 100)

            *-- Imagem de fundo
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page1.Caption = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarPaginaLista - Configura Page1 com Grid e Botoes CRUD
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra no legado)
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

        *-- Label sombra (efeito visual)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .Caption   = "Cadastro de Fabrica" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label titulo principal
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .Caption   = "Cadastro de Fabrica" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_Op no legado) - LADO DIREITO
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
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

        *-- Container Encerrar (canonico: Left=917, Width=90)
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                  = 121
            .Left                 = 12
            .Width                = 890
            .Height               = 440
            .FontName             = "Verdana"
            .FontSize             = 8
            .ForeColor            = RGB(90, 90, 90)
            .BackColor            = RGB(255, 255, 255)
            .GridLineColor        = RGB(238, 238, 238)
            .HighlightBackColor   = RGB(255, 255, 255)
            .HighlightForeColor   = RGB(15, 41, 104)
            .HighlightStyle       = 2
            .DeleteMark           = .F.
            .RecordMark           = .F.
            .RowHeight            = 16
            .ScrollBars           = 2
            .GridLines            = 3
            .ColumnCount          = 4
            .Visible              = .T.
        ENDWITH

        *-- Configurar colunas do grid apos ColumnCount
        WITH loc_oPagina.grd_4c_Lista
            .Column1.Width              = 160
            .Column1.Header1.Caption    = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
            .Column1.Alignment          = 0

            .Column2.Width              = 80
            .Column2.Header1.Caption    = "Empresa"
            .Column2.Alignment          = 0

            .Column3.Width              = 300
            .Column3.Header1.Caption    = "Fabrica" + CHR(231) + CHR(227) + "o (Criptografado)"
            .Column3.Alignment          = 0

            .Column4.Width              = 120
            .Column4.Header1.Caption    = "Caixa"
            .Column4.Alignment          = 0
        ENDWITH

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *====================================================================
    * ConfigurarPaginaDados - Configura Page2 com campos e botoes
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Salvar/Cancelar (Grupo_Salva no legado)
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

        *-- Botao Confirmar (Salvar)
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- === COLUNA ESQUERDA - Campos da Page2 (Fase 5: primeiros 50%) ===

        *-- NFAB - No. Fabricacao (chave de negocio, desabilitado no ALTERAR)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 216
            .Left      = 137
            .Width     = 115
            .Height    = 17
            .Caption   = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o - NFAB. :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top       = 213
            .Left      = 256
            .Width     = 157
            .Height    = 23
            .Value     = ""
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- NSEQ - No. do Caixa (obrigatorio 3 digitos)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Top       = 241
            .Left      = 146
            .Width     = 108
            .Height    = 17
            .Caption   = "N" + CHR(186) + " do Caixa - NSEQ. :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ncaixa", "TextBox")
        WITH loc_oPagina.txt_4c_Ncaixa
            .Top       = 238
            .Left      = 256
            .Width     = 31
            .Height    = 21
            .Value     = ""
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Ncaixa, "KeyPress", THIS, "NcaixaLostFocus")

        *-- Contador Reinicio de Operacao
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Top       = 265
            .Left      = 96
            .Width     = 158
            .Height    = 17
            .Caption   = "Contador Reinicio de Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Interv", "TextBox")
        WITH loc_oPagina.txt_4c_Interv
            .Top       = 262
            .Left      = 256
            .Width     = 38
            .Height    = 21
            .Value     = ""
            .MaxLength = 4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Empresa (lookup em SigCdEmp)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Top       = 290
            .Left      = 204
            .Width     = 50
            .Height    = 17
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Emp", "TextBox")
        WITH loc_oPagina.txt_4c_Emp
            .Top       = 286
            .Left      = 256
            .Width     = 38
            .Height    = 21
            .Value     = ""
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Emp, "KeyPress", THIS, "EmpresaLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Emp, "KeyPress", THIS, "EmpresaKeyPress")

        *-- GT Inicial
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Top       = 314
            .Left      = 202
            .Width     = 52
            .Height    = 17
            .Caption   = "GT Inicial :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GTInicial", "TextBox")
        WITH loc_oPagina.txt_4c_GTInicial
            .Top       = 311
            .Left      = 256
            .Width     = 175
            .Height    = 23
            .Value     = ""
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- GT Atual
        loc_oPagina.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oPagina.lbl_4c_Label30
            .Top       = 339
            .Left      = 204
            .Width     = 50
            .Height    = 17
            .Caption   = "GT Atual :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Gtatual", "TextBox")
        WITH loc_oPagina.txt_4c_Gtatual
            .Top       = 336
            .Left      = 256
            .Width     = 175
            .Height    = 23
            .Value     = ""
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Modelo ECF (lookup em SigFiMpM)
        loc_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPagina.lbl_4c_Label16
            .Top       = 365
            .Left      = 211
            .Width     = 43
            .Height    = 17
            .Caption   = "Modelo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Modelo", "TextBox")
        WITH loc_oPagina.txt_4c_Modelo
            .Top       = 361
            .Left      = 256
            .Width     = 220
            .Height    = 23
            .Value     = ""
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ModeloLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ModeloKeyPress")

        *-- Numero do Usuario do ECF
        loc_oPagina.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPagina.lbl_4c_Label17
            .Top       = 390
            .Left      = 114
            .Width     = 140
            .Height    = 17
            .Caption   = "Numero do Usu" + CHR(225) + "rio do ECF :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_NumUsu", "TextBox")
        WITH loc_oPagina.txt_4c_NumUsu
            .Top       = 386
            .Left      = 256
            .Width     = 25
            .Height    = 21
            .Value     = ""
            .MaxLength = 2
            .InputMask = "99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_NumUsu, "GotFocus", THIS, "NumUsuGotFocus")
        BINDEVENT(loc_oPagina.txt_4c_NumUsu, "KeyPress", THIS, "NumUsuLostFocus")

        *-- Tipo do ECF
        loc_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPagina.lbl_4c_Label18
            .Top       = 414
            .Left      = 188
            .Width     = 66
            .Height    = 17
            .Caption   = "Tipo do ECF :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_TipoECF", "TextBox")
        WITH loc_oPagina.txt_4c_TipoECF
            .Top       = 410
            .Left      = 256
            .Width     = 59
            .Height    = 23
            .Value     = ""
            .MaxLength = 7
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Versao do Software Basico
        loc_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPagina.lbl_4c_Label19
            .Top       = 437
            .Left      = 121
            .Width     = 133
            .Height    = 17
            .Caption   = "Vers" + CHR(227) + "o do Sofware B" + CHR(225) + "sico :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_VerSB", "TextBox")
        WITH loc_oPagina.txt_4c_VerSB
            .Top       = 434
            .Left      = 256
            .Width     = 80
            .Height    = 21
            .Value     = ""
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Data do Software Basico
        loc_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPagina.lbl_4c_Label20
            .Top       = 461
            .Left      = 131
            .Width     = 123
            .Height    = 17
            .Caption   = "Data do Sofware B" + CHR(225) + "sico :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DataSB", "TextBox")
        WITH loc_oPagina.txt_4c_DataSB
            .Top       = 458
            .Left      = 256
            .Width     = 80
            .Height    = 21
            .Value     = {}
            .Format    = "D"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Hora do Software Basico
        loc_oPagina.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPagina.lbl_4c_Label21
            .Top       = 485
            .Left      = 131
            .Width     = 123
            .Height    = 17
            .Caption   = "Hora do Sofware B" + CHR(225) + "sico :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_HoraSB", "TextBox")
        WITH loc_oPagina.txt_4c_HoraSB
            .Top       = 482
            .Left      = 256
            .Width     = 64
            .Height    = 21
            .Value     = ""
            .MaxLength = 8
            .InputMask = "99:99:99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Comando de Geracao RFD
        loc_oPagina.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPagina.lbl_4c_Label22
            .Top       = 510
            .Left      = 119
            .Width     = 135
            .Height    = 17
            .Caption   = "Comando de Gera" + CHR(231) + CHR(227) + "o RFD :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CmdRFD", "TextBox")
        WITH loc_oPagina.txt_4c_CmdRFD
            .Top       = 506
            .Left      = 256
            .Width     = 30
            .Height    = 23
            .Value     = ""
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- COO Inicial (Troca Aplicativo)
        loc_oPagina.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPagina.lbl_4c_Label27
            .Top       = 534
            .Left      = 109
            .Width     = 145
            .Height    = 15
            .Caption   = "Coo Inicial (Troca Aplicativo) :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Coos", "TextBox")
        WITH loc_oPagina.txt_4c_Coos
            .Top       = 530
            .Left      = 256
            .Width     = 52
            .Height    = 23
            .Value     = ""
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Coos, "KeyPress", THIS, "CoosLostFocus")

        *-- === COLUNA DIREITA - primeiros campos (Fase 5) ===

        *-- Data do Cadastro do ECF
        loc_oPagina.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oPagina.lbl_4c_Label23
            .Top       = 216
            .Left      = 497
            .Width     = 131
            .Height    = 17
            .Caption   = "Data do Cadastro do ECF :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtCad", "TextBox")
        WITH loc_oPagina.txt_4c_DtCad
            .Top       = 213
            .Left      = 630
            .Width     = 80
            .Height    = 21
            .Value     = {}
            .Format    = "D"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- === COLUNA DIREITA - campos restantes (Fase 6) ===

        *-- Hora do Cadastro do ECF
        loc_oPagina.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPagina.lbl_4c_Label24
            .Top       = 240
            .Left      = 497
            .Width     = 131
            .Height    = 17
            .Caption   = "Hora do Cadastro do ECF :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_HrCad", "TextBox")
        WITH loc_oPagina.txt_4c_HrCad
            .Top       = 237
            .Left      = 630
            .Width     = 64
            .Height    = 21
            .Value     = ""
            .MaxLength = 8
            .InputMask = "99:99:99"
            .Format    = "R"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Reinicio de Operacoes / CRO Inicial
        loc_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPagina.lbl_4c_Label25
            .Top       = 264
            .Left      = 513
            .Width     = 115
            .Height    = 17
            .Caption   = "Reinicio de Opera" + CHR(231) + CHR(245) + "es :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CRO", "TextBox")
        WITH loc_oPagina.txt_4c_CRO
            .Top       = 261
            .Left      = 630
            .Width     = 50
            .Height    = 23
            .Value     = ""
            .MaxLength = 6
            .InputMask = "999999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CRO, "KeyPress", THIS, "CROLostFocus")

        *-- Leitura Mem. Fiscal Automatico
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Top       = 285
            .Left      = 468
            .Width     = 160
            .Height    = 17
            .Caption   = "Leitura Mem. Fiscal Autom" + CHR(225) + "tico :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_LeitMF", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_LeitMF
            .Top       = 285
            .Left      = 630
            .Width     = 18
            .Height    = 17
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Gaveta Acoplada
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Top       = 304
            .Left      = 534
            .Width     = 94
            .Height    = 17
            .Caption   = "Gaveta Acoplada :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_gaveta", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_gaveta
            .Top       = 304
            .Left      = 630
            .Width     = 18
            .Height    = 17
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Impressora de Cheques
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 324
            .Left      = 549
            .Width     = 79
            .Height    = 17
            .Caption   = "Imp. Cheques :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_impche", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_impche
            .Top       = 324
            .Left      = 630
            .Width     = 18
            .Height    = 15
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- MFD (Memoria de Fita Detalhe)
        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Top       = 343
            .Left      = 595
            .Width     = 33
            .Height    = 17
            .Caption   = "MFD :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox2
            .Top       = 343
            .Left      = 630
            .Width     = 18
            .Height    = 15
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Inativa
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Top       = 361
            .Left      = 582
            .Width     = 46
            .Height    = 15
            .Caption   = "Inativa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox1
            .Top       = 361
            .Left      = 630
            .Width     = 18
            .Height    = 15
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Bom Para (uso cheque)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Top       = 382
            .Left      = 571
            .Width     = 57
            .Height    = 17
            .Caption   = "Bom Para :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_Bompara", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_Bompara
            .Top       = 382
            .Left      = 630
            .Width     = 18
            .Height    = 15
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Nominal
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Top       = 403
            .Left      = 579
            .Width     = 49
            .Height    = 17
            .Caption   = "Nominal :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_nominal", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_nominal
            .Top       = 403
            .Left      = 630
            .Width     = 18
            .Height    = 15
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Cruzado
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Top       = 423
            .Left      = 576
            .Width     = 52
            .Height    = 17
            .Caption   = "Cruzado :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_cruzado", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_cruzado
            .Top       = 423
            .Left      = 630
            .Width     = 18
            .Height    = 15
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Pertochek / Check-Pronto
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Top       = 442
            .Left      = 493
            .Width     = 135
            .Height    = 17
            .Caption   = "Pertochek / Check-Pronto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_perto", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_perto
            .Top       = 442
            .Left      = 630
            .Width     = 18
            .Height    = 15
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Autentica (OptionGroup 1=Sim, 2=Nao)
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Top       = 461
            .Left      = 573
            .Width     = 55
            .Height    = 17
            .Caption   = "Autentica :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Optiongroup1", "OptionGroup")
        WITH loc_oPagina.obj_4c_Optiongroup1
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 429
            .Left        = 625
            .Width       = 95
            .Height      = 22
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 3
                .Width     = 44
                .Height    = 17
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 56
                .Top       = 3
                .Width     = 61
                .Height    = 17
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        *-- Imprime Codigo de Barras (OptionGroup 1=Sim, 2=Nao)
        loc_oPagina.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPagina.lbl_4c_Label26
            .Top       = 483
            .Left      = 496
            .Width     = 132
            .Height    = 17
            .Caption   = "Imprime C" + CHR(243) + "digo de Barras :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Optiongroup2", "OptionGroup")
        WITH loc_oPagina.obj_4c_Optiongroup2
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 451
            .Left        = 624
            .Width       = 95
            .Height      = 22
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 3
                .Width     = 44
                .Height    = 17
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 56
                .Top       = 3
                .Width     = 61
                .Height    = 17
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        *-- Codigo Nacional do ECF (ReadOnly - getcodnac.When = .F. no legado)
        loc_oPagina.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPagina.lbl_4c_Label28
            .Top       = 509
            .Left      = 506
            .Width     = 122
            .Height    = 17
            .Caption   = "C" + CHR(243) + "digo Nacional do ECF :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codnac", "TextBox")
        WITH loc_oPagina.txt_4c_Codnac
            .Top       = 505
            .Left      = 630
            .Width     = 52
            .Height    = 23
            .Value     = ""
            .MaxLength = 6
            .InputMask = "999999"
            .ReadOnly  = .T.
            .Enabled   = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Incidencia Desc. ISSQN
        loc_oPagina.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oPagina.lbl_4c_Label29
            .Top       = 534
            .Left      = 507
            .Width     = 121
            .Height    = 17
            .Caption   = "Incid" + CHR(234) + "ncia Desc. ISSQN :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Fwcheckbox3", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox3
            .Top       = 534
            .Left      = 629
            .Width     = 18
            .Height    = 15
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *====================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    *====================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (cImpFabs c(20), emps c(3), cncaixas c(3), cidchaves c(20))
                ENDIF
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 4
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cImpFabs"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cImpFabs"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cncaixas"

                    *-- Redefinir headers apos RecordSource (VFP9 reseta cabecalhos)
                    loc_oGrid.Column1.Header1.Caption = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column2.Header1.Caption = "Empresa"
                    loc_oGrid.Column3.Header1.Caption = "Fabrica" + CHR(231) + CHR(227) + "o (Criptografado)"
                    loc_oGrid.Column4.Header1.Caption = "Caixa"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *====================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *====================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *====================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *====================================================================
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

    *====================================================================
    * Destroy - Libera recursos
    *====================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *====================================================================
    * NcaixaLostFocus - Valida 3 digitos obrigatorios no Nr. Caixa
    * Legado: Get_ncaixa.Click
    *====================================================================
    PROCEDURE NcaixaLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF !INLIST(par_nKeyCode, 9, 13)
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Ncaixa.Value)
        IF !EMPTY(loc_cValor) AND LEN(loc_cValor) < 3
            MsgAviso("Obrigatorio Preenchimento de 3 d" + CHR(237) + "gitos")
            loc_oPg2.txt_4c_Ncaixa.SetFocus()
        ENDIF
    ENDPROC

    *====================================================================
    * EmpresaLostFocus - Lookup de empresa (SigCdEmp) ao sair do campo
    * Legado: Get_Emp.Valid - fwBuscaExt em SigCdEmp
    *====================================================================
    PROCEDURE EmpresaLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF par_nKeyCode > 0 AND par_nKeyCode <> 13
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cEmpresa, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cEmpresa = ALLTRIM(loc_oPg2.txt_4c_Emp.Value)

        IF EMPTY(loc_cEmpresa)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "CEmps", loc_cEmpresa, ;
                "Empresas")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaEmp")
                        loc_oPg2.txt_4c_Emp.Value = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg2.txt_4c_Emp.Value = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.EmpresaLostFocus")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *====================================================================
    * EmpresaKeyPress - Abre lookup de empresa com F4
    *====================================================================
    PROCEDURE EmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.EmpresaLostFocus()
        ENDIF
    ENDPROC

    *====================================================================
    * ModeloLostFocus - Lookup de modelo ECF (SigFiMpM) ao sair do campo
    * Legado: GetModelo.Valid - fwBuscaExt em SigFiMpM (cModelos, cMarcas, cversbs, cidecfs)
    *====================================================================
    PROCEDURE ModeloLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF par_nKeyCode > 0 AND par_nKeyCode <> 13
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cModelo, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cModelo = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)

        IF EMPTY(loc_cModelo)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigFiMpM", "cursor_4c_BuscaModelo", "cModelos", loc_cModelo, ;
                "Modelos")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaModelo")
                        loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(cursor_4c_BuscaModelo.cModelos)
                        loc_oPg2.txt_4c_Codnac.Value = ALLTRIM(cursor_4c_BuscaModelo.cidecfs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cModelos", "", "Modelo")
                    loc_oBusca.mAddColuna("cMarcas",  "", "Marca")
                    loc_oBusca.mAddColuna("cversbs",  "", "Vers" + CHR(227) + "o S.B.")
                    loc_oBusca.mAddColuna("cidecfs",  "", "Cod.Nac.ECF")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaModelo")
                        loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(cursor_4c_BuscaModelo.cModelos)
                        loc_oPg2.txt_4c_Codnac.Value = ALLTRIM(cursor_4c_BuscaModelo.cidecfs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.ModeloLostFocus")
        ENDTRY

        IF USED("cursor_4c_BuscaModelo")
            USE IN cursor_4c_BuscaModelo
        ENDIF
    ENDPROC

    *====================================================================
    * ModeloKeyPress - Abre lookup de modelo com F4 ou F5
    *====================================================================
    PROCEDURE ModeloKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 64
            THIS.ModeloLostFocus()
        ENDIF
    ENDPROC

    *====================================================================
    * NumUsuGotFocus - Valida que Modelo foi preenchido antes de NumUsu
    * Legado: GetNumUsu.GotFocus
    *====================================================================
    PROCEDURE NumUsuGotFocus()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Modelo.Value))
            MsgAviso("Obrigatorio Preenchimento")
            loc_oPg2.txt_4c_Modelo.SetFocus()
        ENDIF
    ENDPROC

    *====================================================================
    * NumUsuLostFocus - Formata numero do usuario com mascara @L 99
    * Legado: GetNumUsu.LostFocus - TRANSFORM(Val(This.Value), '@L 99')
    *====================================================================
    PROCEDURE NumUsuLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF !INLIST(par_nKeyCode, 9, 13)
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = loc_oPg2.txt_4c_NumUsu.Value
        IF !EMPTY(ALLTRIM(loc_cValor))
            loc_oPg2.txt_4c_NumUsu.Value = TRANSFORM(VAL(loc_cValor), "@L 99")
        ENDIF
    ENDPROC

    *====================================================================
    * CoosLostFocus - Formata COO Inicial com mascara @L 999999
    * Legado: GetCoos.LostFocus - TRANSFORM(Val(This.Value), '@L 999999')
    *====================================================================
    PROCEDURE CoosLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF !INLIST(par_nKeyCode, 9, 13)
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = loc_oPg2.txt_4c_Coos.Value
        IF !EMPTY(ALLTRIM(loc_cValor))
            loc_oPg2.txt_4c_Coos.Value = TRANSFORM(VAL(loc_cValor), "@L 999999")
        ENDIF
    ENDPROC

    *====================================================================
    * CROLostFocus - Formata CRO Inicial com mascara @L 999999
    * Legado: GetCroniop.LostFocus - TRANSFORM(Val(This.Value), '@L 999999')
    *====================================================================
    PROCEDURE CROLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF !INLIST(par_nKeyCode, 9, 13)
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = loc_oPg2.txt_4c_CRO.Value
        IF !EMPTY(ALLTRIM(loc_cValor))
            loc_oPg2.txt_4c_CRO.Value = TRANSFORM(VAL(loc_cValor), "@L 999999")
        ENDIF
    ENDPROC

    *====================================================================
    * FormParaBO - Transfere valores dos controles do form para o BO
    *====================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oPg2, loc_oBO
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oBusinessObject

            loc_oBO.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            loc_oBO.this_cNcaixas   = ALLTRIM(loc_oPg2.txt_4c_Ncaixa.Value)
            loc_oBO.this_cInterv    = ALLTRIM(loc_oPg2.txt_4c_Interv.Value)
            loc_oBO.this_cEmpresa   = ALLTRIM(loc_oPg2.txt_4c_Emp.Value)
            loc_oBO.this_cGTInics   = ALLTRIM(loc_oPg2.txt_4c_GTInicial.Value)
            loc_oBO.this_cGTAtuas   = ALLTRIM(loc_oPg2.txt_4c_Gtatual.Value)
            loc_oBO.this_cModelo    = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
            loc_oBO.this_cNumUsuars = ALLTRIM(loc_oPg2.txt_4c_NumUsu.Value)
            loc_oBO.this_cTipoECF   = ALLTRIM(loc_oPg2.txt_4c_TipoECF.Value)
            loc_oBO.this_cVersaoSB  = ALLTRIM(loc_oPg2.txt_4c_VerSB.Value)
            loc_oBO.this_dDataSB    = loc_oPg2.txt_4c_DataSB.Value
            loc_oBO.this_cHoraSB    = ALLTRIM(loc_oPg2.txt_4c_HoraSB.Value)
            loc_oBO.this_cCmdRFD    = ALLTRIM(loc_oPg2.txt_4c_CmdRFD.Value)
            loc_oBO.this_cIfCoos    = ALLTRIM(loc_oPg2.txt_4c_Coos.Value)
            loc_oBO.this_dDtCadECF  = loc_oPg2.txt_4c_DtCad.Value
            loc_oBO.this_cHrCadECF  = ALLTRIM(loc_oPg2.txt_4c_HrCad.Value)
            loc_oBO.this_cCROIniOps = ALLTRIM(loc_oPg2.txt_4c_CRO.Value)
            loc_oBO.this_cCodNac    = ALLTRIM(loc_oPg2.txt_4c_Codnac.Value)
            loc_oBO.this_lLeitMF    = (loc_oPg2.chk_4c_Chk_LeitMF.Value  = 1)
            loc_oBO.this_lGaveta    = (loc_oPg2.chk_4c_Chk_gaveta.Value  = 1)
            loc_oBO.this_lImpCheque = (loc_oPg2.chk_4c_Chk_impche.Value  = 1)
            loc_oBO.this_lMFD       = (loc_oPg2.chk_4c_Fwcheckbox2.Value = 1)
            loc_oBO.this_lInativa   = (loc_oPg2.chk_4c_Fwcheckbox1.Value = 1)
            loc_oBO.this_lBomPara   = (loc_oPg2.chk_4c_Chk_Bompara.Value = 1)
            loc_oBO.this_lNominal   = (loc_oPg2.chk_4c_Chk_nominal.Value = 1)
            loc_oBO.this_lCruzado   = (loc_oPg2.chk_4c_Chk_cruzado.Value = 1)
            loc_oBO.this_lPerto     = (loc_oPg2.chk_4c_Chk_perto.Value   = 1)
            loc_oBO.this_nAutentica = loc_oPg2.obj_4c_Optiongroup1.Value
            loc_oBO.this_nImpBars   = loc_oPg2.obj_4c_Optiongroup2.Value
            loc_oBO.this_lISSQN     = (loc_oPg2.chk_4c_Fwcheckbox3.Value = 1)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BOParaForm - Transfere valores do BO para os controles do form
    *====================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPg2, loc_oBO
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oBusinessObject

            loc_oPg2.txt_4c_Codigo.Value       = loc_oBO.this_cCodigo
            loc_oPg2.txt_4c_Ncaixa.Value       = loc_oBO.this_cNcaixas
            loc_oPg2.txt_4c_Interv.Value       = loc_oBO.this_cInterv
            loc_oPg2.txt_4c_Emp.Value          = loc_oBO.this_cEmpresa
            loc_oPg2.txt_4c_GTInicial.Value    = loc_oBO.this_cGTInics
            loc_oPg2.txt_4c_Gtatual.Value      = loc_oBO.this_cGTAtuas
            loc_oPg2.txt_4c_Modelo.Value       = loc_oBO.this_cModelo
            loc_oPg2.txt_4c_NumUsu.Value       = loc_oBO.this_cNumUsuars
            loc_oPg2.txt_4c_TipoECF.Value      = loc_oBO.this_cTipoECF
            loc_oPg2.txt_4c_VerSB.Value        = loc_oBO.this_cVersaoSB
            loc_oPg2.txt_4c_DataSB.Value       = loc_oBO.this_dDataSB
            loc_oPg2.txt_4c_HoraSB.Value       = loc_oBO.this_cHoraSB
            loc_oPg2.txt_4c_CmdRFD.Value       = loc_oBO.this_cCmdRFD
            loc_oPg2.txt_4c_Coos.Value         = loc_oBO.this_cIfCoos
            loc_oPg2.txt_4c_DtCad.Value        = loc_oBO.this_dDtCadECF
            loc_oPg2.txt_4c_HrCad.Value        = loc_oBO.this_cHrCadECF
            loc_oPg2.txt_4c_CRO.Value          = loc_oBO.this_cCROIniOps
            loc_oPg2.txt_4c_Codnac.Value       = loc_oBO.this_cCodNac
            loc_oPg2.chk_4c_Chk_LeitMF.Value  = IIF(loc_oBO.this_lLeitMF,    1, 0)
            loc_oPg2.chk_4c_Chk_gaveta.Value  = IIF(loc_oBO.this_lGaveta,    1, 0)
            loc_oPg2.chk_4c_Chk_impche.Value  = IIF(loc_oBO.this_lImpCheque, 1, 0)
            loc_oPg2.chk_4c_Fwcheckbox2.Value = IIF(loc_oBO.this_lMFD,       1, 0)
            loc_oPg2.chk_4c_Fwcheckbox1.Value = IIF(loc_oBO.this_lInativa,   1, 0)
            loc_oPg2.chk_4c_Chk_Bompara.Value = IIF(loc_oBO.this_lBomPara,   1, 0)
            loc_oPg2.chk_4c_Chk_nominal.Value = IIF(loc_oBO.this_lNominal,   1, 0)
            loc_oPg2.chk_4c_Chk_cruzado.Value = IIF(loc_oBO.this_lCruzado,   1, 0)
            loc_oPg2.chk_4c_Chk_perto.Value   = IIF(loc_oBO.this_lPerto,     1, 0)
            loc_oPg2.obj_4c_Optiongroup1.Value = loc_oBO.this_nAutentica
            loc_oPg2.obj_4c_Optiongroup2.Value = loc_oBO.this_nImpBars
            loc_oPg2.chk_4c_Fwcheckbox3.Value = IIF(loc_oBO.this_lISSQN,     1, 0)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * par_lHabilitar=.T. -> campos editaveis; .F. -> somente leitura
    *====================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Ncaixa.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_Interv.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_Emp.ReadOnly       = !par_lHabilitar
            loc_oPg2.txt_4c_GTInicial.ReadOnly = !par_lHabilitar
            loc_oPg2.txt_4c_Gtatual.ReadOnly   = !par_lHabilitar
            loc_oPg2.txt_4c_Modelo.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_NumUsu.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_TipoECF.ReadOnly   = !par_lHabilitar
            loc_oPg2.txt_4c_VerSB.ReadOnly     = !par_lHabilitar
            loc_oPg2.txt_4c_DataSB.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_HoraSB.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_CmdRFD.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_Coos.ReadOnly      = !par_lHabilitar
            loc_oPg2.txt_4c_DtCad.ReadOnly     = !par_lHabilitar
            loc_oPg2.txt_4c_HrCad.ReadOnly     = !par_lHabilitar
            loc_oPg2.txt_4c_CRO.ReadOnly       = !par_lHabilitar

            *-- Codigo: editavel apenas em INCLUIR
            loc_oPg2.txt_4c_Codigo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")

            *-- Codnac: sempre somente leitura (populado pelo lookup de modelo)
            loc_oPg2.txt_4c_Codnac.ReadOnly = .T.
            loc_oPg2.txt_4c_Codnac.Enabled  = .F.

            loc_oPg2.chk_4c_Chk_LeitMF.Enabled  = par_lHabilitar
            loc_oPg2.chk_4c_Chk_gaveta.Enabled  = par_lHabilitar
            loc_oPg2.chk_4c_Chk_impche.Enabled  = par_lHabilitar
            loc_oPg2.chk_4c_Fwcheckbox2.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_Chk_Bompara.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_Chk_nominal.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_Chk_cruzado.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_Chk_perto.Enabled   = par_lHabilitar
            loc_oPg2.obj_4c_Optiongroup1.Enabled = par_lHabilitar
            loc_oPg2.obj_4c_Optiongroup2.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_Fwcheckbox3.Enabled = par_lHabilitar

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.HabilitarCampos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * LimparCampos - Reseta todos os campos da Page2 para valores padrao
    *====================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Codigo.Value       = ""
            loc_oPg2.txt_4c_Ncaixa.Value       = ""
            loc_oPg2.txt_4c_Interv.Value       = ""
            loc_oPg2.txt_4c_Emp.Value          = ""
            loc_oPg2.txt_4c_GTInicial.Value    = ""
            loc_oPg2.txt_4c_Gtatual.Value      = ""
            loc_oPg2.txt_4c_Modelo.Value       = ""
            loc_oPg2.txt_4c_NumUsu.Value       = ""
            loc_oPg2.txt_4c_TipoECF.Value      = ""
            loc_oPg2.txt_4c_VerSB.Value        = ""
            loc_oPg2.txt_4c_DataSB.Value       = {}
            loc_oPg2.txt_4c_HoraSB.Value       = ""
            loc_oPg2.txt_4c_CmdRFD.Value       = ""
            loc_oPg2.txt_4c_Coos.Value         = ""
            loc_oPg2.txt_4c_DtCad.Value        = {}
            loc_oPg2.txt_4c_HrCad.Value        = ""
            loc_oPg2.txt_4c_CRO.Value          = ""
            loc_oPg2.txt_4c_Codnac.Value       = ""
            loc_oPg2.chk_4c_Chk_LeitMF.Value  = 0
            loc_oPg2.chk_4c_Chk_gaveta.Value  = 0
            loc_oPg2.chk_4c_Chk_impche.Value  = 0
            loc_oPg2.chk_4c_Fwcheckbox2.Value = 0
            loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
            loc_oPg2.chk_4c_Chk_Bompara.Value = 0
            loc_oPg2.chk_4c_Chk_nominal.Value = 0
            loc_oPg2.chk_4c_Chk_cruzado.Value = 0
            loc_oPg2.chk_4c_Chk_perto.Value   = 0
            loc_oPg2.obj_4c_Optiongroup1.Value = 1
            loc_oPg2.obj_4c_Optiongroup2.Value = 1
            loc_oPg2.chk_4c_Fwcheckbox3.Value = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.LimparCampos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * AjustarBotoesPorModo - Habilita botao Confirmar apenas em INCLUIR/ALTERAR
    *====================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lConfirmarAtivo
        loc_lConfirmarAtivo = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lConfirmarAtivo
    ENDPROC

    *====================================================================
    * BtnIncluirClick - Prepara formulario para inclusao de novo registro
    *====================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.pgf_4c_Paginas.Page2.txt_4c_Emp.Value = go_4c_Sistema.cCodEmpresa
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
    ENDPROC

    *====================================================================
    * BtnVisualizarClick - Carrega registro selecionado para visualizacao
    *====================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN .F.
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *====================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN .F.
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Ncaixa.SetFocus()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *====================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cChave, loc_lConfirma
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN .F.
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            RETURN .F.
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?")
        IF !loc_lConfirma
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para pesquisa em SigFiMpf
    *====================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigFiMpf", "cursor_4c_BuscaFBI", "cImpFabs", "", ;
                "Fabrica" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cImpFabs", "", "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("emps",     "", "Empresa")
                loc_oBusca.mAddColuna("cncaixas", "", "Caixa")
                loc_oBusca.Show()
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaFBI")
            USE IN cursor_4c_BuscaFBI
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BtnEncerrarClick - Fecha o formulario
    *====================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnSalvarClick - Valida dados e salva o registro atual
    * Legado: Salva.Click
    *====================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes FORA do TRY (Regra VFP9 #1: RETURN nao permitido dentro de TRY)
        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
                MsgAviso("N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o (NFAB) " + CHR(233) + " obrigat" + CHR(243) + "rio.")
                loc_oPg2.txt_4c_Codigo.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Modelo.Value))
            MsgAviso("Modelo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
            loc_oPg2.txt_4c_Modelo.SetFocus()
            RETURN .F.
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso.")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormFBI.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Cancela operacao e retorna para lista
    *====================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

ENDDEFINE
