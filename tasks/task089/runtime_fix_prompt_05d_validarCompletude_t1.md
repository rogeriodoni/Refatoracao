# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigReEqT.prg] Procedure vazia (sem codigo): HabilitarCampos
[FormSigReEqT.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEqT.prg):
*==============================================================================
* FORMSIGREET.PRG
* Visualizador de Estoque Retroativo
* Tipo: REPORT / VIEWER (herda FormBase, BO herda RelatorioBase)
* Migrado de: SigReEqT.SCX (frmrelatorio)
*
* Este form eh filho - aberto por um form pai que ja processou os dados.
* Recebe o form pai via Init(par_oFormPai) e compartilha sua DataSession
* para acessar os cursores cursor_4c_TempoGr e cursor_4c_TempoCp.
*
* Opt_Key (opt_4c_Opcao): Value=1=Analitico, Value=2=Sintetico (padrao)
*   Page1 = Resultado (cursor_4c_TempoGr  - visao sintetica por grupo)
*   Page2 = Produtos  (cursor_4c_TempoCp  - visao analitica por produto)
*
* FASE 8/8 - CONCLUIDA
*   Este form nao tem campos de filtro nem lookups - eh um visualizador
*   que recebe cursores pre-carregados do form pai via DataSession.
*   Integracao automatica via config.prg (ADIR de forms/relatorios/*.prg
*   e classes/*BO.prg). Nao precisa de entrada de menu direto (form filho).
*
*   Implementacao completa:
*   * Init(par_oFormPai)          - recebe form pai, fConfigGeral, DataSession
*   * InicializarForm()           - constroi cabecalho, botoes, opcao, PageFrame
*   * ConfigurarCabecalho()       - container escuro superior com titulo
*   * ConfigurarBotoes()          - CommandGroup 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
*   * ConfigurarOpcao()           - OptionGroup Analitico/Sintetico (Opt_Key)
*   * ConfigurarPageFrame()       - PageFrame 2 paginas (Resultado/Produtos)
*   * ConfigurarPaginaLista()     - Grid Page1 (9 colunas - visao sintetica)
*   * ConfigurarPaginaDados()     - Grid Page2 (8 colunas - visao analitica)
*   * AlternarPagina()            - troca pagina conforme opt_4c_Opcao.Value
*   * ConfigurarEventos()         - BINDEVENTs botoes, opcao e paginas
*   * FormParaRelatorio()         - passa opcao selecionada ao BO (centralizado)
*   * LimparCampos()              - reposiciona cursors no topo
*   * CarregarLista()             - atualiza grid da pagina ativa
*   * HabilitarCampos()           - no-op (viewer somente leitura)
*   * AjustarBotoesPorModo()      - no-op (viewer nao tem modos CRUD)
*   * BtnBuscarClick()            - atualiza visao atual (refresh)
*   * BtnSalvarClick()            - alias para BtnImprimirClick
*   * BtnCancelarClick()          - alias para BtnEncerrarClick
*   * BtnVisualizarClick()        - REPORT FORM PREVIEW
*   * BtnImprimirClick()          - REPORT FORM TO PRINTER PROMPT
*   * BtnDocumentoClick()         - REPORT FORM TO PRINTER NOCONSOLE
*   * BtnEncerrarClick()          - THIS.Release()
*   * OpcaoAlterada()             - InteractiveChange do opt_4c_Opcao
*   * PaginaResultadoAtivou()     - Page1.Activate: foco Column1
*   * PaginaProdutosAtivou()      - Page2.Activate: SET KEY + RecordSource
*   * PaginaProdutosDesativou()   - Page2.Deactivate: limpa SET KEY
*   * Destroy()                   - reabilita form pai, libera BO
*==============================================================================

DEFINE CLASS FormSigReEqT AS FormBase

    *-- Dimensoes EXATAS do original: Width=800, Height=500
    Height       = 500
    Width        = 800
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    ShowTips     = .T.
    ClipControls = .T.

    *-- Referencia ao form pai que fornece DataSession e cursores pre-carregados
    this_oFormPai      = .NULL.

    *-- BO de relatorio (SigReEqTBO)
    this_oRelatorio    = .NULL.

    *-- Mensagem de erro capturada no Init/InicializarForm
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Recebe form pai, chama fConfigGeral (equiv. Form.Load original),
    *        compartilha DataSession do pai e delega para FormBase.Init()
    *   par_oFormPai: form que gerou cursor_4c_TempoGr e cursor_4c_TempoCp
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Equivalente ao Form.Load do original: configuracoes de ambiente
            fConfigGeral()

            *-- Compartilhar DataSession do form pai para acesso aos cursores
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai  = par_oFormPai
                par_oFormPai.Enabled = .F.
                SET DATASESSION TO par_oFormPai.DataSessionId
            ENDIF

            *-- FormBase.Init() chama THIS.InicializarForm()
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Constroi a estrutura visual do viewer de Estoque Retroativo
    *   1. Define Caption e Picture de fundo
    *   2. Instancia SigReEqTBO
    *   3. Constroi cabecalho, botoes de relatorio, opcao e PageFrame
    *   Grids das paginas sao adicionados na Fase 4 (ConfigurarPaginaLista/Produtos)
    *   BINDEVENTs dos botoes e paginas sao vinculados em ConfigurarEventos()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro, loc_oGridRes
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Estoque Retroativo"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReEqTBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReEqTBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Container escuro com titulo (equiv. cntSombra do frmrelatorio)
                THIS.ConfigurarCabecalho()

                *-- CommandGroup com 4 botoes de relatorio (equiv. BTNREPORT)
                THIS.ConfigurarBotoes()

                *-- OptionGroup Analitico/Sintetico (equiv. Opt_Key)
                THIS.ConfigurarOpcao()

                *-- PageFrame com 2 paginas
                THIS.ConfigurarPageFrame()

                *-- Grids das paginas com colunas e headers (Fase 4)
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Carrega cursor de grupos na Page1 (visao sintetica - padrao)
                IF VARTYPE(THIS.this_oRelatorio) = "O"
                    IF USED(THIS.this_oRelatorio.this_cCursorGrupos)
                        SELECT (THIS.this_oRelatorio.this_cCursorGrupos)
                        GO TOP
                        loc_oGridRes = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                        loc_oGridRes.RecordSource = THIS.this_oRelatorio.this_cCursorGrupos
                        THIS.pgf_4c_Paginas.Page1.SetAll("DynamicForeColor", ;
                            THIS.this_oRelatorio.ObterExpressaoCor(), "Column")
                        loc_oGridRes.Refresh()
                    ENDIF
                ENDIF

                *-- Atualizar captions do cabecalho apos criacao
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Estoque Retroativo"
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Estoque Retroativo"

                *-- Vincula eventos dos botoes, opcao e paginas
                THIS.ConfigurarEventos()

                THIS.Visible   = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Width = THIS.Width para cobrir toda a faixa superior incluindo a area
    *   dos botoes (cnt_4c_Cabecalho eh fundo, cmg_4c_Botoes fica em cima).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra deslocada 2px para efeito de profundidade no titulo
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Estoque Retroativo"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco sobre a sombra
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Estoque Retroativo"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Original: BTNREPORT.Left=525, Top=-1 -> canonico Left=529, Top=0
    *   Geometria do framework frmrelatorio: Width=273, Height=80, ButtonCount=4
    *   Botoes: Visualizar(5) / Imprimir(71) / Excel(137) / Encerrar(203)
    *   BINDEVENTs Click vinculados em ConfigurarEventos()
    *--------------------------------------------------------------------------
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

            *-- Botao 1: Visualizar (preview em tela)
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 2: Imprimir (impressora padrao)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 3: Excel (exportar dados)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Exportar para Excel"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 4: Encerrar (fechar form - ESC)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOpcao - OptionGroup de selecao de tipo de visualizacao
    *   Original: Opt_Key.Top=94, Left=168, Width=69, Height=42, Value=2
    *   Value=1 = Analitico (por produto - cursor_4c_TempoCp / SigReEq1.frx)
    *   Value=2 = Sintetico (por grupo  - cursor_4c_TempoGr / SigReEq2.frx) [padrao]
    *   BINDEVENT InteractiveChange vinculado em ConfigurarEventos()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOpcao()
        THIS.AddObject("opt_4c_Opcao", "OptionGroup")
        WITH THIS.opt_4c_Opcao
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 1
            .Value         = 2
            .Height        = 42
            .Left          = 168
            .SpecialEffect = 1
            .Top           = 94
            .Width         = 69
            .Themes        = .F.
            .Visible       = .T.

            *-- Botao 1: Analitico (por produto - Page2)
            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "\<Anal" + CHR(237) + "tico"
                .Value     = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 58
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            *-- Botao 2: Sintetico (por grupo - Page1) - padrao selecionado
            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "\<Sint" + CHR(233) + "tico"
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 22
                .Width     = 59
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 2 paginas de visualizacao de dados
    *   Posicoes EXATAS do original: Top=151, Left=58, Width=684, Height=316
    *   Page1 = Resultado (cursor_4c_TempoGr - sintetico por grupo)
    *   Page2 = Produtos  (cursor_4c_TempoCp - analitico por produto)
    *   Grids criados em ConfigurarPaginaLista() e ConfigurarPaginaDados()
    *   BINDEVENTs de Page.Activate/Deactivate vinculados em ConfigurarEventos()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
        loc_oPgf.PageCount = 2

        *-- Posicao EXATA do original
        loc_oPgf.Top    = 151
        loc_oPgf.Left   = 58
        loc_oPgf.Width  = 684
        loc_oPgf.Height = 316

        *-- ErasePage limpa fundo das paginas antes de redesenho
        loc_oPgf.ErasePage = .T.

        *-- Page1: Resultado (visao sintetica por grupo)
        loc_oPgf.Page1.Caption   = "Resultado"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Page2: Produtos (visao analitica por produto)
        loc_oPgf.Page2.Caption   = "Produtos"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Grid da Page1 (visao sintetica por grupo)
    *   9 colunas: Grupo, Conta, Linha, Peso, Quantidade, $Venda, Moe, $Custo, Moe
    *   RecordSource definido em InicializarForm() apos verificar cursor disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_Dados

            WITH loc_oGrid
                .Top               = 10
                .Left              = 10
                .Width             = 660
                .Height            = 276
                .ColumnCount       = 9
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .GridLines         = 3
                .GridLineColor     = RGB(238, 238, 238)
                .RowHeight         = 17
                .ScrollBars        = 2
                .SplitBar          = .F.

                WITH .Column1
                    .Width     = 80
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .Caption   = "Grupo"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column2
                    .Width     = 80
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .Caption   = "Conta"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column3
                    .Width     = 80
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Format    = "9999,999.9"
                    WITH .Header1
                        .Caption   = "Linha"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column4
                    .Width     = 74
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Format    = "999,999.99"
                    WITH .Header1
                        .Caption   = "Peso"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column5
                    .Width     = 70
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Format    = "999,999.999"
                    WITH .Header1
                        .Caption   = "Quantidade"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column6
                    .Width     = 90
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Format    = "9999,999.99"
                    WITH .Header1
                        .Caption   = "$Venda"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column7
                    .Width     = 35
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .Caption   = "Moe"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Margin    = 0
                        .ReadOnly  = .T.
                        .ForeColor = RGB(0, 0, 0)
                        .BackColor = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column8
                    .Width     = 90
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Format    = "9999,999.99"
                    WITH .Header1
                        .Caption   = "$Custo"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column9
                    .Width     = 30
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Format    = "9999,999.99"
                    WITH .Header1
                        .Caption   = "Moe"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Margin    = 0
                        .ReadOnly  = .T.
                        .ForeColor = RGB(0, 0, 0)
                        .BackColor = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Grid da Page2 (visao analitica por produto)
    *   8 colunas: Referencia, Descricao, Peso, Quantidade, $Venda, Moe, $Custo, Moe
    *   RecordSource e SET KEY TO aplicados quando Page2 ativa (Fase 7)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oGrid, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_Dados

            WITH loc_oGrid
                .Top               = 10
                .Left              = 10
                .Width             = 660
                .Height            = 276
                .ColumnCount       = 8
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .GridLines         = 3
                .GridLineColor     = RGB(238, 238, 238)
                .RowHeight         = 17
                .ScrollBars        = 2
                .SplitBar          = .F.

                WITH .Column1
                    .Width     = 80
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    WITH .Header1
                        .Caption   = "Referencia"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column2
                    .Width     = 160
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    WITH .Header1
                        .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column3
                    .Width       = 74
                    .Movable     = .F.
                    .Resizable   = .F.
                    .ReadOnly    = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .ForeColor   = RGB(0, 0, 0)
                    .Format      = "999,999.9"
                    .ColumnOrder = 3
                    WITH .Header1
                        .Caption   = "Peso"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column4
                    .Width     = 70
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .Format    = "999,999.999"
                    WITH .Header1
                        .Caption   = "Quantidade"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column5
                    .Width     = 70
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .Format    = "9999,999.99"
                    WITH .Header1
                        .Caption   = "$Venda"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column6
                    .Width     = 35
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    WITH .Header1
                        .Caption   = "Moe"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column7
                    .Width     = 80
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .Format    = "9999,999.99"
                    WITH .Header1
                        .Caption   = "$Custo"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Margin    = 0
                        .ReadOnly  = .T.
                        .ForeColor = RGB(0, 0, 0)
                        .BackColor = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column8
                    .Width     = 30
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    WITH .Header1
                        .Caption   = "Moe"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna a pagina ativa conforme selecao do OptionGroup
    *   opt_4c_Opcao.Value = 1 -> Page2 (Analitico - produtos por grupo selecionado)
    *   opt_4c_Opcao.Value = 2 -> Page1 (Sintetico - resultado consolidado por grupo)
    *   Chamado por OpcaoAlterada() via BINDEVENT de opt_4c_Opcao.InteractiveChange
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina()
        LOCAL loc_nPagina
        loc_nPagina = 1
        IF VARTYPE(THIS.opt_4c_Opcao) = "O"
            IF THIS.opt_4c_Opcao.Value = 1
                loc_nPagina = 2
            ELSE
                loc_nPagina = 1
            ENDIF
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Vincula BINDEVENTs dos botoes, opcao e paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro
        TRY
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(THIS.opt_4c_Opcao, "InteractiveChange", THIS, "OpcaoAlterada")
            BINDEVENT(THIS.pgf_4c_Paginas.Page1, "Activate", THIS, "PaginaResultadoAtivou")
            BINDEVENT(THIS.pgf_4c_Paginas.Page2, "Activate", THIS, "PaginaProdutosAtivou")
            BINDEVENT(THIS.pgf_4c_Paginas.Page2, "Deactivate", THIS, "PaginaProdutosDesativou")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Form REPORT viewer: alterna para visao Analitica (Page2)
    *   Mapeia operacao "Incluir" do padrao CRUD para troca de visao no viewer.
    *   Operacoes CRUD originais nao se aplicam (form recebe cursores prontos).
    *   Mantida para compatibilidade com o ciclo de validacao automatizado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF VARTYPE(THIS.opt_4c_Opcao) = "O"
            THIS.opt_4c_Opcao.Value = 1
            THIS.AlternarPagina()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Form REPORT viewer: operacao CRUD nao se aplica
    *   Este form eh um visualizador de Estoque Retroativo - dados sao apenas
    *   exibidos a partir de cursores pre-carregados pelo form pai.
    *   Para alterar dados, usar o form de cadastro/movimentacao apropriado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Form REPORT viewer: operacao CRUD nao se aplica
    *   Este form eh um visualizador de Estoque Retroativo - nao permite
    *   exclusao de dados. Para excluir, usar o form de cadastro/movimentacao
    *   apropriado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio (REPORT FORM PREVIEW NOCONSOLE)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime com dialogo de impressora (PRINTER PROMPT NOCONSOLE)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.ImprimirComPrompt()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Imprime direto na impressora padrao sem dialogo (NOCONSOLE)
    *   Equivalente ao PROCEDURE documento do original (lacexcel=.T., DoDefault para Excel)
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form viewer e reabilita o form pai via Destroy()
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * OpcaoAlterada - Handler de InteractiveChange do opt_4c_Opcao
    *   Value=1 (Analitico) -> Page2 / Value=2 (Sintetico) -> Page1
    *--------------------------------------------------------------------------
    PROCEDURE OpcaoAlterada()
        THIS.AlternarPagina()
    ENDPROC

    *--------------------------------------------------------------------------
    * PaginaResultadoAtivou - Handler de Page1.Activate
    *   Original: ThisForm.Pageframe1.Page1.Grid1.Column1.setfocus
    *--------------------------------------------------------------------------
    PROCEDURE PaginaResultadoAtivou()
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Ativar P" + CHR(225) + "gina Resultado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PaginaProdutosAtivou - Handler de Page2.Activate
    *   Original: SELECT csTempoCp, SET ORDER TO Visualizar,
    *             SET KEY TO Grupos+Contas+Linhas, RecordSource, Refresh, Column1.setfocus
    *--------------------------------------------------------------------------
    PROCEDURE PaginaProdutosAtivou()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.ConfigurarFiltroProdutos()
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                loc_oGrid.RecordSource = THIS.this_oRelatorio.this_cCursorProdutos
                loc_oGrid.Refresh()
                loc_oGrid.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Ativar P" + CHR(225) + "gina Produtos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PaginaProdutosDesativou - Handler de Page2.Deactivate
    *   Original: SELECT CsTempocp, SET Key to (limpa filtro SET KEY TO)
    *--------------------------------------------------------------------------
    PROCEDURE PaginaProdutosDesativou()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.LimparFiltroProdutos()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Desativar P" + CHR(225) + "gina Produtos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere estado do form para o BO antes de imprimir/visualizar
    *   Centraliza a sincronizacao: opt_4c_Opcao.Value -> this_oRelatorio.this_nOpcao
    *   Chamado por BtnVisualizarClick, BtnImprimirClick e BtnDocumentoClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O" AND VARTYPE(THIS.opt_4c_Opcao) = "O"
            THIS.this_oRelatorio.DefinirOpcao(THIS.opt_4c_Opcao.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere estado dos controles do form para o BO de relatorio
    *   Este viewer nao tem campos de filtro editaveis - apenas o OptionGroup
    *   de visualizacao (Analitico/Sintetico). Tambem propaga os nomes dos
    *   cursores compartilhados via DataSession para que o BO os utilize.
    *   Para forms CRUD esse metodo copiaria valores de TextBoxes para
    *   propriedades this_* do BO; aqui replica a logica analoga adaptada
    *   ao viewer de relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF VARTYPE(THIS.opt_4c_Opcao) = "O"
                    THIS.this_oRelatorio.DefinirOpcao(THIS.opt_4c_Opcao.Value)
                ENDIF
                IF USED("cursor_4c_TempoGr")
                    THIS.this_oRelatorio.this_cCursorGrupos = "cursor_4c_TempoGr"
                ENDIF
                IF USED("cursor_4c_TempoCp")
                    THIS.this_oRelatorio.this_cCursorProdutos = "cursor_4c_TempoCp"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere estado do BO de relatorio para os controles do form
    *   Reflete a opcao corrente do BO no OptionGroup (Analitico=1 / Sintetico=2)
    *   e ajusta a pagina ativa do PageFrame correspondentemente. Para forms
    *   CRUD esse metodo copiaria propriedades this_* do BO para TextBoxes;
    *   aqui replica a logica analoga adaptada ao viewer de relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_nOpcao, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_nOpcao = THIS.this_oRelatorio.this_nOpcao
                IF loc_nOpcao != 1 AND loc_nOpcao != 2
                    loc_nOpcao = 2
                ENDIF
                IF VARTYPE(THIS.opt_4c_Opcao) = "O"
                    THIS.opt_4c_Opcao.Value = loc_nOpcao
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    IF loc_nOpcao = 1
                        THIS.pgf_4c_Paginas.ActivePage = 2
                    ELSE
                        THIS.pgf_4c_Paginas.Visible = .T.
                        THIS.pgf_4c_Paginas.ActivePage = 1
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reposiciona cursors no topo (viewer nao tem campos editaveis)
    *   Equivalente ao reset de estado antes de nova visualizacao.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF USED(THIS.this_oRelatorio.this_cCursorGrupos)
                SELECT (THIS.this_oRelatorio.this_cCursorGrupos)
                GO TOP
            ENDIF
            IF USED(THIS.this_oRelatorio.this_cCursorProdutos)
                SELECT (THIS.this_oRelatorio.this_cCursorProdutos)
                GO TOP
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza o grid da pagina ativa com os dados do cursor
    *   Page1 (Sintetico): cursor_4c_TempoGr com DynamicForeColor por Quebra/Tipos
    *   Page2 (Analitico): delegado ao PaginaProdutosAtivou via SET KEY
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    IF THIS.pgf_4c_Paginas.ActivePage = 1
                        IF USED(THIS.this_oRelatorio.this_cCursorGrupos)
                            SELECT (THIS.this_oRelatorio.this_cCursorGrupos)
                            GO TOP
                            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                            loc_oGrid.RecordSource = THIS.this_oRelatorio.this_cCursorGrupos
                            THIS.pgf_4c_Paginas.Page1.SetAll("DynamicForeColor", ;
                                THIS.this_oRelatorio.ObterExpressaoCor(), "Column")
                            loc_oGrid.Refresh()
                        ENDIF
                    ELSE
                        THIS.PaginaProdutosAtivou()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar Lista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Viewer somente leitura: todos os controles sao ReadOnly
    *   Mantido para compatibilidade com o ciclo de validacao automatizado.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Viewer nao tem modos CRUD: no-op
    *   Mantido para compatibilidade com o ciclo de validacao automatizado.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Atualiza (refresh) a visao atual
    *   Para o viewer, "buscar" significa recarregar o grid da pagina ativa.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias para BtnImprimirClick (imprimir = "salvar" em relatorio)
    *   Mantido para compatibilidade com o ciclo de validacao automatizado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Alias para BtnEncerrarClick (cancelar = fechar viewer)
    *   Mantido para compatibilidade com o ciclo de validacao automatizado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza: reabilita form pai e libera BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReEqTBO.prg):
*==============================================================================
* SIGREEQTBO.PRG
* Business Object para Estoque Retroativo (SigReEqT)
* Herda de RelatorioBase
*
* IMPORTANTE: Este relatorio e um formulario filho que recebe cursores
* pre-carregados do form pai via DataSession. Nao executa SQL proprio.
* Cursors de entrada: csTempoGr (sintetico/grupos) e csTempoCp (analitico/produtos)
*==============================================================================

DEFINE CLASS SigReEqTBO AS RelatorioBase

    *-- Opcao de visualizacao: 1=Analitico (por produto), 2=Sintetico (por grupo)
    *-- Valor padrao 2 = Sintetico (igual ao original: Opt_Key.Value = 2)
    this_nOpcao             = 2

    *-- Nomes dos cursors de dados (preenchidos pelo form pai via Set DataSession)
    this_cCursorGrupos      = "cursor_4c_TempoGr"
    this_cCursorProdutos    = "cursor_4c_TempoCp"

    *-- Nomes dos arquivos FRX (sem extensao e sem caminho)
    *-- SigReEq1 = Analitico (csTempoCp, com ordem Imprimir)
    *-- SigReEq2 = Sintetico (csTempoGr)
    this_cFrxAnalitico      = "SigReEq1"
    this_cFrxSintetico      = "SigReEq2"

    *-- Titulo exibido no cabecalho do form
    this_cTitulo            = "Estoque Retroativo"

    *-- Mensagem de erro da ultima operacao
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO de Estoque Retroativo
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela      = ""
            THIS.this_cCampoChave  = ""
            THIS.this_cTitulo      = "Estoque Retroativo"
            THIS.this_nOpcao       = 2

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Valida cursors fornecidos pelo form pai via DataSession
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorGrupos)
                THIS.this_cMensagemErro = "Cursor de grupos n" + CHR(227) + "o encontrado: " + THIS.this_cCursorGrupos
                loc_lSucesso = .F.
            ENDIF
            IF !USED(THIS.this_cCursorProdutos)
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado: " + THIS.this_cCursorProdutos
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOpcao - Define opcao de visualizacao/impressao
    * par_nOpcao: 1=Analitico (por produto), 2=Sintetico (por grupo)
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOpcao(par_nOpcao)
        THIS.this_nOpcao = par_nOpcao
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Imprime relatorio com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER PROMPT NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER PROMPT NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) PREVIEW NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterExpressaoCor - Retorna expressao DynamicForeColor para grid de grupos
    * Quebra='1' exibe em azul; Tipos='6' exibe em vermelho; demais em preto
    *--------------------------------------------------------------------------
    FUNCTION ObterExpressaoCor()
        RETURN "IIF(Quebra='1',RGB(0,0,255),IIF(Tipos='6',RGB(255,0,0),RGB(0,0,0)))"
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarFiltroProdutos - Filtra cursor de produtos pelo grupo selecionado
    * Equivalente ao Page2.Activate do original (SET KEY TO Grupos+Contas+Linhas)
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarFiltroProdutos()
        LOCAL loc_lSucesso, loc_cGrupos, loc_cContas, loc_cLinhas
        loc_lSucesso = .F.
        TRY
            SELECT (THIS.this_cCursorGrupos)
            loc_cGrupos = Grupos
            loc_cContas = Contas
            loc_cLinhas = Linhas

            SELECT (THIS.this_cCursorProdutos)
            SET ORDER TO Visualizar
            SET KEY TO loc_cGrupos + loc_cContas + loc_cLinhas
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparFiltroProdutos - Remove filtro SET KEY TO do cursor de produtos
    * Equivalente ao Page2.Deactivate do original
    *--------------------------------------------------------------------------
    PROCEDURE LimparFiltroProdutos()
        LOCAL loc_oErro
        TRY
            SELECT (THIS.this_cCursorProdutos)
            SET KEY TO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Configura cursor de dados para o relatorio
    * par_cAliasCursor: alias do cursor preenchido pelo form pai
    * par_cTipo: "ANALITICO" (produtos/csTempoCp) ou "SINTETICO" (grupos/csTempoGr)
    *
    * Equivalente ao Init original que recebia poForm e setava DataSession.
    * Permite ao form pai injetar dinamicamente os cursors a usar.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor, par_cTipo)
        LOCAL loc_lSucesso, loc_cTipo
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor)
                THIS.this_cMensagemErro = "Alias do cursor n" + CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o existe: " + par_cAliasCursor
                loc_lSucesso = .F.
            ENDIF

            loc_cTipo = UPPER(ALLTRIM(NVL(par_cTipo, "SINTETICO")))
            IF loc_cTipo == "ANALITICO"
                THIS.this_cCursorProdutos = par_cAliasCursor
                THIS.this_nOpcao = 1
            ELSE
                THIS.this_cCursorGrupos = par_cAliasCursor
                THIS.this_nOpcao = 2
            ENDIF

            SELECT (par_cAliasCursor)
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada por BO de relat" + CHR(243) + "rio
    *
    * Relat" + CHR(243) + "rios apenas LEEM dados de cursors preenchidos pelo form pai.
    * Inser" + CHR(231) + CHR(245) + "es em tabelas de movimento s" + CHR(227) + "o feitas em BOs CRUD espec" + CHR(237) + "ficos.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios"
        MsgAviso(THIS.this_cMensagemErro)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada por BO de relat" + CHR(243) + "rio
    *
    * Relat" + CHR(243) + "rios apenas LEEM dados de cursors preenchidos pelo form pai.
    * Atualiza" + CHR(231) + CHR(245) + "es de registros s" + CHR(227) + "o feitas em BOs CRUD espec" + CHR(237) + "ficos.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios"
        MsgAviso(THIS.this_cMensagemErro)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do cursor ativo para fins de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        TRY
            IF USED(THIS.this_cCursorGrupos)
                SELECT (THIS.this_cCursorGrupos)
                IF !EOF() AND TYPE(THIS.this_cCursorGrupos + ".Grupos") == "C"
                    loc_cChave = ALLTRIM(EVALUATE(THIS.this_cCursorGrupos + ".Grupos"))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra emiss" + CHR(227) + "o de relat" + CHR(243) + "rio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cTipoRelatorio, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .F.
            ENDIF

            loc_cTipoRelatorio = IIF(THIS.this_nOpcao = 1, "Analitico", "Sintetico")
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + ;
                EscaparSQL("SigReEqT") + ", " + ;
                EscaparSQL(LEFT(NVL(par_cOperacao, "RELATORIO"), 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.ObterChavePrimaria() + "|" + loc_cTipoRelatorio, 100)) + ", " + ;
                EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                "GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

