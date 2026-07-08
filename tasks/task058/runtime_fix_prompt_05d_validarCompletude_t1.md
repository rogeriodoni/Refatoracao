# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigrecnt.prg] Indicador de pendencia: * LimparBaseDescendentes - Limpa todos os niveis dependente
[Formsigrecnt.prg] Indicador de pendencia: * LimparNvl2Descendentes - Limpa niveis dependente
[Formsigrecnt.prg] Indicador de pendencia: * LimparNvl3Descendentes - Limpa niveis dependente

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecnt.prg):
*==============================================================================
* FORMSIGRECNT.PRG
* Rela" + CHR(231) + CHR(227) + "o de Contagem por Localiza" + CHR(231) + CHR(227) + "o
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECNT.SCX (frmrelatorio)
*
* Form: 800 x 350 (EXATO do original layout.json)
* Filtros: Data, Vendedor/Conta, Localiza" + CHR(231) + CHR(245) + "es (Base/N" + CHR(237) + "vel 2/3/4),
*          C" + CHR(243) + "digo, OptionGroups Local e Ordena" + CHR(231) + CHR(227) + "o
*
* FASE 7/8 - Form - Eventos Principais (REPORT: conclu" + CHR(237) + "do na Fase 6)
*   Forms REPORT nao tem BtnIncluirClick/BtnAlterarClick/BtnExcluirClick.
*   Todos os eventos de bot" + CHR(245) + "es ja foram implementados na Fase 6:
*   BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
*
* FASE 3/8 - Form - Estrutura Base
*   * Propriedades visuais do form (Width=800, Height=350)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()  (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
*   * ConfigurarBotoes()     (cmg_4c_Botoes: Visualizar/Imprimir/Excel/Encerrar)
*   * ConfigurarPageFrame()  (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
*
* FASE 5/8 - Form - BINDEVENTs dos campos de filtro (primeira metade)
*   * ConfigurarPaginaDados() com BINDEVENT para Conta, DConta, Base, Nvl2
*   * TeclaVendedor / ValidarVendedor / AbrirBuscaVendedor
*   * TeclaDescVendedor / ValidarDescVendedor
*   * TeclaBase / ValidarBase / AbrirBuscaBase / LimparBaseDescendentes
*   * TeclaNvl2 / ValidarNvl2 / AbrirBuscaNvl2 / LimparNvl2Descendentes
*
* FASE 6/8 - Form - Campos Restantes e Lookups (segunda metade)
*   * BINDEVENTs para Nvl3, Nvl4 e botoes do relatorio (cmg_4c_Botoes)
*   * TeclaNvl3 / ValidarNvl3 / AbrirBuscaNvl3 / LimparNvl3Descendentes
*   * TeclaNvl4 / ValidarNvl4 / AbrirBuscaNvl4 / LimparNvl4Descendentes
*   * ValidarDataParaRelatorio (guard clause pre-execucao)
*   * BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
*
* FASE 4/8 - Form - Conte" + CHR(250) + "do da Page1 + Alterna" + CHR(231) + CHR(227) + "o de p" + CHR(225) + "gina
*   * ConfigurarPaginaLista() - Adiciona 20 controles de filtro " + CHR(224) + " Page1:
*       - Labels e TextBoxes para Data, C" + CHR(243) + "digo, Vendedor (cod+desc),
*         Base, N" + CHR(237) + "vel 2/3/4 (cada um com cod+desc), totalizando 16 fields.
*       - 2 OptionGroups: OptLocal (4 op: Todos/Contados/N" + CHR(227) + "o Contados/Divergentes)
*         e OptOrdem (4 op: Local/N" + CHR(237) + "vel 2/N" + CHR(237) + "vel 3/N" + CHR(237) + "vel 4).
*       - Campos de descri" + CHR(231) + CHR(227) + "o ReadOnly=.T. com fundo cinza claro.
*   * AlternarPagina(par_nPagina) - Alterna ActivePage do PageFrame.
*   * LimparCampos() - Redefine filtros para valores padr" + CHR(227) + "o.
*   * FormParaRelatorio() - Transfere filtros do form para o BO.
*
*   NOTA: Este " + CHR(233) + " um form REPORT, ent" + CHR(227) + "o cnt_4c_Botoes (CRUD) N" + CHR(195) + "O existe.
*   Os bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar/Imprimir/Excel/Encerrar) j" + CHR(225) + " est" + CHR(227) + "o
*   no cmg_4c_Botoes criado na Fase 3 (padr" + CHR(227) + "o frmrelatorio framework.vcx).
*==============================================================================

DEFINE CLASS Formsigrecnt AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=350)
    Height      = 350
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
    *   2. Cria sigrecntBO e carrega par" + CHR(226) + "metros iniciais (pula em modo UI)
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
                           "Localiza" + CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("sigrecntBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecntBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar par" + CHR(226) + "metros iniciais (GrPadVens e cursores de n" + CHR(237) + "vel).
            *   Pulado em modo de valida" + CHR(231) + CHR(227) + "o de UI (sem conex" + CHR(227) + "o SQL).
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarParametros()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()

                *-- Controles de filtro na Page1 (m" + CHR(233) + "todo " + CHR(233) + " "ConfigurarPaginaLista"
                *-- por compatibilidade com o esqueleto, embora a Page1 deste
                *-- form REPORT contenha filtros e n" + CHR(227) + "o uma lista CRUD).
                THIS.ConfigurarPaginaLista()

                *-- BINDEVENT dos campos de filtro interativos (Fase 5/6)
                THIS.ConfigurarPaginaDados()

                *-- Redefine filtros para valores padr" + CHR(227) + "o
                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

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
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
                             "Localiza" + CHR(231) + CHR(227) + "o"
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
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
                             "Localiza" + CHR(231) + CHR(227) + "o"
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
    * ConfigurarBotoes - CommandGroup com bot" + CHR(245) + "es de relat" + CHR(243) + "rio (btnReport " + CHR(225) + "rea)
    *   Original: btnReport.Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *   Bot" + CHR(245) + "es: Visualizar(5), Imprimir(71), Excel(137), Encerrar(203) - W=65
    *   Eventos Click vinculados em InicializarForm (Fase 7).
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

            *-- Imprimir (impressora padr" + CHR(227) + "o)
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

            *-- Excel (exportar dados)
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

            *-- Encerrar (fechar form)
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
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina ("Filtros")
    *   O form legado SIGRECNT " + CHR(233) + " FLAT (sem PageFrame), mas no novo padr" + CHR(227) + "o
    *   os campos s" + CHR(227) + "o agrupados em um PageFrame de 1 p" + CHR(225) + "gina para consist" + CHR(234) + "ncia
    *   com o restante do sistema.
    *
    *   Posicionado logo abaixo do cabe" + CHR(231) + "alho (80px + 5px gap = Top=85)
    *   at" + CHR(233) + " o fim do form.
    *   Os campos de filtro s" + CHR(227) + "o adicionados " + CHR(224) + " Page1 nas fases seguintes (4-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho
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
    * ConfigurarPaginaLista - Adiciona todos os controles de filtro ao Page1
    *
    *   Form REPORT: a "Page1" deste relat" + CHR(243) + "rio cont" + CHR(233) + "m FILTROS, n" + CHR(227) + "o uma lista
    *   CRUD. O nome ConfigurarPaginaLista() " + CHR(233) + " mantido para compatibilidade
    *   com o esqueleto/valida" + CHR(231) + CHR(227) + "o multi-fase, mas o conte" + CHR(250) + "do " + CHR(233) + " formado
    *   pelos campos de filtro do legado SIGRECNT (Data, C" + CHR(243) + "digo, Vendedor,
    *   Base, N" + CHR(237) + "veis 2/3/4 e OptionGroups Local/Ordem).
    *
    *   Posi" + CHR(231) + CHR(245) + "es: layout.json original top - 85 (offset do PageFrame).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Data
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 21
            .Left      = 199
            .Width     = 32
            .Height    = 15
            .Caption   = "Data :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPag.txt_4c_Datas
            .Top      = 17
            .Left     = 235
            .Width    = 80
            .Height   = 24
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- C" + CHR(243) + "digo
        loc_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag.lbl_4c_Label3
            .Top       = 20
            .Left      = 366
            .Width     = 42
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPag.txt_4c_Codigo
            .Top      = 16
            .Left     = 411
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Vendedor
        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Top       = 49
            .Left      = 176
            .Width     = 55
            .Height    = 15
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPag.txt_4c_Conta
            .Top      = 44
            .Left     = 235
            .Width    = 80
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPag.txt_4c_DConta
            .Top       = 44
            .Left      = 317
            .Width     = 290
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Base (N" + CHR(237) + "vel 1)
        loc_oPag.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPag.lbl_4c_Label7
            .Top       = 77
            .Left      = 199
            .Width     = 32
            .Height    = 15
            .Caption   = "Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Base", "TextBox")
        WITH loc_oPag.txt_4c_Base
            .Top      = 72
            .Left     = 235
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DBase", "TextBox")
        WITH loc_oPag.txt_4c_DBase
            .Top       = 72
            .Left      = 291
            .Width     = 174
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Segundo N" + CHR(237) + "vel
        loc_oPag.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag.lbl_4c_Label6
            .Top       = 105
            .Left      = 154
            .Width     = 77
            .Height    = 15
            .Caption   = "Segundo N" + CHR(237) + "vel :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Nvl2", "TextBox")
        WITH loc_oPag.txt_4c_Nvl2
            .Top      = 100
            .Left     = 235
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DNvl2", "TextBox")
        WITH loc_oPag.txt_4c_DNvl2
            .Top       = 100
            .Left      = 291
            .Width     = 174
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Terceiro N" + CHR(237) + "vel
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .Top       = 133
            .Left      = 157
            .Width     = 74
            .Height    = 15
            .Caption   = "Terceiro N" + CHR(237) + "vel :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Nvl3", "TextBox")
        WITH loc_oPag.txt_4c_Nvl3
            .Top      = 128
            .Left     = 235
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DNvl3", "TextBox")
        WITH loc_oPag.txt_4c_DNvl3
            .Top       = 128
            .Left      = 291
            .Width     = 174
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Quarto N" + CHR(237) + "vel
        loc_oPag.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPag.lbl_4c_Label8
            .Top       = 161
            .Left      = 162
            .Width     = 69
            .Height    = 15
            .Caption   = "Quarto N" + CHR(237) + "vel :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Nvl4", "TextBox")
        WITH loc_oPag.txt_4c_Nvl4
            .Top      = 156
            .Left     = 235
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DNvl4", "TextBox")
        WITH loc_oPag.txt_4c_DNvl4
            .Top       = 156
            .Left      = 291
            .Width     = 174
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Label Localiza" + CHR(231) + CHR(245) + "es (ao lado do OptionGroup Local)
        loc_oPag.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPag.lbl_4c_Label4
            .Top       = 185
            .Left      = 163
            .Width     = 68
            .Height    = 15
            .Caption   = "Localiza" + CHR(231) + CHR(245) + "es :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup - Tipo de localiza" + CHR(231) + CHR(227) + "o
        loc_oPag.AddObject("obj_4c_OptLocal", "OptionGroup")
        WITH loc_oPag.obj_4c_OptLocal
            .Top         = 180
            .Left        = 231
            .Width       = 347
            .Height      = 26
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            .Value       = 1
            WITH .Buttons(1)
                .Caption  = "Todos"
                .Width    = 82
                .Height   = 18
                .Top      = 4
                .Left     = 2
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Contados"
                .Width    = 82
                .Height   = 18
                .Top      = 4
                .Left     = 87
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "N" + CHR(227) + "o Contados"
                .Width    = 90
                .Height   = 18
                .Top      = 4
                .Left     = 172
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption  = "Divergentes"
                .Width    = 82
                .Height   = 18
                .Top      = 4
                .Left     = 265
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Label Ordena" + CHR(231) + CHR(227) + "o (ao lado do OptionGroup Ordem)
        loc_oPag.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPag.lbl_4c_Label9
            .Top       = 209
            .Left      = 169
            .Width     = 62
            .Height    = 15
            .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup - Crit" + CHR(233) + "rio de ordena" + CHR(231) + CHR(227) + "o
        loc_oPag.AddObject("obj_4c_OptOrdem", "OptionGroup")
        WITH loc_oPag.obj_4c_OptOrdem
            .Top         = 204
            .Left        = 231
            .Width       = 432
            .Height      = 26
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            .Value       = 1
            WITH .Buttons(1)
                .Caption  = "Local"
                .Width    = 104
                .Height   = 18
                .Top      = 4
                .Left     = 2
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(237) + "vel 2"
                .Width    = 104
                .Height   = 18
                .Top      = 4
                .Left     = 109
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "N" + CHR(237) + "vel 3"
                .Width    = 104
                .Height   = 18
                .Top      = 4
                .Left     = 216
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption  = "N" + CHR(237) + "vel 4"
                .Width    = 104
                .Height   = 18
                .Top      = 4
                .Left     = 323
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna a p" + CHR(225) + "gina ativa do PageFrame
    *
    *   Form REPORT: este formul" + CHR(225) + "rio possui apenas 1 p" + CHR(225) + "gina (Filtros), ent" + CHR(227) + "o
    *   AlternarPagina sempre retorna para Page1. Mantido para compatibilidade
    *   com a interface padr" + CHR(227) + "o da fase 4 (esqueleto CRUD).
    *
    *   par_nPagina : n" + CHR(250) + "mero da p" + CHR(225) + "gina destino (1 = Filtros)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = par_nPagina

        *-- Sanitiza" + CHR(231) + CHR(227) + "o: somente Page1 existe neste form REPORT
        IF VARTYPE(loc_nPagina) != "N" OR loc_nPagina < 1 OR ;
           loc_nPagina > THIS.pgf_4c_Paginas.PageCount
            loc_nPagina = 1
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = loc_nPagina

        *-- Refresh dos controles ap" + CHR(243) + "s alternar p" + CHR(225) + "gina
        THIS.pgf_4c_Paginas.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Redefine todos os filtros para os valores padr" + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_Datas.Value    = DATE()
        loc_oPag.txt_4c_Codigo.Value   = ""
        loc_oPag.txt_4c_Conta.Value    = ""
        loc_oPag.txt_4c_DConta.Value   = ""
        loc_oPag.txt_4c_Base.Value     = ""
        loc_oPag.txt_4c_DBase.Value    = ""
        loc_oPag.txt_4c_Nvl2.Value     = ""
        loc_oPag.txt_4c_DNvl2.Value    = ""
        loc_oPag.txt_4c_Nvl3.Value     = ""
        loc_oPag.txt_4c_DNvl3.Value    = ""
        loc_oPag.txt_4c_Nvl4.Value     = ""
        loc_oPag.txt_4c_DNvl4.Value    = ""
        loc_oPag.obj_4c_OptLocal.Value = 1
        loc_oPag.obj_4c_OptOrdem.Value = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dData     = loc_oPag.txt_4c_Datas.Value
            .this_cCods     = ALLTRIM(loc_oPag.txt_4c_Codigo.Value)
            .this_cConta    = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
            .this_cDConta   = ALLTRIM(loc_oPag.txt_4c_DConta.Value)
            .this_cBase     = ALLTRIM(loc_oPag.txt_4c_Base.Value)
            .this_cNvl2     = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
            .this_cNvl3     = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
            .this_cNvl4     = ALLTRIM(loc_oPag.txt_4c_Nvl4.Value)
            .this_nOptLocal = loc_oPag.obj_4c_OptLocal.Value
            .this_nOptOrdem = loc_oPag.obj_4c_OptOrdem.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Vincula eventos (BINDEVENT) dos campos de filtro
    *   interativos da Page1 - primeira metade (Fase 5/8):
    *   Conta (Vendedor), DConta (descricao), Base (nivel 1) e Nvl2 (nivel 2).
    *   BINDEVENT exige metodos PUBLIC - handlers abaixo sem PROTECTED.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        BINDEVENT(loc_oPag.txt_4c_Conta,  "KeyPress", THIS, "TeclaVendedor")
        BINDEVENT(loc_oPag.txt_4c_DConta, "KeyPress", THIS, "TeclaDescVendedor")
        BINDEVENT(loc_oPag.txt_4c_Base,   "KeyPress", THIS, "TeclaBase")
        BINDEVENT(loc_oPag.txt_4c_Base,   "InteractiveChange", THIS, "LimparBaseDescendentes")
        BINDEVENT(loc_oPag.txt_4c_Nvl2,   "KeyPress", THIS, "TeclaNvl2")
        BINDEVENT(loc_oPag.txt_4c_Nvl2,   "InteractiveChange", THIS, "LimparNvl2Descendentes")
        BINDEVENT(loc_oPag.txt_4c_Nvl3,   "KeyPress", THIS, "TeclaNvl3")
        BINDEVENT(loc_oPag.txt_4c_Nvl3,   "InteractiveChange", THIS, "LimparNvl3Descendentes")
        BINDEVENT(loc_oPag.txt_4c_Nvl4,   "KeyPress", THIS, "TeclaNvl4")
        BINDEVENT(loc_oPag.txt_4c_Nvl4,   "InteractiveChange", THIS, "LimparNvl4Descendentes")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVendedor - Handler KeyPress de txt_4c_Conta (codigo do vendedor)
    *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de vendedor.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedor(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarVendedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedor - Verifica codigo digitado; abre busca se necessario
    *--------------------------------------------------------------------------
    PROCEDURE ValidarVendedor()
        LOCAL loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaVendedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVendedor - Lista vendedores com controle de acesso (SigCdAcJ)
    *   Equivalente ao getConta.Valid / getDConta.Valid do legado.
    *   SQL filtra SigCdCli pelo grupo padrao de vendedores e pelos jobs
    *   acessiveis ao usuario logado em SigCdAcJ.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaVendedor()
        LOCAL loc_cGrPadVens, loc_cSQL, loc_nResult, loc_oLookup, loc_oPag
        loc_oPag       = THIS.pgf_4c_Paginas.Page1
        loc_cGrPadVens = ""
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_cGrPadVens = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
        ENDIF

        loc_cSQL = "SELECT a.iclis AS Cods, a.rclis AS Descs " + ;
                   "FROM SigCdCli a " + ;
                   "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                   "AND (b.Coletors <> 10 " + ;
                   "OR (b.Coletors = 10 " + ;
                   "AND a.IClis NOT IN (" + ;
                   "SELECT DISTINCT c.Jobs FROM SigCdAcJ c " + ;
                   "WHERE c.Jobs NOT IN (" + ;
                   "SELECT DISTINCT d.Jobs FROM SigCdAcJ d " + ;
                   "WHERE d.Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "))))"
        IF !EMPTY(loc_cGrPadVens)
            loc_cSQL = loc_cSQL + " AND a.grupos = " + EscaparSQL(loc_cGrPadVens)
        ENDIF
        loc_cSQL = loc_cSQL + " ORDER BY a.rclis"

        IF USED("cursor_4c_BuscaVend")
            USE IN SELECT("cursor_4c_BuscaVend")
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVend")
        IF loc_nResult > 0
            IF RECCOUNT("cursor_4c_BuscaVend") > 0
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.DefinirCursor("cursor_4c_BuscaVend", "Cods", "Descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Vendedor")
                    IF loc_oLookup.Mostrar()
                        loc_oPag.txt_4c_Conta.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                        loc_oPag.txt_4c_DConta.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhum vendedor encontrado.", "Aviso")
            ENDIF
            IF USED("cursor_4c_BuscaVend")
                USE IN SELECT("cursor_4c_BuscaVend")
            ENDIF
        ELSE
            MsgErro("Erro ao buscar vendedores.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDescVendedor - Handler KeyPress de txt_4c_DConta (nome do vendedor)
    *   getDConta.When legado: campo habilitado apenas quando getConta eh vazio.
    *   ENTER(13) / TAB(9) / F4(115): abre busca de vendedor por nome.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDescVendedor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_Conta.Value))
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarDescVendedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescVendedor - Valida descricao e abre busca de vendedor
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescVendedor()
        LOCAL loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_DConta.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_Conta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaVendedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaBase - Handler KeyPress de txt_4c_Base (nivel 1 da localizacao)
    *   ENTER(13) / TAB(9) / F4(115): valida codigo ou abre busca de base.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaBase(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarBase()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBase - Valida codigo de base contra cursor_4c_SigLcNv1 do BO
    *   Equivalente ao getBase.Valid (fwbuscaext em SigLcNv1) do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarBase()
        LOCAL loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Base.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DBase.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_SigLcNv1")
            SELECT cursor_4c_SigLcNv1
            LOCATE FOR ALLTRIM(Cods) = loc_cValor
            IF FOUND()
                loc_oPag.txt_4c_DBase.Value = ALLTRIM(Descs)
            ELSE
                THIS.AbrirBuscaBase()
            ENDIF
        ELSE
            THIS.AbrirBuscaBase()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaBase - Lista opcoes de base (nivel 1 de localizacao)
    *   Usa cursor_4c_SigLcNv1 do BO; fallback para SQLEXEC se nao disponivel.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaBase()
        LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_BuscaBase")
            USE IN SELECT("cursor_4c_BuscaBase")
        ENDIF
        IF USED("cursor_4c_SigLcNv1")
            SELECT Cods, Descs FROM cursor_4c_SigLcNv1 ;
                ORDER BY Cods ;
                INTO CURSOR cursor_4c_BuscaBase READWRITE
        ELSE
            loc_cSQL    = "SELECT Cods, Descs FROM SigLcNv1 ORDER BY Cods"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaBase")
            IF loc_nResult < 1
                MsgErro("Erro ao buscar bases de localiza" + CHR(231) + ;
                    CHR(227) + "o.", "Erro")
                RETURN
            ENDIF
        ENDIF
        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.DefinirCursor("cursor_4c_BuscaBase", "Cods", "Descs", ;
                "Localiza" + CHR(231) + CHR(227) + "o Base")
            IF loc_oLookup.Mostrar()
                loc_oPag.txt_4c_Base.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                loc_oPag.txt_4c_DBase.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                THIS.LimparBaseDescendentes()
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaBase")
            USE IN SELECT("cursor_4c_BuscaBase")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparBaseDescendentes - Limpa todos os niveis dependentes de Base
    *   Equivalente ao getBase.InteractiveChange do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparBaseDescendentes()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DBase.Value  = ""
        loc_oPag.txt_4c_Nvl2.Value   = ""
        loc_oPag.txt_4c_DNvl2.Value  = ""
        loc_oPag.txt_4c_Nvl3.Value   = ""
        loc_oPag.txt_4c_DNvl3.Value  = ""
        loc_oPag.txt_4c_Nvl4.Value   = ""
        loc_oPag.txt_4c_DNvl4.Value  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNvl2 - Handler KeyPress de txt_4c_Nvl2 (segundo nivel localizacao)
    *   getNvl2.When legado: bloqueia entrada se Base estiver vazio.
    *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de nivel 2.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNvl2(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Base.Value))
            MsgAviso("N" + CHR(237) + "vel anterior n" + CHR(227) + "o informado.", "Aviso")
            loc_oPag.txt_4c_Nvl2.Value = ""
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarNvl2()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNvl2 - Valida codigo de nivel 2 contra cursor_4c_SigLcNv2 do BO
    *   Filtra por Cods = Base atual; equivalente ao getNvl2.Valid do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNvl2()
        LOCAL loc_cNivel, loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Base.Value)
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DNvl2.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_SigLcNv2")
            SELECT cursor_4c_SigLcNv2
            LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
            IF FOUND()
                loc_oPag.txt_4c_DNvl2.Value = ALLTRIM(Descs)
            ELSE
                THIS.AbrirBuscaNvl2()
            ENDIF
        ELSE
            THIS.AbrirBuscaNvl2()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaNvl2 - Lista opcoes de nivel 2 filtradas pela Base atual
    *   Equivalente ao fwBuscaSel em CrSigLcNv2 do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNvl2()
        LOCAL loc_cNivel, loc_oLookup, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Base.Value)
        IF USED("cursor_4c_BuscaNvl2")
            USE IN SELECT("cursor_4c_BuscaNvl2")
        ENDIF
        IF USED("cursor_4c_SigLcNv2")
            SELECT Codigo, Descs FROM cursor_4c_SigLcNv2 ;
                WHERE ALLTRIM(Cods) = loc_cNivel ;
                ORDER BY Codigo ;
                INTO CURSOR cursor_4c_BuscaNvl2 READWRITE
        ELSE
            MsgErro("Cursor de n" + CHR(237) + "vel 2 n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel.", "Erro")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_BuscaNvl2") > 0
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl2", "Codigo", "Descs", ;
                    "Segundo N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
                IF loc_oLookup.Mostrar()
                    loc_oPag.txt_4c_Nvl2.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    loc_oPag.txt_4c_DNvl2.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                    THIS.LimparNvl2Descendentes()
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum segundo n" + CHR(237) + "vel encontrado " + ;
                "para a base informada.", "Aviso")
        ENDIF
        IF USED("cursor_4c_BuscaNvl2")
            USE IN SELECT("cursor_4c_BuscaNvl2")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparNvl2Descendentes - Limpa niveis dependentes de Nvl2
    *   Equivalente ao getNvl2.InteractiveChange do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparNvl2Descendentes()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DNvl2.Value = ""
        loc_oPag.txt_4c_Nvl3.Value  = ""
        loc_oPag.txt_4c_DNvl3.Value = ""
        loc_oPag.txt_4c_Nvl4.Value  = ""
        loc_oPag.txt_4c_DNvl4.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNvl3 - Handler KeyPress de txt_4c_Nvl3 (terceiro nivel localizacao)
    *   getNvl3.When legado: bloqueia entrada se Nvl2 estiver vazio.
    *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de nivel 3.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNvl3(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Nvl2.Value))
            MsgAviso("N" + CHR(237) + "vel anterior n" + CHR(227) + "o informado.", "Aviso")
            loc_oPag.txt_4c_Nvl3.Value = ""
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarNvl3()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNvl3 - Valida codigo de nivel 3 contra cursor_4c_SigLcNv3 do BO
    *   Filtra por Cods = Nvl2 atual; equivalente ao getNvl3.Valid do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNvl3()
        LOCAL loc_cNivel, loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DNvl3.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_SigLcNv3")
            SELECT cursor_4c_SigLcNv3
            LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
            IF FOUND()
                loc_oPag.txt_4c_DNvl3.Value = ALLTRIM(Descs)
            ELSE
                THIS.AbrirBuscaNvl3()
            ENDIF
        ELSE
            THIS.AbrirBuscaNvl3()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaNvl3 - Lista opcoes de nivel 3 filtradas pelo Nvl2 atual
    *   Equivalente ao fwBuscaSel em CrSigLcNv3 do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNvl3()
        LOCAL loc_cNivel, loc_oLookup, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
        IF USED("cursor_4c_BuscaNvl3")
            USE IN SELECT("cursor_4c_BuscaNvl3")
        ENDIF
        IF USED("cursor_4c_SigLcNv3")
            SELECT Codigo, Descs FROM cursor_4c_SigLcNv3 ;
                WHERE ALLTRIM(Cods) = loc_cNivel ;
                ORDER BY Codigo ;
                INTO CURSOR cursor_4c_BuscaNvl3 READWRITE
        ELSE
            MsgErro("Cursor de n" + CHR(237) + "vel 3 n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel.", "Erro")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_BuscaNvl3") > 0
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl3", "Codigo", "Descs", ;
                    "Terceiro N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
                IF loc_oLookup.Mostrar()
                    loc_oPag.txt_4c_Nvl3.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    loc_oPag.txt_4c_DNvl3.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                    THIS.LimparNvl3Descendentes()
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum terceiro n" + CHR(237) + "vel encontrado " + ;
                "para o segundo n" + CHR(237) + "vel informado.", "Aviso")
        ENDIF
        IF USED("cursor_4c_BuscaNvl3")
            USE IN SELECT("cursor_4c_BuscaNvl3")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparNvl3Descendentes - Limpa niveis dependentes de Nvl3
    *   Equivalente ao getNvl3.InteractiveChange do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparNvl3Descendentes()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DNvl3.Value = ""
        loc_oPag.txt_4c_Nvl4.Value  = ""
        loc_oPag.txt_4c_DNvl4.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNvl4 - Handler KeyPress de txt_4c_Nvl4 (quarto nivel localizacao)
    *   getNvl4.When legado: bloqueia entrada se Nvl3 estiver vazio.
    *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de nivel 4.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNvl4(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Nvl3.Value))
            MsgAviso("N" + CHR(237) + "vel anterior n" + CHR(227) + "o informado.", "Aviso")
            loc_oPag.txt_4c_Nvl4.Value = ""
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarNvl4()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNvl4 - Valida codigo de nivel 4 contra cursor_4c_SigLcNv4 do BO
    *   Filtra por Cods = Nvl3 atual; equivalente ao getNvl4.Valid do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNvl4()
        LOCAL loc_cNivel, loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Nvl4.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DNvl4.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_SigLcNv4")
            SELECT cursor_4c_SigLcNv4
            LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
            IF FOUND()
                loc_oPag.txt_4c_DNvl4.Value = ALLTRIM(Descs)
            ELSE
                THIS.AbrirBuscaNvl4()
            ENDIF
        ELSE
            THIS.AbrirBuscaNvl4()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaNvl4 - Lista opcoes de nivel 4 filtradas pelo Nvl3 atual
    *   Equivalente ao fwBuscaSel em CrSigLcNv4 do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNvl4()
        LOCAL loc_cNivel, loc_oLookup, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
        IF USED("cursor_4c_BuscaNvl4")
            USE IN SELECT("cursor_4c_BuscaNvl4")
        ENDIF
        IF USED("cursor_4c_SigLcNv4")
            SELECT Codigo, Descs FROM cursor_4c_SigLcNv4 ;
                WHERE ALLTRIM(Cods) = loc_cNivel ;
                ORDER BY Codigo ;
                INTO CURSOR cursor_4c_BuscaNvl4 READWRITE
        ELSE
            MsgErro("Cursor de n" + CHR(237) + "vel 4 n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel.", "Erro")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_BuscaNvl4") > 0
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl4", "Codigo", "Descs", ;
                    "Quarto N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
                IF loc_oLookup.Mostrar()
                    loc_oPag.txt_4c_Nvl4.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    loc_oPag.txt_4c_DNvl4.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum quarto n" + CHR(237) + "vel encontrado " + ;
                "para o terceiro n" + CHR(237) + "vel informado.", "Aviso")
        ENDIF
        IF USED("cursor_4c_BuscaNvl4")
            USE IN SELECT("cursor_4c_BuscaNvl4")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparNvl4Descendentes - Limpa descricao de nivel 4
    *   Equivalente ao getNvl4.InteractiveChange do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparNvl4Descendentes()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DNvl4.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataParaRelatorio - Valida se data foi informada (obrigatoria)
    *   Equivalente ao guard clause do btnReport.Click legado:
    *     If Empty(ThisForm.getDatas.Value) -> Messagebox + Return 0
    *   Retorna .T. se data valida, .F. se invalida (exibe aviso).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDataParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag.txt_4c_Datas.Value)
            MsgAviso("Data inv" + CHR(225) + "lida!", "Aviso")
            loc_oPag.txt_4c_Datas.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em tela (preview)
    *   Botao 1 do cmg_4c_Botoes. Requer data valida.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    *   Botao 2 do cmg_4c_Botoes. Requer data valida.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para Excel
    *   Botao 3 do cmg_4c_Botoes. Requer data valida.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.GerarExcel()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio
    *   Botao 4 (Cancel=.T.) do cmg_4c_Botoes. Sem validacao de data.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os controles de filtro
    *   par_lHabilitar: .T. = habilita edicao, .F. = somente leitura
    *   Forms REPORT chamam com .T. no InicializarForm (estado normal).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oPag
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_Datas.ReadOnly    = !loc_lHab
        loc_oPag.txt_4c_Codigo.ReadOnly   = !loc_lHab
        loc_oPag.txt_4c_Conta.ReadOnly    = !loc_lHab
        loc_oPag.txt_4c_Base.ReadOnly     = !loc_lHab
        loc_oPag.txt_4c_Nvl2.ReadOnly     = !loc_lHab
        loc_oPag.txt_4c_Nvl3.ReadOnly     = !loc_lHab
        loc_oPag.txt_4c_Nvl4.ReadOnly     = !loc_lHab
        loc_oPag.obj_4c_OptLocal.Enabled  = loc_lHab
        loc_oPag.obj_4c_OptOrdem.Enabled  = loc_lHab
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lHab
        THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lHab
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecntBO.prg):
*==============================================================================
* SIGRECNTBO.PRG
* Business Object para Relatorio de Contagem por Localizacao
*
* Herda de: RelatorioBase
* Form: Formsigrecnt.prg
* Relatorio original: sigrecnt.SCX / SigReCnt.FRX
*==============================================================================

DEFINE CLASS sigrecntBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCnt"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cBase              = ""
    this_cNvl2              = ""
    this_cNvl3              = ""
    this_cNvl4              = ""
    this_cCods              = ""
    this_nOptLocal          = 0
    this_nOptOrdem          = 0

    *-- Estado / controle
    this_lVisualizaCtg      = .F.
    this_cGrPadVens         = ""

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                     "Contagem por Localiza" + CHR(231) + CHR(227) + "o"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega GrPadVens e cursores de nivel para o form
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cSQL = "SELECT TOP 1 GrPadVens FROM SigCdPam " + ;
                           "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_LocalPam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrPadVens = ALLTRIM(NVL(cursor_4c_LocalPam.GrPadVens, ""))
                    ENDIF
                ENDIF

                IF EMPTY(THIS.this_cGrPadVens)
                    THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores " + ;
                        "N" + CHR(227) + "o Est" + CHR(225) + " Configurado nos " + ;
                        "Par" + CHR(226) + "metros do Sistema."
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv1", "cursor_4c_SigLcNv1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 1"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv2", "cursor_4c_SigLcNv2")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 2"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv3", "cursor_4c_SigLcNv3")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 3"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv4", "cursor_4c_SigLcNv4")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 4"
                    EXIT
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida parametros obrigatorios antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dData)
            THIS.this_cMensagemErro = "Data " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio de contagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_lcLocalizacao, loc_lcBase, loc_lcNvl2, loc_lcNvl3, loc_lcNvl4
        LOCAL loc_lcVends, loc_lnLocal, loc_lnOrdem, loc_lcCods
        LOCAL loc_cDtI, loc_cDtF
        LOCAL loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2
        LOCAL loc_lcNvl3Tmp
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF !THIS.ValidarFiltros()
                    EXIT
                ENDIF

                loc_lcBase        = ALLTRIM(THIS.this_cBase)
                loc_lcNvl2        = ALLTRIM(THIS.this_cNvl2)
                loc_lcNvl3        = ALLTRIM(THIS.this_cNvl3)
                loc_lcNvl4        = ALLTRIM(THIS.this_cNvl4)
                loc_lcLocalizacao = loc_lcBase + loc_lcNvl2 + loc_lcNvl3 + loc_lcNvl4
                loc_lcVends       = ALLTRIM(THIS.this_cConta)
                loc_lnLocal       = THIS.this_nOptLocal
                loc_lnOrdem       = THIS.this_nOptOrdem
                loc_lcCods        = ALLTRIM(THIS.this_cCods)

                loc_cDtI = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 00:00:00', 120)"
                loc_cDtF = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 23:59:59', 120)"

                IF USED("csRel")
                    USE IN csRel
                ENDIF
                IF USED("crRel")
                    USE IN crRel
                ENDIF
                IF USED("crTmpLocal")
                    USE IN crTmpLocal
                ENDIF
                IF USED("crSigCdCnl")
                    USE IN crSigCdCnl
                ENDIF
                IF USED("csTotLocal")
                    USE IN csTotLocal
                ENDIF
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF

                CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE Cemps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa), "cursor_4c_EmpCnt")
                IF loc_nResult > 0
                    SELECT cursor_4c_EmpCnt
                    GO TOP
                    loc_lcEmpresa = go_4c_Sistema.cCodEmpresa + " - " + ;
                                    ALLTRIM(NVL(cursor_4c_EmpCnt.Razas, ""))
                ELSE
                    loc_lcEmpresa = go_4c_Sistema.cCodEmpresa
                ENDIF

                loc_lcTitulo  = "Rela" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
                loc_lcTitulo2 = IIF(!EMPTY(THIS.this_cConta), ;
                    "Vendedor - " + THIS.this_cConta + " " + THIS.this_cDConta, "")
                INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                    VALUES (loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2)

                *-- Contagens realizadas (sigcdcnl + sigcdcni)
                loc_cSQL = "SELECT a.cods, a.datas, a.vends, a.emps, b.locals, b.qtds, b.estoque " + ;
                           "FROM sigcdcnl a " + ;
                           "JOIN sigcdcni b ON a.cods = b.cods " + ;
                           "WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF

                IF !EMPTY(loc_lcCods)
                    loc_cSQL = loc_cSQL + " AND A.Cods = " + EscaparSQL(loc_lcCods)
                ENDIF
                IF !EMPTY(loc_lcVends)
                    loc_cSQL = loc_cSQL + " AND A.Vends = " + EscaparSQL(loc_lcVends)
                ENDIF
                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND b.locals LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnl")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar contagens."
                    EXIT
                ENDIF

                SELECT crSigCdCnl
                INDEX ON Locals TAG Locals
                GO TOP

                IF RECCOUNT("crSigCdCnl") = 0
                    THIS.this_cMensagemErro = "Nenhuma contagem encontrada para os filtros informados."
                    EXIT
                ENDIF

                *-- Estoque por localizacao (SigOpEtq UNION ALL SigMvesl)
                loc_cSQL = "SELECT localizas, grupos, contas, empos, Sum(Qtde) AS qtde, " + ;
                           "CONVERT(NUMERIC(5,0), 0) AS QtdCtg " + ;
                           "FROM (" + ;
                           " SELECT localizas, a.grupos, a.contas, a.empos, COUNT(1) AS qtde " + ;
                           " FROM SigOpEtq A " + ;
                           " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;
                           "  ON b.cpros = a.cpros " + ;
                           " WHERE a.empos = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.contas NOT IN ('15000100','15000141') " + ;
                           " GROUP BY A.localizas, a.grupos, a.contas, a.empos " + ;
                           " UNION ALL " + ;
                           " SELECT a.locals, a.grupos, a.estos, a.emps, SUM(sqtds) AS Total " + ;
                           " FROM SigMvesl a, SigCdpro b " + ;
                           " WHERE a.CPros = b.Cpros " + ;
                           " AND a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.estos NOT IN ('15000100','15000141') " + ;
                           " AND a.cpros + a.locals NOT IN " + ;
                           "  (SELECT cpros + localizas FROM sigopetq) " + ;
                           " GROUP BY a.locals, a.grupos, a.estos, a.emps" + ;
                           ") a WHERE Grupos <> SPACE(10)"

                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND a.localizas LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_cSQL = loc_cSQL + ;
                           " GROUP BY localizas, grupos, contas, empos" + ;
                           " HAVING SUM(qtde) <> 0"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLocal")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar estoque por localiza" + ;
                                              CHR(231) + CHR(227) + "o."
                    EXIT
                ENDIF

                *-- Filtra crTmpLocal: manter apenas localizacoes com contagem
                SELECT crTmpLocal
                GO TOP
                SCAN
                    IF !SEEK(crTmpLocal.localizas, "crSigCdCnl", "Locals")
                        DELETE
                        LOOP
                    ENDIF
                    SELECT crTmpLocal
                ENDSCAN

                SELECT Localizas, SUM(Qtde) AS Qtds ;
                    FROM crTmpLocal WHERE 0=0 ;
                    GROUP BY Localizas ;
                    INTO CURSOR csTotLocal READWRITE

                IF RECCOUNT("csTotLocal") = 0
                    THIS.this_cMensagemErro = "Nenhum estoque encontrado para as " + ;
                        "localiza" + CHR(231) + CHR(245) + "es contadas."
                    EXIT
                ENDIF

                SELECT csTotLocal
                INDEX ON Localizas TAG Locals
                GO TOP

                *-- Gera cursor de resultado conforme OptLocal
                DO CASE
                CASE loc_lnLocal = 1
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        FULL OUTER JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 2
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crSigCdCnl a ;
                        LEFT JOIN crTmpLocal b ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 3
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) = 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 4
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> ;
                            IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) ;
                        INTO CURSOR csRel READWRITE
                ENDCASE

                *-- Agrega resultado final com campos de nivel decompostos
                SELECT Datas, Locals, Vends, Empos, Localizas, ;
                    SUM(Qtds) AS Qtds, SUM(Qtde) AS Qtde, ;
                    SPACE(100) AS Descr, ;
                    LEFT(Locals, 2) AS Nivel1s, ;
                    SUBSTR(Locals, 3, 2) AS Nivel2s, ;
                    SUBSTR(Locals, 5, 2) AS Nivel3s, ;
                    SUBSTR(Locals, 7, 3) AS Nivel4s ;
                    FROM csRel ;
                    GROUP BY Datas, Locals, Vends, Empos, Localizas ;
                    INTO CURSOR crRel READWRITE

                *-- Enriquece descricao com nivel 3
                IF !USED("cursor_4c_SigLcNv3")
                    SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigLcNv3", "cursor_4c_SigLcNv3")
                ENDIF

                SELECT crRel
                INDEX ON Vends + Locals TAG Locals
                GO TOP
                SCAN
                    loc_lcNvl3Tmp = SUBSTR(crRel.Locals, 5, 2)
                    IF !EMPTY(loc_lcNvl3Tmp)
                        SELECT cursor_4c_SigLcNv3
                        LOCATE FOR ALLTRIM(Cods) = ALLTRIM(loc_lcNvl3Tmp)
                        IF FOUND()
                            REPLACE Descr WITH ALLTRIM(cursor_4c_SigLcNv3.Descs) IN crRel
                        ENDIF
                    ENDIF
                    SELECT crRel
                ENDSCAN

                *-- Aplica ordenacao final
                SELECT crRel
                DO CASE
                CASE loc_lnOrdem = 1
                    INDEX ON Locals TAG Locals
                CASE loc_lnOrdem = 2
                    INDEX ON Nivel2s TAG Nivel2s
                CASE loc_lnOrdem = 3
                    INDEX ON Nivel3s TAG Nivel3s
                CASE loc_lnOrdem = 4
                    INDEX ON Nivel4s TAG Nivel4s
                ENDCASE
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e exporta para planilha Excel
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = PUTFILE("Exportar para Excel", ;
                    "contagem_localizacao", "xls")
                IF !EMPTY(loc_cArquivo)
                    SELECT crRel
                    COPY TO (loc_cArquivo) TYPE XLS
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem, o unico
    * parametro persistido eh GrPadVens, usado nos lookups de vendedor.
    * Retorna .T. se carregou, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                IF TYPE("&par_cAliasCursor..GrPadVens") = "C"
                    THIS.this_cGrPadVens = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrPadVens"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Contagem por Localizacao eh apenas leitura: consulta SigCdCnl/SigCdCnI/
    * SigOpEtq/SigMvesl e gera preview via REPORT FORM. Retorna .F. para
    * satisfazer contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto pela
    * data, empresa e filtro de localizacao) para fins de auditoria/log.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCNT|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cBase) + ;
                     ALLTRIM(THIS.this_cNvl2) + ;
                     ALLTRIM(THIS.this_cNvl3) + ;
                     ALLTRIM(THIS.this_cNvl4)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de execucao do relatorio na
    * tabela LogAuditoria (Empresa, Usuario, DataHora, Operacao, Detalhes).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave
        loc_lSucesso = .F.
        IF EMPTY(par_cOperacao)
            par_cOperacao = "VISUALIZAR"
        ENDIF
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Empresa, Usuario, DataHora, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("Relatorio_Contagem") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cTituloRelatorio) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

