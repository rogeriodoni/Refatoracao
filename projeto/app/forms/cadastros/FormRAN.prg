*==============================================================================
* FormRAN.prg - Formulario de Registro de Analises
* Migrado de: SIGCDRAN.SCX (frmcadastro)
* Tabela: SigInAna | Cursor: crSigInAna
*==============================================================================

DEFINE CLASS FormRAN AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Registro de An" + CHR(225) + "lises"
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

    *===========================================================================
    * Init - Inicializa o formulario
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("RANBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar RANBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormRAN.InicializarForm")
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
            MostrarErro("Erro ao inicializar FormRAN:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
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
    * ConfigurarPaginaLista - Configura Page1 com Grid (5 colunas) e botoes CRUD
    * Colunas do grid: codigos, datas, resps, codtpans, nlaudos
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho
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
        *-- Legado: Grupo_op.Left=312, Top=-1, Width=418, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
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

        *-- Botao Visualizar (Left=80)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
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

        *-- Botao Buscar (Left=305)
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

        *-- Container Saida - PADRAO CANONICO (Left=917, Width=90)
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

        *-- Grid de listagem
        *-- Legado: Grade.Top=121, Left=12, Width=940
        *-- Com compensacao +29: Top=150, Left=26, Width=880
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 5
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
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
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 com campos de dados
    * Campos: getCodigos, GetLaudo, getDatas, Gettpan, Getdtpan,
    *         Getcdconta, Getdsconta, Container2 (Amostragem), Container1 (Material)
    * Posicoes: original Top + 29 (compensacao PageFrame)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt1, loc_oCnt2
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (Confirmar + Cancelar)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * Linha 1: Codigo (codigos) + N.Laudo (nlaudos) + Data (datas)
        * Legado: getCodigos.Top=179, GetLaudo.Top=179, getDatas.Top=179 -> +29 = 208
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo : "
            .Top       = 213
            .Left      = 206
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = 0
            .Top           = 208
            .Left          = 258
            .Width         = 52
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999999"
            .BackColor     = RGB(230, 230, 230)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_NLaudo", "Label")
        WITH loc_oPagina.lbl_4c_NLaudo
            .Caption   = "N" + CHR(186) + " Laudo : "
            .Top       = 213
            .Left      = 351
            .Width     = 67
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Laudo", "TextBox")
        WITH loc_oPagina.txt_4c_Laudo
            .Value         = 0
            .Top           = 208
            .Left          = 414
            .Width         = 52
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999999"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Data", "Label")
        WITH loc_oPagina.lbl_4c_Data
            .Caption   = "Data :"
            .Top       = 213
            .Left      = 507
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPagina.txt_4c_Datas
            .Value         = {}
            .Top           = 208
            .Left          = 546
            .Width         = 79
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Linha 2: Tipo Analise (codtpans + descricao)
        * Legado: Gettpan.Top=205, Getdtpan.Top=205 -> +29 = 234
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_TipoAnalise", "Label")
        WITH loc_oPagina.lbl_4c_TipoAnalise
            .Caption   = "Tipo An" + CHR(225) + "lise : "
            .Top       = 237
            .Left      = 177
            .Width     = 84
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tpan", "TextBox")
        WITH loc_oPagina.txt_4c_Tpan
            .Value         = 0
            .Top           = 234
            .Left          = 258
            .Width         = 24
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Tpan, "KeyPress", THIS, "ValidarTipoAnalise")

        loc_oPagina.AddObject("txt_4c_Dtpan", "TextBox")
        WITH loc_oPagina.txt_4c_Dtpan
            .Value         = ""
            .Top           = 234
            .Left          = 283
            .Width         = 342
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 20
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dtpan, "KeyPress", THIS, "ValidarDescricaoTipoAnalise")

        *----------------------------------------------------------------------
        * Linha 3: Responsavel (resps = iclis de SigCdCli)
        * Legado: Getcdconta.Top=231, Getdsconta.Top=231 -> +29 = 260
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Responsavel", "Label")
        WITH loc_oPagina.lbl_4c_Responsavel
            .Caption   = "Respons" + CHR(225) + "vel : "
            .Top       = 263
            .Left      = 174
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cdconta", "TextBox")
        WITH loc_oPagina.txt_4c_Cdconta
            .Value         = ""
            .Top           = 260
            .Left          = 258
            .Width         = 80
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Cdconta, "KeyPress", THIS, "ValidarResponsavel")

        loc_oPagina.AddObject("txt_4c_Dsconta", "TextBox")
        WITH loc_oPagina.txt_4c_Dsconta
            .Value         = ""
            .Top           = 260
            .Left          = 340
            .Width         = 285
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 40
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dsconta, "KeyPress", THIS, "ValidarNomeResponsavel")

        *----------------------------------------------------------------------
        * Container2 - Amostragem
        * Legado: Top=295, Left=126, Width=180, Height=96 -> +29 = Top=324
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Container2", "Container")
        WITH loc_oPagina.cnt_4c_Container2
            .Top         = 324
            .Left        = 126
            .Width       = 180
            .Height      = 96
            .BackStyle   = 0
            .BorderWidth = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
        loc_oCnt2 = loc_oPagina.cnt_4c_Container2

        loc_oCnt2.AddObject("lbl_4c_TitAmost", "Label")
        WITH loc_oCnt2.lbl_4c_TitAmost
            .Caption   = "Amostragem"
            .Top       = 4
            .Left      = 5
            .Width     = 85
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oCnt2.AddObject("lbl_4c_PesoLabel", "Label")
        WITH loc_oCnt2.lbl_4c_PesoLabel
            .Caption   = "Peso : "
            .Top       = 29
            .Left      = 33
            .Width     = 40
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oCnt2.AddObject("txt_4c_Peam", "TextBox")
        WITH loc_oCnt2.txt_4c_Peam
            .Value         = 0
            .Top           = 25
            .Left          = 71
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999,999.99"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt2.AddObject("lbl_4c_DtamLabel", "Label")
        WITH loc_oCnt2.lbl_4c_DtamLabel
            .Caption   = "Data : "
            .Top       = 55
            .Left      = 33
            .Width     = 37
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oCnt2.AddObject("txt_4c_Dtam", "TextBox")
        WITH loc_oCnt2.txt_4c_Dtam
            .Value         = {}
            .Top           = 52
            .Left          = 71
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container1 - Material para analise
        * Legado: Top=295, Left=305, Width=374, Height=96 -> +29 = Top=324
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Container1", "Container")
        WITH loc_oPagina.cnt_4c_Container1
            .Top         = 324
            .Left        = 305
            .Width       = 374
            .Height      = 96
            .BackStyle   = 0
            .BorderWidth = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
        loc_oCnt1 = loc_oPagina.cnt_4c_Container1

        loc_oCnt1.AddObject("lbl_4c_TitMaterial", "Label")
        WITH loc_oCnt1.lbl_4c_TitMaterial
            .Caption   = "Material para an" + CHR(225) + "lise"
            .Top       = 4
            .Left      = 5
            .Width     = 140
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oCnt1.AddObject("lbl_4c_NLoteLabel", "Label")
        WITH loc_oCnt1.lbl_4c_NLoteLabel
            .Caption   = "N" + CHR(186) + " Lote : "
            .Top       = 27
            .Left      = 37
            .Width     = 51
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oCnt1.AddObject("txt_4c_Nlote", "TextBox")
        WITH loc_oCnt1.txt_4c_Nlote
            .Value         = 0
            .Top           = 23
            .Left          = 90
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "9999999999"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oCnt1.txt_4c_Nlote, "KeyPress", THIS, "ValidarLote")

        loc_oCnt1.AddObject("lbl_4c_NFundLabel", "Label")
        WITH loc_oCnt1.lbl_4c_NFundLabel
            .Caption   = "N" + CHR(186) + " Fundi" + CHR(231) + CHR(227) + "o :"
            .Top       = 26
            .Left      = 186
            .Width     = 78
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oCnt1.AddObject("txt_4c_Nfund", "TextBox")
        WITH loc_oCnt1.txt_4c_Nfund
            .Value         = 0
            .Top           = 23
            .Left          = 264
            .Width         = 58
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999999"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oCnt1.txt_4c_Nfund, "KeyPress", THIS, "ValidarFundicao")

        loc_oCnt1.AddObject("lbl_4c_NOpLabel", "Label")
        WITH loc_oCnt1.lbl_4c_NOpLabel
            .Caption   = "N" + CHR(186) + " Op :"
            .Top       = 54
            .Left      = 45
            .Width     = 45
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oCnt1.AddObject("txt_4c_Op", "TextBox")
        WITH loc_oCnt1.txt_4c_Op
            .Value         = 0
            .Top           = 50
            .Left          = 90
            .Width         = 80
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "9999999999"
            .Alignment     = 3
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oCnt1.txt_4c_Op, "KeyPress", THIS, "ValidarOperacao")

        loc_oCnt1.AddObject("lbl_4c_FaseLabel", "Label")
        WITH loc_oCnt1.lbl_4c_FaseLabel
            .Caption   = "Fase :"
            .Top       = 54
            .Left      = 227
            .Width     = 37
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oCnt1.AddObject("txt_4c_Fase", "TextBox")
        WITH loc_oCnt1.txt_4c_Fase
            .Value         = ""
            .Top           = 50
            .Left          = 264
            .Width         = 100
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(230, 230, 230)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount = 5
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.resps"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.codtpans"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.nlaudos"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 80
                loc_oGrid.Column3.Width = 80
                loc_oGrid.Column4.Width = 150
                loc_oGrid.Column5.Width = 80

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
                loc_oGrid.Column2.Header1.Caption = "Data"
                loc_oGrid.Column3.Header1.Caption = "Respons" + CHR(225) + "vel"
                loc_oGrid.Column4.Header1.Caption = "Tipo An" + CHR(225) + "lise"
                loc_oGrid.Column5.Header1.Caption = "N. Laudo"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
                "FormRAN.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormRAN.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Abre Page2 para incluir novo registro
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_nNovoCodigo
        loc_nNovoCodigo = 0

        loc_nNovoCodigo = THIS.this_oBusinessObject.GerarProximoCodigo()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_oBusinessObject.this_nCodigos = loc_nNovoCodigo
        THIS.this_oBusinessObject.this_cEmps    = go_4c_Sistema.cCodEmpresa
        THIS.this_oBusinessObject.this_dDatas   = DATE()

        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.BOParaForm()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigo
        loc_nCodigo = 0

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_nCodigo = cursor_4c_Dados.codigos
        ENDIF

        IF loc_nCodigo <= 0
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.LimparCampos()
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar registro selecionado
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigo
        loc_nCodigo = 0

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_nCodigo = cursor_4c_Dados.codigos
        ENDIF

        IF loc_nCodigo <= 0
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.LimparCampos()
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigo
        loc_nCodigo = 0

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_nCodigo = cursor_4c_Dados.codigos
        ENDIF

        IF loc_nCodigo <= 0
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da an" + CHR(225) + "lise [" + ;
                    TRANSFORM(loc_nCodigo) + "]?", "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre picker para localizar analise na lista
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cSQL, loc_nResult, loc_nCodigo
        loc_nCodigo = 0

        TRY
            loc_cSQL = "SELECT CONVERT(varchar(10), codigos) AS codigos_str," + ;
                " CONVERT(varchar(10), datas, 103) AS datas_str, resps" + ;
                " FROM SigInAna WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " ORDER BY codigos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaRAN")

            IF loc_nResult >= 0 AND USED("cursor_4c_BuscaRAN")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaRAN", "codigos_str", "resps", ;
                        "Buscar An" + CHR(225) + "lise")
                    loc_oBusca.Mostrar()

                    IF loc_oBusca.this_lSelecionou
                        loc_nCodigo = VAL(loc_oBusca.cCodigoSelecionado)
                    ENDIF

                    loc_oBusca = .NULL.
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaRAN")
                USE IN cursor_4c_BuscaRAN
            ENDIF

            IF loc_nCodigo > 0 AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR codigos = loc_nCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.BtnBuscarClick")
            IF USED("cursor_4c_BuscaRAN")
                USE IN cursor_4c_BuscaRAN
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma e salva o registro atual
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5) AND EMPTY(loc_oPagina.txt_4c_Datas.Value)
            MsgAviso("Data inv" + CHR(225) + "lida.")
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados do Form para o BO antes de salvar
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_oCnt1, loc_oCnt2
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oCnt1   = loc_oPagina.cnt_4c_Container1
        loc_oCnt2   = loc_oPagina.cnt_4c_Container2

        THIS.this_oBusinessObject.this_nCodigos   = loc_oPagina.txt_4c_Codigos.Value
        THIS.this_oBusinessObject.this_nNlaudos   = loc_oPagina.txt_4c_Laudo.Value
        THIS.this_oBusinessObject.this_dDatas     = loc_oPagina.txt_4c_Datas.Value
        THIS.this_oBusinessObject.this_nCodtpans  = loc_oPagina.txt_4c_Tpan.Value
        THIS.this_oBusinessObject.this_cResps     = ALLTRIM(loc_oPagina.txt_4c_Cdconta.Value)

        THIS.this_oBusinessObject.this_nPesamosts = loc_oCnt2.txt_4c_Peam.Value
        THIS.this_oBusinessObject.this_dDtamosts  = loc_oCnt2.txt_4c_Dtam.Value

        THIS.this_oBusinessObject.this_nNlotes    = loc_oCnt1.txt_4c_Nlote.Value
        THIS.this_oBusinessObject.this_nNfunds    = loc_oCnt1.txt_4c_Nfund.Value
        THIS.this_oBusinessObject.this_nNops      = loc_oCnt1.txt_4c_Op.Value
        THIS.this_oBusinessObject.this_cFases     = ALLTRIM(loc_oCnt1.txt_4c_Fase.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para o Form apos carregar registro
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oCnt1, loc_oCnt2
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oCnt1   = loc_oPagina.cnt_4c_Container1
        loc_oCnt2   = loc_oPagina.cnt_4c_Container2

        loc_oPagina.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_nCodigos
        loc_oPagina.txt_4c_Laudo.Value   = THIS.this_oBusinessObject.this_nNlaudos
        loc_oPagina.txt_4c_Datas.Value   = THIS.this_oBusinessObject.this_dDatas
        loc_oPagina.txt_4c_Tpan.Value    = THIS.this_oBusinessObject.this_nCodtpans
        loc_oPagina.txt_4c_Dtpan.Value   = ""
        loc_oPagina.txt_4c_Cdconta.Value = THIS.this_oBusinessObject.this_cResps
        loc_oPagina.txt_4c_Dsconta.Value = ""

        loc_oCnt2.txt_4c_Peam.Value = THIS.this_oBusinessObject.this_nPesamosts
        loc_oCnt2.txt_4c_Dtam.Value = THIS.this_oBusinessObject.this_dDtamosts

        loc_oCnt1.txt_4c_Nlote.Value = THIS.this_oBusinessObject.this_nNlotes
        loc_oCnt1.txt_4c_Nfund.Value = THIS.this_oBusinessObject.this_nNfunds
        loc_oCnt1.txt_4c_Op.Value    = THIS.this_oBusinessObject.this_nNops
        loc_oCnt1.txt_4c_Fase.Value  = THIS.this_oBusinessObject.this_cFases

        THIS.CarregarDescricoes()
        THIS.AtualizarMutualExclusao()
    ENDPROC

    *===========================================================================
    * CarregarDescricoes - Carrega descricoes dos lookups (TipoAnalise + Responsavel)
    *===========================================================================
    PROTECTED PROCEDURE CarregarDescricoes()
        LOCAL loc_oPagina, loc_cSQL, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Descricao do tipo de analise (SigPrTpa)
        IF THIS.this_oBusinessObject.this_nCodtpans > 0
            loc_cSQL = "SELECT descs FROM SigPrTpa WHERE codigos = " + ;
                FormatarNumeroSQL(THIS.this_oBusinessObject.this_nCodtpans, 0)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpAna")
            IF loc_nResult >= 0 AND USED("cursor_4c_TpAna") AND RECCOUNT("cursor_4c_TpAna") > 0
                SELECT cursor_4c_TpAna
                loc_oPagina.txt_4c_Dtpan.Value = ALLTRIM(cursor_4c_TpAna.descs)
            ENDIF
            IF USED("cursor_4c_TpAna")
                USE IN cursor_4c_TpAna
            ENDIF
        ENDIF

        *-- Nome do responsavel (SigCdCli)
        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cResps))
            loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + ;
                EscaparSQL(THIS.this_oBusinessObject.this_cResps)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Resp")
            IF loc_nResult >= 0 AND USED("cursor_4c_Resp") AND RECCOUNT("cursor_4c_Resp") > 0
                SELECT cursor_4c_Resp
                loc_oPagina.txt_4c_Dsconta.Value = ALLTRIM(cursor_4c_Resp.rclis)
            ENDIF
            IF USED("cursor_4c_Resp")
                USE IN cursor_4c_Resp
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_oCnt1, loc_oCnt2
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oCnt1   = loc_oPagina.cnt_4c_Container1
        loc_oCnt2   = loc_oPagina.cnt_4c_Container2

        *-- txt_4c_Codigos sempre ReadOnly (PK auto-gerada)
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Enabled = .F.
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Laudo", 5)
            loc_oPagina.txt_4c_Laudo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
            loc_oPagina.txt_4c_Datas.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Tpan", 5)
            loc_oPagina.txt_4c_Tpan.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Dtpan", 5)
            *-- Dtpan habilitado apenas quando editando e nenhum tipo selecionado ainda
            loc_oPagina.txt_4c_Dtpan.Enabled = par_lHabilitar AND (loc_oPagina.txt_4c_Tpan.Value = 0)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Cdconta", 5)
            loc_oPagina.txt_4c_Cdconta.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Dsconta", 5)
            *-- Dsconta habilitado apenas quando editando e nenhum codigo selecionado ainda
            loc_oPagina.txt_4c_Dsconta.Enabled = par_lHabilitar AND ;
                EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cdconta.Value))
        ENDIF

        *-- Container2 (Amostragem)
        IF PEMSTATUS(loc_oPagina, "cnt_4c_Container2", 5)
            loc_oCnt2 = loc_oPagina.cnt_4c_Container2
            IF PEMSTATUS(loc_oCnt2, "txt_4c_Peam", 5)
                loc_oCnt2.txt_4c_Peam.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oCnt2, "txt_4c_Dtam", 5)
                loc_oCnt2.txt_4c_Dtam.Enabled = par_lHabilitar
            ENDIF
        ENDIF

        *-- Container1 (Material) - txt_4c_Fase sempre ReadOnly
        IF PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
            loc_oCnt1 = loc_oPagina.cnt_4c_Container1
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Fase", 5)
                loc_oCnt1.txt_4c_Fase.Enabled = .F.
            ENDIF
        ENDIF

        *-- Aplicar exclusao mutua em Op/Nlote/Nfund
        THIS.AtualizarMutualExclusao()
    ENDPROC

    *===========================================================================
    * AtualizarMutualExclusao - Aplica logica de exclusao mutua entre Op/Nlote/Nfund
    * Regra legado: cada campo s so editavel quando os outros dois estao vazios
    *===========================================================================
    PROCEDURE AtualizarMutualExclusao()
        LOCAL loc_oPagina, loc_oCnt1, loc_lEdicao
        LOCAL loc_lTemNlote, loc_lTemNfund, loc_lTemOp
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
            RETURN
        ENDIF
        loc_oCnt1 = loc_oPagina.cnt_4c_Container1

        loc_lTemNlote = PEMSTATUS(loc_oCnt1, "txt_4c_Nlote", 5) AND ;
            !EMPTY(loc_oCnt1.txt_4c_Nlote.Value) AND loc_oCnt1.txt_4c_Nlote.Value <> 0
        loc_lTemNfund = PEMSTATUS(loc_oCnt1, "txt_4c_Nfund", 5) AND ;
            !EMPTY(loc_oCnt1.txt_4c_Nfund.Value) AND loc_oCnt1.txt_4c_Nfund.Value <> 0
        loc_lTemOp    = PEMSTATUS(loc_oCnt1, "txt_4c_Op", 5) AND ;
            !EMPTY(loc_oCnt1.txt_4c_Op.Value) AND loc_oCnt1.txt_4c_Op.Value <> 0

        IF PEMSTATUS(loc_oCnt1, "txt_4c_Nlote", 5)
            loc_oCnt1.txt_4c_Nlote.Enabled = loc_lEdicao AND !loc_lTemOp AND !loc_lTemNfund
        ENDIF
        IF PEMSTATUS(loc_oCnt1, "txt_4c_Nfund", 5)
            loc_oCnt1.txt_4c_Nfund.Enabled = loc_lEdicao AND !loc_lTemOp AND !loc_lTemNlote
        ENDIF
        IF PEMSTATUS(loc_oCnt1, "txt_4c_Op", 5)
            loc_oCnt1.txt_4c_Op.Enabled = loc_lEdicao AND !loc_lTemNlote AND !loc_lTemNfund
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 para novo registro
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_oCnt1, loc_oCnt2
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oCnt1   = loc_oPagina.cnt_4c_Container1
        loc_oCnt2   = loc_oPagina.cnt_4c_Container2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Laudo", 5)
            loc_oPagina.txt_4c_Laudo.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
            loc_oPagina.txt_4c_Datas.Value = {}
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Tpan", 5)
            loc_oPagina.txt_4c_Tpan.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Dtpan", 5)
            loc_oPagina.txt_4c_Dtpan.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Cdconta", 5)
            loc_oPagina.txt_4c_Cdconta.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Dsconta", 5)
            loc_oPagina.txt_4c_Dsconta.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cnt_4c_Container2", 5)
            loc_oCnt2 = loc_oPagina.cnt_4c_Container2
            IF PEMSTATUS(loc_oCnt2, "txt_4c_Peam", 5)
                loc_oCnt2.txt_4c_Peam.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oCnt2, "txt_4c_Dtam", 5)
                loc_oCnt2.txt_4c_Dtam.Value = {}
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
            loc_oCnt1 = loc_oPagina.cnt_4c_Container1
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Nlote", 5)
                loc_oCnt1.txt_4c_Nlote.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Nfund", 5)
                loc_oCnt1.txt_4c_Nfund.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Op", 5)
                loc_oCnt1.txt_4c_Op.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Fase", 5)
                loc_oCnt1.txt_4c_Fase.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarTipoAnalise - Valida codigo do tipo de analise (txt_4c_Tpan)
    * Legado: Gettpan.Valid - fwBuscaExt on SigPrTpa by codigos
    *===========================================================================
    PROCEDURE ValidarTipoAnalise(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cSQL, loc_nResult, loc_nCod
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_Tpan", 5)
            RETURN
        ENDIF

        loc_nCod = loc_oPagina.txt_4c_Tpan.Value

        IF EMPTY(loc_nCod) OR loc_nCod = 0
            loc_oPagina.txt_4c_Dtpan.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT codigos, descs FROM SigPrTpa WHERE codigos = " + ;
                FormatarNumeroSQL(loc_nCod, 0)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpAnaVal")

            IF loc_nResult >= 0 AND USED("cursor_4c_TpAnaVal") AND RECCOUNT("cursor_4c_TpAnaVal") > 0
                SELECT cursor_4c_TpAnaVal
                loc_oPagina.txt_4c_Tpan.Value  = cursor_4c_TpAnaVal.codigos
                loc_oPagina.txt_4c_Dtpan.Value = ALLTRIM(cursor_4c_TpAnaVal.descs)
            ELSE
                THIS.AbrirBuscaTipoAnalise()
            ENDIF

            IF USED("cursor_4c_TpAnaVal")
                USE IN cursor_4c_TpAnaVal
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.ValidarTipoAnalise")
            IF USED("cursor_4c_TpAnaVal")
                USE IN cursor_4c_TpAnaVal
            ENDIF
        ENDTRY

        IF PEMSTATUS(loc_oPagina, "txt_4c_Dtpan", 5)
            loc_oPagina.txt_4c_Dtpan.Enabled = (loc_oPagina.txt_4c_Tpan.Value = 0) AND ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarDescricaoTipoAnalise - Valida descricao do tipo de analise (txt_4c_Dtpan)
    * Legado: Getdtpan.Valid - fwBuscaExt on SigPrTpa by Descs
    *===========================================================================
    PROCEDURE ValidarDescricaoTipoAnalise(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cSQL, loc_nResult, loc_cDesc
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_Dtpan", 5)
            RETURN
        ENDIF

        loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_Dtpan.Value)

        IF EMPTY(loc_cDesc)
            RETURN
        ENDIF

        *-- Dtpan so editavel quando Tpan = 0
        IF loc_oPagina.txt_4c_Tpan.Value <> 0
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigPrTpa WHERE descs LIKE " + ;
                EscaparSQL(loc_cDesc + "%")
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpDesc")

            IF loc_nResult >= 0 AND USED("cursor_4c_TpDesc") AND RECCOUNT("cursor_4c_TpDesc") > 0
                SELECT cursor_4c_TpDesc
                loc_oPagina.txt_4c_Tpan.Value  = cursor_4c_TpDesc.codigos
                loc_oPagina.txt_4c_Dtpan.Value = ALLTRIM(cursor_4c_TpDesc.descs)
            ELSE
                THIS.AbrirBuscaTipoAnalise()
            ENDIF

            IF USED("cursor_4c_TpDesc")
                USE IN cursor_4c_TpDesc
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.ValidarDescricaoTipoAnalise")
            IF USED("cursor_4c_TpDesc")
                USE IN cursor_4c_TpDesc
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaTipoAnalise - Abre picker FormBuscaAuxiliar para SigPrTpa
    *===========================================================================
    PROCEDURE AbrirBuscaTipoAnalise()
        LOCAL loc_oBusca, loc_cSQL, loc_nResult, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL = "SELECT codigos, descs FROM SigPrTpa ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpanaLista")

            IF loc_nResult >= 0 AND USED("cursor_4c_TpanaLista")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_TpanaLista", "codigos", "descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Tipo de An" + CHR(225) + "lise")
                    loc_oBusca.Mostrar()

                    IF loc_oBusca.this_lSelecionou
                        loc_oPagina.txt_4c_Tpan.Value  = VAL(loc_oBusca.cCodigoSelecionado)
                        loc_oPagina.txt_4c_Dtpan.Value = loc_oBusca.cDescricaoSelecionada
                    ELSE
                        loc_oPagina.txt_4c_Tpan.Value  = 0
                        loc_oPagina.txt_4c_Dtpan.Value = ""
                    ENDIF

                    loc_oBusca = .NULL.
                ENDIF
            ENDIF

            IF USED("cursor_4c_TpanaLista")
                USE IN cursor_4c_TpanaLista
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.AbrirBuscaTipoAnalise")
            IF USED("cursor_4c_TpanaLista")
                USE IN cursor_4c_TpanaLista
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarResponsavel - Valida codigo do responsavel (txt_4c_Cdconta -> SigCdCli.iclis)
    * Legado: Getcdconta.Valid - fAcessoContas -> substituido por lookup direto SigCdCli
    *===========================================================================
    PROCEDURE ValidarResponsavel(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cSQL, loc_nResult, loc_cCod
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_Cdconta", 5)
            RETURN
        ENDIF

        loc_cCod = ALLTRIM(loc_oPagina.txt_4c_Cdconta.Value)

        IF EMPTY(loc_cCod)
            loc_oPagina.txt_4c_Dsconta.Value = ""
            IF PEMSTATUS(loc_oPagina, "txt_4c_Dsconta", 5)
                loc_oPagina.txt_4c_Dsconta.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodResp")

            IF loc_nResult >= 0 AND USED("cursor_4c_CodResp") AND RECCOUNT("cursor_4c_CodResp") > 0
                SELECT cursor_4c_CodResp
                loc_oPagina.txt_4c_Cdconta.Value = ALLTRIM(cursor_4c_CodResp.iclis)
                loc_oPagina.txt_4c_Dsconta.Value = ALLTRIM(cursor_4c_CodResp.rclis)
                IF PEMSTATUS(loc_oPagina, "txt_4c_Dsconta", 5)
                    loc_oPagina.txt_4c_Dsconta.Enabled = .F.
                ENDIF
            ELSE
                THIS.AbrirBuscaResponsavel()
            ENDIF

            IF USED("cursor_4c_CodResp")
                USE IN cursor_4c_CodResp
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.ValidarResponsavel")
            IF USED("cursor_4c_CodResp")
                USE IN cursor_4c_CodResp
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarNomeResponsavel - Valida nome do responsavel (txt_4c_Dsconta -> SigCdCli.rclis)
    * Legado: Getdsconta.Valid - fAcessoContas -> substituido por lookup direto
    *===========================================================================
    PROCEDURE ValidarNomeResponsavel(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cSQL, loc_nResult, loc_cNome
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_Dsconta", 5)
            RETURN
        ENDIF

        loc_cNome = ALLTRIM(loc_oPagina.txt_4c_Dsconta.Value)

        IF EMPTY(loc_cNome)
            RETURN
        ENDIF

        *-- Dsconta so editavel quando Cdconta esta vazio
        IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cdconta.Value))
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE rclis LIKE " + ;
                EscaparSQL(loc_cNome + "%")
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeResp")

            IF loc_nResult >= 0 AND USED("cursor_4c_NomeResp") AND RECCOUNT("cursor_4c_NomeResp") > 0
                SELECT cursor_4c_NomeResp
                loc_oPagina.txt_4c_Cdconta.Value = ALLTRIM(cursor_4c_NomeResp.iclis)
                loc_oPagina.txt_4c_Dsconta.Value = ALLTRIM(cursor_4c_NomeResp.rclis)
                IF PEMSTATUS(loc_oPagina, "txt_4c_Dsconta", 5)
                    loc_oPagina.txt_4c_Dsconta.Enabled = .F.
                ENDIF
            ELSE
                THIS.AbrirBuscaResponsavel()
            ENDIF

            IF USED("cursor_4c_NomeResp")
                USE IN cursor_4c_NomeResp
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.ValidarNomeResponsavel")
            IF USED("cursor_4c_NomeResp")
                USE IN cursor_4c_NomeResp
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaResponsavel - Abre picker FormBuscaAuxiliar para SigCdCli
    *===========================================================================
    PROCEDURE AbrirBuscaResponsavel()
        LOCAL loc_oBusca, loc_cSQL, loc_nResult, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli ORDER BY iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespLista")

            IF loc_nResult >= 0 AND USED("cursor_4c_RespLista")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_RespLista", "iclis", "rclis", ;
                        "Selecionar Respons" + CHR(225) + "vel")
                    loc_oBusca.Mostrar()

                    IF loc_oBusca.this_lSelecionou
                        loc_oPagina.txt_4c_Cdconta.Value = loc_oBusca.cCodigoSelecionado
                        loc_oPagina.txt_4c_Dsconta.Value = loc_oBusca.cDescricaoSelecionada
                        IF PEMSTATUS(loc_oPagina, "txt_4c_Dsconta", 5)
                            loc_oPagina.txt_4c_Dsconta.Enabled = .F.
                        ENDIF
                    ELSE
                        loc_oPagina.txt_4c_Cdconta.Value = ""
                        loc_oPagina.txt_4c_Dsconta.Value = ""
                    ENDIF

                    loc_oBusca = .NULL.
                ENDIF
            ENDIF

            IF USED("cursor_4c_RespLista")
                USE IN cursor_4c_RespLista
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.AbrirBuscaResponsavel")
            IF USED("cursor_4c_RespLista")
                USE IN cursor_4c_RespLista
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarLote - Valida numero do lote (txt_4c_Nlote -> SigMvCab via SigCdOpe)
    * Legado: Getnlote.Valid - extrai operacao dos 4 primeiros digitos, numero dos 6 ultimos
    *===========================================================================
    PROCEDURE ValidarLote(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_oCnt1, loc_cSQL, loc_nResult
        LOCAL loc_nNlote, loc_nNdope, loc_nNume
        LOCAL loc_cDopes, loc_nCtrllotes
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
            RETURN
        ENDIF
        loc_oCnt1 = loc_oPagina.cnt_4c_Container1

        IF !PEMSTATUS(loc_oCnt1, "txt_4c_Nlote", 5)
            RETURN
        ENDIF

        loc_nNlote = loc_oCnt1.txt_4c_Nlote.Value

        IF EMPTY(loc_nNlote) OR loc_nNlote = 0
            THIS.AtualizarMutualExclusao()
            RETURN
        ENDIF

        TRY
            *-- Extrai codigo numerico da operacao (primeiros 4 digitos do lote)
            loc_nNdope = VAL(LEFT(ALLTRIM(STR(loc_nNlote, 10)), 4))
            *-- Extrai numero sequencial (ultimos 6 digitos do lote)
            loc_nNume  = VAL(RIGHT(ALLTRIM(STR(loc_nNlote, 10)), 6))

            *-- Busca operacao em SigCdOpe
            loc_cSQL = "SELECT TOP 1 Dopes, ctrllotes FROM SigCdOpe WHERE NDopes = " + ;
                FormatarNumeroSQL(loc_nNdope, 0)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeValida")

            IF loc_nResult < 0 OR !USED("cursor_4c_OpeValida") OR RECCOUNT("cursor_4c_OpeValida") = 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o do lote n" + CHR(227) + "o encontrada!")
                loc_oCnt1.txt_4c_Nlote.Value = 0
                IF USED("cursor_4c_OpeValida")
                    USE IN cursor_4c_OpeValida
                ENDIF
                RETURN
            ENDIF

            SELECT cursor_4c_OpeValida
            loc_cDopes     = ALLTRIM(cursor_4c_OpeValida.Dopes)
            loc_nCtrllotes = NVL(cursor_4c_OpeValida.ctrllotes, 0)
            USE IN cursor_4c_OpeValida

            IF loc_nCtrllotes <> 1
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + loc_cDopes + ;
                    " n" + CHR(227) + "o configurada para gerar N" + CHR(186) + ". Lote!")
                loc_oCnt1.txt_4c_Nlote.Value = 0
                THIS.AtualizarMutualExclusao()
                RETURN
            ENDIF

            *-- Verifica existencia do lote em SigMvCab
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigMvCab" + ;
                " WHERE Dopes = " + EscaparSQL(loc_cDopes) + ;
                "   AND Numes = " + FormatarNumeroSQL(loc_nNume, 0) + ;
                "   AND emps  = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LoteVal")

            IF loc_nResult >= 0 AND USED("cursor_4c_LoteVal")
                SELECT cursor_4c_LoteVal
                IF NVL(cursor_4c_LoteVal.qtd, 0) = 0
                    MsgAviso("Lote N" + CHR(186) + " " + TRANSFORM(loc_nNlote) + " n" + CHR(227) + "o existe!")
                    loc_oCnt1.txt_4c_Nlote.Value = 0
                ENDIF
                USE IN cursor_4c_LoteVal
            ELSE
                MostrarErro("Erro ao validar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_oCnt1.txt_4c_Nlote.Value = 0
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.ValidarLote")
            IF USED("cursor_4c_OpeValida")
                USE IN cursor_4c_OpeValida
            ENDIF
            IF USED("cursor_4c_LoteVal")
                USE IN cursor_4c_LoteVal
            ENDIF
        ENDTRY

        THIS.AtualizarMutualExclusao()
    ENDPROC

    *===========================================================================
    * ValidarFundicao - Valida numero de fundicao (txt_4c_Nfund -> SigCdFun)
    * Legado: Getnfund.Valid - fwBuscaExt on SigCdFun by Codigos
    *===========================================================================
    PROCEDURE ValidarFundicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_oCnt1, loc_cSQL, loc_nResult, loc_nCod
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
            RETURN
        ENDIF
        loc_oCnt1 = loc_oPagina.cnt_4c_Container1

        IF !PEMSTATUS(loc_oCnt1, "txt_4c_Nfund", 5)
            RETURN
        ENDIF

        loc_nCod = loc_oCnt1.txt_4c_Nfund.Value

        IF EMPTY(loc_nCod) OR loc_nCod = 0
            THIS.AtualizarMutualExclusao()
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT codigos FROM SigCdFun WHERE codigos = " + ;
                FormatarNumeroSQL(loc_nCod, 0)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FundVal")

            IF loc_nResult >= 0 AND USED("cursor_4c_FundVal") AND RECCOUNT("cursor_4c_FundVal") > 0
                SELECT cursor_4c_FundVal
                loc_oCnt1.txt_4c_Nfund.Value = cursor_4c_FundVal.codigos
                USE IN cursor_4c_FundVal
            ELSE
                IF USED("cursor_4c_FundVal")
                    USE IN cursor_4c_FundVal
                ENDIF
                THIS.AbrirBuscaFundicao()
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.ValidarFundicao")
            IF USED("cursor_4c_FundVal")
                USE IN cursor_4c_FundVal
            ENDIF
        ENDTRY

        THIS.AtualizarMutualExclusao()
    ENDPROC

    *===========================================================================
    * AbrirBuscaFundicao - Abre picker FormBuscaAuxiliar para SigCdFun
    * Legado: Getnfund.Valid - fwBuscaExt com colunas Codigos + Datas
    *===========================================================================
    PROCEDURE AbrirBuscaFundicao()
        LOCAL loc_oBusca, loc_cSQL, loc_nResult, loc_oPagina, loc_oCnt1
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
            RETURN
        ENDIF
        loc_oCnt1 = loc_oPagina.cnt_4c_Container1

        TRY
            loc_cSQL = "SELECT codigos, CONVERT(varchar(10), datas, 103) AS datas_str" + ;
                " FROM SigCdFun ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FundLista")

            IF loc_nResult >= 0 AND USED("cursor_4c_FundLista")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_FundLista", "codigos", "datas_str", ;
                        "Fundi" + CHR(231) + CHR(245) + "es")
                    loc_oBusca.Mostrar()

                    IF loc_oBusca.this_lSelecionou
                        loc_oCnt1.txt_4c_Nfund.Value = VAL(loc_oBusca.cCodigoSelecionado)
                    ELSE
                        loc_oCnt1.txt_4c_Nfund.Value = 0
                    ENDIF

                    loc_oBusca = .NULL.
                ENDIF
            ENDIF

            IF USED("cursor_4c_FundLista")
                USE IN cursor_4c_FundLista
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.AbrirBuscaFundicao")
            IF USED("cursor_4c_FundLista")
                USE IN cursor_4c_FundLista
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarOperacao - Valida numero da operacao (txt_4c_Op -> SigPdMvf) e popula Fase
    * Legado: GetOp.Valid - cursorquery SigPdMvf by nops, popula Getfase com Grupods
    *===========================================================================
    PROCEDURE ValidarOperacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_oCnt1, loc_cSQL, loc_nResult, loc_nNops
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
            RETURN
        ENDIF
        loc_oCnt1 = loc_oPagina.cnt_4c_Container1

        IF !PEMSTATUS(loc_oCnt1, "txt_4c_Op", 5)
            RETURN
        ENDIF

        loc_nNops = loc_oCnt1.txt_4c_Op.Value

        IF EMPTY(loc_nNops) OR loc_nNops = 0
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Fase", 5)
                loc_oCnt1.txt_4c_Fase.Value = ""
            ENDIF
            THIS.AtualizarMutualExclusao()
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 nops, grupods FROM SigPdMvf WHERE nops = " + ;
                FormatarNumeroSQL(loc_nNops, 0) + ;
                " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpVal")

            IF loc_nResult >= 0 AND USED("cursor_4c_OpVal") AND RECCOUNT("cursor_4c_OpVal") > 0
                SELECT cursor_4c_OpVal
                IF PEMSTATUS(loc_oCnt1, "txt_4c_Fase", 5)
                    loc_oCnt1.txt_4c_Fase.Value = ALLTRIM(cursor_4c_OpVal.grupods)
                ENDIF
                USE IN cursor_4c_OpVal
            ELSE
                IF USED("cursor_4c_OpVal")
                    USE IN cursor_4c_OpVal
                ENDIF
                MsgAviso("Op " + TRANSFORM(loc_nNops) + " n" + CHR(227) + "o encontrada!")
                loc_oCnt1.txt_4c_Op.Value = 0
                IF PEMSTATUS(loc_oCnt1, "txt_4c_Fase", 5)
                    loc_oCnt1.txt_4c_Fase.Value = ""
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRAN.ValidarOperacao")
            IF USED("cursor_4c_OpVal")
                USE IN cursor_4c_OpVal
            ENDIF
        ENDTRY

        THIS.AtualizarMutualExclusao()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
