*==============================================================================
* FormSigPrCtc.prg - Formulario de Cotacoes por Operacoes
* Origem legada: SIGPRCTC.SCX (dialogo modal chamado por SIGPRCPR/SIGPRCIC)
* Migrado como CRUD-style com PageFrame (Page1=Lista, Page2=Dados)
* Herda de: FormBase
* Fase 7/8: Form completo - estrutura, grid, campos, lookups e eventos CRUD
*==============================================================================

DEFINE CLASS FormSigPrCtc AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 384
    Width       = 550
    Caption     = "Cota" + CHR(231) + CHR(245) + "es por Opera" + CHR(231) + CHR(245) + "es"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(100, 100, 100)
    KeyPreview  = .T.
    Picture     = "..\framework\imagens\new_background.jpg"

    *-- Propriedades internas do form
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"     && LISTA / INCLUIR / ALTERAR / VISUALIZAR
    this_cMensagemErro   = ""

    *-- Parametros recebidos do form pai (fluxo modal legado)
    this_oParentForm     = .NULL.
    this_cEmpDopNums     = ""          && pcEmps + pcDopes + STR(pnNumes,6)
    this_cEscolha        = ""          && permissoes: INSERIR / ALTERAR / EXCLUIR
    this_lHouveInsercao  = .F.
    this_lHouveExclusao  = .F.

    *--------------------------------------------------------------------------
    * Init - Apenas delega para FormBase (que chama InicializarForm)
    * Parametros opcionais para chamada modal a partir de outros forms:
    *   par_oParentForm : referencia ao form chamador (sera desabilitado)
    *   par_cEscolha    : permissoes de INSERIR/ALTERAR/EXCLUIR
    *   par_cEmps       : codigo da empresa
    *   par_cDopes      : codigo da operacao (tipo)
    *   par_nNumes      : numero da operacao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_cEscolha, par_cEmps, par_cDopes, par_nNumes

        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
                par_oParentForm.Enabled = .F.
            ENDIF

            IF VARTYPE(par_cEscolha) = "C"
                THIS.this_cEscolha = ALLTRIM(par_cEscolha)
            ENDIF

            IF VARTYPE(par_cEmps) = "C" AND VARTYPE(par_cDopes) = "C" AND VARTYPE(par_nNumes) = "N"
                THIS.this_cEmpDopNums = ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)
                THIS.Caption = "Cota" + CHR(231) + CHR(245) + "es " + ;
                               ALLTRIM(PROPER(THIS.this_cEmpDopNums))
            ENDIF

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtc.Init:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e monta estrutura visual completa
    * Chamado por FormBase.Init() via DODEFAULT()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtcBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrCtcBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ControlarBotoesPorEscolha()

                *-- Carrega dados na grade (CarregarLista() trata gb_4c_ValidandoUI internamente)
                THIS.CarregarLista()

                *-- Propaga Caption para labels do cabecalho (fase 4 cria os labels)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Cabecalho", 5)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                SET DATE TO BRITISH
                SET CENTURY ON

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 631
            .Tabs      = .F.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria containers vazios da Page1 (Lista)
    * cnt_4c_Cabecalho: barra cinza superior com titulo
    * cnt_4c_Botoes   : container de botoes CRUD (populado na Fase 4)
    * cnt_4c_Saida    : container flutuante do botao Encerrar
    * Grid e botoes CRUD sao adicionados na Fase 4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container do cabecalho (cntSombra: Top=2+29, W=THIS.Width, H=80)
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
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0+29)
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

        *-- Container de saida canonico (cnt_4c_Saida)
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

        *-- Botao Encerrar no container cnt_4c_Saida (canonico)
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

        *-- Botoes CRUD em cnt_4c_Botoes
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

        *-- Grid grd_4c_Dados (GradeSubN legado: Top=110, Left=85, Width=379 em form 550px)
        *-- Adaptado para form 1000px: Top=117 (+29 compensacao PageFrame), Left=12, Width=890
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados
        loc_oGrid.Top                = 117
        loc_oGrid.Left               = 12
        loc_oGrid.Width              = 890
        loc_oGrid.Height             = 498
        loc_oGrid.ColumnCount        = 3
        loc_oGrid.GridLines          = 3
        loc_oGrid.FontName           = "Verdana"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ForeColor          = RGB(90, 90, 90)
        loc_oGrid.BackColor          = RGB(255, 255, 255)
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark         = .F.
        loc_oGrid.RecordMark         = .F.
        loc_oGrid.RowHeight          = 16
        loc_oGrid.ScrollBars         = 2
        loc_oGrid.Visible            = .T.

        WITH loc_oGrid.Column1
            .Width           = 100
            .Header1.Caption = "Moeda"
        ENDWITH

        WITH loc_oGrid.Column2
            .Width           = 550
            .ReadOnly        = .T.
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        WITH loc_oGrid.Column3
            .Width           = 200
            .ReadOnly        = .T.
            .Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
        ENDWITH

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria containers vazios da Page2 (Dados)
    * cnt_4c_Cabecalho: barra cinza superior com titulo
    * cnt_4c_BotoesAcao: container de botoes Confirmar/Cancelar (Fase 4)
    * TextBoxes/grid de detalhe sao adicionados nas Fases 5-6
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container do cabecalho da Page2 (mesmo layout da Page1)
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
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes de acao (Confirmar/Cancelar)
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

        *-- Primeiros 50% dos campos: Moeda (cmoes) e Descricao (Descrs)

        *-- Campo Moeda
        loc_oPagina.AddObject("lbl_4c_LblMoeda", "Label")
        WITH loc_oPagina.lbl_4c_LblMoeda
            .AutoSize  = .F.
            .Caption   = "Moeda :"
            .Top       = 133
            .Left      = 40
            .Width     = 100
            .Height    = 17
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cmoes", "TextBox")
        WITH loc_oPagina.txt_4c_Cmoes
            .Value     = ""
            .Top       = 130
            .Left      = 150
            .Width     = 120
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- Campo Descricao (read-only, preenchido automaticamente pelo lookup de moeda)
        loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
        WITH loc_oPagina.lbl_4c_LblDescrs
            .AutoSize  = .F.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 168
            .Left      = 40
            .Width     = 100
            .Height    = 17
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value     = ""
            .Top       = 165
            .Left      = 150
            .Width     = 400
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Campo Cotacao (valos - numerico 11,6 - equivalente Column3 do grid original)
        loc_oPagina.AddObject("lbl_4c_LblValos", "Label")
        WITH loc_oPagina.lbl_4c_LblValos
            .AutoSize  = .F.
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
            .Top       = 203
            .Left      = 40
            .Width     = 100
            .Height    = 17
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valos", "TextBox")
        WITH loc_oPagina.txt_4c_Valos
            .Value     = 0
            .Top       = 200
            .Left      = 150
            .Width     = 200
            .Height    = 23
            .InputMask = "99999.9999999"
            .Format    = "K"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT: lookup de moeda em txt_4c_Cmoes (F4, DblClick, LostFocus)
        BINDEVENT(loc_oPagina.txt_4c_Cmoes, "KeyPress",  THIS, "CmoesLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Cmoes, "DblClick",  THIS, "CmoesLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Cmoes, "KeyPress", THIS, "CmoesLostFocus")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos, cursores locais e re-habilita o form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
            IF USED("cursor_4c_Totais")
                USE IN cursor_4c_Totais
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
                THIS.this_oParentForm = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Destroy:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
                        TRANSFORM(par_nPagina), "Erro")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega cursor local e configura grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF EMPTY(THIS.this_cEmpDopNums)
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.CarregarParaEdicao(THIS.this_cEmpDopNums)
                loc_lResultado = .T.
                ENDIF
                ENDIF
            ENDIF

            IF loc_lResultado AND USED("cursor_4c_Dados")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 3

                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.cmoes"
                    .Column1.Width           = 100
                    .Column1.Header1.Caption = "Moeda"

                    .Column2.ControlSource   = "cursor_4c_Dados.Descrs"
                    .Column2.Width           = 550
                    .Column2.ReadOnly        = .T.
                    .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    .Column3.ControlSource   = "cursor_4c_Dados.valos"
                    .Column3.Width           = 200
                    .Column3.ReadOnly        = .T.
                    .Column3.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                THIS.AjustarBotoesPorModo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * FormatarGridLista - Formata visual do grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * Handlers dos botoes CRUD (PUBLIC para BINDEVENT funcionar)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Insere nova linha vazia no cursor local
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_oBusinessObject.InserirLinhaLocal(THIS.this_cEmpDopNums)
                SELECT cursor_4c_Dados
                GO BOTTOM
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.LimparCampos()
                THIS.HabilitarCampos(.T.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnIncluirClick")
        ENDTRY

        IF loc_lSucesso
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Navega para Page2 exibindo dados da linha selecionada
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
           !DELETED("cursor_4c_Dados")
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Nenhum registro selecionado para visualizar.", "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Posiciona foco no grid para edicao inline
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
           !DELETED("cursor_4c_Dados")
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Nenhum registro selecionado para alterar.", "Alterar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui linha corrente do cursor local
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado para excluir.", "Excluir")
            ELSE
                IF MsgConfirma("Deseja excluir a cota" + CHR(231) + CHR(227) + ;
                               "o selecionada?", ;
                               "Confirmar Exclus" + CHR(227) + "o")
                IF THIS.this_oBusinessObject.ExcluirLinhaLocal()
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre picker de moeda e posiciona no grid
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCmoes
        loc_cCmoes = ""

        TRY
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdMoe", "cursor_4c_BuscaMoeda", ;
                            "cmoes", "", "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    loc_cCmoes = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnBuscarClick")
        ENDTRY

        IF !EMPTY(loc_cCmoes) AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(UPPER(cmoes)) == UPPER(loc_cCmoes) AND !DELETED()
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Valida, salva cotacoes e fecha o formulario
    * Equivalente ao cmdSair.Click do legado (SIGPRCTC)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lPodeSair, loc_lHouveAlteracao
        loc_lPodeSair       = .F.
        loc_lHouveAlteracao = THIS.this_oBusinessObject.this_lHouveInsercao OR ;
                              THIS.this_oBusinessObject.this_lHouveExclusao

        TRY
            IF loc_lHouveAlteracao
                IF THIS.this_oBusinessObject.SalvarCotacoes(THIS.this_cEmpDopNums)
                    THIS.this_lHouveInsercao = THIS.this_oBusinessObject.this_lHouveInsercao
                    THIS.this_lHouveExclusao = THIS.this_oBusinessObject.this_lHouveExclusao
                    loc_lPodeSair = .T.
                ENDIF
            ELSE
                loc_lPodeSair = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnEncerrarClick")
        ENDTRY

        IF loc_lPodeSair
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Valida moeda ao sair da Coluna 1
    * par_nColIndex: coluna ANTERIOR (ativa antes da mudanca de coluna)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_cCmoes
        loc_cCmoes = ""

        TRY
            IF par_nColIndex = 1 AND USED("cursor_4c_Dados") AND ;
               !EOF("cursor_4c_Dados") AND !DELETED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCmoes = ALLTRIM(cmoes)
                IF EMPTY(loc_cCmoes)
                    REPLACE Descrs WITH SPACE(15)
                ELSE
                    THIS.AbrirBuscaMoeda(loc_cCmoes)
                ENDIF
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro GrdDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - Valida codigo ou abre picker para selecao de moeda
    * Equivalente ao Valid do Column1.Text1 do legado (fwbuscaext -> SigCdMoe)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoeda(par_cValor)
        LOCAL loc_oBusca, loc_cCmoes, loc_cDescrs
        loc_cCmoes  = ""
        loc_cDescrs = ""

        TRY
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdMoe", "cursor_4c_BuscaMoeda", ;
                            "cmoes", ALLTRIM(par_cValor), "Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaMoeda")
                        SELECT cursor_4c_BuscaMoeda
                        loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                        loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                        SELECT cursor_4c_BuscaMoeda
                        loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                        loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AbrirBuscaMoeda")
        ENDTRY

        IF !EMPTY(loc_cCmoes) AND USED("cursor_4c_Dados") AND ;
           !EOF("cursor_4c_Dados") AND !DELETED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            REPLACE cmoes  WITH PADR(loc_cCmoes,  3)
            REPLACE Descrs WITH PADR(loc_cDescrs, 15)
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Persiste campos da Page2 no cursor local e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cCmoes, loc_nValos, loc_oPg2
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes = ""
        loc_nValos = 0

        *-- Em modo visualizar, apenas volta para lista (botao vira "Fechar")
        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
            loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
            loc_nValos = loc_oPg2.txt_4c_Valos.Value
        ENDIF

        IF EMPTY(loc_cCmoes)
            MsgAviso("C" + CHR(243) + "digo da moeda obrigat" + CHR(243) + "rio.", "Salvar")
        ELSE
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
               !DELETED("cursor_4c_Dados")
            THIS.FormParaBO()
            THIS.this_oBusinessObject.this_lHouveInsercao = .T.
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista sem salvar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega linha corrente do cursor local nos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cCmoes, loc_cDescrs, loc_nValos
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes  = ""
        loc_cDescrs = ""
        loc_nValos  = 0

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
               !DELETED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCmoes  = ALLTRIM(NVL(cmoes,  ""))
                loc_cDescrs = ALLTRIM(NVL(Descrs, ""))
                loc_nValos  = NVL(valos, 0)
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_oPg2.txt_4c_Cmoes.Value = loc_cCmoes
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
                loc_oPg2.txt_4c_Descrs.Value = loc_cDescrs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
                loc_oPg2.txt_4c_Valos.Value = loc_nValos
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere campos editados da Page2 de volta para cursor local
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_cCmoes, loc_nValos
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes = ""
        loc_nValos = 0

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
                loc_nValos = loc_oPg2.txt_4c_Valos.Value
            ENDIF

            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
               !DELETED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                REPLACE cmoes WITH PADR(loc_cCmoes, 3), valos WITH loc_nValos
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmoesLookupKeyPress - Handler de KeyPress do txt_4c_Cmoes (Page2)
    * Abre picker de moeda ao pressionar F4 (keycode 28)
    *--------------------------------------------------------------------------
    PROCEDURE CmoesLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirBuscaMoedaPage2()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmoesLookupDblClick - Handler de DblClick do txt_4c_Cmoes (Page2)
    *--------------------------------------------------------------------------
    PROCEDURE CmoesLookupDblClick()
        THIS.AbrirBuscaMoedaPage2()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmoesLostFocus - Handler de LostFocus do txt_4c_Cmoes (Page2)
    * Valida o codigo digitado e atualiza descricao; se vazio, limpa descricao
    *--------------------------------------------------------------------------
    PROCEDURE CmoesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCmoes
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
            ENDIF

            IF EMPTY(loc_cCmoes)
                IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
                    loc_oPg2.txt_4c_Descrs.Value = ""
                ENDIF
            ELSE
                THIS.AbrirBuscaMoedaPage2()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CmoesLostFocus:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoedaPage2 - Valida/busca moeda e preenche campos na Page2
    * Equivalente ao Valid de GradeSubN.Column1.Text1 do SIGPRCTC original
    * adaptado para uso em Page2 (fora do grid)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoedaPage2()
        LOCAL loc_oPg2, loc_cCmoes, loc_oBusca, loc_cDescrs, loc_lExecutar
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes    = ""
        loc_cDescrs   = ""
        loc_lExecutar = .F.

        IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
            loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
        ENDIF

        IF !EMPTY(loc_cCmoes)
            loc_lExecutar = .T.
        ENDIF

        IF loc_lExecutar
            TRY
                IF USED("cursor_4c_BuscaMoeda")
                    USE IN cursor_4c_BuscaMoeda
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                "SigCdMoe", "cursor_4c_BuscaMoeda", ;
                                "cmoes", loc_cCmoes, "Moeda")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                        IF USED("cursor_4c_BuscaMoeda")
                            SELECT cursor_4c_BuscaMoeda
                            loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                            loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                            SELECT cursor_4c_BuscaMoeda
                            loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                            loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                        ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro em AbrirBuscaMoedaPage2:" + CHR(13) + loc_oErro.Message + ;
                        " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
            ENDTRY

            IF !EMPTY(loc_cCmoes) AND PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_oPg2.txt_4c_Cmoes.Value = loc_cCmoes
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
                loc_oPg2.txt_4c_Descrs.Value = loc_cDescrs
            ENDIF

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_oPg2.txt_4c_Cmoes.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
                loc_oPg2.txt_4c_Descrs.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
                loc_oPg2.txt_4c_Valos.Value = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    * par_lHabilitar: .T. = editar (INCLUIR/ALTERAR), .F. = somente leitura (VISUALIZAR)
    * Em VISUALIZAR: muda botao Confirmar para "Fechar" com icone de saida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_oPg2.txt_4c_Cmoes.Enabled   = par_lHabilitar
                loc_oPg2.txt_4c_Cmoes.BackColor = IIF(par_lHabilitar, ;
                                                       RGB(255,255,255), RGB(240,240,240))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
                loc_oPg2.txt_4c_Valos.Enabled   = par_lHabilitar
                loc_oPg2.txt_4c_Valos.BackColor = IIF(par_lHabilitar, ;
                                                       RGB(255,255,255), RGB(240,240,240))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    IF par_lHabilitar
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Confirmar"
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Picture = ;
                            gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    ELSE
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Fechar"
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Picture = ;
                            gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme estado do cursor
    * Chamado apos CarregarLista() para refletir se ha registros selecionaveis
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lTemRegistro, loc_lPodeInserir, loc_lPodeExcluir
        loc_oPg1         = THIS.pgf_4c_Paginas.Page1
        loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
                           RECCOUNT("cursor_4c_Dados") > 0
        loc_lPodeInserir = .T.
        loc_lPodeExcluir = .T.

        TRY
            IF !EMPTY(THIS.this_cEscolha)
                loc_lPodeInserir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
                loc_lPodeExcluir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
            ENDIF

            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = loc_lPodeInserir
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro AND loc_lPodeExcluir
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ControlarBotoesPorEscolha - Exibe/oculta Incluir e Excluir conforme pcEscolha
    * Equivalente ao mCtrlBotoes + fChecaAcesso do SIGPRCTC original:
    * Se pcEscolha = 'INSERIR' ou 'ALTERAR': mostra Incluir e Excluir
    * Se pcEscolha = 'EXCLUIR' ou outro: oculta ambos
    * Se pcEscolha = '' (nao fornecido): mostra ambos (modo standalone)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ControlarBotoesPorEscolha()
        LOCAL loc_oPg1, loc_lPodeInserir, loc_lPodeExcluir
        loc_oPg1         = THIS.pgf_4c_Paginas.Page1
        loc_lPodeInserir = .T.
        loc_lPodeExcluir = .T.

        TRY
            IF !EMPTY(THIS.this_cEscolha)
                loc_lPodeInserir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), ;
                                          "INSERIR", "ALTERAR")
                loc_lPodeExcluir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), ;
                                          "INSERIR", "ALTERAR")
            ENDIF

            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Visible = loc_lPodeInserir
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = loc_lPodeInserir
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Visible = loc_lPodeExcluir
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lPodeExcluir
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ControlarBotoesPorEscolha:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
