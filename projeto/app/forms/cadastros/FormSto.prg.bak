*==============================================================================
* FormSto.prg - Formulario de Cadastro de Status de Operacao
* Migrado de: SigCdSto.SCX (frmcadastro)
* Tabela: SigCdSts | PK: cods
*==============================================================================

DEFINE CLASS FormSto AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Status de Opera" + CHR(231) + CHR(227) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    ForeColor   = RGB(90, 90, 90)

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = "LISTA"
    this_cMensagemErro    = ""

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
            THIS.this_oBusinessObject = CREATEOBJECT("StoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar StoBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSto.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                THIS.CarregarLista()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar FormSto:" + CHR(13) + ;
                THIS.this_cMensagemErro, "FormSto.InicializarForm")
            loc_lSucesso = .F.
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
    * ConfigurarPaginaLista - Configura Page1: Cabecalho, Grid de listagem e
    * Botoes CRUD (Incluir, Visualizar, Alterar, Excluir, Buscar, Encerrar)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oBotoes, loc_oSaida
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: Top=1. Com compensacao +29: Top=31
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

        *-- Container Botoes CRUD (Grupo_op no legado) - Canonico: Left=542, Top=29, Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPagina.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
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

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
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

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
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

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
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

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
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

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (padrao canonico CLAUDE.md #10 - PREVALECE sobre PILAR 1)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPagina.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
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

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem: cods (Codigo) + descs (Descricao)
        *-- Colunas EXATAS do legado (Init): pColuna("Cods",080)/pColuna("Descs",220)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 2

        WITH loc_oPagina.grd_4c_Lista
            .Top                     = 117
            .Left                    = 26
            .Width                   = 890
            .Height                  = 498
            .FontName                = "Verdana"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .GridLines               = 3
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 16
            .ScrollBars              = 2
            .ReadOnly                = .T.
            .Visible                 = .T.
            .Column1.Width           = 80
            .Column2.Width           = 220
            .Column1.ReadOnly        = .T.
            .Column2.ReadOnly        = .T.
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega os registros de SigCdSts no Grid da Page1
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (cods C(3), descs C(30), ddvals C(10))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount  = 2
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"

                        loc_oGrid.Column1.Width = 80
                        loc_oGrid.Column2.Width = 220

                        loc_oGrid.Column1.ReadOnly = .T.
                        loc_oGrid.Column2.ReadOnly = .T.

                        *-- Reconfigurar cabecalhos (RecordSource reseta Header1.Caption)
                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                        THIS.FormatarGridLista(loc_oGrid)

                        IF RECCOUNT("cursor_4c_Dados") > 0
                            GO TOP IN cursor_4c_Dados
                        ENDIF

                        loc_oGrid.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao carregar lista de Status de Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                THIS.this_cMensagemErro, "FormSto.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para a Lista (1), recarrega o Grid
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + THIS.this_cMensagemErro, "FormSto.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 completa: Codigo, Descricao,
    * checkboxes de dias validos (Domingo..Sabado + Feriados) e botoes de acao
    * (Confirmar/Cancelar). NAO ha lookups neste form (getCods/getDescs sao
    * fwget simples, sem fwbuscaext/fwBuscaSel/sigacess no fonte original).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH



        *-- Container Botoes de Acao (Grupo_Salva no legado)
        *-- Canonico: Left=842, Top=33, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva no legado - Grupo_Salva.Salva)
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
            .FontName        = "Comic Sans MS"
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

        *-- Botao Cancelar (Grupo_Salva.Cancelar)
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
            .FontName        = "Comic Sans MS"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label1 (Say1 - "C" + CHR(243) + "digo :"): Top=134+29=163, Left=216
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 163
            .Left      = 216
            .Width     = 42
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCods (txt_4c_Codigo): Top=130+29=159, Left=258, Width=31, Height=24
        *-- Campo cods C(3) - PK, editavel apenas em INCLUIR/BUSCAR (HabilitarCampos)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 159
            .Left          = 258
            .Width         = 31
            .Height        = 24
            .MaxLength     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label2 (Say2 - "Descri" + CHR(231) + CHR(227) + "o :"): Top=160+29=189, Left=203
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 189
            .Left      = 203
            .Width     = 55
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getDescs (txt_4c_Descricao): Top=156+29=185, Left=258, Width=220, Height=24
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 185
            .Left          = 258
            .Width         = 220
            .Height        = 24
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Shape3 (shp_4c_Shape3): Top=209+29=238, Left=180, Width=378, Height=2
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top         = 238
            .Left        = 180
            .Width       = 378
            .Height      = 2
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Say18 (lbl_4c_Label18 - titulo da secao): Top=192+29=221, Left=180
        loc_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPagina.lbl_4c_Label18
            .Caption   = " Datas V" + CHR(225) + "lidas Para Utiliza" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es"
            .Top       = 221
            .Left      = 180
            .Width     = 254
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkEntregaDo (chk_4c_ChkEntregaDo - Domingos): Top=215+29=244, Left=179
        loc_oPagina.AddObject("chk_4c_ChkEntregaDo", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkEntregaDo
            .Caption   = "Domingos"
            .Value     = 0
            .Top       = 244
            .Left      = 179
            .Width     = 64
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkEntrega02 (chk_4c_ChkEntrega02 - Segunda-feira): Top=215+29=244, Left=271
        loc_oPagina.AddObject("chk_4c_ChkEntrega02", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkEntrega02
            .Caption   = "Segunda-feira"
            .Value     = 0
            .Top       = 244
            .Left      = 271
            .Width     = 86
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkEntrega03 (chk_4c_ChkEntrega03 - Terca-feira): Top=215+29=244, Left=377
        loc_oPagina.AddObject("chk_4c_ChkEntrega03", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkEntrega03
            .Caption   = "Ter" + CHR(231) + "a-feira"
            .Value     = 0
            .Top       = 244
            .Left      = 377
            .Width     = 71
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkEntrega04 (chk_4c_ChkEntrega04 - Quarta-feira): Top=215+29=244, Left=467
        loc_oPagina.AddObject("chk_4c_ChkEntrega04", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkEntrega04
            .Caption   = "Quarta-feira"
            .Value     = 0
            .Top       = 244
            .Left      = 467
            .Width     = 78
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkEntrega05 (chk_4c_ChkEntrega05 - Quinta-feira): Top=235+29=264, Left=179
        loc_oPagina.AddObject("chk_4c_ChkEntrega05", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkEntrega05
            .Caption   = "Quinta-feira"
            .Value     = 0
            .Top       = 264
            .Left      = 179
            .Width     = 76
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkEntrega06 (chk_4c_ChkEntrega06 - Sexta-feira): Top=235+29=264, Left=271
        loc_oPagina.AddObject("chk_4c_ChkEntrega06", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkEntrega06
            .Caption   = "Sexta-feira"
            .Value     = 0
            .Top       = 264
            .Left      = 271
            .Width     = 72
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkEntregaSa (chk_4c_ChkEntregaSa - Sabados): Top=235+29=264, Left=377
        loc_oPagina.AddObject("chk_4c_ChkEntregaSa", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkEntregaSa
            .Caption   = "S" + CHR(225) + "bados"
            .Value     = 0
            .Top       = 264
            .Left      = 377
            .Width     = 59
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkEntregaFe (chk_4c_ChkEntregaFe - Feriados): Top=235+29=264, Left=467
        loc_oPagina.AddObject("chk_4c_ChkEntregaFe", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkEntregaFe
            .Caption   = "Feriados"
            .Value     = 0
            .Top       = 264
            .Left      = 467
            .Width     = 59
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles do container,
    * percorrendo recursivamente Containers e Pages de PageFrames aninhados
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores da Page2 (Form) para o Business Object
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        loc_oBO.this_cCodigo         = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        loc_oBO.this_cDescricao      = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        loc_oBO.this_lEntregaDomingo = loc_oPagina.chk_4c_ChkEntregaDo.Value
        loc_oBO.this_lEntregaSegunda = loc_oPagina.chk_4c_ChkEntrega02.Value
        loc_oBO.this_lEntregaTerca   = loc_oPagina.chk_4c_ChkEntrega03.Value
        loc_oBO.this_lEntregaQuarta  = loc_oPagina.chk_4c_ChkEntrega04.Value
        loc_oBO.this_lEntregaQuinta  = loc_oPagina.chk_4c_ChkEntrega05.Value
        loc_oBO.this_lEntregaSexta   = loc_oPagina.chk_4c_ChkEntrega06.Value
        loc_oBO.this_lEntregaSabado  = loc_oPagina.chk_4c_ChkEntregaSa.Value
        loc_oBO.this_lEntregaFeriado = loc_oPagina.chk_4c_ChkEntregaFe.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do Business Object para a Page2 (Form)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        loc_oPagina.txt_4c_Codigo.Value      = loc_oBO.this_cCodigo
        loc_oPagina.txt_4c_Descricao.Value   = loc_oBO.this_cDescricao
        loc_oPagina.chk_4c_ChkEntregaDo.Value = loc_oBO.this_lEntregaDomingo
        loc_oPagina.chk_4c_ChkEntrega02.Value = loc_oBO.this_lEntregaSegunda
        loc_oPagina.chk_4c_ChkEntrega03.Value = loc_oBO.this_lEntregaTerca
        loc_oPagina.chk_4c_ChkEntrega04.Value = loc_oBO.this_lEntregaQuarta
        loc_oPagina.chk_4c_ChkEntrega05.Value = loc_oBO.this_lEntregaQuinta
        loc_oPagina.chk_4c_ChkEntrega06.Value = loc_oBO.this_lEntregaSexta
        loc_oPagina.chk_4c_ChkEntregaSa.Value = loc_oBO.this_lEntregaSabado
        loc_oPagina.chk_4c_ChkEntregaFe.Value = loc_oBO.this_lEntregaFeriado
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos da Page2
    * Codigo (PK) so eh editavel em INCLUIR/BUSCAR (equivalente ao When do
    * getCods no legado: InList(pcEscolha,[INSERIR],[PROCURAR]))
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPagina.txt_4c_Codigo.Enabled      = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
            loc_oPagina.txt_4c_Descricao.Enabled   = par_lHabilitar
            loc_oPagina.chk_4c_ChkEntregaDo.Enabled = par_lHabilitar
            loc_oPagina.chk_4c_ChkEntrega02.Enabled = par_lHabilitar
            loc_oPagina.chk_4c_ChkEntrega03.Enabled = par_lHabilitar
            loc_oPagina.chk_4c_ChkEntrega04.Enabled = par_lHabilitar
            loc_oPagina.chk_4c_ChkEntrega05.Enabled = par_lHabilitar
            loc_oPagina.chk_4c_ChkEntrega06.Enabled = par_lHabilitar
            loc_oPagina.chk_4c_ChkEntregaSa.Enabled = par_lHabilitar
            loc_oPagina.chk_4c_ChkEntregaFe.Enabled = par_lHabilitar
        CATCH TO loException
            MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, "FormSto.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os valores dos campos da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPagina.txt_4c_Codigo.Value       = ""
            loc_oPagina.txt_4c_Descricao.Value    = ""
            loc_oPagina.chk_4c_ChkEntregaDo.Value = 0
            loc_oPagina.chk_4c_ChkEntrega02.Value = 0
            loc_oPagina.chk_4c_ChkEntrega03.Value = 0
            loc_oPagina.chk_4c_ChkEntrega04.Value = 0
            loc_oPagina.chk_4c_ChkEntrega05.Value = 0
            loc_oPagina.chk_4c_ChkEntrega06.Value = 0
            loc_oPagina.chk_4c_ChkEntregaSa.Value = 0
            loc_oPagina.chk_4c_ChkEntregaFe.Value = 0
        CATCH TO loException
            MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, "FormSto.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta botoes Confirmar/Cancelar conforme o modo
    * atual (VISUALIZAR desabilita Confirmar - somente leitura)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao

        TRY
            loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

            DO CASE
                CASE THIS.this_cModoAtual = "VISUALIZAR"
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                OTHERWISE
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDCASE
        CATCH TO loException
            MostrarErro("Erro ao ajustar bot" + CHR(245) + "es por modo:" + CHR(13) + loException.Message, "FormSto.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara o form para inclusao de novo Status de Operacao
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao incluir Status de Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "FormSto.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre o registro selecionado no Grid em modo somente
    * leitura (equivalente a ChkDtvalid('Leitura') + Salva.SetFocus do legado)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao visualizar Status de Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "FormSto.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre o registro selecionado no Grid para edicao
    * (equivalente a ChkDtvalid('Leitura') + getDescs.SetFocus do legado)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alterar Status de Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "FormSto.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o Status de Operacao selecionado no Grid,
    * apos confirmacao do usuario
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do Status de Opera" + CHR(231) + CHR(227) + "o " + loc_cCodigo + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Status de Opera" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir Status de Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "FormSto.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para procurar um Status de
    * Operacao pelo codigo/descricao e posiciona o Grid da Lista no registro
    * localizado (equivalente ao msv_procurar/LocateCursor do legado)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdSts", "cursor_4c_BuscaSto", "cods", loc_cCodigo, ;
                "Buscar Status de Opera" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSto")
                    SELECT cursor_4c_BuscaSto
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaSto.cods)
                    *-- Posicionar grid na linha correspondente
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cursor_4c_Dados.cods) = loc_cCodigo
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaSto")
                USE IN cursor_4c_BuscaSto
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormSto.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaSto")
                USE IN cursor_4c_BuscaSto
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro("Erro em FormSto.BtnEncerrarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida (via BO.ValidarDados, chamado dentro de Salvar())
    * e grava o Status de Operacao (INSERT ou UPDATE conforme this_lNovoRegistro)
    * Equivalente ao Pagina.Dados.Grupo_Salva.Salva.Click do legado
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgSucesso("Status de Opera" + CHR(231) + CHR(227) + "o salvo com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro)
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar Status de Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "FormSto.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela a edicao/inclusao/visualizacao e retorna
    * para a Page1 (Lista), recarregando os dados do Grid
    * Equivalente ao Pagina.Dados.Grupo_Salva.Cancelar.Click do legado
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro("Erro em FormSto.BtnCancelarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Destroy - Libera cursores abertos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loException
            *-- Ignorar erros na destruicao
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE

