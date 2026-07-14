*==============================================================================
* FORMSIGREESP.PRG
* Relatorio de Estatistica de Pedidos
* Herda de FormBase
* Migrado de: SigReEsp.SCX (frmrelatorio)
* Layout: FLAT (sem PageFrame de lista+dados - todos os controles direto no form)
*
* Fase 3/8: Estrutura base - Init, InicializarForm, Cabecalho, Botoes, Destroy
* Fase 4: grdOperacoes + cmdBtnGradeS + CarregarOperacoes
* Fases 5-6: controles de filtro (TextBox, OptionGroup, ComboBox, CheckBox)
* Fases 7-8: FormParaRelatorio, LimparCampos, eventos de lookup (KeyPress/LostFocus)
*==============================================================================

DEFINE CLASS FormSigReEsp AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SCX)
    Height      = 420
    Width       = 810
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- BO do relatorio (relatorios usam this_oRelatorio, nao this_oBusinessObject)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *==========================================================================
    * INIT - Delegado ao FormBase, que chama THIS.InicializarForm()
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * INICIALIZARFORM - Cria todos os controles visuais do form
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gc_4c_CaminhoIcones") != "C"
                gc_4c_CaminhoIcones = ""
            ENDIF

            THIS.Caption = "Estat" + CHR(237) + "stica de Pedidos"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Instanciar BO do relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReEspBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                THIS.this_cMensagemErro = "Falha ao criar SigReEspBO (VARTYPE=" + ;
                    VARTYPE(THIS.this_oRelatorio) + ")"
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor placeholder para grdOperacoes (cria estrutura vazia)
            *-- Equivalente ao "Create Cursor crOperacoes" do Init() legado
            THIS.CriarCursorOperacoes()

            *-- Cabecalho escuro com titulo (padrao frmrelatorio - cntSombra)
            THIS.ConfigurarCabecalho()

            *-- CommandGroup de 4 botoes de relatorio (padrao framework.vcx - btnReport)
            THIS.ConfigurarBotoes()

            *-- PageFrame com 1 pagina (Filtros) - container dos controles abaixo do cabecalho
            THIS.ConfigurarPageFrame()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Page1: grid de selecao de tipos de operacao + botoes Sel/Des todos
            *-- (em forms REPORT, ConfigurarPaginaLista monta a "pagina de selecao" -
            *--  equivalente ao papel da Page1/Lista em forms CRUD)
            THIS.ConfigurarPaginaLista()

            *-- Controles de filtro - primeira metade (Periodo, Operacao, Tipo, Conta, Vendedor)
            THIS.ConfigurarPaginaDados()

            *-- Carregar tipos de operacao via SQL (pular em modo validacao UI)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarOperacoes()
            ENDIF

            *-- Tornar form visivel
            THIS.Visible = .T.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "InicializarForm - FormSigReEsp")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGEFRAME - PageFrame com 2 paginas (Filtros / Dados)
    *
    *   O SCX legado SIGREESP eh FLAT mas no novo padrao do sistema os
    *   controles abaixo do cabecalho ficam encapsulados num PageFrame com
    *   PageCount=2 para consistencia com o ciclo de navegacao do FormBase
    *   (Page1 = "lista" / filtros, Page2 = "dados" reservado para extensoes).
    *
    *   Geometria: inicia logo abaixo do cabecalho (Top=80), ocupa toda a
    *   largura do form e o espaco restante na altura. Tabs ocultos (Tabs=.F.)
    *   - a navegacao eh feita via AlternarPagina().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
        loc_oPgf.PageCount = 2

        loc_oPgf.Top    = 80
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 80
        loc_oPgf.Tabs   = .F.

        *-- Page1 = "Filtros" (lista de selecao + filtros)
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Page2 = "Dados" (reservada - frmrelatorio nao usa, mantida para
        *--                  compatibilidade com o ciclo padrao do FormBase)
        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *==========================================================================
    * CRIARCURSOROPERACOES - Cria cursor vazio de tipos de operacao
    * Espelha o "Create Cursor crOperacoes" do Init() original + Index
    * Fase 4 ira popular com dados do SQL Server (SigCdTom) e configurar grid
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorOperacoes()
        IF USED("crOperacoes")
            USE IN crOperacoes
        ENDIF
        CREATE CURSOR crOperacoes (SelImp L(1), Codigos N(2), Descrs C(30), SelImp2 L(1), SelImp3 L(1))
        INDEX ON Codigos TAG Codigos
    ENDPROC

    *==========================================================================
    * CONFIGURARCABECALHO - Cabecalho escuro com titulo
    * Equivalente a cntSombra do framework.vcx
    * BackColor=RGB(100,100,100), Width=THIS.Width (nao subtrair!)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible    = .T.

            *-- Sombra preta (deslocada 3px para efeito de profundidade)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 12
                .Width     = THIS.Width
                .Height    = 46
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo branco (sobre o fundo cinza escuro)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CONFIGURARBOTOES - CommandGroup com 4 botoes canonicos de relatorio
    * Geometria EXATA do framework.vcx (prevalece sobre SCX original):
    *   cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80
    *   Botoes: Width=65, Height=70, Lefts=5,71,137,203
    * Imagens: ideo.jpg / impressora.jpg / excel.jpg / otao_encerrar.jpg
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "DocExcel"
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Sair"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH
        ENDWITH

        *-- BINDEVENT em Buttons(N) - metodos PUBLIC obrigatorio
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * ATUALIZARESTADOCONTROLES - Override: relatorio nao tem estado CRUD
    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Exibe relatorio em preview na tela
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao visualizar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNIMPRIMIRCLICK - Imprime relatorio sem dialogo de impressora
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao imprimir")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNDOCEXCELCLICK - Imprime com selecao de impressora (dialogo)
    *==========================================================================
    PROCEDURE BtnDocExcelClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.ImprimirComPrompt()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao imprimir")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNSAIRCLICK - Fecha o formulario (Cancel=.T. no Buttons(4) cobre ESC)
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNINCLUIRCLICK - Override no-op: form REPORT nao tem operacao Incluir
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        RETURN
    ENDPROC

    *==========================================================================
    * BTNALTERARCLICK - Override no-op: form REPORT nao tem operacao Alterar
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *==========================================================================
    * BTNEXCLUIRCLICK - Override no-op: form REPORT nao tem operacao Excluir
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *==========================================================================
    * ALTERNARPAGINA - Navega para a pagina solicitada no PageFrame
    *   Form REPORT possui PageCount=2; navega apenas se o indice for valido
    *   (1..PageCount). Usado pelo ciclo padrao do FormBase (BtnIncluir/Cancelar).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
           VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINALISTA - Monta a Page1 (lista de selecao do relatorio)
    *
    *   Em forms REPORT, a "pagina de lista" corresponde aa pagina de filtros
    *   contendo o grid de selecao + botoes Selecionar/Desmarcar todos.
    *   Equivale aa Page1/Lista de forms CRUD (carrega grid + botoes associados).
    *
    *   Coordenadas internas da Page1 = coordenadas originais - 80 (PageFrame
    *   inicia em Top=80, entao Top_Page1 = Top_original - 80).
    *
    *   Componentes adicionados:
    *     - grd_4c_Operacoes  : grid 5 colunas (M/Codigos/Descrs/E/C)
    *       Top original=290 -> Top_Page1=210
    *     - cmg_4c_GradeS     : CommandGroup 2 botoes (Sel./Des. todos)
    *       Top original=300 -> Top_Page1=220
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid

        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- ========================== GRID grd_4c_Operacoes ==========================
        loc_oPagina.AddObject("grd_4c_Operacoes", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Operacoes

        *-- ColumnCount ANTES de configurar colunas (cria Column1..ColumnN)
        loc_oGrid.ColumnCount = 5

        WITH loc_oGrid
            .Top                = 210
            .Left               = 439
            .Width              = 309
            .Height             = 115
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .FontName           = "Verdana"
            .FontSize           = 8
            .ScrollBars         = 2
            .RowHeight          = 16
        ENDWITH

        *-- Coluna 1: CheckBox para SelImp (selecao principal - Header "M")
        *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS
        WITH loc_oGrid.Column1
            .Width = 22
            .Sparse    = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Value   = 0
            .CurrentControl = "Check1"
            .ControlSource  = "crOperacoes.SelImp"
            .Check1.Visible = .T.
        ENDWITH

        *-- Coluna 2: Codigos (somente leitura)
        WITH loc_oGrid.Column2
            .Width         = 30
            .ControlSource = "crOperacoes.Codigos"
            .ReadOnly      = .T.
        ENDWITH

        *-- Coluna 3: Descricao - Movimentacoes (somente leitura)
        WITH loc_oGrid.Column3
            .Width         = 185
            .ControlSource = "crOperacoes.Descrs"
            .ReadOnly      = .T.
        ENDWITH

        *-- Coluna 4: CheckBox para SelImp2 (Header "E")
        WITH loc_oGrid.Column4
            .Width = 37
            .Sparse    = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Value   = 0
            .CurrentControl = "Check1"
            .ControlSource  = "crOperacoes.SelImp2"
            .Check1.Visible = .T.
        ENDWITH

        *-- Coluna 5: CheckBox para SelImp3 (Header "C")
        WITH loc_oGrid.Column5
            .Width = 35
            .Sparse    = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Value   = 0
            .CurrentControl = "Check1"
            .ControlSource  = "crOperacoes.SelImp3"
            .Check1.Visible = .T.
        ENDWITH

        *-- RecordSource APOS configurar colunas (RecordSource reseta headers)
        loc_oGrid.RecordSource = "crOperacoes"

        *-- Reconfigurar Headers APOS RecordSource (OBRIGATORIO)
        loc_oGrid.Column1.Header1.Caption = "M"
        loc_oGrid.Column2.Header1.Caption = ""
        loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
        loc_oGrid.Column4.Header1.Caption = "E"
        loc_oGrid.Column5.Header1.Caption = "C"

        loc_oGrid.Visible = .T.

        *-- KeyPress Enter(13)/Espaco(32) em Col1.Check1 -> togla SelImp
        BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "GrdOpeCheck1KeyPress")

        *-- ===================== COMMANDGROUP cmg_4c_GradeS ==========================
        *-- Botoes Sel./Des. todos (cmdBtnGradeS do original)
        *-- Top original=300 -> Top_Page1=220, Left=746, Width=50, Height=90
        loc_oPagina.AddObject("cmg_4c_GradeS", "CommandGroup")
        WITH loc_oPagina.cmg_4c_GradeS
            .Top         = 220
            .Left        = 746
            .Width       = 50
            .Height      = 90
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Top      = 0
                .Left     = 0
                .Width    = 50
                .Height   = 45
                .Caption  = "Sel."
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Themes   = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top      = 45
                .Left     = 0
                .Width    = 50
                .Height   = 45
                .Caption  = "Des."
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .Themes   = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cmg_4c_GradeS, "Click", THIS, "BtnGradeSClick")
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADOS - Fase 5/8: primeiros 50% dos controles de filtro
    *   Linha 1: Periodo (datas inicial/final + opcoes tipo periodo)
    *   Linha 2: Movimentacao (codigo operacao + numero pedido)
    *   Linha 3: Tipo de Operacao (codigo + descricao)
    *   Linha 4: Conta/Estoque (codigo + descricao)
    *   Linha 5: Vendedor (codigo + descricao)
    *
    *   Todos os controles vao em Page1 (form relatorio = layout flat).
    *   Coordenadas: Top_Page1 = Top_original - 80 (PageFrame.Top=80)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina

        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- ===========================================================
        *-- LINHA 1: Periodo / Datas / Tipo de periodo
        *-- ===========================================================

        *-- Label "Periodo :" (lbl_periodo - TabIndex=1)
        *-- Top original=97 -> Top_Page1=17
        loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_periodo
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 47
            .Top       = 17
            .Width     = 45
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox data inicial (get_dt_inicial - TabIndex=2)
        *-- Top original=92 -> Top_Page1=12
        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 94
            .SpecialEffect = 1
            .Top           = 12
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- Label "ate" (lbl_periodo_a - TabIndex=3)
        loc_oPagina.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_periodo_a
            .AutoSize  = .T.
            .Caption   = "at" + CHR(233)
            .Left      = 188
            .Top       = 17
            .Width     = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox data final (get_dt_final - TabIndex=4)
        *-- Top original=92 -> Top_Page1=12
        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 221
            .SpecialEffect = 1
            .Top           = 12
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- OptionGroup tipo de periodo (Opt_nr_periodo - TabIndex=5)
        *-- Top original=83 -> Top_Page1=3
        *-- ButtonCount=4: Lancamento / Prazo Entrega / Ult. Alteracao / Fechamento
        loc_oPagina.AddObject("obj_4c_OptNrPeriodo", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptNrPeriodo
            .Top           = 3
            .Left          = 306
            .Width         = 200
            .Height        = 41
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .SpecialEffect = 0
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Lan" + CHR(231) + "amento"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 76
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Prazo Entrega"
                .Value     = 0
                .Left      = 100
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o"
                .WordWrap        = .T.
                .Height    = 15
                .Left      = 5
                .Top       = 20
                .Width     = 84
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(4)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Fechamento"
                .WordWrap        = .T.
                .Height    = 15
                .Left      = 100
                .Top       = 20
                .Width     = 88
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- ===========================================================
        *-- LINHA 2: Movimentacao (cod. operacao + numero do pedido)
        *-- ===========================================================

        *-- Label "Movimentacao :" (lbl_dopes - TabIndex=6)
        *-- Top original=124 -> Top_Page1=44
        loc_oPagina.AddObject("lbl_4c_Lbl_dopes", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_dopes
            .AutoSize  = .T.
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Left      = 14
            .Top       = 44
            .Width     = 78
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo da operacao (get_nm_operacao - TabIndex=7)
        *-- Top original=119 -> Top_Page1=39
        loc_oPagina.AddObject("txt_4c__nm_operacao", "TextBox")
        WITH loc_oPagina.txt_4c__nm_operacao
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 0
            .Format        = "K!"
            .Height        = 25
            .Left          = 94
            .MaxLength     = 20
            .SpecialEffect = 1
            .Top           = 39
            .Width         = 150
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = SPACE(20)
            .Visible       = .T.
        ENDWITH

        *-- TextBox numero do pedido (Get_Numero - TabIndex=8)
        loc_oPagina.AddObject("txt_4c_Numero", "TextBox")
        WITH loc_oPagina.txt_4c_Numero
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Format        = "K"
            .Height        = 25
            .InputMask     = "999999"
            .Left          = 246
            .SpecialEffect = 1
            .Top           = 39
            .Width         = 55
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- ===========================================================
        *-- LINHA 3: Tipo de Operacao (codigo + descricao)
        *-- ===========================================================

        *-- Label "Tipo :" (Say6 - TabIndex=9)
        *-- Top original=151 -> Top_Page1=71
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .AutoSize  = .T.
            .Caption   = "Tipo :"
            .Height    = 15
            .Left      = 63
            .Top       = 71
            .Width     = 29
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo tipo de operacao (getCdTpOpe - TabIndex=10)
        *-- Top original=146 -> Top_Page1=66
        loc_oPagina.AddObject("txt_4c_CdTpOpe", "TextBox")
        WITH loc_oPagina.txt_4c_CdTpOpe
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .InputMask     = "99"
            .Left          = 94
            .MaxLength     = 2
            .SpecialEffect = 1
            .Top           = 66
            .Width         = 24
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- TextBox descricao tipo de operacao (getDsTpOpe - TabIndex=11)
        loc_oPagina.AddObject("txt_4c_DsTpOpe", "TextBox")
        WITH loc_oPagina.txt_4c_DsTpOpe
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 120
            .MaxLength     = 30
            .SpecialEffect = 1
            .Top           = 66
            .Width         = 181
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = "TODOS"
            .Visible       = .T.
        ENDWITH

        *-- ===========================================================
        *-- LINHA 4: Conta/Estoque (codigo + descricao)
        *-- ===========================================================

        *-- Label "Conta :" (lbl_estoque - TabIndex=12)
        *-- Top original=178 -> Top_Page1=98
        loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_estoque
            .AutoSize  = .T.
            .Caption   = "Conta :"
            .Left      = 54
            .Top       = 98
            .Width     = 38
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo conta/estoque (getCdEstoque - TabIndex=13)
        *-- Top original=173 -> Top_Page1=93
        loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdEstoque
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 0
            .Format        = "K"
            .Height        = 25
            .Left          = 94
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 93
            .Width         = 79
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = SPACE(10)
            .Visible       = .T.
        ENDWITH

        *-- TextBox descricao conta/estoque (getDsEstoque - TabIndex=14)
        loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsEstoque
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 175
            .MaxLength     = 40
            .SpecialEffect = 1
            .Top           = 93
            .Width         = 300
            .BorderColor   = RGB(100, 100, 100)
            .Value         = SPACE(40)
            .Visible       = .T.
        ENDWITH

        *-- ===========================================================
        *-- LINHA 5: Vendedor (codigo + descricao)
        *-- ===========================================================

        *-- Label "Vendedor :" (Say4 - TabIndex=15)
        *-- Top original=205 -> Top_Page1=125
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .AutoSize  = .T.
            .Caption   = "Vendedor :"
            .Left      = 37
            .Top       = 125
            .Width     = 55
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo vendedor (getCdVendedor - TabIndex=16)
        *-- Top original=200 -> Top_Page1=120
        loc_oPagina.AddObject("txt_4c_CdVendedor", "TextBox")
        WITH loc_oPagina.txt_4c_CdVendedor
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 0
            .Format        = "K"
            .Height        = 25
            .Left          = 94
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 120
            .Width         = 79
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = SPACE(10)
            .Visible       = .T.
        ENDWITH

        *-- TextBox descricao vendedor (getDsVendedor - TabIndex=17)
        loc_oPagina.AddObject("txt_4c_DsVendedor", "TextBox")
        WITH loc_oPagina.txt_4c_DsVendedor
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 175
            .MaxLength     = 40
            .SpecialEffect = 1
            .Top           = 120
            .Width         = 300
            .BorderColor   = RGB(100, 100, 100)
            .Value         = SPACE(40)
            .Visible       = .T.
        ENDWITH

        *-- ===========================================================
        *-- LINHA 6: Cidade / UF (Estado)
        *-- ===========================================================

        *-- Label "Cidade :" (Say2 - Top original=232 -> Top_Page1=152)
        loc_oPagina.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oPagina.lbl_4c_Say2
            .AutoSize  = .T.
            .Caption   = "Cidade :"
            .Left      = 50
            .Top       = 152
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox cidade (Cidade - Top original=227 -> Top_Page1=147)
        loc_oPagina.AddObject("txt_4c_Cidade", "TextBox")
        WITH loc_oPagina.txt_4c_Cidade
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 94
            .MaxLength     = 30
            .SpecialEffect = 1
            .Top           = 147
            .Width         = 207
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = SPACE(30)
            .Visible       = .T.
        ENDWITH

        *-- Label "UF :" (Say3 - Top original=232 -> Top_Page1=152)
        loc_oPagina.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPagina.lbl_4c_Say3
            .AutoSize  = .T.
            .Caption   = "UF :"
            .Left      = 335
            .Top       = 152
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox estado (estado - Top original=227 -> Top_Page1=147)
        loc_oPagina.AddObject("txt_4c_Estado", "TextBox")
        WITH loc_oPagina.txt_4c_Estado
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Height        = 25
            .Left          = 359
            .MaxLength     = 2
            .SpecialEffect = 1
            .Top           = 147
            .Width         = 24
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = SPACE(2)
            .Visible       = .T.
        ENDWITH

        *-- ===========================================================
        *-- LINHA 7: Ordem / Moeda
        *-- ===========================================================

        *-- Label "Ordem :" (Say1 - Top original=259 -> Top_Page1=179)
        loc_oPagina.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oPagina.lbl_4c_Say1
            .AutoSize  = .T.
            .Caption   = "Ordem :"
            .Left      = 51
            .Top       = 179
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- ComboBox ordem (cmbOrdem1 - Top original=254 -> Top_Page1=174)
        *-- RowSourceType=1 (lista estatica), Style=2 (dropdown list)
        loc_oPagina.AddObject("cbo_4c_Ordem1", "ComboBox")
        WITH loc_oPagina.cbo_4c_Ordem1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 25
            .Left          = 94
            .Top           = 174
            .Width         = 207
            .Style         = 2
            .RowSourceType = 1
            .RowSource     = "Cliente,Digita" + CHR(231) + CHR(227) + "o,Entrega,Vendedor+Digita" + CHR(231) + CHR(227) + "o,Vendedor+Entrega,Vendedor+Cliente"
            .Value         = "Cliente"
            .Visible       = .T.
        ENDWITH

        *-- Label "Moeda :" (lbl_moeda - Top original=259 -> Top_Page1=179)
        loc_oPagina.AddObject("lbl_4c_LblMoeda", "Label")
        WITH loc_oPagina.lbl_4c_LblMoeda
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .Left      = 316
            .Top       = 179
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo moeda (get_cd_moeda - Top original=254 -> Top_Page1=174)
        loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_CdMoeda
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 0
            .Format        = "K!"
            .Height        = 25
            .Left          = 359
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 174
            .Width         = 31
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = SPACE(3)
            .Visible       = .T.
        ENDWITH

        *-- TextBox descricao moeda (get_ds_moeda - Top original=254 -> Top_Page1=174)
        loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_DsMoeda
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 392
            .MaxLength     = 15
            .SpecialEffect = 1
            .Top           = 174
            .Width         = 115
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = SPACE(15)
            .Visible       = .T.
        ENDWITH

        *-- ===========================================================
        *-- LINHA 8: Situacao (opt_filtro)
        *-- ===========================================================

        *-- Label "Situacao :" (lbl_custo - Top original=285 -> Top_Page1=205)
        loc_oPagina.AddObject("lbl_4c_LblCusto", "Label")
        WITH loc_oPagina.lbl_4c_LblCusto
            .AutoSize  = .T.
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Left      = 42
            .Top       = 205
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup situacao filtro (opt_filtro - Top original=281 -> Top_Page1=201)
        *-- ButtonCount=3: Encerrados/Abertos/Ambos, Value=3 (Ambos)
        loc_oPagina.AddObject("obj_4c_OptFiltro", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptFiltro
            .Top           = 201
            .Left          = 89
            .Width         = 235
            .Height        = 20
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 3
            .SpecialEffect = 0
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Encerrados"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Height    = 15
                .Left      = 5
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Abertos"
                .Height    = 15
                .Left      = 95
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Ambos"
                .WordWrap        = .T.
                .Height    = 15
                .Left      = 170
                .Top       = 3
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- ===========================================================
        *-- LINHA 9: chkItens
        *-- ===========================================================

        *-- CheckBox ignorar itens encerrados (chkItens - Top original=304 -> Top_Page1=224)
        loc_oPagina.AddObject("chk_4c_ChkItens", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkItens
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Ignorar itens encerrados"
            .Height    = 20
            .Left      = 112
            .Top       = 224
            .Width     = 200
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- ===========================================================
        *-- LINHA 10: Imprimir (Opc_Imp)
        *-- ===========================================================

        *-- Label "Imprimir :" (Say5 - Top original=325 -> Top_Page1=245)
        loc_oPagina.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPagina.lbl_4c_Say5
            .AutoSize  = .T.
            .Caption   = "Imprimir :"
            .Left      = 45
            .Top       = 245
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup imprimir por (Opc_Imp - Top original=321 -> Top_Page1=241)
        *-- ButtonCount=3: Vendedor/Cidade/Data Encerramento, Value=1
        *-- Enabled=.F.: habilitado somente quando opt_filtro.Value=1 (Encerrados)
        loc_oPagina.AddObject("obj_4c_OpcImp", "OptionGroup")
        WITH loc_oPagina.obj_4c_OpcImp
            .Top           = 241
            .Left          = 89
            .Width         = 288
            .Height        = 25
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .SpecialEffect = 0
            .Themes        = .F.
            .Enabled       = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Vendedor"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Cidade"
                .Height    = 15
                .Left      = 90
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Data Encerramento"
                .WordWrap        = .T.
                .Height    = 15
                .Left      = 155
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- ===========================================================
        *-- LINHA 11: Visualizar (optAnaSin)
        *-- ===========================================================

        *-- Label "Visualizar :" (Say7 - Top original=352 -> Top_Page1=272)
        loc_oPagina.AddObject("lbl_4c_Say7", "Label")
        WITH loc_oPagina.lbl_4c_Say7
            .AutoSize  = .T.
            .Caption   = "Visualizar :"
            .Left      = 39
            .Top       = 272
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup analitico/sintetico (optAnaSin - Top original=347 -> Top_Page1=267)
        *-- ButtonCount=2: Analitico/Sintetico, Value=2 (Sintetico)
        loc_oPagina.AddObject("obj_4c_OptAnaSin", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptAnaSin
            .Top           = 267
            .Left          = 89
            .Width         = 158
            .Height        = 25
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .SpecialEffect = 0
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Anal" + CHR(237) + "tico"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sint" + CHR(233) + "tico"
                .Height    = 15
                .Left      = 80
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- ===========================================================
        *-- LINHA 12: chkTpope / chkSemVals
        *-- ===========================================================

        *-- CheckBox analisar por tipo de movimentacao (chkTpope - Top original=369 -> Top_Page1=289)
        loc_oPagina.AddObject("chk_4c_ChkTpope", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkTpope
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Analisar por Tipo de Movimenta" + CHR(231) + CHR(227) + "o"
            .Height    = 20
            .Left      = 112
            .Top       = 289
            .Width     = 220
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- CheckBox sem valores (chkSemVals - Top original=369 -> Top_Page1=289)
        *-- Enabled=.F.: habilitado somente quando chkTpope.Value=1
        loc_oPagina.AddObject("chk_4c_ChkSemVals", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkSemVals
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Sem Valores"
            .Height    = 20
            .Left      = 337
            .Top       = 289
            .Width     = 100
            .BackStyle = 0
            .Value     = 0
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===========================================================
        *-- LINHA 13: chkIndus
        *-- ===========================================================

        *-- CheckBox ignorar nao industrializadas (chkIndus - Top original=387 -> Top_Page1=307)
        loc_oPagina.AddObject("chk_4c_ChkIndus", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkIndus
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Ignorar n" + CHR(227) + "o Industrializadas"
            .Height    = 20
            .Left      = 112
            .Top       = 307
            .Width     = 200
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- ===========================================================
        *-- BINDEVENTS: KeyPress para lookups + InteractiveChange
        *-- ===========================================================

        BINDEVENT(loc_oPagina.txt_4c_CdTpOpe,    "KeyPress",          THIS, "CdTpOpeLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DsTpOpe,    "KeyPress",          THIS, "DsTpOpeLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque,  "KeyPress",          THIS, "CdEstoqueLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque,  "KeyPress",          THIS, "DsEstoqueLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CdVendedor, "KeyPress",          THIS, "CdVendedorLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DsVendedor, "KeyPress",          THIS, "DsVendedorLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Estado,     "KeyPress",          THIS, "EstadoLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda,    "KeyPress",          THIS, "CdMoedaLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda,    "KeyPress",          THIS, "DsMoedaLookupKeyPress")
        BINDEVENT(loc_oPagina.obj_4c_OptFiltro,  "InteractiveChange", THIS, "OptFiltroInteractiveChange")
        BINDEVENT(loc_oPagina.chk_4c_ChkTpope,   "InteractiveChange", THIS, "ChkTpopeInteractiveChange")
    ENDPROC

    *==========================================================================
    * CARREGAROPERACOES - Carrega tipos de operacao de SigCdTom no crOperacoes
    * Equivalente a logica SQL do Init() original do SIGREESP
    * Inicializa SelImp=.T., SelImp2=.T., SelImp3=.F. para todos os registros
    *==========================================================================
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_cDescrs
        loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos"

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
            IF loc_nResult > 0
                SELECT crOperacoes
                ZAP
                SELECT cursor_4c_TmpOpe
                SCAN
                    loc_nCodigos = cursor_4c_TmpOpe.Codigos
                    loc_cDescrs  = ALLTRIM(cursor_4c_TmpOpe.Descrs)
                    SELECT crOperacoes
                    APPEND BLANK
                    REPLACE SelImp  WITH .T., ;
                            SelImp2 WITH .T., ;
                            SelImp3 WITH .F., ;
                            Codigos WITH loc_nCodigos, ;
                            Descrs  WITH loc_cDescrs
                    SELECT cursor_4c_TmpOpe
                ENDSCAN
                IF USED("cursor_4c_TmpOpe")
                    USE IN cursor_4c_TmpOpe
                ENDIF
                SELECT crOperacoes
                GO TOP
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
                   VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes) = "O"
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarOperacoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNGRADESCLICK - Seleciona ou desmarca todos os tipos de operacao
    *   Value=1 -> marca todos (SelImp=.T., SelImp2=.T.)
    *   Value=2 -> desmarca todos (SelImp=.F., SelImp2=.F.)
    *   Logica identica ao cmdBtnGradeS.Click original.
    *==========================================================================
    PROCEDURE BtnGradeSClick()
        LOCAL loc_lMarcar, loc_oGrid
        loc_lMarcar = (THIS.pgf_4c_Paginas.Page1.cmg_4c_GradeS.Value = 1)
        IF USED("crOperacoes")
            UPDATE crOperacoes SET SelImp = loc_lMarcar, SelImp2 = loc_lMarcar
            GO TOP IN crOperacoes
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
            IF VARTYPE(loc_oGrid) = "O"
                loc_oGrid.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GRDOPECHECK1KEYPRESS - Togla SelImp via teclado (Enter=13, Espaco=32)
    * Equivalente ao KeyPress do Check1 da Column1 do grdOperacoes original
    *==========================================================================
    PROCEDURE GrdOpeCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrid
        IF INLIST(par_nKeyCode, 13, 32)
            IF USED("crOperacoes") AND !EOF("crOperacoes")
                SELECT crOperacoes
                REPLACE SelImp WITH !crOperacoes.SelImp
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
                    IF VARTYPE(loc_oGrid) = "O"
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * DESTROY - Limpeza de recursos
    * NAO usar .Release() em BO Custom - apenas .NULL.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        IF USED("crOperacoes")
            USE IN crOperacoes
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * FORMPARARELATORIO - Transfere controles da tela para o BO do relatorio
    * Chamado por BtnVisualizarClick, BtnImprimirClick, BtnDocExcelClick
    *==========================================================================
    PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag, loc_cTpOpeM, loc_cTpOpeE, loc_cTpOpeC
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPag     = THIS.pgf_4c_Paginas.Page1
        loc_cTpOpeM  = ""
        loc_cTpOpeE  = ""
        loc_cTpOpeC  = ""
        TRY
            WITH THIS.this_oRelatorio
                .this_dDtInicial  = loc_oPag.txt_4c_DtInicial.Value
                .this_dDtFinal    = loc_oPag.txt_4c_DtFinal.Value
                .this_nPeriodo    = loc_oPag.obj_4c_OptNrPeriodo.Value
                .this_cNmOperacao = ALLTRIM(loc_oPag.txt_4c__nm_operacao.Value)
                .this_nNumero     = loc_oPag.txt_4c_Numero.Value
                .this_nCdTpOpe    = loc_oPag.txt_4c_CdTpOpe.Value
                .this_cDsTpOpe    = ALLTRIM(loc_oPag.txt_4c_DsTpOpe.Value)
                .this_cCdConta    = ALLTRIM(loc_oPag.txt_4c_CdEstoque.Value)
                .this_cDsConta    = ALLTRIM(loc_oPag.txt_4c_DsEstoque.Value)
                .this_cCdVendedor = ALLTRIM(loc_oPag.txt_4c_CdVendedor.Value)
                .this_cDsVendedor = ALLTRIM(loc_oPag.txt_4c_DsVendedor.Value)
                .this_cCidade     = ALLTRIM(loc_oPag.txt_4c_Cidade.Value)
                .this_cEstado     = ALLTRIM(loc_oPag.txt_4c_Estado.Value)
                .this_nFiltro     = loc_oPag.obj_4c_OptFiltro.Value
                .this_nOpcImp     = loc_oPag.obj_4c_OpcImp.Value
                .this_nOrdem      = loc_oPag.cbo_4c_Ordem1.ListIndex
                .this_nAnaSin     = loc_oPag.obj_4c_OptAnaSin.Value
                .this_lTpOpe      = (loc_oPag.chk_4c_ChkTpope.Value = 1)
                .this_lItens      = (loc_oPag.chk_4c_ChkItens.Value = 1)
                .this_lIndus      = (loc_oPag.chk_4c_ChkIndus.Value = 1)
                .this_lSemVals    = (loc_oPag.chk_4c_ChkSemVals.Value = 1)
                .this_cCdMoeda    = ALLTRIM(loc_oPag.txt_4c_CdMoeda.Value)
                .this_cDsMoeda    = ALLTRIM(loc_oPag.txt_4c_DsMoeda.Value)
            ENDWITH
            IF USED("crOperacoes")
                SELECT crOperacoes
                GO TOP
                SCAN
                    IF crOperacoes.SelImp
                        loc_cTpOpeM = loc_cTpOpeM + IIF(EMPTY(loc_cTpOpeM),"",",") + ALLTRIM(STR(crOperacoes.Codigos))
                    ENDIF
                    IF crOperacoes.SelImp2
                        loc_cTpOpeE = loc_cTpOpeE + IIF(EMPTY(loc_cTpOpeE),"",",") + ALLTRIM(STR(crOperacoes.Codigos))
                    ENDIF
                    IF crOperacoes.SelImp3
                        loc_cTpOpeC = loc_cTpOpeC + IIF(EMPTY(loc_cTpOpeC),"",",") + ALLTRIM(STR(crOperacoes.Codigos))
                    ENDIF
                ENDSCAN
            ENDIF
            THIS.this_oRelatorio.this_cTpOpeM = IIF(EMPTY(loc_cTpOpeM), "0", loc_cTpOpeM)
            THIS.this_oRelatorio.this_cTpOpeE = IIF(EMPTY(loc_cTpOpeE), "0", loc_cTpOpeE)
            THIS.this_oRelatorio.this_cTpOpeC = IIF(EMPTY(loc_cTpOpeC), "0", loc_cTpOpeC)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaRelatorio")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LIMPARCAMPOS - Restaura todos os filtros aos valores padrao
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPag
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oPag.txt_4c_DtInicial.Value        = DATE()
            loc_oPag.txt_4c_DtFinal.Value          = DATE()
            loc_oPag.obj_4c_OptNrPeriodo.Value     = 1
            loc_oPag.txt_4c__nm_operacao.Value     = SPACE(20)
            loc_oPag.txt_4c_Numero.Value           = 0
            loc_oPag.txt_4c_CdTpOpe.Value          = 0
            loc_oPag.txt_4c_DsTpOpe.Value          = "TODOS"
            loc_oPag.txt_4c_CdEstoque.Value        = SPACE(10)
            loc_oPag.txt_4c_DsEstoque.Value        = SPACE(40)
            loc_oPag.txt_4c_CdVendedor.Value       = SPACE(10)
            loc_oPag.txt_4c_DsVendedor.Value       = SPACE(40)
            loc_oPag.txt_4c_Cidade.Value           = SPACE(30)
            loc_oPag.txt_4c_Estado.Value           = SPACE(2)
            loc_oPag.cbo_4c_Ordem1.Value           = "Cliente"
            loc_oPag.txt_4c_CdMoeda.Value          = SPACE(3)
            loc_oPag.txt_4c_DsMoeda.Value          = SPACE(15)
            loc_oPag.obj_4c_OptFiltro.Value        = 3
            loc_oPag.obj_4c_OpcImp.Enabled         = .F.
            loc_oPag.obj_4c_OpcImp.Value           = 1
            loc_oPag.obj_4c_OptAnaSin.Value        = 2
            loc_oPag.chk_4c_ChkItens.Value         = 0
            loc_oPag.chk_4c_ChkTpope.Value         = 0
            loc_oPag.chk_4c_ChkSemVals.Value       = 0
            loc_oPag.chk_4c_ChkSemVals.Enabled     = .F.
            loc_oPag.chk_4c_ChkIndus.Value         = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OPTFILTROINTERACTIVECHANGE - Controla estado de OpcImp e ChkItens
    *   Value=1 (Encerrados): habilita OpcImp, zera ChkItens
    *   Value=2/3: desabilita OpcImp
    *==========================================================================
    PROCEDURE OptFiltroInteractiveChange()
        LOCAL loc_oPag, loc_lEncerrados
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPag        = THIS.pgf_4c_Paginas.Page1
        loc_lEncerrados = (loc_oPag.obj_4c_OptFiltro.Value = 1)
        loc_oPag.obj_4c_OpcImp.Enabled = loc_lEncerrados
        IF loc_lEncerrados
            loc_oPag.chk_4c_ChkItens.Value = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * CHKTPOPEINTERACTIVECHANGE - Controla estado de ChkSemVals
    *   Value=1: habilita ChkSemVals
    *   Value=0: desabilita e zera ChkSemVals
    *==========================================================================
    PROCEDURE ChkTpopeInteractiveChange()
        LOCAL loc_oPag
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF loc_oPag.chk_4c_ChkTpope.Value = 1
            loc_oPag.chk_4c_ChkSemVals.Enabled = .T.
        ELSE
            loc_oPag.chk_4c_ChkSemVals.Value   = 0
            loc_oPag.chk_4c_ChkSemVals.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS KEYPRESS - F4/F5 dispara lookup nos campos de filtro
    *==========================================================================
    PROCEDURE CdTpOpeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupTpOpePorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE DsTpOpeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupTpOpePorDescricao()
        ENDIF
    ENDPROC

    PROCEDURE CdEstoqueLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupEstoquePorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE DsEstoqueLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupEstoquePorDescricao()
        ENDIF
    ENDPROC

    PROCEDURE CdVendedorLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupVendedorPorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE DsVendedorLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupVendedorPorDescricao()
        ENDIF
    ENDPROC

    PROCEDURE EstadoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupEstado()
        ENDIF
    ENDPROC

    PROCEDURE CdMoedaLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupMoedaPorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE DsMoedaLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupMoedaPorDescricao()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS TIPO DE OPERACAO (SigCdTom: Codigos, Descrs)
    *==========================================================================
    PROCEDURE AbrirLookupTpOpePorCodigo()
        LOCAL loc_oBusca, loc_cValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(STR(THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value))
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTom", "cursor_4c_BuscaTpOpe", "Codigos", loc_cValor, ;
                "Tipo de Opera" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOpe")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
                        THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupTpOpePorCodigo")
        ENDTRY
        IF USED("cursor_4c_BuscaTpOpe")
            USE IN cursor_4c_BuscaTpOpe
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupTpOpePorDescricao()
        LOCAL loc_oBusca, loc_cValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value)
        IF loc_cValor = "TODOS"
            loc_cValor = ""
        ENDIF
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTom", "cursor_4c_BuscaTpOpe", "Descrs", loc_cValor, ;
                "Tipo de Opera" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOpe")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
                        THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupTpOpePorDescricao")
        ENDTRY
        IF USED("cursor_4c_BuscaTpOpe")
            USE IN cursor_4c_BuscaTpOpe
        ENDIF
    ENDPROC

    PROCEDURE ValidarTpOpeCodigo()
        LOCAL loc_cSQL, loc_nRes, loc_nCod
        loc_nCod = THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value
        IF loc_nCod = 0
            THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = "TODOS"
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValTpOpe")
            IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValTpOpe") = 1
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_ValTpOpe.Descrs)
            ELSE
                MsgAviso("C" + CHR(243) + "digo de tipo n" + CHR(227) + "o encontrado.")
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = 0
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = "TODOS"
                THIS.AbrirLookupTpOpePorCodigo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarTpOpeCodigo")
        ENDTRY
        IF USED("cursor_4c_ValTpOpe")
            USE IN cursor_4c_ValTpOpe
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS CONTA/ESTOQUE (SigCdCli: iclis, nomes)
    *==========================================================================
    PROCEDURE AbrirLookupEstoquePorCodigo()
        LOCAL loc_oBusca, loc_cValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaEstoque", "iclis", loc_cValor, ;
                "Conta/Estoque")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("nomes", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupEstoquePorCodigo")
        ENDTRY
        IF USED("cursor_4c_BuscaEstoque")
            USE IN cursor_4c_BuscaEstoque
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupEstoquePorDescricao()
        LOCAL loc_oBusca, loc_cValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaEstoque", "nomes", loc_cValor, ;
                "Conta/Estoque")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("nomes", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupEstoquePorDescricao")
        ENDTRY
        IF USED("cursor_4c_BuscaEstoque")
            USE IN cursor_4c_BuscaEstoque
        ENDIF
    ENDPROC

    PROCEDURE ValidarEstoqueCodigo()
        LOCAL loc_cSQL, loc_nRes, loc_cCod
        loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value)
        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = SPACE(40)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEstoque")
            IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValEstoque") = 1
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_ValEstoque.nomes)
            ELSE
                MsgAviso("C" + CHR(243) + "digo de conta n" + CHR(227) + "o encontrado.")
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = SPACE(10)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = SPACE(40)
                THIS.AbrirLookupEstoquePorCodigo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarEstoqueCodigo")
        ENDTRY
        IF USED("cursor_4c_ValEstoque")
            USE IN cursor_4c_ValEstoque
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS VENDEDOR (SigCdCli: iclis, nomes)
    *==========================================================================
    PROCEDURE AbrirLookupVendedorPorCodigo()
        LOCAL loc_oBusca, loc_cValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaVendedor", "iclis", loc_cValor, ;
                "Vendedor")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("nomes", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVendedor")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupVendedorPorCodigo")
        ENDTRY
        IF USED("cursor_4c_BuscaVendedor")
            USE IN cursor_4c_BuscaVendedor
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupVendedorPorDescricao()
        LOCAL loc_oBusca, loc_cValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaVendedor", "nomes", loc_cValor, ;
                "Vendedor")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("nomes", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVendedor")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupVendedorPorDescricao")
        ENDTRY
        IF USED("cursor_4c_BuscaVendedor")
            USE IN cursor_4c_BuscaVendedor
        ENDIF
    ENDPROC

    PROCEDURE ValidarVendedorCodigo()
        LOCAL loc_cSQL, loc_nRes, loc_cCod
        loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value)
        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = SPACE(40)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValVendedor")
            IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValVendedor") = 1
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_ValVendedor.nomes)
            ELSE
                MsgAviso("C" + CHR(243) + "digo de vendedor n" + CHR(227) + "o encontrado.")
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = SPACE(10)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = SPACE(40)
                THIS.AbrirLookupVendedorPorCodigo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarVendedorCodigo")
        ENDTRY
        IF USED("cursor_4c_ValVendedor")
            USE IN cursor_4c_ValVendedor
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP ESTADO (SigCdUfs: Estados)
    *==========================================================================
    PROCEDURE AbrirLookupEstado()
        LOCAL loc_oBusca, loc_cValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Estado.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUfs", "cursor_4c_BuscaEstado", "Estados", loc_cValor, ;
                "Estado (UF)")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Estado.Value = ALLTRIM(cursor_4c_BuscaEstado.Estados)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Estados", "", "UF")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstado")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Estado.Value = ALLTRIM(cursor_4c_BuscaEstado.Estados)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupEstado")
        ENDTRY
        IF USED("cursor_4c_BuscaEstado")
            USE IN cursor_4c_BuscaEstado
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS MOEDA (SigCdMoe: cmoes, dmoes)
    *==========================================================================
    PROCEDURE AbrirLookupMoedaPorCodigo()
        LOCAL loc_oBusca, loc_cValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
                "Moeda")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Moeda")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupMoedaPorCodigo")
        ENDTRY
        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupMoedaPorDescricao()
        LOCAL loc_oBusca, loc_cValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeda", "dmoes", loc_cValor, ;
                "Moeda")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Moeda")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupMoedaPorDescricao")
        ENDTRY
        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoedaCodigo()
        LOCAL loc_cSQL, loc_nRes, loc_cCod
        loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)
        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = SPACE(15)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE CAST(cmoes AS VARCHAR(10)) = " + EscaparSQL(loc_cCod)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValMoeda")
            IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValMoeda") = 1
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_ValMoeda.dmoes)
            ELSE
                MsgAviso("C" + CHR(243) + "digo de moeda n" + CHR(227) + "o encontrado.")
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = SPACE(3)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = SPACE(15)
                THIS.AbrirLookupMoedaPorCodigo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarMoedaCodigo")
        ENDTRY
        IF USED("cursor_4c_ValMoeda")
            USE IN cursor_4c_ValMoeda
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNBUSCARCLICK - Override no-op: form REPORT nao tem operacao Buscar CRUD
    *   FormBase pode chamar este metodo; aqui nao faz nada.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *==========================================================================
    * BTNENCERRARCLICK - Fecha o formulario de relatorio
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNSALVARCLICK - Override no-op: form REPORT nao salva registros CRUD
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *==========================================================================
    * BTNCANCELARCLICK - Override no-op: form REPORT nao tem cancelar CRUD
    *   Para relatorio, cancela equivale a limpar os filtros.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * FORMPARA BO - Alias para FormParaRelatorio (compatibilidade com FormBase)
    *   FormBase pode chamar FormParaBO(); para relatorios isso equivale a
    *   transferir os filtros da tela para o BO do relatorio.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *==========================================================================
    * BOPARAFORM - Nao aplicavel para relatorios (dados fluem Form -> BO)
    *   Override para evitar chamada de metodo inexistente em FormBase.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *==========================================================================
    * HABILITARCAMPOS - Habilita/desabilita controles de filtro
    *   Em formulario REPORT todos os campos de filtro ficam sempre habilitados.
    *   O unico controle com habilitacao condicional e obj_4c_OpcImp (controlado
    *   pelo OptFiltroInteractiveChange) e chk_4c_ChkSemVals (pelo ChkTpope).
    *   Este metodo garante que os controles principais estejam habilitados.
    *==========================================================================
    PROCEDURE HabilitarCampos()
        LOCAL loc_oPag
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oPag.txt_4c_DtInicial.Enabled        = .T.
            loc_oPag.txt_4c_DtFinal.Enabled          = .T.
            loc_oPag.obj_4c_OptNrPeriodo.Enabled     = .T.
            loc_oPag.txt_4c__nm_operacao.Enabled     = .T.
            loc_oPag.txt_4c_Numero.Enabled           = .T.
            loc_oPag.txt_4c_CdTpOpe.Enabled         = .T.
            loc_oPag.txt_4c_DsTpOpe.Enabled         = .T.
            loc_oPag.txt_4c_CdEstoque.Enabled       = .T.
            loc_oPag.txt_4c_DsEstoque.Enabled       = .T.
            loc_oPag.txt_4c_CdVendedor.Enabled      = .T.
            loc_oPag.txt_4c_DsVendedor.Enabled      = .T.
            loc_oPag.txt_4c_Cidade.Enabled          = .T.
            loc_oPag.txt_4c_Estado.Enabled          = .T.
            loc_oPag.cbo_4c_Ordem1.Enabled          = .T.
            loc_oPag.txt_4c_CdMoeda.Enabled         = .T.
            loc_oPag.txt_4c_DsMoeda.Enabled         = .T.
            loc_oPag.obj_4c_OptFiltro.Enabled       = .T.
            loc_oPag.obj_4c_OptAnaSin.Enabled       = .T.
            loc_oPag.chk_4c_ChkItens.Enabled        = .T.
            loc_oPag.chk_4c_ChkTpope.Enabled        = .T.
            loc_oPag.chk_4c_ChkIndus.Enabled        = .T.
            loc_oPag.grd_4c_Operacoes.Enabled       = .T.
            loc_oPag.cmg_4c_GradeS.Enabled          = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CARREGARLISTA - Recarrega a lista de tipos de operacao no grid
    *   Em formulario REPORT "lista" equivale ao grid de selecao de operacoes.
    *   Chamado pelo FormBase quando necessario recarregar dados.
    *==========================================================================
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
            THIS.CarregarOperacoes()
        ENDIF
    ENDPROC

    *==========================================================================
    * AJUSTARBOTOESPORMODO - Override: form REPORT nao tem modos CRUD
    *   FormBase chama este metodo ao mudar de modo (INCLUIR/ALTERAR/etc.).
    *   Para relatorio, os botoes de relatorio ficam sempre habilitados.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Enabled = .T.
        ENDIF
    ENDPROC

ENDDEFINE
