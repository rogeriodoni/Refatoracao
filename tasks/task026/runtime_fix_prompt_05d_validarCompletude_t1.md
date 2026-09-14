# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SIGREADSBO.prg] Indicador de pendencia: * Destroy - Limpeza de cursores e SigTempR pendente
[FormSIGREADS.prg] Procedure vazia (sem codigo): AlternarPagina

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREADS.prg):
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
                    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Carregar tipos de opera" + CHR(231) + CHR(227) + "o no grid (pula em modo de valida" + CHR(231) + CHR(227) + "o de UI)
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarTiposOperacao(THIS.this_oRelatorio.this_cCursorTipos)
                    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
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
            .AutoSize  = .T.
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
            .AutoSize  = .T.
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
            .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
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
            .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
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
            .Caption         = "Excel"
            .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
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
            .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
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

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

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
        LOCAL loc_oPagina, loc_oGrid, loc_cCursor

        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos

        *-- Label acima do grid (Label1 original: top=194, left=180, width=94)
        loc_oPagina.AddObject("lbl_4c_TipoOpe", "Label")
        WITH loc_oPagina.lbl_4c_TipoOpe
            .Top       = 109
            .Left      = 180
            .Width     = 94
            .Height    = 15
            .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
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
            .Top                = 110
            .Left               = 277
            .Width              = 279
            .Height             = 110
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .ScrollBars         = 2
            .RowHeight          = 16
            .FontName           = "Verdana"
            .FontSize           = 8
        ENDWITH

        *-- Column1: CheckBox para Marca (sele" + CHR(231) + CHR(227) + "o do tipo)
        *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS de CurrentControl
        WITH loc_oGrid.Column1
            .Width = 25
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Value   = 0
            .CurrentControl = "Check1"
            .ControlSource  = loc_cCursor + ".Marca"
            .Header1.Caption = ""
        ENDWITH

        *-- Column2: Descri" + CHR(231) + CHR(227) + "o do tipo de opera" + CHR(231) + CHR(227) + "o (read-only)
        WITH loc_oGrid.Column2
            .Width         = 250
            .ControlSource = loc_cCursor + ".Descri"
            .ReadOnly      = .T.
            .FontName      = "Verdana"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
        ENDWITH

        *-- RecordSource APOS configurar colunas (evita reset antecipado de headers)
        loc_oGrid.RecordSource = loc_cCursor

        *-- Reconfigurar headers APOS RecordSource (RecordSource reseta headers)
        loc_oGrid.Column1.Header1.Caption = ""
        loc_oGrid.Column2.Header1.Caption = "Tipo de Opera" + CHR(231) + CHR(227) + "o"
        loc_oGrid.Column2.Header1.FontName = "Tahoma"
        loc_oGrid.Column2.Header1.FontSize = 8

        loc_oGrid.Visible = .T.

        *-- Bot" + CHR(227) + "o SelTudo: seleciona todos (original SelTudo.When: replace all marca with 1)
        loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oPagina.cmd_4c_SelTudo
            .Top           = 128
            .Left          = 560
            .Width         = 65
            .Height        = 25
            .Caption       = "Sel. Todos"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH

        *-- Bot" + CHR(227) + "o Apaga: desmarca todos (original apaga.Click: replace all marca with 0)
        loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH loc_oPagina.cmd_4c_Apaga
            .Top           = 168
            .Left          = 560
            .Width         = 65
            .Height        = 25
            .Caption       = "Nenhum"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENTs (m" + CHR(233) + "todos PUBLIC por padr" + CHR(227) + "o em DEFINE CLASS)
        BINDEVENT(loc_oPagina.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Apaga,   "Click", THIS, "BtnApagaClick")
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
    * AlternarPagina - N" + CHR(227) + "o aplic" + CHR(225) + "vel para form de relat" + CHR(243) + "rio (1 p" + CHR(225) + "gina apenas)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos campos de filtro (Fase 5/8)
    *   Empresa (top=110->25), Vendedor (top=133->48), Opera" + CHR(231) + CHR(227) + "o (top=158->73), Moeda (top=318->233)
    *   Ajuste de Top: Top_Page1 = Top_original - 85 (PageFrame inicia em Top=85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- EMPRESA (original: lbl_Empresa top=110, Get_Empresa top=108, Get_Dempresa top=108)
        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 25
            .Left      = 224
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
            .Top       = 23
            .Left      = 277
            .Width     = 33
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dempresa", "TextBox")
        WITH loc_oPagina.txt_4c_Dempresa
            .Top       = 23
            .Left      = 312
            .Width     = 284
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- VENDEDOR (original: Say1 top=135, Get_Vended top=133, Get_Dvend top=133)
        *-- Get_Dvend.When original: habilitado quando Get_Vended estiver vazio
        loc_oPagina.AddObject("lbl_4c_Vended", "Label")
        WITH loc_oPagina.lbl_4c_Vended
            .Top       = 50
            .Left      = 219
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
            .Top       = 48
            .Left      = 277
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
            .Top       = 48
            .Left      = 360
            .Width     = 236
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OPERACAO (original: lbl_dopes top=161, get_nm_operacao top=158)
        loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oPagina.lbl_4c_Operacao
            .Top       = 76
            .Left      = 218
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
            .Top       = 73
            .Left      = 277
            .Width     = 150
            .Height    = 25
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- MOEDA (original: Label6 top=321, getCmoeda top=318, getDmoeda top=318)
        *-- getDmoeda.When original: habilitado quando getCmoeda estiver vazio
        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Top       = 236
            .Left      = 229
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
            .Top       = 233
            .Left      = 277
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
            .Top       = 233
            .Left      = 313
            .Width     = 115
            .Height    = 25
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- PERIODO (original: lbl_periodo top=347->262, get_dt_inicial top=345->260, get_dt_final top=345->260)
        *-- LostFocus de txt_4c_DtInicial copia valor para txt_4c_DtFinal (comportamento do legado)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 262
            .Left      = 223
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
            .Top       = 260
            .Left      = 277
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
            .Top       = 263
            .Left      = 361
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
            .Top       = 260
            .Left      = 373
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- TIPO VARIACAO (Opt_TipoVars original: top=371->286, left=272, width=316, buttoncount=4)
        *-- Say4 "Opcao :" original: top=373->288, left=234, width=40
        loc_oPagina.AddObject("lbl_4c_TipoVars", "Label")
        WITH loc_oPagina.lbl_4c_TipoVars
            .Top       = 288
            .Left      = 234
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
            .Left          = 272
            .Top           = 286
            .Width         = 316
            .Value         = 3
            .Visible       = .T.
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoVars.Buttons(1)
            .Caption   = "Desconto"
            .FontName  = "Tahoma"
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
            .FontName  = "Tahoma"
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
            .FontName  = "Tahoma"
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
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 239
            .Top       = 4
            .Width     = 43
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- MARGEM (getMargem original: top=395->310, left=574, width=45, InputMask=99.99)
        *-- Say5 "Margem :" original: top=399->314, left=524, width=47
        *-- Say6 "%" original: top=399->314, left=620, width=13
        loc_oPagina.AddObject("lbl_4c_Margem", "Label")
        WITH loc_oPagina.lbl_4c_Margem
            .Top       = 314
            .Left      = 524
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
            .Top       = 310
            .Left      = 574
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
            .Top       = 314
            .Left      = 620
            .Width     = 13
            .Height    = 15
            .Caption   = "%"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TIPO IMPRESSAO (optTipoRel original: top=396->311, left=272, width=244, buttoncount=3)
        *-- Say3 "Tipo de Impressao :" original: top=398->313, left=177, width=97
        loc_oPagina.AddObject("lbl_4c_TipoRel", "Label")
        WITH loc_oPagina.lbl_4c_TipoRel
            .Top       = 313
            .Left      = 177
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
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Themes        = .F.
            .Height        = 23
            .Left          = 272
            .Top           = 311
            .Width         = 244
            .Value         = 2
            .Visible       = .T.
        ENDWITH

        WITH loc_oPagina.obj_4c_TipoRel.Buttons(1)
            .Caption   = "Sint" + CHR(233) + "tico"
            .FontName  = "Tahoma"
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
            .FontName  = "Tahoma"
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
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 165
            .Top       = 3
            .Width     = 66
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- OBSERVACOES (Opt_obs original: top=419->334, left=272, width=248, buttoncount=2)
        *-- Say2 "Obs :" original: top=421->336, left=247
        loc_oPagina.AddObject("lbl_4c_Obs", "Label")
        WITH loc_oPagina.lbl_4c_Obs
            .Top       = 336
            .Left      = 247
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
            .Left          = 272
            .Top           = 334
            .Width         = 248
            .Value         = 1
            .Visible       = .T.
        ENDWITH

        WITH loc_oPagina.obj_4c_Obs.Buttons(1)
            .Caption   = "Sim"
            .FontName  = "Tahoma"
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
            .FontName  = "Tahoma"
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
                MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
                loc_oPagina.txt_4c_Empresa.Value  = ""
                loc_oPagina.txt_4c_Dempresa.Value = ""
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
                MsgAviso("Vendedor n" + CHR(227) + "o encontrado.", "Vendedor")
                loc_oPagina.txt_4c_Vended.Value = ""
                loc_oPagina.txt_4c_Dvend.Value  = ""
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
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", ;
                         "Opera" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Operacao.Value = ""
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
                MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Moeda")
                loc_oPagina.txt_4c_Cmoeda.Value = ""
                loc_oPagina.txt_4c_Dmoeda.Value = ""
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
    PROCEDURE DtInicialLostFocus()
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
    * BtnIncluirClick - Nao aplicavel a formularios de relatorio
    *   Form REPORT nao possui operacao Incluir - usar Visualizar/Imprimir/Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        RETURN
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
            IF !THIS.this_oRelatorio.Atualizar()
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
            IF !THIS.this_oRelatorio.Inserir()
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
            IF !THIS.this_oRelatorio.PrepararDados()
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
    * BtnCancelarClick - Nao aplicavel para formularios de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        RETURN
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


### BO (C:\4c\projeto\app\classes\SIGREADSBO.prg):
*==============================================================================
* SIGREADSBO.PRG
* Business Object para Relatorio de Apuracao de Descontos/Acrescimos
*
* Form: FormSIGREADS
* Tabelas: SigMvCab, SigMvMov, SigCdCli, SigCdOpe, SigTempR
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SIGREADSBO AS RelatorioBase

    *-- Filtros de empresa
    this_cEmpresa        = ""    && codigo empresa (cEmps em SigCdEmp - Get_Empresa)
    this_cDEmpresa       = ""    && razao social empresa (Razas em SigCdEmp - Get_Dempresa)

    *-- Filtros de vendedor
    this_cVendedor       = ""    && codigo vendedor (Iclis em SigCdCli - Get_Vended)
    this_cDVendedor      = ""    && nome vendedor (Rclis em SigCdCli - Get_Dvend)

    *-- Filtro de operacao
    this_cNmOperacao     = ""    && codigo da operacao (Dopes em SigCdOpe - get_nm_operacao, max 20)

    *-- Filtros de periodo
    this_dDtInicial      = {}    && data inicial do periodo (get_dt_inicial)
    this_dDtFinal        = {}    && data final do periodo (get_dt_final)

    *-- Filtros de moeda
    this_cMoeda          = ""    && codigo moeda (CMoes em SigCdMoe - getCmoeda, max 3)
    this_cDMoeda         = ""    && descricao moeda (DMoes em SigCdMoe - getDmoeda, max 15)

    *-- Filtro de margem
    this_nMargem         = 0     && margem de tolerancia percentual (getMargem, formato 99.99)

    *-- Opcoes de relatorio
    this_nTipoVars       = 1     && tipo variacao: 1=Desconto, 2=Acrescimo, 3=Ambos, 4=Geral (Opt_TipoVars)
    this_nObs            = 0     && imprimir observacoes: 1=Sim, 0=Nao (Opt_obs)
    this_nTipoRel        = 2     && tipo relatorio: 1=Sintetico, 2=Analitico, 3=Resumo (optTipoRel)

    *-- Flags de acesso (fChecaAcesso)
    this_lTitulos        = .F.   && exibe titulos completos (fChecaAcesso 'SigReAds','TITULOS')
    this_lNomeVend       = .F.   && exibe nome do vendedor (fChecaAcesso 'SigReAds','NOMEVEND')

    *-- Dados auxiliares carregados no Init
    this_cGrPadVens      = ""    && GrPadVens de SigCdPam (grupo padrao de vendas para lookup de vendedor)

    *-- Cursores
    this_cCursorDados    = "csRelatorio"         && cursor principal de saida para REPORT FORM
    this_cCursorTipos    = "cursor_4c_TipoOps"   && cursor com tipos de operacao selecionados no grid
    this_cIdQuery        = ""                     && ID unico para cleanup de SigTempR no modo analitico

    *--------------------------------------------------------------------------
    * Init - Configura o BO e carrega flags de acesso
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "Numes"
            THIS.this_lTitulos    = fChecaAcesso("SigReAds", "TITULOS")
            THIS.this_lNomeVend   = fChecaAcesso("SigReAds", "NOMEVEND")
            loc_lSucesso          = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosPadrao - Carrega valores iniciais de SigCdPam e empresa
    * Chamado pelo Form apos CREATEOBJECT para pre-preencher campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosPadrao()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Carregar SigCdPam para moeda e grupo padrao de vendas
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 MoePadVens, GrPadVens FROM SigCdPam", ;
                "cursor_4c_SigrPam")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrPam")
                SELECT cursor_4c_SigrPam
                THIS.this_cMoeda     = ALLTRIM(cursor_4c_SigrPam.MoePadVens)
                THIS.this_cGrPadVens = ALLTRIM(cursor_4c_SigrPam.GrPadVens)
            ENDIF
            IF USED("cursor_4c_SigrPam")
                USE IN cursor_4c_SigrPam
            ENDIF

            *-- Empresa e datas padrao
            THIS.this_cEmpresa   = go_4c_Sistema.cCodEmpresa
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()

            *-- Descricao da moeda padrao
            IF !EMPTY(THIS.this_cMoeda)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 DMoes FROM SigCdMoe WHERE CMoes = " + ;
                    EscaparSQL(THIS.this_cMoeda), "cursor_4c_SigrMoe")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrMoe")
                    SELECT cursor_4c_SigrMoe
                    THIS.this_cDMoeda = ALLTRIM(cursor_4c_SigrMoe.DMoes)
                ENDIF
                IF USED("cursor_4c_SigrMoe")
                    USE IN cursor_4c_SigrMoe
                ENDIF
            ENDIF

            *-- Descricao da empresa padrao
            IF !EMPTY(THIS.this_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                    EscaparSQL(THIS.this_cEmpresa), "cursor_4c_SigrEmpPad")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpPad")
                    SELECT cursor_4c_SigrEmpPad
                    THIS.this_cDEmpresa = ALLTRIM(cursor_4c_SigrEmpPad.Razas)
                ENDIF
                IF USED("cursor_4c_SigrEmpPad")
                    USE IN cursor_4c_SigrEmpPad
                ENDIF
            ENDIF

            *-- Valores padrao das opcoes (igual ao legado: TipoVars=3, TipoRel=2)
            THIS.this_nTipoVars = 3
            THIS.this_nTipoRel  = 2
            THIS.this_nObs      = 0
            THIS.this_nMargem   = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacao - Carrega SigCdTom para cursor do grid de tipos
    * par_cCursorDestino: nome do cursor a criar (ex: cursor_4c_TipoOps)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposOperacao(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nResult, loc_nMarca
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF
            CREATE CURSOR (par_cCursorDestino) (Marca N(1), Codigos N(2), Descri C(40))
            INDEX ON Codigos TAG Codigos

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos", ;
                "cursor_4c_SigrTomTmp")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrTomTmp
                SCAN
                    loc_nMarca = IIF(INLIST(cursor_4c_SigrTomTmp.Codigos, 4, 5), 1, 0)
                    INSERT INTO (par_cCursorDestino) (Marca, Codigos, Descri) ;
                        VALUES (loc_nMarca, cursor_4c_SigrTomTmp.Codigos, ;
                                ALLTRIM(STR(cursor_4c_SigrTomTmp.Codigos, 2)) + "-" + ;
                                ALLTRIM(cursor_4c_SigrTomTmp.Descrs))
                ENDSCAN
                USE IN cursor_4c_SigrTomTmp
            ENDIF

            SELECT (par_cCursorDestino)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega SigCdEmp (exceto oficiais) para lookup
    * par_cCursorDestino: nome do cursor a criar (ex: cursor_4c_SigrJanEmp)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cEmps, Razas, TipoNFs FROM SigCdEmp " + ;
                "WHERE NOT TipoNFs = 2 ORDER BY cEmps", ;
                par_cCursorDestino)
            IF loc_nResult > 0
                SELECT (par_cCursorDestino)
                INDEX ON cEmps TAG cEmps
                INDEX ON Razas TAG Razas
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Descontos/Acrescimos
    * Equivale ao PROCEDURE processamento do legado (SIGREADS.SCX)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_cEmpresa, loc_cOperacao, loc_cVendedor, loc_cMoedaOper
        LOCAL loc_cDtIniStr, loc_cDtFimStr, loc_cDtIniBase, loc_cDtFimBase
        LOCAL loc_nTipoVars, loc_nObs, loc_nTipoRel, loc_nMargem
        LOCAL loc_lAnalitico, loc_cIdQuery
        LOCAL loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo, loc_lNomeVend, loc_cNmEmpresa
        LOCAL loc_cSQL, loc_nResult, loc_cWhere, loc_cNumOp, loc_cWhere1, loc_cWhere2
        LOCAL loc_cEmpDopNums, loc_cUniqueId, loc_nDif, loc_nRec
        LOCAL loc_nTotI1, loc_nTotI2, loc_nResto, loc_nRateio, loc_nVlVend
        LOCAL loc_nItnV, loc_nGerV, loc_cEmpV, loc_cVenV, loc_nNumV
        LOCAL loc_cEmpO, loc_cVenO, loc_nNumO, loc_nMarca

        loc_lSucesso = .F.
        TRY
            *-- 1. Ler filtros das propriedades THIS
            loc_cEmpresa   = ALLTRIM(THIS.this_cEmpresa)
            loc_cOperacao  = ALLTRIM(THIS.this_cNmOperacao)
            loc_cMoedaOper = ALLTRIM(THIS.this_cMoeda)
            loc_cVendedor  = ALLTRIM(THIS.this_cVendedor)
            loc_nTipoVars  = THIS.this_nTipoVars
            loc_nObs       = THIS.this_nObs
            loc_nTipoRel   = THIS.this_nTipoRel
            loc_nMargem    = THIS.this_nMargem
            loc_lAnalitico = (loc_nTipoRel # 1)

            *-- Formatar datas para SQL (DTOS retorna YYYYMMDD)
            loc_cDtIniBase = DTOS(THIS.this_dDtInicial)
            loc_cDtFimBase = DTOS(THIS.this_dDtFinal)
            loc_cDtIniStr  = "'" + SUBSTR(loc_cDtIniBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtIniBase,5,2) + "-" + SUBSTR(loc_cDtIniBase,7,2) + "'"
            loc_cDtFimStr  = "'" + SUBSTR(loc_cDtFimBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtFimBase,5,2) + "-" + SUBSTR(loc_cDtFimBase,7,2) + ;
                              " 23:59:59'"

            *-- 2. Textos do cabecalho
            loc_lcPeriodo = "PERIODO : " + DTOC(THIS.this_dDtInicial) + ;
                            " A " + DTOC(THIS.this_dDtFinal)
            IF THIS.this_lTitulos
                loc_lcTitulo  = "RELA" + CHR(199) + CHR(195) + "O DE APURA" + ;
                                CHR(199) + CHR(195) + "O DE DESCONTOS/ACR" + ;
                                CHR(201) + "SCIMOS"
                loc_lcSubTit  = "MOEDA : " + loc_cMoedaOper + " - " + ;
                                ALLTRIM(THIS.this_cDMoeda) + ;
                                IIF(!EMPTY(loc_nMargem), ;
                                    " - Margem : " + ALLTRIM(STR(loc_nMargem,5,2)) + "%", "")
                loc_lNomeVend = THIS.this_lNomeVend
            ELSE
                loc_lcTitulo  = "RAPDE"
                loc_lcSubTit  = loc_cMoedaOper + ;
                                IIF(!EMPTY(loc_nMargem), ;
                                    " - (" + ALLTRIM(STR(loc_nMargem,5,2)) + "%)", "")
                loc_lNomeVend = .F.
            ENDIF

            *-- 3. Nome da empresa
            loc_cNmEmpresa = loc_cEmpresa
            IF !EMPTY(loc_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                    EscaparSQL(loc_cEmpresa), "cursor_4c_SigrEmpRel")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpRel")
                    SELECT cursor_4c_SigrEmpRel
                    loc_cNmEmpresa = ALLTRIM(cursor_4c_SigrEmpRel.Razas)
                ENDIF
                IF USED("cursor_4c_SigrEmpRel")
                    USE IN cursor_4c_SigrEmpRel
                ENDIF
            ENDIF

            *-- 4. Cursor de cabecalho do relatorio
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (NomeEmp C(80), Titulo C(80), Titulo2 C(200), ;
                                        Titulo3 C(200), tObs N(1), Analitico L(1), ;
                                        NVend L(1), Titulos L(1))
            INSERT INTO csCabecalho ;
                (NomeEmp, Titulo, Titulo2, Titulo3, tObs, Analitico, NVend, Titulos) ;
                VALUES (loc_cNmEmpresa, loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo, ;
                        loc_nObs, loc_lAnalitico, loc_lNomeVend, THIS.this_lTitulos)

            *-- 5. Limpar cursores de execucao anterior
            IF USED("csRelatorio")
                USE IN csRelatorio
            ENDIF
            IF USED("csProdutos")
                USE IN csProdutos
            ENDIF
            IF USED("csSqlEest")
                USE IN csSqlEest
            ENDIF
            IF USED("csSqlEest2")
                USE IN csSqlEest2
            ENDIF
            IF USED("TmpCsRelat")
                USE IN TmpCsRelat
            ENDIF
            IF USED("TmpCsRela2")
                USE IN TmpCsRela2
            ENDIF
            IF USED("csRelatorio1")
                USE IN csRelatorio1
            ENDIF

            *-- 6. Montar clausula de tipos de operacao selecionados no grid
            loc_cNumOp = ""
            IF EMPTY(loc_cOperacao) AND USED(THIS.this_cCursorTipos)
                SELECT (THIS.this_cCursorTipos)
                SCAN
                    IF Marca > 0
                        loc_cNumOp = loc_cNumOp + ;
                            IIF(!EMPTY(loc_cNumOp), " Or ", "(") + ;
                            "o.TipoOps = " + ALLTRIM(STR(Codigos, 2))
                    ENDIF
                ENDSCAN
                IF LEN(loc_cNumOp) > 1
                    loc_cNumOp = loc_cNumOp + ")"
                ENDIF
            ENDIF

            SET DECIMALS TO 2
            SET FIXED ON

            *-- 7. Query 1: SigMvCab+SigMvMov+SigCdCli+SigCdOpe (ValPres = 1 ou 3)
            loc_cWhere = IIF(!EMPTY(loc_cEmpresa), ;
                             "a.Emps = " + EscaparSQL(loc_cEmpresa) + " And ", "") + ;
                         "a.Emps = b.Emps And a.Dopes = b.Dopes And a.Numes = b.Numes And " + ;
                         "a.Datas Between " + loc_cDtIniStr + " And " + loc_cDtFimStr + " And " + ;
                         "a.Dopes = o.Dopes And " + ;
                         IIF(!EMPTY(loc_cOperacao), ;
                             "a.Dopes = " + EscaparSQL(loc_cOperacao) + " And ", "") + ;
                         IIF(!EMPTY(loc_cVendedor), ;
                             "a.Vends = " + EscaparSQL(loc_cVendedor) + " And ", "") + ;
                         "a.Vends = c.Iclis And " + ;
                         IIF(EMPTY(loc_cOperacao) AND !EMPTY(loc_cNumOp), ;
                             loc_cNumOp + " And ", "") + ;
                         "(o.ValPres = 1 Or o.ValPres = 3)"

            loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, " + ;
                       "b.nSinals, b.ValItens, b.Moeds, a.Datas, " + ;
                       "b.ValTots, a.CodObs, a.Obses, a.Usuars " + ;
                       "From SigMvCab a, SigMvMov b, SigCdCli c, SigCdOpe o " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSqlEest")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados (csSqlEest)"
                loc_lSucesso = .F.
            ENDIF

            *-- 8. VFP SELECT cotacao -> TmpCsRelat
            SELECT csSqlEest
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
                   SUM(IIF(nSinals < 0, -1, 1) * ValItens * ;
                       fBuscarCotacao(Moeds, Datas, gnConnHandle) / ;
                       fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as ValInis, ;
                   (ValTots * fBuscarCotacao(Moeds, Datas, gnConnHandle) / ;
                    fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as Valos, ;
                   CodObs, "CAB" as Tp, 1 as Soma ;
                   FROM csSqlEest ;
                   INTO CURSOR TmpCsRelat ;
                   GROUP BY Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, 9, CodObs

            *-- 9. Query 2: SigMvCab+SigCdCli+SigCdOpe (NOT ValPres = 1 ou 3)
            loc_cWhere = IIF(!EMPTY(loc_cEmpresa), ;
                             "a.Emps = " + EscaparSQL(loc_cEmpresa) + " And ", "") + ;
                         "a.Datas Between " + loc_cDtIniStr + " And " + loc_cDtFimStr + " And " + ;
                         "Not a.Valvars = 0 And " + ;
                         "a.Dopes = o.Dopes And " + ;
                         IIF(!EMPTY(loc_cOperacao), ;
                             "a.Dopes = " + EscaparSQL(loc_cOperacao) + " And ", "") + ;
                         IIF(!EMPTY(loc_cVendedor), ;
                             "a.Vends = " + EscaparSQL(loc_cVendedor) + " And ", "") + ;
                         "a.Vends = c.Iclis And " + ;
                         IIF(EMPTY(loc_cOperacao) AND !EMPTY(loc_cNumOp), ;
                             loc_cNumOp + " And ", "") + ;
                         "Not (o.ValPres = 1 Or o.ValPres = 3)"

            loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, " + ;
                       "a.ValInis, o.cMoes, a.Datas, " + ;
                       "a.Valos, a.CodObs, a.Obses, a.Usuars " + ;
                       "From SigMvCab a, SigCdCli c, SigCdOpe o " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSqlEest2")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados (csSqlEest2)"
                loc_lSucesso = .F.
            ENDIF

            *-- 10. VFP SELECT cotacao -> TmpCsRela2
            SELECT csSqlEest2
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
                   SUM(ValInis * ;
                       IIF(EMPTY(cMoes), 1, fBuscarCotacao(cMoes, Datas, gnConnHandle)) / ;
                       fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as ValInis, ;
                   (Valos * ;
                    IIF(EMPTY(cMoes), 1, fBuscarCotacao(cMoes, Datas, gnConnHandle)) / ;
                    fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as Valos, ;
                   CodObs, "CAB" as Tp, 1 as Soma ;
                   FROM csSqlEest2 ;
                   INTO CURSOR TmpCsRela2 ;
                   GROUP BY Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, 9, CodObs

            *-- 11. Condicoes de filtro por tipo de variacao
            loc_cWhere1 = IIF(loc_nTipoVars=1, ;
                              "ValInis > Valos Or (ValInis = 0 And Not Valos = 0)", ;
                          IIF(loc_nTipoVars=2, "ValInis < Valos Or ValInis = 0", ;
                          IIF(loc_nTipoVars=3, "Not ValInis = Valos", "0=0")))

            loc_cWhere2 = IIF(loc_nTipoVars=1, "ValInis > Valos", ;
                          IIF(loc_nTipoVars=2, "ValInis < Valos", ;
                          IIF(loc_nTipoVars=3, "Not ValInis = Valos", "0=0")))

            *-- 12. UNION ALL das duas selects -> csRelatorio1
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, ;
                   Tp, Soma, ;
                   SPACE(14) as CPros, 00000000000000 as CBars, ;
                   SPACE(40) as DPros, SPACE(1) as Opers, ;
                   000000.00 as Qtds, 00000.000000 as Units, ;
                   000000000.00 as Totas, 000000000.00 as DifVal, Usuars ;
                   FROM TmpCsRelat ;
                   WHERE &loc_cWhere1. ;
                   UNION ALL ;
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, ;
                   Tp, Soma, ;
                   SPACE(14) as CPros, 00000000000000 as CBars, ;
                   SPACE(40) as DPros, SPACE(1) as Opers, ;
                   000000.00 as Qtds, 00000.000000 as Units, ;
                   000000000.00 as Totas, 000000000.00 as DifVal, Usuars ;
                   FROM TmpCsRela2 ;
                   WHERE &loc_cWhere2. ;
                   INTO CURSOR csRelatorio1 ;
                   ORDER BY 1, 5, 2, 3, 11

            *-- 13. Cursor de observacoes unificado
            IF USED("TmpObses")
                USE IN TmpObses
            ENDIF
            SELECT Emps, Dopes, Numes, Obses FROM csSqlEest ;
            UNION ALL ;
            SELECT Emps, Dopes, Numes, Obses FROM csSqlEest2 ;
            INTO CURSOR TmpObses ;
            ORDER BY 1, 2, 3

            *-- 14. Left join observacoes -> csRelatorio READWRITE
            SELECT a.*, b.Obses FROM csRelatorio1 a ;
                               LEFT JOIN TmpObses b ;
                               ON a.Emps = b.Emps AND a.Dopes = b.Dopes AND ;
                                  a.Numes = b.Numes ;
                               INTO CURSOR csRelatorio READWRITE

            SELECT csRelatorio
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
            INDEX ON Emps + Vends + Dopes + STR(Numes, 6) + Tp TAG VdDpNmTp

            *-- 15. Filtrar pela margem de tolerancia
            IF !EMPTY(loc_nMargem)
                SELECT csRelatorio
                SCAN
                    IF ABS(100 - ((Valos*100) / IIF(ValInis#0, ValInis, 1))) < loc_nMargem
                        DELETE
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 16. Modo analitico: inserir cabecalhos em SigTempR e buscar produtos
            IF loc_lAnalitico
                loc_cIdQuery = SYS(2015)
                THIS.this_cIdQuery = loc_cIdQuery

                *-- Limpar registros anteriores desta query
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE CIdQuerys = " + EscaparSQL(loc_cIdQuery))

                *-- Inserir cada cabecalho no SigTempR via SQL
                SELECT csRelatorio
                GO TOP
                SCAN
                    loc_cEmpDopNums = PADR(csRelatorio.Emps, 3) + ;
                                      PADR(csRelatorio.Dopes, 20) + ;
                                      STR(csRelatorio.Numes, 6)
                    loc_cUniqueId = SYS(2015)

                    loc_cSQL = "INSERT INTO SigTempR " + ;
                               "(Emps, Dopes, Numes, MascNum, CPros, Razas, Valors, Qtds, " + ;
                               "CodObs, Obss, EmpDopNums, CIdQuerys, CIdChaves, Contas) " + ;
                               "VALUES (" + ;
                               EscaparSQL(csRelatorio.Emps) + ", " + ;
                               EscaparSQL(csRelatorio.Dopes) + ", " + ;
                               TRANSFORM(csRelatorio.Numes) + ", " + ;
                               EscaparSQL(csRelatorio.MascNum) + ", " + ;
                               EscaparSQL(csRelatorio.Vends) + ", " + ;
                               EscaparSQL(csRelatorio.RClis) + ", " + ;
                               FormatarNumeroSQL(csRelatorio.Valos) + ", " + ;
                               FormatarNumeroSQL(csRelatorio.ValInis) + ", " + ;
                               EscaparSQL(csRelatorio.CodObs) + ", " + ;
                               EscaparSQL(csRelatorio.Obses) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               EscaparSQL(loc_cIdQuery) + ", " + ;
                               EscaparSQL(loc_cUniqueId) + ", " + ;
                               EscaparSQL(csRelatorio.Usuars) + ")"

                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT csRelatorio
                ENDSCAN

                *-- Buscar produtos de SigTempR + SigMvItn
                loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.CPros As Vends, " + ;
                           "a.Razas As RClis, a.Qtds As ValInis, a.Valors As Valos, " + ;
                           "a.CodObs, a.Obss as Obses, 'ITN' as Tp, 0 as Soma, " + ;
                           "b.CPros, b.CodBarras as CBars, b.DPros, b.Opers, b.Qtds, " + ;
                           "b.Totas As Units, b.Totas, 99999999.99 as DifVal, " + ;
                           "a.Contas as Usuars " + ;
                           "From SigTempR a, SigMvItn b " + ;
                           "Where a.EmpDopNums = b.EmpDopNums And a.CIdQuerys = " + ;
                           EscaparSQL(loc_cIdQuery)

                IF USED("csProdutos")
                    USE IN csProdutos
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csProdutos")

                IF loc_nResult > 0
                    SELECT csProdutos
                    INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                    INDEX ON Emps + Vends + STR(Numes, 6) TAG EmpVenNum

                    *-- Calcular DifVal (diferenca real paga) por nota
                    SET ORDER TO EmpDopNum
                    REPLACE ALL DifVal WITH 0

                    SCAN
                        loc_nDif = 0
                        IF USED("crSigMvMov")
                            USE IN crSigMvMov
                        ENDIF
                        loc_cSQL = "SELECT ValtOts, Nsinals, ValItens FROM SigMvMov " + ;
                                   "WHERE EmpDopNums = " + ;
                                   EscaparSQL(csProdutos.Emps + csProdutos.Dopes + ;
                                              STR(csProdutos.Numes, 6))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvMov") > 0
                            SELECT crSigMvMov
                            SCAN
                                loc_nDif = loc_nDif + crSigMvMov.Valtots - ;
                                           (crSigMvMov.Nsinals * crSigMvMov.Valitens)
                            ENDSCAN
                            USE IN crSigMvMov
                        ENDIF
                        REPLACE DifVal WITH loc_nDif IN csProdutos
                        SELECT csProdutos
                    ENDSCAN

                    *-- Calcular rateio de desconto/acrescimo por produto
                    SET ORDER TO EmpVenNum
                    GO TOP
                    DO WHILE !EOF()
                        loc_cEmpV  = csProdutos.Emps
                        loc_cVenV  = csProdutos.Vends
                        loc_nNumV  = csProdutos.Numes
                        loc_nTotI1 = 0
                        loc_nRec   = RECNO()
                        loc_nDif   = 0
                        loc_nItnV  = 0
                        loc_nGerV  = 0

                        SCAN WHILE csProdutos.Emps=loc_cEmpV AND ;
                                    csProdutos.Vends=loc_cVenV AND ;
                                    csProdutos.Numes=loc_nNumV
                            IF !INLIST(csProdutos.Cpros, ;
                                       PADR("CP",14), PADR("CR",14), ;
                                       PADR("C",14), PADR("E",14)) ;
                               AND csProdutos.Opers = "S"
                                loc_nItnV  = loc_nItnV + csProdutos.Totas
                                loc_nTotI1 = loc_nTotI1 + 1
                            ENDIF
                            loc_nGerV = loc_nGerV + csProdutos.Totas
                            loc_nDif  = IIF(EMPTY(loc_nDif), csProdutos.DifVal, loc_nDif)
                        ENDSCAN

                        loc_nResto = loc_nDif
                        IF loc_nGerV < 0
                            loc_nResto = ABS(loc_nResto)
                        ENDIF

                        loc_nTotI2 = 0
                        GO loc_nRec
                        SCAN WHILE csProdutos.Emps=loc_cEmpV AND ;
                                    csProdutos.Vends=loc_cVenV AND ;
                                    csProdutos.Numes=loc_nNumV
                            IF !INLIST(csProdutos.Cpros, ;
                                       PADR("CP",14), PADR("CR",14), ;
                                       PADR("C",14), PADR("E",14)) ;
                               AND csProdutos.Opers = "S"
                                loc_nTotI2 = loc_nTotI2 + 1
                                loc_nRateio = ROUND(loc_nDif * ;
                                    (csProdutos.Totas / IIF(loc_nItnV <> 0, loc_nItnV, 1)), 0)
                                IF loc_nTotI1 = loc_nTotI2
                                    loc_nVlVend = csProdutos.Totas + loc_nResto
                                ELSE
                                    loc_nVlVend = csProdutos.Totas + loc_nRateio
                                    loc_nResto  = loc_nResto - loc_nRateio
                                ENDIF
                                REPLACE Totas WITH loc_nVlVend IN csProdutos
                            ENDIF
                        ENDSCAN
                    ENDDO

                    *-- Inserir produtos processados no csRelatorio
                    SELECT csProdutos
                    SCAN
                        INSERT INTO csRelatorio ;
                            (Emps, Dopes, Numes, MascNum, Vends, Rclis, ;
                             ValInis, Valos, CodObs, Obses, Tp, Soma, ;
                             CPros, CBars, DPros, Opers, Qtds, Units, ;
                             Totas, DifVal, Usuars) ;
                            VALUES (csProdutos.Emps, csProdutos.Dopes, ;
                                    csProdutos.Numes, csProdutos.MascNum, ;
                                    csProdutos.Vends, csProdutos.RClis, ;
                                    0, 0, csProdutos.CodObs, csProdutos.Obses, ;
                                    csProdutos.Tp, csProdutos.Soma, ;
                                    csProdutos.CPros, csProdutos.CBars, ;
                                    csProdutos.DPros, csProdutos.Opers, ;
                                    csProdutos.Qtds, csProdutos.Units, ;
                                    csProdutos.Totas, csProdutos.DifVal, ;
                                    csProdutos.Usuars)
                    ENDSCAN
                ENDIF

                *-- Limpar SigTempR desta query
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE CIdQuerys = " + EscaparSQL(loc_cIdQuery))
                THIS.this_cIdQuery = ""
            ENDIF

            *-- 17. Processar observacoes (marcar registros OB)
            IF loc_nObs = 1
                SELECT csRelatorio
                SET ORDER TO VdDpNmTp DESCENDING
                loc_cEmpO = ""
                loc_cVenO = ""
                loc_nNumO = 0
                SCAN
                    IF loc_cEmpO # csRelatorio.Emps OR ;
                       loc_cVenO # csRelatorio.Vends OR ;
                       loc_nNumO # csRelatorio.Numes
                        REPLACE Tp WITH "OB" + SUBS(csRelatorio.Tp, 1, 1) IN csRelatorio
                        loc_cEmpO = csRelatorio.Emps
                        loc_cVenO = csRelatorio.Vends
                        loc_nNumO = csRelatorio.Numes
                    ENDIF
                ENDSCAN
                SET ORDER TO VdDpNmTp ASCENDING
            ENDIF

            *-- 18. Modo Resumo: agregar por empresa
            IF loc_nTipoRel = 3
                IF USED("csTot1")
                    USE IN csTot1
                ENDIF
                IF USED("csTot2")
                    USE IN csTot2
                ENDIF

                SELECT Emps, COUNT(1) as TotSoma ;
                       FROM TmpCsRelat ;
                       GROUP BY Emps ;
                       INTO CURSOR csTot1
                INDEX ON Emps TAG Emps

                SELECT Emps, COUNT(1) as TotSoma ;
                       FROM TmpCsRela2 ;
                       GROUP BY Emps ;
                       INTO CURSOR csTot2
                INDEX ON Emps TAG Emps

                IF USED("csRelatorio")
                    USE IN csRelatorio
                ENDIF
                SELECT Emps, ;
                       SUM(ValInis) as ValInis, ;
                       SUM(Valos) as Valos, ;
                       SUM(IIF(ValInis > Valos, ValInis - Valos, 0)) as Desconto, ;
                       SUM(IIF(Valos > ValInis, Valos - ValInis, 0)) as Acrescimo, ;
                       SUM(Soma) as Soma, ;
                       0 as TotSoma ;
                       FROM csRelatorio ;
                       GROUP BY Emps ;
                       INTO CURSOR csRelatorio READWRITE

                SELECT csRelatorio
                SCAN
                    IF SEEK(csRelatorio.Emps, "csTot1", "Emps")
                        REPLACE TotSoma WITH TotSoma + csTot1.TotSoma IN csRelatorio
                    ENDIF
                    IF SEEK(csRelatorio.Emps, "csTot2", "Emps")
                        REPLACE TotSoma WITH TotSoma + csTot2.TotSoma IN csRelatorio
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 19. Posicionar no inicio
            SELECT csRelatorio
            SET ORDER TO VdDpNmTp
            GOTO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirRelatorio - Executa REPORT FORM com dados preparados
    * par_lVisualizar: .T. = visualizar na tela, .F. = imprimir direto
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirRelatorio(par_lVisualizar)
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                THIS.this_cMensagemErro = "Erro ao preparar dados para o relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            IF !USED("csRelatorio") OR RECCOUNT("csRelatorio") = 0
                MsgAviso("Nenhum dado encontrado para os filtros selecionados.", ;
                         "Relat" + CHR(243) + "rio")
                loc_lSucesso = .T.
            ENDIF

            IF THIS.this_nTipoRel = 3
                loc_cFrx = "SigReAd2"
            ELSE
                loc_cFrx = "SigReAd1"
            ENDIF

            IF par_lVisualizar
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao do relatorio
    * par_cAliasCursor: nome do cursor com colunas de filtro (formato preset)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset nao disponivel: " + ;
                                          ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            *-- SCATTER MEMVAR para acessar colunas dinamicamente
            SCATTER MEMVAR

            IF TYPE("m.cEmpresa") = "C"
                THIS.this_cEmpresa = ALLTRIM(m.cEmpresa)
            ENDIF
            IF TYPE("m.cDEmpresa") = "C"
                THIS.this_cDEmpresa = ALLTRIM(m.cDEmpresa)
            ENDIF
            IF TYPE("m.cVendedor") = "C"
                THIS.this_cVendedor = ALLTRIM(m.cVendedor)
            ENDIF
            IF TYPE("m.cDVendedor") = "C"
                THIS.this_cDVendedor = ALLTRIM(m.cDVendedor)
            ENDIF
            IF TYPE("m.cNmOperacao") = "C"
                THIS.this_cNmOperacao = ALLTRIM(m.cNmOperacao)
            ENDIF
            IF TYPE("m.dDtInicial") = "D"
                THIS.this_dDtInicial = m.dDtInicial
            ENDIF
            IF TYPE("m.dDtFinal") = "D"
                THIS.this_dDtFinal = m.dDtFinal
            ENDIF
            IF TYPE("m.cMoeda") = "C"
                THIS.this_cMoeda = ALLTRIM(m.cMoeda)
            ENDIF
            IF TYPE("m.cDMoeda") = "C"
                THIS.this_cDMoeda = ALLTRIM(m.cDMoeda)
            ENDIF
            IF TYPE("m.nMargem") = "N"
                THIS.this_nMargem = m.nMargem
            ENDIF
            IF TYPE("m.nTipoVars") = "N"
                THIS.this_nTipoVars = m.nTipoVars
            ENDIF
            IF TYPE("m.nObs") = "N"
                THIS.this_nObs = m.nObs
            ENDIF
            IF TYPE("m.nTipoRel") = "N"
                THIS.this_nTipoRel = m.nTipoRel
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Delega para ImprimirRelatorio(.F.) e registra auditoria de impressao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          " obrigat" + CHR(243) + "rio para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ImprimirRelatorio(.F.)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Delega para ImprimirRelatorio(.T.) e registra auditoria de visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          " obrigat" + CHR(243) + "rio para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ImprimirRelatorio(.T.)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = "EMP=" + ALLTRIM(THIS.this_cEmpresa) + ;
                         ";PER=" + DTOC(THIS.this_dDtInicial) + "-" + DTOC(THIS.this_dDtFinal) + ;
                         ";VEND=" + ALLTRIM(THIS.this_cVendedor) + ;
                         ";OPE=" + ALLTRIM(THIS.this_cNmOperacao) + ;
                         ";MOE=" + ALLTRIM(THIS.this_cMoeda) + ;
                         ";TR=" + ALLTRIM(STR(THIS.this_nTipoRel, 1))

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(dtOperacao, cUsuario, cTabela, cOperacao, cChave) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReAds") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores e SigTempR pendente
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cIdQuery)
            SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigTempR WHERE CIdQuerys = " + ;
                EscaparSQL(THIS.this_cIdQuery))
            THIS.this_cIdQuery = ""
        ENDIF
        IF USED("csRelatorio")
            USE IN csRelatorio
        ENDIF
        IF USED("csProdutos")
            USE IN csProdutos
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("csSqlEest")
            USE IN csSqlEest
        ENDIF
        IF USED("csSqlEest2")
            USE IN csSqlEest2
        ENDIF
        IF USED("TmpCsRelat")
            USE IN TmpCsRelat
        ENDIF
        IF USED("TmpCsRela2")
            USE IN TmpCsRela2
        ENDIF
        IF USED("TmpObses")
            USE IN TmpObses
        ENDIF
        IF USED("csRelatorio1")
            USE IN csRelatorio1
        ENDIF
        IF USED("csTot1")
            USE IN csTot1
        ENDIF
        IF USED("csTot2")
            USE IN csTot2
        ENDIF
        IF USED(THIS.this_cCursorTipos)
            USE IN (THIS.this_cCursorTipos)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

