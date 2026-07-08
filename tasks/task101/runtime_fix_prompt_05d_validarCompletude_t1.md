# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[sigreffiBO.prg] Indicador de pendencia: *   - Situacao (Baixados/Pendente
[Formsigreffi.prg] Indicador de pendencia: *   - Situa" + CHR(231) + CHR(227) + "o (Baixados / Pendente
[Formsigreffi.prg] Indicador de pendencia: *-- opt_situa: Baixados/Pendente

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreffi.prg):
*==============================================================================
* FORMSIGREFFI.PRG
* Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFFI.SCX (frmrelatorio)
*
* Filtros:
*   - Per" + CHR(237) + "odo (data inicial / data final / tipo Vencimento ou Lan" + CHR(231) + "amento)
*   - Moeda refer" + CHR(234) + "ncia (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe)
*   - Moeda convers" + CHR(227) + "o (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe)
*   - Tipo (Pagamentos / Recebimentos / Ambos)
*   - Situa" + CHR(231) + CHR(227) + "o (Baixados / Pendentes / Todos)
*   - Ordem impress" + CHR(227) + "o (Vencimento / Grupo-Conta)
*   - Op" + CHR(231) + CHR(245) + "es NF (Sim/N" + CHR(227) + "o/Ambos - captions de SigCdPac)
*   - Previsto (Sim/N" + CHR(227) + "o/Ambos)
*   - Saldo (Anterior / Na Data)
*   - Atrasos (Considerar / Listar / Listar C" + CHR(243) + "d. Opera" + CHR(231) + CHR(227) + "o)
*   - Empresas selecion" + CHR(225) + "veis (Grid1 com CheckBox - SigCdEmp)
*   - Disponibilidades selecion" + CHR(225) + "veis (Grid2 com CheckBox - SigCdDis)
*   - Opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos selecion" + CHR(225) + "veis (Grd_Oper com CheckBox - SigOpOpe)
*
* FASES 3-7/8 COMPLETO - Form: Estrutura Base + Grids + Filtros + Lookups + Eventos
*   * Propriedades visuais do form
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()   (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
*   * ConfigurarBotoes()      (Visualizar / Imprimir / Excel / Encerrar)
*   * ConfigurarPageFrame()   (PageFrame com 1 p" + CHR(225) + "gina - Filtros)
*   * ConfigurarPaginaLista()  (grids selecion" + CHR(225) + "veis + bot" + CHR(245) + "es Sel/Des)
*   * AlternarPagina()        (ativa pagina do PageFrame)
*   * BtnVisualizarClick() / BtnImprimirClick() / BtnExcelClick() / BtnSairClick()
*   * BtnIncluirClick() / BtnAlterarClick() / BtnExcluirClick() (compat. interface CRUD)
*   * BtnMarcarEmpClick() / BtnDesmarcarEmpClick()
*   * BtnMarcarDispClick() / BtnDesmarcarDispClick()
*   * BtnMarcarOpeClick() / BtnDesmarcarOpeClick()
*   * ConfigurarPaginaDados() (todos os filtros: periodo, moedas, opcoes, atrasos, saldo)
*   * FormParaRelatorio()     (mapeamento completo de todos os filtros para o BO)
*   * LimparCampos()          (inicializa" + CHR(231) + CHR(227) + "o completa de todos os filtros)
*   * ValidarCdMoeda/ValidarDsMoeda/ValidarMoeConv/ValidarDMoeConv (F4/Enter/Tab/DblClick)
*   * OptListaAtraChange()    (habilita/desabilita ConsidAtra conforme ListaAtra)
*==============================================================================

DEFINE CLASS Formsigreffi AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=560)
    Height      = 560
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
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigreffiBO e carrega cursores base (pula em modo UI sem SQL)
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
    *   4. Chama ConfigurarPaginaLista() para adicionar grids/botoes na Page1
    *   5. Vincula Click dos bot" + CHR(245) + "es de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relat" + CHR(243) + "rio (pula se em modo valida" + CHR(231) + CHR(227) + "o de UI sem conex" + CHR(227) + "o SQL)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigreffiBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar sigreffiBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF

                *-- Carregar cursores base (Empresas, Disponibilidades, Opera" + CHR(231) + CHR(245) + "es, Moedas)
                IF loc_lContinuar
                    IF !THIS.this_oRelatorio.CarregarCursoresBase()
                        *-- N" + CHR(227) + "o bloqueia abertura do form se cursores falharem
                        MsgAviso(THIS.this_oRelatorio.ObterMensagemErro() + CHR(13) + ;
                            "Alguns grids poder" + CHR(227) + "o aparecer vazios.", "Aviso")
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Controles de filtro na Page1 do PageFrame (grids selecionaveis + botoes)
                THIS.ConfigurarPaginaLista()

                *-- Garante que a unica pagina disponivel esteja ativa
                THIS.AlternarPagina(1)

                *-- Vincular Click dos bot" + CHR(245) + "es de relat" + CHR(243) + "rio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()

                THIS.Visible = .T.
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
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior).
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

            *-- Sombra (deslocada 2px para efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico"
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
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es do relat" + CHR(243) + "rio
    *   Original: btnReport.Left=527, Top=3
    *   Bot" + CHR(245) + "es: Visualiza(Left=6), Imprime(72), DocExcel(138), Sair(204)
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

            *-- Visualizar (preview em tela)
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

            *-- Imprimir (impressora com di" + CHR(225) + "logo)
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

            *-- Excel (exportar para XLS)
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

            *-- Encerrar (fechar form - ESC)
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
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina (Filtros)
    *   Posicionado logo abaixo do cabe" + CHR(231) + "alho (Top=85) at" + CHR(233) + " o fim do form.
    *   Page1 conter" + CHR(225) + " todos os controles de filtro (implementados nas Fases 4-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
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
    * ConfigurarPaginaLista - Grids selecionaveis e botoes Marcar/Desmarcar (FASE 4/8)
    *   Em forms REPORT, a "Pagina Lista" hospeda os grids que listam itens
    *   selecionaveis pelo usuario (Empresas, Disponibilidades, Operacoes).
    *   Cada grid tem CheckBox na Column1 ligado a coluna LOGICAL do cursor +
    *   2 botoes laterais (Marcar todos / Desmarcar todos).
    *   Fases 5-6 adicionam controles de filtro (periodo, moeda, opcoes, etc.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oPag.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            THIS.ConfigurarGridEmpresas(loc_oPag)
            THIS.ConfigurarGridDisponibilidades(loc_oPag)
            THIS.ConfigurarGridOperacoes(loc_oPag)
            THIS.ConfigurarPaginaDados(loc_oPag)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina indicada do PageFrame de filtros
    *   Forms REPORT possuem PageCount=1 (apenas pagina de filtros), porem o
    *   metodo eh mantido para conformidade com a API esperada e para garantir
    *   que ActivePage seja explicitamente posicionado apos InicializarForm.
    *   Valida par_nPagina contra PageCount real para evitar erro de range.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro
        TRY
            IF VARTYPE(par_nPagina) != "N"
                loc_nPagina = 1
            ELSE
                loc_nPagina = par_nPagina
            ENDIF

            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                IF loc_nPagina < 1
                    loc_nPagina = 1
                ENDIF
                IF loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                    loc_nPagina = THIS.pgf_4c_Paginas.PageCount
                ENDIF
                THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridEmpresas - Grid de selecao de empresas (Grid1 no legado)
    *   Layout original: top=152, left=377, width=341, height=111
    *   Posicao em Page1: top=67 (152-85), left=377
    *   Cursores: cursor_4c_Emp (ImpEmps LOGICAL, Cemps, Razas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridEmpresas(par_oPag)
        LOCAL loc_oGrd, loc_oErro
        TRY
            *-- Label Empresas (original: top=136, left=376, width=57)
            par_oPag.AddObject("lbl_4c_LblEmpresas", "Label")
            WITH par_oPag.lbl_4c_LblEmpresas
                .Top       = 51
                .Left      = 376
                .Width     = 57
                .Height    = 15
                .Caption   = "Empresas"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Grid de empresas (original: top=152, left=377, width=341, height=111)
            par_oPag.AddObject("grd_4c_Empresas", "Grid")
            loc_oGrd = par_oPag.grd_4c_Empresas
            WITH loc_oGrd
                .Top                = 67
                .Left               = 377
                .Width              = 341
                .Height             = 111
                .ColumnCount        = 3
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

                .Column1.Width = 25
                .Column2.Width = 65
                .Column3.Width = 251

                *-- REGRA: AddObject("Check1") ANTES de ControlSource (evita Error 1767)
                .Column1.AddObject("Check1", "CheckBox")
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Value     = 0
                .Column1.Check1.Visible   = .T.
                .Column1.CurrentControl   = "Check1"
                .Column1.Resizable        = .F.
                .Column2.ReadOnly         = .T.
                .Column3.ReadOnly         = .T.

                *-- RecordSource antes de ControlSource (reseta headers automaticamente)
                IF USED("cursor_4c_Emp")
                    .RecordSource = "cursor_4c_Emp"
                ENDIF

                *-- ControlSources APOS RecordSource e CurrentControl
                .Column1.ControlSource = "cursor_4c_Emp.ImpEmps"
                .Column2.ControlSource = "cursor_4c_Emp.Cemps"
                .Column3.ControlSource = "cursor_4c_Emp.Razas"

                *-- Headers SEMPRE APOS ControlSource
                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = "C" + CHR(243) + "digo"
                .Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"

                .Visible = .T.
            ENDWITH

            *-- Botao Marcar Empresas (original: top=169, left=720, w=40, h=40)
            par_oPag.AddObject("cmd_4c_MarcarEmp", "CommandButton")
            WITH par_oPag.cmd_4c_MarcarEmp
                .Top           = 84
                .Left          = 720
                .Width         = 40
                .Height        = 40
                .Caption       = "Sel"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Marcar Todas as Empresas"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_MarcarEmp, "Click", THIS, "BtnMarcarEmpClick")

            *-- Botao Desmarcar Empresas (original: top=209, left=720, w=40, h=40)
            par_oPag.AddObject("cmd_4c_DesmarcarEmp", "CommandButton")
            WITH par_oPag.cmd_4c_DesmarcarEmp
                .Top           = 124
                .Left          = 720
                .Width         = 40
                .Height        = 40
                .Caption       = "Des"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Desmarcar Todas as Empresas"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_DesmarcarEmp, "Click", THIS, "BtnDesmarcarEmpClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarGridEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridDisponibilidades - Grid de selecao de disponibilidades
    *   Layout original: top=399, left=57, width=196, height=111
    *   Posicao em Page1: top=314 (399-85), left=57
    *   Cursores: cursor_4c_Disp (ImpDisps LOGICAL, Grupos, Contas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridDisponibilidades(par_oPag)
        LOCAL loc_oGrd, loc_oErro
        TRY
            *-- Label Disponibilidades (original: top=381, left=63, width=99)
            par_oPag.AddObject("lbl_4c_LblDisps", "Label")
            WITH par_oPag.lbl_4c_LblDisps
                .Top       = 296
                .Left      = 63
                .Width     = 99
                .Height    = 15
                .Caption   = " Disponibilidades "
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Grid de disponibilidades (original: top=399, left=57, width=196, height=111)
            par_oPag.AddObject("grd_4c_Disps", "Grid")
            loc_oGrd = par_oPag.grd_4c_Disps
            WITH loc_oGrd
                .Top                = 314
                .Left               = 57
                .Width              = 196
                .Height             = 111
                .ColumnCount        = 3
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

                .Column1.Width = 25
                .Column2.Width = 75
                .Column3.Width = 96

                .Column1.AddObject("Check1", "CheckBox")
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Value     = 0
                .Column1.Check1.Visible   = .T.
                .Column1.CurrentControl   = "Check1"
                .Column1.Resizable        = .F.
                .Column2.ReadOnly         = .T.
                .Column3.ReadOnly         = .T.

                IF USED("cursor_4c_Disp")
                    .RecordSource = "cursor_4c_Disp"
                ENDIF

                .Column1.ControlSource = "cursor_4c_Disp.ImpDisps"
                .Column2.ControlSource = "cursor_4c_Disp.Grupos"
                .Column3.ControlSource = "cursor_4c_Disp.Contas"

                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = "Grupo"
                .Column3.Header1.Caption = "Conta"

                .Visible = .T.
            ENDWITH

            *-- Botao Marcar Disponibilidades (original: top=416, left=256, w=40, h=40)
            par_oPag.AddObject("cmd_4c_MarcarDisp", "CommandButton")
            WITH par_oPag.cmd_4c_MarcarDisp
                .Top           = 331
                .Left          = 256
                .Width         = 40
                .Height        = 40
                .Caption       = "Sel"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Marcar Todas as Disponibilidades"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_MarcarDisp, "Click", THIS, "BtnMarcarDispClick")

            *-- Botao Desmarcar Disponibilidades (original: top=456, left=256, w=40, h=40)
            par_oPag.AddObject("cmd_4c_DesmarcarDisp", "CommandButton")
            WITH par_oPag.cmd_4c_DesmarcarDisp
                .Top           = 371
                .Left          = 256
                .Width         = 40
                .Height        = 40
                .Caption       = "Des"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Desmarcar Todas as Disponibilidades"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_DesmarcarDisp, "Click", THIS, "BtnDesmarcarDispClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarGridDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridOperacoes - Grid de selecao de operacoes de titulos
    *   Layout original: top=336, left=380, width=277, height=130
    *   Posicao em Page1: top=251 (336-85), left=380
    *   Cursores: cursor_4c_Oper (SeleOp LOGICAL, Dopes, Opers)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPag)
        LOCAL loc_oGrd, loc_oErro
        TRY
            *-- Label Operacoes de Titulos (original: top=317, left=377, width=120)
            par_oPag.AddObject("lbl_4c_LblOper", "Label")
            WITH par_oPag.lbl_4c_LblOper
                .Top       = 232
                .Left      = 377
                .Width     = 120
                .Height    = 15
                .Caption   = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Grid de operacoes (original: top=336, left=380, width=277, height=130)
            par_oPag.AddObject("grd_4c_Oper", "Grid")
            loc_oGrd = par_oPag.grd_4c_Oper
            WITH loc_oGrd
                .Top                = 251
                .Left               = 380
                .Width              = 277
                .Height             = 130
                .ColumnCount        = 3
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

                .Column1.Width = 25
                .Column2.Width = 65
                .Column3.Width = 187

                .Column1.AddObject("Check1", "CheckBox")
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Value     = 0
                .Column1.Check1.Visible   = .T.
                .Column1.CurrentControl   = "Check1"
                .Column1.Resizable        = .F.
                .Column2.ReadOnly         = .T.
                .Column3.ReadOnly         = .T.

                IF USED("cursor_4c_Oper")
                    .RecordSource = "cursor_4c_Oper"
                ENDIF

                .Column1.ControlSource = "cursor_4c_Oper.SeleOp"
                .Column2.ControlSource = "cursor_4c_Oper.Dopes"
                .Column3.ControlSource = "cursor_4c_Oper.Opers"

                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = "C" + CHR(243) + "digo"
                .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                .Visible = .T.
            ENDWITH

            *-- Botao Marcar Operacoes (original: top=363, left=659, w=40, h=40)
            par_oPag.AddObject("cmd_4c_MarcarOpe", "CommandButton")
            WITH par_oPag.cmd_4c_MarcarOpe
                .Top           = 278
                .Left          = 659
                .Width         = 40
                .Height        = 40
                .Caption       = "Sel"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_MarcarOpe, "Click", THIS, "BtnMarcarOpeClick")

            *-- Botao Desmarcar Operacoes (original: top=403, left=659, w=40, h=40)
            par_oPag.AddObject("cmd_4c_DesmarcarOpe", "CommandButton")
            WITH par_oPag.cmd_4c_DesmarcarOpe
                .Top           = 318
                .Left          = 659
                .Width         = 40
                .Height        = 40
                .Caption       = "Des"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_DesmarcarOpe, "Click", THIS, "BtnDesmarcarOpeClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarGridOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padrao
    *   Todos os filtros: Periodo, Moeda, Tipo/Situacao/Ordem, Opcoes/Previsto/Atrasos/Saldo
    *   Valores padrao conforme original Init(): tipo=Pagamentos, situa=Baixados, ordem=Vencimento
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPag.txt_4c__dt_inicial.Value = THIS.this_oRelatorio.this_dDtInicial
                loc_oPag.txt_4c__dt_final.Value   = THIS.this_oRelatorio.this_dDtFinal
            ELSE
                loc_oPag.txt_4c__dt_inicial.Value = DATE()
                loc_oPag.txt_4c__dt_final.Value   = DATE()
            ENDIF

            loc_oPag.obj_4c_Opt_Data.Value            = 1
            loc_oPag.txt_4c__cd_moeda.Value           = ""
            loc_oPag.txt_4c__ds_moeda.Value           = ""
            loc_oPag.txt_4c__ds_moeda.ReadOnly        = .F.
            loc_oPag.txt_4c_MoeConv.Value             = ""
            loc_oPag.txt_4c_DMoeConv.Value            = ""
            loc_oPag.txt_4c_DMoeConv.ReadOnly         = .F.
            loc_oPag.obj_4c_Opt_nr_tipo.Value         = 1
            loc_oPag.obj_4c_Opt_situa.Value           = 1
            loc_oPag.obj_4c_Opt_ordem_impressao.Value = 1
            loc_oPag.obj_4c_Opt_opcoes.Value          = 3
            loc_oPag.obj_4c_Opt_prev.Value            = 3
            loc_oPag.obj_4c_Opt_lista_atra.Value      = 1
            loc_oPag.obj_4c_Opt_consid_atra.Value     = 2
            loc_oPag.obj_4c_Opt_consid_atra.Enabled   = .T.
            loc_oPag.obj_4c_Opt_lista_op.Value        = 2
            loc_oPag.obj_4c_Opt_saldo.Value           = 1

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros do form para o BO
    *   Todos os filtros: Periodo, Moeda, Tipo/Situacao/Ordem, Opcoes/Previsto/Atrasos/Saldo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            WITH THIS.this_oRelatorio
                .this_dDtInicial = loc_oPag.txt_4c__dt_inicial.Value
                .this_dDtFinal   = loc_oPag.txt_4c__dt_final.Value
                .this_nTpData    = loc_oPag.obj_4c_Opt_Data.Value
                .this_cCdMoeda   = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
                .this_cDsMoeda   = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)
                .this_cMoeConv   = ALLTRIM(loc_oPag.txt_4c_MoeConv.Value)
                .this_cDMoeConv  = ALLTRIM(loc_oPag.txt_4c_DMoeConv.Value)
                .this_nNrTipo      = loc_oPag.obj_4c_Opt_nr_tipo.Value
                .this_nNrSitua     = loc_oPag.obj_4c_Opt_situa.Value
                .this_nOrdImp      = loc_oPag.obj_4c_Opt_ordem_impressao.Value
                .this_nOpcoes      = loc_oPag.obj_4c_Opt_opcoes.Value
                .this_nNrPrev      = loc_oPag.obj_4c_Opt_prev.Value
                .this_nListaAtra   = loc_oPag.obj_4c_Opt_lista_atra.Value
                .this_nConsAtra    = loc_oPag.obj_4c_Opt_consid_atra.Value
                .this_nListaCodOp  = loc_oPag.obj_4c_Opt_lista_op.Value
                .this_nSaldos      = loc_oPag.obj_4c_Opt_saldo.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relat" + CHR(243) + "rio em tela (REPORT FORM ... PREVIEW)
    *   Equivalente ao Visualiza.Click original
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relat" + CHR(243) + "rio (REPORT FORM ... TO PRINTER PROMPT)
    *   Equivalente ao Imprime.Click original
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do cursor de relat" + CHR(243) + "rio para Excel (XLS)
    *   Equivalente ao DocExcel.Click original (COPY TO ... TYPE XLS)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_cCursorRel

        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Preparar Dados")
                RETURN
            ENDIF

            loc_cCursorRel = THIS.this_oRelatorio.this_cCursorRelatorio
            IF USED(loc_cCursorRel)
                loc_cArquivo = gc_4c_CaminhoBase + "FluxoFinanceiroAnalitico.xls"
                SELECT (loc_cCursorRel)
                COPY TO (loc_cArquivo) TYPE XLS
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
            ELSE
                MsgAviso("Nenhum dado para exportar.", "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Acao CRUD nao aplicavel em formulario de relatorio
    *   Mantido pela interface padrao; redireciona ao usuario para gerar relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        MsgInfo("Este " + CHR(233) + " um formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
                "Configure os filtros e use Visualizar (F5) ou Imprimir (F6).", ;
                "Relat" + CHR(243) + "rio Fluxo Financeiro")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Acao CRUD nao aplicavel em formulario de relatorio
    *   Mantido pela interface padrao; redireciona ao usuario para gerar relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        MsgInfo("Este " + CHR(233) + " um formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
                "Os par" + CHR(226) + "metros podem ser editados diretamente nos campos da tela.", ;
                "Relat" + CHR(243) + "rio Fluxo Financeiro")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Acao CRUD nao aplicavel em formulario de relatorio
    *   Mantido pela interface padrao; limpa os filtros restaurando valores iniciais.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Limpar todos os filtros e restaurar valores padr" + CHR(227) + "o?", ;
                       "Limpar Filtros")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formul" + CHR(225) + "rio
    *   Equivalente ao Sair.Click original (Release)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formul" + CHR(225) + "rio
    *   BO " + CHR(233) + " Custom (NAO tem Release) - setar como .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarEmpClick - Marca todas as empresas para impressao
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarEmpClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarEmpresas()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Empresas.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarEmpClick - Desmarca todas as empresas
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarEmpClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarEmpresas()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Empresas.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarDispClick - Marca todas as disponibilidades para impressao
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarDispClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarDisponibilidades()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Disps.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarDispClick - Desmarca todas as disponibilidades
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarDispClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarDisponibilidades()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Disps.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarOpeClick - Marca todas as operacoes de titulos
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarOpeClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarOperacoes()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Oper.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarOpeClick - Desmarca todas as operacoes de titulos
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarOpeClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarOperacoes()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Oper.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Campos de filtro: Periodo, Moeda, Tipo, Situacao, Ordem
    * (FASE 5/8 - primeira metade dos filtros)
    *   Posicoes: top original - PageFrame.Top(85) = top na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPag)
        LOCAL loc_oErro
        TRY
            *== SECAO PERIODO ================================================

            *-- Label "Periodo :" (original top=138 -> Page1 top=53)
            par_oPag.AddObject("lbl_4c_Periodo", "Label")
            WITH par_oPag.lbl_4c_Periodo
                .Top       = 53
                .Left      = 52
                .Width     = 45
                .Height    = 15
                .Caption   = "Per" + CHR(237) + "odo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Data inicial (original top=134 -> Page1 top=49)
            par_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
            WITH par_oPag.txt_4c__dt_inicial
                .Top      = 49
                .Left     = 100
                .Width    = 80
                .Height   = 25
                .Value    = {}
                .Format   = "K"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Separador " a " (original top=139 -> Page1 top=54)
            par_oPag.AddObject("lbl_4c_PeriodoA", "Label")
            WITH par_oPag.lbl_4c_PeriodoA
                .Top       = 54
                .Left      = 184
                .Width     = 8
                .Height    = 15
                .Caption   = CHR(224)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Data final (original top=134, left=194 -> Page1 top=49)
            par_oPag.AddObject("txt_4c__dt_final", "TextBox")
            WITH par_oPag.txt_4c__dt_final
                .Top      = 49
                .Left     = 194
                .Width    = 80
                .Height   = 25
                .Value    = {}
                .Format   = "K"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Opt_Data: Vencimento / Lancamento (original top=134, left=275 -> Page1 top=49)
            par_oPag.AddObject("obj_4c_Opt_Data", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_Data
                .Top           = 49
                .Left          = 275
                .Width         = 97
                .Height        = 46
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Vencimento"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 73
                    .Height    = 15
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "Lan" + CHR(231) + "amento"
                    .Top       = 24
                    .Left      = 5
                    .Width     = 76
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                .Value = 1
            ENDWITH

            *== SECAO MOEDA DE REFERENCIA =====================================

            *-- Label "Moeda :" (original top=165 -> Page1 top=80)
            par_oPag.AddObject("lbl_4c_Moeda", "Label")
            WITH par_oPag.lbl_4c_Moeda
                .Top       = 80
                .Left      = 56
                .Width     = 41
                .Height    = 15
                .Caption   = "Moeda :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Codigo moeda referencia (original top=161, left=100 -> Page1 top=76)
            par_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
            WITH par_oPag.txt_4c__cd_moeda
                .Top           = 76
                .Left          = 100
                .Width         = 31
                .Height        = 25
                .Value         = ""
                .MaxLength     = 3
                .Format        = "K"
                .FontName      = "Courier New"
                .FontSize      = 9
                .ForeColor     = RGB(0, 0, 0)
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Alignment     = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")
            BINDEVENT(par_oPag.txt_4c__cd_moeda, "DblClick", THIS, "TeclaCdMoedaDblClick")

            *-- Descricao moeda referencia (original top=161, left=132 -> Page1 top=76)
            par_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
            WITH par_oPag.txt_4c__ds_moeda
                .Top      = 76
                .Left     = 132
                .Width    = 115
                .Height   = 25
                .Value    = ""
                .MaxLength = 15
                .Format   = "K"
                .FontName = "Courier New"
                .FontSize = 9
                .Visible  = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")
            BINDEVENT(par_oPag.txt_4c__ds_moeda, "DblClick", THIS, "TeclaDsMoedaDblClick")

            *== SECAO MOEDA DE CONVERSAO =====================================

            *-- Label "Moe Conv :" (original top=190 -> Page1 top=105)
            par_oPag.AddObject("lbl_4c_MoeConv", "Label")
            WITH par_oPag.lbl_4c_MoeConv
                .Top       = 105
                .Left      = 40
                .Width     = 57
                .Height    = 15
                .Caption   = "Moe Conv :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Codigo moeda conversao (original top=187, left=100 -> Page1 top=102)
            par_oPag.AddObject("txt_4c_MoeConv", "TextBox")
            WITH par_oPag.txt_4c_MoeConv
                .Top           = 102
                .Left          = 100
                .Width         = 31
                .Height        = 25
                .Value         = ""
                .MaxLength     = 3
                .Format        = "K"
                .FontName      = "Courier New"
                .FontSize      = 9
                .ForeColor     = RGB(0, 0, 0)
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Alignment     = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c_MoeConv, "KeyPress", THIS, "TeclaMoeConv")
            BINDEVENT(par_oPag.txt_4c_MoeConv, "DblClick", THIS, "TeclaMoeConvDblClick")

            *-- Descricao moeda conversao (original top=187, left=132 -> Page1 top=102)
            par_oPag.AddObject("txt_4c_DMoeConv", "TextBox")
            WITH par_oPag.txt_4c_DMoeConv
                .Top      = 102
                .Left     = 132
                .Width    = 115
                .Height   = 25
                .Value    = ""
                .MaxLength = 15
                .Format   = "K"
                .FontName = "Courier New"
                .FontSize = 9
                .Visible  = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c_DMoeConv, "KeyPress", THIS, "TeclaDMoeConv")
            BINDEVENT(par_oPag.txt_4c_DMoeConv, "DblClick", THIS, "TeclaDMoeConvDblClick")

            *== SECAO OPCOES =================================================

            *-- Label2 "Opcoes" secao header (original top=214 -> Page1 top=129)
            par_oPag.AddObject("lbl_4c_SecaoOpcoes", "Label")
            WITH par_oPag.lbl_4c_SecaoOpcoes
                .Top        = 129
                .Left       = 24
                .Width      = 43
                .Height     = 15
                .Caption    = "Op" + CHR(231) + CHR(245) + "es"
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackStyle  = 0
                .Visible    = .T.
            ENDWITH

            *-- Label "Tipo :" (original top=230 -> Page1 top=145)
            par_oPag.AddObject("lbl_4c_Tipo", "Label")
            WITH par_oPag.lbl_4c_Tipo
                .Top       = 145
                .Left      = 66
                .Width     = 29
                .Height    = 15
                .Caption   = "Tipo :"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- opt_nr_tipo: Pagamentos/Recebimentos/Ambos
            *   (original top=223, left=94 -> Page1 top=138)
            par_oPag.AddObject("obj_4c_Opt_nr_tipo", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_nr_tipo
                .Top           = 138
                .Left          = 94
                .Width         = 262
                .Height        = 27
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Pagamentos"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 77
                    .Height    = 15
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "Recebimentos"
                    .Top       = 5
                    .Left      = 95
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Caption   = "Ambos"
                    .Top       = 5
                    .Left      = 196
                    .Width     = 61
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                .Value = 3
            ENDWITH

            *-- Label "Situacao :" (original top=244 -> Page1 top=159)
            par_oPag.AddObject("lbl_4c_Situa", "Label")
            WITH par_oPag.lbl_4c_Situa
                .Top       = 159
                .Left      = 47
                .Width     = 50
                .Height    = 15
                .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- opt_situa: Baixados/Pendentes/Todos
            *   (original top=240, left=94 -> Page1 top=155)
            par_oPag.AddObject("obj_4c_Opt_situa", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_situa
                .Top           = 155
                .Left          = 94
                .Width         = 254
                .Height        = 27
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Baixados"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 61
                    .Height    = 15
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "Pendentes"
                    .Top       = 5
                    .Left      = 93
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Caption   = "Todos"
                    .Top       = 5
                    .Left      = 196
                    .Width     = 53
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                .Value = 2
            ENDWITH

            *-- Label "Ordem :" (original top=262 -> Page1 top=177)
            par_oPag.AddObject("lbl_4c_Ordem", "Label")
            WITH par_oPag.lbl_4c_Ordem
                .Top       = 177
                .Left      = 56
                .Width     = 41
                .Height    = 15
                .Caption   = "Ordem :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- opt_ordem_impressao: Vencimento / Grupo/Conta
            *   (original top=258, left=94 -> Page1 top=173)
            par_oPag.AddObject("obj_4c_Opt_ordem_impressao", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_ordem_impressao
                .Top           = 173
                .Left          = 94
                .Width         = 185
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Vencimento"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 73
                    .Height    = 15
                    .BackStyle = 0
                    .AutoSize  = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "Grupo / Conta"
                    .Top       = 5
                    .Left      = 94
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .AutoSize  = .T.
                ENDWITH
                .Value = 1
            ENDWITH

            *== SECAO OPCOES NF ==============================================

            *-- Say3 "Opcoes :" (original top=281 -> Page1 top=196)
            par_oPag.AddObject("lbl_4c_OpcoesSay", "Label")
            WITH par_oPag.lbl_4c_OpcoesSay
                .Top       = 196
                .Left      = 52
                .Width     = 45
                .Height    = 15
                .Caption   = "Op" + CHR(231) + CHR(245) + "es :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- optOpcoes: Sim/Nao/Ambos (original top=277, left=94 -> Page1 top=192)
            par_oPag.AddObject("obj_4c_Opt_opcoes", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_opcoes
                .Top           = 192
                .Left          = 94
                .Width         = 251
                .Height        = 25
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 34
                    .Height    = 15
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Top       = 5
                    .Left      = 92
                    .Width     = 37
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Caption   = "Ambos"
                    .Top       = 5
                    .Left      = 196
                    .Width     = 50
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                .Value = 3
            ENDWITH

            *== SECAO PREVISTO ===============================================

            *-- Say4 "Previsto :" (original top=299 -> Page1 top=214)
            par_oPag.AddObject("lbl_4c_Previsto", "Label")
            WITH par_oPag.lbl_4c_Previsto
                .Top       = 214
                .Left      = 49
                .Width     = 48
                .Height    = 15
                .Caption   = "Previsto :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- OptPrev: Sim/Nao/Ambos (original top=296, left=94 -> Page1 top=211)
            par_oPag.AddObject("obj_4c_Opt_prev", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_prev
                .Top           = 211
                .Left          = 94
                .Width         = 256
                .Height        = 27
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 57
                    .Height    = 17
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Top       = 5
                    .Left      = 92
                    .Width     = 57
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption   = "Ambos"
                    .Top       = 5
                    .Left      = 196
                    .Width     = 55
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH
                .Value = 3
            ENDWITH

            *== SECAO ATRASOS ================================================

            *-- Say8 "Listar Atrasos :" (original top=318 -> Page1 top=233)
            par_oPag.AddObject("lbl_4c_ListaAtrasos", "Label")
            WITH par_oPag.lbl_4c_ListaAtrasos
                .Top       = 233
                .Left      = 82
                .Width     = 75
                .Height    = 15
                .Caption   = "Listar Atrasos :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- opt_Lista_Atra: Sim/Nao (original top=313, left=180 -> Page1 top=228)
            par_oPag.AddObject("obj_4c_Opt_lista_atra", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_lista_atra
                .Top           = 228
                .Left          = 180
                .Width         = 172
                .Height        = 27
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 57
                    .Height    = 17
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Top       = 5
                    .Left      = 110
                    .Width     = 57
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH
                .Value = 1
            ENDWITH
            BINDEVENT(par_oPag.obj_4c_Opt_lista_atra, "InteractiveChange", THIS, "OptListaAtraChange")

            *-- Say7 "Considerar Atrasos :" (original top=335 -> Page1 top=250)
            par_oPag.AddObject("lbl_4c_ConsidAtrasos", "Label")
            WITH par_oPag.lbl_4c_ConsidAtrasos
                .Top       = 250
                .Left      = 51
                .Width     = 101
                .Height    = 15
                .Caption   = "Considerar Atrasos :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- opt_Consid_Atra: Sim/Nao (original top=331, left=180 -> Page1 top=246)
            par_oPag.AddObject("obj_4c_Opt_consid_atra", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_consid_atra
                .Top           = 246
                .Left          = 180
                .Width         = 172
                .Height        = 27
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 57
                    .Height    = 17
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Top       = 5
                    .Left      = 110
                    .Width     = 57
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH
                .Value = 2
            ENDWITH

            *-- Say9 "Listar Cod. Operacao :" (original top=352 -> Page1 top=267)
            par_oPag.AddObject("lbl_4c_ListaCodOp", "Label")
            WITH par_oPag.lbl_4c_ListaCodOp
                .Top       = 267
                .Left      = 41
                .Width     = 111
                .Height    = 15
                .Caption   = "Listar C" + CHR(243) + "d. Opera" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Opt_Lista_op: Sim/Nao (original top=348, left=180 -> Page1 top=263)
            par_oPag.AddObject("obj_4c_Opt_lista_op", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_lista_op
                .Top           = 263
                .Left          = 180
                .Width         = 172
                .Height        = 27
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 57
                    .Height    = 17
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Top       = 5
                    .Left      = 110
                    .Width     = 57
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH
                .Value = 2
            ENDWITH

            *== SECAO SALDO ==================================================

            *-- Say5 "Saldo :" (original top=514 -> Page1 top=429)
            par_oPag.AddObject("lbl_4c_Saldo", "Label")
            WITH par_oPag.lbl_4c_Saldo
                .Top       = 429
                .Left      = 58
                .Width     = 35
                .Height    = 15
                .Caption   = "Saldo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- OptSaldo: Anterior/Na Data (original top=509, left=99 -> Page1 top=424)
            par_oPag.AddObject("obj_4c_Opt_saldo", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_saldo
                .Top           = 424
                .Left          = 99
                .Width         = 137
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                WITH .Buttons(1)
                    .Caption   = "Anterior"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 57
                    .Height    = 15
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "Na Data"
                    .Top       = 5
                    .Left      = 75
                    .Width     = 57
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .T.
                ENDWITH
                .Value = 1
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress: F4/Enter/Tab valida codigo de moeda referencia
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarCdMoeda(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress: F4/Enter/Tab lookup reverso por descricao moeda ref
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarDsMoeda(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaMoeConv - KeyPress: F4/Enter/Tab valida codigo de moeda conversao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoeConv(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarMoeConv(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDMoeConv - KeyPress: F4/Enter/Tab lookup reverso por descricao moeda conv
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDMoeConv(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarDMoeConv(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Valida codigo de moeda referencia contra SigCdMoe
    *   Equivalente ao get_cd_moeda.Valid do legado (fwBuscaExt)
    *   Se codigo encontrado: preenche descricao e bloqueia campo ds_moeda
    *   Se nao encontrado: abre FormBuscaAuxiliar
    *   Se vazio: limpa ambos os campos
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda(par_oPag)
        LOCAL loc_cCodigo, loc_oForm, loc_oErro
        TRY
            loc_cCodigo = ALLTRIM(par_oPag.txt_4c__cd_moeda.Value)
            IF EMPTY(loc_cCodigo)
                par_oPag.txt_4c__cd_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.ReadOnly = .F.
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cCodigo, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                        par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c__cd_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.ReadOnly = .F.
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdMoeda")
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Lookup reverso por descricao de moeda referencia
    *   Equivalente ao get_ds_moeda.Valid do legado
    *   get_ds_moeda.When = Empty(get_cd_moeda) => so ativo quando codigo vazio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda(par_oPag)
        LOCAL loc_cDesc, loc_oForm, loc_oErro
        TRY
            loc_cDesc = ALLTRIM(par_oPag.txt_4c__ds_moeda.Value)
            IF EMPTY(loc_cDesc)
                par_oPag.txt_4c__cd_moeda.Value = ""
                par_oPag.txt_4c__ds_moeda.Value = ""
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cDesc, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeD")
                    SELECT cursor_4c_BuscaMoeD
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
                        par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c__cd_moeda.Value = ""
                par_oPag.txt_4c__ds_moeda.Value = ""
            ENDIF
            IF USED("cursor_4c_BuscaMoeD")
                USE IN cursor_4c_BuscaMoeD
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDsMoeda")
            IF USED("cursor_4c_BuscaMoeD")
                USE IN cursor_4c_BuscaMoeD
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeConv - Valida codigo de moeda de conversao contra SigCdMoe
    *   Equivalente ao Get_MoeConv.Valid do legado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoeConv(par_oPag)
        LOCAL loc_cCodigo, loc_oForm, loc_oErro
        TRY
            loc_cCodigo = ALLTRIM(par_oPag.txt_4c_MoeConv.Value)
            IF EMPTY(loc_cCodigo)
                par_oPag.txt_4c_MoeConv.Value      = ""
                par_oPag.txt_4c_DMoeConv.Value     = ""
                par_oPag.txt_4c_DMoeConv.ReadOnly  = .F.
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeC", "CMoes", loc_cCodigo, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda Convers" + CHR(227) + "o")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeC")
                    SELECT cursor_4c_BuscaMoeC
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c_MoeConv.Value      = ALLTRIM(cursor_4c_BuscaMoeC.CMoes)
                        par_oPag.txt_4c_DMoeConv.Value     = ALLTRIM(cursor_4c_BuscaMoeC.DMoes)
                        par_oPag.txt_4c_DMoeConv.ReadOnly  = .T.
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c_MoeConv.Value      = ""
                par_oPag.txt_4c_DMoeConv.Value     = ""
                par_oPag.txt_4c_DMoeConv.ReadOnly  = .F.
            ENDIF
            IF USED("cursor_4c_BuscaMoeC")
                USE IN cursor_4c_BuscaMoeC
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarMoeConv")
            IF USED("cursor_4c_BuscaMoeC")
                USE IN cursor_4c_BuscaMoeC
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDMoeConv - Lookup reverso por descricao de moeda de conversao
    *   Equivalente ao Get_DMoeConv.Valid do legado
    *   Get_DMoeConv.When = Empty(Get_MoeConv) => so ativo quando codigo vazio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDMoeConv(par_oPag)
        LOCAL loc_cDesc, loc_oForm, loc_oErro
        TRY
            loc_cDesc = ALLTRIM(par_oPag.txt_4c_DMoeConv.Value)
            IF EMPTY(loc_cDesc)
                par_oPag.txt_4c_MoeConv.Value  = ""
                par_oPag.txt_4c_DMoeConv.Value = ""
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeCD", "DMoes", loc_cDesc, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda Convers" + CHR(227) + "o")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeCD")
                    SELECT cursor_4c_BuscaMoeCD
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c_MoeConv.Value      = ALLTRIM(cursor_4c_BuscaMoeCD.CMoes)
                        par_oPag.txt_4c_DMoeConv.Value     = ALLTRIM(cursor_4c_BuscaMoeCD.DMoes)
                        par_oPag.txt_4c_DMoeConv.ReadOnly  = .T.
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c_MoeConv.Value  = ""
                par_oPag.txt_4c_DMoeConv.Value = ""
            ENDIF
            IF USED("cursor_4c_BuscaMoeCD")
                USE IN cursor_4c_BuscaMoeCD
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDMoeConv")
            IF USED("cursor_4c_BuscaMoeCD")
                USE IN cursor_4c_BuscaMoeCD
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoedaDblClick - DblClick em txt_4c__cd_moeda: abre lookup de moeda referencia
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoedaDblClick()
        THIS.ValidarCdMoeda(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoedaDblClick - DblClick em txt_4c__ds_moeda: busca reversa por descricao
    *   Disponivel apenas quando txt_4c__cd_moeda vazio (ReadOnly=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoedaDblClick()
        THIS.ValidarDsMoeda(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaMoeConvDblClick - DblClick em txt_4c_MoeConv: abre lookup de moeda conversao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoeConvDblClick()
        THIS.ValidarMoeConv(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDMoeConvDblClick - DblClick em txt_4c_DMoeConv: busca reversa por descricao
    *   Disponivel apenas quando txt_4c_MoeConv vazio (ReadOnly=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDMoeConvDblClick()
        THIS.ValidarDMoeConv(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * OptListaAtraChange - InteractiveChange de obj_4c_Opt_lista_atra
    *   Quando "Listar Atrasos = Nao" (Value=2): desabilita obj_4c_Opt_consid_atra
    *   e forca Value=2 (Nao). Quando "Sim" (Value=1): reabilita.
    *--------------------------------------------------------------------------
    PROCEDURE OptListaAtraChange()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF loc_oPag.obj_4c_Opt_lista_atra.Value = 2
                loc_oPag.obj_4c_Opt_consid_atra.Value   = 2
                loc_oPag.obj_4c_Opt_consid_atra.Enabled = .F.
            ELSE
                loc_oPag.obj_4c_Opt_consid_atra.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OptListaAtraChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Visualiza relatorio em tela (equivalente a Visualizar)
    *   Em forms REPORT nao ha conceito de "buscar registros" - acao mapeada
    *   para previsualizar o relatorio com os filtros atuais.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *   Alias de BtnSairClick para conformidade com interface padrao dos forms.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Imprime relatorio (mapeado para Imprimir em forms REPORT)
    *   Em forms REPORT nao ha "salvar registro" - acao mapeada para imprimir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa todos os filtros restaurando valores padrao
    *   Em forms REPORT nao ha "cancelar edicao" - acao mapeada para limpar filtros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF MsgConfirma("Limpar todos os filtros e restaurar valores padr" + CHR(227) + "o?", ;
                       "Limpar Filtros")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere filtros do form para o BO (alias de FormParaRelatorio)
    *   Mantido para conformidade com API padrao dos forms.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega valores default do BO para o form
    *   Em forms REPORT reinicializa os filtros com valores padrao do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            loc_oPag.txt_4c__dt_inicial.Value          = THIS.this_oRelatorio.this_dDtInicial
            loc_oPag.txt_4c__dt_final.Value            = THIS.this_oRelatorio.this_dDtFinal
            loc_oPag.obj_4c_Opt_Data.Value             = THIS.this_oRelatorio.this_nTpData
            loc_oPag.txt_4c__cd_moeda.Value            = THIS.this_oRelatorio.this_cCdMoeda
            loc_oPag.txt_4c__ds_moeda.Value            = THIS.this_oRelatorio.this_cDsMoeda
            loc_oPag.txt_4c__ds_moeda.ReadOnly         = !EMPTY(THIS.this_oRelatorio.this_cCdMoeda)
            loc_oPag.txt_4c_MoeConv.Value              = THIS.this_oRelatorio.this_cMoeConv
            loc_oPag.txt_4c_DMoeConv.Value             = THIS.this_oRelatorio.this_cDMoeConv
            loc_oPag.txt_4c_DMoeConv.ReadOnly          = !EMPTY(THIS.this_oRelatorio.this_cMoeConv)
            loc_oPag.obj_4c_Opt_nr_tipo.Value          = THIS.this_oRelatorio.this_nNrTipo
            loc_oPag.obj_4c_Opt_situa.Value            = THIS.this_oRelatorio.this_nNrSitua
            loc_oPag.obj_4c_Opt_ordem_impressao.Value  = THIS.this_oRelatorio.this_nOrdImp
            loc_oPag.obj_4c_Opt_opcoes.Value           = THIS.this_oRelatorio.this_nOpcoes
            loc_oPag.obj_4c_Opt_prev.Value             = THIS.this_oRelatorio.this_nNrPrev
            loc_oPag.obj_4c_Opt_lista_atra.Value       = THIS.this_oRelatorio.this_nListaAtra
            loc_oPag.obj_4c_Opt_consid_atra.Value      = THIS.this_oRelatorio.this_nConsAtra
            loc_oPag.obj_4c_Opt_consid_atra.Enabled    = (THIS.this_oRelatorio.this_nListaAtra = 1)
            loc_oPag.obj_4c_Opt_lista_op.Value         = THIS.this_oRelatorio.this_nListaCodOp
            loc_oPag.obj_4c_Opt_saldo.Value            = THIS.this_oRelatorio.this_nSaldos

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    *   Em forms REPORT todos os campos de filtro estao sempre habilitados.
    *   Parametro par_lHabilitar ignorado - campos de filtro sao sempre editaveis.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            loc_oPag.txt_4c__dt_inicial.Enabled         = .T.
            loc_oPag.txt_4c__dt_final.Enabled           = .T.
            loc_oPag.obj_4c_Opt_Data.Enabled            = .T.
            loc_oPag.txt_4c__cd_moeda.Enabled           = .T.
            loc_oPag.txt_4c__ds_moeda.Enabled           = .T.
            loc_oPag.txt_4c_MoeConv.Enabled             = .T.
            loc_oPag.txt_4c_DMoeConv.Enabled            = .T.
            loc_oPag.obj_4c_Opt_nr_tipo.Enabled         = .T.
            loc_oPag.obj_4c_Opt_situa.Enabled           = .T.
            loc_oPag.obj_4c_Opt_ordem_impressao.Enabled = .T.
            loc_oPag.obj_4c_Opt_opcoes.Enabled          = .T.
            loc_oPag.obj_4c_Opt_prev.Enabled            = .T.
            loc_oPag.obj_4c_Opt_lista_atra.Enabled      = .T.
            loc_oPag.obj_4c_Opt_lista_op.Enabled        = .T.
            loc_oPag.obj_4c_Opt_saldo.Enabled           = .T.
            loc_oPag.grd_4c_Empresas.Enabled            = .T.
            loc_oPag.grd_4c_Disps.Enabled               = .T.
            loc_oPag.grd_4c_Oper.Enabled                = .T.
            loc_oPag.cmd_4c_MarcarEmp.Enabled           = .T.
            loc_oPag.cmd_4c_DesmarcarEmp.Enabled        = .T.
            loc_oPag.cmd_4c_MarcarDisp.Enabled          = .T.
            loc_oPag.cmd_4c_DesmarcarDisp.Enabled       = .T.
            loc_oPag.cmd_4c_MarcarOpe.Enabled           = .T.
            loc_oPag.cmd_4c_DesmarcarOpe.Enabled        = .T.

            *-- Consid. Atrasos: somente habilitado se Listar Atrasos = Sim
            IF VARTYPE(loc_oPag.obj_4c_Opt_consid_atra) = "O"
                loc_oPag.obj_4c_Opt_consid_atra.Enabled = (loc_oPag.obj_4c_Opt_lista_atra.Value = 1)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *   Em forms REPORT nao ha modos CRUD. Botoes de relatorio estao sempre
    *   habilitados. Metodo mantido para conformidade com API padrao.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega os tres grids selecionaveis do relatorio
    *   Empresas / Disponibilidades / Operacoes: busca novos dados via BO
    *   e atualiza RecordSource de cada grid.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oPag, loc_oGrd, loc_oErro
        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF

            IF !THIS.this_oRelatorio.CarregarCursoresBase()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro() + CHR(13) + ;
                    "Alguns grids poder" + CHR(227) + "o aparecer vazios.", "Aviso")
            ENDIF

            loc_oPag = THIS.pgf_4c_Paginas.Page1

            *-- Atualizar grid de empresas
            IF VARTYPE(loc_oPag.grd_4c_Empresas) = "O"
                loc_oGrd = loc_oPag.grd_4c_Empresas
                IF USED("cursor_4c_Emp")
                    loc_oGrd.ColumnCount = 3
                    loc_oGrd.RecordSource = "cursor_4c_Emp"
                ENDIF
                loc_oGrd.Column1.ControlSource  = "cursor_4c_Emp.ImpEmps"
                loc_oGrd.Column2.ControlSource  = "cursor_4c_Emp.Cemps"
                loc_oGrd.Column3.ControlSource  = "cursor_4c_Emp.Razas"
                loc_oGrd.Column1.Header1.Caption = ""
                loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrd.Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
                loc_oGrd.Refresh()
            ENDIF

            *-- Atualizar grid de disponibilidades
            IF VARTYPE(loc_oPag.grd_4c_Disps) = "O"
                loc_oGrd = loc_oPag.grd_4c_Disps
                IF USED("cursor_4c_Disp")
                    loc_oGrd.ColumnCount = 3
                    loc_oGrd.RecordSource = "cursor_4c_Disp"
                ENDIF
                loc_oGrd.Column1.ControlSource  = "cursor_4c_Disp.ImpDisps"
                loc_oGrd.Column2.ControlSource  = "cursor_4c_Disp.Grupos"
                loc_oGrd.Column3.ControlSource  = "cursor_4c_Disp.Contas"
                loc_oGrd.Column1.Header1.Caption = ""
                loc_oGrd.Column2.Header1.Caption = "Grupo"
                loc_oGrd.Column3.Header1.Caption = "Conta"
                loc_oGrd.Refresh()
            ENDIF

            *-- Atualizar grid de operacoes de titulos
            IF VARTYPE(loc_oPag.grd_4c_Oper) = "O"
                loc_oGrd = loc_oPag.grd_4c_Oper
                IF USED("cursor_4c_Oper")
                    loc_oGrd.ColumnCount = 3
                    loc_oGrd.RecordSource = "cursor_4c_Oper"
                ENDIF
                loc_oGrd.Column1.ControlSource  = "cursor_4c_Oper.SeleOp"
                loc_oGrd.Column2.ControlSource  = "cursor_4c_Oper.Dopes"
                loc_oGrd.Column3.ControlSource  = "cursor_4c_Oper.Opers"
                loc_oGrd.Column1.Header1.Caption = ""
                loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrd.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrd.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarLista")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreffiBO.prg):
*==============================================================================
* SIGREFFI BO - Relatorio de Fluxo Financeiro Analitico
*
* Herda de RelatorioBase
* Processa dados de fluxo financeiro analitico com filtros por:
*   - Periodo (data inicial/final, tipo Vencimento/Lancamento)
*   - Moeda de referencia e moeda de conversao
*   - Tipo (Pagamentos/Recebimentos/Ambos)
*   - Situacao (Baixados/Pendentes/Todos)
*   - Ordem de impressao (Vencimento/Grupo-Conta)
*   - Opcoes NF, Previsto, Saldo, Atrasos
*   - Empresas e Disponibilidades selecionaveis via grid
*   - Operacoes de titulos selecionaveis via grid
*==============================================================================

*-- Garante que RelatorioBase esta carregado
IF !("RELATORIOBASE" $ UPPER(SET("PROCEDURE")))
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "relatoriobase.prg") ADDITIVE
ENDIF

DEFINE CLASS sigreffiBO AS RelatorioBase

    *--------------------------------------------------------------------------
    * Propriedades de identificacao do relatorio
    *--------------------------------------------------------------------------
    this_cTabela       = ""
    this_cCampoChave   = ""
    this_cMensagemErro = ""

    *-- Nome do FRX e titulo do relatorio
    this_cFRX          = "SigReFfi"
    this_cTituloRel    = ""

    *--------------------------------------------------------------------------
    * Propriedades de filtro: Periodo
    *--------------------------------------------------------------------------
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nTpData       = 1     && 1=Vencimento 2=Lancamento

    *--------------------------------------------------------------------------
    * Propriedades de filtro: Moeda
    *--------------------------------------------------------------------------
    this_cCdMoeda      = ""    && Codigo moeda referencia (max 3)
    this_cDsMoeda      = ""    && Descricao moeda referencia (max 15)
    this_cMoeConv      = ""    && Codigo moeda de conversao (max 3)
    this_cDMoeConv     = ""    && Descricao moeda de conversao (max 15)

    *--------------------------------------------------------------------------
    * Propriedades de filtro: Opcoes de tipo e situacao
    *--------------------------------------------------------------------------
    this_nNrTipo       = 3     && 1=Pagamentos 2=Recebimentos 3=Ambos
    this_nNrSitua      = 1     && 1=Baixados 2=Pendentes 3=Todos
    this_nOrdImp       = 1     && 1=Vencimento 2=Grupo/Conta
    this_nOpcoes       = 3     && 1=Com NF 2=Sem NF 3=Ambos (caption carregado de SigCdPac)
    this_nNrPrev       = 3     && 1=Sim(previsto) 2=Nao 3=Ambos

    *--------------------------------------------------------------------------
    * Propriedades de filtro: Saldo e Atrasos
    *--------------------------------------------------------------------------
    this_nSaldos       = 1     && 1=Anterior (data-1) 2=Na Data
    this_nConsAtra     = 2     && 1=Sim (considerar atrasos) 2=Nao
    this_nListaAtra    = 1     && 1=Sim (listar atrasos) 2=Nao
    this_nListaCodOp   = 2     && 1=Sim (listar codigo operacao) 2=Nao

    *--------------------------------------------------------------------------
    * Nomes dos cursores de dados
    *--------------------------------------------------------------------------
    this_cCursorEmp       = "cursor_4c_Emp"       && Empresas selecionaveis (cEmp no legado)
    this_cCursorDisp      = "cursor_4c_Disp"      && Disponibilidades selecionaveis (cDisp no legado)
    this_cCursorOper      = "cursor_4c_Oper"      && Operacoes de titulos (crSigOpOpe no legado)
    this_cCursorMoeda     = "cursor_4c_Moeda"     && Tabela de moedas (crSigCdMoe no legado)
    this_cCursorCotacao   = "cursor_4c_Cotacao"   && Cotacoes (crSigCdCot no legado)
    this_cCursorRec       = "cursor_4c_Rec"       && Grupos de recebimento (crSigCdRec no legado)
    this_cCursorCabecalho = "cursor_4c_Cabecalho" && Cabecalho do relatorio
    this_cCursorRelatorio = "cursor_4c_Relatorio" && Dados principais (csRelatorio no legado)
    this_cCursorDados     = "cursor_4c_Relatorio" && Alias padrao exigido por RelatorioBase

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de processamento
    *--------------------------------------------------------------------------
    this_lCursoresCarregados = .F.   && Flag: cursores de grids ja inicializados

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ELSE
                THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico"
                THIS.this_dDtInicial = DATE()
                THIS.this_dDtFinal   = DATE()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursoresBase - Carrega cursores de selecao (Empresas, Disps, Oper)
    * Chamado pelo Form no InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCursoresBase()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSqlOpe, loc_cSqlEmp, loc_cSqlDisp
        LOCAL loc_cSqlMoe, loc_cSqlCot, loc_cSqlRec
        LOCAL loc_nResult
        LOCAL loc_cCursorEmp, loc_cCursorDisp, loc_cCursorOper
        LOCAL loc_cCursorMoeda, loc_cCursorCotacao, loc_cCursorRec

        loc_lSucesso = .F.

        *-- Copiar nomes de cursor para locais (evitar THIS dentro de SCAN)
        loc_cCursorEmp     = THIS.this_cCursorEmp
        loc_cCursorDisp    = THIS.this_cCursorDisp
        loc_cCursorOper    = THIS.this_cCursorOper
        loc_cCursorMoeda   = THIS.this_cCursorMoeda
        loc_cCursorCotacao = THIS.this_cCursorCotacao
        loc_cCursorRec     = THIS.this_cCursorRec

        TRY
            *-- Cursor de operacoes de titulos (SigOpOpe - exceto canceladas)
            loc_cSqlOpe = "SELECT CAST(0 AS BIT) AS SeleOp, o.Dopes, o.Opers, o.RealPrevs " + ;
                          "FROM SigOpOpe o " + ;
                          "WHERE o.OpeCancs <> 1 " + ;
                          "ORDER BY o.Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlOpe, loc_cCursorOper)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos"
            ELSE
                *-- Cursor de empresas (SigCdEmp)
                loc_cSqlEmp = "SELECT CAST(0 AS BIT) AS ImpEmps, e.Cemps, e.Razas " + ;
                              "FROM SigCdEmp e " + ;
                              "ORDER BY e.Razas"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, loc_cCursorEmp)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar empresas"
                ELSE
                    *-- Marcar empresa corrente como selecionada
                    LOCAL loc_cEmpAtual
                    loc_cEmpAtual = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                    SELECT (loc_cCursorEmp)
                    SCAN
                        IF ALLTRIM(Cemps) == loc_cEmpAtual
                            REPLACE ImpEmps WITH 1
                        ENDIF
                    ENDSCAN

                    *-- Cursor de disponibilidades (SigCdDis tipos 0 e 1)
                    loc_cSqlDisp = "SELECT CAST(1 AS BIT) AS ImpDisps, d.Grupos, d.Contas, d.Tipos " + ;
                                   "FROM SigCdDis d " + ;
                                   "WHERE d.Tipos IN (0, 1) " + ;
                                   "ORDER BY d.Grupos, d.Contas"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlDisp, loc_cCursorDisp)
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao carregar disponibilidades"
                    ELSE
                        *-- Cursor de moedas (SigCdMoe)
                        loc_cSqlMoe = "SELECT m.CMoes, m.DMoes, m.Cotas " + ;
                                      "FROM SigCdMoe m " + ;
                                      "ORDER BY m.CMoes"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlMoe, loc_cCursorMoeda)
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao carregar moedas"
                        ELSE
                            *-- Cursor de cotacoes (SigCdCot)
                            loc_cSqlCot = "SELECT c.CMoes, c.Datas, c.Valos " + ;
                                          "FROM SigCdCot c " + ;
                                          "ORDER BY c.CMoes, c.Datas"

                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlCot, loc_cCursorCotacao)
                            IF loc_nResult < 0
                                THIS.this_cMensagemErro = "Erro ao carregar cota" + CHR(231) + CHR(245) + "es"
                            ELSE
                                *-- Cursor de grupos de recebimento (SigCdRec)
                                loc_cSqlRec = "SELECT r.Grupos " + ;
                                              "FROM SigCdRec r " + ;
                                              "ORDER BY r.Grupos"

                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlRec, loc_cCursorRec)
                                IF loc_nResult < 0
                                    THIS.this_cMensagemErro = "Erro ao carregar grupos de recebimento"
                                ELSE
                                    THIS.this_lCursoresCarregados = .T.
                                    loc_lSucesso = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.CarregarCursoresBase")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCaptionsOpcoes - Carrega captions de optOpcoes de SigCdPac
    * par_aResult deve ser dimensionado com 3 posicoes pelo chamador
    * Preenche par_aResult[1..3] com captions customizados ou padrao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCaptionsOpcoes(par_aResult)
        LOCAL loc_cSql, loc_nResult

        par_aResult[1] = "Sim"
        par_aResult[2] = "N" + CHR(227) + "o"
        par_aResult[3] = "Ambos"

        TRY
            loc_cSql = "SELECT TOP 1 TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Pac")
            IF loc_nResult > 0
                SELECT cursor_4c_Pac
                GO TOP
                IF !EOF()
                    IF !EMPTY(cursor_4c_Pac.TitOpcS)
                        par_aResult[1] = ALLTRIM(cursor_4c_Pac.TitOpcS)
                    ENDIF
                    IF !EMPTY(cursor_4c_Pac.TitOpcN)
                        par_aResult[2] = ALLTRIM(cursor_4c_Pac.TitOpcN)
                    ENDIF
                    IF !EMPTY(cursor_4c_Pac.TitOpcA)
                        par_aResult[3] = ALLTRIM(cursor_4c_Pac.TitOpcA)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.CarregarCaptionsOpcoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacaoMoeda - Busca cotacao de moeda na data informada
    * Retorna valor numerico da cotacao (1 se nao encontrar)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacaoMoeda(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSql, loc_nResult

        loc_nCotacao = 1

        IF EMPTY(par_cMoeda)
            RETURN loc_nCotacao
        ENDIF

        TRY
            loc_cSql = "SELECT TOP 1 Valos FROM SigCdCot " + ;
                       "WHERE CMoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                       " AND Datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY Datas DESC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CotMoe")
            IF loc_nResult > 0
                SELECT cursor_4c_CotMoe
                GO TOP
                IF !EOF()
                    loc_nCotacao = IIF(cursor_4c_CotMoe.Valos = 0, 1, cursor_4c_CotMoe.Valos)
                ENDIF
                IF USED("cursor_4c_CotMoe")
                    USE IN cursor_4c_CotMoe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.BuscarCotacaoMoeda")
        ENDTRY

        RETURN loc_nCotacao
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados para o relatorio de fluxo financeiro
    * Monta cursor_4c_Relatorio e cursor_4c_Cabecalho para o FRX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_dDtInicial, loc_dDtFinal
        LOCAL loc_cCdMoeda, loc_cDsMoeda, loc_cMoeConv
        LOCAL loc_nNrTipo, loc_nNrPrev, loc_nNrSitua, loc_nOrdImp
        LOCAL loc_nOpcoes, loc_nTpData, loc_nSaldos
        LOCAL loc_nConsAtra, loc_nListaAtra, loc_nListaCodOp
        LOCAL loc_nVlCotacao
        LOCAL loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo, loc_cCbEmpresa
        LOCAL loc_cSql, loc_nResult

        loc_lSucesso = .F.

        TRY
            *-- Capturar valores dos filtros
            loc_dDtInicial   = THIS.this_dDtInicial
            loc_dDtFinal     = THIS.this_dDtFinal
            loc_cCdMoeda     = ALLTRIM(THIS.this_cCdMoeda)
            loc_cDsMoeda     = ALLTRIM(THIS.this_cDsMoeda)
            loc_nNrTipo      = THIS.this_nNrTipo
            loc_nNrPrev      = THIS.this_nNrPrev
            loc_nNrSitua     = THIS.this_nNrSitua
            loc_nOrdImp      = THIS.this_nOrdImp
            loc_nOpcoes      = THIS.this_nOpcoes
            loc_nTpData      = THIS.this_nTpData
            loc_nSaldos      = THIS.this_nSaldos
            loc_cMoeConv     = ALLTRIM(THIS.this_cMoeConv)
            loc_nConsAtra    = THIS.this_nConsAtra
            loc_nListaAtra   = THIS.this_nListaAtra
            loc_nListaCodOp  = THIS.this_nListaCodOp

            *-- Cotacao da moeda de conversao
            loc_nVlCotacao = THIS.BuscarCotacaoMoeda(loc_cMoeConv, DATE())
            IF loc_nVlCotacao = 0
                loc_nVlCotacao = 1
            ENDIF

            *-- Buscar nome da empresa corrente
            loc_cNmEmpresa = ""
            loc_cSql = "SELECT TOP 1 Razas FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_NmEmp")
            IF loc_nResult > 0
                SELECT cursor_4c_NmEmp
                GO TOP
                IF !EOF()
                    loc_cNmEmpresa = ALLTRIM(cursor_4c_NmEmp.Razas)
                ENDIF
                IF USED("cursor_4c_NmEmp")
                    USE IN cursor_4c_NmEmp
                ENDIF
            ENDIF

            *-- Montar titulo e periodo
            loc_cNmTitulo = "Fluxo Financeiro Anal" + CHR(237) + "tico [" + ;
                IIF(loc_nNrTipo = 1, "Pagamentos", ;
                    IIF(loc_nNrTipo = 2, "Recebimentos", "Todos")) + "]"

            loc_cNmPeriodo = "Periodo: " + DTOC(loc_dDtInicial) + " " + CHR(224) + " " + ;
                DTOC(loc_dDtFinal) + " " + ;
                IIF(loc_nTpData = 1, "Vencimento", "Lan" + CHR(231) + "amento")

            loc_cCbEmpresa = ""
            IF loc_nNrSitua <> 3
                loc_cCbEmpresa = "   Situa" + CHR(231) + CHR(227) + "o: " + ;
                    IIF(loc_nNrSitua = 1, "Baixados", "Pendentes")
            ENDIF

            *-- Criar cursor de cabecalho do relatorio
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (nm_empresa C(80), nm_titulo C(80), nm_periodo C(80), ;
                 cb_empresa C(80), cb_Moe_Ref C(3), ConsidAtra N(1))

            INSERT INTO (THIS.this_cCursorCabecalho) ;
                (nm_empresa, nm_titulo, nm_periodo, cb_empresa, cb_Moe_Ref, ConsidAtra) ;
                VALUES (loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo, ;
                        loc_cCbEmpresa, loc_cMoeConv, loc_nConsAtra)

            *-- Criar cursor principal do relatorio
            IF USED(THIS.this_cCursorRelatorio)
                USE IN (THIS.this_cCursorRelatorio)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorRelatorio) ;
                (moedas C(3), dsmoedas C(15), vencs D, grupos C(10), contas C(10), ;
                 dopcs C(20), dscontas C(40), valors N(12,2), hists C(200), ;
                 flpagos C(1), quebras N(6), subquebras N(6), cstotals C(50), ;
                 Fase N(1), Saldos N(12,2), vl_Convertido N(12,2), ;
                 flPrevs C(2), Opers C(1))

            *-- Processar saldos de disponibilidades (Fase=1)
            IF !THIS.ProcessarSaldosDisponibilidades(loc_cCdMoeda, loc_dDtInicial, ;
                   loc_nSaldos, loc_nOpcoes, loc_nVlCotacao)
                MsgErro(THIS.this_cMensagemErro, "PrepararDados - Saldos")
            ENDIF

            *-- Processar atrasos se solicitado (Fase=3)
            IF loc_nListaAtra = 1
                IF !THIS.ProcessarAtrasos(loc_dDtInicial, loc_cCdMoeda, ;
                       loc_nNrTipo, loc_nNrPrev, loc_nOpcoes, ;
                       loc_nListaCodOp, loc_nVlCotacao)
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados - Atrasos")
                ENDIF
            ENDIF

            *-- Processar fluxo do periodo (Fase=2)
            IF !THIS.ProcessarFluxoPeriodo(loc_dDtInicial, loc_dDtFinal, loc_cCdMoeda, ;
                   loc_nNrTipo, loc_nNrPrev, loc_nNrSitua, loc_nOrdImp, loc_nOpcoes, ;
                   loc_nTpData, loc_nListaCodOp, loc_nVlCotacao)
                MsgErro(THIS.this_cMensagemErro, "PrepararDados - Periodo")
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarSaldosDisponibilidades - Processa saldos iniciais (Fase=1)
    * Busca saldo anterior ao periodo para disponibilidades selecionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarSaldosDisponibilidades(par_cCdMoeda, par_dDtInicial, ;
        par_nSaldos, par_nOpcoes, par_nVlCotacao)

        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSql, loc_nResult
        LOCAL loc_cFiltroMoeda, loc_dDataCalc
        LOCAL loc_cCursorDisp, loc_cCursorMoeda, loc_cCursorRel

        loc_lSucesso = .F.
        loc_cCursorDisp  = THIS.this_cCursorDisp
        loc_cCursorMoeda = THIS.this_cCursorMoeda
        loc_cCursorRel   = THIS.this_cCursorRelatorio

        TRY
            loc_cFiltroMoeda = ""
            IF !EMPTY(par_cCdMoeda)
                loc_cFiltroMoeda = " AND a.Moedas = " + EscaparSQL(par_cCdMoeda)
            ENDIF

            *-- Data base para saldo: dia anterior se Anterior, propria data se Na Data
            loc_dDataCalc = IIF(par_nSaldos = 1, par_dDtInicial - 1, par_dDtInicial)

            *-- Buscar cruzamento SigMvSlc x SigCdCli para disponibilidades
            loc_cSql = "SELECT a.Grupos, a.Contas, a.Moedas, b.cContabs " + ;
                       "FROM SigMvSlc a " + ;
                       "INNER JOIN SigCdCli b ON b.IClis = a.Contas " + ;
                       "WHERE 1=1 " + loc_cFiltroMoeda + ;
                       " ORDER BY a.Grupos, a.Contas, a.Moedas"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_MvSlc")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar movimenta" + CHR(231) + CHR(227) + "o de saldo"
            ELSE
                *-- Percorrer disponibilidades selecionadas
                LOCAL loc_cGrDisp, loc_cCtDisp, loc_nImpDisp
                SELECT (loc_cCursorDisp)
                GO TOP
                SCAN
                    loc_cGrDisp  = ALLTRIM(Grupos)
                    loc_cCtDisp  = ALLTRIM(Contas)
                    loc_nImpDisp = ImpDisps

                    IF loc_nImpDisp <> 1
                        LOOP
                    ENDIF

                    *-- Para cada linha do cursor MvSlc que bate com esta conta
                    LOCAL loc_cGrMvSlc, loc_cCtMvSlc, loc_cMoesMvSlc, loc_cContabs
                    SELECT cursor_4c_MvSlc
                    GO TOP
                    SCAN
                        loc_cGrMvSlc  = ALLTRIM(cursor_4c_MvSlc.Grupos)
                        loc_cCtMvSlc  = ALLTRIM(cursor_4c_MvSlc.Contas)
                        loc_cMoesMvSlc= ALLTRIM(cursor_4c_MvSlc.Moedas)
                        loc_cContabs  = ALLTRIM(cursor_4c_MvSlc.cContabs)

                        IF loc_cGrMvSlc <> loc_cGrDisp OR loc_cCtMvSlc <> loc_cCtDisp
                            LOOP
                        ENDIF

                        *-- Aplicar filtro de opcoes (NF ou nao NF) via cContabs
                        LOCAL loc_lPassaOpc
                        loc_lPassaOpc = .T.
                        IF par_nOpcoes = 1
                            loc_lPassaOpc = !EMPTY(loc_cContabs)
                        ELSE
                            IF par_nOpcoes = 2
                            loc_lPassaOpc = EMPTY(loc_cContabs)
                            ENDIF
                        ENDIF

                        IF !loc_lPassaOpc
                            LOOP
                        ENDIF

                        *-- Buscar ultimo saldo no SigMvCcr ate a data base
                        LOCAL loc_cGruConMoes, loc_cFiltroMoeInner, loc_cSqlSaldo
                        LOCAL loc_nSaldo, loc_nResSaldo
                        loc_cGruConMoes     = loc_cGrMvSlc + loc_cCtMvSlc + loc_cMoesMvSlc
                        loc_cFiltroMoeInner = ""
                        IF !EMPTY(par_cCdMoeda)
                            loc_cFiltroMoeInner = " AND Moedas = " + EscaparSQL(par_cCdMoeda)
                        ENDIF

                        loc_cSqlSaldo = "SELECT TOP 1 Saldos FROM SigMvCcr " + ;
                                        "WHERE GruConMoes = " + EscaparSQL(loc_cGruConMoes) + ;
                                        loc_cFiltroMoeInner + ;
                                        " AND Datas <= " + FormatarDataSQL(loc_dDataCalc) + ;
                                        " ORDER BY GruConMoes ASC, cIdChaves DESC"

                        loc_nSaldo     = 0
                        loc_nResSaldo  = SQLEXEC(gnConnHandle, loc_cSqlSaldo, "cursor_4c_Ccr")
                        IF loc_nResSaldo > 0
                            SELECT cursor_4c_Ccr
                            GO TOP
                            IF !EOF()
                                loc_nSaldo = cursor_4c_Ccr.Saldos
                            ENDIF
                            IF USED("cursor_4c_Ccr")
                                USE IN cursor_4c_Ccr
                            ENDIF
                        ENDIF

                        IF loc_nSaldo <> 0
                            *-- Buscar descricao da moeda
                            LOCAL loc_cDsMoedaLinha, loc_cMoeLinha
                            loc_cDsMoedaLinha = ""
                            loc_cMoeLinha     = loc_cMoesMvSlc
                            IF USED(loc_cCursorMoeda)
                                SELECT (loc_cCursorMoeda)
                                GO TOP
                                SCAN
                                    IF ALLTRIM(CMoes) == loc_cMoeLinha
                                        loc_cDsMoedaLinha = ALLTRIM(DMoes)
                                        EXIT
                                    ENDIF
                                ENDSCAN
                            ENDIF

                            *-- Calcular conversao
                            LOCAL loc_nCtRef, loc_nVlConv
                            loc_nCtRef = THIS.BuscarCotacaoMoeda(loc_cMoeLinha, DATE())
                            IF loc_nCtRef = 0
                                loc_nCtRef = 1
                            ENDIF
                            loc_nVlConv = (loc_nSaldo * loc_nCtRef / par_nVlCotacao)

                            SELECT (loc_cCursorRel)
                            INSERT INTO (loc_cCursorRel) ;
                                (Grupos, Contas, Moedas, Saldos, Fase, DsMoedas, Vl_Convertido) ;
                                VALUES (loc_cGrDisp, loc_cCtDisp, ;
                                        loc_cMoeLinha, loc_nSaldo, 1, ;
                                        loc_cDsMoedaLinha, loc_nVlConv)
                        ENDIF

                        SELECT cursor_4c_MvSlc
                    ENDSCAN

                    SELECT (loc_cCursorDisp)
                ENDSCAN

                IF USED("cursor_4c_MvSlc")
                    USE IN cursor_4c_MvSlc
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.ProcessarSaldosDisponibilidades")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarAtrasos - Processa titulos vencidos antes do periodo (Fase=3)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarAtrasos(par_dDtInicial, par_cCdMoeda, ;
        par_nNrTipo, par_nNrPrev, par_nOpcoes, ;
        par_nListaCodOp, par_nVlCotacao)

        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSql, loc_nResult
        LOCAL loc_cFiltroMoeda, loc_cFiltroNF, loc_cFiltroPrev
        LOCAL loc_cCursorEmp, loc_cCursorMoeda, loc_cCursorRel

        loc_lSucesso = .F.
        loc_cCursorEmp   = THIS.this_cCursorEmp
        loc_cCursorMoeda = THIS.this_cCursorMoeda
        loc_cCursorRel   = THIS.this_cCursorRelatorio

        TRY
            loc_cFiltroMoeda = ""
            IF !EMPTY(par_cCdMoeda)
                loc_cFiltroMoeda = " AND a.Moedas = " + EscaparSQL(par_cCdMoeda)
            ENDIF

            loc_cFiltroNF = ""
            IF par_nOpcoes = 1
                loc_cFiltroNF = " AND a.Nfs IS NOT NULL AND LTRIM(RTRIM(a.Nfs)) <> ''"
            ELSE
                IF par_nOpcoes = 2
                loc_cFiltroNF = " AND (a.Nfs IS NULL OR LTRIM(RTRIM(a.Nfs)) = '')"
                ENDIF
            ENDIF

            loc_cFiltroPrev = ""
            IF par_nNrPrev = 1
                loc_cFiltroPrev = " AND b.ValPres = 2"
            ELSE
                IF par_nNrPrev = 2
                loc_cFiltroPrev = " AND b.ValPres <> 2"
                ENDIF
            ENDIF

            loc_cSql = "SELECT a.Moedas, a.Vencs, a.Opers, a.Grupos, a.Contas, a.DopCs, " + ;
                       "a.Valors, a.Hists, a.ValPags, a.Emps, a.NOpers, " + ;
                       "a.CIdChaves, a.EmpDopNums, a.EmpDopNcs " + ;
                       "FROM SigMvCcr a " + ;
                       "INNER JOIN SigTempR b ON a.DopCs = b.Dopes " + ;
                       "WHERE a.Vencs < " + FormatarDataSQL(par_dDtInicial) + ;
                       " AND (a.Valors - a.ValPags) > 0 " + ;
                       " AND a.TitCancs <> 1 " + ;
                       loc_cFiltroMoeda + loc_cFiltroNF + loc_cFiltroPrev + ;
                       " ORDER BY a.Moedas, a.Vencs, a.Grupos, a.Contas, a.CIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Atrasos")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar atrasos"
            ELSE
                LOCAL loc_cEmpAtr, loc_nImpEmpAtr, loc_lEmpSel
                LOCAL loc_nValors, loc_nValPags, loc_nSaldoAtr
                LOCAL loc_cFlPagos, loc_cHistAtr, loc_cEDN
                LOCAL loc_cMoesAtr, loc_cDsMoesAtr, loc_cOpersAtr
                LOCAL loc_nCtRefAtr, loc_nVlConvAtr

                SELECT cursor_4c_Atrasos
                GO TOP
                SCAN
                    loc_cEmpAtr = ALLTRIM(cursor_4c_Atrasos.Emps)

                    *-- Verificar se empresa esta selecionada no grid
                    loc_lEmpSel = .F.
                    IF USED(loc_cCursorEmp)
                        SELECT (loc_cCursorEmp)
                        GO TOP
                        SCAN
                            IF ALLTRIM(Cemps) == loc_cEmpAtr
                                loc_nImpEmpAtr = ImpEmps
                                IF loc_nImpEmpAtr = 1
                                    loc_lEmpSel = .T.
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT cursor_4c_Atrasos

                    IF !loc_lEmpSel
                        LOOP
                    ENDIF

                    loc_nValors   = cursor_4c_Atrasos.Valors
                    loc_nValPags  = cursor_4c_Atrasos.ValPags
                    loc_nSaldoAtr = loc_nValors - loc_nValPags

                    IF loc_nSaldoAtr <= 0
                        LOOP
                    ENDIF

                    loc_cFlPagos  = IIF(loc_nValPags >= loc_nValors, "*", "")
                    loc_cHistAtr  = ALLTRIM(cursor_4c_Atrasos.Hists)
                    loc_cMoesAtr  = ALLTRIM(cursor_4c_Atrasos.Moedas)
                    loc_cOpersAtr = ALLTRIM(cursor_4c_Atrasos.Opers)

                    IF par_nListaCodOp = 1
                        loc_cEDN = ALLTRIM(cursor_4c_Atrasos.EmpDopNums)
                        IF VAL(RIGHT(loc_cEDN, 6)) > 0
                            loc_cHistAtr = loc_cHistAtr + loc_cEDN
                        ELSE
                            loc_cHistAtr = loc_cHistAtr + ALLTRIM(cursor_4c_Atrasos.EmpDopNcs)
                        ENDIF
                    ENDIF

                    *-- Buscar descricao da moeda
                    loc_cDsMoesAtr = ""
                    IF USED(loc_cCursorMoeda)
                        SELECT (loc_cCursorMoeda)
                        GO TOP
                        SCAN
                            IF ALLTRIM(CMoes) == loc_cMoesAtr
                                loc_cDsMoesAtr = ALLTRIM(DMoes)
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT cursor_4c_Atrasos

                    *-- Calcular conversao
                    loc_nCtRefAtr = THIS.BuscarCotacaoMoeda(loc_cMoesAtr, DATE())
                    IF loc_nCtRefAtr = 0
                        loc_nCtRefAtr = 1
                    ENDIF
                    loc_nVlConvAtr = (loc_nSaldoAtr * loc_nCtRefAtr / par_nVlCotacao)

                    SELECT (loc_cCursorRel)
                    INSERT INTO (loc_cCursorRel) ;
                        (Moedas, DsMoedas, Vencs, Grupos, Contas, DopCs, Valors, ;
                         Hists, FlPagos, Fase, Saldos, Vl_Convertido, FlPrevs, Opers) ;
                        VALUES (loc_cMoesAtr, loc_cDsMoesAtr, ;
                                cursor_4c_Atrasos.Vencs, ;
                                ALLTRIM(cursor_4c_Atrasos.Grupos), ;
                                ALLTRIM(cursor_4c_Atrasos.Contas), ;
                                ALLTRIM(cursor_4c_Atrasos.DopCs), ;
                                loc_nSaldoAtr, loc_cHistAtr, loc_cFlPagos, ;
                                3, 0, loc_nVlConvAtr, "", loc_cOpersAtr)

                    SELECT cursor_4c_Atrasos
                ENDSCAN

                IF USED("cursor_4c_Atrasos")
                    USE IN cursor_4c_Atrasos
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.ProcessarAtrasos")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarFluxoPeriodo - Processa fluxo do periodo principal (Fase=2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarFluxoPeriodo(par_dDtInicial, par_dDtFinal, par_cCdMoeda, ;
        par_nNrTipo, par_nNrPrev, par_nNrSitua, par_nOrdImp, par_nOpcoes, ;
        par_nTpData, par_nListaCodOp, par_nVlCotacao)

        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSql, loc_nResult
        LOCAL loc_cFiltroMoeda, loc_cFiltroNF, loc_cFiltroPrev
        LOCAL loc_cFiltroSitua, loc_cCampData, loc_cOrder
        LOCAL loc_cCursorEmp, loc_cCursorMoeda, loc_cCursorRel

        loc_lSucesso = .F.
        loc_cCursorEmp   = THIS.this_cCursorEmp
        loc_cCursorMoeda = THIS.this_cCursorMoeda
        loc_cCursorRel   = THIS.this_cCursorRelatorio

        TRY
            loc_cFiltroMoeda = ""
            IF !EMPTY(par_cCdMoeda)
                loc_cFiltroMoeda = " AND a.Moedas = " + EscaparSQL(par_cCdMoeda)
            ENDIF

            loc_cFiltroNF = ""
            IF par_nOpcoes = 1
                loc_cFiltroNF = " AND a.Nfs IS NOT NULL AND LTRIM(RTRIM(a.Nfs)) <> ''"
            ELSE
                IF par_nOpcoes = 2
                loc_cFiltroNF = " AND (a.Nfs IS NULL OR LTRIM(RTRIM(a.Nfs)) = '')"
                ENDIF
            ENDIF

            loc_cFiltroPrev = ""
            IF par_nNrPrev = 1
                loc_cFiltroPrev = " AND b.ValPres = 2"
            ELSE
                IF par_nNrPrev = 2
                loc_cFiltroPrev = " AND b.ValPres <> 2"
                ENDIF
            ENDIF

            *-- Filtro de situacao
            loc_cFiltroSitua = ""
            IF par_nNrSitua = 1
                loc_cFiltroSitua = " AND a.ValPags >= a.Valors"
            ELSE
                IF par_nNrSitua = 2
                loc_cFiltroSitua = " AND a.ValPags < a.Valors"
                ENDIF
            ENDIF

            *-- Campo de data conforme tipo selecionado
            loc_cCampData = IIF(par_nTpData = 1, "a.Vencs", "a.Datas")

            *-- Ordem de impressao
            IF par_nOrdImp = 1
                loc_cOrder = " ORDER BY a.Moedas, a.Vencs, a.Grupos, a.Contas, a.CIdChaves"
            ELSE
                loc_cOrder = " ORDER BY a.Moedas, a.Grupos, a.Contas, a.Vencs, a.CIdChaves"
            ENDIF

            loc_cSql = "SELECT a.Moedas, a.Vencs, a.Opers, a.Grupos, a.Contas, a.DopCs, " + ;
                       "a.Valors, a.Hists, a.ValPags, a.Emps, a.NOpers, a.CIdChaves, " + ;
                       "0 AS nPrevs, a.EmpDopNums, a.EmpDopNcs " + ;
                       "FROM SigMvCcr a " + ;
                       "INNER JOIN SigTempR b ON a.DopCs = b.Dopes " + ;
                       "WHERE " + loc_cCampData + " >= " + FormatarDataSQL(par_dDtInicial) + ;
                       " AND " + loc_cCampData + " <= " + FormatarDataSQL(par_dDtFinal) + ;
                       " AND a.TitCancs <> 1 " + ;
                       loc_cFiltroMoeda + loc_cFiltroNF + loc_cFiltroPrev + ;
                       loc_cFiltroSitua + loc_cOrder

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Periodo")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar fluxo do per" + CHR(237) + "odo"
            ELSE
                LOCAL loc_cEmpPer, loc_nImpEmpPer, loc_lEmpSelPer
                LOCAL loc_nValPer, loc_nPagPer, loc_nSaldoPer
                LOCAL loc_cFlPagosPer, loc_cHistPer, loc_cEDNPer
                LOCAL loc_cMoesPer, loc_cDsMoesPer, loc_cOpersPer
                LOCAL loc_nCtRefPer, loc_nVlConvPer

                SELECT cursor_4c_Periodo
                GO TOP
                SCAN
                    loc_cEmpPer = ALLTRIM(cursor_4c_Periodo.Emps)

                    *-- Verificar se empresa esta selecionada
                    loc_lEmpSelPer = .F.
                    IF USED(loc_cCursorEmp)
                        SELECT (loc_cCursorEmp)
                        GO TOP
                        SCAN
                            IF ALLTRIM(Cemps) == loc_cEmpPer
                                loc_nImpEmpPer = ImpEmps
                                IF loc_nImpEmpPer = 1
                                    loc_lEmpSelPer = .T.
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT cursor_4c_Periodo

                    IF !loc_lEmpSelPer
                        LOOP
                    ENDIF

                    loc_nValPer   = cursor_4c_Periodo.Valors
                    loc_nPagPer   = cursor_4c_Periodo.ValPags
                    loc_nSaldoPer = loc_nValPer - loc_nPagPer
                    loc_cFlPagosPer = IIF(loc_nPagPer >= loc_nValPer, "*", "")
                    loc_cHistPer    = ALLTRIM(cursor_4c_Periodo.Hists)
                    loc_cMoesPer    = ALLTRIM(cursor_4c_Periodo.Moedas)
                    loc_cOpersPer   = ALLTRIM(cursor_4c_Periodo.Opers)

                    IF par_nListaCodOp = 1
                        loc_cEDNPer = ALLTRIM(cursor_4c_Periodo.EmpDopNums)
                        IF VAL(RIGHT(loc_cEDNPer, 6)) > 0
                            loc_cHistPer = loc_cHistPer + loc_cEDNPer
                        ELSE
                            loc_cHistPer = loc_cHistPer + ALLTRIM(cursor_4c_Periodo.EmpDopNcs)
                        ENDIF
                    ENDIF

                    *-- Buscar descricao da moeda
                    loc_cDsMoesPer = ""
                    IF USED(loc_cCursorMoeda)
                        SELECT (loc_cCursorMoeda)
                        GO TOP
                        SCAN
                            IF ALLTRIM(CMoes) == loc_cMoesPer
                                loc_cDsMoesPer = ALLTRIM(DMoes)
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT cursor_4c_Periodo

                    *-- Calcular conversao
                    loc_nCtRefPer = THIS.BuscarCotacaoMoeda(loc_cMoesPer, DATE())
                    IF loc_nCtRefPer = 0
                        loc_nCtRefPer = 1
                    ENDIF
                    loc_nVlConvPer = (loc_nSaldoPer * loc_nCtRefPer / par_nVlCotacao)

                    SELECT (loc_cCursorRel)
                    INSERT INTO (loc_cCursorRel) ;
                        (Moedas, DsMoedas, Vencs, Grupos, Contas, DopCs, Valors, ;
                         Hists, FlPagos, Fase, Saldos, Vl_Convertido, FlPrevs, Opers) ;
                        VALUES (loc_cMoesPer, loc_cDsMoesPer, ;
                                cursor_4c_Periodo.Vencs, ;
                                ALLTRIM(cursor_4c_Periodo.Grupos), ;
                                ALLTRIM(cursor_4c_Periodo.Contas), ;
                                ALLTRIM(cursor_4c_Periodo.DopCs), ;
                                loc_nSaldoPer, loc_cHistPer, loc_cFlPagosPer, ;
                                2, 0, loc_nVlConvPer, "", loc_cOpersPer)

                    SELECT cursor_4c_Periodo
                ENDSCAN

                IF USED("cursor_4c_Periodo")
                    USE IN cursor_4c_Periodo
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.ProcessarFluxoPeriodo")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para a impressora (com prompt)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorRelatorio)
                    SELECT (THIS.this_cCursorRelatorio)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cFRX) ;
                        TO PRINTER PROMPT NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorRelatorio)
                    SELECT (THIS.this_cCursorRelatorio)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cFRX) PREVIEW NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LiberarCursores - Libera todos os cursores em memoria
    *--------------------------------------------------------------------------
    PROCEDURE LiberarCursores()
        LOCAL loc_aCursores(8), loc_nI

        loc_aCursores(1) = THIS.this_cCursorEmp
        loc_aCursores(2) = THIS.this_cCursorDisp
        loc_aCursores(3) = THIS.this_cCursorOper
        loc_aCursores(4) = THIS.this_cCursorMoeda
        loc_aCursores(5) = THIS.this_cCursorCotacao
        loc_aCursores(6) = THIS.this_cCursorRec
        loc_aCursores(7) = THIS.this_cCursorCabecalho
        loc_aCursores(8) = THIS.this_cCursorRelatorio

        FOR loc_nI = 1 TO 8
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarOperacoes - Marca todas as operacoes de titulos para impressao
    * Equivalente ao botao MarcarOpe.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE MarcarOperacoes()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorOper

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE SeleOp WITH .T.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.MarcarOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarOperacoes - Desmarca todas as operacoes de titulos
    * Equivalente ao botao DesmarcarOpe.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarOperacoes()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorOper

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE SeleOp WITH .F.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.DesmarcarOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecaoOperacao - Inverte selecao da operacao no registro atual
    * Equivalente ao CheckBox KeyPress/MouseDown do Grd_Oper.Column1
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecaoOperacao()
        LOCAL loc_cCursor, loc_lAtual
        loc_cCursor = THIS.this_cCursorOper

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EOF()
                    loc_lAtual = SeleOp
                    REPLACE SeleOp WITH !loc_lAtual
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.AlternarSelecaoOperacao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarEmpresas - Marca todas as empresas para impressao
    * Equivalente ao botao MarcarEmp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE MarcarEmpresas()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorEmp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE ImpEmps WITH .T.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.MarcarEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarEmpresas - Desmarca todas as empresas
    * Equivalente ao botao DesmarcarEmp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarEmpresas()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorEmp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE ImpEmps WITH .F.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.DesmarcarEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecaoEmpresa - Inverte selecao da empresa no registro atual
    * Equivalente ao CheckBox KeyPress/MouseDown do Grid1.Column1
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecaoEmpresa()
        LOCAL loc_cCursor, loc_lAtual
        loc_cCursor = THIS.this_cCursorEmp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EOF()
                    loc_lAtual = ImpEmps
                    REPLACE ImpEmps WITH !loc_lAtual
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.AlternarSelecaoEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarDisponibilidades - Marca todas as disponibilidades para impressao
    * Equivalente ao botao MarcarDisp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE MarcarDisponibilidades()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorDisp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE ImpDisps WITH .T.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.MarcarDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarDisponibilidades - Desmarca todas as disponibilidades
    * Equivalente ao botao DesmarcarDisp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarDisponibilidades()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorDisp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE ImpDisps WITH .F.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.DesmarcarDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecaoDisponibilidade - Inverte selecao da disponibilidade atual
    * Equivalente ao CheckBox KeyPress/MouseDown do Grid2.Column1
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecaoDisponibilidade()
        LOCAL loc_cCursor, loc_lAtual
        loc_cCursor = THIS.this_cCursorDisp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EOF()
                    loc_lAtual = ImpDisps
                    REPLACE ImpDisps WITH !loc_lAtual
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.AlternarSelecaoDisponibilidade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LiberarCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

