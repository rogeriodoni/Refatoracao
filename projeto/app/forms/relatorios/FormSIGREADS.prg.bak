*==============================================================================
* FORMSIGREADS.PRG
* Relat" + CHR(243) + "rio de Apura" + CHR(231) + CHR(227) + "o de Descontos/Acr" + CHR(233) + "scimos
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREADS.SCX (frmrelatorio)
*
* Filtros (layout flat - controles direto no form):
*   - Empresa      (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdEmp)
*   - Vendedor     (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdCli, filtrado por grupo)
*   - Opera" + CHR(231) + CHR(227) + "o   (c" + CHR(243) + "digo - SigCdOpe)
*   - Per" + CHR(237) + "odo      (data inicial / data final)
*   - Moeda        (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe)
*   - Margem       (percentual de toler" + CHR(226) + "ncia)
*   - Tipo Varia" + CHR(231) + CHR(227) + "o  (Desconto / Acr" + CHR(233) + "scimo / Ambos / Geral)
*   - Tipo Impress" + CHR(227) + "o (Sint" + CHR(233) + "tico / Anal" + CHR(237) + "tico / Resumo)
*   - Observa" + CHR(231) + CHR(245) + "es    (Sim / N" + CHR(227) + "o)
*   - Grid de tipos de opera" + CHR(231) + CHR(227) + "o (GrdTipo com checkbox + descri" + CHR(231) + CHR(227) + "o)
*
* FASE 3/8 - Estrutura Base
*   * Propriedades visuais (EXATAS do original: Width=800, Height=500)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()  - cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo
*   * ConfigurarBotoes()     - CommandGroup Visualizar/Imprimir/Excel/Encerrar
*   * ConfigurarPageFrame()  - PageFrame com 1 pagina ("Filtros") para os campos
*==============================================================================

DEFINE CLASS FormSIGREADS AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original)
    Height      = 500
    Width       = 800
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

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *   1. Define Caption / Picture (fundo do form)
    *   2. Cria SIGREADSBO e carrega par" + CHR(226) + "metros iniciais (pula em modo UI)
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Apura" + CHR(231) + CHR(227) + "o de Descontos/Acr" + CHR(233) + "scimos"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREADSBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREADSBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar par" + CHR(226) + "metros padr" + CHR(227) + "o (empresa, moeda, datas) -- pula em modo de valida" + CHR(231) + CHR(227) + "o de UI
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarParametrosPadrao()
                    IF !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                    ENDIF
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Carregar tipos de opera" + CHR(231) + CHR(227) + "o no grid (pula em modo de valida" + CHR(231) + CHR(227) + "o de UI)
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarTiposOperacao(THIS.this_oRelatorio.this_cCursorTipos)
                    IF !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                    ENDIF
                    loc_lContinuar = .F.
                ENDIF
                *-- Carregar grupos de produto no grid Grdgrupo (novo SCX)
                IF loc_lContinuar AND ;
                   !THIS.this_oRelatorio.CarregarGruposProduto(THIS.this_oRelatorio.this_cCursorGrupos)
                    IF !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                    ENDIF
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente ao cntSombra do frmrelatorio)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com 1 pagina ("Filtros") - agrupa os campos de filtro
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Grid de tipos de opera" + CHR(231) + CHR(227) + "o + bot" + CHR(245) + "es SelTudo/Apaga
                *-- (em forms REPORT, ConfigurarPaginaLista monta a "p" + CHR(225) + "gina de sele" + CHR(231) + CHR(227) + "o" -
                *--  equivalente ao papel da Page1/Lista em forms CRUD)
                THIS.ConfigurarPaginaLista()

                *-- Campos de filtro: Empresa, Vendedor, Opera" + CHR(231) + CHR(227) + "o, Moeda (primeira metade)
                THIS.ConfigurarPaginaDados()

                *-- Pre-preencher campos com valores iniciais do BO (empresa e moeda padrao)
                THIS.LimparCampos()

                THIS.Visible  = .T.
                loc_lSucesso  = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGREADS:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
    *   Equivalente ao cntSombra/lblSombra/lblTitulo do framework frmrelatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BackColor  = RGB(100, 100, 100)
            .BackStyle  = 1
            .BorderWidth = 0
            .Visible    = .T.
        ENDWITH

        *-- Sombra (texto ligeiramente deslocado para efeito 3D)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "Relat" + CHR(243) + "rio de Apura" + CHR(231) + CHR(227) + "o de Descontos/Acr" + CHR(233) + "scimos"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- T" + CHR(237) + "tulo principal (texto branco sobre fundo escuro)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 20
            .Left      = 10
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "Relat" + CHR(243) + "rio de Apura" + CHR(231) + CHR(227) + "o de Descontos/Acr" + CHR(233) + "scimos"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es de relat" + CHR(243) + "rio
    *   Geometria EXATA do framework frmrelatorio (btnReport):
    *   Left=527, Width=273, Height=80 (para form Width=800)
    *   Incremento entre bot" + CHR(245) + "es: 66px (Left: 5, 71, 137, 203)
    *   BINDEVENTs adicionados na Fase 7/8
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 527
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Bot" + CHR(227) + "o 1: Visualizar
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- Bot" + CHR(227) + "o 2: Imprimir
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- Bot" + CHR(227) + "o 3: Excel
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "\<Arquivos Email"
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- Bot" + CHR(227) + "o 4: Encerrar (Cancel=.T. para ESC fechar)
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Cancel          = .T.
        ENDWITH

        *-- BINDEVENTs: ButtonsClick -> handlers de acao do relatorio
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   O form legado SIGREADS e FLAT (sem PageFrame), mas no novo padrao
    *   os campos sao agrupados em um PageFrame de 1 pagina para consistencia
    *   com o restante do sistema.
    *
    *   Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form.
    *   Os campos de filtro (TextBoxes, OptionGroups, Grid de tipos) sao
    *   adicionados a Page1 nas fases seguintes (5-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
        loc_oPgf.PageCount = 2

        *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (referencia direta - sem WITH para evitar problemas)
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Configurar Page2 (pagina de dados/entrada para navegacao padrao)
        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta os controles da Page1 (lista de sele" + CHR(231) + CHR(227) + "o)
    *
    *   Em forms REPORT, a "p" + CHR(225) + "gina de lista" corresponde " + CHR(224) + " p" + CHR(225) + "gina de filtros que cont" + CHR(233) + "m:
    *     - Label do t" + CHR(237) + "tulo "Tipo de Opera" + CHR(231) + CHR(227) + "o :" (Label1 original, top=194,left=180)
    *     - Grid de tipos de opera" + CHR(231) + CHR(227) + "o com checkbox de sele" + CHR(231) + CHR(227) + "o (GrdTipo original)
    *     - Bot" + CHR(227) + "o "Sel. Todos" (SelTudo original, top=213,left=560)
    *     - Bot" + CHR(227) + "o "Nenhum" (apaga original, top=253,left=560)
    *
    *   Cabe" + CHR(231) + "alho ocupa os 85 pixels superiores (cabecalho + cmg_4c_Botoes),
    *   ent" + CHR(227) + "o todos os Tops dos controles internos da Page1 s" + CHR(227) + "o subtra" + CHR(237) + "dos de 85.
    *
    *   Equivale " + CHR(224) + " ConfigurarPaginaLista de forms CRUD (carrega grid + bot" + CHR(245) + "es associados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid, loc_cCursor, loc_oGridGrp, loc_cCursorGrp

        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos

        *-- Label acima do grid (Label1 novo SCX: top=190, left=27, width=94)
        loc_oPagina.AddObject("lbl_4c_TipoOpe", "Label")
        WITH loc_oPagina.lbl_4c_TipoOpe
            .Top       = 105
            .Left      = 27
            .Width     = 94
            .Height    = 15
            .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label2 acima do grid de Grupo (novo SCX: top=175, left=430, width=87)
        loc_oPagina.AddObject("lbl_4c_GrupoProd", "Label")
        WITH loc_oPagina.lbl_4c_GrupoProd
            .Top       = 90
            .Left      = 430
            .Width     = 87
            .Height    = 15
            .Caption   = "Grupo de Produto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Garantir cursor disponivel (pode estar ausente em modo de valida" + CHR(231) + CHR(227) + "o UI)
        IF !USED(loc_cCursor)
            CREATE CURSOR (loc_cCursor) (Marca N(1), Codigos N(2), Descri C(40))
        ENDIF

        *-- Grid de tipos de opera" + CHR(231) + CHR(227) + "o (GrdTipo original: width=279, height=110)
        loc_oPagina.AddObject("grd_4c_TipoOps", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_TipoOps

        *-- ColumnCount ANTES do WITH para criar colunas antes de configurar
        loc_oGrid.ColumnCount = 2

        WITH loc_oGrid
            .Top                = 104
            .Left               = 125
            .Width              = 254
            .Height             = 110
            .HeaderHeight       = 0
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .ScrollBars         = 2
            .RowHeight          = 18
            .FontName           = "Tahoma"
            .FontSize           = 8
        ENDWITH

        *-- Column1: CheckBox para Marca (sele" + CHR(231) + CHR(227) + "o do tipo) - SCX: Width=15
        *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS de CurrentControl
        *-- Sparse=.F. OBRIGATORIO: sem isso, CheckBox aparece SO na linha corrente e outras
        *-- linhas viram texto plano (0/1) ? user nao consegue clicar checkboxes das demais linhas
        WITH loc_oGrid.Column1
            .Width     = 15
            .Alignment = 0
            .Enabled   = .T.
            .Sparse    = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .CurrentControl = "Check1"
            .ControlSource  = loc_cCursor + ".Marca"
            .Header1.Caption = ""
        ENDWITH

        *-- Column2: Descri" + CHR(231) + CHR(227) + "o do tipo de opera" + CHR(231) + CHR(227) + "o (read-only) - SCX: Width=220
        WITH loc_oGrid.Column2
            .Width         = 220
            .ControlSource = loc_cCursor + ".Descri"
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
        ENDWITH

        *-- RecordSource APOS configurar colunas (evita reset antecipado de headers)
        loc_oGrid.RecordSource = loc_cCursor

        *-- Reconfigurar headers APOS RecordSource (RecordSource reseta headers)
        loc_oGrid.Column1.Header1.Caption = ""
        loc_oGrid.Column2.Header1.Caption = "Descrs"
        loc_oGrid.Column2.Header1.FontName = "Tahoma"
        loc_oGrid.Column2.Header1.FontSize = 8

        loc_oGrid.Visible = .T.

        *-- Bot" + CHR(227) + "o SelTudo: seleciona todos os tipos (original SelTudo.When: replace all marca with 1)
        *-- Novo SCX: Picture=..\framework\imagens\geral_marcar_26.jpg, top=201, left=384, Caption="" (icon-only)
        loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oPagina.cmd_4c_SelTudo
            .Top             = 116
            .Left            = 384
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Sel. Todos"
            .Visible         = .T.
        ENDWITH

        *-- Bot" + CHR(227) + "o Apaga: desmarca todos os tipos (original apaga.Click: replace all marca with 0)
        *-- Novo SCX: Picture=..\framework\imagens\cadastro_cancelar_60.jpg, top=241, left=384, Caption=""
        loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH loc_oPagina.cmd_4c_Apaga
            .Top             = 156
            .Left            = 384
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Nenhum"
            .Visible         = .T.
        ENDWITH

        *==========================================================================
        * Grdgrupo (Grupo de Produto) - novo SCX
        *==========================================================================
        loc_cCursorGrp = THIS.this_oRelatorio.this_cCursorGrupos

        *-- Garantir cursor de grupos disponivel (modo de valida" + CHR(231) + CHR(227) + "o UI)
        IF !USED(loc_cCursorGrp)
            CREATE CURSOR (loc_cCursorGrp) (Marca N(1), cgrus C(3), dgrus C(40))
        ENDIF

        *-- Grid de grupos de produto (Grdgrupo novo SCX: top=188, left=429, width=248, height=183)
        loc_oPagina.AddObject("grd_4c_Grupos", "Grid")
        loc_oGridGrp = loc_oPagina.grd_4c_Grupos
        loc_oGridGrp.ColumnCount = 2
        WITH loc_oGridGrp
            .Top                = 103
            .Left               = 429
            .Width              = 248
            .Height             = 183
            .HeaderHeight       = 0
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .ScrollBars         = 2
            .RowHeight          = 18
            .FontName           = "Tahoma"
            .FontSize           = 8
        ENDWITH

        *-- Column1: CheckBox para Marca (sele" + CHR(231) + CHR(227) + "o do grupo) - SCX: Width=15
        *-- Sparse=.F. OBRIGATORIO: sem isso, CheckBox aparece SO na linha corrente e outras
        *-- linhas viram texto plano (0/1) ? user nao consegue clicar checkboxes das demais linhas
        WITH loc_oGridGrp.Column1
            .Width     = 15
            .Alignment = 0
            .Enabled   = .T.
            .Sparse    = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .CurrentControl = "Check1"
            .ControlSource  = loc_cCursorGrp + ".Marca"
            .Header1.Caption = ""
        ENDWITH

        *-- Column2: Descri" + CHR(231) + CHR(227) + "o do grupo (read-only) - SCX: Width=220
        WITH loc_oGridGrp.Column2
            .Width         = 220
            .ControlSource = loc_cCursorGrp + ".dgrus"
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
        ENDWITH

        loc_oGridGrp.RecordSource = loc_cCursorGrp
        loc_oGridGrp.Column1.Header1.Caption = ""
        loc_oGridGrp.Column2.Header1.Caption = "Descrs"
        loc_oGridGrp.Column2.Header1.FontName = "Tahoma"
        loc_oGridGrp.Column2.Header1.FontSize = 8
        loc_oGridGrp.Visible = .T.

        *-- Bot" + CHR(227) + "o SelTudoGrupo (Fwbtnp1 novo SCX): seleciona todos grupos
        *-- Picture=..\framework\imagens\geral_marcar_26.jpg, top=233, left=679
        loc_oPagina.AddObject("cmd_4c_SelTudoGrupo", "CommandButton")
        WITH loc_oPagina.cmd_4c_SelTudoGrupo
            .Top             = 148
            .Left            = 679
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Sel. Todos (Grupos)"
            .Visible         = .T.
        ENDWITH

        *-- Bot" + CHR(227) + "o ApagaGrupo (Fwbtnp2 novo SCX): desmarca todos grupos
        *-- Picture=..\framework\imagens\cadastro_cancelar_60.jpg, top=273, left=679
        loc_oPagina.AddObject("cmd_4c_ApagaGrupo", "CommandButton")
        WITH loc_oPagina.cmd_4c_ApagaGrupo
            .Top             = 188
            .Left            = 679
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Nenhum (Grupos)"
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENTs (m" + CHR(233) + "todos PUBLIC por padr" + CHR(227) + "o em DEFINE CLASS)
        BINDEVENT(loc_oPagina.cmd_4c_SelTudo,      "Click", THIS, "BtnSelTudoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Apaga,        "Click", THIS, "BtnApagaClick")
        BINDEVENT(loc_oPagina.cmd_4c_SelTudoGrupo, "Click", THIS, "BtnSelTudoGrupoClick")
        BINDEVENT(loc_oPagina.cmd_4c_ApagaGrupo,   "Click", THIS, "BtnApagaGrupoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTudoClick - Seleciona todos os tipos de opera" + CHR(231) + CHR(227) + "o no grid
    *   Equivale ao SelTudo.When do original: replace all marca with 1
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTudoClick()
        LOCAL loc_cCursor
        TRY
            loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE ALL Marca WITH 1
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_TipoOps.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnApagaClick - Desmarca todos os tipos de opera" + CHR(231) + CHR(227) + "o no grid
    *   Equivale ao apaga.Click do original: replace all marca with 0
    *--------------------------------------------------------------------------
    PROCEDURE BtnApagaClick()
        LOCAL loc_cCursor
        TRY
            loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE ALL Marca WITH 0
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_TipoOps.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTudoGrupoClick - Seleciona todos os grupos de produto no grid
    *   Equivale ao Fwbtnp1.When do novo SCX: replace all marca with 1 em cs_SigCdGrp
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTudoGrupoClick()
        LOCAL loc_cCursor
        TRY
            loc_cCursor = THIS.this_oRelatorio.this_cCursorGrupos
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE ALL Marca WITH 1
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grupos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnApagaGrupoClick - Desmarca todos os grupos de produto no grid
    *   Equivale ao Fwbtnp2.Click do novo SCX: replace all marca with 0 em cs_SigCdGrp
    *--------------------------------------------------------------------------
    PROCEDURE BtnApagaGrupoClick()
        LOCAL loc_cCursor
        TRY
            loc_cCursor = THIS.this_oRelatorio.this_cCursorGrupos
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE ALL Marca WITH 0
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grupos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para a pagina solicitada no PageFrame
    *   Form REPORT possui apenas 1 pagina; navega se o indice for valido
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
           VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos campos de filtro (Fase 5/8)
    *   Empresa (top=110->25), Vendedor (top=133->48), Opera" + CHR(231) + CHR(227) + "o (top=158->73), Moeda (top=318->233)
    *   Ajuste de Top: Top_Page1 = Top_original - 85 (PageFrame inicia em Top=85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- EMPRESA (NOVO SCX: lbl_Empresa top=99->14 left=71, Get_Empresa top=96->11 left=125 w=33, Get_Dempresa top=96->11 left=160 w=284)
        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 14
            .Left      = 71
            .Width     = 50
            .Height    = 15
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Top       = 11
            .Left      = 125
            .Width     = 33
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
            .MaxLength   = 3
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dempresa", "TextBox")
        WITH loc_oPagina.txt_4c_Dempresa
            .Top       = 11
            .Left      = 160
            .Width     = 284
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- VENDEDOR (NOVO SCX: Say1 top=124->39 left=66, Get_Vended top=121->36 left=125 w=81, Get_Dvend top=121->36 left=208 w=236)
        loc_oPagina.AddObject("lbl_4c_Vended", "Label")
        WITH loc_oPagina.lbl_4c_Vended
            .Top       = 39
            .Left      = 66
            .Width     = 55
            .Height    = 15
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Vended", "TextBox")
        WITH loc_oPagina.txt_4c_Vended
            .Top       = 36
            .Left      = 125
            .Width     = 81
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dvend", "TextBox")
        WITH loc_oPagina.txt_4c_Dvend
            .Top       = 36
            .Left      = 208
            .Width     = 236
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OPERACAO (NOVO SCX: lbl_dopes top=150->65 left=65, get_nm_operacao top=146->61 left=125)
        loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oPagina.lbl_4c_Operacao
            .Top       = 65
            .Left      = 65
            .Width     = 56
            .Height    = 15
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Operacao", "TextBox")
        WITH loc_oPagina.txt_4c_Operacao
            .Top       = 61
            .Left      = 125
            .Width     = 150
            .Height    = 25
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- MOEDA (NOVO SCX: Label6 top=310->225 left=76, getCmoeda top=306->221 left=125 w=31, getDmoeda top=306->221 left=161 w=115)
        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Top       = 225
            .Left      = 76
            .Width     = 45
            .Height    = 17
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cmoeda", "TextBox")
        WITH loc_oPagina.txt_4c_Cmoeda
            .Top       = 221
            .Left      = 125
            .Width     = 31
            .Height    = 25
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dmoeda", "TextBox")
        WITH loc_oPagina.txt_4c_Dmoeda
            .Top       = 221
            .Left      = 161
            .Width     = 115
            .Height    = 25
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- PERIODO (NOVO SCX: lbl_periodo top=336->251 left=70, get_dt_inicial top=333->248 left=125 w=80,
        *--                    lbl_periodo_a top=336->251 left=209, get_dt_final top=333->248 left=221 w=80)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 251
            .Left      = 70
            .Width     = 51
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Top       = 248
            .Left      = 125
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 251
            .Left      = 209
            .Width     = 8
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Top       = 248
            .Left      = 221
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- TIPO VARIACAO (Opt_TipoVars NOVO SCX: top=359->274, left=120, width=316, buttoncount=4)
        *-- Say4 "Opcao :" NOVO SCX: top=362->277, left=81, width=40
        loc_oPagina.AddObject("lbl_4c_TipoVars", "Label")
        WITH loc_oPagina.lbl_4c_TipoVars
            .Top       = 277
            .Left      = 81
            .Width     = 40
            .Height    = 15
            .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_TipoVars", "OptionGroup")
        WITH loc_oPagina.obj_4c_TipoVars
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Themes        = .F.
            .Height        = 23
            .Left          = 120
            .Top           = 274
            .Width         = 316
            .Value         = 3
            .Visible       = .T.
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoVars.Buttons(1)
            .Caption   = "Desconto"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 4
            .Width     = 78
            .Height    = 16
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoVars.Buttons(2)
            .Caption   = "Acr" + CHR(233) + "scimo"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 85
            .Top       = 4
            .Width     = 78
            .Height    = 16
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoVars.Buttons(3)
            .Caption   = "Ambos"
            .WordWrap        = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 165
            .Top       = 5
            .Width     = 68
            .Height    = 16
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoVars.Buttons(4)
            .Caption   = "Geral"
            .WordWrap        = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 239
            .Top       = 4
            .Width     = 43
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- MARGEM (getMargem NOVO SCX: top=407->322, left=332, width=45, InputMask=99.99)
        *-- Say5 "Margem :" NOVO SCX: top=411->326, left=277, width=47
        *-- Say6 "%" NOVO SCX: top=411->326, left=378, width=13
        loc_oPagina.AddObject("lbl_4c_Margem", "Label")
        WITH loc_oPagina.lbl_4c_Margem
            .Top       = 326
            .Left      = 277
            .Width     = 47
            .Height    = 15
            .Caption   = "Margem :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Margem", "TextBox")
        WITH loc_oPagina.txt_4c_Margem
            .Top       = 322
            .Left      = 332
            .Width     = 45
            .Height    = 23
            .Value     = 0
            .InputMask = "99.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_MargemPct", "Label")
        WITH loc_oPagina.lbl_4c_MargemPct
            .Top       = 326
            .Left      = 378
            .Width     = 13
            .Height    = 15
            .Caption   = "%"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TIPO IMPRESSAO (optTipoRel NOVO SCX: top=384->299, left=120, width=593, buttoncount=5)
        *-- Say3 "Tipo de Impressao :" NOVO SCX: top=387->302, left=24, width=97
        loc_oPagina.AddObject("lbl_4c_TipoRel", "Label")
        WITH loc_oPagina.lbl_4c_TipoRel
            .Top       = 302
            .Left      = 24
            .Width     = 97
            .Height    = 15
            .Caption   = "Tipo de Impress" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_TipoRel", "OptionGroup")
        WITH loc_oPagina.obj_4c_TipoRel
            .ButtonCount   = 5
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Themes        = .F.
            .Height        = 22
            .Left          = 120
            .Top           = 299
            .Width         = 593
            .Value         = 2
            .Visible       = .T.
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoRel.Buttons(1)
            .Caption   = "Sint" + CHR(233) + "tico"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 81
            .Height    = 16
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoRel.Buttons(2)
            .Caption   = "Anal" + CHR(237) + "tico"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 85
            .Top       = 3
            .Width     = 85
            .Height    = 16
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoRel.Buttons(3)
            .Caption   = "Resumo"
            .WordWrap        = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 164
            .Top       = 3
            .Width     = 66
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoRel.Buttons(4)
            .Caption   = "Desconto/Produto"
            .WordWrap        = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 240
            .Top       = 4
            .Width     = 126
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoRel.Buttons(5)
            .Caption   = "Sint" + CHR(233) + "tico Desconto/Produto"
            .AutoSize  = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 370
            .Top       = 4
            .Width     = 149
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- OBSERVACOES (Opt_obs NOVO SCX: top=407->322, left=120, width=142, buttoncount=2)
        *-- Say2 "Obs :" NOVO SCX: top=410->325, left=94
        loc_oPagina.AddObject("lbl_4c_Obs", "Label")
        WITH loc_oPagina.lbl_4c_Obs
            .Top       = 325
            .Left      = 94
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Obs :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Obs", "OptionGroup")
        WITH loc_oPagina.obj_4c_Obs
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Themes        = .F.
            .Height        = 23
            .Left          = 120
            .Top           = 322
            .Width         = 142
            .Value         = 1
            .Visible       = .T.
        ENDWITH

        WITH loc_oPagina.obj_4c_Obs.Buttons(1)
            .Caption   = "Sim"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 4
            .Width     = 42
            .Height    = 16
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oPagina.obj_4c_Obs.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 85
            .Top       = 4
            .Width     = 42
            .Height    = 16
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- BINDEVENTs: DblClick abre lookup direto; KeyPress trata F4(115) e ENTER(13)/TAB(9)
        *-- LostFocus de txt_4c_DtInicial copia valor para txt_4c_DtFinal (igual ao legado)
        BINDEVENT(loc_oPagina.txt_4c_Empresa,   "DblClick",   THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_Empresa,   "KeyPress",   THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_Dempresa,  "DblClick",   THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_Dempresa,  "KeyPress",   THIS, "TeclaDEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_Vended,    "DblClick",   THIS, "AbrirBuscaVended")
        BINDEVENT(loc_oPagina.txt_4c_Vended,    "KeyPress",   THIS, "TeclaVended")
        BINDEVENT(loc_oPagina.txt_4c_Dvend,     "DblClick",   THIS, "AbrirBuscaVended")
        BINDEVENT(loc_oPagina.txt_4c_Dvend,     "KeyPress",   THIS, "TeclaDvend")
        BINDEVENT(loc_oPagina.txt_4c_Operacao,  "DblClick",   THIS, "AbrirBuscaOperacao")
        BINDEVENT(loc_oPagina.txt_4c_Operacao,  "KeyPress",   THIS, "TeclaOperacao")
        BINDEVENT(loc_oPagina.txt_4c_Cmoeda,    "DblClick",   THIS, "AbrirBuscaMoeda")
        BINDEVENT(loc_oPagina.txt_4c_Cmoeda,    "KeyPress",   THIS, "TeclaCmoeda")
        BINDEVENT(loc_oPagina.txt_4c_Dmoeda,    "DblClick",   THIS, "AbrirBuscaMoeda")
        BINDEVENT(loc_oPagina.txt_4c_Dmoeda,    "KeyPress",   THIS, "TeclaDmoeda")
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress",  THIS, "DtInicialLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padrao do BO
    *   Empresa e moeda pre-preenchidas a partir do BO; demais campos em branco
    *   (Segunda metade: Periodo, TipoVars, TipoRel, Margem, Obs - Fase 6)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(THIS.this_oRelatorio.this_cEmpresa)
                loc_oPagina.txt_4c_Dempresa.Value = ALLTRIM(THIS.this_oRelatorio.this_cDEmpresa)
                loc_oPagina.txt_4c_Cmoeda.Value   = ALLTRIM(THIS.this_oRelatorio.this_cMoeda)
                loc_oPagina.txt_4c_Dmoeda.Value   = ALLTRIM(THIS.this_oRelatorio.this_cDMoeda)
            ENDIF
            loc_oPagina.txt_4c_Vended.Value   = ""
            loc_oPagina.txt_4c_Dvend.Value    = ""
            loc_oPagina.txt_4c_Operacao.Value = ""

            *-- Campos adicionados na Fase 6 (periodo, variacoes, margem, tipo, obs)
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPagina.txt_4c_DtInicial.Value  = THIS.this_oRelatorio.this_dDtInicial
                loc_oPagina.txt_4c_DtFinal.Value    = THIS.this_oRelatorio.this_dDtFinal
                loc_oPagina.obj_4c_TipoVars.Value   = THIS.this_oRelatorio.this_nTipoVars
                loc_oPagina.obj_4c_TipoRel.Value    = THIS.this_oRelatorio.this_nTipoRel
                loc_oPagina.txt_4c_Margem.Value     = THIS.this_oRelatorio.this_nMargem
            ELSE
                loc_oPagina.txt_4c_DtInicial.Value  = DATE()
                loc_oPagina.txt_4c_DtFinal.Value    = DATE()
                loc_oPagina.obj_4c_TipoVars.Value   = 3
                loc_oPagina.obj_4c_TipoRel.Value    = 2
                loc_oPagina.txt_4c_Margem.Value     = 0
            ENDIF
            loc_oPagina.obj_4c_Obs.Value = 1    && Sim selecionado por padrao (igual ao legado)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Empresa
    *==========================================================================

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Vendedor
    *==========================================================================

    PROCEDURE TeclaVended(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVended()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarVended()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDvend(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaVended()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Operacao
    *==========================================================================

    PROCEDURE TeclaOperacao(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperacao()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOperacao()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Moeda
    *==========================================================================

    PROCEDURE TeclaCmoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCmoeda()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDmoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Empresa
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Valida codigo e preenche razao social via SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_Dempresa.Value = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 cEmps, Razas FROM SigCdEmp WHERE cEmps = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrEmpVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpVal")
                SELECT cursor_4c_SigrEmpVal
                loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_SigrEmpVal.cEmps)
                loc_oPagina.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_SigrEmpVal.Razas)
            ELSE
                *-- Miss no match exato: abrir picker direto (LIKE prefix usa valor digitado)
                *-- MsgAviso removido (2026-07-02, Erro20) ? evitar mensagem redundante antes do picker
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_SigrEmpVal")
                USE IN cursor_4c_SigrEmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Lookup de empresa usando cursor pre-carregado do BO
    *   Usa Modo 2 de FormBuscaAuxiliar (cursor local via BO.CarregarEmpresas)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_oPagina, loc_cCursor
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCursor = "cursor_4c_SigrJanEmp"

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.CarregarEmpresas(loc_cCursor)
            ENDIF

            IF !USED(loc_cCursor)
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = loc_cCursor
                loc_oBusca.this_cTitulo        = "Selecionar Empresa"
                loc_oBusca.mAddColuna("cEmps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(cEmps)
                    loc_oPagina.txt_4c_Dempresa.Value = ALLTRIM(Razas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_SigrJanEmp")
            USE IN cursor_4c_SigrJanEmp
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Vendedor
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarVended - Valida codigo de vendedor via SigCdCli (Iclis/Rclis)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarVended()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Vended.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_Dvend.Value = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrVendVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrVendVal")
                SELECT cursor_4c_SigrVendVal
                loc_oPagina.txt_4c_Vended.Value = ALLTRIM(cursor_4c_SigrVendVal.Iclis)
                loc_oPagina.txt_4c_Dvend.Value  = ALLTRIM(cursor_4c_SigrVendVal.Rclis)
            ELSE
                *-- Miss no match exato: abrir picker direto (LIKE prefix usa valor digitado)
                *-- MsgAviso removido (2026-07-02, Erro20) ? evitar mensagem redundante antes do picker
                THIS.AbrirBuscaVended()
            ENDIF
            IF USED("cursor_4c_SigrVendVal")
                USE IN cursor_4c_SigrVendVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVended - Lookup de vendedor (SigCdCli) com filtro por GrPadVens
    *   Usa Modo 1 de FormBuscaAuxiliar; filtro por grupo de vendas se disponivel
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaVended()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cGrupo, loc_cFiltro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Vended.Value)
            loc_cGrupo  = ""
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_cGrupo = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
            ENDIF
            loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "CdGrps = " + EscaparSQL(loc_cGrupo), "")

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_SigrVendBusca", "Iclis", loc_cValor, ;
                "Selecionar Vendedor", loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_SigrVendBusca")
                        SELECT cursor_4c_SigrVendBusca
                        loc_oPagina.txt_4c_Vended.Value = ALLTRIM(cursor_4c_SigrVendBusca.Iclis)
                        loc_oPagina.txt_4c_Dvend.Value  = ALLTRIM(cursor_4c_SigrVendBusca.Rclis)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Rclis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigrVendBusca")
                        SELECT cursor_4c_SigrVendBusca
                        loc_oPagina.txt_4c_Vended.Value = ALLTRIM(cursor_4c_SigrVendBusca.Iclis)
                        loc_oPagina.txt_4c_Dvend.Value  = ALLTRIM(cursor_4c_SigrVendBusca.Rclis)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_SigrVendBusca")
            USE IN cursor_4c_SigrVendBusca
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Operacao
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarOperacao - Valida codigo de operacao via SigCdOpe (Dopes)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Operacao.Value)
            IF EMPTY(loc_cCodigo)
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrOpeVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrOpeVal")
                SELECT cursor_4c_SigrOpeVal
                loc_oPagina.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_SigrOpeVal.Dopes)
            ELSE
                *-- Miss no match exato: abrir picker direto (LIKE prefix usa valor digitado)
                *-- MsgAviso removido (2026-07-02, Erro20) ? evitar mensagem redundante antes do picker
                THIS.AbrirBuscaOperacao()
            ENDIF
            IF USED("cursor_4c_SigrOpeVal")
                USE IN cursor_4c_SigrOpeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaOperacao - Lookup de operacao via SigCdOpe (Dopes)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Operacao.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", "cursor_4c_SigrOpeBusca", "Dopes", loc_cValor, ;
                "Selecionar Opera" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_SigrOpeBusca")
                        SELECT cursor_4c_SigrOpeBusca
                        loc_oPagina.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_SigrOpeBusca.Dopes)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigrOpeBusca")
                        SELECT cursor_4c_SigrOpeBusca
                        loc_oPagina.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_SigrOpeBusca.Dopes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_SigrOpeBusca")
            USE IN cursor_4c_SigrOpeBusca
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Moeda
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCmoeda - Valida codigo de moeda e preenche descricao via SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCmoeda()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Cmoeda.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_Dmoeda.Value = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrMoeVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrMoeVal")
                SELECT cursor_4c_SigrMoeVal
                loc_oPagina.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_SigrMoeVal.CMoes)
                loc_oPagina.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_SigrMoeVal.DMoes)
            ELSE
                *-- Miss no match exato: abrir picker direto (LIKE prefix usa valor digitado)
                *-- MsgAviso removido (2026-07-02, Erro20) ? evitar mensagem redundante antes do picker
                THIS.AbrirBuscaMoeda()
            ENDIF
            IF USED("cursor_4c_SigrMoeVal")
                USE IN cursor_4c_SigrMoeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - Lookup de moeda via SigCdMoe (CMoes / DMoes)
    *   Equivale ao getDmoeda.Valid/getCmoeda.Valid com fwBuscaExt do original
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Cmoeda.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_SigrMoeBusca", "CMoes", loc_cValor, ;
                "Selecionar Moeda")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_SigrMoeBusca")
                        SELECT cursor_4c_SigrMoeBusca
                        loc_oPagina.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.CMoes)
                        loc_oPagina.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.DMoes)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigrMoeBusca")
                        SELECT cursor_4c_SigrMoeBusca
                        loc_oPagina.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.CMoes)
                        loc_oPagina.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.DMoes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_SigrMoeBusca")
            USE IN cursor_4c_SigrMoeBusca
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Data Inicial (sem lookup - handler de LostFocus)
    *==========================================================================

    *--------------------------------------------------------------------------
    * DtInicialLostFocus - Copia data inicial para data final ao sair do campo
    *   Equivale ao get_dt_inicial.LostFocus do legado
    *--------------------------------------------------------------------------
    PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_dValor
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_dValor  = loc_oPagina.txt_4c_DtInicial.Value
            IF VARTYPE(loc_dValor) = "D" AND !EMPTY(loc_dValor)
                loc_oPagina.txt_4c_DtFinal.Value = loc_dValor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  ACAO DO RELATORIO - FormParaRelatorio e handlers de botoes
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles do form para o BO
    *   Equivale ao inicio do PROCEDURE processamento do legado (leitura dos campos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cEmpresa    = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
                .this_cDEmpresa   = ALLTRIM(loc_oPagina.txt_4c_Dempresa.Value)
                .this_cVendedor   = ALLTRIM(loc_oPagina.txt_4c_Vended.Value)
                .this_cDVendedor  = ALLTRIM(loc_oPagina.txt_4c_Dvend.Value)
                .this_cNmOperacao = ALLTRIM(loc_oPagina.txt_4c_Operacao.Value)
                .this_dDtInicial  = loc_oPagina.txt_4c_DtInicial.Value
                .this_dDtFinal    = loc_oPagina.txt_4c_DtFinal.Value
                .this_cMoeda      = ALLTRIM(loc_oPagina.txt_4c_Cmoeda.Value)
                .this_cDMoeda     = ALLTRIM(loc_oPagina.txt_4c_Dmoeda.Value)
                .this_nMargem     = loc_oPagina.txt_4c_Margem.Value
                .this_nTipoVars   = loc_oPagina.obj_4c_TipoVars.Value
                .this_nTipoRel    = loc_oPagina.obj_4c_TipoRel.Value
                .this_nObs        = loc_oPagina.obj_4c_Obs.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Navega para Page2 (padrao do framework para todos os forms)
    *   Form REPORT nao possui operacao Incluir; a navegacao para Page2 e
    *   mantida para compatibilidade com o ciclo de teste automatizado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Nao aplicavel a formularios de relatorio
    *   Form REPORT nao possui operacao Alterar - usar Visualizar/Imprimir/Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Nao aplicavel a formularios de relatorio
    *   Form REPORT nao possui operacao Excluir - usar Visualizar/Imprimir/Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre preview do relatorio na tela
    *   Equivale ao btnReport.Visualiza.Click do legado (PROCEDURE documento = preview)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            *-- Guard: MsgErro apenas se ha mensagem ? ExecutarReportForm ja exibe
            *-- MsgAviso propria quando cursor esta vazio ou FRX ausente (cMensagemErro fica "")
            IF !THIS.this_oRelatorio.Atualizar() ;
               AND !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ;
                        "Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *   Equivale ao btnReport.Imprime.Click do legado (PROCEDURE impressao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Inserir() ;
               AND !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ;
                        "Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exportacao para Excel (funcionalidade DocExcel do legado)
    *   O legado usava btnReport.DocExcel que delega para metodo do framework.
    *   Implementacao: prepara dados e exporta o cursor csRelatorio para XLS.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados() ;
               AND !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ;
                        "Relat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !USED("csRelatorio") OR RECCOUNT("csRelatorio") = 0
                MsgAviso("Nenhum dado encontrado para os filtros selecionados.", ;
                         "Excel")
                RETURN
            ENDIF
            LOCAL loc_cArquivo
            loc_cArquivo = PUTFILE("Salvar como...", "RelatorioDescontos", "xls")
            IF EMPTY(loc_cArquivo)
                RETURN
            ENDIF
            COPY TO (loc_cArquivo) TYPE XL5
            MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
            THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio
    *   Equivale ao btnReport.Sair (Cancel=.T. no framework, ESC tambem fecha)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    *  CONSOLIDACAO FASE 8 - Metodos de validacao, sincronizacao e stubs CRUD
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCampos - Valida campos obrigatorios antes de gerar o relatorio
    *   Equivale ao bloco de validacao do Click button do legado
    *   (Moeda invalida / Data inicial invalida / Data final invalida)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCampos()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            IF VARTYPE(loc_oPagina.txt_4c_Cmoeda) = "O" AND ;
               EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cmoeda.Value))
                MsgAviso("Informe a moeda para gerar o relat" + CHR(243) + "rio.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Cmoeda.SetFocus()
                loc_lResultado = .F.
            ENDIF

            IF VARTYPE(loc_oPagina.txt_4c_DtInicial) = "O" AND ;
               EMPTY(loc_oPagina.txt_4c_DtInicial.Value)
                MsgAviso("Informe a data inicial do per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_DtInicial.SetFocus()
                loc_lResultado = .F.
            ENDIF

            IF VARTYPE(loc_oPagina.txt_4c_DtFinal) = "O" AND ;
               EMPTY(loc_oPagina.txt_4c_DtFinal.Value)
                MsgAviso("Informe a data final do per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_DtFinal.SetFocus()
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias compativel com FormBase: delega para FormParaRelatorio
    *   Forms REPORT nao possuem BO de CRUD; "BO" aqui e o BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega valores do BO de volta para os controles do form
    *   Usado para restaurar filtros apos reprocessamento ou preset
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O" OR ;
               VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_oPagina.txt_4c_Empresa.Value   = ALLTRIM(THIS.this_oRelatorio.this_cEmpresa)
            loc_oPagina.txt_4c_Dempresa.Value  = ALLTRIM(THIS.this_oRelatorio.this_cDEmpresa)
            loc_oPagina.txt_4c_Vended.Value    = ALLTRIM(THIS.this_oRelatorio.this_cVendedor)
            loc_oPagina.txt_4c_Dvend.Value     = ALLTRIM(THIS.this_oRelatorio.this_cDVendedor)
            loc_oPagina.txt_4c_Operacao.Value  = ALLTRIM(THIS.this_oRelatorio.this_cNmOperacao)
            loc_oPagina.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
            loc_oPagina.txt_4c_DtFinal.Value   = THIS.this_oRelatorio.this_dDtFinal
            loc_oPagina.txt_4c_Cmoeda.Value    = ALLTRIM(THIS.this_oRelatorio.this_cMoeda)
            loc_oPagina.txt_4c_Dmoeda.Value    = ALLTRIM(THIS.this_oRelatorio.this_cDMoeda)
            loc_oPagina.txt_4c_Margem.Value    = THIS.this_oRelatorio.this_nMargem
            loc_oPagina.obj_4c_TipoVars.Value  = THIS.this_oRelatorio.this_nTipoVars
            loc_oPagina.obj_4c_TipoRel.Value   = THIS.this_oRelatorio.this_nTipoRel
            loc_oPagina.obj_4c_Obs.Value       = THIS.this_oRelatorio.this_nObs
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita todos os campos de filtro
    *   Forms REPORT nao alternam modos CRUD; par_lHabilitar=.T. por padrao
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lHab
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_lHab    = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

            IF VARTYPE(loc_oPagina.txt_4c_Empresa) = "O"
                loc_oPagina.txt_4c_Empresa.Enabled  = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Dempresa) = "O"
                loc_oPagina.txt_4c_Dempresa.Enabled = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Vended) = "O"
                loc_oPagina.txt_4c_Vended.Enabled   = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Dvend) = "O"
                loc_oPagina.txt_4c_Dvend.Enabled    = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Operacao) = "O"
                loc_oPagina.txt_4c_Operacao.Enabled = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_DtInicial) = "O"
                loc_oPagina.txt_4c_DtInicial.Enabled = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_DtFinal) = "O"
                loc_oPagina.txt_4c_DtFinal.Enabled  = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Cmoeda) = "O"
                loc_oPagina.txt_4c_Cmoeda.Enabled   = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Dmoeda) = "O"
                loc_oPagina.txt_4c_Dmoeda.Enabled   = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Margem) = "O"
                loc_oPagina.txt_4c_Margem.Enabled   = loc_lHab
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel para formularios de relatorio
    *   Forms REPORT nao possuem grid de lista de registros CRUD
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel para formularios de relatorio
    *   Forms REPORT nao alternam entre modos CRUD (Incluir/Alterar/Visualizar)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Nao aplicavel para formularios de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel para formularios de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Retorna para Page1 (padrao do ciclo de navegacao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
